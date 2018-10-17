From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 17 Oct 2018 09:46:10 -0600
Subject: [GIT PULL] nvme fix for 4.19
In-Reply-To: <20181017063859.GA7083@infradead.org>
References: <20181017063859.GA7083@infradead.org>
Message-ID: <f25fc6a3-4d91-6883-eb31-639a1af9f27e@kernel.dk>

On 10/17/18 12:38 AM, Christoph Hellwig wrote:
> The following changes since commit 133424a207774d3d32a38d560c6469ed31c0472f:
> 
>   Merge branch 'nvme-4.19' of git://git.infradead.org/nvme into for-linus (2018-09-28 09:41:40 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-4.19
> 
> for you to fetch changes up to 48f78be3326052a7718678ff9a78d6d884a50323:
> 
>   nvme: remove ns sibling before clearing path (2018-10-08 11:53:42 +0200)
> 
> ----------------------------------------------------------------
> Keith Busch (1):
>       nvme: remove ns sibling before clearing path
> 
>  drivers/nvme/host/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Pulled, thanks.

-- 
Jens Axboe
