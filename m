Return-Path: <SRS0=GXcx=5N=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D082C43331
	for <linux-nvme@archiver.kernel.org>; Sat, 28 Mar 2020 02:12:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D06482076B
	for <linux-nvme@archiver.kernel.org>; Sat, 28 Mar 2020 02:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KD7KLX1l";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sFaLKsO0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D06482076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=b8mSv9zZoJChMw1dCBrxoRF//N/xpq2V3EbZi+enqPU=; b=KD7KLX1lPgQAa1
	cV48iyLXhXErEL4+nRA2LN/SZtAXh6nedkdmSpcHmeS7Fqj4bkWLr1WhejRycRRYQzk9LtEE8vahX
	v7lEMApuQadIfLlE1siYsjohE4Az+tlV8VA7/A7fu0NG4iiOjbfYm7RwOopCxY4M3Xv95QOlKCfXu
	SqD4/Pkxuh9V3KBAOA/X3xpJRK8YYMyTWBC8qaBEYnBrfWQc9G4a5G/SZH/BXsZALnKwFEsZTx+2/
	LM187vaSNI931cwsBl3T2pkSAroeCcB9U0ql4kPP1UzfNOFenGImeXQKT8aIndLp4NMqxoMINDp8p
	N8ZyUzk/63SpwNp2NRhw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jI0xN-0003fQ-Ia; Sat, 28 Mar 2020 02:12:17 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jI0xI-0003ez-PP
 for linux-nvme@lists.infradead.org; Sat, 28 Mar 2020 02:12:14 +0000
Received: by mail-wm1-x344.google.com with SMTP id f6so8225909wmj.3
 for <linux-nvme@lists.infradead.org>; Fri, 27 Mar 2020 19:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=A/DOwGlq77kSeP4sy4KWSZr4DI/jrj8vkZIgJxq2wxQ=;
 b=sFaLKsO0B1asOYx6CZzraFrL8vCx/JKwHn8CzUlYAq2cex+3Qr1n3ZAj3v01GJI6hR
 7wVRC/D8xXWYyoNqRBfd0VVgCOIbIereEVqM+NTTmO3CnqQFmTfgjjnAm5Z6c7O5fq2q
 bTPTM+wsYxfk9iuDMiktlq5xTK/n8In6GVz2X43LfNlDvwZ8X1/d+wI6Y+RoQbS58Bv5
 XIVMLnHkUsThgIzrSUgMYFjJpyyBWOci3e3dfQnYUyeCyRNfv7rsTiwIrFI/IbzaWf0d
 jUUeQDTOxi9aPICgrMaA06srZGN/5dTtypeMVfFzQH5EHRgmcgWX6A58lrs09oGZLxio
 9J+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=A/DOwGlq77kSeP4sy4KWSZr4DI/jrj8vkZIgJxq2wxQ=;
 b=cxdRCL8U0fwzvXn5o7jvsuhH3Vji3lqAxcRbNMCXiKYFVu/JGAT856KADclEbpoAxN
 pmSRVEaO8rLK6FV5m6QujvY42Fm9236aepPjkOpV6NkTPcg2vuM8A/zGLQ0Qu0u6+pok
 WB+69u4Zg2w9/rbr/1fTmezIV6KDRyOos/RD011geYmmoIy/QxXSzkpWgNucK7//+6H3
 2qCxqqGNaIoblrlNzXauDwtfuQnopL1C1TUkIuy6h/CVxeXI41f/UvyPf1Y1WshPlgJC
 D2l6VWbiIgH3jmKpYK2pys8KN7xPprPbfPEeVaZLvMROHL/p/+aL3lZRfQznsmK0XXu9
 0Qxg==
X-Gm-Message-State: ANhLgQ3o84QUgYGbBcM0PyNEuICnAXHTXU9KKit89YEzyFfBe/Va/AdX
 WCvmoCdRJHXEgxV0/VmQUPkoEbH5yrFtHrRxN/AZ5Z5yJMk=
