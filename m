Return-Path: <SRS0=neNW=HY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35075C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Feb 2021 15:58:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D83BC64EC3
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Feb 2021 15:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D83BC64EC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hhGk8C52pUnlmhdr9s7y+DcCxuREiAgSfbN4ajSbJbs=; b=AJAxOt/7aUcutA/Tnv4nyzVtc
	h2A9Ksdn/8zyI3tJCHr5yV4K3jnefqNrrk4SXRL3Z771iuHtNnXePwi4AVOknWMWUPU/FVZd3D05z
	rfELjIt7iin4q5oQiPYFyrB0IqBKWL9r+g5Br0DcPAIZ94fcwG8uV6EYPHGd7MF1ERgMwXIYSKuJt
	MkwcqKVm+XDTpLanZR+I668lfra71xskFFBTRx20nmQ1ZMFhNTDyybb+A8ZmF5UaXSC1fJ52Z9Zkz
	68xkZHO8mMduI/279tM03t8jgTtSJhzJZ573lWvOJYrAbJ9X5HxCm9xiIld+jqqft8IA68b/9oGwo
	udvzFK8aA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEDb5-0006wY-49; Mon, 22 Feb 2021 15:58:07 +0000
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEDb3-0006vY-1v
 for linux-nvme@lists.infradead.org; Mon, 22 Feb 2021 15:58:05 +0000
Received: by mail-ed1-x52c.google.com with SMTP id q10so22649200edt.7
 for <linux-nvme@lists.infradead.org>; Mon, 22 Feb 2021 07:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eqt4tyVUm6sFFSl2X77cgXFxmGm9zkPl59fYAb4UtLM=;
 b=CRGzM9snCLPk0WcXCIhX/L5eaQ49/xpzBacwDJLahWleNBDO+XJsBkpdLGp9kguzNz
 Scu4+dMvFBSh6DuJgtkw6J8FBzj5SZ5UExMOQD++T2jBuwCNKJdRcVHgrLfx3m2WDTsv
 WFKIJk+7uIq5nf7FW9GOotYbtPcypKJ3yZuZnj6VqyBa0tQcsY6sXD8Go6SX3nxK676O
 rn1Qxl7xUt29Ssr577+0saPIioLrKs8jSpb2ornKbVURE2X3vMaMfHDPxKAyNZxfJMVQ
 nLaSu0D9wtfIW4jgsqT+m7YmXQxYTBn63lFDgkuoKeYUtiLJTgdckMD1kekyxN2AV2Vk
 UHpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eqt4tyVUm6sFFSl2X77cgXFxmGm9zkPl59fYAb4UtLM=;
 b=l/RGnCbGwr2oBA7w4/oOhqKqN+ppOgmlK5kxI6XnPtsBlKDnrRzmU3sZV2EETZCtQa
 1OK6ADN+Yow7ux5XlIv1H+X+RQ8M221LzfMCdfT1cT0liabirzQKBXsV8LgvdG5NM29e
 2Wf+RjLnNPQhmtsWWH2pGTcINLXYczpp23jDNft0WQwDeq68BmS6Se5glcMU5kXPelqF
 tTufW9E+dLrHBELSJ9Q52S60c0GfGr2tVxkJg9/SK6xblqDwZ9Ml/UHgnMlBQvri23hL
 iD+n3M4UDJGkNsq6o55nPMFh+3ho/Ah9WWUMWejHEX5vaNO/KVxBisaHPIcUcNA7Atz+
 4Stg==
X-Gm-Message-State: AOAM5323wmjAmHUSRTzcNWS+VMUtBVIlcv8ZKPkkergbsLTzfagVKz0G
 XAjEVYTuogoLluwGrJG1SxKfKyMuoggcSbpiUus=
X-Google-Smtp-Source: ABdhPJwZCZVZf9WeJRPU+J8UGCkToLST5tkhlxw8G27fU8a5k7VbjCKgwE2fc0X960Ko9awC2JIhDm7WjyG+QPkPyN4=
X-Received: by 2002:a50:cf02:: with SMTP id c2mr23026578edk.333.1614009483256; 
 Mon, 22 Feb 2021 07:58:03 -0800 (PST)
MIME-Version: 1.0
References: <20210219124517.79359-1-selvakuma.s1@samsung.com>
 <CGME20210219124608epcas5p2a673f9e00c3e7b5352f115497b0e2d98@epcas5p2.samsung.com>
 <20210219124517.79359-4-selvakuma.s1@samsung.com>
 <20210220033637.GA2858050@casper.infradead.org>
In-Reply-To: <20210220033637.GA2858050@casper.infradead.org>
From: Selva Jove <selvajove@gmail.com>
Date: Mon, 22 Feb 2021 21:27:50 +0530
Message-ID: <CAHqX9vYdz-SRP2y6gzR1ei5WukNGzWhrHrvtXo4L8iFw4Lb9Hg@mail.gmail.com>
Subject: Re: [RFC PATCH v5 3/4] nvme: add simple copy support
To: Matthew Wilcox <willy@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210222_105805_131260_20269019 
X-CRM114-Status: GOOD (  12.90  )
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
Cc: axboe@kernel.dk, Damien Le Moal <damien.lemoal@wdc.com>, kch@kernel.org,
 SelvaKumar S <selvakuma.s1@samsung.com>, sagi@grimberg.me, snitzer@redhat.com,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 nj.shetty@samsung.com, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, dm-devel@redhat.com, joshi.k@samsung.com,
 javier.gonz@samsung.com, Keith Busch <kbusch@kernel.org>, joshiiitr@gmail.com,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Matthew,

Maximum Source Range Count (MSRC) is limited by u8. So the maximum
number of source ranges is 256 (0 base value). The number of pages
required to be sent to the device is at most 2. Since we are
allocating the memory using kmalloc_array(), we would get a continuous
physical segment. nvme_map_data() maps the physical segment either by
setting 2 PRP pointers or by SGL. So the copy command sends two pages
to the device for copying more than128 ranges.

On Sat, Feb 20, 2021 at 9:08 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Feb 19, 2021 at 06:15:16PM +0530, SelvaKumar S wrote:
> > +     struct nvme_copy_range *range = NULL;
> [...]
> > +     range = kmalloc_array(nr_range, sizeof(*range),
> > +                     GFP_ATOMIC | __GFP_NOWARN);
> [...]
> > +     req->special_vec.bv_page = virt_to_page(range);
> > +     req->special_vec.bv_offset = offset_in_page(range);
> > +     req->special_vec.bv_len = sizeof(*range) * nr_range;
> [...]
> > +struct nvme_copy_range {
> > +     __le64                  rsvd0;
> > +     __le64                  slba;
> > +     __le16                  nlb;
> > +     __le16                  rsvd18;
> > +     __le32                  rsvd20;
> > +     __le32                  eilbrt;
> > +     __le16                  elbat;
> > +     __le16                  elbatm;
> > +};
>
> so ... at 32 bytes, you can get 128 per 4kB page.  What happens if you
> try to send down a command that attempts to copy 129 ranges?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
