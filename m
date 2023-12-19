Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C16DC41535
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 14:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=k9Ut98o0Rl9Ei+Wm6T72h9hZE9
	TpMmw6wGPZQzld4Sq4CpzdQgba3QeSsh6MDP2musKi28hfgBzhqhgF96eiurv0p7OKipB750yJj/+
	wmiWabg/9kpL19FgaDTGTI07HLLe06b+OT+by4IDaNoAi2rTVK6vUAsU+Pb9XSHE7paZKZg4+8WvR
	N/8RnCOjTbnVYuCaP9HTGx+bo13IUoAXv62oiv4PAPYmJVPhqupOFXyxX8annin/CyRSFj8If5fJg
	XPcEOchpeRVl7Py8yvMHb5IsJWiHLeJ01R61h/Haf/cd98JHq/q8wayDd7ciAJZF8tA0aXBjkTz1F
	3R+VcPPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFat9-00EKC0-0E;
	Tue, 19 Dec 2023 14:16:03 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFat7-00EKAt-0t
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 14:16:02 +0000
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3366047d9a8so556556f8f.1
        for <linux-nvme@lists.infradead.org>; Tue, 19 Dec 2023 06:16:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702995359; x=1703600159;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=A2FhIqvgUl6l7SR2Jf3EPtP6xqV4u8MCTp6gVx3UChHjsX7ZIWNPplbGc4TsrrbDL5
         5k4kvSzbByJBTiDhj/F1aPZw81rXXfc3GK3X4tFX/IAo+fANkLY3JP+YZY/zc8pbzErv
         BL8eXCmmUFSlqiLEnA9QVA/k27vS85jRQDKSQwrvDeaLVpB87P711UiCsmD6Vntw8mDu
         dM1+sw6nyS3Slev3+1026gv5+MVYeuEw8PIl3p4YXvLASunz3+IO+kOUl+CoYZdgoQxP
         zpEFbOBYNyvOS+cgwgsS8UboNizMMsbw+Crv7GFZps5ZdxenojXF+eScvAut6uyyizzj
         4qrA==
X-Gm-Message-State: AOJu0YzJl2lle9efawTGIwEcJSUtPaPz6NBeK/GZMMFPgzFTReN0IsEP
	iFlPxkcrtRx5ibiw8aUmMIM=
X-Google-Smtp-Source: AGHT+IE/6FjPq9dOsW08pWoWGNu8dnMSxOfVRcZKIKozNwkajZZzOBUgAMoOXistX/uEMZSgILzD4A==
X-Received: by 2002:a5d:6288:0:b0:336:74f3:3873 with SMTP id k8-20020a5d6288000000b0033674f33873mr946345wru.7.1702995358845;
        Tue, 19 Dec 2023 06:15:58 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id q18-20020a05600000d200b0033671314440sm2046380wrx.3.2023.12.19.06.15.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 06:15:57 -0800 (PST)
Message-ID: <fe88c1a1-d0fa-4f50-ab91-957d940fcb3d@grimberg.me>
Date: Tue, 19 Dec 2023 16:15:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "nvme-fc: fix race between error recovery and
 creating association"
Content-Language: en-US
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org, hch@lst.de
Cc: james.smart@broadcom.com, Keith Busch <kbusch@kernel.org>,
 Daniel Wagner <dwagner@suse.de>, Maurizio Lombardi <mlombard@redhat.com>,
 Michael Liang <mliang@purestorage.com>
References: <20231218162410.1087788-1-kbusch@meta.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231218162410.1087788-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_061601_310260_AAB65918 
X-CRM114-Status: UNSURE (   4.98  )
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

