From: hare@suse.de (Hannes Reinecke)
Date: Tue, 17 Jul 2018 15:42:06 +0200
Subject: Q: Status of ANA patches
In-Reply-To: <20180629120303.GA22270@lst.de>
References: <0426d517-4c6e-022d-5d42-d1f22053ed1a@suse.de>
 <20180629120303.GA22270@lst.de>
Message-ID: <01b035fe-72cb-72c8-daa4-00d416815550@suse.de>

On 06/29/2018 02:03 PM, Christoph Hellwig wrote:
> On Fri, Jun 29, 2018@01:42:49PM +0200, Hannes Reinecke wrote:
>> Hi Christoph,
>>
>> do you have any timeline for the ANA patches?
>> From my last testing they look good so far; the only missing bit is a 
>> missing configfs entry for the actual ANATT value.
>> For that we could easily resurrect my original patch.
>>
>> Is there anything else which is holding it up?
> 
> An automated test suite to actually test the code reliably is the
> important missing bit.
> 
So, just submitted a blktest to check the basic functionality via
nvme-loop, including path failover.

And send some fixes for issues found during development of the said test :-)

If you can think of anything else which should be tested please let me
know, I'm happy to write up a testcase for that.

But what's next, then?
Will you fold the patches into the main patchset?
Or should they be kept separate?
Should I be doing it (if you are too busy)?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
