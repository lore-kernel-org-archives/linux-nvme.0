From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 21 Feb 2017 12:52:43 +0200
Subject: [PATCHv2 1/2] nvme-rdma: move nvme cm status helper to .h file
In-Reply-To: <20170221092705.GA27568@infradead.org>
References: <1487591069-6261-1-git-send-email-maxg@mellanox.com>
 <1D08B61A9CF0974AA09887BE32D889DA0A9949@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
 <d21d9ca9-92fe-5994-d09a-f6ad37bbd099@mellanox.com>
 <20170221092705.GA27568@infradead.org>
Message-ID: <9611eb27-4922-3674-7272-8ceecb2dd4a9@mellanox.com>



On 2/21/2017 11:27 AM, hch@infradead.org wrote:
> On Tue, Feb 21, 2017@11:24:24AM +0200, Max Gurtovoy wrote:
>> Hi Bart,
>>
>> Currently we don't have any .c file to put this function implementation
>> without creating a code duplication and module dependencies.
>> I think that this new solution is better than code duplication, right ?
>
> Yes, it is - especially given that it's just a bit of constant and not
> much code anyway, and each new module would take up at least a page of
> memory.
>

Maybe we'll need it in the future, but for now let's take it as is.

Sagi,
can you take it to nvme-4.11 ?

Max.
