Return-Path: <SRS0=58/p=4Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43C0C3F2D2
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Feb 2020 21:08:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95AF6246A2
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Feb 2020 21:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Sg1SLLVw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95AF6246A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z1fMvao11i+d0UZrbIxXcd2/3fEWA/mH8uzwOCutGXo=; b=Sg1SLLVwBMNaHw87+L6NHTiX/
	wA8d6+uW/xw+e36uBTtoH1U50CSUWwsZ8WmvJfUDwoDw2R3/rm0agC4pTaAZe+AXiKSNG7sSRq/C+
	Di3xj/NOzTzlVzSg/062fV5SYLpTzmxbPcudmAs5fNnzXNWO3I5M2uUOUshCwjOoHx6ivN/iy7rI4
	I+WiA118ntYX0TGfS7NpXLRn/TWBMm2qTLIuAIClH8raYKwf+ybp57deNZbvqe6m3NAA0vsU2R1ZU
	1YlI6j7Q/5p+Kx/W1eC9uRMcSUYarvA1RuMH34G7mehFXkIzufsPzqasgSWmWvhZ4eY+Myxf7YOxX
	UhFmEhwMg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j7mru-0006BG-GC; Fri, 28 Feb 2020 21:08:22 +0000
Received: from mail-pg1-f196.google.com ([209.85.215.196])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j7mrs-0006Ap-OG
 for linux-nvme@lists.infradead.org; Fri, 28 Feb 2020 21:08:21 +0000
Received: by mail-pg1-f196.google.com with SMTP id h8so2118726pgs.9
 for <linux-nvme@lists.infradead.org>; Fri, 28 Feb 2020 13:08:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=Us1GGU6bAwidMR+waVOCwaIh0UaIPMKYLAkJQuYeoE4XkvQGcVlUjiUf7K2XnXLwvy
 h3n83pkBZ4sRUbElle6P8sc1A9mVw4wQVyBCgrdyW7Wz+Xg/FmwaCJYWpMUwKMk+nbUm
 DcTOYHyKjc1woT7g2mvbuykbtkK13N5732T/vmYE3GhqcczX1GRNSTx/F3iEtrsB4KFS
 LLQri6fMyJ7WXBscq8WJx8zvxiqZ3uUzRotBUh7L+hG0NnLgg4qR4mOoUTf67jqyT1qS
 ZNsTHCVQdjMMPUfVvH/+Xp1A1nMflfCiXFTWJNba2vx0Z86ZoXB1T/Bl2E/9Ygq3XXdP
 IijA==
X-Gm-Message-State: APjAAAXcrxlv50NgH+L/So+O3MQMshI9CPEFXChwLBa0dmK3xfl49GHQ
 hA7G93kixQ6RfZau5MLQXbcnOUQq
X-Google-Smtp-Source: APXvYqyf2/+xTHCYSFhW4J95sd6Pwt0G0udhry1jSzJT1DMX606rzS0bR1zysqZ5m0K0wflnahmZOg==
X-Received: by 2002:aa7:9ab6:: with SMTP id x22mr6160590pfi.260.1582924099912; 
 Fri, 28 Feb 2020 13:08:19 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:d1b8:1f12:d98f:3f23?
 ([2601:647:4802:9070:d1b8:1f12:d98f:3f23])
 by smtp.gmail.com with ESMTPSA id e189sm6972108pfa.139.2020.02.28.13.08.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Feb 2020 13:08:18 -0800 (PST)
Subject: Re: [PATCH 11/29] nvme-fc: convert assoc_active flag to atomic
To: James Smart <jsmart2021@gmail.com>, linux-nvme@lists.infradead.org
References: <20200205183753.25959-1-jsmart2021@gmail.com>
 <20200205183753.25959-12-jsmart2021@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <45e29b9c-d573-308f-769a-4631c8d63ffc@grimberg.me>
Date: Fri, 28 Feb 2020 13:08:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200205183753.25959-12-jsmart2021@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200228_130820_783505_02C56B80 
X-CRM114-Status: UNSURE (   9.08  )
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
Cc: martin.petersen@oracle.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
