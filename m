From: hare@suse.de (Hannes Reinecke)
Date: Thu, 1 Jun 2017 08:59:52 +0200
Subject: [PATCH v1 7/7] nvmet: allow overriding the NVMe VS via configfs
In-Reply-To: <20170601065255.GG16778@lst.de>
References: <cover.1496237370.git.jthumshirn@suse.de>
 <d7170a45381be21b7d0da629406a063db62aaa42.1496237370.git.jthumshirn@suse.de>
 <20170601065255.GG16778@lst.de>
Message-ID: <0af0f525-918d-d2b3-2f08-f4f19c83fab1@suse.de>

On 06/01/2017 08:52 AM, Christoph Hellwig wrote:
> On Wed, May 31, 2017@03:32:17PM +0200, Johannes Thumshirn wrote:
>> Allow overriding the announced NVMe Version of a via configfs.
>>
>> This is particularly helpful when debugging new features for the host
>> or target side without bumping the hard coded version (as the target
>> might not be fully compliant to the announced version yet).
> 
> It is.  Just bump to 1.3, please as Identify 3h is the only mandatory
> change: http://nvmexpress.org/changes/
> 
Actually, I still do like this.
With it it'll be very easy to test version compliance; and validate our
initiator behaviour against older versions.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
