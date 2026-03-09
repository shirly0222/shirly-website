# shirly 可爱个人网站 - 一键生成脚本
# 目标目录：D:\shirly-website

$targetDir = "D:\shirly-website"

# 确保目录存在
if (!(Test-Path $targetDir)) {
    New-Item -ItemType Directory -Path $targetDir | Out-Null
}

Write-Host "🍊 正在生成 shirly 的可爱小窝..." -ForegroundColor Pink

# ------------------------------
# 1. style.css
# ------------------------------
$styleCss = @'
/* 全局样式 - 可爱风 */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Segoe UI', 'Microsoft YaHei', sans-serif;
    background: linear-gradient(135deg, #ffeef8 0%, #e3f2fd 100%);
    color: #5a3d5c;
    line-height: 1.6;
}

/* 导航栏 */
.navbar {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(10px);
    padding: 1rem 2rem;
    display: flex;
    justify-content: space-between;
    align-items: center;
    position: sticky;
    top: 0;
    z-index: 100;
    box-shadow: 0 4px 20px rgba(255, 182, 193, 0.3);
}

.nav-brand {
    font-size: 1.3rem;
    font-weight: bold;
    color: #ff6b9d;
}

.nav-links {
    display: flex;
    gap: 1.5rem;
    flex-wrap: wrap;
}

.nav-links a {
    text-decoration: none;
    color: #7a5a7f;
    font-weight: 500;
    padding: 0.5rem 1rem;
    border-radius: 20px;
    transition: all 0.3s ease;
}

.nav-links a:hover,
.nav-links a.active {
    background: #ffe0f0;
    color: #ff6b9d;
}

/* 容器 */
.container {
    max-width: 1000px;
    margin: 0 auto;
    padding: 2rem;
}

/* 欢迎区域 */
.hero {
    text-align: center;
    padding: 4rem 2rem;
    background: rgba(255, 255, 255, 0.7);
    border-radius: 30px;
    margin-bottom: 3rem;
    box-shadow: 0 10px 40px rgba(255, 182, 193, 0.25);
}

.hero-avatar {
    font-size: 5rem;
    margin-bottom: 1rem;
    animation: bounce 2s infinite;
}

@keyframes bounce {
    0%, 100% { transform: translateY(0); }
    50% { transform: translateY(-15px); }
}

.hero h1 {
    color: #ff6b9d;
    font-size: 2.2rem;
    margin-bottom: 0.8rem;
}

/* 快速入口卡片 */
.quick-links h2 {
    text-align: center;
    color: #7a5a7f;
    margin-bottom: 2rem;
    font-size: 1.8rem;
}

.links-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 1.5rem;
}

.link-card {
    background: white;
    padding: 2rem;
    border-radius: 25px;
    text-align: center;
    text-decoration: none;
    color: inherit;
    box-shadow: 0 8px 25px rgba(255, 182, 193, 0.2);
    transition: all 0.3s ease;
}

.link-card:hover {
    transform: translateY(-8px);
    box-shadow: 0 15px 35px rgba(255, 182, 193, 0.35);
}

.card-icon {
    font-size: 3rem;
    display: block;
    margin-bottom: 1rem;
}

.link-card h3 {
    color: #ff6b9d;
    margin-bottom: 0.5rem;
}

/* 页脚 */
.footer {
    text-align: center;
    padding: 2rem;
    color: #9a7a9f;
    margin-top: 3rem;
}

