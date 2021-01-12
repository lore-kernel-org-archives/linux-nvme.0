Return-Path: <SRS0=XnCc=GP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C18C433E6
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 08:47:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A03222D58
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 08:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A03222D58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=D2W0T3Xrn66K2Fja8JtHVyUsNKNozFbIPS2b5QEbv5I=; b=X/myNLNaPF/j53UwlsQjBkFo5
	tng5IbvvMrsnl8hgEHQa4dLhfwBCZwAoEVCZVO74DIe4NQofp3dKjz0Rn5AI80hXmmCPEIeySE3am
	4V8ADqIzh5/ltPRR2Q/DCh+1WZUdPt4tE8zBYX4FLsNC2AOeMkaw7RYHczli20qMM34CthuTrMgOR
	eXeGy1yG/89G1yC8ChsXJKgNfn+FcvC8pJNfSrrxndXgEK/jQuCvUfoMovrM8vQjzy82VpkKbLUXZ
	JyiKlYR8kY0M5CX6fAoWNadbw57RPZdki0N8QmIQNHlJCm0nqtOYFFpINbsrNuxJzlgev2bOJ/j+b
	agrRGpTGQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzFKy-0001vA-8Q; Tue, 12 Jan 2021 08:47:36 +0000
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzFKu-0001tO-D0
 for linux-nvme@lists.infradead.org; Tue, 12 Jan 2021 08:47:33 +0000
Received: by mail-pf1-x431.google.com with SMTP id x126so979937pfc.7
 for <linux-nvme@lists.infradead.org>; Tue, 12 Jan 2021 00:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Cxe1nq4uM5uEQ7e4KI6Jzh0OMVkbCPYUAkKc91SWoDA=;
 b=QPmwVg8BSiM2/2Ku4vA3hgXqICxRgy3wUBlPjyqMvuuZi75WfEdId1vlAKUWSNrRAc
 q0ySBLj42GxLtrBwyzLNawWx/gQ8OTnrjZaiywVkBIgVeaz96UGzFRn6z/HW1swDOwX3
 xAXfLvy51evlWT3BlXelcqyRvq6z+Op+Wut6grv6zL4TNulr/xC3pRR1031pL9mJYBRe
 2w4x6mw4lkD/dPj7djRHQxFCKTa3l/8D3jaUEBiU6RutJrFr4tFFgvAGhjSfXgOm5sRi
 tngkAMXwA/nDasE61NcbsbhHSeBFXG3V628C2ZM1tfcGIs6kRjVT6mzsQG4JC2vE337W
 Rpxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Cxe1nq4uM5uEQ7e4KI6Jzh0OMVkbCPYUAkKc91SWoDA=;
 b=eHntemAcIO77JYYcY8wHRGW1CMle1Exv+1PMLi5vBN0xQSAI60ww2rcZjWbScxewZy
 zrRxLYuovf1EZ5BMSk0h/mUjd8EONqXUYdTrpD+2SY1Oep8XZel8y9QtpzWnpT3rrxUN
 BoeW4w+ZiES2bul3/isvkO1iRFZmd1KmEMNL9+ApDn8vLCXJblV2JF85a9QNYve7oXh+
 2VYAbkTWy9UQQ9ChBZAFi8OXceYdbpCnOos+I/R56ZgFDXQhuLDqxAGGZCzEprq5SuMT
 oWupKJ6dHa57WQIDzMcG+402is7KRJBhmSMp6RR33GfNG7kRo5NkHJR6QKE9SyTlOdGp
 M0uw==
X-Gm-Message-State: AOAM531tp98Q/Bus8qaCJd6SSlu+MZ36cgQbidY3yMg2O3TcsyxE+6jJ
 mC1ahjG6CKMLWn5BjpwOqQU=
X-Google-Smtp-Source: ABdhPJxojn/9pwQXeUabSaxPfWqIxQDCI3GCj/JfjbayB8NL3BqPJV9QSKzk+8v5pU6O3l9kFHECTQ==
X-Received: by 2002:a65:6450:: with SMTP id s16mr3684520pgv.71.1610441250406; 
 Tue, 12 Jan 2021 00:47:30 -0800 (PST)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id b5sm2307445pfi.1.2021.01.12.00.47.29
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 12 Jan 2021 00:47:29 -0800 (PST)
Date: Tue, 12 Jan 2021 17:47:27 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/3] nvme: support command retry delay for admin command
Message-ID: <20210112084727.GC3227@localhost.localdomain>
References: <20210108144659.7126-1-minwoo.im.dev@gmail.com>
 <20210108144659.7126-2-minwoo.im.dev@gmail.com>
 <20210112080653.GB24949@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210112080653.GB24949@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210112_034732_509787_9D666E95 
X-CRM114-Status: GOOD (  11.50  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello,

On 21-01-12 09:06:53, Christoph Hellwig wrote:
> Except for the little wording issue this looks good to me.  I'll pick it
> up for nvme-5.11 and will fix up the commit log.

Thanks for the fix!

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
