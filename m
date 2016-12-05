From: axboe@kernel.dk (Jens Axboe)
Date: Mon, 5 Dec 2016 10:42:37 -0700
Subject: [GIT PULL] nvme fabrics patches for 4.10
In-Reply-To: <1480888926-19235-1-git-send-email-sagi@grimberg.me>
References: <1480888926-19235-1-git-send-email-sagi@grimberg.me>
Message-ID: <6d35084f-f7e2-28bc-9a2b-740af461f02e@kernel.dk>

On 12/04/2016 03:02 PM, Sagi Grimberg wrote:
> Hey Jens,
> 
> The major addition here is the nvme FC transport implementation
> from James.
> 
> What else:
> - some cleanups and memory leak fixes in the host side fabrics code from Bart
> - possible rcu violation fix from Sasha
> - logging change from Max
> - small include cleanup
> 
> Please pull from:
> 
>   git://git.infradead.org/nvme-fabrics.git nvmf-4.10

Ehm no. This isn't based on my 4.10 branch, hence I get a ton of
unrelated commits if I pull this in. Please rebase this on top of
4.10/block first, thanks.

-- 
Jens Axboe
