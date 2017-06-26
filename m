From: adilger@dilger.ca (Andreas Dilger)
Date: Mon, 26 Jun 2017 13:36:59 -0600
Subject: [PATCH 9/9] nvme: add support for streams and directives
In-Reply-To: <d2dcae41-d0b2-71a7-a63d-b7ef25ae47d2@kernel.dk>
References: <1498004526-4543-1-git-send-email-axboe@kernel.dk>
 <1498004526-4543-10-git-send-email-axboe@kernel.dk>
 <20170626095907.GG14057@infradead.org>
 <d2dcae41-d0b2-71a7-a63d-b7ef25ae47d2@kernel.dk>
Message-ID: <7A48D12A-E656-4FC8-9D03-1BC482B8AE34@dilger.ca>

On Jun 26, 2017,@7:56 AM, Jens Axboe <axboe@kernel.dk> wrote:
> 
> On 06/26/2017 03:59 AM, Christoph Hellwig wrote:
>> Looks mostly good,
>> 
>> but two nit-picks:
>> 
>> - can we keep a module option to disable streams, or in fact for
>>   now maybe to explicitly enable it?  I expect this to be interesting
>>   at least for the first devices that implement it.  Also given that
>>   it needs to be explicitly enabled I would expect some overhead of
>>   just enabling it when never used
> 
> Fine with me, I can add the 'streams' parameter back, but just default
> it to false.

Better would be a parameter to set the default streams count, 0 by default.

>> - do we even need the < 4 streams fallback now that they are global
>>   instead of per-ns instead of just disabling the feature for now?
> 
> Maybe the device only supports 2? or 3?
> 
> --
> Jens Axboe
> 


Cheers, Andreas





-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 195 bytes
Desc: Message signed with OpenPGP
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20170626/c71128c1/attachment.sig>
