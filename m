Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5DB1EB64DD
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jul 2023 07:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TojfIkzOYN1XP4ysOM1dfj07DdBIf3ICY+X6/6Dkd2k=; b=hfnGyjRCyXDh4f8TLC93l0Pkch
	N2t2XKRZkjLulzyOaQcEoS6GkqaS87+a8Gd84xUai2qmioy/jWreyr7xXFPQOCqB9fxoReaj6+MEP
	NIwL7PbVYIaTflrqX2Nuqlzmf9utl3xIHxth8kwf99lB+UCgtBRQer/01t+uG+oCXH+Hriu9fiwt0
	QM4hOhuiSEfvoK+MD15doM8wBa7O54YLl+kPrf2m6nmJaUtmJ2g2CAKyGYIhq4wBmIDiPNW9LzXSS
	YGe3F1nLVFsK0fQQGzw8Y4v9befT577oMcbXgQRtNWG1j/ZCFdyfOAJSLWn6tNhTboQqsE+SRbDGN
	IcFB5pBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJ7yW-00E0S7-0E;
	Tue, 11 Jul 2023 07:39:56 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJ7yT-00E0R6-1s
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jul 2023 07:39:54 +0000
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-3facc7a4e8aso11421475e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 11 Jul 2023 00:39:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689061189; x=1691653189;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TojfIkzOYN1XP4ysOM1dfj07DdBIf3ICY+X6/6Dkd2k=;
        b=Z4dBw30ygwQpW9UBxQvGCo5/b9Dmnj7pKM3KweQyYhX+eaLwzPe6uokHdsxmvCZv0j
         woZwqhYLvcRG0vOGI0eapYUgonHSdCYrfwgEL+xoLaiTMoQDiwCmFYbW1RuPyLKl6/s1
         DvjjL03V/0V2t6UrqSlMxsCtUm1GbRFY00YdAWzpnZa/XIhGQ2U7LdmDRBHNDOqehtOv
         uBo+ks0qcj+Mi3NuNxsO/xWNgpQ2u5d7gLLEboDwxAx4ftC2HmWOlxEHBfgTYRk2qOzX
         LK/J/mePTkoxCuQ1v7EHjxq4IrIPyOMuwGRY+QwFghqn+ze68yGJdUuafhAgloG1HwZ0
         3uBg==
X-Gm-Message-State: ABy/qLa3X2RLKKk5psscW/pHOn8YblCLROYI2BEVDfP1rFAjHCLMDC3/
	KNdqsoGx1D5gHRpQAwj8a3ccwG9X1wM=
X-Google-Smtp-Source: APBJJlFNiYtfvqtiPpdJ8Yr2ALFbLaB4gMQL+wfv8GsqrG4xUJ4Wpm2xh45pVEDw4YD2Xre7b2o16w==
X-Received: by 2002:a05:600c:358f:b0:3fb:3dd9:89c with SMTP id p15-20020a05600c358f00b003fb3dd9089cmr15465689wmq.0.1689061188780;
        Tue, 11 Jul 2023 00:39:48 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id v21-20020a7bcb55000000b003fba9db141esm12236024wmj.38.2023.07.11.00.39.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 00:39:48 -0700 (PDT)
Message-ID: <7619c99f-51be-b9fd-8f86-2a9ea45ce0ef@grimberg.me>
Date: Tue, 11 Jul 2023 10:39:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/6] nvme: tcp: remove 'shutdown' parameters from two
 teardown helpers
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>, Chunguang Xu <brookxu.cn@gmail.com>
References: <20230710153555.1766438-1-ming.lei@redhat.com>
 <20230710153555.1766438-3-ming.lei@redhat.com>
 <a3702d5e-a0ac-a2ce-4bc4-e48e39f649d2@grimberg.me>
In-Reply-To: <a3702d5e-a0ac-a2ce-4bc4-e48e39f649d2@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230711_003953_616517_D4F4F7B2 
X-CRM114-Status: UNSURE (   7.58  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

Nit: title prefix is "nvme-tcp: "

