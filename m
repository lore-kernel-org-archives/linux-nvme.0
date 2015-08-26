From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 26 Aug 2015 09:00:28 -0600
Subject: [PATCH V2] NVMe: Using PRACT bit to generate and verify PI by
 controller
In-Reply-To: <55DDD459.8060405@kernel.dk>
References: <1438094033-2693-1-git-send-email-pandey.alok@samsung.com>
 <alpine.LNX.2.00.1507301956330.15930@localhost.lm.intel.com>
 <000001d0dfba$7ad40210$707c0630$@samsung.com> <55DDD459.8060405@kernel.dk>
Message-ID: <55DDD48C.2030602@kernel.dk>

On 08/26/2015 08:59 AM, Jens Axboe wrote:
> On 08/25/2015 10:46 PM, Alok wrote:
>> Can it be picked up.
>
> Applied for 4.3:
>
> http://git.kernel.dk/cgit/linux-block/commit/?h=for-4.3/drivers&id=e3f879bf1ea3e03f433d292b0114807785f0754b
>
>
> Please double check the patch, I had to hand apply it due to conflicts.
> In the future, base patches for revision x.y of the kernel against
> for-x.y/drivers. Thanks!

Ooops, this is the right commit, of course:

http://git.kernel.dk/cgit/linux-block/commit/?h=for-4.3/drivers&id=e19b127f5b76ec03b9c52b64f117dc75bb39eda1


-- 
Jens Axboe