X-Google-Smtp-Source: ADFU+vuabhaHXmflsA/2lDMhKPUJLSaV8Pmr1H1oT2n52e77OAV9Vl6OQd+eI84i5QJN+qyP96N0v+9h/rBxBJSYLnA=
X-Received: by 2002:a05:600c:10ce:: with SMTP id
 l14mr1732074wmd.161.1585361529430; 
 Fri, 27 Mar 2020 19:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200323182324.3243-1-ikegami.t@gmail.com>
 <BYAPR04MB4965BAF4C0300E1206B049A586F00@BYAPR04MB4965.namprd04.prod.outlook.com>
 <cff52955-e55c-068a-44a6-8ed4edc0696f@gmail.com>
 <20200324000237.GB15091@redsun51.ssa.fujisawa.hgst.com>
 <6b73db44-ca3f-4285-0c91-dc1b1a5ca9f1@gmail.com>
 <dc3a3e88-f062-b7df-dd18-18fb76e68e0c@gmail.com>
 <20200327181825.GA8356@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20200327181825.GA8356@redsun51.ssa.fujisawa.hgst.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Sat, 28 Mar 2020 10:11:57 +0800
Message-ID: <CACVXFVM=rT=86JrmAkySTg=gknfFL8Q1NU0uXWzoDMKMyL_mow@mail.gmail.com>
Subject: Re: [PATCH] block, nvme: Increase max segments parameter setting value
To: Keith Busch <kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200327_191212_849535_80D771CD 
X-CRM114-Status: GOOD (  18.80  )
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
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Tokunori Ikegami <ikegami.t@gmail.com>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sat, Mar 28, 2020 at 2:18 AM Keith Busch <kbusch@kernel.org> wrote:
>
> On Sat, Mar 28, 2020 at 02:50:43AM +0900, Tokunori Ikegami wrote:
> > On 2020/03/25 1:51, Tokunori Ikegami wrote:
> > > On 2020/03/24 9:02, Keith Busch wrote:
> > > > We didn't have 32-bit max segments before, though. Why was 16-bits
> > > > enough in older kernels? Which kernel did this stop working?
> > > Now I am asking the detail information to the reporter so let me
> > > update later.  That was able to use the same command script with the
> > > large data length in the past.
> >
> > I have just confirmed the detail so let me update below.
> >
> > The data length 20,531,712 (0x1394A00) is used on kernel 3.10.0 (CentOS
> > 64bit).
> > Also it is failed on kernel 10 4.10.0 (Ubuntu 32bit).
> > But just confirmed it as succeeded on both 4.15.0 (Ubuntu 32bit) and 4.15.1
> > (Ubuntu 64bit).
> > So the original 20,531,712 length failure issue seems already resolved.
> >
> > I tested the data length 0x10000000 (268,435,456) and it is failed
> > But now confirmed it as failed on all the above kernel versions.
> > Also the patch fixes only this 0x10000000 length failure issue.
>
> This is actually even more confusing. We do not support 256MB transfers
> within a single command in the pci nvme driver anymore. The max is 4MB,
> so I don't see how increasing the max segments will help: you should be
> hitting the 'max_sectors' limit if you don't hit the segment limit first.

That looks a bug for passthrough req, because 'max_sectors' limit is only
checked in bio_add_pc_page(), not done in blk_rq_append_bio(), something
like the following seems required:

diff --git a/block/blk-map.c b/block/blk-map.c
index b0790268ed9d..e120d80b75a5 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -22,6 +22,10 @@ int blk_rq_append_bio(struct request *rq, struct bio **bio)
        struct bio_vec bv;
        unsigned int nr_segs = 0;

+       if (((rq->__data_len + (*bio)->bi_iter.bi_size) >> 9) >
+                       queue_max_hw_sectors(rq->q))
+               return -EINVAL;
+


Thanks,
Ming Lei

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
