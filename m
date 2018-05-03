From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 3 May 2018 09:38:24 -0600
Subject: [GIT PULL] nvme fixes for 4.17
In-Reply-To: <20180503152948.GM5938@localhost.localdomain>
References: <20180503152948.GM5938@localhost.localdomain>
Message-ID: <b16ac523-9926-6321-87a7-7cad9473495d@kernel.dk>

On 5/3/18 9:29 AM, Keith Busch wrote:
> The following changes since commit bf0ddaba65ddbb2715af97041da8e7a45b2d8628:
> 
>   blk-mq: fix sysfs inflight counter (2018-04-26 09:02:01 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-4.17-rc3
> 
> for you to fetch changes up to eb395977b73dce7af0eaa29412b3f6e13b87811d:
> 
>   nvmet: switch loopback target state to connecting when resetting (2018-05-03 08:11:38 -0600)
> 
> ----------------------------------------------------------------
> Chengguang Xu (1):
>       nvme: fix potential memory leak in option parsing
> 
> Johannes Thumshirn (1):
>       nvmet: switch loopback target state to connecting when resetting
> 
> Keith Busch (3):
>       nvme: Set integrity flag for user passthrough commands
>       nvme/multipath: Disable runtime writable enabling parameter
>       nvme/multipath: Fix multipath disabled naming collisions

Applied, thanks Keith.

-- 
Jens Axboe
