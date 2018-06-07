From: hch@lst.de (Christoph Hellwig)
Date: Thu, 7 Jun 2018 15:06:38 +0200
Subject: draft ANA support v3
In-Reply-To: <045315fe-e548-086c-fd02-ec17f395bbc3@grimberg.me>
References: <20180606143311.23076-1-hch@lst.de>
 <045315fe-e548-086c-fd02-ec17f395bbc3@grimberg.me>
Message-ID: <20180607130638.GB13101@lst.de>

On Thu, Jun 07, 2018@03:34:30PM +0300, Sagi Grimberg wrote:
>> Changes since v2:
>>   - support changing the state for the default ANA group
>>   - drop ANATT configuration again
>>   - delay gendisk registration until we have an I/O capable path
>>   - remove nvme_req_needs_failover and the SCT=3 handling in it,
>>     we actually do the right thing without it
>>   - refactor the get log page helpers
>
> Wish you had accumulated review tags for this one...

I've picked them up now.  But the patches are still undergoing
non-trivial changes, so I will probably drop them at least for
some patches again.
