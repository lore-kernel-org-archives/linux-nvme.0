From: hare@suse.de (Hannes Reinecke)
Date: Tue, 30 Apr 2019 09:40:13 +0200
Subject: [PATCH nvme-cli] nvme_fc auto-connect scripts
In-Reply-To: <79a99c17-8f2d-3b44-057a-38c9d9e5c85e@grimberg.me>
References: <20190430064359.24905-1-hare@suse.de>
 <79a99c17-8f2d-3b44-057a-38c9d9e5c85e@grimberg.me>
Message-ID: <bc7f1739-0a3a-4b19-fcca-6852d62268d8@suse.de>

On 4/30/19 9:15 AM, Sagi Grimberg wrote:
> Hannes,
> 
> I added these to the discovery log change stuff, which
> makes nvme-fc-autoconnect service a unified service not just for
> FC. I thought you had a look at the series.

There had been some fixes to it (namely changing it to a 'simple' 
service instead of 'oneshot', and adding an nvmefc-connect.target to 
stop all running instances).
So I've just posted it here for completeness; I've found it rather weird 
sending a patch to a non-merged patchset.
Do feel free to include it in your patchset.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
