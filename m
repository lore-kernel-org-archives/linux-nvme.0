Return-Path: <SRS0=YADc=KM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DA1C433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 17:16:33 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA0DC60232
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 17:16:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA0DC60232
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6g1WcSq5fjyRhjMxZ0E68A+B0mz+skM0wWxYKMDc7Yk=; b=l1L50ox/odcvWTTqRsnhBuN01
	eBrkzBF6J7AHh4iNUdJ9iSu1Y+7+1B0IqQTDHE0nWdWm3efn1jHFbWBTy2c08em8BslJ6uK4LcKAV
	IF1OoIUa8mQkh160rhLJGycdTN/1Coz7dqa2pon2wGgIGKtmCnysjAZrqh+u/NezQe2Pu0R+OFOCs
	MPlfu8XblO4iD2D8mCLLXgtVHGtlaxHTbEG3P1mdiQnJvmHgmc3IxnyYgsAos+0pCdWbWNDnCSrqs
	I8UPM6qLqdWeSlAsAbKj1Ky0rZOXIsew//wMaO3cEozk8eVOmRJeAtxjve4uHtNC4TmZNEX231ZB1
	DL5etjhhQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ligqV-00Fc3q-Vm; Mon, 17 May 2021 17:16:00 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ligpN-00Fbl5-1v
 for linux-nvme@desiato.infradead.org; Mon, 17 May 2021 17:14:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=priScSjTLVvBK7rA83Y37kSshwzUOURBJKzWMFTiGd0=; b=Ol0e/NFku4uF3amF7Xw9qOXOFK
 nVEzYr+Vq/LuGhPdh/rm5WlQgw7U3vfFkGhv9ZCLGlFSZGI5VrVgIO0gvORUghNYXllAgHlXJKPcT
 tkd25RFdi9gwdLHYb71mtt4nwxO6+kc9ES3yva2GVfsz/7adG+KYE9nP8GyLCDxTtQDOa8OoOWrBg
 quVUG22PEhspROSBkUu5d1/6Tk2NiufSX2px7ratMKNd5eesQh2ugx/2uVLtv6Q1zblZ+6T1D0KHO
 wPRaKKEv6eBtqj9Z4tBbmjov7oNXLN1RxIOLd74LY9EA8fW7GNAOnH9JkJu3Nd9TtrrVYwgF52PEP
 OQvNXyHw==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ligpK-00E0WC-F9
 for linux-nvme@lists.infradead.org; Mon, 17 May 2021 17:14:47 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8AAFB61285;
 Mon, 17 May 2021 17:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621271686;
 bh=gBtObo7/6QCuct1lI++nwYijYXvNSZxZRKnFoAxtAao=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kSQoNpEzzPp+Q0SofRiLXMc0x3ZPAL+arkcesSexgSMntO9Fna3V2SaJZPhTI6KBZ
 b2C7Kf9Rz3L248yMzoX5X0V8AxOJ1Zk/D/FDwcSaO0j0iiSQzSDfFpNDoZSFc13oSZ
 j3aXTQGyUvvHhMKe/AmYwiAq74AcbzYYvFGr0c+lOhh24gPyiRc8ZWM8DcIBO7CGan
 oS97aRCXaM+PuQO5X7B+uj5FrEhE6enVHqtCfYJJn6P+//Y174GtbS8PRdctB2RyHt
 mBoSpJPXee2IBfHZtXCJpcut0+v+3/zwdEQoqIhB2oFcLDDsrjqOJDq3z+QwLrju94
 CHIFZ1eiAKmJQ==
Date: Mon, 17 May 2021 10:14:43 -0700
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshiiitr@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, Yuanyuan Zhong <yzhong@purestorage.com>,
 Casey Chen <cachen@purestorage.com>
Subject: Re: [PATCHv2 5/5] nvme: allow user passthrough commands to poll
Message-ID: <20210517171443.GB2709391@dhcp-10-100-145-180.wdc.com>
References: <20210423220558.40764-1-kbusch@kernel.org>
 <20210423220558.40764-6-kbusch@kernel.org>
 <20210426144316.GE20668@lst.de>
 <20210426151537.GB12593@redsun51.ssa.fujisawa.hgst.com>
 <CA+1E3rLD7Zx2iKtUoTBVc4VXBj2ohXFeXSw59umBZ3Q=QEA0xQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+1E3rLD7Zx2iKtUoTBVc4VXBj2ohXFeXSw59umBZ3Q=QEA0xQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_101446_552624_35EF3C36 
X-CRM114-Status: GOOD (  21.94  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, May 17, 2021 at 10:25:21PM +0530, Kanchan Joshi wrote:
> On Mon, Apr 26, 2021 at 8:46 PM Keith Busch <kbusch@kernel.org> wrote:
> >
> > On Mon, Apr 26, 2021 at 04:43:16PM +0200, Christoph Hellwig wrote:
> > > On Fri, Apr 23, 2021 at 03:05:58PM -0700, Keith Busch wrote:
> > > > The block layer knows how to deal with polled requests. Let the NVMe
> > > > driver use the previously reserved user "flags" fields to define an
> > > > option to allocate the request from the polled hardware contexts. If
> > > > polling is not enabled, then the block layer will automatically fallback
> > > > to a non-polled request.
> > >
> > > So this only support synchronous polling for a single command.  What
> > > use case do we have for that?  I think io_uring based polling would
> > > be much more useful once we support NVMe passthrough through that.
> >
> > There is no significant use case here. I just needed a simple way to
> > test the polled exec from earlier in the series. It was simple enough so
> > I included the patch here, but it's really not important compared to the
> > preceeding patches.
> 
> It would be great to see this in at some point; helps in making
> passthrough more useful.
> I'll look into integrating this with async-passthrough.

Right, async ioctl would really provide better justification for
passthrough polling. I'll post a new version of this series this week to
address the previously submitted feedback, but without this patch for
now.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
