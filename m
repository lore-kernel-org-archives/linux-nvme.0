From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 25 Jul 2018 11:06:56 -0700
Subject: [GIT PULL] first round of nvme updates for 4.19
In-Reply-To: <20180725110835.GA1674@infradead.org>
References: <20180725110835.GA1674@infradead.org>
Message-ID: <3fea3397-3ec6-9187-2a03-195c88b754a1@kernel.dk>

On 7/25/18 4:08 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> below is the first batch of NVMe updates for Linux 4.19.
> 
> Highlights:
> 
>  - massively improved tracepoints (Keith Busch)
>  - support for larger inline data in the RDMA host and target
>    (Steve Wise)
>  - RDMA setup/teardown path fixes and refactor (Sagi Grimberg)
>  - Command Supported and Effects log support for the NVMe target
>    (Chaitanya Kulkarni)
>  - buffered I/O support for the NVMe target (Chaitanya Kulkarni)
> 
> plus the usual set of cleanups and small enhancements.

Pulled, thanks.

-- 
Jens Axboe
