From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 5 Oct 2016 20:38:05 +0300
Subject: [PATCH v2 6/7] SRP transport: Port srp_wait_for_queuecommand() to
 scsi-mq
In-Reply-To: <bedf4b45-00b0-6844-047d-f1e05bb1092f@sandisk.com>
References: <f153ee47-e599-c333-92b0-d5da475012f3@sandisk.com>
 <bedf4b45-00b0-6844-047d-f1e05bb1092f@sandisk.com>
Message-ID: <8ce2910d-fde0-724f-a61f-8fbd7fbf499d@grimberg.me>


> +static void srp_mq_wait_for_queuecommand(struct Scsi_Host *shost)
> +{
> +	struct scsi_device *sdev;
> +	struct request_queue *q;
> +
> +	shost_for_each_device(sdev, shost) {
> +		q = sdev->request_queue;
> +
> +		blk_mq_quiesce_queue(q);
> +		blk_mq_resume_queue(q);
> +	}
> +}
> +

This *should* live in scsi_lib.c. I suspect that
various drivers would really want this functionality.

Thoughts?
