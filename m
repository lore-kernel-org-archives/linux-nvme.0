Return-Path: <SRS0=K5Lp=F4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC62C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Dec 2020 10:29:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F99E22228
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Dec 2020 10:29:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F99E22228
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lOGShIN168F1bO5PqiGj+7vsXHXjPHbQbU6wJAttxWU=; b=N0Dv/tbmPEN475j1zTtXvb1i8
	TgGlYV7+UJcHm5IQy2LvgtlAlyPqYkdOQZRaf/GsjjJL3t+iMErUnMQc1V/SNdUIRBQdsCGnQda/V
	78RtSwqMQe+h+nm+nlcK6IslZNCB4E4ZHdQCCfqqZNJJCHJMm98UCUlAtjqKguoJ3Ms69kBwLfmbg
	Pi8zYljiLfDo4v7xbkQ4qvXHNFKigewEWoNDQmxxiryD8EjTZX8IBuUlWWNVkYFcLhjuGtEpOK9es
	5wtBWEUlXhRLbV7g2aF+mB+urRICFIp/C5cWLx8gK5RW3NcpumGFC4i2sXqqLvYtnFHbANKho7dXv
	UlNQVgqZg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ksNrt-0008DY-TI; Thu, 24 Dec 2020 10:29:13 +0000
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ksNrq-0008Cr-T3
 for Linux-nvme@lists.infradead.org; Thu, 24 Dec 2020 10:29:11 +0000
Received: by mail-yb1-xb2e.google.com with SMTP id v67so1944019ybi.1
 for <Linux-nvme@lists.infradead.org>; Thu, 24 Dec 2020 02:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LseoGloo/fGGCMefHJyF2TU1M0NScN8reyYKbDo9kNE=;
 b=lIvCKH9gRm4EAbs8HPvgg5tuZU05frEWJnCl+U/go3BD1WWIi5EDsZzYoSN4po0+p1
 mXWfCbUgtXncgfVHV2JCtNa9DMggeECYaMlcd6GC9RMH38fyf44ZFRW3XbVUyd3KPsNn
 +Nfg3W85ffA7EKpCYFUFc33wOBr5wdhklEuSPUVCmNkTeMC1abkFkQklU2uPuVt1lZqb
 liz8PAnJgzU8eDMTb6CSen+rmJmKL8+G0pByWJu1Dn/UeAWD3CT48wkr8nyFHteiDtiS
 hs5l829E4k8ataoowuBC3fcFT+M2WPEVi/eSNfhgriNOuYTRPaQ4KVlfDqYyUZrg9jJ5
 sZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LseoGloo/fGGCMefHJyF2TU1M0NScN8reyYKbDo9kNE=;
 b=l1fdINUXUv7fH4LE3WQKR96jyE/CSb5c2TdSP+6kZUsHal4NrywXhcnQ4jX1IufvSe
 WZkluT5PwuYYu9oaKLec1QgNXsKUqwHZDGLEhyfokc/62G+RRz2+1lDw2lYlnX1LZ4Yb
 KvifqVNNy/T7bStD+kri52HdXo6FmQDisNzil7BilwclVP5OQ+2mxwAM+WMS7Jc7snnq
 wzGWPre2krAVIe/64zUxtcxTRcWxVBJ4kdnXrPw9ppEGt7DDCIwTF/mLZD31OxWzLXfR
 9gzlaSTvhvHntwNXxcRY0QzalxtZ1TxUtj7Pj7f+vKKNJptfEJB/QRnOzKa8aHu7vVVB
 FbrA==
X-Gm-Message-State: AOAM531NXB4vm7hsJXzeYCYtJ00DeVUOnSUVA7MAfqFk7omfhxvMJWnm
 89w6+LkrzkNVf4TgoKjQhpRO9mbNTXrBoRAXXdo=
X-Google-Smtp-Source: ABdhPJzfcg21XFq//CGPapzbcgn+sd+qFUTbZ+F1EJEoPxBKVPpMd+67SRmyEz9gJzVoJMkj1n6BRRzFLRDyRlfhK/k=
X-Received: by 2002:a25:6ec3:: with SMTP id
 j186mr42671231ybc.165.1608805748957; 
 Thu, 24 Dec 2020 02:29:08 -0800 (PST)
MIME-Version: 1.0
References: <CAJS6EdjsTVgs3JK3q2DePjEz1A0s9RJTOwqo=Ka7kinNMECtJw@mail.gmail.com>
 <2c0ff5ec-4ae2-ad29-67fb-4744514dab47@grimberg.me>
 <CAJS6Edh8aVAHhKRGqU+7v5C3KY7YxczVg_7Q8QrPGtyvVw7K3w@mail.gmail.com>
 <fd4541e4-78c5-ec3b-b272-467fd11f7472@grimberg.me>
 <20201223084332.GA30502@infradead.org>
 <CAJS6EdijX6ws_wHxygdpcYGtB6JFwLDbDE3A0t0QUYS-LbRakg@mail.gmail.com>
 <16d876c1-524a-38d3-3cff-99ec694464b2@grimberg.me>
