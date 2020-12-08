Return-Path: <SRS0=lokR=FM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4595C433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 19:17:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FB6723B7C
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 19:17:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FB6723B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tqgeeWW9UO0NHR+O+efWkfazWtKlJ2swBhIWQJiwJ0g=; b=kwvXusLmx0T9s3fsvaskV4W/B
	HFHT0rEzChXRPseihIGd2sJIKPEpXyn2m57sjOI7E+uZVlMU8QhmLi1GKkstSKLu3ZyJ6nXea97kp
	o5PrtkuDEcHRLdUd6DRnVXNNKQMkSEc+L6UrfjbJRHG2P4Q8nirCPVwhf2DkhopaB9rbeCj/76/KT
	1BQzmctEepffJFGICmyV+qcrYUV29Dkybn1b2EvF1R6wVgkz3NPWy16NGI6tHKoJrdPe6WEV8a+vU
	faAWrFe2igUsuD3uyFCoFGWhNWHlYiaJPhxXNopRcKGWKMuWkUo3FYCmXeskYkbfHCaCHdw/87E74
	vqFc/sqbQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmiU0-0005my-Q7; Tue, 08 Dec 2020 19:17:08 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmiTy-0005mT-QF
 for linux-nvme@lists.infradead.org; Tue, 08 Dec 2020 19:17:07 +0000
Date: Wed, 9 Dec 2020 04:17:03 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607455026;
 bh=y5iaKKm38m+5MvyV3gN0lac6o3gk6bJ/lucXRegR/wA=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=N8hTNtKtCpkpjhFcC+ELOBey+OdPFlAp4dfdWJeDt9bmdMmBUyPoj4Hu+0yAo+Fkc
 199kBzgSnlhzlBEfYojJERvOrcDL18tJ0nqoFJu6OKGMgu+Pw04WedWSdgdyLjVgnW
 IGAIRLdtf+wslIOaju9/MNQBrNPZTfVDgPEFCBVTDkQ7MJHBCE/hYs6S34L+Xwgsgx
 ucE3SxYwjF4uaYKB81TpIZbORVeaQfa74K/PyLXw+G2m73CYSvSQPHOYSFaiDZFTxA
 5U8DDYK3XUlQJMZQ4etEApKVPczydOccLUPlIOVvgBdoX/xyDfmEg9gvt4ZpBdyje/
 0gwDtlxWfoLug==
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: retrigger ANA log update if group descriptor isn't
 found
Message-ID: <20201208191703.GE27155@redsun51.ssa.fujisawa.hgst.com>
References: <20201205152901.56665-1-hare@suse.de>
 <20201207153121.GA3679937@dhcp-10-100-145-180.wdc.com>
 <20201207153443.GA6236@lst.de>
 <20201207154650.GB3679937@dhcp-10-100-145-180.wdc.com>
 <20201208140352.GB2919@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201208140352.GB2919@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201208_141706_929147_9791671B 
X-CRM114-Status: GOOD (  16.09  )
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
Cc: Keith Busch <keith.busch@wdc.com>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Dec 08, 2020 at 03:03:52PM +0100, Christoph Hellwig wrote:
> On Mon, Dec 07, 2020 at 07:46:50AM -0800, Keith Busch wrote:
> > > But as I just outlined it just papers over buggy controllers.  I really
> > > don't think we should just silently do that.
> > 
> > Okay, that's fine with me too. I agree with you on what the correct
> > event sequence should be, but I just thought this looks like a fairly
> > harmless work-around.
> 
> I see three major downsides:

You only listed two. :)

>  (1) it papers over our host side bug where we do not process the
>      different AENs in the order that the controller generated them

We only have one AEN outstanding at a time, though, so we can't process
them in a different order than the controller sent them, right?

>  (2) the code is black magic as there is no indicator why this condition
>      would happen

Would it help if Hannes adds a dev_warn() that this log refresh is
occuring from a controller's inconsistent reporting?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
