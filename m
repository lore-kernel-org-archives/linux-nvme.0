Return-Path: <SRS0=5twQ=XA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7171C00306
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2019 16:12:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D0232082E
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2019 16:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Cc7WU24Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D0232082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SLUxEjstswUBYpV1USOlm68nauBsI8Xl0DyVnNSbw4k=; b=Cc7WU24Y3XV6FFLXEX1BUOUql
	Of9w1L7lpWxJyZlq4DmK6pHo0fZlirUH9T85iYPLSs4r07E4fdjXiQUwjEZRChp+QecfSHkcJSDKW
	QEAKmsTcQmyvNlcYjGLJYs/kGOUYOvd9DFx5r1W12ku49+Ou2zU6tWMsQSN6KHCcAC32+lg02v0u9
	C9lfGATiiLk8UD5Q7CemsHfjyRhtsNHSCgq6WV5pEF05iuiwNsYMss00MyXmFRLlpx3Qf1cQiUwrY
	3ERClwv5/Qri/8lwS+kagotXQmZBgJh+PnbNGxiw5hHfnt0hEZTHKvvVOVIKdm4Ntd89ODmUllFcp
	jXPYdhzGQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5uNH-0007Y7-SN; Thu, 05 Sep 2019 16:12:43 +0000
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5uNF-0007X9-Kw
 for linux-nvme@lists.infradead.org; Thu, 05 Sep 2019 16:12:42 +0000
Received: by mail-ot1-f67.google.com with SMTP id r20so2753356ota.5
 for <linux-nvme@lists.infradead.org>; Thu, 05 Sep 2019 09:12:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=n9/mVvbc+FJD5lFAC39ToEnsu4tlFlkzdP2wms0HhJ0=;
 b=FCi5zMKcDzAo5sJ5sLYdead89SKzu1qshk+auQlxjTIMak7h8j9zQbnxKrNnXBJjxM
 Y311ZLYQkczdwkiaSt31oX2zxpXq+ks1rRmGeljCKdvLjE/BxhluIC8/Nwft6Sm74H4b
 m4ocTeNDSr0fZHhWCx4w9f+VIjhSzB8Vh+gMccSo4sPWlkhECfN3CXUrY7EeNsT8XUWS
 OhtFzdy+ZSo5hzxKkfhuIxYs5R50bZ3JYETWXhEptRXVJ3K7AgRTMVvm8EvpFhscJ2wE
 bfNaS4WzfPeL9SzcwcU4oEQWZODe9Zw/03/GzWHH9yL6haS+4OPzztpt56tZoKwPOj0h
 ytHg==
X-Gm-Message-State: APjAAAWlnr7gdR5kR2Lj9PNXW4YivKEQebqabwWAIeE0GxI9IecmN68g
 ABRAyiFVMwixa+dOfn5RiRg=
X-Google-Smtp-Source: APXvYqzRcb8W/oZq18yF/qsn+UkujlrvsEZn46ppLsm0+TIemu1nunO3GijvRMpn59nJIjSofzxQZg==
X-Received: by 2002:a9d:7a83:: with SMTP id l3mr2122370otn.359.1567699960205; 
 Thu, 05 Sep 2019 09:12:40 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id 5sm595489ois.15.2019.09.05.09.12.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 05 Sep 2019 09:12:39 -0700 (PDT)
Subject: Re: [PATCH] nvme: tcp: remove redundant assignment to variable ret
To: Colin King <colin.king@canonical.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
References: <20190905143435.2864-1-colin.king@canonical.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2aa4f13f-7d24-ee59-ac6b-ed3dc30d3da3@grimberg.me>
Date: Thu, 5 Sep 2019 09:12:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190905143435.2864-1-colin.king@canonical.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190905_091241_682850_24A1D1A4 
X-CRM114-Status: UNSURE (   9.50  )
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
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Applied to nvme-5.4

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
