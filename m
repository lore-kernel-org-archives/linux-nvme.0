From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Sun, 3 Jan 2016 18:54:13 +0200
Subject: [PATCHv2 2/5] NVMe: Use a retryable error code on reset
In-Reply-To: <1451580116-12252-3-git-send-email-keith.busch@intel.com>
References: <1451580116-12252-1-git-send-email-keith.busch@intel.com>
 <1451580116-12252-3-git-send-email-keith.busch@intel.com>
Message-ID: <56895235.1060708@dev.mellanox.co.il>

> The negative status has the "do not retry" bit set, which makes it not
> retryable. Use a fake status that can potentially be retried on reset.
>
> An aborted command's status is still overridden by the timeout handler
> with the CANCELLED status, which is needed for initialization to
> distinguish an unresponsive controller.
>
> Signed-off-by: Keith Busch <keith.busch at intel.com>

Reviewed-by: Sagi Grimberg <sagig at mellanox.com>
