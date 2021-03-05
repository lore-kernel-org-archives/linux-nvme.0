Return-Path: <SRS0=roYe=ID=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570AAC433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 22:37:00 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC6596509B
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 22:36:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC6596509B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=jH8A8xseZ3Xo0QrTMm03ly/tb
	zqrSjDsQYMVPaGf3DMU3MqPbkw3sgiP9f/TrDxBNMh6BbV284s0tENoB2gs9yocyoa63+zXqHMfQF
	uWTc1u6428fnM+euyOJS9SKzDGSQO8hl7oM/nc5pVNr8e17vStviwnIcVyKbA14gOcOBY33uHocvc
	chSAXSXTAM2xWElicMojZ49OOfW6tU4MfMpIM7Kh5DFmEzpOrBQwjRM2RSJW5f6WGODIHKE5WyCHf
	soQvA+6bOmz/+tu8HC2GCaauPrn1nLw26TIKQsmccA7egOxjNuAq+yQDNlguo8O+JeungUHTWvj3M
	Octu5i2AQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIJ3p-00Grm8-T3; Fri, 05 Mar 2021 22:36:42 +0000
Received: from mail-ot1-f48.google.com ([209.85.210.48])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIJ3k-00Grkf-Ed
 for linux-nvme@lists.infradead.org; Fri, 05 Mar 2021 22:36:39 +0000
Received: by mail-ot1-f48.google.com with SMTP id j8so3384681otc.0
 for <linux-nvme@lists.infradead.org>; Fri, 05 Mar 2021 14:36:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=rSi1axQQEyRzWstDSujmNkLezjydUsvQzzNWkmF4nkMinEAQtP3ViOXivrw+QThHSU
 nrbd+0RvWoo8xTAoxMtCLQZfr30jnM8Q3RO9GAlezp8aJVFp+WxZdryMYGMX/WjICOFa
 lro9x53xBJ+9lgF9FLSAOy3NExrHwcWWiVbbf147AFly8uITKs6AGpQh94W9/lidN+JI
 RSggr0TPf5WvjesJZcEY0d0hDvk68B6czrzsfWXxtfjif5RVpFc0IFBy/Ef+wAUpos8D
 sCCb40HbOpo1/pcTnCZ+drKrRMIiNQjftAjjVWanekhC6TaYkNy2CcR2wkDqCPLDtTsN
 8Clw==
X-Gm-Message-State: AOAM530d0SYAFdNBZjnBn8IucQj5CE6h7OkQQr95kfTSRch6FBO9stFB
 hip0njtG5vPKFxh3pMXReLUg5jffiJA=
X-Google-Smtp-Source: ABdhPJzNKs79vYcNhqrFiNfwcEeXFrkthhmsWyuAY1zmxauPAgXusEvk8u4uUZcL41gryCkBE0V/JA==
X-Received: by 2002:a9d:20c6:: with SMTP id x64mr8291927ota.262.1614983795494; 
 Fri, 05 Mar 2021 14:36:35 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:e55e:67c6:e7ec:9?
 ([2600:1700:65a0:78e0:e55e:67c6:e7ec:9])
 by smtp.gmail.com with ESMTPSA id n17sm849529oos.20.2021.03.05.14.36.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Mar 2021 14:36:35 -0800 (PST)
Subject: Re: [PATCH V2 1/6] nvmet: remove duplicate status assignment
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
Cc: hch@lst.de
References: <20210225015642.29288-1-chaitanya.kulkarni@wdc.com>
 <20210225015642.29288-2-chaitanya.kulkarni@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0de96c65-b632-3cfa-09d0-74b4565c668f@grimberg.me>
Date: Fri, 5 Mar 2021 14:36:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210225015642.29288-2-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210305_223637_759114_81357961 
X-CRM114-Status: UNSURE (   8.22  )
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
