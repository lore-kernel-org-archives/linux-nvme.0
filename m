Return-Path: <SRS0=ldP/=42=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72676C10F25
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Mar 2020 21:59:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 459FD2253D
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Mar 2020 21:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DKlFUt/n";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="J5pAjl2u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 459FD2253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tDjL5EI/msz2yfcwNDwL8t1qhwWSYytWQrYuwCUP7ns=; b=DKlFUt/nNyga1jXFh6MelcYsS
	eBLayhb0RI3l3IhFtTCKJzV/5hxAM3ir9eEQRvfISO18VrlNiU07AEJ0X0qIDCc5UP2mzItHncLET
	fVU+5UbWfNUQORDB9ls4ha2iCfB01CFiJcmEfW1nLevM423Ta/3TJG6IzL9sG7/wQU+v5A1wWTr9Y
	XE1yUita3chVQdiSAKeDXIPmUD43xNZdVcDIHJ4rLp261R/m9LFHCgKSSokEeC4uJ497TJ9FDKfON
	u1V15xivTbaidrUVgGHF+kQRtO+WaOjGw8Iyu6jflaEvJtLwaO+8jATOhPSxszn6Yy2HPTuhqTnke
	C2zoxJRfw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jBQR5-0005vE-BV; Mon, 09 Mar 2020 21:59:43 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jBQR2-0005up-D6
 for linux-nvme@lists.infradead.org; Mon, 09 Mar 2020 21:59:41 +0000
Received: by mail-pl1-x641.google.com with SMTP id g6so4565557plt.2
 for <linux-nvme@lists.infradead.org>; Mon, 09 Mar 2020 14:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=uFw+h8JyWISfjE1DZLY1A1MMpJ9JwzFyFsQQLQT6ct0=;
 b=J5pAjl2uZU9lJDoR2X+RO8l+kyQLZ1JUyt4l5XTUtrQfPt34fHcInxH2reNV9DpVF7
 +IC8cqg2iUjYZvWPVmDK3W+0jea6rNETd6rtCgTiN6DSzfmy8lxqBh/AEawfF+PWsBps
 pCAjn8hHcNmrNsdsZvvY2HN8L/TOILYy1p5AE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=uFw+h8JyWISfjE1DZLY1A1MMpJ9JwzFyFsQQLQT6ct0=;
 b=CfCkotZ65YEoAtDzAP9Pml6IftTP3BP4ciPZCV2l5ReUQSiTMo0C7+3yyR+MRplUT+
 LDnOoiMvOjzXQE/ZM3kCcFdvaecEy9HVO0RpYcNUyfbHE+eTY9qa9mVCtXIUWXu5SNz+
 0k9cTPzdIel49tYXwlRkrwCfGhG30hFUS1c3pzw9hEO9M+fCfDCGLOfA+quRAVV0Lo9m
 FT8ZgIllrSX5bZoopo67uLu62u69LsqLSfu7l+Gi9rHYqSjyNjM8qc8KOcoWeKqyMAgp
 YrEjFfbSQEPTR4GnBPCqJdAbFkMCK830HlaDQL2Tb1xjrdYHHW/dsWHw542Y+AQ0fEhu
 e3fA==
X-Gm-Message-State: ANhLgQ1+w+x/BUeHy3XzDus8lGyPWQE2qzNArCRPEjz/WDuc+vU/mPa+
 bm+Mu2CC/DPLU7K/r20UOzq2VUrhV8YL9/FskE+FgVOarfoVE0jwpZDEx0Hz80H+rxgB/OxwZjN
 ab7xl+Qb2rWYipCvp2QCCGWyjMb4oWrJFAs63yLtSRzZbeheSvtphpV9PutIYP1Qm/VehWuzBNj
 AUSrfzxQ==
X-Google-Smtp-Source: ADFU+vt/D1y/11+W8T+sv3J8kGR2UzFTyJhDgKbPgjk89siH4na11bCRdS1k+2Jjnv5pwY/NoUaI2w==
X-Received: by 2002:a17:90b:3582:: with SMTP id
 mm2mr1472434pjb.17.1583791178042; 
 Mon, 09 Mar 2020 14:59:38 -0700 (PDT)
