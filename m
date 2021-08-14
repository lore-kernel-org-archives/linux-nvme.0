Return-Path: <SRS0=EXTw=NF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E097C4338F
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Aug 2021 19:31:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2F2760720
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Aug 2021 19:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E2F2760720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=CAwEjwddOWRsaFxVzit/lqwry03nxMozIztSmr+7zE8=; b=dv5oxXNVm1phY2bodEmiFQ6NoH
	H2ajbKFZtbluZzdDXDeidZv44+xzCya92QE3Ce4GLKdjbcR3YQvASgJ74jgQz1sIwdL4b04DEqp7u
	F9pYBFYH5iRGzZqzTvx35DqY95/QXyP9/KkB74/6llfrpD6HJBjMExDv8dikGOKHxET9ugJdVWPJE
	BgbDzY5CpuDuVwGPZSddjD42gFQA1FS8/slAi30HEWHfjgVtuCPyR4/pvVo/l0PYCqboAcg7Y7DW5
	4BIldjug1fkZXlu4NNjSZdE1x3VKe1Ia6LHP92UXiIFpGG/e13exCTNGPGbN+6pmP4QFeOxetCiM9
	YCIIuAQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mEzMb-00EW59-Oh; Sat, 14 Aug 2021 19:30:37 +0000
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mEzMY-00EW4W-Rs
 for linux-nvme@lists.infradead.org; Sat, 14 Aug 2021 19:30:36 +0000
Received: by mail-io1-xd32.google.com with SMTP id x10so17758817iop.13
 for <linux-nvme@lists.infradead.org>; Sat, 14 Aug 2021 12:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=JbeDQ4x16e5G5gIVypE4YgHTi2ZFRimYJ1CyJiMvUlQ=;
 b=xkiRijzMCah70wTodyE2LfL4ZqJrQirVS/aCf0QmkKuU/Ysq5hMtrYzgFV2R723eD7
 v2kX8S3ohjaWaCTYfXNKCN3QFy413zcCuc6Q8Lag9JVcDac3r0S54TUgBZhF/sWxdIMV
 3ApfJZGIMKn1XpcmNL2XrPV2K1JGBfS16yjIedT7IYoJa7op6ryVKOu9DdCyOM+6dqz/
 xg+6bwdG1PHtXkPt4r5qve1KQr514suuLbdhSTXoJOvTK1CUC7Jh0iyQPtIJQZ7a2Ptd
 pvHMwyUYwtPsUpeTBqDQ5zw7i9yx+DTjbq0bOCVLeS6k2G7sc3xPIX2l7lzOcecfE4jf
 Pbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JbeDQ4x16e5G5gIVypE4YgHTi2ZFRimYJ1CyJiMvUlQ=;
 b=XSDO+ryVaMTHCHSxjDRzrKVAN3UP2wPtYnqd7Ge0j8gYAX9BVwlw8uDCIhkl8ZFr16
 KgaS6kUiDXRRLq59YOKZVHGTV9Fsa8EwEmY8FZ/lk2sdg1At5iXuZ5UEhNbYURtz9tnS
 60JWf0x5O31jS58WYV/zqXH6gJeD53KAyp0s/v4uAOmmos/8ZZ+QnF7046BLM6CdNrSl
 G63qMuVp4dBOaaUREaJKkRgRe9xxZr+IbIsU+t+ANNCgeZ7MBi6cAMvG+UWKntalFWMd
 +Aah3tgq6F0uwVKl7ejJFhGfshGu+whuKFBr8BBc0owlvNVNRJpYD0TiEdWEO6VhUR3b
 v5qA==
X-Gm-Message-State: AOAM532JXbPV5OJeyuYLgKvBscaj9AQw9mdW7bH9T6rW0mcOlDKb/vGj
 GbvYUIFJAn3Hs3xLu85HnVagfA==
X-Google-Smtp-Source: ABdhPJyX1hdL4HzyioRyFH/5AU+jMOR8WI6MANxllEGuSGxPkVkqvH28RsHCdHYoG5zVX2sSaYRsTA==
X-Received: by 2002:a02:4e04:: with SMTP id r4mr7905240jaa.99.1628969433368;
 Sat, 14 Aug 2021 12:30:33 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
 by smtp.gmail.com with ESMTPSA id g14sm475564ila.28.2021.08.14.12.30.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Aug 2021 12:30:33 -0700 (PDT)
Subject: Re: [PATCH] remove the lightnvm subsystem
To: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>,
 Christoph Hellwig <hch@lst.de>, javier@javigon.com
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20210812132308.38486-1-hch@lst.de>
 <094e8eec-affe-81ba-908e-fbbe2fb7fa84@lightnvm.io>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <512bf4a4-fc60-36d0-adae-93caaf0441d2@kernel.dk>
Date: Sat, 14 Aug 2021 13:30:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <094e8eec-affe-81ba-908e-fbbe2fb7fa84@lightnvm.io>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210814_123034_947463_4FC43FF7 
X-CRM114-Status: GOOD (  11.32  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gOC8xNC8yMSAxOjAxIFBNLCBNYXRpYXMgQmrDuHJsaW5nIHdyb3RlOgo+IFRoYW5rcywgQ2hy
aXN0b3BoLgo+IAo+IFJldmlld2VkLWJ5OiBNYXRpYXMgQmrDuHJsaW5nIDxtYkBsaWdodG52bS5p
bz4KPiAKPiBKYXZpZXIsIGlmIHlvdSBhZ3JlZSB0byB0aGUgcmVtb3ZhbCBvZiB0aGUgc3Vic3lz
dGVtLCB3b3VsZCB5b3UgbGlrZSB0byAKPiBwcm92aWRlIHlvdXIgcmV2aWV3ZWQtYnkgYXMgd2Vs
bD8gVGhhbmtzIQoKU2lkZSBiYXIgLSBwbGVhc2UgZG9uJ3QgcXVvdGUgNDAwayBvZiB0ZXh0LCB0
aGlzIHJlcGx5IHJlYWxseSBkaWRuJ3QKbmVlZCBhbnkgb2YgaXQuCgpQZXQgcGVldmUgb2YgbWlu
ZSwgYW5kIGl0IGhhcHBlbnMgd2F5IHRvbyBvZnRlbiBvbiByZXZpZXdzIGFzIHdlbGwuCkRvbid0
IHF1b3RlIHRoZSB3aG9sZSBlbWFpbCBqdXN0IHRvIGFkZCBSZXZpZXdlZC9BY2tlZC1ieSwgaXQn
cyBqdXN0Cndhc3RlZnVsLgoKLS0gCkplbnMgQXhib2UKCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1u
dm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1udm1lCg==