/* 编辑功能样式 */
.edit-btn {
    background: linear-gradient(135deg, #ff6b9d, #ffb6c1);
    color: white;
    border: none;
    padding: 0.5rem 1rem;
    border-radius: 20px;
    cursor: pointer;
    font-size: 0.9rem;
    transition: all 0.3s;
}
.edit-btn:hover {
    transform: scale(1.05);
}
.add-btn {
    background: linear-gradient(135deg, #64b5f6, #90caf9);
    color: white;
    border: none;
    padding: 0.8rem 1.5rem;
    border-radius: 20px;
    cursor: pointer;
    font-size: 1rem;
    margin: 1rem 0;
    display: block;
    width: fit-content;
}
.modal {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0,0,0,0.5);
    display: none;
    align-items: center;
    justify-content: center;
    z-index: 1000;
}
.modal.show {
    display: flex;
}
.modal-content {
    background: white;
    padding: 2rem;
    border-radius: 25px;
    max-width: 500px;
    width: 90%;
}
.modal-content h3 {
    color: #ff6b9d;
    margin-bottom: 1rem;
}
.modal-content input,
.modal-content textarea {
    width: 100%;
    padding: 0.8rem;
    margin-bottom: 1rem;
    border: 2px solid #ffe0f0;
    border-radius: 15px;
    font-size: 1rem;
}
.modal-content textarea {
    min-height: 120px;
    resize: vertical;
}
.modal-buttons {
    display: flex;
    gap: 1rem;
    justify-content: flex-end;
}
.save-btn {
    background: #64b5f6;
    color: white;
    border: none;
    padding: 0.6rem 1.2rem;
    border-radius: 15px;
    cursor: pointer;
}
.cancel-btn {
    background: #e0e0e0;
    color: #666;
    border: none;
    padding: 0.6rem 1.2rem;
    border-radius: 15px;
    cursor: pointer;
}
.delete-btn {
    background: #ff8a80;
    color: white;
    border: none;
    padding: 0.4rem 0.8rem;
    border-radius: 12px;
    cursor: pointer;
    font-size: 0.85rem;
    margin-left: auto;
}

/* 响应式 */
@media (max-width: 768px) {
    .navbar {
        flex-direction: column;
        gap: 1rem;
    }
    .hero h1 {
        font-size: 1.6rem;
    }
}
'@

# ------------------------------
# 2. data.js
# ------------------------------
$dataJs = @'
// 默认数据
const defaultData = {
    home: {
        avatar: '🌸',
        title: '欢迎来到 shirly 的可爱小窝！',
        desc: '这里记录着我的生活、想法、作品和成长 ✨'
    },
    plans: [
        { id: 1, text: '看完 12 本书', done: true, category: '学习成长' },
        { id: 2, text: '学会做个人网站（进行中！）', done: false, category: '学习成长' },
        { id: 3, text: '学一门新技能（插画/摄影/烘焙）', done: false, category: '学习成长' },
        { id: 4, text: '每周运动 3 次', done: false, category: '生活健康' },
        { id: 5, text: '保持早睡早起（尽量！）', done: true, category: '生活健康' },
        { id: 6, text: '学会做 10 道新菜', done: false, category: '生活健康' },
        { id: 7, text: '去 2 个新地方旅行', done: false, category: '休闲娱乐' },
        { id: 8, text: '看 24 部好电影', done: false, category: '休闲娱乐' }
    ],
    works: [
        { id: 1, icon: '🌸', title: '可爱个人网站', desc: '你正在看的这个！从 0 到 1 做的可爱小窝～', tags: ['HTML', 'CSS', '可爱风'] },
        { id: 2, icon: '✏️', title: '插画练习集', desc: '日常画的一些小画，可可爱爱没有脑袋～', tags: ['插画', 'Procreate'] },
        { id: 3, icon: '📷', title: '生活摄影集', desc: '记录生活里的小美好，天空、猫咪、咖啡...', tags: ['摄影', '生活'] },
        { id: 4, icon: '🍰', title: '烘焙小厨房', desc: '做过的小蛋糕、饼干、面包，甜甜蜜蜜！', tags: ['烘焙', '美食'] },
        { id: 5, icon: '📝', title: '手写笔记', desc: '读书笔记、学习笔记，认认真真生活～', tags: ['笔记', '手写'] }
    ],
    articles: [
        { id: 1, date: '2026-03-06', tag: '随想', title: '关于做个人网站这件小事', summary: '今天终于开始做自己的个人网站啦！从想这件事到真正动手，其实过了挺久。不过没关系，现在开始也不晚。希望这个小窝能慢慢变成自己喜欢的样子～' },
        { id: 2, date: '2026-02-28', tag: '读书笔记', title: '《被讨厌的勇气》读后小感', summary: '这本书真的改变了我很多想法。原来我们的很多烦恼，都来自于人际关系。学会“课题分离”之后，感觉轻松了好多。推荐给每一个正在纠结的人～' },
        { id: 3, date: '2026-02-20', tag: '生活', title: '春天快来了吧？', summary: '今天出门的时候，感觉风都变温柔了。阳光晒在身上暖洋洋的，路边的小树好像也在准备发芽。好期待春天呀，可以穿漂亮的小裙子～' },
        { id: 4, date: '2026-02-14', tag: '观影', title: '《龙猫》真是永远的治愈神作', summary: '重看了一遍《龙猫》，还是哭哭笑笑的。宫崎骏的电影里，总有一种让人安心的魔力。好想去那种有大片稻田和森林的地方生活呀～' }
    ],
    diary: [
        { id: 1, date: '2026-03-06 星期五', mood: '🥳', content: '今天太开心啦！我的个人网站终于开工了！虽然只是刚开始，但是看着页面一点点变可爱，真的好有成就感～橘子帮了我大忙！晚上要奖励自己吃点好吃的！' },
        { id: 2, date: '2026-03-04 星期三', mood: '☁️', content: '今天有点小低落，工作上的事情有点烦。不过晚上回家路上，看到了一只超可爱的橘猫！它还蹭了蹭我，感觉被治愈了一点～明天也要加油呀！' },
        { id: 3, date: '2026-03-01 星期日', mood: '🌞', content: '今天天气超级好！和朋友一起去公园野餐了，晒了晒太阳，吃了好吃的小蛋糕，还拍了好多照片。这样的周末真的太幸福了～' }
    ],
    timeline: [
        { id: 1, date: '2026-03-06', emoji: '🎉', title: '个人网站上线啦！', content: '终于有了属于自己的可爱小窝！从今天开始，在这里记录生活、想法和成长～' },
        { id: 2, date: '2026-01-01', emoji: '🎆', title: '2026 新年到来！', content: '新的一年，新的开始！许了好多愿望，希望今年都能慢慢实现～' },
        { id: 3, date: '2025-10-15', emoji: '🐱', title: '遇见了那只橘猫', content: '下班路上遇到了一只超可爱的橘猫，它蹭了蹭我，那一刻感觉被治愈了～虽然没有把它带回家，但是每次想起都觉得暖暖的。' },
        { id: 4, date: '2025-07-20', emoji: '✈️', title: '第一次独自旅行', content: '鼓起勇气一个人去了海边！看着大海，感觉所有的烦恼都变小了。原来一个人旅行也可以这么开心～' },
        { id: 5, date: '很久以前...', emoji: '👶', title: 'shirly 出生啦！', content: '故事的开始，一切的起点～从这天起，慢慢长大，慢慢经历，变成了现在的 shirly ✨' }
    ],
    checkins: {
        water: 12,
        read: 8,
        sport: 3,
        sleep: '努力中...'
    },
    about: {
        name: 'shirly',
        emoji: '🍊',
        bio: '一个可可爱爱、认认真真生活的普通人。喜欢记录生活里的小美好，相信每一天都值得被认真对待。',
        likes: ['可爱的东西', '晒太阳', '看电影', '吃好吃的', '和朋友聊天'],
        motto: '慢慢来，比较快 ✨'
    }
};

// 获取数据
function getData() {
    const stored = localStorage.getItem('shirlyWebsiteData');
    if (stored) {
        return JSON.parse(stored);
    }
    return JSON.parse(JSON.stringify(defaultData));
}

// 保存数据
function saveData(data) {
    localStorage.setItem('shirlyWebsiteData', JSON.stringify(data));
}

// 重置数据（可选）
function resetData() {
    if (confirm('确定要重置所有数据吗？这将恢复到初始状态！')) {
        localStorage.removeItem('shirlyWebsiteData');
        location.reload();
    }
}
'@

# ------------------------------
# 3. index.html
# ------------------------------
$indexHtml = @'
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>shirly 的可爱小窝 🌸</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <nav class="navbar">
        <div class="nav-brand">🍊 shirly 的小窝</div>
        <div class="nav-links">
            <a href="index.html" class="active">首页</a>
            <a href="plans.html">年度计划</a>
            <a href="works.html">作品集</a>
            <a href="articles.html">想法文章</a>
            <a href="diary.html">生活打卡</a>
            <a href="timeline.html">重大事件</a>
            <a href="about.html">关于我</a>
        </div>
    </nav>

    <main class="container">
        <section class="hero">
            <div class="hero-content">
                <div class="hero-avatar" id="heroAvatar">🌸</div>
                <h1 id="heroTitle">欢迎来到 shirly 的可爱小窝！</h1>
                <p id="heroDesc">这里记录着我的生活、想法、作品和成长 ✨</p>
                <button class="edit-btn" onclick="editHome()">✏️ 编辑首页</button>
            </div>
        </section>

        <section class="quick-links">
            <h2>✨ 快速逛逛</h2>
            <div class="links-grid">
                <a href="plans.html" class="link-card">
                    <span class="card-icon">📅</span>
                    <h3>年度计划</h3>
                    <p>今年的目标与进度</p>
                </a>
                <a href="works.html" class="link-card">
                    <span class="card-icon">🎨</span>
                    <h3>作品集</h3>
                    <p>我的作品展示</p>
                </a>
                <a href="articles.html" class="link-card">
                    <span class="card-icon">📝</span>
                    <h3>想法文章</h3>
                    <p>一些胡思乱想</p>
                </a>
                <a href="diary.html" class="link-card">
                    <span class="card-icon">✨</span>
                    <h3>生活打卡</h3>
                    <p>日常小记录</p>
                </a>
                <a href="timeline.html" class="link-card">
                    <span class="card-icon">🌟</span>
                    <h3>重大事件</h3>
                    <p>人生里程碑</p>
                </a>
                <a href="about.html" class="link-card">
                    <span class="card-icon">🍊</span>
                    <h3>关于我</h3>
                    <p>认识一下 shirly</p>
                </a>
            </div>
        </section>
    </main>

    <!-- 编辑弹窗 -->
    <div class="modal" id="homeModal">
        <div class="modal-content">
            <h3>✏️ 编辑首页</h3>
            <input type="text" id="inputAvatar" placeholder="头像 emoji（比如：🌸）">
            <input type="text" id="inputTitle" placeholder="标题">
            <textarea id="inputDesc" placeholder="描述"></textarea>
            <div class="modal-buttons">
                <button class="cancel-btn" onclick="closeModal('homeModal')">取消</button>
                <button class="save-btn" onclick="saveHome()">保存</button>
            </div>
        </div>
    </div>

    <footer class="foo
...(truncated)...