Received: from [10.69.45.46] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id b3sm482998pjo.30.2020.03.09.14.59.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2020 14:59:37 -0700 (PDT)
Subject: Re: [PATCH RFC] nvme/fc: sq flow control
To: Hannes Reinecke <hare@suse.de>, Keith Busch <keith.busch@wdc.com>
References: <20200225235956.28475-1-hare@suse.de>
From: James Smart <james.smart@broadcom.com>
Message-ID: <f3d3dc5e-f7d0-b33a-db59-c303a57d343a@broadcom.com>
Date: Mon, 9 Mar 2020 14:59:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200225235956.28475-1-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200309_145940_447817_4C2BCCE0 
X-CRM114-Status: GOOD (  21.56  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 John Meneghini <john.meneghini@netapp.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2/25/2020 3:59 PM, Hannes Reinecke wrote:
> As per NVMe-oF spec sq flow control is actually mandatory, and we should
> be implementing it to avoid the controller to return a fatal status
> error, and try to play nicely with controllers using sq flow control
> to implement QoS.
>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/fc.c | 29 ++++++++++++++++++++++++++++-
>   1 file changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index a19ddb61039d..628397bd5065 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -12,6 +12,7 @@
>   
>   #include "nvme.h"
>   #include "fabrics.h"
> +#include "trace.h"
>   #include <linux/nvme-fc-driver.h>
>   #include <linux/nvme-fc.h>
>   #include <scsi/scsi_transport_fc.h>
> @@ -34,7 +35,8 @@ struct nvme_fc_queue {
>   	size_t			cmnd_capsule_len;
>   	u32			qnum;
>   	u32			seqno;
> -
> +	int			sq_head;
> +	int			sq_tail;
>   	u64			connection_id;
>   	atomic_t		csn;
>   
> @@ -1671,6 +1673,8 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
>   				cqe->command_id);
>   			goto done;
>   		}
> +		WRITE_ONCE(queue->sq_head, cpu_to_le16(cqe->sq_head));
> +		trace_nvme_sq(rq, cqe->sq_head, queue->sq_tail);
>   		result = cqe->result;
>   		status = cqe->status;
>   		break;
> @@ -2177,6 +2181,18 @@ nvme_fc_unmap_data(struct nvme_fc_ctrl *ctrl, struct request *rq,
>   	freq->sg_cnt = 0;
>   }
>   
> +static int nvme_fc_update_sq_tail(struct nvme_fc_queue *queue, int incr)
> +{
> +	int old_sqtl, new_sqtl;
> +
> +	do {
> +		old_sqtl = queue->sq_tail;
> +		new_sqtl = (old_sqtl + incr) % queue->ctrl->ctrl.sqsize;
> +	} while (cmpxchg(&queue->sq_tail, old_sqtl, new_sqtl) !=
> +		 old_sqtl);
> +	return new_sqtl;
> +}
> +
>   /*
>    * In FC, the queue is a logical thing. At transport connect, the target
>    * creates its "queue" and returns a handle that is to be given to the
> @@ -2219,6 +2235,14 @@ nvme_fc_start_fcp_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
>   	if (!nvme_fc_ctrl_get(ctrl))
>   		return BLK_STS_IOERR;
>   
> +	if (!ctrl->ctrl.opts->disable_sqflow) {
> +		if (nvme_fc_update_sq_tail(queue, 1) ==
> +		    READ_ONCE(queue->sq_head)) {
> +			nvme_fc_update_sq_tail(queue, -1);
> +			return BLK_STS_RESOURCE;
> +		}
> +	}
> +
>   	/* format the FC-NVME CMD IU and fcp_req */
>   	cmdiu->connection_id = cpu_to_be64(queue->connection_id);
>   	cmdiu->data_len = cpu_to_be32(data_len);
> @@ -2284,6 +2308,9 @@ nvme_fc_start_fcp_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
>   					queue->lldd_handle, &op->fcp_req);
>   
>   	if (ret) {
> +		if (ctrl->ctrl.opts->disable_sqflow)
> +			nvme_fc_update_sq_tail(queue, -1);
> +
>   		/*
>   		 * If the lld fails to send the command is there an issue with
>   		 * the csn value?  If the command that fails is the Connect,

fyi - I NAK'd this patch mainly as it wasn't ordering ERSP's before 
processing SQHD.

-- james


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
