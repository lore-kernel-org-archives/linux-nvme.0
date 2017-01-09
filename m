From: colyli@suse.de (Coly Li)
Date: Tue, 10 Jan 2017 00:38:03 +0800
Subject: [LSF/MM TOPIC] [LSF/MM ATTEND] md raid general discussion
Message-ID: <79796ea4-2631-c762-b8a1-50bcdcbc602e@suse.de>

Hi Folks,

I'd like to propose a general md raid discussion, it is quite necessary
for most of active md raid developers sit together to discuss current
challenge of Linux software raid and development trends.

In the last years, we have many development activities in md raid, e.g.
raid5 cache, raid1 clustering, partial parity log, fast fail
upstreaming, and some effort for raid1 & raid0 performance improvement.

I see there are some kind of functionality overlap between r5cache
(raid5 cache) and PPL (partial parity log), currently I have no idea
where we will go for these two development activities.
Also I receive reports from users that raid1 performance is desired when
it is built on NVMe SSDs as a cache (maybe bcache or dm-cache). I am
working on some raid1 performance improvement (e.g. new raid1 I/O
barrier and lockless raid1 I/O submit), and have some more ideas to discuss.

Therefore, if md raid developers may have a chance to sit together,
discuss how to efficiently collaborate in next year, it will be much
more productive then communicating on mailing list.

Finally let me introduce myself for people don't know me. My name is
Coly Li, I used to work on OCFS2, Ext4 for SUSE Linux, now I work with
Neil Brown and Hannes Reinecke to maintain block layer code for SUSE
Linux, mostly focus on drivers/md/*

Thanks.

Coly Li
