From: hare@suse.de (Hannes Reinecke)
Date: Fri, 20 Oct 2017 16:11:15 +0200
Subject: [REPOST PATCH] nvmet: Fix fatal_err_work deadlock
In-Reply-To: <20171020102721.GA20587@infradead.org>
References: <20171019200236.15892-1-jsmart2021@gmail.com>
 <20171020102721.GA20587@infradead.org>
Message-ID: <cde5ef37-4a23-5257-c76a-425ece92b777@suse.de>

On 10/20/2017 12:27 PM, Christoph Hellwig wrote:
> Why can't we just switch to flush_work instead of cancel_work_sync?
> 
> fatal_err_work never requeues itself, although we might need
> protection against queueing more up once we enter nvmet_ctrl_free.
> 
That's actually what I would prefer, too.

Deadlocking when doing to final put on the controller from the
fatal_error queue function is not a nice design.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
