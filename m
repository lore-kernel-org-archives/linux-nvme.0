Return-Path: <SRS0=nD3g=I4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288FBC433C1
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 04:13:06 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA3B861985
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 04:13:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA3B861985
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Us87ZDT6Ng+Hu+a2osoFUBpAg4WJu+L2vdHc0mOk+6c=; b=OckaHiLUrFgnEupk1KzVVH7ko
	lTkEeQ2HHv5E15MRB79OVXgjnbHIZvehJvZ5/uHuR47TToH70+QG/UgcNI32wogU50am/C+IWeHZ/
	W1qMEYXuaBvxQFheReEvCTl2sYM9V73bH5RJsOq1aA0OfGHhPKm+JeHvyvBgObGjRnkdTYrWst5CU
	gTcnklc6WsfArsMcnaL3aPTglJSSSwJoopKghqij6wOv1fj75QOSswSHsCi7QUmyZXv8uxsx7yw9E
	qjdQDDX9QW9E+lzTR8wvW2f29r+//wZ149MGF04G92RTTdtv6ql+XiOUEubpiiuKkHj/EBgrWepNh
	t72BeniPw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lR5kA-002evK-Ci; Tue, 30 Mar 2021 04:12:43 +0000
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lR5k1-002eua-Ep
 for linux-nvme@lists.infradead.org; Tue, 30 Mar 2021 04:12:35 +0000
Received: by mail-pf1-x435.google.com with SMTP id 11so11246763pfn.9
 for <linux-nvme@lists.infradead.org>; Mon, 29 Mar 2021 21:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/rHZ6uwpSk0AjO997UoQPXtNepHpJWZyQrwYQ5vWHpY=;
 b=IXSgyX0VQa5zL0XdmRDuVePVvIWs8uKYZQnuy85XDyb2GoQDbwkkR0oA1CeCVCthKQ
 8aAMCIGd2mYs5aXLvAZI0JhEOv/Opb8FSHbaCE2TXFFMWyrSlz5rT7ZzHNu1YKqQdT+A
 jVPUzOzdPUgGYpkxBDfAHpkkl/BmoSEEbZkbqk9tDEs77bqUL/c+ftHiVealNBvr51i8
 FYuEnz9wVxz+m0hLtg/1OFOhz4Z8xQTmXY0YLev2S4WESZhwfzVQ0Bl+lk1/jbHjAkLS
 Xk40QIcxFfkw5294DYQQdFgc3nyYUkMQDyCrTsfBeiIcNaqtXUELHUhyBxSPbiDlRXlX
 +4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/rHZ6uwpSk0AjO997UoQPXtNepHpJWZyQrwYQ5vWHpY=;
 b=H4W6NYUh7bJo+8P/y4FfuRqL5/CoDu8m7PpO0zC5HUNlnSdiN8BIxAFDOjCo69fW6H
 O05V3KGvie5FGiK7jSrRnO/dNrWfoWsS8ilS5OM0+bwVR/7aqHPKWDThf/EW8f4LtquN
 dr5ojyBEid92iVImxwu2lfP+Xm+s7kEon1ID/t0T7MEDCa+eHS++vXy+71wXL0goBbQ8
 ga5nS73k9M5earyhvwNdbFNghaymrdPM2joUe/FCQbz9Nt81YhzwdQLdYmClusz3RgyW
 IEBMv/V+umfocfJbdP88FwtZR4vMwC2XPJ5VvPzi1iIeCZSZzDtGqZm/D2yqsUf7r1OW
 OGtg==
X-Gm-Message-State: AOAM530KNsE0ZcycN0P3RHbBkTeDL0jp6rxU/+LHmO1jgc+7cjMoo5im
 r+ys642qV5aD6bixZ8Kt8xE=
X-Google-Smtp-Source: ABdhPJywugv6+zts8SGNW9uZP/BScoUOFdWcH3vD1KGyN0AYEp6DULrLoBv0wnulIQH0DZ/b1t89dw==
X-Received: by 2002:a63:f70f:: with SMTP id x15mr26095355pgh.109.1617077551529; 
 Mon, 29 Mar 2021 21:12:31 -0700 (PDT)
Received: from houpudeMacBook-Pro.local.net ([61.120.150.74])
 by smtp.gmail.com with ESMTPSA id v1sm1262376pjt.1.2021.03.29.21.12.28
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Mar 2021 21:12:31 -0700 (PDT)
From: Hou Pu <houpu.main@gmail.com>
To: elad.grupi@dell.com
Cc: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	houpu.main@gmail.com
Subject: Re: [PATCH v3] nvmet-tcp: fix a segmentation fault during io parsing
 error
Date: Tue, 30 Mar 2021 12:12:19 +0800
Message-Id: <20210330041219.3069-1-houpu.main@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20210329180125.3977-1-elad.grupi@dell.com>
References: <20210329180125.3977-1-elad.grupi@dell.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210330_051233_992761_40C3A43B 
X-CRM114-Status: GOOD (  17.02  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Date: Mon, 29 Mar 2021 21:01:25 +0300, Elad Grupi wrote:
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 70cc507d1565..41102fc09595 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -525,11 +525,34 @@ static void nvmet_tcp_queue_response(struct nvmet_req *req)
>  	struct nvmet_tcp_cmd *cmd =
>  		container_of(req, struct nvmet_tcp_cmd, req);
>  	struct nvmet_tcp_queue	*queue = cmd->queue;
> +	struct nvme_sgl_desc *sgl;
> +	u32 len;
> +
> +	if (unlikely(cmd == queue->cmd)) {
> +		sgl = &cmd->req.cmd->common.dptr.sgl;
> +		len = le32_to_cpu(sgl->length);
> +
> +		/*
> +		 * Wait for inline data before processing the response.
> +		 * Avoid using helpers, this might happen before
> +		 * nvmet_req_init is completed.
> +		 */
> +		if (len && cmd->rcv_state == NVMET_TCP_RECV_PDU)
> +			return;

Is it queue->rcv_state ?
I tried this patch, the identify command could get here. And nvme connect could hang.
We need to figure out a way to tell if it needs abort queue the request. Or maybe we
could use the v2 version.

Thanks,
Hou


> +	}
 
>  	llist_add(&cmd->lentry, &queue->resp_list);
>  	queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &cmd->queue->io_work);
>  }

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
