Return-Path: <SRS0=tknV=IJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360B0C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 10:47:34 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57CF064FC1
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 10:47:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57CF064FC1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qf4IE/AshKJa93c0fNN8vcUoo0ayW4Q4dDUaQCOyTTA=; b=Q4ZrvIlcip1wudYPC7kWHxvAs
	prDQYkTla+rbyDmWvi4ptPBDEqCtVDqFYMzu+9U4W1byH+HT5s06/QnFgBLaRKxf9iIzXZ/zgWqjm
	jp//pl3iGd3av3BFHg0mgu62S+fNKP+5T/SyqQzwoqI32KmJ5JqAfyyhzPdKB0riLupxbbfSBPwkl
	g3daVJGEXC+MJvVrIX733OVRsmHtjaOblKWeuRKJsik5JVELMP8a6CzSnUycAcI6AwA50HjJlymhX
	kYa5jYCQkeewvGvpMs19U9Mv95v8BUiBMiUFS0Fg8sMDzRAIA4OMxKRL97yh2E/1kZ/1R773P018E
	VH5X6B4yw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKIqe-008s9Q-1D; Thu, 11 Mar 2021 10:47:20 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKIqZ-008s8u-H5
 for linux-nvme@lists.infradead.org; Thu, 11 Mar 2021 10:47:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 037A468B05; Thu, 11 Mar 2021 11:47:13 +0100 (CET)
Date: Thu, 11 Mar 2021 11:47:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
 Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Chaitanya.Kulkarni@wdc.com
Subject: Re: [PATCH 1/1] nvme-pci: add the DISABLE_WRITE_ZEROES quirk for a
 Samsung PM1725a
Message-ID: <20210311104712.GA16218@lst.de>
References: <1615377076-3251-1-git-send-email-dmtrmonakhov@yandex-team.ru>
 <20210310132156.GA12145@lst.de> <20210310134110.GA13063@lst.de>
 <20210310200030.GA3377333@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210310200030.GA3377333@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210311_104715_676234_474910FA 
X-CRM114-Status: GOOD (  18.07  )
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

On Wed, Mar 10, 2021 at 12:00:30PM -0800, Keith Busch wrote:
> On Wed, Mar 10, 2021 at 02:41:10PM +0100, Christoph Hellwig wrote:
> > On Wed, Mar 10, 2021 at 02:21:56PM +0100, Christoph Hellwig wrote:
> > > Can you try this patch instead?
> > > 
> > > http://lists.infradead.org/pipermail/linux-nvme/2021-February/023183.html
> > 
> > Actually, please try the patch below instead, it looks like our existing
> > logic messes up the units:
> 
> This seems like a good opportunity to incorporate TP4040 for non-MDTS
> command limits. I sent a proposal here
> 
>   http://lists.infradead.org/pipermail/linux-nvme/2021-March/023522.html
> 
> And it defaults to your suggestion if the controller doesn't implement
> the capability.

I think TP4040 is good and useful, but I defintively want the pure
fix get in first.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
