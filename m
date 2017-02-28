From: axboe@fb.com (Jens Axboe)
Date: Tue, 28 Feb 2017 10:44:21 -0700
Subject: [PATCH] nvme/pci: Poll CQ on timeout
In-Reply-To: <20170228160056.GA15639@localhost.localdomain>
References: <1487977168-5347-1-git-send-email-keith.busch@intel.com>
 <20170228141017.GC20317@lst.de>
 <20170228160056.GA15639@localhost.localdomain>
Message-ID: <6c0cacb0-ab91-6270-8bae-dbd18a8dbd0e@fb.com>

On 02/28/2017 09:00 AM, Keith Busch wrote:
> On Tue, Feb 28, 2017@03:10:17PM +0100, Christoph Hellwig wrote:
>> On Fri, Feb 24, 2017@05:59:28PM -0500, Keith Busch wrote:
>>> If an IO timeout occurs, it's helpful to know if the controller did not
>>> post a completion or the driver missed an interrupt. While we never expect
>>> the latter, this patch will make it possible to tell the difference so
>>> we don't have to guess.
>>
>> Do you have any good real use case for it?  I mostly don't like it
>> becuase it ties us to polling for a specific tag, something I'd like
>> to change in the ->poll API.
> 
> I don't expect this to often catch anything, but this is a cheap way of
> constraining the problem just by having this in place: the "Timeout"
> message definitely means the device did not post an entry on that
> command's completion queue, so either the device is broken or we messed
> up the queue mapping.
> 
> In the event it does trigger (I've seen this only a handlful of times
> on new platforms and devices, as well as legacy IRQs), we know a whole
> lot more about the problem, compared to just seeing "Timeout".
> 
> If you want to remove the tag specific polling, I can look into an
> alternative.

IMHO that can go at a later time, if we do remove polling for
specific entries. For now it's fine.

And I do think this is a nice addition - it's free, and it provides
us extra info for debugging an issue. That's a big deal, especially
if it's a user report.

-- 
Jens Axboe
