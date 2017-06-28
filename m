From: axboe@fb.com (Jens Axboe)
Date: Wed, 28 Jun 2017 17:13:00 -0600
Subject: nvme defintions not used in the kernel
In-Reply-To: <20170628231129.GA20902@lst.de>
References: <20170628231129.GA20902@lst.de>
Message-ID: <dece3f75-444f-ea57-6569-d8089e5cf19c@fb.com>

On 06/28/2017 05:11 PM, Christoph Hellwig wrote:
> Hi all,
> 
> currently nvme-cli supports various nvme features that are not
> needed in the kernel and keeps them in its own nvme.h file,
> in addition to pulling in the kernel one.
> 
> Do we want to keep it that way in the long run, or just add
> things to nvme.h in the kernel even if they are not used to
> keep things in a single place.
> 
> To me the latter would seem a little nicer, especially as it
> doesn't involve a whole lot of defintion.

I'd vote for the latter as well. It's nice for documentation as
well, often easier than grabbing the spec if you are in the driver
anyway.

-- 
Jens Axboe
