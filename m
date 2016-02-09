From: axboe@fb.com (Jens Axboe)
Date: Tue, 9 Feb 2016 12:39:52 -0700
Subject: [PATCH 2/2] NVMe: Fix possible queue use after freed
In-Reply-To: <20160208192848.GA8151@localhost.localdomain>
References: <1450397295-24031-1-git-send-email-keith.busch@intel.com>
 <1450397295-24031-2-git-send-email-keith.busch@intel.com>
 <20160208192848.GA8151@localhost.localdomain>
Message-ID: <56BA4088.40001@fb.com>

On 02/08/2016 12:28 PM, Jon Derrick wrote:
> Hi Jens,
>
> This set was acked a while back by Christoph and reviewed by me.
> I just tested it again and it still works well against 4.5-rc3.
>
> Is there any chance we can get this in for 4.6?

Yes, it will go into 4.6.

-- 
Jens Axboe
