From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Thu, 31 Dec 2015 20:38:21 +0200
Subject: [PATCHv2 0/5] NVMe fixes and updates, version 2
In-Reply-To: <1451580116-12252-1-git-send-email-keith.busch@intel.com>
References: <1451580116-12252-1-git-send-email-keith.busch@intel.com>
Message-ID: <5685761D.2070704@dev.mellanox.co.il>



On 31/12/2015 18:41, Keith Busch wrote:
> Changes since v1:
>
>    Fixed the patch order. Previously 4/5 and 5/5 were swapped.
>
>    Added a code comment to make the clarify the queue full condition.
>
>    Better commit log messages.
>
>    Moved the "struct completion" from an nvme_queue union to struct nvme_dev.
>
>    Simplified the shutdown patch based on review comments. The logic is
>    pushed into a single admin queue handling function, and the result is
>    more understandable.
>
> There are suggestions for other mechanisms to handle async io queue
> deletion (patch 4/5, previously 5/5), but I'm sticking with the original
> idea this time. I'll spin another patch if the alternate proposals compel
> new version.
>
> Keith Busch (5):
>    NVMe: Fix admin queue ring wrap
>    NVMe: Use a retryable error code on reset
>    NVMe: Remove queue freezing on resets

Any particular reason for not rebasing on top of my patch and
Christoph's "namespace list locking and ioctl fixes V2"?
