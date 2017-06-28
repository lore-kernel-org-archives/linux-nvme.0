From: hch@lst.de (Christoph Hellwig)
Date: Wed, 28 Jun 2017 16:15:24 +0200
Subject: [PATCH 1/1] blk-mq: map all HWQ also in hyperthreaded system
In-Reply-To: <1498653880-29223-1-git-send-email-maxg@mellanox.com>
References: <1498653880-29223-1-git-send-email-maxg@mellanox.com>
Message-ID: <20170628141524.GA1894@lst.de>

On Wed, Jun 28, 2017@03:44:40PM +0300, Max Gurtovoy wrote:
> This patch performs sequential mapping between CPUs and queues.
> In case the system has more CPUs than HWQs then there are still
> CPUs to map to HWQs. In hyperthreaded system, map the unmapped CPUs
> and their siblings to the same HWQ.
> This actually fixes a bug that found unmapped HWQs in a system with
> 2 sockets, 18 cores per socket, 2 threads per core (total 72 CPUs)
> running NVMEoF (opens upto maximum of 64 HWQs).
> 
> Performance results running fio (72 jobs, 128 iodepth)
> using null_blk (w/w.o patch):

Can you also tests with Sagi's series to use the proper IRQ
level mapping?
