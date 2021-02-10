Return-Path: <SRS0=Gy4h=HM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1971C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 08:13:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6175764E42
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 08:13:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6175764E42
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=NszExvT6X3Y44pH3fNvh0dfDyfh9EOBpAmWW+WDCi/k=; b=Vr484SgXJIX7oX5Q7sJphiqA8
	9UB/HS5KEd9BYk0+e3p7MMmwrTD314/VK2GyguF5NoyBfe6+QaMPuJI4M627IdwL5XpCmWKC3afOJ
	ivfX/mUm+G8ZimyxUZ2PfyQq4ZXCf9waWc/fhUXAb/nSW6iWpzApxnDqF5adLSRrE8+IyRom+bRsT
	jm1Q1wB5cr2HlPVRecnTeOQ384ERmwUnQ1U5XfMRqS9HC3Hx5aRI06zZVFpTL4IaWbd/VKBg9Ohci
	8LEUDKAhSfomgQuqp+dDAZ7jI1cL7wTkokgWY5Qh68MdKZjh6uWNM2YYv0+7ddbAcqme43oKb2G5U
	7St+NxPWA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9kcZ-0002Yb-KH; Wed, 10 Feb 2021 08:13:11 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9kcW-0002XQ-BR
 for linux-nvme@lists.infradead.org; Wed, 10 Feb 2021 08:13:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id BD6856736F; Wed, 10 Feb 2021 09:13:06 +0100 (CET)
Date: Wed, 10 Feb 2021 09:13:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH V3 08/11] nvmet: use min of device_path and disk len
Message-ID: <20210210081306.GD24040@lst.de>
References: <20210210054802.34269-1-chaitanya.kulkarni@wdc.com>
 <20210210054802.34269-9-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210210054802.34269-9-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210210_031308_606957_8AD5C503 
X-CRM114-Status: UNSURE (   8.98  )
X-CRM114-Notice: Please train this message.
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
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

>  static inline void __assign_req_name(char *name, struct nvmet_req *req)
>  {
> +	size_t len = min_t(size_t, DISK_NAME_LEN, strlen(req->ns->device_path));
> +
>  	if (req->ns)
> -		strncpy(name, req->ns->device_path, DISK_NAME_LEN);
> +		strncpy(name, req->ns->device_path, len);
>  	else
>  		memset(name, 0, DISK_NAME_LEN);

This could dereference a NULL req->ns.  I've changed the patch
to eliminate the local variable and to return early for the NULL
req->ns case.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
