Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C49C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Feb 2022 17:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D3ieuZyvCrV2PUjgywPf+38FO/DG/kucLJxnFs0FkEU=; b=nIhNotrJT6i0HY9SXFbtfAM+dK
	GnTmpvdzf+MfHDquVzZCjkMW0HoxSXFxHDGZKIhtcHWFnzQN6keWDtuN/r1l0fsNXsJtFRLQgrgbS
	IJfEsZlXYgIMrpmypyEQIIyrnuxr9kPd5v2e1ZPNNCj2IdLGjO5k2pGmwv1JyiU4CEkWU/0o7kot5
	RNLoUQXy6sas/G/GZEf/x9zcg9FDhyiC4gsuu9BL0TksEV2m2gu3kaG02OkSDnsMy1VO6qtuP/zJG
	RWQPEcrsxRd2rHeyG+BU1Wbcibl/YRoI7gYHCvB4cH1KTHvgtNUlbQJN4rBo1WrW/Zy3vBXqUh1KE
	8uekPnFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nNHft-001jH6-85; Thu, 24 Feb 2022 17:13:05 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nNHfo-001jFo-JH
 for linux-nvme@lists.infradead.org; Thu, 24 Feb 2022 17:13:02 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 3569EB8279F;
 Thu, 24 Feb 2022 17:12:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D3BC340EC;
 Thu, 24 Feb 2022 17:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645722777;
 bh=nGTSgzaxucqVIMsNmhDMBCNM0/d4v99BM1V3wtw8uLo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FLyohMIRKRBT3EjdgaZG4YQU/6Ub4Z3XNIg0TaD0AuFtoEOPfXObTUR3MhOupJFKI
 cKXcqcOj+gnWaGV6uHn5ZN9nM/OOAyGvcnbeY5+ICspc93vmDQsJBt1jIynehVGxxH
 qcy1F5NslTpornx70B0pVO2qMfGE9mAfGOvhbPQKW5jvVlcNf7RfW+bD/ZsR5oOois
 tl9siXKa+Z3lreb3ceGyfqI5AJEeJnOvf0f1cJra1Y+q4hjhEGkE94kI1ShjHwtET3
 m5i/6eVuYqKBln7yPS2HjxFCdM/SA7OPUpTnh7KrPF8vu2Dmr1m95IobAVz3tUN36T
 ut9XtVoh2/LSw==
Date: Thu, 24 Feb 2022 09:12:55 -0800
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/3] nvme: check that EUI/GUID/UUID are globally unique
Message-ID: <20220224171255.GA3257446@dhcp-10-100-145-180.wdc.com>
References: <20220224105852.862715-1-hch@lst.de>
 <20220224105852.862715-4-hch@lst.de>
 <20220224154304.GB2976831@dhcp-10-100-145-180.wdc.com>
 <20220224165138.GA32261@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224165138.GA32261@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220224_091300_803190_8C56C3C5 
X-CRM114-Status: GOOD (  16.01  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Feb 24, 2022 at 05:51:38PM +0100, Christoph Hellwig wrote:
> On Thu, Feb 24, 2022 at 07:43:04AM -0800, Keith Busch wrote:
> > It looks like a race condition exists here such that two namespaces with
> > duplicate IDs in different subsystems being concurrently added may not
> > see the duplicate.
> 
> Yes.  But do we care?  This is a sanity check.  The alternative would be
> to hold nvme_subsystems_lock for the whole ns_head probing, which is
> a little annoying.

I suppose whether we care or not depends on how many broken or dispersed
subsystems exist in the field. If it's too common, we may receive bug
reports for inconsistent namespace enumeration.

Holding the subsystem lock for the entire scan is annoying, though... I
guess just go with this patch and we'll see what happens.

