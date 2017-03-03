From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 3 Mar 2017 09:20:19 -0700
Subject: WARN_ON() when booting with nvme loopback over zram
In-Reply-To: <20170303161826.GA26324@linux-x5ow.site>
References: <20170303161826.GA26324@linux-x5ow.site>
Message-ID: <d18616eb-bce4-379b-4328-f4df4763a10a@kernel.dk>

On 03/03/2017 09:18 AM, Johannes Thumshirn wrote:
> Hi,
> 
> I get the following WARN_ON when trying to establish a nvmf loopback device
> backed by zram.
> 
> My topmost commit is c82be9d2244aacea9851c86f4fb74694c99cd874

It's fixed in my for-linus, pull request went out to Linus yesterday.
So hopefully master should be fine with nvmf very shortly.

-- 
Jens Axboe
