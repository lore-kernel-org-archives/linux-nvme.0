Return-Path: <SRS0=X9H7=XW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A79C4360C
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Sep 2019 17:24:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17872207FF
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Sep 2019 17:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bFHihC15"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17872207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=a5rljt+Rt8f6PQa7s6hVOpOvh41JwjKc8+1Tqr1Bjvs=; b=bFHihC15zl7dO6WOzEGAEAIw1
	jgdPRsy+uWcyC2pGqS2tHR3XjJQ3GJCGZ7aJmRlDRAr8R+KTxjuY12j8BDthxmUb0SMyGpQXfBqI2
	D0FDFdAcVDOsEdyDeiDTbvSM380ZpN0mrsWUAiTrvTiImymZBuS/DjcqAx3/E+YbG96G1dm/CKbFZ
	y+0EYmRFHz7DY5GHuoFlYTlBYs/uW+jwSkKUug+TYhLs6NyS4stAbcaYHia7UadRQjleFQyHcV8Cc
	JuLC+EPA+wosRLE9bWYwPcg1+LoViKe88jxs4/M379yEwxSiUFwE4JoBpSQAaya9pnO6seKsp0h1F
	xh03TDWmg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iDtyh-0002ar-4I; Fri, 27 Sep 2019 17:24:23 +0000
Received: from mail-oi1-f196.google.com ([209.85.167.196])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iDtye-0002aN-RZ
 for linux-nvme@lists.infradead.org; Fri, 27 Sep 2019 17:24:22 +0000
Received: by mail-oi1-f196.google.com with SMTP id m16so5869788oic.5
 for <linux-nvme@lists.infradead.org>; Fri, 27 Sep 2019 10:24:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7D4V63TAXoTT4F9yKTxXrLXJn7A7fjPs4Ts3QV4JA4E=;
 b=oRC9zACbcCjOl+qwgI7KGUGUFjP5rhlgwTWlI5R8wCtbkUJ+wh9whkoE3vDsJH8tpQ
 /F4tfAfBD86k0Bkjasl7mruKjsATT0wciaCx+xqxdOuohfQk5rPcTLH85iH9ZIyqECzv
 OG6bwQu6DlpiT8n5K/oDMq8s4yaaV1mDtIUjbqPOYFMiZ4KNEG8/Iq/TQklmMh5pyeQc
 vDpRZsjWTl0cxoKrxRibIX8svUzVTJOxDQj4x+1OtJNbw0pDUJMjnCJX6Val3mYZz3dk
 2XOAZPw7BAf+dvm6TIf8wGT1mfHE3AgGNz0XEa7fbYlhZZU7uFczZIFzU4FBMjYBx/NQ
 565w==
X-Gm-Message-State: APjAAAXOXvOyiWRD3FxdzRGULm7kBIP0sWH/RwM6kHKm5r1HjCzFSzsh
 aU4mjx/+I1bC5Etg9kTBUu4dtBAv
X-Google-Smtp-Source: APXvYqxu9AN6e87fMwEfuS/m3gPhb6TGSK0p6150gZUbru8ucWYrxXKDXI5bdsH0bCG2niK6HH+zbA==
X-Received: by 2002:aca:d887:: with SMTP id p129mr8233990oig.92.1569605059625; 
 Fri, 27 Sep 2019 10:24:19 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id t10sm1834676oib.49.2019.09.27.10.24.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 27 Sep 2019 10:24:18 -0700 (PDT)
Subject: Re: [PATCH] nvmet: add revalidate ns sysfs attribute to handle device
 resize
To: Mikhail Malygin <m.malygin@yadro.com>, linux-nvme@lists.infradead.org
References: <20190926231940.7494-1-m.malygin@yadro.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <80c2509b-bd48-c3c4-13bf-8ad6b1c0f77a@grimberg.me>
Date: Fri, 27 Sep 2019 10:24:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190926231940.7494-1-m.malygin@yadro.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190927_102420_887428_0F5F3A4A 
X-CRM114-Status: GOOD (  11.22  )
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
Cc: Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> +int nvmet_ns_revalidate(struct nvmet_ns *ns)
> +{
> +	struct nvmet_subsys *subsys = ns->subsys;
> +	int ret = 0;
> +
> +	mutex_lock(&subsys->lock);
> +	if(!ns->enabled){
> +		goto out_unlock;
> +	}
> +
> +	if(ns->bdev){
> +		ret = nvmet_bdev_ns_revalidate(ns);
> +	}else if(ns->file){
> +		ret = nvmet_file_ns_revalidate(ns);
> +	}
> +
> +	nvmet_ns_changed(subsys, ns->nsid);

Shouldn't that happen only of the size changed?

So what is the model here? have some udev rule to
trigger this?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
