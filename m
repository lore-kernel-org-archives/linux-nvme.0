From: stephen.bates@microsemi.com (Stephen Bates)
Date: Thu, 5 May 2016 19:44:29 +0000
Subject: [PATCH 0/2] Block: Give option to force io polling
In-Reply-To: <1459455554-2794-1-git-send-email-jonathan.derrick@intel.com>
References: <1459455554-2794-1-git-send-email-jonathan.derrick@intel.com>
Message-ID: <D87A37E7A4AA544D853031D9A919C70B168FDA58@avsrvexchmbx2.microsemi.net>

> 
> In 4.6, enabling io polling in direct-io was switched to a per-io flag.
> This had an unintended result of giving a significant difference when doing
> benchmarks between 4.5 and 4.6, using fio's sync engine.
> 
> I was able to regain the performance by getting the pvsync2 engine working
> with the new p{read,write}v2 syscalls, but this patchset allows polling to be
> tried in the direct-io path with the other syscalls.
> 
> Rather than having to convert applications to prwv2 syscalls, users can enable
> this knob that let's them see the same performance as they may have seen
> in 4.5 when it always polled.
> 
> Jon Derrick (2):
>   block: add queue flag to always poll
>   block: add forced polling sysfs controls
> 
>  block/blk-core.c       |  8 ++++++++
>  block/blk-sysfs.c      | 38 ++++++++++++++++++++++++++++++++++++++
>  fs/direct-io.c         |  7 ++++++-
>  include/linux/blkdev.h |  2 ++
>  4 files changed, 54 insertions(+), 1 deletion(-)
> 

Hi

Revisiting this discussion from late March...

I am very interested in seeing this added. There are use cases involving super-low latency (non-NAND based) NVMe devices and they want the fastest possible IO response times for ALL IO to that device. They also have no desire to wait for the new system calls and glibc updates needed to tie their applications into polling or to rewrite their applications to avail of those new calls. I have done some testing on Jon's "big hammer" and it seems to work well for this use case and applied cleanly against v4.6-rc6.

For the series...

Reviewed-by: Stephen Bates <stephen.bates at microsemi.com>
Tested-by: Stephen Bates <stephen.bates at microsemi.com>

Cheers

Stephen
