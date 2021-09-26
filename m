Return-Path: <SRS0=vClw=OQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A3EC433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Sep 2021 14:31:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A278C61090
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Sep 2021 14:31:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A278C61090
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fksaQZ4Ulupy0qtY2NT3UOyt9CqXZBhFw1naAgmtHDg=; b=gR2F5bK1upkQtlnE+z/QdvuBxC
	9+fHyIgA2YJ8ghzq7g71f8Tb/Z3H5EVm3fUsZAylZ3G7WZm5Co21qtYS2llKD30Pkbg8QgUP7Xe+m
	gRMySPkohJ913IM1Tz7+Avc709Rf5/JJFos1p4mY8rqcgvpuPUiv99vNj8RpPun8T1liGUMiLYSL7
	OCUUFHBHbf+HGxDr4Pho92gtyvO2PL1ztdcJoQG8l1PWYhAVo+T7Z5e6FS4acttngTgj8CjTwEGth
	lR21AjBR/USC38PHWyD2PXJ6FLXT/xMG5AfTYYjG9/Y/NpG1b8DnPysGPyeYeN/xYwCk1yGRUksJo
	q6VAJCYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUVBA-000hnn-My; Sun, 26 Sep 2021 14:30:56 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUVB7-000hnN-LC
 for linux-nvme@lists.infradead.org; Sun, 26 Sep 2021 14:30:55 +0000
Received: by mail-wr1-f41.google.com with SMTP id u18so43903106wrg.5
 for <linux-nvme@lists.infradead.org>; Sun, 26 Sep 2021 07:30:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GFrakaChpU71NHjRcWO+0wGjtZo3JZzVivsrYIGgJx8=;
 b=sYi4SgM6n6Tok6/Tl1MegNdWAoHYQ/e1QWxMVhyS79zPD5ejuQ1TguRZXvdGocoaTa
 uupGTE3ylhBxlvlS9OlizFYFg8stzxjXU3mV16krdPeANYqIiCn/hdSrPuT7w4adVebq
 Dl/BufsJrjeU5wpdKwE6gW0SC78j0UJy4GpHM+3YcR9BMVeA/5ESv/TJgEebLXrEFR40
 VVEFNGHKWPr7pYnrLVdKnM2cZxsLHJ1ofXmDtdpHPlbmp9ZrKT70QeZTNu7Vx2/cphym
 aSbs3GXSt4KoftBhcbpkK7GOdmF5WMPXeGt62Wf0yP5UJK3sCKoUsP2yXSneinVr5IKS
 H5aQ==
X-Gm-Message-State: AOAM533+mqvwa8G3NgvMTb/arFRkFU54+mY3OtPRitVfLE6UcZ+lRDoh
 n8Q++j/wxfuRZZOXETBOmdc=
X-Google-Smtp-Source: ABdhPJxBhO75Ijrh4mMBuQACXBz+X+J6JKleAMUY6oy62LWd4XDyCDWkVHHBSc59WXsWpr1HZF7+6Q==
X-Received: by 2002:a05:600c:1d05:: with SMTP id
 l5mr11425937wms.119.1632666651929; 
 Sun, 26 Sep 2021 07:30:51 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id m13sm1041180wms.10.2021.09.26.07.30.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Sep 2021 07:30:51 -0700 (PDT)
Subject: Re: [PATCH 10/12] nvmet: Implement basic In-Band Authentication
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-nvme@lists.infradead.org,
 linux-crypto@vger.kernel.org
References: <20210910064322.67705-1-hare@suse.de>
 <20210910064322.67705-11-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <618db458-108d-859c-14ef-3977a34db95a@grimberg.me>
Date: Sun, 26 Sep 2021 17:30:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210910064322.67705-11-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210926_073053_732830_46FA285A 
X-CRM114-Status: GOOD (  11.51  )
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


> +int nvmet_setup_auth(struct nvmet_ctrl *ctrl)
> +{
> +	int ret = 0;
> +	struct nvmet_host_link *p;
> +	struct nvmet_host *host = NULL;
> +	const char *hash_name;
> +
> +	down_read(&nvmet_config_sem);
> +	if (ctrl->subsys->type == NVME_NQN_DISC)
> +		goto out_unlock;

+       if (ctrl->subsys->allow_any_host)
+               goto out_unlock;

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
