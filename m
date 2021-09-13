Return-Path: <SRS0=T5dq=OD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A6FC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 13:16:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFD5E60724
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 13:16:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DFD5E60724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=X1B5FJTeW6a9jDczbdbPhhM9cG
	GbYmWNbKzy07CwmxXoZPRkh2lfg1eg17W8+mGvm34YjaEf5esPe2cqL7PIQG5GP7na2Exp1DXMSXD
	Xdxxh5KuAL17lHR59B0513El0cHGKzRAPahO1i2X1DtdVtBdzDX+/FeCSO5W9ngpeCN2/uKSXK8TM
	Y0wMinRBVT83yDU/qnllzUoqjSsrDbpyb0BciZc70Y32QdPtIS9rqptCKHjrQRqcZM8lMwX6CrRY/
	4R4Av+wJKHuFI+ObDcaE1ZoMm/X4l8ft5CdrHg4EkbSqrqpnJFUdwGA/LFVbd+mPWWExq0hd7fJzK
	QdNWnBXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mPlol-001jzg-Em; Mon, 13 Sep 2021 13:16:15 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPloc-001jyM-SF
 for linux-nvme@lists.infradead.org; Mon, 13 Sep 2021 13:16:09 +0000
Received: by mail-wr1-f49.google.com with SMTP id u15so8593867wru.6
 for <linux-nvme@lists.infradead.org>; Mon, 13 Sep 2021 06:16:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=UDYGIo5Oz2Dw7bzK94xf4ZkvN01Cnpaq5zSBZjOWzzrm8f6LSOBQsGOgN2+AYVPYv5
 W1aCbKaks0q6dMNwDMQyweh8UR1S5puzF7ftuOA5f4xXRMnYniW4anAwhanvpNbP5J3a
 0pYPQJQlpjPb0VfwWc5H9dCrgxXTxTpxndcbF94lWJiTujgkhxiRr8JPSnhIdtUPfnHI
 vHT/FjYo3ZnzbHMt44ZeEu9noNHVnRT2GVPwkDc20rVpMqqVTfo96rbXuvu2Z53lecTZ
 qgG/ThG4r1OxViOny0BnNuiXZ33pGIvrypIKMnVKmPUCjNgU/bfQ3wxkayHYUorZby2M
 HPtA==
X-Gm-Message-State: AOAM531mjYSS3ctFLTA3By4DqaYRhyQ3LU6FM/likSewCOJvb4Eq7psM
 1NxxVdtQyUy+DIXATxT9CuYlp6BXDg4=
X-Google-Smtp-Source: ABdhPJxC2G+83Sn9m2HoK7rtfsVr7UeNIaPHspr5GhsqFvsj4Tog4ygakvq61LUuUsQ2iktHWnst1Q==
X-Received: by 2002:a5d:4b50:: with SMTP id w16mr12479916wrs.71.1631538965422; 
 Mon, 13 Sep 2021 06:16:05 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id l15sm6045604wme.42.2021.09.13.06.16.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Sep 2021 06:16:05 -0700 (PDT)
Subject: Re: [PATCH 02/12] crypto: add crypto_has_kpp()
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-nvme@lists.infradead.org,
 linux-crypto@vger.kernel.org
References: <20210910064322.67705-1-hare@suse.de>
 <20210910064322.67705-3-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <9ce7e32a-7409-df05-ff04-10e8eaf0f22d@grimberg.me>
Date: Mon, 13 Sep 2021 16:16:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210910064322.67705-3-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210913_061606_949638_EF0ABEF2 
X-CRM114-Status: UNSURE (   9.23  )
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