In-Reply-To: <16d876c1-524a-38d3-3cff-99ec694464b2@grimberg.me>
From: Hao Wang <pkuwangh@gmail.com>
Date: Thu, 24 Dec 2020 02:28:57 -0800
Message-ID: <CAJS6EdivEF0c=3FmKj4wGZoVRKbUvjH_qJLXmO7Tvwsp+km0rw@mail.gmail.com>
Subject: Re: Data corruption when using multiple devices with NVMEoF TCP
To: Sagi Grimberg <sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201224_052910_988506_592D10AA 
X-CRM114-Status: GOOD (  20.40  )
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
Cc: Christoph Hellwig <hch@infradead.org>, Linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Sagi, thanks a lot for helping look into this.

> Question, if you build the raid0 in the target and expose that over nvmet-tcp (with a single namespace), does the issue happen?
No, it works fine in that case.
Actually with this setup, initially the latency was pretty bad, and it
seems enabling CONFIG_NVME_MULTIPATH improved it significantly.
I'm not exactly sure though as I've changed too many things and didn't
specifically test for this setup.
Could you help confirm that?

And after applying your patch,
 - With the problematic setup, i.e. creating a 2-device raid0, I did
see numerous numerous prints popping up in dmesg; a few lines are
pasted below:
 - With the good setup, i.e. only using 1 device, this line also pops
up, but a lot less frequent.

[  390.240595] nvme_tcp: rq 10 (WRITE) contains multiple bios bvec:
nsegs 25 size 102400 offset 0
[  390.243146] nvme_tcp: rq 35 (WRITE) contains multiple bios bvec:
nsegs 7 size 28672 offset 4096
[  390.246893] nvme_tcp: rq 35 (WRITE) contains multiple bios bvec:
nsegs 25 size 102400 offset 4096
[  390.250631] nvme_tcp: rq 35 (WRITE) contains multiple bios bvec:
nsegs 4 size 16384 offset 16384
[  390.254374] nvme_tcp: rq 11 (WRITE) contains multiple bios bvec:
nsegs 7 size 28672 offset 0
[  390.256869] nvme_tcp: rq 11 (WRITE) contains multiple bios bvec:
nsegs 25 size 102400 offset 12288
[  390.266877] nvme_tcp: rq 57 (READ) contains multiple bios bvec:
nsegs 4 size 16384 offset 118784
[  390.269444] nvme_tcp: rq 58 (READ) contains multiple bios bvec:
nsegs 4 size 16384 offset 118784
[  390.273281] nvme_tcp: rq 59 (READ) contains multiple bios bvec:
nsegs 4 size 16384 offset 0
[  390.275776] nvme_tcp: rq 60 (READ) contains multiple bios bvec:
nsegs 4 size 16384 offset 118784

On Wed, Dec 23, 2020 at 6:57 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> > Okay, tried both v5.10 and latest 58cf05f597b0.
> >
> > And same behavior
> >   - data corruption on the initiator side when creating a raid-0 volume
> > using 2 nvme-tcp devices;
> >   - no data corruption either on local target side, or on initiator
> > side but only using 1 nvme-tcp devoce.
> >
> > A difference I can see on the max_sectors_kb is that, now on the
> > target side, /sys/block/nvme*n1/queue/max_sectors_kb also becomes
> > 1280.
> >
>
> Thanks Hao,
>
> I'm thinking we maybe have an issue with bio splitting/merge/cloning.
>
> Question, if you build the raid0 in the target and expose that over
> nvmet-tcp (with a single namespace), does the issue happen?
>
> Also, would be interesting to add this patch and see if the following
> print pops up, and if it correlates when you see the issue:
>
> --
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 979ee31b8dd1..d0a68cdb374f 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -243,6 +243,9 @@ static void nvme_tcp_init_iter(struct
> nvme_tcp_request *req,
>                  nsegs = bio_segments(bio);
>                  size = bio->bi_iter.bi_size;
>                  offset = bio->bi_iter.bi_bvec_done;
> +               if (rq->bio != rq->biotail)
> +                       pr_info("rq %d (%s) contains multiple bios bvec:
> nsegs %d size %d offset %ld\n",
> +                               rq->tag, dir == WRITE ? "WRITE" :
> "READ", nsegs, size, offset);
>          }
>
>          iov_iter_bvec(&req->iter, dir, vec, nsegs, size);
> --
>
> I'll try to look further to understand if we have an issue there.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
