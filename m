Return-Path: <SRS0=Mmm6=7Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620CFC433DF
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jun 2020 21:07:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3258E20734
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jun 2020 21:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dfP7FFif"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3258E20734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z1fMvao11i+d0UZrbIxXcd2/3fEWA/mH8uzwOCutGXo=; b=dfP7FFifvKMm/hKOe0D/iqvMz
	LJM6pF3zBUbZXVTbdkD3K259mZpcxMFRhTbqMtXIwfPCxHReRe2o39zR1p4mdHrnC3tdKsFkkzkkn
	/hI69QZsxpAOBP5ZE2SuqKbu78hKX/X2lAY8TJdBfTKprNzxS1xvFJ/mjmMcYWbQU8mtcKlvFzz0U
	t7jW7Af+d5Ty9nTzStnqjXl++uwqpfbhLv1yjx5M7gr9iydVxdSowAVaaAnDlDqZsHP9dqVJOZKBl
	BDBFLlrDfFdaHKrewWoj4sx8GLwXOh1qBBjzOB6mv0zkgx1zi43QMu/XiiXmuOWN7lCUeHPgH9AQF
	/GKydgYgw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jgaba-0000Ll-AC; Wed, 03 Jun 2020 21:07:22 +0000
Received: from mail-pg1-f195.google.com ([209.85.215.195])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jgabX-0000Kx-5s
 for linux-nvme@lists.infradead.org; Wed, 03 Jun 2020 21:07:20 +0000
Received: by mail-pg1-f195.google.com with SMTP id o6so2545983pgh.2
 for <linux-nvme@lists.infradead.org>; Wed, 03 Jun 2020 14:07:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=U2co1IN5kvS6HOvIrnWKyCnsUgXb36dkQWtYraY+gPPQM9lgHMIEc+4CtJo4XVheXH
 creflltE6jOXljBzR39enG7zKaXH2P6dxMQ8f4ox0TjKorsGSwr00mzU9PtN1e1wEbIU
 sHwsuHwfPgiurKNz6nzqN5nOzS0nMe8e1JSZ3kTT8ptkig9068HHCkSKQfsyYuAiNg6r
 BpDHoNGuUmD79e4P9BieiryY86/2Th0SMtHmvMQOcjj8Gcs7O0lLpls8M8LDeR/9yJqQ
 /i6QGQC7AQh6Pv/ISF60qAVdldodFTAvNJq6w7FTJWDyWpGaXiG7ojaLAExi613KySlt
 Q4lw==
X-Gm-Message-State: AOAM533+7uhynqqKmlQssC0WqqMuix55o4D//uHePBFWs6JNpJ51ufAf
 8CtbF9fuJdU8JtR9pn8r/cnJPtoU6p4=
X-Google-Smtp-Source: ABdhPJz2sNdB6TgrVYK4AAZ7LMOKXHzMsWmYBYifbEU67iZ0i3KGTIDTxAgusHBxBl0VQQ60G+gT/Q==
X-Received: by 2002:aa7:80d0:: with SMTP id a16mr1051457pfn.188.1591218437954; 
 Wed, 03 Jun 2020 14:07:17 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5409:1488:6d95:bdff?
 ([2601:647:4802:9070:5409:1488:6d95:bdff])
 by smtp.gmail.com with ESMTPSA id t4sm2199776pgp.2.2020.06.03.14.07.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2020 14:07:17 -0700 (PDT)
Subject: Re: [PATCH 1/4] nvme-core: use u16 type for direcives
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20200602024114.5153-1-chaitanya.kulkarni@wdc.com>
 <20200602024114.5153-2-chaitanya.kulkarni@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5e67ab10-c6a9-aa8d-3fcd-a15c273f7dba@grimberg.me>
Date: Wed, 3 Jun 2020 14:07:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200602024114.5153-2-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200603_140719_217206_C905968F 
X-CRM114-Status: UNSURE (   8.69  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: kbusch@kernel.org, hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
