From: axboe@kernel.dk (Jens Axboe)
Date: Tue, 29 May 2018 12:56:00 -0600
Subject: [GIT PULL] nvme one-liner fix for 4.17
In-Reply-To: <20180529185148.GA30983@infradead.org>
References: <20180529185148.GA30983@infradead.org>
Message-ID: <abb5d799-8889-711c-2dce-7d021648e57b@kernel.dk>

On 5/29/18 12:51 PM, Christoph Hellwig wrote:
> Hi Jens,
> 
> below is a one-liner fix from Max that unbreaks T10-DIF support, which
> got broken in 4.15.
> 
> The following changes since commit eedffa28c9b00ca2dcb4d541b5a530f4c917052d:
> 
>   loop: clear wb_err in bd_inode when detaching backing file (2018-05-21 12:36:03 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-4.17
> 
> for you to fetch changes up to c97f414c54a255f4f05a50a2625efaeee406e134:
> 
>   nvme: fix extended data LBA supported setting (2018-05-29 20:29:16 +0200)
> 
> ----------------------------------------------------------------
> Max Gurtovoy (1):
>       nvme: fix extended data LBA supported setting

Pulled, thanks.
-- 
Jens Axboe
