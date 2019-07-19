From: hare@suse.de (Hannes Reinecke)
Date: Fri, 19 Jul 2019 15:49:52 +0200
Subject: [PATCH v2 3/3] nvme: fire discovery log page change events to
 userspace
In-Reply-To: <20190712180211.26333-4-sagi@grimberg.me>
References: <20190712180211.26333-1-sagi@grimberg.me>
 <20190712180211.26333-4-sagi@grimberg.me>
Message-ID: <818a1212-ea35-7675-27e1-40627316824c@suse.de>

On 7/12/19 8:02 PM, Sagi Grimberg wrote:
> Provide userspace with nvme discovery controller device instance,
> controller traddr and trsvcid. We'd expect userspace to handle
> this event by issuing a discovery + connect.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>   drivers/nvme/host/core.c | 30 +++++++++++++++++++++++++++++-
>   1 file changed, 29 insertions(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare at suse.de                              +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
