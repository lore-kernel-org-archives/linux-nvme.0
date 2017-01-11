From: hare@suse.de (Hannes Reinecke)
Date: Wed, 11 Jan 2017 10:40:41 +0100
Subject: [LFS/MM TOPIC][LFS/MM ATTEND]: - Storage Stack and Driver Testing
 methodology.
In-Reply-To: <20170111092447.GA13600@infradead.org>
References: <CO2PR04MB218427BF42159B20FB26F74186670@CO2PR04MB2184.namprd04.prod.outlook.com>
 <CO2PR04MB2184DB653C04FB620B41435486670@CO2PR04MB2184.namprd04.prod.outlook.com>
 <20170111091945.GD6286@linux-x5ow.site>
 <20170111092447.GA13600@infradead.org>
Message-ID: <0ac6509a-738b-e1f4-871c-13fd62cf9cca@suse.de>

On 01/11/2017 10:24 AM, Christoph Hellwig wrote:
> On Wed, Jan 11, 2017@10:19:45AM +0100, Johannes Thumshirn wrote:
>> Well, something I was thinking about but didn't find enough time to actually
>> implement is making a xfstestes like test suite written using sg3_utils for
>> SCSI.
> 
> Ronnie's libiscsi testsuite can use SG_IO for a new years now:
> 
> https://github.com/sahlberg/libiscsi/tree/master/test-tool
> 
> and has been very useful to find bus in various protocol
> implementations.
> 
>> This idea could very well be extented to NVMe
> 
> Chaitanya suite is doing something similar for NVMe, although the
> coverage is still much more limited so far.
> 
One of the discussion points here indeed would be if we want to go in
the direction of a protocol-specific testsuites (of which we already
have several) or if it makes sense to move to functional testing.

And if we can have a common interface / documentation on how these
things should run.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
