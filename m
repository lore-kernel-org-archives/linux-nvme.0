From: james.smart@broadcom.com (James Smart)
Date: Tue, 21 May 2019 09:18:46 -0700
Subject: [PATCH 3/4] nvme-fc: fail reconnect if state change fails
In-Reply-To: <20190520063624.50338-4-hare@suse.de>
References: <20190520063624.50338-1-hare@suse.de>
 <20190520063624.50338-4-hare@suse.de>
Message-ID: <2a186bc0-132a-d9ac-b98c-7f5cb2e5c548@broadcom.com>


On 5/19/2019 11:36 PM, Hannes Reinecke wrote:
> If the final state change to LIVE in nvme_fc_create_association()
> fails the controller is not operational as no I/O is possible.
> So we should be returning an error here to reschedule reconnect.
> Additionally it should only be called while in CONNECTING state, so
> add a check for this, too.
>
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> ---

Reviewed-by:?? James Smart?? <james.smart at broadcom.com>
