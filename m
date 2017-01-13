From: colyli@suse.de (Coly Li)
Date: Fri, 13 Jan 2017 12:00:12 +0800
Subject: [Lsf-pc] [LSF/MM TOPIC] [LSF/MM ATTEND] md raid general discussion
In-Reply-To: <17625a3f-5598-d83d-44a1-316ccc917ad5@grimberg.me>
References: <79796ea4-2631-c762-b8a1-50bcdcbc602e@suse.de>
 <17625a3f-5598-d83d-44a1-316ccc917ad5@grimberg.me>
Message-ID: <0e2dc23a-bee9-6c7b-0903-a2edc05f75e6@suse.de>

On 2017/1/12 ??11:09, Sagi Grimberg wrote:
> Hey Coly,
> 
>> Also I receive reports from users that raid1 performance is desired when
>> it is built on NVMe SSDs as a cache (maybe bcache or dm-cache). I am
>> working on some raid1 performance improvement (e.g. new raid1 I/O
>> barrier and lockless raid1 I/O submit), and have some more ideas to
>> discuss.
> 
> Do you have some performance measurements to share?
> 
> Mike used null devices to simulate very fast devices which
> led to nice performance enhancements in dm-multipath code.

I have several performance data of raid1 and raid0, which is still work
in progress.

- md raid1
  Current md raid1 read performance is not ideal. A raid1 with 2 NVMe
SSD, only observe 2.6GB/s throughput for multi I/O and depth reading.
Most of the time spending on I/O barrier locking. Now I am working on a
lockless I/O submit patch (the original idea is from Hannes Reinecke),
which improves reading throughput to 4.7~5GB/s. When using md raid1 as a
cache device, reading performance improvement is critical.
  On my hardware, the ideal reading throughput of 2 NVMe is 6GB/s,
currently the reading performance number is 4.7~5GB/s, still have a
little some space to improve.
- md raid0
  People reports on linux-raid mailing list that DISCARD/TRIM
performance on raid0 is slow. In my reproducing, a raid0 built by 4x3TB
NVMe SSD, formatting a XFS volume on top of it takes 306 seconds. Most
of the time is inside md raid0 code to issue DISCARD/TRIM request in
chunk size range. I compose a POC patch to re-combine a large
DISCARD/TRIM command into per-device request, which reduces the
formatting time to 15 seconds. Now I work on patch simplifying by the
suggestions from upstream maintainers.

For raid1, currently most of feed backs are from read performance.

Coly
