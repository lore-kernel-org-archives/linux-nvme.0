Return-Path: <SRS0=v579=XM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145D4C4CEC9
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Sep 2019 18:58:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDDF8214AF
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Sep 2019 18:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X/aku7NV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDDF8214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Cw1IFT5IQDR7Kfxw9KKZE27lWmQcB+74fcChNuVdBJc=; b=X/aku7NVQdsTozm6Qzx08eLUV
	94LRvzR/lqu7AYowHwtuAxQsI5pJyAMq28OSREe2l7CHESJFbXjf/adWWZiq6sW7lNQz59F8kIqm7
	uIYmVaTDrF/waU4FU6iRuMWejvK80VRHQ0GIi3UAnmo4tMPwak2u2OdBnIIzSQuzhjDRgiscnwKIW
	3otd205pG+c8M0O/GfCuykBJjeSONDLprS6IO+flfsZZUp2yUCLvlyPvoKn5SmGX08KnatUl7g8oe
	BpMoArcwTxdGK9dzt34YSJMoIcoS6QKWwM2XjtS6rdLU48dLRjlPcMG9o1eL/adwrJi7nvYLY1j6c
	lqqeknEAQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iAIg6-00040Y-Ih; Tue, 17 Sep 2019 18:58:18 +0000
Received: from mail-pf1-f171.google.com ([209.85.210.171])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iAIg3-000409-TV
 for linux-nvme@lists.infradead.org; Tue, 17 Sep 2019 18:58:17 +0000
Received: by mail-pf1-f171.google.com with SMTP id y72so2666839pfb.12
 for <linux-nvme@lists.infradead.org>; Tue, 17 Sep 2019 11:58:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kQc4sh+/ANUB12qotn06cQoVAtOlplPZiL32AJPb/Pw=;
 b=CxTdSamRK7AzA8MloGlMYcZIKJ8f2uId9RqGi43BgcR99N9U6s+ejPNnkdyeyatMem
 ixYTCikpKsvdazHj2dAMEmWDqAhS7gNOdEE8NSgVWSNzI0SxbvWzMtSGVKse2gEPyCzl
 VSxBMOglI8DzTudtl9yQrAqW0rjZjAzfs2Cc91GDr+ijCQqCRR82o3i2/YlHOVQuidAQ
 QW82EsIwFS/n1m4kYw9YxE8NVi+tbpJEu3xHgBsB1ZKuJ7mGQtMk9YMh7C+2nTIvO76t
 QSYZS33Oxjxc2jTowTRCJjPKjtzZPuvXuvPH5805aRq2XwkSsrYAKqopyNfLeg3ZvpaZ
 0yGw==
X-Gm-Message-State: APjAAAVPdP2CKyO7ozHlwqNXZqJKQ3bOeCLhdy8htopyRTeR1XhMEKhb
 mpgvmiqQ7efQKhGcLjC6WlI=
X-Google-Smtp-Source: APXvYqz72Yu59YPq7W6vjnmidIhnIp0rO0KFpA3hRb5nx+RVN4e19DkezpEbwtxg26if5G7V7IeuUA==
X-Received: by 2002:a62:1d12:: with SMTP id d18mr5948695pfd.53.1568746693736; 
 Tue, 17 Sep 2019 11:58:13 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com
 ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
 by smtp.gmail.com with ESMTPSA id h4sm1178494pgg.81.2019.09.17.11.58.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Sep 2019 11:58:12 -0700 (PDT)
Subject: Re: [PATCH] nvmet: change ppl to lpp
To: John Pittman <jpittman@redhat.com>, hch@lst.de
References: <20190917185200.24292-1-jpittman@redhat.com>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <a66f0549-4d58-57ff-8a5c-7e7140614b77@acm.org>
Date: Tue, 17 Sep 2019 11:58:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190917185200.24292-1-jpittman@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190917_115815_951885_6275D3D7 
X-CRM114-Status: GOOD (  11.25  )
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org, bvanassche@asm.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/17/19 11:52 AM, John Pittman wrote:
> In nvmet_bdev_set_limits() the number of logical blocks per
> physical block is calculated, but the opposite is mentioned in
> the associated comment and reflected in the variable name. Correct
> the comment and adjust the variable name to reflect the calculation
> done.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
