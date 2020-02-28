Return-Path: <SRS0=58/p=4Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BCDC3F2D2
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Feb 2020 20:36:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25DFC24690
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Feb 2020 20:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z6fOLV2T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25DFC24690
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z1fMvao11i+d0UZrbIxXcd2/3fEWA/mH8uzwOCutGXo=; b=Z6fOLV2TF5UHkAP5gDKQI7qmq
	X+IrznFYgHJom6I/zNbRmElo8S4V1s/F5bPxgwvdCix8VMKwZakWSXib4yaqgGTB0GvpXFdZbpz/1
	Z2yGuFhEOxslICeW8RTkz7lXZ2a5b/JfCka/EFvvbzqNJaVHRqYIAjqDZHsFmBa8hsi0oz+/3LL4f
	j+QyIamoDqt9eRjz09AKhml4H+LAD1JljqpKYRe9jVh1EJr/4mdZ51e5QAMrM3do4iQ2koBQx5Fe/
	ne+QWOERVNF9FfAPDycpBo3aJHe/WhRRBE7tIXiMPQ9d9VWoEv3mqcWwoyc7HWIEApNfoDZxEM5X/
	KCjZRmnNQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j7mMp-0001i9-3H; Fri, 28 Feb 2020 20:36:15 +0000
Received: from mail-pj1-f46.google.com ([209.85.216.46])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j7mMm-0001hs-PN
 for linux-nvme@lists.infradead.org; Fri, 28 Feb 2020 20:36:13 +0000
Received: by mail-pj1-f46.google.com with SMTP id dw13so1748787pjb.4
 for <linux-nvme@lists.infradead.org>; Fri, 28 Feb 2020 12:36:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=UZ/Oe1F27CdCD+e4vwbV0Gwifk7N97fWIqlelG/IRKr4MqjAsk/c3PouDToBND3JK4
 JN0h2CleAFjv5YbfCNpy2CY/eBfsGucTY0HcN/w+PGCJWIU+P4pMHltuzVIa/r72TUfi
 gXT/QSqW4HZx0swMRMNqxttI/sDZHODKx9rvTZApFn83rivQH95NT7OmSuR3OaXpEKd1
 m0tblwAKWyHV+pd2P84gV249T0kce2deW3+APlK/p2/dmYwePbD/RgbDE9mhVtPoe8b4
 DTftdB1GBh8BKbDimmKlo2Zv7fjAJ35LfF9EQUg6TQywtM36v4fLCZIlq+VEiEJWPHwU
 5Kag==
X-Gm-Message-State: APjAAAXtHVGpi614OvrxHWSpTvxepfOSbKcO+WdxTYP0x+DJPmA8f6LR
 WzV2d+Kf3DQLHyJKr7hSxXw=
X-Google-Smtp-Source: APXvYqxdcrOD+hQztTjrGhucKRc5HQIwyz7Ng0/FDFmE+Fm3btwmzFjdExw8JxR0IzG+Cq3ZfP/2HQ==
X-Received: by 2002:a17:902:8b8a:: with SMTP id
 ay10mr5818212plb.288.1582922172034; 
 Fri, 28 Feb 2020 12:36:12 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:d1b8:1f12:d98f:3f23?
 ([2601:647:4802:9070:d1b8:1f12:d98f:3f23])
 by smtp.gmail.com with ESMTPSA id m15sm11007039pgh.80.2020.02.28.12.36.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Feb 2020 12:36:11 -0800 (PST)
Subject: Re: [PATCH 01/29] nvme-fc: Sync header to FC-NVME-2 rev 1.08
To: James Smart <jsmart2021@gmail.com>, linux-nvme@lists.infradead.org
References: <20200205183753.25959-1-jsmart2021@gmail.com>
 <20200205183753.25959-2-jsmart2021@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <9c369f3f-cb71-c730-239f-a114f7a91a57@grimberg.me>
Date: Fri, 28 Feb 2020 12:36:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200205183753.25959-2-jsmart2021@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200228_123612_825785_8D2ACFD5 
X-CRM114-Status: UNSURE (   9.09  )
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
