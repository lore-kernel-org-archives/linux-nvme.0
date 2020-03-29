Return-Path: <SRS0=sr50=5O=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2824CC43331
	for <linux-nvme@archiver.kernel.org>; Sun, 29 Mar 2020 03:01:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E713C206DB
	for <linux-nvme@archiver.kernel.org>; Sun, 29 Mar 2020 03:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rfA8cty7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQaDg0k6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E713C206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=99EPXq3SbnMZLxBbecXIMIofwwvx7pbjovN/6MWxj1Q=; b=rfA8cty7X0lGqm
	uEOc8bBmdu/bbSxqsOJASfCpgqaxoXdggSGy1vizNcatMKGZO1S2NFvjEczb3sejCLGpVSh2n37Vq
	DyRJE2TxoxfFgjajI9EG4dedY7iHMOnaeZ0krNypqyiJqXWpqv6kEZGbkorATEn/Mudv7WsddA7C0
	xh0Db0igMe4XWLqMNUEeyyYXujwfMpTbnk4XBAhL7GRAz52Sv4AnZrGuU3XhFv3DzuQbuKGIz6wHs
	OJs0ISw/Dex5DqSwJ3FwpcOu9tNLx/01HnX0W3hJcIZJUGLQS1V/JgkaRJEvPfgyhzGJLin9Av/TN
	uK1Sltpac2KvCgVBqtuA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jIOCg-0003cG-FO; Sun, 29 Mar 2020 03:01:38 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jIOCc-0003bg-9Y
 for linux-nvme@lists.infradead.org; Sun, 29 Mar 2020 03:01:35 +0000
Received: by mail-wr1-x444.google.com with SMTP id h15so16758468wrx.9
 for <linux-nvme@lists.infradead.org>; Sat, 28 Mar 2020 20:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1lnvHlmuRhQDgbhidJay1W7MqRCYIekQtHxcuUYunGc=;
 b=fQaDg0k6NNEydB/Vwc6ZgcOr9ajs3qeROL8o4CVMWHnZ8xb9aNMq+R8DmFxIi+lHYR
 z9UI+48eAAXCeELACJs0zfc3/2XbMcoYBq/MRMabsI76SYF8lGsrpHI0RF2BzmmTDtQ0
 g88vUde84PiGG0/JGV2A6SKI0qDUMdLJda9fee7py044DgQJrIwYqAZ3iKVSexJFCP7Z
 HQfptT23QpaPweLz6VULdPyD3RYWKET0BrCuJ+oKynRoouh+9b+1bVGnmDAukNOzjW0+
 8vyJzOiFNP59YEBKe6HcqL952a+Esa/BBPGH2AzJZu2fTv1jN6lblMsyLD8EtulwA3xP
 6KCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1lnvHlmuRhQDgbhidJay1W7MqRCYIekQtHxcuUYunGc=;
 b=PVsJrohDAN9SiaVfnv+Z/e8xmSc6vYjtd2qqUb+hMYvIjbY1FGgLS/aHC/5bD+mS50
 115aFyiVAU8Nzxgyo8T984kU5Dm32Da9E19dqH6FRZhVUDiNbrJUuypZl5cRVrWZkrgP
 4iC8vaf1Kf88AK0am4gXARx1inULAubB1b0vbZ+43EcJ2o1Z2pK/jHpkn9f0jUdAtZ1I
 pLrjcN/+m0C3u1WG8Bk8/wnOc6PqX2NFyB2rJO4P5y83KA069pJPTBoTpRfPPtkD9QpI
 cLf+Qnd1d+Yt5ZdUtWeCOVKIuLbUC8tsl2C2HEX2qUflAMtMZVOMne8+KohuDq6vhePw
 dk3Q==
X-Gm-Message-State: ANhLgQ2loDU9yxCnAbefP9QYDmZFbJljzvt6GGx0/YVIlUezU9aPT0kQ
 zfx6LBfcQpHyrtDxGWzfZgqvqIXN7J2iqDA3IWY=
