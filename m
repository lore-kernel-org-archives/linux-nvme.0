From: mlin@kernel.org (Ming Lin)
Date: Fri, 17 Jun 2016 10:20:42 -0700
Subject: target crash / host hang with nvme-all.3 branch of nvme-fabrics
In-Reply-To: <007801d1c8a2$d6056530$82102f90$@opengridcomputing.com>
References: <00d801d1c7de$e17fc7d0$a47f5770$@opengridcomputing.com>
 <20160616145724.GA32635@infradead.org>
 <017001d1c7e7$95057270$bf105750$@opengridcomputing.com>
 <5763044A.9090206@grimberg.me>
 <005f01d1c8a1$5a229240$0e67b6c0$@opengridcomputing.com>
 <007801d1c8a2$d6056530$82102f90$@opengridcomputing.com>
Message-ID: <CAF1ivSZNJhOtORceAfk9Ym9SPpYOGQ4q0KOD8eEuy0ovU2Eefw@mail.gmail.com>

On Fri, Jun 17, 2016@7:16 AM, Steve Wise <swise@opengridcomputing.com> wrote:
>>
>> >
>> > Steve, is this something that started happening recently? does the
>> > 4.6-rc3 tag suffer from the same phenomenon?
>>
>> Where is this tag?
>
> Never mind.  I found it (needed 'git pull -t' for pull the tags from the gitlab
> nvmef repo).

I run this overnight,

#!/bin/bash

while [ 1 ] ; do
    ifconfig eth5 down ; sleep 15; ifconfig eth5 up; sleep 15
done

Although the crash is not reproduced, but it triggers another OOM bug.

[38335.167460] nvmet: ctrl 241 keep-alive timer (15 seconds) expired!
[38365.954235] nvmet: ctrl 243 keep-alive timer (15 seconds) expired!
[38392.132613] nvmet: ctrl 241 keep-alive timer (15 seconds) expired!
[38423.943463] nvmet: ctrl 243 keep-alive timer (15 seconds) expired!
[38455.178284] nvmet: ctrl 244 keep-alive timer (15 seconds) expired!
[38486.093079] nvmet: ctrl 243 keep-alive timer (15 seconds) expired!
[38517.231876] nvmet: ctrl 244 keep-alive timer (15 seconds) expired!
[38543.122210] nvmet: ctrl 243 keep-alive timer (15 seconds) expired!
[38574.933079] nvmet: ctrl 244 keep-alive timer (15 seconds) expired!
[38605.975884] nvmet: ctrl 245 keep-alive timer (15 seconds) expired!
[38636.954661] nvmet: ctrl 244 keep-alive timer (15 seconds) expired!
[38668.189494] nvmet: ctrl 245 keep-alive timer (15 seconds) expired!
[38699.072284] nvmet: ctrl 244 keep-alive timer (15 seconds) expired!
[38725.154623] nvmet: ctrl 245 keep-alive timer (15 seconds) expired!
[38756.901490] nvmet: ctrl 244 keep-alive timer (15 seconds) expired!
[38762.153397] 96 and 0 pages still available in the bound and unbound
GPU page lists.
[38762.161985] Out of memory: Kill process 1270 (java) score 2 or
sacrifice child
[38762.169829] Killed process 1270 (java) total-vm:2829756kB,
anon-rss:0kB, file-rss:2696kB, shmem-rss:0kB
[38770.880447] 96 and 0 pages still available in the bound and unbound
GPU page lists.
[38770.888688] Out of memory: Kill process 1409 (libvirtd) score 0 or
sacrifice child
[38770.896618] Killed process 1409 (libvirtd) total-vm:372592kB,
anon-rss:0kB, file-rss:1664kB, shmem-rss:0kB
[38770.912433] 96 and 0 pages still available in the bound and unbound
GPU page lists.
[38770.920867] 96 and 0 pages still available in the bound and unbound
GPU page lists.
[38770.929214] 96 and 0 pages still available in the bound and unbound
GPU page lists.
[38770.937788] 96 and 0 pages still available in the bound and unbound
GPU page lists.
[38774.191627] 96 and 0 pages still available in the bound and unbound
GPU page lists.
[38774.199950] Out of memory: Kill process 11265 (java) score 0 or
sacrifice child
[38774.207787] Killed process 11265 (java) total-vm:35600kB,
anon-rss:48kB, file-rss:4784kB, shmem-rss:0kB
[38788.104282] nvmet: ctrl 246 keep-alive timer (15 seconds) expired!
[38803.999289] nvmet: invalid command 0x0 on unconnected queue.
[38806.514069] 96 and 0 pages still available in the bound and unbound
GPU page lists.


[38947.267367] Out of memory: Kill process 1153 (iscsid) score 0 or
sacrifice child
[38947.274738] Killed process 1153 (iscsid) total-vm:5796kB,
anon-rss:1124kB, file-rss:2464kB, shmem-rss:16kB
[38948.804421] 96 and 0 pages still available in the bound and unbound
GPU page lists.
[38948.812215] Kernel panic - not syncing: Out of memory and no
killable processes...
[38948.812215]
[38948.821215] CPU: 1 PID: 1 Comm: init Tainted: G           OE
4.7.0-rc2+ #256
[38948.828400] Hardware name: Dell Inc. OptiPlex 7010/0773VG, BIOS A12
01/10/2013
[38948.835585]  0000000000000000 ffff88011827faa8 ffffffff8133104a
ffffffff81a1b758
[38948.843001]  ffffffff81c0d540 ffff88011827fb20 ffffffff811218fc
ffff880000000008
[38948.850413]  ffff88011827fb30 ffff88011827fad0 000000000000000a
ffff8800d6870d40
[38948.857824] Call Trace:
[38948.860260]  [<ffffffff8133104a>] dump_stack+0x63/0x89
[38948.865373]  [<ffffffff811218fc>] panic+0xcd/0x21e
[38948.870140]  [<ffffffff81128249>] out_of_memory+0x449/0x470
[38948.875683]  [<ffffffff8112c7de>] __alloc_pages_nodemask+0xa4e/0xc20
[38948.882004]  [<ffffffff8109adc0>] ? put_prev_entity+0x30/0x6e0
[38948.887807]  [<ffffffff81172830>] alloc_pages_vma+0xb0/0x210
[38948.893438]  [<ffffffff81163514>] __read_swap_cache_async+0x134/0x1e0
[38948.899846]  [<ffffffff811635d2>] read_swap_cache_async+0x12/0x30
[38948.905908]  [<ffffffff81163739>] swapin_readahead+0x149/0x1b0
[38948.911710]  [<ffffffff81123600>] ? find_get_entry+0x60/0xa0
[38948.917339]  [<ffffffff81124767>] ? pagecache_get_page+0x27/0x250
[38948.923401]  [<ffffffff8115092b>] handle_mm_fault+0x14fb/0x1cf0
[38948.929291]  [<ffffffff81076fa6>] ? recalc_sigpending+0x16/0x50
[38948.935181]  [<ffffffff81059bc3>] __do_page_fault+0x1a3/0x4e0
[38948.940898]  [<ffffffff81059f22>] do_page_fault+0x22/0x30
[38948.946269]  [<ffffffff816f6e18>] page_fault+0x28/0x30
[38948.951383] Kernel Offset: disabled
[38948.960747] ---[ end Kernel panic - not syncing: Out of memory and
no killable processes...
[38948.960747]
