Return-Path: <SRS0=xKei=LR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE222C48BC2
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Jun 2021 21:34:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2C19600D1
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Jun 2021 21:34:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2C19600D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=Yx0P9jlzQcSY6504YsQOHGFR8k
	8MWKBAd2MAJScfISMfs6iBychAw0u8QthMMSm8FF2QNH/INobWAAr+6AnX7lvM2uILGfktTVhwVyI
	YRecTH2YeJWShcl/cT45gU1zSJlIUbZZACzx0zfcV4Lx2SC9ff8um3hr+IOz0a2D6qwabU05YAIQl
	MNlY/SYQwBWMXbSmCFVn9sStTQlkP58k03jDH/Z2HBliaBD9+Eo1w2TxAIGqm3z3q9BoFY/Wqcy06
	i4x8R7zosEB5xEV5CwYLgywNRdemfKu3DSiz+0akWLW7aazFjYY+s74GgoSSrWjxqfDZaeB1cKw2d
	+EdZ9CsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lwAVr-00C0vt-I3; Wed, 23 Jun 2021 21:34:23 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lwAVo-00C0vL-Q1
 for linux-nvme@lists.infradead.org; Wed, 23 Jun 2021 21:34:22 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 j11-20020a05600c1c0bb02901e23d4c0977so4247160wms.0
 for <linux-nvme@lists.infradead.org>; Wed, 23 Jun 2021 14:34:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=FJ5ESbf/iQuw3s5KMSoFMeydHCPZFWwZodySP5gceILh0JIWP3PYR3Mt676Hbf38tw
 hiTM+gynRbTqcjN80YqW9JBNYrT4s7n5opCA2wzZuB2puQ3lQrZI9ohE2dZfsYyFtmAW
 Z7LT+bLNP7bdeF/377ZYuRCeiN3QxPHeWWEo7FeSAh7e46YznmuPZ9eFcUJcSp8YPRlZ
 uwnzRYg97TtwNxRTKgcweZsdMF76TcAdjOEd7roqtgkCAJ08rDH5TSoMjlIsdc9OFR31
 5+FbKLoBrTVrISNNONvWhRfEdhrz0oT6FnkufMMWP5GsOI+5I0eVR4I6mScCxyePPs5M
 ZP9g==
X-Gm-Message-State: AOAM533lMfwqeAFHx3dwQw4uzsbJxGNWH/8VMbEJrW683L8lRYy8olRz
 wN9N4Duuvx1KctvYuCo0MhU=
X-Google-Smtp-Source: ABdhPJyk3bcamDzzubVC9xwgjsgbco9kNE4eJGHOwgWQP/8xUYzP/vfZ5FhBFQ9jSAiUA1VlYCMc2A==
X-Received: by 2002:a1c:ac87:: with SMTP id v129mr176905wme.45.1624484059301; 
 Wed, 23 Jun 2021 14:34:19 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:d7a5:9de1:faa6:69b7?
 ([2601:647:4802:9070:d7a5:9de1:faa6:69b7])
 by smtp.gmail.com with ESMTPSA id b7sm1176387wrw.20.2021.06.23.14.34.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Jun 2021 14:34:18 -0700 (PDT)
Subject: Re: [PATCH] nvme-tcp: Use __dev_get_by_name instead dev_get_by_name
 for OPT_HOST_IFACE
To: Prabhakar Kushwaha <pkushwaha@marvell.com>,
 linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 martin.belanger@dell.com
Cc: aelior@marvell.com, okulkarni@marvell.com, smalin@marvell.com,
 prabhakar.pkin@gmail.com, malin1024@gmail.com
References: <20210618133956.10637-1-pkushwaha@marvell.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ac92bc9e-0799-9aec-ce77-479a133fc3d3@grimberg.me>
Date: Wed, 23 Jun 2021 14:34:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210618133956.10637-1-pkushwaha@marvell.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210623_143420_893850_12D071E1 
X-CRM114-Status: UNSURE (   7.93  )
X-CRM114-Notice: Please train this message.
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
