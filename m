Return-Path: <SRS0=L5xI=6O=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD687C47247
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Apr 2020 23:36:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94F2C20774
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Apr 2020 23:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nd7flYCI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94F2C20774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z1fMvao11i+d0UZrbIxXcd2/3fEWA/mH8uzwOCutGXo=; b=nd7flYCIy3Hvvy3BsfHnOJUgg
	jTvZFHbm8F6F4VGjLKLO/LRJ00ZDPD0hJfc2NLQBPMtkF3PT86aIJl3Y2TTLQKdY41kscKxpCTpru
	BIQc9RpPXSbehl80FB/JL21ibe+4a34PcFVBHYDJ9UgpJYb1uCrMuCQ6SqlQWCxU21YRGsrV+Pcv5
	j5dImioNk5oU3LnMW6YxNzIj4mCYikSBNQxEs+W2wGaOgwGfGngNBmwZxK9S+GpdPN7sOEyjmjzsP
	AaOtxW0H6s26gX7GNMHL6WUtISJ+mSWErzWFZDf5aSajLa2R6jGeMq1SslX4bLbgqoUlODGFT3EcY
	yPNF162XQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jUIjT-0005sv-D6; Thu, 30 Apr 2020 23:36:43 +0000
Received: from mail-pf1-f196.google.com ([209.85.210.196])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jUIjQ-0005sc-5L
 for linux-nvme@lists.infradead.org; Thu, 30 Apr 2020 23:36:41 +0000
Received: by mail-pf1-f196.google.com with SMTP id p25so735117pfn.11
 for <linux-nvme@lists.infradead.org>; Thu, 30 Apr 2020 16:36:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=DWqfSYU0hHA+tXYvRPH3cS1t+U3V2ucOGKa4Ipdtl8vTCke/ShH+F+XaCYmO8tFpsj
 +hcrcL26HFQaUKxbwiNwZQVPZ9UqxLPx9+Sj4gcsPx64s1mNP5rraNalQphr/UJE1u/f
 n/6r/k4RCBsPiWTwFJ2wuBEuAK5LnPKe4Na+e32qjqFMUdFdMbiGFuP1nAnSCKd28Qjr
 Ur78OqokFd2iVcJWZEFX9nfup7GC9P/06W3rGFnEiPsykJJemudeRSBylDoeZc2Dn3z3
 B06F9FhJmM2ijRJaO4MuZlRFlV4ydFbP0VAbgb4zRfJCr2oW9SarCibyUyNb1zXut2HE
 mAMA==
X-Gm-Message-State: AGi0PuZzh4L8B9YZgO2aY55MxQd+Gnta/DIDwr+7s1XGq2EkJ8h0jIer
 5vX6o5U9U6gI6Q8d0Lta/t7u9gqd
X-Google-Smtp-Source: APiQypJTAjwNEGBlPF+x5FJ7MtX+jIFw0XeVUGM3ijMwNkTDWPNvDrB7Jm5n2P6/Uosx7PyDzwfakQ==
X-Received: by 2002:a63:e64d:: with SMTP id p13mr1373939pgj.240.1588289798728; 
 Thu, 30 Apr 2020 16:36:38 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:7c3c:3588:d5ec:d94e?
 ([2601:647:4802:9070:7c3c:3588:d5ec:d94e])
 by smtp.gmail.com with ESMTPSA id a129sm741280pfb.102.2020.04.30.16.36.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2020 16:36:37 -0700 (PDT)
Subject: Re: [PATCH] nvme: flush scan work on passthrough commands
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, hch@lst.de
References: <20200429203123.31302-1-kbusch@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0e813bf1-ee6b-aa06-d3e7-80ee5e35df84@grimberg.me>
Date: Thu, 30 Apr 2020 16:36:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200429203123.31302-1-kbusch@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200430_163640_199150_24990F09 
X-CRM114-Status: UNSURE (   7.97  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
