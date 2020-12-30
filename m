Return-Path: <SRS0=bcs0=GC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3CCC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Dec 2020 11:10:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89F2122209
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Dec 2020 11:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89F2122209
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=HqyC3j4a8Fbs1rcQD1sA+JFXvmnJFjy65jUQLC6cY08=; b=yXMOQM6cHjrG84J5miZnoKve8
	s9VwIC3Tx9vWILd/vHMxLo5CIbwbBGUCZjpUh9A6VT7XDgkSmAr83aTLNyzXl35zqEfvRLqdQWMgK
	zpsDzIrHSkfcPaSnbAjoMTqOES67k6mOS8rS+1/mswYCHdrTRCAdQ0uRPdHZ9UuahOvTTCo2mrins
	RsJI2C3WCsUH1iVxlq8Fbd0O134MzO9kaMK7mBg3ahcvlpzXBLuGbcAY5eazH/GBRqAxYvlmAn4WV
	WgxQ9heJxY9zSHtLi5NHI3gNSkHUq0Z2q5Q2CMQkGym4eh3Ja2RMQl3FYP/+3ZrDFRPgxjW7qS/Y6
	dOXtA7f8g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kuZNJ-00028p-HX; Wed, 30 Dec 2020 11:10:41 +0000
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kuZNF-00028N-AS
 for Linux-nvme@lists.infradead.org; Wed, 30 Dec 2020 11:10:38 +0000
Received: by mail-pg1-x52a.google.com with SMTP id i7so11188525pgc.8
 for <Linux-nvme@lists.infradead.org>; Wed, 30 Dec 2020 03:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=68CU2txyoqUZLMbAHcXVjRsVhRCGnPXCsBPsXu+i4KA=;
 b=PfF3w7mU8zsa1TqfPL9WxivM8gD1LU4T8664MuaBkKCLE5lk8i9c/ZHYucHzP+WBfd
 IA0DLEgQoJuaukf5dPjvMCF4TNdwY3N0WWsCFGudxE4c7M0//H5fqb5dKgiL+bSNyQPP
 Qh+PEHLxzweriX9Ui6PxGDQcFVkrOI/XFC0eAQbX2iDXifr70tutPPVP3QQRcEOuoBaY
 xa/dp4j2qi51mq4wgbJKBpUwrtGKg8TeYnBHJ32EHofh1vdAA/MVZtLRPp+0o/En/YyG
 zvMpqMZ7FPe/BdS5qMchfBr/KvWonh/4igZU3xP1UmTc4ELMsCxNrgun70VqDvnLZX0x
 1zjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=68CU2txyoqUZLMbAHcXVjRsVhRCGnPXCsBPsXu+i4KA=;
 b=kRtw96dy5HUzOzKBR/EYsAfXC8y9Bvq/2xqEeSc7X+U5rtqRRCiCdli/VzreWI9OBu
 Fy6IVZ0I4STKdaqHOVF9jB2X1zkmDg5z3aiDsJ7yReDPzZk3E1YxOEJs2azhSb3XWMF6
 XMTwtyD++3MEMy2ni8QOj84lwYCdVDxBoWC/lv+EpYSR8S73o7ASWXggAXOBpvd94w5J
 L/GJTy6R9oGzp0+xPIKaVyzEf5OJA9rJrMB6zFjPsxVnTCCMFgd+8plfieHZOELAt5hO
 MMzdXXX7WpD2ybGn7zTP99U36Iaw3Q8Qwp6dCbzVIMysTmml4qcb6gwx3NAwU3Fl5b5e
 d32Q==
X-Gm-Message-State: AOAM531ra89kTYXszLrvdHnwzzykkGtmEc55GkpyveMd/cI9/9KBPZfW
 hK3mC/CXFediU8F+PHjPubI=
X-Google-Smtp-Source: ABdhPJwWrbTV0gWDASrIlMvtnGS4HrXHAzfB5y6s3qBetFQ+XGsoCuRMWQeOT0ceJ7bEaf9Qw26S5A==
X-Received: by 2002:a62:1d43:0:b029:1ab:7f7a:4ab8 with SMTP id
 d64-20020a621d430000b02901ab7f7a4ab8mr29563911pfd.43.1609326632877; 
 Wed, 30 Dec 2020 03:10:32 -0800 (PST)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id d4sm41825646pfo.127.2020.12.30.03.10.31
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 30 Dec 2020 03:10:32 -0800 (PST)
Date: Wed, 30 Dec 2020 20:10:30 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH] nvme: unexport internal function symbols
Message-ID: <20201230111030.GA7917@localhost.localdomain>
References: <20201227103831.22319-1-minwoo.im.dev@gmail.com>
 <BYAPR04MB496508D70A0F3121191C0C2886D70@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB496508D70A0F3121191C0C2886D70@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201230_061037_472677_7056CFBA 
X-CRM114-Status: GOOD (  14.92  )
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
 Christoph Hellwig <hch@lst.de>,
 "Linux-nvme@lists.infradead.org" <Linux-nvme@lists.infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello,

On 20-12-30 07:10:49, Chaitanya Kulkarni wrote:
> On 12/27/20 2:46 AM, Minwoo Im wrote:
> > Unexport symbols not taken from other side.  This patch also make those
> > two functions as static functions:
> >
> >   nvme_reset_ctrl_sync
> >   nvme_alloc_request_qid
> >
> > This patch has no functional changes.
> change the commit log to :-
> 
> 
> There are no callers for nvme_reset_ctrl_sync() and
> nvme_alloc_request_qid()so that we keep the symbols exported.
> 
> Unexport those functions, mark them static and update the headerfile
> respectively.

Thanks for your review!

I think I should have written some of reasons why symbols are removed.
Please let me prepare V2 patch with comment updated.

Thanks,

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
