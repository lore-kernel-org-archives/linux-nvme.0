Return-Path: <SRS0=Rbl5=MJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB77C636CA
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Jul 2021 06:08:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 336FB613C4
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Jul 2021 06:08:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 336FB613C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TyIRpVI4RvgmfcFyKZOZIhBTgpxrMm7PQImlKxYTHu0=; b=F1XUOa91pLoYh41f84och+u/5B
	9X25Zus9s3hHq3ZxehFv4QzkC3PyV8GPZj2OqfZnX6RGD8FaW1v7mqKbHPr2imnz3UsCZ4t/feAFA
	tW1qpogJ+UNoTv+0OH9IbK19mhI9znRnhai8Wq4rVF21ORHcaoipR4eTZlFws5aOahuFtiljAPH2n
	kouW5oBJ3VKCK5hC6Ij4BVrwn8DEOTTKykbK6nDqf6IV3ERcSFCJ4UF13QvqZZ3zsymZfmipXnKbh
	Ov4GrAUg7NvhBYQDESWvoD+EsMOVmxMr7P7oycn21yYzN+RHwDBtXgCnzgFKXvCXY12Ce1OXDUC6w
	WxPmREzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m4dV0-00620U-Q6; Sat, 17 Jul 2021 06:08:30 +0000
Received: from mail-pj1-f42.google.com ([209.85.216.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m4dUy-006203-66
 for linux-nvme@lists.infradead.org; Sat, 17 Jul 2021 06:08:29 +0000
Received: by mail-pj1-f42.google.com with SMTP id
 x13-20020a17090a46cdb0290175cf22899cso2101201pjg.2
 for <linux-nvme@lists.infradead.org>; Fri, 16 Jul 2021 23:08:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7oIpjjlNp3WRf5oo4fvh6ZKEozEtaUWbPUQq7Ygs9vE=;
 b=Ujy8ODQ46DjLUO/Y2qPwDMiiKXSidZf6Nc1jBya33L7Ws3L2GIFsxaEwuk2Sd3A87U
 4ptAlJaQKRIygZ5L//Za5nBVKtSwSH1eVSZ9/gJqdsg4nN04mmiM2J23IxJQdAFwOXsK
 yD1wruf2AS2bvDlhVkWQ65NBikAZiViNrXCCbLNAE/k8a7TNc92E2T+Ghw6coDzwNwom
 qvytJ/MzEOSFMBgFe+juCb6J0HkwUl6MVmu3nPF/prQFD8gpoGJ2s59kCYXg2vbydzVT
 WjwCmpdw+F7Ksv/dvv/4+amFWjY9CUszVDFY/5T/vFyERf7QJG/fLSuBNVqL1A3VW7PZ
 Esiw==
X-Gm-Message-State: AOAM531IA7MLkHt/XK0agUP1GPdxIx3DKi+Ehyws0QaTsu7AdxJY3jvh
 m+zJp1+Z+ajFbUtZv9PYgVVq4mjTHls=
X-Google-Smtp-Source: ABdhPJzeUQ1Gh2h8ZGgLLZuk5O1+ggANUfqHOqWfKdIw7Ppkw1lJYnlvw6iX53Ac4wrjIJcLDg8l7w==
X-Received: by 2002:a17:90a:28f:: with SMTP id
 w15mr13537190pja.70.1626502106462; 
 Fri, 16 Jul 2021 23:08:26 -0700 (PDT)
Received: from [10.0.0.146] ([162.211.128.122])
 by smtp.gmail.com with ESMTPSA id i1sm12010601pfo.37.2021.07.16.23.08.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jul 2021 23:08:25 -0700 (PDT)
Subject: Re: [PATCH 01/11] crypto: add crypto_has_shash()
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org
References: <20210716110428.9727-1-hare@suse.de>
 <20210716110428.9727-2-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b6723b88-07d8-228e-ea36-533608087672@grimberg.me>
Date: Fri, 16 Jul 2021 23:08:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210716110428.9727-2-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210716_230828_279032_C8D96D19 
X-CRM114-Status: UNSURE (   9.12  )
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

> Add helper function to determine if a given synchronous hash is supported.

Can you add more info in the change log? Who is the consumer
and why is this needed.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
