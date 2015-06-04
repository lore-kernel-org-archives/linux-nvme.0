From: axboe@fb.com (Jens Axboe)
Date: Thu, 4 Jun 2015 14:12:57 -0600
Subject: [PATCH] NVMe: Add reset controller sysfs entry
In-Reply-To: <5570AE5E.6030407@fb.com>
References: <D195D453.84EA%brandon.schulz@hgst.com>
 <alpine.LNX.2.00.1506041518030.15930@localhost.lm.intel.com>
 <20150604153909.GA18137@infradead.org> <5570AE5E.6030407@fb.com>
Message-ID: <5570B149.3050901@fb.com>

On 06/04/2015 02:00 PM, Jens Axboe wrote:
> On 06/04/2015 09:39 AM, Christoph Hellwig wrote:
>> On Thu, Jun 04, 2015@03:26:03PM +0000, Keith Busch wrote:
>>> On Thu, 4 Jun 2015, Brandon Schulz wrote:
>>>> Do you plan to merge this into your legacy tree somewhere that we can
>>>> reference in Bugzillas/etc. with the Linux distro vendors?
>>>
>>> There is a strong preference with vendors to see fixes upstream prior
>>> to backporting but this is a long-standing percieved weakness in Linux
>>> vs. other operating systems; no one wants to reboot their machine for
>>> a f/w upgrade ... so, okay, I'll apply it to legacy and see if I can
>>> lobby OSVs to take out-of-stream fixes.
>>
>> Eww.  Jens, can you please just apply this patch so that we're not
>> having such a mess?
>
> Yeah, I'll apply it now for 4.2.

Well, that was a bit of a mess. Attached is my quick attempt at 
combining the two, and reusing the reset code from the ioctl path as 
well. One functional change was NOT flushing the work if we don't queue 
it in nvme_reset(), the previous code from Keith did that. Otherwise it 
should be straight forward.

Please review, I'll hold off on committing this.

-- 
Jens Axboe

-------------- next part --------------
A non-text attachment was scrubbed...
Name: nvme-reset.patch
Type: text/x-patch
Size: 3651 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20150604/ff0c718e/attachment.bin>