X-Google-Smtp-Source: ADFU+vu5Dqu6Zgyd4KVxIX4B2sh8GgdQB0nnr4vbkA1gIb1fJ6uacc8qBLVRgembols/s/FlJqniWUhihsy9sih0V2w=
X-Received: by 2002:a5d:6742:: with SMTP id l2mr8031333wrw.124.1585450891310; 
 Sat, 28 Mar 2020 20:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200323182324.3243-1-ikegami.t@gmail.com>
 <BYAPR04MB4965BAF4C0300E1206B049A586F00@BYAPR04MB4965.namprd04.prod.outlook.com>
 <cff52955-e55c-068a-44a6-8ed4edc0696f@gmail.com>
 <20200324000237.GB15091@redsun51.ssa.fujisawa.hgst.com>
 <6b73db44-ca3f-4285-0c91-dc1b1a5ca9f1@gmail.com>
 <dc3a3e88-f062-b7df-dd18-18fb76e68e0c@gmail.com>
 <20200327181825.GA8356@redsun51.ssa.fujisawa.hgst.com>
 <CACVXFVM=rT=86JrmAkySTg=gknfFL8Q1NU0uXWzoDMKMyL_mow@mail.gmail.com>
 <a0e7a985-a726-8e16-d29c-eb38a919e18e@gmail.com>
In-Reply-To: <a0e7a985-a726-8e16-d29c-eb38a919e18e@gmail.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Sun, 29 Mar 2020 11:01:19 +0800
Message-ID: <CACVXFVMsPstD2ZLnozC8-RsaJ7EMZK9+d47Q+1Z0coFOw3vMhg@mail.gmail.com>
Subject: Re: [PATCH] block, nvme: Increase max segments parameter setting value
To: Tokunori Ikegami <ikegami.t@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200328_200134_359475_485EBB17 
X-CRM114-Status: GOOD (  19.57  )
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
Cc: Keith Busch <kbusch@kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sat, Mar 28, 2020 at 8:57 PM Tokunori Ikegami <ikegami.t@gmail.com> wrote:
>
> Hi,
>
> On 2020/03/28 11:11, Ming Lei wrote:
> > On Sat, Mar 28, 2020 at 2:18 AM Keith Busch <kbusch@kernel.org> wrote:
> >> On Sat, Mar 28, 2020 at 02:50:43AM +0900, Tokunori Ikegami wrote:
> >>> On 2020/03/25 1:51, Tokunori Ikegami wrote:
> >>>> On 2020/03/24 9:02, Keith Busch wrote:
> >>>>> We didn't have 32-bit max segments before, though. Why was 16-bits
> >>>>> enough in older kernels? Which kernel did this stop working?
> >>>> Now I am asking the detail information to the reporter so let me
> >>>> update later.  That was able to use the same command script with the
> >>>> large data length in the past.
> >>> I have just confirmed the detail so let me update below.
> >>>
> >>> The data length 20,531,712 (0x1394A00) is used on kernel 3.10.0 (CentOS
> >>> 64bit).
> >>> Also it is failed on kernel 10 4.10.0 (Ubuntu 32bit).
> >>> But just confirmed it as succeeded on both 4.15.0 (Ubuntu 32bit) and 4.15.1
> >>> (Ubuntu 64bit).
> >>> So the original 20,531,712 length failure issue seems already resolved.
> >>>
> >>> I tested the data length 0x10000000 (268,435,456) and it is failed
> >>> But now confirmed it as failed on all the above kernel versions.
> >>> Also the patch fixes only this 0x10000000 length failure issue.
> >> This is actually even more confusing. We do not support 256MB transfers
> >> within a single command in the pci nvme driver anymore. The max is 4MB,
> >> so I don't see how increasing the max segments will help: you should be
> >> hitting the 'max_sectors' limit if you don't hit the segment limit first.
> > That looks a bug for passthrough req, because 'max_sectors' limit is only
> > checked in bio_add_pc_page(), not done in blk_rq_append_bio(), something
> > like the following seems required:
> >
> > diff --git a/block/blk-map.c b/block/blk-map.c
> > index b0790268ed9d..e120d80b75a5 100644
> > --- a/block/blk-map.c
> > +++ b/block/blk-map.c
> > @@ -22,6 +22,10 @@ int blk_rq_append_bio(struct request *rq, struct bio **bio)
> >          struct bio_vec bv;
> >          unsigned int nr_segs = 0;
> >
> > +       if (((rq->__data_len + (*bio)->bi_iter.bi_size) >> 9) >
> > +                       queue_max_hw_sectors(rq->q))
> > +               return -EINVAL;
> > +
>
> I have just confirmed about the max_hw_sectors checking below.
> It is checked by the function blk_rq_map_kern() also as below.
>
>      if (len > (queue_max_hw_sectors(q) << 9))
>          return -EINVAL;

The above check doesn't take rq->__data_len into account.

Thanks,
Ming Lei

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
