Return-Path: <SRS0=GfOp=4X=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36786C10DCE
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Mar 2020 22:12:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06248206CC
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Mar 2020 22:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VwPeFZVJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06248206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z1fMvao11i+d0UZrbIxXcd2/3fEWA/mH8uzwOCutGXo=; b=VwPeFZVJ5uedWV7v99xYA6dhH
	XBPvaO4Ax6pt7P/xv2d9kSHiyvzDqWvYZoVgARRKax7OqbQRdoOd5FTkGdgmF7i9kBgZdqOH6bLyn
	Dh+Cs4uE49qxcCYWMFgLeHNP3VdiBTfBnGF2LHI0a7+haQJEQ+3Su1Cs3OBxnvP5sEjfcCWbACwg1
	am02eSnthijMHPhcV2WcsJI4E5vTLsU09fegShYj4LIO4lCWwFURfQh8bsIPxQ0iLlDRtODNYnxkQ
	SzFjeiAtI2foXx+ean5ULTAKfiEfb4J6vsJ1+UJET0bARquBnmERBhvAU0xZU4HEfOBTc3jjOMC5H
	Q/0LlNWvg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jALCr-0008CI-8e; Fri, 06 Mar 2020 22:12:33 +0000
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jALCo-0008Bc-OO
 for linux-nvme@lists.infradead.org; Fri, 06 Mar 2020 22:12:32 +0000
Received: by mail-ot1-f67.google.com with SMTP id a20so4033485otl.0
 for <linux-nvme@lists.infradead.org>; Fri, 06 Mar 2020 14:12:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=ecN/hwcLclL1YE/ElbTCOl8WkLHMkSWjuZzvsPpFDOjidwikcqKSeSzekTIGoJcoFL
 xZiODOHvpl1yje0hBKQaZzbdOu21siW+eT4sE4/uSTRvwYDd9/fDxWzgmUH9ub5I1PfD
 cy/8642xo0m9pXQYR1klFXjhlKvnM8WSnV1nnmaT1DtLSbtDlOg/Lz7Nfm13aoPxHM17
 jAW03XaP51z2wQx3MWJrLEHt+t7YJVztjcp3Ic7grTgCuRY5rlzKrvDz/ZOwQ52hj8UD
 rmysUxy8MllO8N9NAyAySPSuFQ5+os7D9u6FKIATE8ZbYzpIP/s5atgAdk9X9F9JBjH4
 AdiQ==
X-Gm-Message-State: ANhLgQ36P1WyPcmN1e1G6gPdEZ3MhIr+Ynujp0XW1VKEHdSReKsiSL02
 ahieYmn6mv897o1/EuJglveXOaP9
X-Google-Smtp-Source: ADFU+vu4vi4wsSyXVsDE68reOwCnI/pyIf8lGznB4aUjzGCfly1o6ESJi/JOkV4HfRIMikqykue1Ag==
X-Received: by 2002:a9d:554c:: with SMTP id h12mr4481648oti.16.1583532748990; 
 Fri, 06 Mar 2020 14:12:28 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id n2sm267066oia.58.2020.03.06.14.12.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 06 Mar 2020 14:12:27 -0800 (PST)
Subject: Re: [PATCH 2/3] nvme/fcloop: short-circuit LS requests if no
 association is present
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
References: <20200306130440.16864-1-hare@suse.de>
 <20200306130440.16864-3-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0ec7bd78-9bd9-a3c6-ff52-515aaa574c6b@grimberg.me>
Date: Fri, 6 Mar 2020 14:12:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200306130440.16864-3-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200306_141230_790124_700F08B6 
X-CRM114-Status: UNSURE (   9.70  )
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
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 James Smart <james.smart@broadcom.com>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
