From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 21 Nov 2018 05:56:54 -0700
Subject: [GIT PULL] nvme fix for 4.20
In-Reply-To: <20181120161411.GA1367@infradead.org>
References: <20181120161411.GA1367@infradead.org>
Message-ID: <53d91a0a-73eb-53dd-195e-4c3786104009@kernel.dk>

On 11/20/18 9:14 AM, Christoph Hellwig wrote:
> The following changes since commit 8dc765d438f1e42b3e8227b3b09fad7d73f4ec9a:
> 
>   SCSI: fix queue cleanup race before queue initialization is done (2018-11-14 08:19:10 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-4.20
> 
> for you to fetch changes up to 4cff280a5fccf6513ed9e895bb3a4e7ad8b0cedc:
> 
>   nvme-fc: resolve io failures during connect (2018-11-15 11:37:55 +0100)
> 
> ----------------------------------------------------------------
> James Smart (1):
>       nvme-fc: resolve io failures during connect
> 
>  drivers/nvme/host/fc.c | 73 +++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 63 insertions(+), 10 deletions(-)

Pulled, thanks.

-- 
Jens Axboe
