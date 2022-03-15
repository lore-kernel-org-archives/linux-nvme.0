Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B13C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 09:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vZCq+u3mM1V9asJxr1EEGADNORmbwIEZ+YSJ2Qzib50=; b=pR0aOdTEPemKYogElwhPIM4/By
	eWuzde7mt0jaIVzjTGviif78kGCVF8fUm/sEvhcfpKgq2MVGo9U6CwLljzsrPKfm+AYuyuG3l8nye
	ss2vTZl6VHkSr0fOhOyNC/O+PcF7MhoQKMjVz6/t/cLu8WOfUUwlDeI2kY3tw/tALoRYavRLW9Txj
	FOg9Iaw6LmWcbPL7RstGW44Nlf5/Izp5/P9yyuQBaQwThSuRqm9S+Nm773hgB2FMsrv0dOtTB82m0
	d9zlJC1EK14UCRYBy0u+wA1mf2T2R52XgvubSxXdbSdhikz1fVjQxfcdkwt4lOXunEZs6dkzTL+7Z
	dSWswOQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU3ob-008cas-FH; Tue, 15 Mar 2022 09:50:05 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU3oQ-008cWu-4p
 for linux-nvme@lists.infradead.org; Tue, 15 Mar 2022 09:49:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id B5B7868AA6; Tue, 15 Mar 2022 10:49:50 +0100 (CET)
Date: Tue, 15 Mar 2022 10:49:50 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/3] nvmet: expose discovery subsystem in sysfs
Message-ID: <20220315094950.GA5322@lst.de>
References: <20220314105333.56714-1-hare@suse.de>
 <20220314105333.56714-2-hare@suse.de> <20220315080602.GA3082@lst.de>
 <f2fb9eea-8c9c-cb95-5380-2a10b6ce3f46@grimberg.me>
 <ec115fe9-2b3f-8f31-d3b8-b85686c2788a@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec115fe9-2b3f-8f31-d3b8-b85686c2788a@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_024954_423682_C7D1F8CF 
X-CRM114-Status: GOOD (  22.63  )
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

On Tue, Mar 15, 2022 at 10:06:26AM +0100, Hannes Reinecke wrote:
> The core question really is: do we _want_ to expose the discovery subsystem 
> in configfs?

Well, if you want a freely configurable one we kinda have to, right?

> Unfortunately, exposing the discovery subsystem and trying to configure it 
> with configfs does _not_ match with the way discovery is implemented today. 
> While we currently only have a single discovery subsystem, it will only 
> ever return the subsystems visible from this particular port.

Well.  The original Fabrics spec had this concept of that magic discovery
NQN, which implies that there is one subsystem (or many pretending to be
one).  And that is what the implementation followed.  The varipus 80?? TPs
then made a complete mess off that.

> Hence this rather simple approach, having the 'normal' discovery subsystem 
> exposed, and let the admin configure it accordingly.
>
> I can look at keeping the internal implementation, and only expose unique 
> discovery controller (ie those with a unique subsystem NQN).
> That would remove the need to having the 'discovery_nqn' attribute, and 
> address Christophs concerns.

I suspect if we want to support all the new mess from the FMDS group
(and maybe we need to question the why a little more), then we should
so something like:

 (1) keep the existing global NQN-based discovery as-is.
 (2) maybe add a per-port known to allow disabling it if people really care
 (3) allow creating additional discovery subsystems with non-default
     NQNs that do not automatically get anything added to them and will
     just be configured as needed through configfs

But maybe first we should take a step back and figure out what supporting
TPAR8013 even buys us?

