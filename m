From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 5 Dec 2016 19:05:41 +0200
Subject: [PATCH 3/3] nvme: Make controller state visible via sysfs
In-Reply-To: <06f399ae-4483-2790-878e-08bfc04bea4b@mellanox.com>
References: <1480936146-6406-1-git-send-email-sagi@grimberg.me>
 <1480936146-6406-4-git-send-email-sagi@grimberg.me>
 <06f399ae-4483-2790-878e-08bfc04bea4b@mellanox.com>
Message-ID: <bc5fafa8-7afe-f02d-4bde-0b5bbeadaa6e@grimberg.me>


> Sagi,
> what about locking the "ctrl->lock" and making it more up-to-date ?

Don't see why we should do that. What are you trying to protect against?
