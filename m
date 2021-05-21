Return-Path: <SRS0=oXoK=KQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E92DC04FF3
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 22:35:05 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 323D26135C
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 22:35:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 323D26135C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EXpqH4Nig7EPiNL718OlXK+Lng35tpXa4aTec/6ceIo=; b=EtFbwNuV3sckmNVcuLoTB34dBL
	R3gihYYpz4gXd3c4t6h/i+z+XBpxdXIowyMyGn/1mnBmOz/VrbLE5Butduo9MU9V8JojLo4BgcJ5S
	V30unU8IIgkihvVS9zs0iV/TMD5edhewmznqiZqP4HK8nnVueZtuZHW1nzmkqwhJK7YhXfytsMTJF
	eZBg128rkqK1tHPIFr70+FguqvCyDFGru1ZjpbZNAIBU3pYa2ee+/QGv/xVdMWfi2JxdZz4BZlpWu
	qgsNRRTk37A1+ewm0ZgNIr/xg4mVtF2KYAF+D0JQOsIZslXCS5gaL9ru35VpiDlZ4WWp72l1z5dVn
	6xlYInCQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lkDj6-001G1b-W1; Fri, 21 May 2021 22:34:41 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lkDj2-001Fzs-Tc
 for linux-nvme@desiato.infradead.org; Fri, 21 May 2021 22:34:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=kUMI2+VJBvrfyxF0TnZrFPg59JKRi9yHzzdOTmyJIwU=; b=i5wqF6tlIByzyo/3JNEkBmpmk2
 n0JQDvVUDDvt1orHZIck6lSToo9rx71ZWtCs2MvsV7063Ly3/i5xuE6WBG1gdnwt57b1VMJv2K+RQ
 3KCwHOzl7ct1DS1ZY8DS75QNDvpT4V2i20CG8f5tppMx4nRU1YRGig2n79sIoI68pqPRXbOoIEFeh
 ZtMavCXTOlKoIAo869rXxUPkYYAUJf8zmKZPmKqjDKgYwjOHSjpvYMxK+srBXwfkT3AdCJEFf+Cu9
 mmRrOthnYYbkxvcdn4sPe0jmD5xZ2UNkYTfsqR4u/yxFcGzwRz4GEj0ZrQua1oveRKusgN9OXIOUl
 1NypKtdA==;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lkDj0-00HTUA-Hj
 for linux-nvme@lists.infradead.org; Fri, 21 May 2021 22:34:35 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 f20-20020a05600c4e94b0290181f6edda88so1290784wmq.2
 for <linux-nvme@lists.infradead.org>; Fri, 21 May 2021 15:34:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kUMI2+VJBvrfyxF0TnZrFPg59JKRi9yHzzdOTmyJIwU=;
 b=qxChZ2OytQTKmNkHHulLW5M14YPpQeEZoFIKKxXmcR4qXkF80o5Y/EeRqQriLkClor
 nMj2Ksc8vAmhkf3NAFDI5um3GFqpG1ZoCi+le+b7WIB/Lq95b1AcfgwTNUlqlAUL1Ri2
 TUWZOsHCnZUQ5UwFyb4+L2PnEgfIp2KtyvB8fJQifICvjg07I62VPf+ODk6oBo2Fu3PJ
 h0tHAM2JJ2iFAIWPWWwkvEM6BMcKZA91yA11Dj17qpODS/S13jQO3tDmRbBcE/t5J2S5
 aQIMq9FBaFcKq/aU40S0O4mGCRW7Knc9gw7VFG5Q73y8BSc/CLdrD6vftirjAg9yAPL3
 VCaQ==
X-Gm-Message-State: AOAM531IDR6o1eqsiFN6NTB1eNNngi29IagR+WBKUGPt9QGSeVqySMIW
 rU+2sEym33g8ffx8qdVgNRA=
X-Google-Smtp-Source: ABdhPJxPwE80Mrjced/fQhx+HqdZxh/zPfQGLdEHSgAltgc+RgEotDdkl7lO2158LySvsdlmQT5rZQ==
X-Received: by 2002:a05:600c:3510:: with SMTP id
 h16mr10257627wmq.38.1621636472746; 
 Fri, 21 May 2021 15:34:32 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:66b2:1988:438b:4253?
 ([2601:647:4802:9070:66b2:1988:438b:4253])
 by smtp.gmail.com with ESMTPSA id t7sm3323970wrs.87.2021.05.21.15.34.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 May 2021 15:34:32 -0700 (PDT)
Subject: Re: [RFC PATCH v5 05/27] nvme-tcp-offload: Add controller level error
 recovery implementation
To: Shai Malin <smalin@marvell.com>, netdev@vger.kernel.org,
 linux-nvme@lists.infradead.org, davem@davemloft.net, kuba@kernel.org,
 hch@lst.de, axboe@fb.com, kbusch@kernel.org
Cc: aelior@marvell.com, mkalderon@marvell.com, okulkarni@marvell.com,
 pkushwaha@marvell.com, malin1024@gmail.com,
 Arie Gershberg <agershberg@marvell.com>
References: <20210519111340.20613-1-smalin@marvell.com>
 <20210519111340.20613-6-smalin@marvell.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8343236b-91d6-a3d7-4abb-c74b993763d2@grimberg.me>
Date: Fri, 21 May 2021 15:34:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210519111340.20613-6-smalin@marvell.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210521_153434_615185_83406C03 
X-CRM114-Status: GOOD (  10.03  )
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


> In this patch, we implement controller level error handling and recovery.
> Upon an error discovered by the ULP or reset controller initiated by the
> nvme-core (using reset_ctrl workqueue), the ULP will initiate a controller
> recovery which includes teardown and re-connect of all queues.

It's becoming an eye-soar how much our transports duplicate code...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
