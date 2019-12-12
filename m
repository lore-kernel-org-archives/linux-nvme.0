Return-Path: <SRS0=hCdm=2C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC83C43603
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2019 20:11:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C76821556
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2019 20:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="j5OxdQja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C76821556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nhE8kSM6c5EnqD+0bFulrc3MER/wKEawml6A9SBa2UU=; b=j5OxdQjat+rExhzJGU2tQPwmN
	v8d7GnzvaL/Ap8I77rba29rbs/RK37BjaoSWP/ZFQtqxOioaSS/0lE1ezoEWvihhYwBMsilOIxeYm
	AWDzYJEl6UHsH/tPVQ82S8OLTxgUzhQr8LYIVWz2lpqitMWcl7CMCV3FhP30PFu+TFj4AhbUGveRT
	6jXc18tAEFU1WKpIcVbCmi3xm47iIyhVhT1gktEf59VgTZITliXzoLELJN3wQeRrAb4cCIqhIm1em
	VEHimMrxKy0iUz700/WrM0ZRldd0gtHOEwmfnig4DGojKkBMCNXdjv+S6jDTEIvCGd5kRgIg94dzW
	gF5qkXgkA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ifUnq-0002jk-N8; Thu, 12 Dec 2019 20:11:14 +0000
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ifUno-0002jS-KQ
 for linux-nvme@lists.infradead.org; Thu, 12 Dec 2019 20:11:13 +0000
Received: by mail-ot1-f67.google.com with SMTP id k14so3305755otn.4
 for <linux-nvme@lists.infradead.org>; Thu, 12 Dec 2019 12:11:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iYVYmbQhuZr3dhP/dEK8qqCaDVjwc1XHroU8vsufsh0=;
 b=cWV2K1oPPwsclizWu0OQ75pLB9i/RNlwurOrPU5odn+j58iX4Dw2tstY69mcWCPfYF
 vxARKqJl5IlIenIpn/Kl7z0UtH/HCQ3ZaEgtvYNPhYBbOjplspx6Apq98c3rJoaCw+C3
 4g+7g7Zm/X3VPNVPVoiUgY53Ygw3lq935KSQVIqJfwzVGmEfTRK1riMJNBjqaMozHvCx
 yvd4BCxto0rAMrMnrSfDgXAOgLg1PfGvObkMGfA+gCb1bYPSH5O2dBO2Ta235JVQbpRV
 fq6K/JSW5ohpX3jZlnQI+v0EAGLPh9pfPi72IusY/liCfJI7gP3UqM5z2DY6hzClwn6L
 wY1Q==
X-Gm-Message-State: APjAAAWvrR2kOuEtUz5SkXqJrfdDDRZBBe36e4FVmd3oUJhUndK7Tk+1
 fKSErXGNL6BwFT9Vxe0mvJREhWZc
X-Google-Smtp-Source: APXvYqxm9WbNLA8J5lE2BKMSM4oR6Y+u1oIHIwMyBZAJ9khpeRuarsEpzZ9yFBAmQT3p0ER7qBoLLQ==
X-Received: by 2002:a9d:39a5:: with SMTP id y34mr9522093otb.146.1576181471174; 
 Thu, 12 Dec 2019 12:11:11 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id v200sm2444219oie.35.2019.12.12.12.11.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 12:11:10 -0800 (PST)
Subject: Re: [PATCH] nvme/pci: Remove last_sq_tail
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20191205200825.27651-1-kbusch@kernel.org>
 <20191212092013.GE2399@lst.de>
 <20191212154747.GB30534@redsun51.ssa.fujisawa.hgst.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <96e97c53-5ea9-4636-353f-894bc754cd03@grimberg.me>
Date: Thu, 12 Dec 2019 12:11:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191212154747.GB30534@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191212_121112_666208_B42DC593 
X-CRM114-Status: UNSURE (   8.86  )
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
Cc: linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

You can add:

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
