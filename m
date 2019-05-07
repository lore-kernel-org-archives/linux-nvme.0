From: hare@suse.de (Hannes Reinecke)
Date: Tue, 7 May 2019 09:11:17 +0200
Subject: [PATCH nvme-cli rfc 2/5] fabrics: support persistent connections
 to a discovery controller
In-Reply-To: <20190504000456.3888-3-jsmart2021@gmail.com>
References: <20190504000456.3888-1-jsmart2021@gmail.com>
 <20190504000456.3888-3-jsmart2021@gmail.com>
Message-ID: <7cc06c7a-530d-3807-7f31-f324df733ae8@suse.de>

On 5/4/19 2:04 AM, James Smart wrote:
> From: Sagi Grimberg <sagi at grimberg.me>
> 
> Simply don't destroy the discovery controller after getting the
> log pages. Note that persistent connection to a discovery subsystem
> require to pass in a non-zero kato value, so if not provided we
> simply use a default of 30 seconds kato.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
