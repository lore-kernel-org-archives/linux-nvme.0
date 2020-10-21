Return-Path: <SRS0=B+Fz=D4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD5EC388F9
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2020 16:24:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73E3521D7B
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2020 16:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qzPLVhLu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="qAnN66Pp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73E3521D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RiBPeXoUjp8TdHEteJbFEIbZRl/r5s6q9QD0rRLXd18=; b=qzPLVhLuZTF/oDtJZ5jlnl+Xg
	83GzfpruNHdt7SLK1P/YIi2h9Od8LABm3sfyaIaM+E7GbXARJXxyoieEMLfrALEd3+YcZ6Yjyf8ER
	wQIpj22sImXU4zfcuaBhhkv7eDzNuIjYNUvn4Y7pNuqG/S//dVeE60FjfEup1X+A83dzKhSeMpM3P
	hf8R0R+AvuGayQPlNIG78TIxiKzM/nYTAoaCruSaeCeXEiY7uzrypkZq/NpnRUj8ThhOlR/6LwaBI
	qjf/kdoe8CUbmzbLYKKlCADeOzlO5Kftv8g/dgl9PSWU93ICFDEuQf0r8jk12LNf94TYYSY+tDG9u
	1sBIdmMBQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kVGuV-0004Iz-M4; Wed, 21 Oct 2020 16:24:23 +0000
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kVGuR-0004HU-Qo
 for linux-nvme@lists.infradead.org; Wed, 21 Oct 2020 16:24:21 +0000
Received: by mail-ej1-x642.google.com with SMTP id z5so4100342ejw.7
 for <linux-nvme@lists.infradead.org>; Wed, 21 Oct 2020 09:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3gOwLOinKxfS8Q7pKCJNt4sF+c6ZgP4dy5YmMvKFVL4=;
 b=qAnN66PpKcpHn9YzLKihJgVOkQ9RiPSnoahXPav8UFjfvTvYdnOJugMx+Fd4ph9kHp
 Oro5Qq1x7si+5H+KJWJevoJW2PHn8HhJAqRLzFSXOSgl79BDmY2AGJXBq0iiIUil78+M
 QysAFxNAXgaq/Mfg5kA/0QDMB4VRDlGFuK1DSc+fErnKb3L0gfZ+4VEFg0V7CyQQ7Myx
 qeo8gGSTenyT+jW3xqn8pKqyQzwMS+8RqvOWuqowUB5/1uULNeDD9IyXJHsQOwlNL0h6
 4SoyROAEGF6wAKzdCiIMKhtkonzXdK+mP6RB+X4yyJd9uj4fp1tIq731Z14sHGErjeC2
 4AlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3gOwLOinKxfS8Q7pKCJNt4sF+c6ZgP4dy5YmMvKFVL4=;
 b=o0Ytc4rqm8LNBSvHqDHgJencQ8/JN91Ed6j1V18t2r73bQUcTR9JRzsg5+VY8k+5pC
 9b1uFDQDo3oaup+4ikvkhDm3vqSlgm87Sa0lqSZqjJwbt0dXjP4EYJD9XVbBtvn+1qzz
 VbpZPuodZRvk4/QKjSd8XXh7QAuM1PdpV8sH8kuE59qgbe80CDfKYmhwfQXX9rkVMvq1
 dA+xRNDA1t6RyBK5GjSTCasr3G0vUcWB2tS/bW8q3nt5smc0afkaq9LvChCXTEMmoEPd
 /RpvXnGdBUkfTIcrkwnOdx3otGeD9VOJxTyQNOIKSXFRdYJmTgg7doqxFxLddh6W90yi
 RC0g==
X-Gm-Message-State: AOAM531XZzblmHQDLanZjyXEWWWoIfzOCpZUPYmiV3L+TMrbtrypUWPR
 cvsThYGFTFo3Enjfw0IOdO3/1n/1HKzEfI/0smMUMQ==
X-Google-Smtp-Source: ABdhPJxdbZlz7qjHcsJyG3VwrTEzzzv1Xnm7a3x75REVedoliNewQfm4hBXe15u3vhqNhzOv2lGigBFvNc+AOMCjKO4=
X-Received: by 2002:a17:906:c20f:: with SMTP id
 d15mr4164002ejz.341.1603297457480; 
 Wed, 21 Oct 2020 09:24:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201012162736.65241-1-nmeeramohide@micron.com>
 <20201015080254.GA31136@infradead.org>
 <SN6PR08MB420880574E0705BBC80EC1A3B3030@SN6PR08MB4208.namprd08.prod.outlook.com>
 <CAPcyv4j7a0gq++rL--2W33fL4+S0asYjYkvfBfs+hY+3J=c_GA@mail.gmail.com>
 <CAMM=eLf+2VYHB6vZVjn_=GA5uXJWKL-d6PuCpHEBPz=_Loe58A@mail.gmail.com>
In-Reply-To: <CAMM=eLf+2VYHB6vZVjn_=GA5uXJWKL-d6PuCpHEBPz=_Loe58A@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 21 Oct 2020 09:24:06 -0700
Message-ID: <CAPcyv4hj2iPmf4YNdJLZqHMh2B10hbkSnk_9BAAACbG_LFKfBQ@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v2 00/22] add Object Storage Media Pool (mpool)
To: Mike Snitzer <snitzer@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201021_122420_010712_641FCFAE 
X-CRM114-Status: GOOD (  19.13  )
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
 "Steve Moyer \(smoyer\)" <smoyer@micron.com>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
 "John Groves \(jgroves\)" <jgroves@micron.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@infradead.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 device-mapper development <dm-devel@redhat.com>,
 "Nabeel Meeramohideen Mohamed \(nmeeramohide\)" <nmeeramohide@micron.com>,
 "Pierre Labat \(plabat\)" <plabat@micron.com>,
 "Greg Becker \(gbecker\)" <gbecker@micron.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Oct 21, 2020 at 7:24 AM Mike Snitzer <snitzer@redhat.com> wrote:
>
> Hey Dan,
>
> On Fri, Oct 16, 2020 at 6:38 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Fri, Oct 16, 2020 at 2:59 PM Nabeel Meeramohideen Mohamed
> > (nmeeramohide) <nmeeramohide@micron.com> wrote:
> >
> > > (5) Representing an mpool as a /dev/mpool/<mpool-name> device file provides a
> > > convenient mechanism for controlling access to and managing the multiple storage
> > > volumes, and in the future pmem devices, that may comprise an logical mpool.
> >
> > Christoph and I have talked about replacing the pmem driver's
> > dependence on device-mapper for pooling.
>
> Was this discussion done publicly or private?  If public please share
> a pointer to the thread.
>
> I'd really like to understand the problem statement that is leading to
> pursuing a pmem native alternative to existing DM.
>

IIRC it was during the hallway track at a conference. Some of the
concern is the flexibility to carve physical address space but not
attach a block-device in front of it, and allow pmem/dax-capable
filesystems to mount on something other than a block-device.

DM does fit the bill for block-device concatenation and striping, but
there's some pressure to have a level of provisioning beneath that.

The device-dax facility has already started to grow some physical
address space partitioning capabilities this cycle, see 60e93dc097f7
device-dax: add dis-contiguous resource support, and the question
becomes when / if that support needs to extend across regions is DM
the right tool for that?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
