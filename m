From: hare@suse.de (Hannes Reinecke)
Date: Fri, 10 Nov 2017 13:21:54 +0100
Subject: [PATCH 1/2] nvme: add Kconfig option 'NVME_MULTIPATH_DEFAULT'
In-Reply-To: <20171110111357.GA7837@lst.de>
References: <1510307903-3346-1-git-send-email-hare@suse.de>
 <1510307903-3346-2-git-send-email-hare@suse.de>
 <20171110111357.GA7837@lst.de>
Message-ID: <b7cb0745-cb0b-099c-e1e8-25e7a5209129@suse.de>

On 11/10/2017 12:13 PM, Christoph Hellwig wrote:
> On Fri, Nov 10, 2017@10:58:22AM +0100, Hannes Reinecke wrote:
>> Add a configuration option to enable or disable NVMe multipath
>> per default.
> 
> NAK.  If you really want a local override please keep this as a local
> patch.
> 
Well, I had to try :-)
But keeping a distro-specific patch (if the need arises) is fine by me.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
