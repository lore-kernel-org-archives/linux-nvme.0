From: james.smart@broadcom.com (James Smart)
Date: Thu, 16 May 2019 09:24:12 -0700
Subject: [PATCH 2/3] nvme-fc: track state change failures during reconnect
In-Reply-To: <20190516083740.95894-3-hare@suse.de>
References: <20190516083740.95894-1-hare@suse.de>
 <20190516083740.95894-3-hare@suse.de>
Message-ID: <491d8e0b-23f1-0a94-4030-2fbf45f4b2bd@broadcom.com>



On 5/16/2019 1:37 AM, Hannes Reinecke wrote:
> The nvme-fc driver has several situation under which an expected
> state transition fails, but doesn't print out any messages if
> this happens.
> The patch adds logging for these situations.
>
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> ---
>   drivers/nvme/host/fc.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
>
>

Reviewed-by:? James Smart?? <james.smart at broadcom.com>
