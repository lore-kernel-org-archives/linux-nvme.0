From: hch@infradead.org (hch@infradead.org)
Date: Tue, 21 Feb 2017 01:27:05 -0800
Subject: [PATCHv2 1/2] nvme-rdma: move nvme cm status helper to .h file
In-Reply-To: <d21d9ca9-92fe-5994-d09a-f6ad37bbd099@mellanox.com>
References: <1487591069-6261-1-git-send-email-maxg@mellanox.com>
 <1D08B61A9CF0974AA09887BE32D889DA0A9949@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
 <d21d9ca9-92fe-5994-d09a-f6ad37bbd099@mellanox.com>
Message-ID: <20170221092705.GA27568@infradead.org>

On Tue, Feb 21, 2017@11:24:24AM +0200, Max Gurtovoy wrote:
> Hi Bart,
> 
> Currently we don't have any .c file to put this function implementation
> without creating a code duplication and module dependencies.
> I think that this new solution is better than code duplication, right ?

Yes, it is - especially given that it's just a bit of constant and not
much code anyway, and each new module would take up at least a page of
memory.
