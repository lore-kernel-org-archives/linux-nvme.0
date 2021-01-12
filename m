Return-Path: <SRS0=XnCc=GP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933C4C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 08:40:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2502122E00
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 08:40:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2502122E00
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=O6iBWGpTiyEnKxRXyImicwYQlEJUt1RTHm+F1/alK4k=; b=YjcwkK4tn1nVerxaymRiHSnuK
	VX3kPSazH+NAz6+iNICXuoHvlSBJKt2CfOpSnHEHuC5JsopJHwl6Z/D7GHB9xZiuhwg27u3B1aWv3
	NgQfZjTjlXCc93m0fHr45HWSz2nOqwt/cIv5pT8FJfkJPbAT9gBhcsgJF8gK5TtaLQEtuonms16lm
	/hSrlwz/E4y/O6B+Q5wUUx7+KR1p30hRDrSzRjO9T1kN0x4dRGdE3ru10qPhCjgUD8lM6dyagBK4N
	LvwAeAnlNum+snDNNVFnTW7XwJNzzo+dNDlsEXEsIzeVx/Z9tXTCw/TJn7nbhUwmHeXlC/fYvfSm1
	bMX2ziC1Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzFEM-0007sX-8Z; Tue, 12 Jan 2021 08:40:46 +0000
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzFEI-0007qL-K9
 for linux-nvme@lists.infradead.org; Tue, 12 Jan 2021 08:40:43 +0000
Received: by mail-pj1-x102c.google.com with SMTP id u4so1208378pjn.4
 for <linux-nvme@lists.infradead.org>; Tue, 12 Jan 2021 00:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=omqZVy/gvABfZ7+b0drx/2fujWS9+ptdVwwLKDS11GY=;
 b=u4rHFLRIUi7mvwTwEbRc4ib9FaGpzN9mg5gtsO7vwqUlPizNBINRNWDoficMmbiagp
 6dvoN0stiRwCbtO8p/a25VUyT50xIqNwgDQobCnJYc6xfoPkrwwuqSn+dr9FEip2rZQm
 5AvmToilGFHr7fHe26gvNKW1awzA3L5VnJwS1TzPI+d7hb8BFXgkHnKypDHIrgXOOrc0
 yP/wJnqnmQu0h4Tg8WJ7cbq7EVmLQLu6rNH6UlQhUFXxmiTv7JW9oP6Ka3NnDokBn8Xf
 YivahY4RR5SZGMolR8QKzcrNsTQLH/TuhEXg4Xi9vyUzGbBAbeBmqP90L6EIqDmOadKA
 qAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=omqZVy/gvABfZ7+b0drx/2fujWS9+ptdVwwLKDS11GY=;
 b=s+tSKuBbkBJ8b03ToK4wOGZrrcqQaxV+iozokOWCOdaeISiR6qKkwOmXE0YqQn++fI
 gzqR060L+w+qbhGae+WjiHW0H2Fttjy05kJGpFLod+EhhZ8jAlvYHjHAfycN82YDwS3G
 bRoTY4CNC6TyteC2XQo0uSCCaeojt4AoGUGevSDHrky8+crdYvdGVX2//PFvde4CPn75
 dXfDHREFhLiKNOA9dpB58F0KQSiF0v4VJVHn5xxnoiDeas1Iofc8cbjJGmMtmR8ZzklQ
 f3nKtVLwqC0ds/QedwE2KIVCL/3r2qj4NBdIAQ+q/imcjO2o8wGCEOEZ91KP8d19l5wf
 AFLQ==
X-Gm-Message-State: AOAM532HDT+nSIWpIEzfUqyHKEWlyouyPj/g7Uuphxm1PUt8EoLBZDuF
 Yz9bEnQ0XRqa2ED94XWpaZ0=
X-Google-Smtp-Source: ABdhPJweOj+XTRUnGBkvwjAF9kJDfceF4xifIoDlxZWBS3bMoyTnV+k6kCU4pVVZC+l5k6CVzG2aAA==
X-Received: by 2002:a17:90b:34f:: with SMTP id
 fh15mr3442452pjb.80.1610440840477; 
 Tue, 12 Jan 2021 00:40:40 -0800 (PST)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id x14sm2288999pfp.77.2021.01.12.00.40.39
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 12 Jan 2021 00:40:39 -0800 (PST)
Date: Tue, 12 Jan 2021 17:40:37 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/3] nvme: check all retry delay times in Identify
 Controller
Message-ID: <20210112084037.GA3227@localhost.localdomain>
References: <20210108144659.7126-1-minwoo.im.dev@gmail.com>
 <20210108144659.7126-3-minwoo.im.dev@gmail.com>
 <20210112080840.GC24949@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210112080840.GC24949@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210112_034042_759958_06892E5B 
X-CRM114-Status: GOOD (  16.44  )
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

On 21-01-12 09:08:40, Christoph Hellwig wrote:
> On Fri, Jan 08, 2021 at 11:46:58PM +0900, Minwoo Im wrote:
> > If none of Command Retry Delay Time(CRDT)s are set, then we can simply
> > skip to configure Advanced Command Retry Enable(ACRE).
> > 
> > CRDT selection will be made in Completion Queue Entry that controller
> > has responsibility to decide.
> > 
> > This patch checks all CRDT[0, 1, and 2] in Identify Controller data
> > structrure instead of checking the first one: CRDT[0].
> 
> Why?

I thought we should check whether there's at least one CRDT fields are
set or not regardless to CRDT number (0, 1, and 2).  If CRDT[0] is not
set, but CRDT[1] is set, then we can go ahead with CRDT[1] not [0].

Thanks!

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
