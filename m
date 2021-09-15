Return-Path: <SRS0=dHSS=OF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014F1C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Sep 2021 09:35:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9D26610D1
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Sep 2021 09:35:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B9D26610D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0Oe8DpUAzZJkF560gJ0C47wh5v5uS+lKZA61nQpzMM8=; b=nWAErd4ytW7Sms6EHNf+KNSudi
	0q6PLcvIldH0K/i9osMXJlW0rkAY/6BVLLCKIXTburzh34mJp34qHjH1rzQIEP+qJFqjSTOYgEW8r
	tgIEv1NCwPCXpGZZdHasrt914vXloxus5ATcEEmrkE+p4rgjdqCSMSQc8zn4FRx0RFUNVtsKg6mij
	XRyX+Icg0ieJBBm4Tg7f60GPaCZGrtkJx7i2XoESBCbUjj1t2fjPGoBQDNr4chEp8voS4vDpd1ZNK
	7l2UdWykFjUiA1O/v/IwECgjbGCdmK9ODEfR40MHV5jmbovfoyOi1KqekQmDGXf5QvuxxKgE/DOOS
	5H5Ou8Xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQRJd-008hzP-07; Wed, 15 Sep 2021 09:34:53 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQRJZ-008hyP-UK
 for linux-nvme@lists.infradead.org; Wed, 15 Sep 2021 09:34:51 +0000
Received: by mail-wr1-f45.google.com with SMTP id q26so2791844wrc.7
 for <linux-nvme@lists.infradead.org>; Wed, 15 Sep 2021 02:34:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RMc1IAabu4Qub7pR8cASDbSwvZKn6Dz6GSF4Ph7W3LY=;
 b=d8Zh6BOrpF6eMGo9wdw7ZZBNvIXxqg0ytlO6IAluAuD9jo32ddufiuIY42wJc/V1bE
 wxVKisYFpyKb2req5QGxdknar+3fQCwDHgk5+vFgZTZBgRKpKzozul+b2GAy61By2kP+
 uCaVQaLjOAJ9dAku/CK+7nxUkwWWOfPko9aUXsC9cEJ2Roa1CXU7ArMqlhv/rWtXjcoc
 nD99w5uBW4iEYOmTZKwahGhIzOlTYl7g6EeKw1ZCM56dng6TCBGiWbQisRJNfMlq6z6q
 ZFQH3tpDWxp+YoI0zalKh1CyyZgMV9LCKIdpyiCVJw6jrMkuCfVQ/y4Rktq29Wc6zJ/V
 evWg==
X-Gm-Message-State: AOAM533TzWEhJNiLTFaNGszfC0bA3cUUWQDQCFAwmGYAK6w08lTRH+Yv
 GerCH0kDE/m8fp6VwtOWbsAa5gt5aMo=
X-Google-Smtp-Source: ABdhPJwz/BJ8WaU1Zwevkybfm/Ak7gctzmqbAedSeiN2W7TnWeRlnqJGJr9sCBq4LkW/ervTJ2bytg==
X-Received: by 2002:adf:8b19:: with SMTP id n25mr4237379wra.216.1631698487878; 
 Wed, 15 Sep 2021 02:34:47 -0700 (PDT)
Received: from [10.100.102.14] (109-186-240-23.bb.netvision.net.il.
 [109.186.240.23])
 by smtp.gmail.com with ESMTPSA id j27sm3331981wms.6.2021.09.15.02.34.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Sep 2021 02:34:47 -0700 (PDT)
Subject: Re: [PATCH v2] nvme: keep ctrl->namespaces ordered
To: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org
Cc: anton.eidelman@gmail.com, linux-nvme@lists.infradead.org
References: <20210915082449.1058141-1-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1dcf02b6-03b5-a32a-1f41-861e397a1c9c@grimberg.me>
Date: Wed, 15 Sep 2021 12:34:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210915082449.1058141-1-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210915_023450_056910_885374D5 
X-CRM114-Status: GOOD (  11.19  )
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


> Various places in the nvme code that rely on ctrl->namespace to be
> ordered.

Would be nice to mention the reported scenario for the patch, for
context to what "Various places" mean.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
