Return-Path: <SRS0=vClw=OQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA5DC433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Sep 2021 22:52:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A022D60F9B
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Sep 2021 22:52:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A022D60F9B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nZWBmA18i+kiJSLzEKO1Acpz5GA6x5P157zZVQqxBmM=; b=qHkO6pp/009OWsUvJKAVYC69ql
	xM1spa3Z4XzZSZ6X2uQSw5ehJ70Wjjmp6qxaqVnnDZAc5HY5xHfxMHflNbsZa3b1j9fJX+L7Nzu5P
	oQQ575+OZ2iX6iwJ9JMg3OYJ4Myd/OpBL7Phk0sCojPH9IDJiC3H1jQkLPohPTWYoEyKo+bSKy+ur
	r7Vm0IoaO44VXC2Cdzm9K7hqUZkfenLkejyrER5I66Hcr7eCzLNPFbp9ENqgn2PcRDpDPwmAnjVvR
	7TWicP0HlajTyOlCGZuFwgBwgc+FRwNc4jCzjH1X0CqTKgKMay20yJsiUwz4tegSW15yafgrPoVR6
	zR3yUJGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUd06-001CY2-Q8; Sun, 26 Sep 2021 22:52:02 +0000
Received: from mail-ed1-f47.google.com ([209.85.208.47])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUd03-001CXI-MV
 for linux-nvme@lists.infradead.org; Sun, 26 Sep 2021 22:52:01 +0000
Received: by mail-ed1-f47.google.com with SMTP id dm26so27068128edb.12
 for <linux-nvme@lists.infradead.org>; Sun, 26 Sep 2021 15:51:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=34p6t/Gjm3fHsHlQm7MJAedTKeurhIWFu17O3mHId8o=;
 b=unl6zqMLTlC7kxVtz0uDob59n+/dNjX4LMTfin+E72+DSaZS62PYSkDnRJ/BYzKajX
 R91Oi8hEOhhDLTRwU5XJuNC5wqv7VVunVVj8vWCC9rZHhGc4/Pk8LjBvm5HVn2mb6fv4
 qBeQTcz+vWOYTxrnfb46S/HnjMhNw6KLuYa1FuAVKlqBvkOfpTx4ogvCDw3n8PPGUjfz
 919s+efZEnceYxiMZEw+jMsFbs0b7UmbI0BzH7TCS0UG4EK1EfZIh6NAHQ+pDUWcrPZm
 yXqvfv4BX4zdNZ51OOfr3+d6YiXYUZeECY0nMcJ79aWoqmX5ejd08hAFhRG1GkDfJUG8
 ly/g==
X-Gm-Message-State: AOAM531r6gRzY/bN8qTsGXrq0Ak6agsNyOStppWO5KsAPwwrZwBNQOEQ
 KMI439w11OOx6RzudEK/GJw=
X-Google-Smtp-Source: ABdhPJxu3O7qMNKBhQBLNriFNofjdDaQIjpH+nduCfd7jGYzQIpIgW+ePdCWgwZ0i8oB7SkDa0uKOA==
X-Received: by 2002:a17:906:3745:: with SMTP id
 e5mr23770118ejc.400.1632696718253; 
 Sun, 26 Sep 2021 15:51:58 -0700 (PDT)
Received: from [10.100.102.14] (109-186-240-23.bb.netvision.net.il.
 [109.186.240.23])
 by smtp.gmail.com with ESMTPSA id n25sm9626871eda.95.2021.09.26.15.51.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Sep 2021 15:51:57 -0700 (PDT)
Subject: Re: [PATCH 10/12] nvmet: Implement basic In-Band Authentication
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-nvme@lists.infradead.org,
 linux-crypto@vger.kernel.org
References: <20210910064322.67705-1-hare@suse.de>
 <20210910064322.67705-11-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <79742bd7-a41c-0abc-e7de-8d222b146d02@grimberg.me>
Date: Mon, 27 Sep 2021 01:51:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210910064322.67705-11-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210926_155159_796779_45B7A6E7 
X-CRM114-Status: GOOD (  17.64  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> +void nvmet_execute_auth_send(struct nvmet_req *req)
> +{
> +	struct nvmet_ctrl *ctrl = req->sq->ctrl;
> +	struct nvmf_auth_dhchap_success2_data *data;
> +	void *d;
> +	u32 tl;
> +	u16 status = 0;
> +
> +	if (req->cmd->auth_send.secp != NVME_AUTH_DHCHAP_PROTOCOL_IDENTIFIER) {
> +		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
> +		req->error_loc =
> +			offsetof(struct nvmf_auth_send_command, secp);
> +		goto done;
> +	}
> +	if (req->cmd->auth_send.spsp0 != 0x01) {
> +		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
> +		req->error_loc =
> +			offsetof(struct nvmf_auth_send_command, spsp0);
> +		goto done;
> +	}
> +	if (req->cmd->auth_send.spsp1 != 0x01) {
> +		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
> +		req->error_loc =
> +			offsetof(struct nvmf_auth_send_command, spsp1);
> +		goto done;
> +	}
> +	tl = le32_to_cpu(req->cmd->auth_send.tl);
> +	if (!tl) {
> +		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
> +		req->error_loc =
> +			offsetof(struct nvmf_auth_send_command, tl);
> +		goto done;
> +	}
> +	if (!nvmet_check_transfer_len(req, tl)) {
> +		pr_debug("%s: transfer length mismatch (%u)\n", __func__, tl);
> +		return;
> +	}
> +
> +	d = kmalloc(tl, GFP_KERNEL);
> +	if (!d) {
> +		status = NVME_SC_INTERNAL;
> +		goto done;
> +	}
> +
> +	status = nvmet_copy_from_sgl(req, 0, d, tl);
> +	if (status) {
> +		kfree(d);
> +		goto done;
> +	}
> +
> +	data = d;
> +	pr_debug("%s: ctrl %d qid %d type %d id %d step %x\n", __func__,
> +		 ctrl->cntlid, req->sq->qid, data->auth_type, data->auth_id,
> +		 req->sq->dhchap_step);
> +	if (data->auth_type != NVME_AUTH_COMMON_MESSAGES &&
> +	    data->auth_type != NVME_AUTH_DHCHAP_MESSAGES)
> +		goto done_failure1;
> +	if (data->auth_type == NVME_AUTH_COMMON_MESSAGES) {
> +		if (data->auth_id == NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE) {
> +			/* Restart negotiation */
> +			pr_debug("%s: ctrl %d qid %d reset negotiation\n", __func__,
> +				 ctrl->cntlid, req->sq->qid);

This is the point where you need to reset also auth config as this may
have changed and the host will not create a new controller but rather
re-authenticate on the existing controller.

i.e.

+                       if (!req->sq->qid) {
+                               nvmet_destroy_auth(ctrl);
+                               if (nvmet_setup_auth(ctrl) < 0) {
+                                       pr_err("Failed to setup 
re-authentication\n");
+                                       goto done_failure1;
+                               }
+                       }



> +			req->sq->dhchap_step = NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE;
> +		} else if (data->auth_id != req->sq->dhchap_step)
> +			goto done_failure1;
> +		/* Validate negotiation parameters */
> +		status = nvmet_auth_negotiate(req, d);/

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
