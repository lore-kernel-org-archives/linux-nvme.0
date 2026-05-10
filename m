Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C75CD37B2
	for <linux-nvme@archiver.kernel.org>; Sun, 10 May 2026 22:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=OKcZzK4PNVwbPocMT4V93VcH2Q
	xDqK4PF0wwh2tlEtuAAmXte9YaR3pciotxvOwpX+yYeQTYPcrlaxVDf1wBFyfvU5ppIuHCIk02J9K
	mfuTUE8H+tY2K0vTaMotaq9uC9rTKgbjD8gx4SSBrRhXUAeNzwHNyJceSUXVyJh+d6iqaok28bmh0
	5An8fIaVjZdxkhj9yu9IGWit8gLw40iWoNHAqJslw8wMTPMIZUxdiH8yv1nmc09RZDX9E+nbQWAes
	MhvD6S9C3mjUaaG27knYSlN+sYlfQTu4bj5BEy1JYGAtcewfvzmpRpqwcp8tKCofS66vxcc2vOxuA
	1xqWALwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMCR6-0000000Bjql-3qdT;
	Sun, 10 May 2026 22:15:44 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMCR4-0000000BjqB-35iE
	for linux-nvme@lists.infradead.org;
	Sun, 10 May 2026 22:15:43 +0000
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-459bf19e87bso1093f8f.1
        for <linux-nvme@lists.infradead.org>; Sun, 10 May 2026 15:15:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778451341; x=1779056141;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=Hq3kwP5RTIWQXWKQG8OKNcWJ2QT4HkMYKrS7xhHV/LyAQW6P5IetLvUe9BWXFkpqa+
         uqMfNRxl44exndrWInr2Pcdvx0ueJcpnSEUbmL1NLCbyYaHqzV3cbvUPW9StjwypsdiS
         mGnQo53/bFqq5q9wLgmBDUV/zZV2UUy4My0LluYluzULUGs050T2QqqBQMarZbfZ7P9h
         hXjkRZeD3O45PasfrFMrFPnI8mUY7jUgGUzZYCaduYjtefRx53np7YFJaRkVoBOcE+o+
         qZqAXYFhkPgfutni25e5iSaeEo+dnL0TYKqFh1flc2/xfZqywLS/XJwCsLrnrqnfAgzu
         yG8g==
X-Forwarded-Encrypted: i=1; AFNElJ9lXUTDdeeLMOTnaW5zIKmBvROHWbpIfxobAPSlR7s0lG+nPpm36/Ym0v9Ed4qho4VguDKxvC6UPaTb@lists.infradead.org
X-Gm-Message-State: AOJu0Yxa9r6E/ImIyVd0dvDFSD0b/L4tsiH1Qpktmu2BXTkeH7yNRTYo
	8ueS6REFmwBVCl0thxyAUyg8ISmPNCKPpbVXVF1XpubmqQ+Wk0k0JEzj
X-Gm-Gg: Acq92OFMILAnp9e9SHI3oO6ub+zBHmaub+O/7pjEVlrjMx+eZBPGzPkKqWWhQuxBizU
	nb/CmNWxriCCVxYiFa4m6h11MQK5NOXQRx4+MDq1/FNGxT8JCDDNlXKtW+ht8wZByIhg4g5YZ6g
	iFQgTxwZ8POuA6KrfVVgjm4SXISsRdqnMGddkfAZclQLVIhKea7iHJ9SLifD5vCXTd0KTgw6Bjo
	jjC30jdrUp7WFMSs48nbHhdUUngYT7n72cFOiqo08D4Ts8thVIjpkqISIw3Lnwaf9ADTnzm1br3
	A/w/MdNbmN6sRW8QMZQw4p7Q+HApy14Pu6TvTs1JUX487Z1dA7wBSTPGgBXNHlj4Uxc6IDPlQNx
	+JoV0mZu3BMf2WJcBr22jJckHTIWZ+7jDtc4fk8cTe6R+VnPPA4ZB2eEjwZoLnY8gy+lIjQU5nV
	XD/ycbTDXTYg8m2qjvL/taKpsxUeGjBA==
X-Received: by 2002:a05:6000:3103:b0:44f:da83:2030 with SMTP id ffacd0b85a97d-45463d88e5dmr16625035f8f.41.1778451340549;
        Sun, 10 May 2026 15:15:40 -0700 (PDT)
Received: from [10.100.102.74] ([89.138.75.0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548ec6c221sm21501074f8f.13.2026.05.10.15.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2026 15:15:40 -0700 (PDT)
Message-ID: <2e27d7e4-1e06-47e5-94ec-d8fa98ed40f3@grimberg.me>
Date: Mon, 11 May 2026 01:15:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 7/9] nvme-core: align fabrics_q teardown with admin_q
 in nvme_free_ctrl
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: mheyne@amazon.de, emilne@redhat.com, jmeneghi@redhat.com,
 linux-nvme@lists.infradead.org, dwagner@suse.de, mlombard@arkamax.eu,
 mkhalfella@purestorage.com, chaitanyak@nvidia.com, hare@kernel.org,
 hch@lst.de
References: <20260508133335.98612-1-mlombard@redhat.com>
 <20260508133335.98612-8-mlombard@redhat.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260508133335.98612-8-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260510_151542_776251_4871FD8E 
X-CRM114-Status: UNSURE (   3.63  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

