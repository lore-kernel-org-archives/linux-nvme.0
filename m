From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 21 Feb 2017 11:24:24 +0200
Subject: [PATCHv2 1/2] nvme-rdma: move nvme cm status helper to .h file
In-Reply-To: <1D08B61A9CF0974AA09887BE32D889DA0A9949@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
References: <1487591069-6261-1-git-send-email-maxg@mellanox.com>
 <1D08B61A9CF0974AA09887BE32D889DA0A9949@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
Message-ID: <d21d9ca9-92fe-5994-d09a-f6ad37bbd099@mellanox.com>

Hi Bart,

Currently we don't have any .c file to put this function implementation 
without creating a code duplication and module dependencies.
I think that this new solution is better than code duplication, right ?

thanks,
Max.


On 2/20/2017 7:03 PM, Bart Van Assche wrote:
> On 02/20/2017 03:44 AM, Max Gurtovoy wrote:
>> This will enable the usage for nvme rdma target.
>> Also move from a lookup array to a switch statement.
>
> Hello Max,
>
> In general un-inlining code that is not in the hot path is wrong because
> this increases the size of the kernel and because this increases the
> time needed to build the kernel. Would it have been possible to keep the
> nvme_rdma_cm_msg() definition in a .c file?
>
> Thanks,
>
> Bart.
>
