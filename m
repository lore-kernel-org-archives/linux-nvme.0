From: dledford@redhat.com (Doug Ledford)
Date: Wed, 3 May 2017 12:17:05 -0400
Subject: [PATCH v4, under testing] nvme-rdma: support devices with queue
 size < 32
In-Reply-To: <1493827096.3901.4.camel@sandisk.com>
References: <79901165.5342369.1493805915415.JavaMail.zimbra@kalray.eu>
 <823aa3f0-685f-4569-11d6-238cc4f0b126@grimberg.me>
 <780938034.8003164.1493824767084.JavaMail.zimbra@kalray.eu>
 <20170503155316.GA14334@obsidianresearch.com>
 <1493827096.3901.4.camel@sandisk.com>
Message-ID: <92010426-c898-0a56-e615-bbf6eb1c5e7e@redhat.com>

On 5/3/2017 11:58 AM, Bart Van Assche wrote:
> On Wed, 2017-05-03@09:53 -0600, Jason Gunthorpe wrote:
>> On Wed, May 03, 2017@05:19:27PM +0200, Marta Rybczynska wrote:
>>
>>>> where
>>>> 	queue->sig_limit = max(queue->queue_size / 2, 1);
>>>
>>> I tried to avoid that because this adds a division in the fast path Bart
>>> was unhappy about in v2.
>>
>> The compiler switches divide/multiply by powers of two into fast bit shifts.
> 
> Hello Jason,
> 
> As far as I know the compiler only does that for compile-time constants. In
> this case the divisor (max(queue_size / 2, 1)) is not a compile-time constant.

Sure it is.  The only thing that needs to be constant for the compiler
to do the right thing is the '/ 2' part.  queue_size need not be
constant, and the max is performed after the division.  I would fully
expect the compiler to get this right and convert it internally to the
equivalent bit shift, but if it didn't you could always just write it
that way in the first place:

queue->sig_limit = max(queue->queue_size >> 1, 1);


-- 
Doug Ledford <dledford at redhat.com>
    GPG Key ID: B826A3330E572FDD
    Key fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 884 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20170503/c13ad3ac/attachment-0001.sig>
