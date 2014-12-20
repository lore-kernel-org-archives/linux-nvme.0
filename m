From: axboe@fb.com (Jens Axboe)
Date: Sat, 20 Dec 2014 12:29:02 -0700
Subject: [PATCH 0/4] nvme-blkmq fixes
In-Reply-To: <5495B2BF.8070602@fb.com>
References: <1419036856-16275-1-git-send-email-keith.busch@intel.com>
 <5495B2BF.8070602@fb.com>
Message-ID: <5495CDFE.3060404@fb.com>

On 12/20/2014 10:32 AM, Jens Axboe wrote:
> On 12/19/2014 05:54 PM, Keith Busch wrote:
>> This fixes some surprise hot plug and error handling cases.
>>
>> There is still one deadlock when we run out of tags and get stuck in
>> bt_get, but Jens sent me a test patch that I verfied fixes that when
>> used with this set.
>
> Thanks Keith, I'll apply these for the current series. Only change I'll
> make is turn the freeze/unfreeze exports into _GPL exports.

Here's the patch referenced. Keith, if you tested it, can I add your 
tested/reviewed-by to it?

-- 
Jens Axboe

-------------- next part --------------
A non-text attachment was scrubbed...
Name: blk-mq-wake-on-dying.patch
Type: text/x-patch
Size: 3004 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20141220/a39f758d/attachment-0001.bin>
