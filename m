From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 20 Sep 2018 09:11:02 -0600
Subject: [GIT PULL] nvme fix for 4.19
In-Reply-To: <20180920062659.GA18562@infradead.org>
References: <20180920062659.GA18562@infradead.org>
Message-ID: <443f41f6-1b79-89f6-6ac5-5a8d58ac8f98@kernel.dk>

On 9/20/18 12:26 AM, Christoph Hellwig wrote:
> The following changes since commit b228ba1cb95afbaeeb86cf06cd9fd6f6369c3b14:
> 
>   null_blk: fix zoned support for non-rq based operation (2018-09-12 18:21:11 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-4.19
> 
> for you to fetch changes up to be1277f5eb17a2e5788139eabb0b53dd04c695f3:
> 
>   nvme: count all ANA groups for ANA Log page (2018-09-17 15:49:40 +0200)
> 
> ----------------------------------------------------------------
> Hannes Reinecke (1):
>       nvme: count all ANA groups for ANA Log page
> 
>  drivers/nvme/target/admin-cmd.c | 4 ++++
>  1 file changed, 4 insertions(+)

Pulled, thanks.

-- 
Jens Axboe
