From: axboe@fb.com (Jens Axboe)
Date: Wed, 9 Dec 2015 11:05:06 -0700
Subject: [patch] nvme: precedence bug in nvme_pr_clear()
In-Reply-To: <20151209180018.GA19448@lst.de>
References: <20151209102406.GD3173@mwanda> <56686B55.7020900@fb.com>
 <20151209180018.GA19448@lst.de>
Message-ID: <56686D52.5060900@fb.com>

On 12/09/2015 11:00 AM, Christoph Hellwig wrote:
> On Wed, Dec 09, 2015@10:56:37AM -0700, Jens Axboe wrote:
>> On 12/09/2015 03:24 AM, Dan Carpenter wrote:
>>> The "|" operator has higher precedence than "?:" so this didn't work as
>>> intended.  I had previously fixed this bug, but it we copied the older
>>> unfixed version when we moved the function between files.
>>>
>>> Fixes: 1673f1f08c88 ('nvme: move block_device_operations and ns/ctrl freeing to common code')
>>> Signed-off-by: Dan Carpenter <dan.carpenter at oracle.com>
>>
>> Dejavu, but I guess in a different function. Christoph, you are hereby
>> banned from ever using ?:!
>
> Nah, I'm banned from ever moving large chunks of code around again :)
> The orginal Bug is Keith's, I just undid the fix by not properly fixing
> up the code move for the conflict.

Alright you are off the hook, the ban will be instated in Keith instead :-)

-- 
Jens Axboe
