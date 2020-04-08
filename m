Return-Path: <SRS0=zNed=5Y=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA65C2BA16
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Apr 2020 14:49:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5483420780
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Apr 2020 14:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kXiUkamI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="K46bTvro"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5483420780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WWuqq+3JXvcrxjsWbR9z8j1gpf0HfhziAmq+9MMd2Ac=; b=kXiUkamI5LmGvu
	vt9tKlqN1buS7VT5O57BtCgrRVWvCaPGUNsDaspH+FHFFzAvQQr0gaiN98wW56jIQKCnxpcuYCNCQ
	1xXI60VS0CNAeeNOJA2gWBHgKoQlc6OCSc18TaUrxPtlYWe3PSasFvyP8yzRFQQJOnnIN4YnHB5ma
	+lAsbmSSgdgdZNfbdO0RvrsSjK04G4fm2cAjPkoAnRFz6jkXLZvKrJgXnbjZOStMGKJNGkMP1f1lt
	2N5XBzh4WuGPeu0Ah2u9aEIQZhoTB4rBoiKLxIc5cdA3QSizRWEB7X54uhtY8aPQFt4mKM5b13zQf
	DErALw+SJd/lo4rWKfvQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jMC1D-00047U-Di; Wed, 08 Apr 2020 14:49:31 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jMC18-00046Y-Rk
 for linux-nvme@lists.infradead.org; Wed, 08 Apr 2020 14:49:28 +0000
Received: by mail-pf1-x443.google.com with SMTP id a13so2501373pfa.2
 for <linux-nvme@lists.infradead.org>; Wed, 08 Apr 2020 07:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=I8FzH7EebZtU80iu8VKOhofG02voMqpeLU7mMA/1duw=;
 b=K46bTvroOv0b5L2EiCyrJPdIos+MKgPHL/VqLYrdtCQSNgcnLYRNJmrLU3UrZSBPb/
 zQGA+h9UFp4oKK3OBipnhxnix9RrOyoaJD4iFvltAz67T8HEQoMrxDXo0GamnvwBdsyM
 LQP2fZUxR3BV7EkxFbo1LQbP40qKCHspkcJLnC2uo7Yu+P4u3+J1OrO3qSNaSkuyqaEc
 zXkGcJ2a8Uc9+P8n5Lqs291INdThk0a/PvMF/sktuMhmdZgjEqWovor5cQjVPsTui1nv
 H8FrFi/+A3CRKM3oCDLaqPNKUuRxx7lVmowZSDhR6Pz7fi4ltPxnxpClknR1ThbRSgnw
 AZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=I8FzH7EebZtU80iu8VKOhofG02voMqpeLU7mMA/1duw=;
 b=BrZBt3VvH1L6yX5BM5Nq/dLWKaV6aMwmWG9Vyshec2QG3BDIbfU+JwQgK/rz14D3V2
 tCmOIk0YpIMkdyIsyeF+FWLz2DOuTUUPUS7y1f/jtnE5vWwgrXa9Cg7ndkTZqP4Vbqlv
 z1sfyv8edeHKW15pMn8Gf2bav7zen61nGFLYRwQEk2sgkrWgoOXA8Hhgtj2DNPAu9KwJ
 sU2bBVHQPoYNFgnZV0TNWZuzV+7ziiT04KDIqOW78g9yygkqN7amNgpT/BVo/Xvs4Rc+
 krGP1h4vkPZsDW58BxVk2Wlg6yHXuU7BYqjtZhD7y4U9t2+w/9aZjvcR0rA7c5PuLooK
 y4ng==
X-Gm-Message-State: AGi0PuYKHY1awmblIbDlQfLrdheyKQq2UY9gatsuo8EFSVGqVBa6hwtJ
 SSjTplgP2Qq+mBXPczGPliSVbvQ3i6Lxlw==
X-Google-Smtp-Source: APiQypLx/xljiVY4tkyNO5Z6jOqqaJGZZ9DaV7MRYO/RbCEZlAbtLkD3YztpKMrblyNBSsvzCICYsg==
X-Received: by 2002:a17:902:8c94:: with SMTP id
 t20mr48219plo.336.1586356917092; 
 Wed, 08 Apr 2020 07:41:57 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:4466:6b33:f85b:7770?
 ([2605:e000:100e:8c61:4466:6b33:f85b:7770])
 by smtp.gmail.com with ESMTPSA id x188sm15772384pgb.76.2020.04.08.07.41.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2020 07:41:56 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for 5.7
To: Christoph Hellwig <hch@infradead.org>
References: <20200408062131.GA212017@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <795e9c03-4213-8d98-3d18-791c3a97efe3@kernel.dk>
Date: Wed, 8 Apr 2020 07:41:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200408062131.GA212017@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200408_074926_898385_719EA056 
X-CRM114-Status: GOOD (  10.25  )
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
Cc: kbusch@kernel.org, linux-block@vger.kernel.org, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 4/7/20 11:21 PM, Christoph Hellwig wrote:
> The following changes since commit 458ef2a25e0cbdc216012aa2b9cf549d64133b08:
> 
>   Merge tag 'x86-timers-2020-03-30' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2020-03-30 19:55:39 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-5.7

Pulled, thanks.

-- 
Jens Axboe


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
