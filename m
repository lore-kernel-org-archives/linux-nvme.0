Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E0DC636CC
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Feb 2023 09:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=knRsFcgKHGb1+L5a0adpr2Bt0r
	mknbe9cc2nZ3nLJJKVRC9XBWSrQkg4HiF51u/VDaZ8XptGohMJmw/A0KlOh+tvzWXZ5yK5lqcsyEG
	XNGtLGg8FQZN3QVpnwqF0dzsrrIfJBnZYORljQO9PDIRjTgdsV6RdhJoup+G2p/xxgixO8SMq22/r
	gHL5PfWXiU/K7GOGaJQlBH6yrTjtJ2h3ykvVdJHbqBMfE+H6z4z3pZnrq4mFdtHF7UjGMq6lL5/Ld
	5pyE05zvRsC6BfNT7DNqqVrPbxQZClL5tm1JHPVSUpBaKy+gJ49sjPBw0S0M1aisoQRMXv8d/5cm1
	nHt/Y2Pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRVJE-00DwJp-Tp; Mon, 13 Feb 2023 09:39:40 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRVJ7-00DwFO-HZ
	for linux-nvme@lists.infradead.org; Mon, 13 Feb 2023 09:39:37 +0000
Received: by mail-wm1-f47.google.com with SMTP id s13-20020a05600c45cd00b003ddca7a2bcbso3128705wmo.3
        for <linux-nvme@lists.infradead.org>; Mon, 13 Feb 2023 01:39:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=2HS4OjfML/RcWNSwu45z07fINyaP8tL1AFyVRQI7UsZktUQ0R/IGvhBgsjStRk4c6d
         +eP44ApDESgA4eu50OO2AxtMzAwACXHHLfqA+37KGCgV4KDfykqX5s1Sip74nXKE/d/4
         qCHA8Mtx+vpPivBSEpzkbSOAbTFRU1gSc1Oahhjgkq4mC2zg4RIqFyOispEX8X6WZ0da
         Y8i1NE6gmdCfQ5IGzkYbXkOPYzgKZ+7UhvTUJjmR1orLDVK5oFjUJ2r4SWgzD8nLulH7
         SQjQoeMBIfQpSSfijR6Vvd9Jr10kXZhx1XGwDziwxFX9glgUJs/D/b0qLBGPD5sVA2iV
         mpcw==
X-Gm-Message-State: AO0yUKUYqPEgKV7RsLblk60RT5pH6P4AYJM1VkpDzwf439NsW2EcTX3I
	RV6qyhy0jDKLnbxqt/SUin38Ho4N2VI=
X-Google-Smtp-Source: AK7set/WeUX3O5QSS2NvoNjQKb8B4CudaZ9WvBIpGPd+CEQFwdSKtJZBiCewzhgTiyfDL10p2uhqsQ==
X-Received: by 2002:a05:600c:198e:b0:3df:60af:8e8b with SMTP id t14-20020a05600c198e00b003df60af8e8bmr22628818wmq.3.1676281168393;
        Mon, 13 Feb 2023 01:39:28 -0800 (PST)
Received: from [192.168.64.80] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id p21-20020a05600c359500b003db06224953sm14209955wmq.41.2023.02.13.01.39.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 01:39:27 -0800 (PST)
Message-ID: <899d9a81-6754-52b5-960a-8a30f1c742c1@grimberg.me>
Date: Mon, 13 Feb 2023 11:39:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] nvme-pci: set the DMA mask earlier
To: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org
Cc: mikelley@microsoft.com, linux-nvme@lists.infradead.org
References: <20230213072035.288225-1-hch@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230213072035.288225-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230213_013933_687553_2492265C 
X-CRM114-Status: UNSURE (   6.25  )
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

