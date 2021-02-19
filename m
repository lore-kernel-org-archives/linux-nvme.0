Return-Path: <SRS0=4MGw=HV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91244C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Feb 2021 21:27:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F08C3614A7
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Feb 2021 21:27:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F08C3614A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DlTpxR+4prVqsvxlivNUlgasFB/ldjoG8ZcJ7CKprQE=; b=ZpZwIyMX1rsdH2SnW4BsXFyxk
	Zc74Dblcmrx8SsYCNZAVb67dJeGcH6S6p+CgQQY0SD/K1ccI5FXGZz0ktWmrOwM+QdsKT+Qf0apJG
	RwMyN6F5uweb45cHon3PNFAZggHj/HTAhHjMNxdq0it2O1Q5gxPca6lA1FYxTbrtpKccayWyLj5rP
	TKiLdfiZYi+MDz9nYAJiMSWdcw/kZcDXcHT4R7MhRkAgUmeuIr7rAtba9AyESlVw+jZ+ILZ6dySAx
	znu+FK8VKBXt6DPmnA8KsYDXMso9Ox4I8/1kA5AhqbulI/FxJObcOhmcEGttavRE7jgUkpGNRg6Ps
	G5gdmI7BQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lDDIU-0007W1-3C; Fri, 19 Feb 2021 21:26:46 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lDDIR-0007Ve-PT
 for linux-nvme@lists.infradead.org; Fri, 19 Feb 2021 21:26:44 +0000
Received: by mail-pl1-x634.google.com with SMTP id f8so4077531plg.5
 for <linux-nvme@lists.infradead.org>; Fri, 19 Feb 2021 13:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=3C74G3YVTvWHzK/ZQjDVMaLaiL6scZFTz8Wa0+4I4vE=;
 b=KBv+ZnhVGAk9MmS5W+sLeOwDoYmkcRlrlegjL5j9kx3sE9ErCghgEZZ9yEtMjBmAVb
 s0tC53SNNMYledEcAgXqbCKVOfiAlGUcSN1z1MTsSKIy9vrlf4Oes07GBoNRCZgjTBcj
 ctTpnLSsULlz0k1vv1rGa/sUM5E+raV+hKO6tNRmO/LjRvin+M67lwurWbicLTYCbwKS
 8OX4ow+ukt06UN7kVTKUcakhThYuRIPycCzsudkGE9jjDYwKhYtz/iSpE6gbxyXWiVUU
 +xDfW2pirzXwdkO+0Iy2lU9wvVtc3A1OFh/I4F0zQ1EwsWXTynArj9n3SogVqsqHpowl
 /Qmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=3C74G3YVTvWHzK/ZQjDVMaLaiL6scZFTz8Wa0+4I4vE=;
 b=FCga6yQfvdvqBpi6t5DX2BOZ9Y455FInGJHsxPgMQo2911v7ntq0/DV1UYt5Jcll1g
 rtM4JjqBx6M254jITuHNAZ0BlSlfFAZ6OGdZ7Ys8txT4bFNX7JIaPtHGeGqEI555KpNs
 gsZQrZVMlyVZJ1p3BoZZxtauswQrUrEGpO8xUMZihPMYXUyZJPc/PmHFvXGyVxacyy+x
 Borqfi4VLNWVIwS5aMaTIBFgM25J/12YFyuXwjAd4phvfIb3P7GDqVHyEcuw3mXGTKuQ
 BvqBtd3D2KZWxC7btzbLoVsy3K5w0h+Y7+J3uvRcYkM4lysa6I86JuAyF1UrbG7I18Rh
 aRzQ==
X-Gm-Message-State: AOAM530llkA14FRtwJXfnUmSK6Q0Dx+a0f7JGOB+ntEt+/UgV/+/E4hU
 1dCRIwGQCFB46zcq35aAYiE=
X-Google-Smtp-Source: ABdhPJx13xMcml5wBHSx404eNE3NhEuKmFDUcqfKkwGMMHawaRnvl5H/4lSYQJfjezhANEfLM93xbg==
X-Received: by 2002:a17:903:22ce:b029:e3:c57d:aaa9 with SMTP id
 y14-20020a17090322ceb02900e3c57daaa9mr3958803plg.7.1613770000112; 
 Fri, 19 Feb 2021 13:26:40 -0800 (PST)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id c9sm9110118pjr.44.2021.02.19.13.26.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Feb 2021 13:26:39 -0800 (PST)
Date: Sat, 20 Feb 2021 06:26:37 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: introduce passthrough ioctl for multipath
Message-ID: <20210219212637.GA175471@localhost.localdomain>
References: <20210214110126.24023-1-minwoo.im.dev@gmail.com>
 <20210214110126.24023-2-minwoo.im.dev@gmail.com>
 <20210215170233.GA2707454@dhcp-10-100-145-180.wdc.com>
 <20210216095147.GA2601@localhost.localdomain>
 <20210216175722.GC2708768@dhcp-10-100-145-180.wdc.com>
 <20210217021455.GA2251@localhost.localdomain>
 <20210218084014.GA17997@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210218084014.GA17997@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210219_162643_865996_CA4A1F76 
X-CRM114-Status: GOOD (  14.11  )
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
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 21-02-18 09:40:14, Christoph Hellwig wrote:
> On Wed, Feb 17, 2021 at 11:14:55AM +0900, Minwoo Im wrote:
> > > A container could read data from namespaces assigned to a different
> > > container.
> > 
> > Now I got your point! Thanks Keith, please ignore this patch :)
> 
> Note that Javier has been working on exposing access to namespaces
> with unsupported command sets for ioctls.  If that is what you are
> looking for.

Thank you for the information!

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
