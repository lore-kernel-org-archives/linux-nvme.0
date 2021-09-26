Return-Path: <SRS0=vClw=OQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C18FC433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Sep 2021 22:05:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B12861100
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Sep 2021 22:05:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0B12861100
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ccJVYuZGebFTIPQ2tjKZEs/07BV77NQjKREz5OeFPjw=; b=PtXL1VBlbCbFaf8h1DYSKacVUZ
	lHkfH7lQ+8H3T3A+sYMbY328pR9rSFi7jlN40pZ6PKCTbGfV0ovvI8IjM7Jhtaz3qJzaQfMl7kPgN
	owSQK0F8yBD2H6ajHzGmFroNCEneJTqCfvANIxzYb1+9JN4en86b9qmlfcGAii5mYHF7LTOVCn8hV
	KIL+yfP01fzEoTrlfO0k4TYFLrTZTFWS0AOuKnrTKYV0WCAeVZtRxB/5GLrf0oxguQuzTVm8peJDX
	6/mMDUdx0kC1NPK2YDg5wHOZhocX23ko4tUdpidLJnGnLMAOgh44KMxRounWmei3arRs4JWY0mP7P
	Ficn6CBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUcGg-00185r-E3; Sun, 26 Sep 2021 22:05:06 +0000
Received: from mail-ed1-f52.google.com ([209.85.208.52])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUcGS-00185G-QY
 for linux-nvme@lists.infradead.org; Sun, 26 Sep 2021 22:04:54 +0000
Received: by mail-ed1-f52.google.com with SMTP id ee50so60929932edb.13
 for <linux-nvme@lists.infradead.org>; Sun, 26 Sep 2021 15:04:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4DT2MyPQOfWi6Pr3NZyecuQPpN7bAekvzDKni8mdusg=;
 b=wdnXk6ywLtAr2ItThi3OYtKtMvhN7Blwg+MFZ0TU17ivE2Lh1a6f4UBIzM3IpCw2xO
 dr1vEM+wc01YJ1ndnahUqTxgv6+7c1p680xnAaFV9w+9ioKmSeBljpEZbg6LIjnuP5SS
 VpWVLj4kiAlDnltFsm1RrAi9NIW0GdGwn7bC1o71ZTLR+NvsvYnC8ns029x+6NmPOLCk
 jwYAuVBnOfti22SDdeh0kgSzKii4KeFGZ0DRQS1kg8P1CX+Ss5HeX/YT3TYsEqeYI00k
 xaKmRD47DDoSZM35jAqX0DD1LSJmTNPQNiN5lKXnnRWGlGZRmkhjOSR95CY4kKlMcQVF
 gEVA==
X-Gm-Message-State: AOAM532GZEi7FUfUfqzE08HrFA1PbsThtqG4xX5Au8m0mNvjYuLmhuQZ
 nEYIPVr9NakxhSFdFh7eYgc=
X-Google-Smtp-Source: ABdhPJzPVcI9teOq0vmBN156Dq0w4WWWH0Qtr1ImfXz82iN98CHC+ve5E16aQdKcoTMVYVZ/S53V1Q==
X-Received: by 2002:a17:906:25d4:: with SMTP id
 n20mr23935276ejb.399.1632693889401; 
 Sun, 26 Sep 2021 15:04:49 -0700 (PDT)
Received: from [10.100.102.14] (109-186-240-23.bb.netvision.net.il.
 [109.186.240.23])
 by smtp.gmail.com with ESMTPSA id p12sm3307422edt.92.2021.09.26.15.04.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Sep 2021 15:04:48 -0700 (PDT)
Subject: Re: [PATCH 07/12] nvme: Implement In-Band authentication
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-nvme@lists.infradead.org,
 linux-crypto@vger.kernel.org
References: <20210910064322.67705-1-hare@suse.de>
 <20210910064322.67705-8-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <22a5f9bf-5fbc-a0d3-b188-c67706a77600@grimberg.me>
Date: Mon, 27 Sep 2021 01:04:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210910064322.67705-8-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210926_150452_892806_39D2371E 
X-CRM114-Status: GOOD (  15.82  )
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


> +/* Assumes that the controller is in state RESETTING */
> +static void nvme_dhchap_auth_work(struct work_struct *work)
> +{
> +	struct nvme_ctrl *ctrl =
> +		container_of(work, struct nvme_ctrl, dhchap_auth_work);
> +	int ret, q;
> +
> +	nvme_stop_queues(ctrl);

	blk_mq_quiesce_queue(ctrl->admin_q);

> +	/* Authenticate admin queue first */
> +	ret = nvme_auth_negotiate(ctrl, NVME_QID_ANY);
> +	if (ret) {
> +		dev_warn(ctrl->device,
> +			 "qid 0: error %d setting up authentication\n", ret);
> +		goto out;
> +	}
> +	ret = nvme_auth_wait(ctrl, NVME_QID_ANY);
> +	if (ret) {
> +		dev_warn(ctrl->device,
> +			 "qid 0: authentication failed\n");
> +		goto out;
> +	}
> +	dev_info(ctrl->device, "qid 0: authenticated\n");
> +
> +	for (q = 1; q < ctrl->queue_count; q++) {
> +		ret = nvme_auth_negotiate(ctrl, q);
> +		if (ret) {
> +			dev_warn(ctrl->device,
> +				 "qid %d: error %d setting up authentication\n",
> +				 q, ret);
> +			goto out;
> +		}
> +	}
> +out:
> +	/*
> +	 * Failure is a soft-state; credentials remain valid until
> +	 * the controller terminates the connection.
> +	 */
> +	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE))
> +		nvme_start_queues(ctrl);
		blk_mq_unquiesce_queue(ctrl->admin_q);

> +}

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
