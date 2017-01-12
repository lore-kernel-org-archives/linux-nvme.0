From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 12 Jan 2017 17:09:23 +0200
Subject: [Lsf-pc] [LSF/MM TOPIC] [LSF/MM ATTEND] md raid general discussion
In-Reply-To: <79796ea4-2631-c762-b8a1-50bcdcbc602e@suse.de>
References: <79796ea4-2631-c762-b8a1-50bcdcbc602e@suse.de>
Message-ID: <17625a3f-5598-d83d-44a1-316ccc917ad5@grimberg.me>

Hey Coly,

> Also I receive reports from users that raid1 performance is desired when
> it is built on NVMe SSDs as a cache (maybe bcache or dm-cache). I am
> working on some raid1 performance improvement (e.g. new raid1 I/O
> barrier and lockless raid1 I/O submit), and have some more ideas to discuss.

Do you have some performance measurements to share?

Mike used null devices to simulate very fast devices which
led to nice performance enhancements in dm-multipath code.
