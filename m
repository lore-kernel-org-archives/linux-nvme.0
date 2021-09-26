Return-Path: <SRS0=vClw=OQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E96C433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Sep 2021 22:54:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAAE160F9B
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Sep 2021 22:54:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BAAE160F9B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+o9uw2BgDtjsQsWCYq7YdJldRDyBFrXY9Z9QwEw7skU=; b=5F/Qox5wKAYx9oLAZsuRbRLG7S
	/LqM7asGgVO5mWlMLvOjNzN9ol4dv5kDnxcW51vsfNP54cBOdCbd9jmWQ3P0UJ7L2GG+L2nLt/qrA
	IVeYOVT/EonyagHigM7t1FKZ5wp37zOeB01K68tZ8UsfHbXhwktzCC69ED83nDzmBV3xBLcgOKnjf
	GkomwCw9SivEc/5xlsmnCiRp05l9VAJ87Jn8oG7yrF8xP/KUSKYYgaKbyVtbKg3cCmOBNnelpgo8+
	/6hgFyyzc5TyCRhG166parjNJmaBMv2CdGFXVv5qW2LqquO9PrNwk83/9m+GrN46NRsbdci+UY+x4
	WqX8Q9kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUd1r-001CfJ-Kx; Sun, 26 Sep 2021 22:53:51 +0000
Received: from mail-ed1-f54.google.com ([209.85.208.54])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUd1o-001CeQ-MV
 for linux-nvme@lists.infradead.org; Sun, 26 Sep 2021 22:53:49 +0000
Received: by mail-ed1-f54.google.com with SMTP id v18so25996228edc.11
 for <linux-nvme@lists.infradead.org>; Sun, 26 Sep 2021 15:53:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pBbbO+PVbgUmH26Rm8/4mkCm4rE5mxxrVZIdsIun8bA=;
 b=R/q1Wx/w0OWCya6K774l6EgKhbypJMkS+IrDPIs0oj/BxljKPYzCDxE46TJymkQSZ1
 Af4sIxhu6ga//De1XumdbPCsjoksWt2O+lq4nB4uALJPykynTv7hYQwW2DCkg7c6e60d
 EWx20z4B4nzZS+/hlwLtehj9zlnz7hFbz7R4B86DBA8AQ4AzvZ1/NxxmvigdWyZ29stf
 gN69CqHoNOfRmRa4uz+Czd0Xgo/oMItnGMmlvLRtFN/l4lSriHYNS/7noXyf/BzZcq71
 LCBjncKqlo0uSsBLh8k8jQ84OVpk81ed60EKMBiirjKnFToD6K/AHrDficSBQFmMC57m
 15nw==
X-Gm-Message-State: AOAM533f1BubrbI4OyiQpf9nQQemJh9LHLic6ob/Ktj77BUxgyKv6Gms
 Dl8NpysoUB3hec1FOTBoUAv788YvB5g=
X-Google-Smtp-Source: ABdhPJzPRIwybTbcRRSdXa5IxMGckx6qNFyi83EHavtg1wDwLbN7olIyuva0yKX0u5XRoIDpxslBlA==
X-Received: by 2002:aa7:c2d3:: with SMTP id m19mr2270943edp.267.1632696827220; 
 Sun, 26 Sep 2021 15:53:47 -0700 (PDT)
Received: from [10.100.102.14] (109-186-240-23.bb.netvision.net.il.
 [109.186.240.23])
 by smtp.gmail.com with ESMTPSA id o3sm2262188eji.108.2021.09.26.15.53.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Sep 2021 15:53:46 -0700 (PDT)
Subject: Re: [PATCH 07/12] nvme: Implement In-Band authentication
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-nvme@lists.infradead.org,
 linux-crypto@vger.kernel.org
References: <20210910064322.67705-1-hare@suse.de>
 <20210910064322.67705-8-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <745c58b2-e508-25c0-f094-8d24af0631ed@grimberg.me>
Date: Mon, 27 Sep 2021 01:53:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210910064322.67705-8-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210926_155348_774117_5571327A 
X-CRM114-Status: GOOD (  11.91  )
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

Here I would print a single:
	dev_info(ctrl->device, "re-authenticating controller");

This is instead of all the queue re-authentication prints that
should be dev_dbg.

Let's avoid doing the per-queue print...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
