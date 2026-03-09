function imgToBase64(file, callback) {
    const reader = new FileReader();
    reader.onload = function(e) {
        callback(e.target.result);
    };
    reader.readAsDataURL(file);
}

const defaultData = {
    home: { avatar: '🌸', avatarImg: '', title: '欢迎来到 shirly 的可爱小窝！', desc: '这里记录着我的生活、想法、作品和成长 ✨' },
    plans: [ { id:1, text:'看完12本书', done:true, category:'学习成长', month:'全年', note:'' }, { id:2, text:'学会做个人网站（进行中！）', done:false, category:'学习成长', month:'3月', note:'正在跟橘子一起做！' } ],
    works: [ { id:1, icon:'🌸', title:'可爱个人网站', desc:'你正在看的这个！', tags:['HTML','CSS','可爱风'], category:'代码项目', img:'' } ],
    articles: [ { id:1, date:'2026-03-06', tag:'随想', title:'关于做个人网站这件小事', summary:'今天终于开始做自己的个人网站啦！', category:'日常', readTime:'2分钟', img:'' } ],
    diary: [ { id:1, date:'2026-03-06 星期五', mood:'🥳', content:'今天太开心啦！我的个人网站终于开工了！', img:'' } ],
    timeline: [ { id:1, date:'2026-03-06', emoji:'🎉', title:'个人网站上线啦！', content:'终于有了属于自己的可爱小窝！', img:'' } ],
    checkins: { water:12, read:8, sport:3, sleep:'努力中...', calendar:{} },
    about: { name:'shirly', emoji:'🍊', bio:'一个可可爱爱、认认真真生活的普通人。', likes:['可爱的东西','晒太阳','看电影'], motto:'慢慢来，比较快 ✨', contact:{ wechat:'', email:'', github:'' }, skills:[ { name:'办公软件', level:80 }, { name:'拍照', level:60 }, { name:'做手工', level:40 } ], avatarImg:'' },
    movies: [ { id:1, title:'龙猫', type:'电影', rating:5, comment:'永远的治愈神作！', date:'2026-02-14', img:'' } ],
    books: [ { id:1, title:'被讨厌的勇气', author:'岸见一郎', rating:5, comment:'改变了我很多想法', date:'2026-02-28', img:'' } ],
    collections: [ { id:1, name:'一个很好用的笔记APP', url:'', type:'APP', note:'' } ],
    guestbook: [ { id:1, name:'橘子', message:'来踩踩！网站超可爱！', date:'2026-03-06' } ],
    settings: { theme:'light' }
};

// GitHub 配置
function getGitHubConfig() {
    const token = localStorage.getItem('githubToken');
    return {
        owner: 'shirly0222',
        repo: 'shirly-website',
        branch: 'main',
        filePath: 'data.json',
        token: token || ''
    };
}

function getData() { const s=localStorage.getItem('shirlyWebsiteData'); return s?JSON.parse(s):JSON.parse(JSON.stringify(defaultData)); }
function saveData(d) { localStorage.setItem('shirlyWebsiteData', JSON.stringify(d)); }
function exportData() { const d=getData(); const b=new Blob([JSON.stringify(d,null,2)],{type:'application/json'}); const a=document.createElement('a'); a.href=URL.createObjectURL(b); a.download='shirly-website-backup-'+new Date().toISOString().split('T')[0]+'.json'; a.click(); }
function importData(fi) { const f=fi.files[0]; if(!f)return; const r=new FileReader(); r.onload=function(e){ try{ const d=JSON.parse(e.target.result); saveData(d); alert('✅ 导入成功！刷新页面生效'); location.reload(); }catch(err){ alert('❌ 导入失败'); } }; r.readAsText(f); }
function resetData() { if(confirm('⚠️ 确定重置？')){ localStorage.removeItem('shirlyWebsiteData'); location.reload(); } }

// GitHub Token 管理
function setGitHubToken(token) {
    localStorage.setItem('githubToken', token);
    alert('✅ Token 已保存！');
}

function clearGitHubToken() {
    localStorage.removeItem('githubToken');
    alert('✅ Token 已清除！');
}

// GitHub 数据同步功能
async function syncToGitHub() {
    const config = getGitHubConfig();
    if (!config.token) {
        alert('❌ 请先设置 GitHub Token！');
        return;
    }
    
    const data = getData();
    const content = btoa(unescape(encodeURIComponent(JSON.stringify(data, null, 2))));
    
    try {
        // 先获取文件信息（看是否已存在）
        let fileSha = null;
        try {
            const getResponse = await fetch(
                `https://api.github.com/repos/${config.owner}/${config.repo}/contents/${config.filePath}`,
                { headers: { 'Authorization': `token ${config.token}` } }
            );
            if (getResponse.ok) {
                const fileData = await getResponse.json();
                fileSha = fileData.sha;
            }
        } catch(e) {
            // 文件不存在，继续
        }
        
        // 上传文件
        const response = await fetch(
            `https://api.github.com/repos/${config.owner}/${config.repo}/contents/${config.filePath}`,
            {
                method: 'PUT',
                headers: {
                    'Authorization': `token ${config.token}`,
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    message: '更新网站数据',
                    content: content,
                    sha: fileSha,
                    branch: config.branch
                })
            }
        );
        
        if (response.ok) {
            alert('✅ 数据已同步到 GitHub！');
        } else {
            const error = await response.json();
            alert('❌ 同步失败：' + (error.message || '未知错误'));
        }
    } catch (error) {
        alert('❌ 同步出错：' + error.message);
    }
}

async function loadFromGitHub() {
    const config = getGitHubConfig();
    if (!config.token) {
        alert('❌ 请先设置 GitHub Token！');
        return;
    }
    
    try {
        const response = await fetch(
            `https://api.github.com/repos/${config.owner}/${config.repo}/contents/${config.filePath}`,
            { headers: { 'Authorization': `token ${config.token}` } }
        );
        
        if (response.ok) {
            const fileData = await response.json();
            const content = decodeURIComponent(escape(atob(fileData.content)));
            const data = JSON.parse(content);
            saveData(data);
            alert('✅ 已从 GitHub 加载数据！刷新页面生效');
            location.reload();
        } else {
            alert('❌ 加载失败：文件不存在或无权限');
        }
    } catch (error) {
        alert('❌ 加载出错：' + error.message);
    }
}