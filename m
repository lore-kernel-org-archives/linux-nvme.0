Return-Path: <SRS0=8yfk=FN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8C6C4167B
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 15:53:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4317A22B47
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 15:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4317A22B47
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kMawuKxd+UwXWn2vBbQo08EP2YRkCWr+yG+C+BxOyEQ=; b=ykFKYtak23JfB0fCuz6BGbfg1
	bZ9yqzrs/iQAImvdngQLr2pBvBnAbRReky58zus1pRcG8D9ce7VvVdDoae191V3AHVSVmfliROr5M
	jzElvhiRXekfLR4pnlmKbCqSrekAulRxDWB0xhi2hN/O/qxlmcGZGj/qR/nt0WI3409LXGyCjznop
	xwVFamqOOIwyyVGLruYA+4GdyTDtQk5u7i7MrlIE4diYpHK4Np+Nfz62Sp/Ukk00u3fhJtWlev6po
	rLl9XVIsYINnl+srFOdmcpQxrzTmYO9kSeq29g6jGiJsXIspAft6AR5/Qq8Zx3dSSUpRKWVJ58nt1
	mXePEucdw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kn1mV-000804-2H; Wed, 09 Dec 2020 15:53:31 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kn1mS-0007zY-Fq
 for linux-nvme@lists.infradead.org; Wed, 09 Dec 2020 15:53:29 +0000
Date: Thu, 10 Dec 2020 00:53:21 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607529207;
 bh=rjMQhhOv/540aUS1NUrtQMwJo7zw+zvG4dBmJd/i44w=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=g2tvikBVJh87i7vtuiGrOgYm65MMRUy4Rno+zTYAxiFORgWiAW77YDWVjzDr9kKMR
 37iEUKQCziLtFEzuFaiEXq6JnKpVVLezPU11jzMPhbihpZmFeX1hwehP+VR/QGFMcN
 756r7jcc3DcfbE+Q4ByLvb3GVpY6pTkQ+e+VT8xOmqMxHaHAFfTeQg8irlQdqyr++q
 HiVuJ+JRNJnCUZj+RX7RAlyl9CO69Ewwbr6T2JUQVHnyRFEMJ+PleCqPbgL+t7yGMt
 l4snnwpKWtBPKIeb6LdBut/4Jm6WXZXeoVeFYGxICIfPQKULg7TRmMHqB865CLOM0I
 l8xjeIzEsRY0A==
From: Keith Busch <kbusch@kernel.org>
To: "Knight, Frederick" <Frederick.Knight@netapp.com>
Subject: Re: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
Message-ID: <20201209155321.GA31729@redsun51.ssa.fujisawa.hgst.com>
References: <20201207152532.GA4527@lst.de>
 <DM5PR0601MB362473E145AC665C0DE96286F1CD0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201208174033.GA27155@redsun51.ssa.fujisawa.hgst.com>
 <DM5PR0601MB362465A52C0B59002A0867F4F1CD0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201208183444.GB27155@redsun51.ssa.fujisawa.hgst.com>
 <DM5PR0601MB3624104F7CC63DF394AD0772F1CD0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201208214650.GF27155@redsun51.ssa.fujisawa.hgst.com>
 <DM5PR0601MB362434919691D589BCCF637BF1CC0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201209072806.GA10037@lst.de>
 <DM5PR0601MB36241F3E2F4BF6AECD96B72BF1CC0@DM5PR0601MB3624.namprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DM5PR0601MB36241F3E2F4BF6AECD96B72BF1CC0@DM5PR0601MB3624.namprd06.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201209_105328_702577_AD6AD70D 
X-CRM114-Status: UNSURE (   8.17  )
X-CRM114-Notice: Please train this message.
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
Cc: "George, Martin" <Martin.George@netapp.com>,
 Hannes Reinecke <hare@suse.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "Meneghini, John" <John.Meneghini@netapp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Dec 09, 2020 at 03:20:57PM +0000, Knight, Frederick wrote:
> When a namespace is created (and contained in an ANA Group), the act
> of creating that namespace results in a change to the ANA Log page -
> therefore AEN.  

That is wrong: creating a namespace doesn't do anything to the ANA log.
Only attached namespaces appear in the log. Creating a namespace
doesn't result in automatically attaching it to any controller.

You are thinking of Namespace Attach from section 5.19, and the spec
doesn't define any special exceptions for events resulting from *that*
command, which is also the command that triggered this thread.

If you want to claim that was a mistake in the text (I would agree it is
a mistake), then take it to the technical reflector rather than this
forum. The spec as currently written doesn't align with you.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
