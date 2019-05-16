From: james.smart@broadcom.com (James Smart)
Date: Thu, 16 May 2019 09:24:07 -0700
Subject: [PATCH 1/3] nvme: separate out nvme_ctrl_state_name()
In-Reply-To: <20190516083740.95894-2-hare@suse.de>
References: <20190516083740.95894-1-hare@suse.de>
 <20190516083740.95894-2-hare@suse.de>
Message-ID: <69728e55-cbc0-6e2a-730b-51bc2e5b7726@broadcom.com>

On 5/16/2019 1:37 AM, Hannes Reinecke wrote:
> Separate out nvme_ctrl_state_name() to return the controller state
> as a string.
>
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> ---
>   drivers/nvme/host/core.c | 36 +++++++++++++++++++++++-------------
>   drivers/nvme/host/nvme.h |  1 +
>   2 files changed, 24 insertions(+), 13 deletions(-)
>
>

Reviewed-by:? James Smart? <james.smart at broadcom.com>
