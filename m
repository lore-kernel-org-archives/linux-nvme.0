Return-Path: <SRS0=sW0/=5L=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE574C43331
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Mar 2020 09:00:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F51D2070A
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Mar 2020 09:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IQLBZGj2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F51D2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FQfNdUcrdmXfVnOJn8KrdWKA9FVwDQB32Ao6aZ8X200=; b=IQLBZGj2DYx6m22pguA0+CrXv
	Ni4Lqn2ARAmtRseMLnsrk8Y/uTovrMwm+YXYS7c2AcIEqMec2lo6ypa9eYqjDyMQhsX1ws5oCwtrG
	me82xl6BZevetT+q7uS2CcF0rahxmOmCsqeglDdSSTonDJOcK1CbmFYdnUoa/3OdlBwhpS/gmHmjC
	lpCQ7c83TKuCBUtBeevWsdpwqpZs1XQMBT1s9pBf6Si8oNJ94x8CncpoJEJMYLcHA030LQ6SOPURk
	2rok6k5vVKs9YhAx2fbhF0H4vt2u3fSaq+mQ4YxR5hrxcnuwNdV2oPgInu4RcKzT3uDXILhDb2yYL
	2U1b5Rjzg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jHONd-0001Xu-JP; Thu, 26 Mar 2020 09:00:49 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jHONa-0001XO-Ui
 for linux-nvme@lists.infradead.org; Thu, 26 Mar 2020 09:00:48 +0000
Received: by mail-wm1-f47.google.com with SMTP id c81so5565228wmd.4
 for <linux-nvme@lists.infradead.org>; Thu, 26 Mar 2020 02:00:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=58k2WhvscX9wKntlixVpOpCsaCk4DUub20yFRnnGLz8=;
 b=lvGHEBthUhYVmOPOgS5obajKWn/JDOTerapuMKlUsRUI4CQz2IiSDd8labzpRhTrjG
 3nQXi6J/MO+nt2kShdgMc/muamRLyNRQ4i414/2GuzjB4i7iCNJ2mZA5IhE9Hv3tTV/s
 KQEJlJap0ZFzpfOvgtyrndn3/KgeEmLMqFnv4Vn45UDRN+vRELBtLlZjezOmRBc9cT8z
 AmNzNed4adhSsqlTx0zbtLvHi6Dm10/Cs4tRBar1/OQyPi2bKEZpP6eJMWJgQxVZ+qPR
 de3582/EU1Dxlqjm4hS6AA86POg3ZgFHRS9EOM1c3HniLjbpR5ifXCR0O8gAuilH/qjv
 6r4Q==
X-Gm-Message-State: ANhLgQ1vgC5MEy9gzd1Ptl2HkSmP7pP9rVeszLFb02qEMLx8KUWXDkw6
 wfrHklK1Tbbaa4iKCnc96ogjAZNf
X-Google-Smtp-Source: ADFU+vt5nO+/bQSvgDHBXDA2S7ExXGyKl6gZckQp0hfdUR7aq3l2x8Dx7NV6kUOPbjK/IOfYVBYsfg==
X-Received: by 2002:a1c:7d88:: with SMTP id y130mr2122302wmc.5.1585213245195; 
 Thu, 26 Mar 2020 02:00:45 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:2c87:e6f8:1c11:1d73?
 ([2601:647:4802:9070:2c87:e6f8:1c11:1d73])
 by smtp.gmail.com with ESMTPSA id l83sm2542281wmf.43.2020.03.26.02.00.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 26 Mar 2020 02:00:44 -0700 (PDT)
Subject: Re: misc nvme cleanups
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200325131937.1198787-1-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e08d88c6-ef5a-dfa8-6746-ae09295c4a4a@grimberg.me>
Date: Thu, 26 Mar 2020 02:00:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200325131937.1198787-1-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200326_020046_987743_5EF0FBC9 
X-CRM114-Status: UNSURE (   9.51  )
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
Cc: linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Series looks good to me,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
