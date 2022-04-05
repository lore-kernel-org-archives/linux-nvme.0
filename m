Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD56DC433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Apr 2022 06:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+cV+MSRX84/AXoSyDVFk7giArVjp7+o4Nw7b6gy4Jz4=; b=nuPlhoTcAMpG0TU0hQ1wvzfUg1
	60gnniYnLS2SvXvzoCoDS82PqYG4pQpFwURd0GMIpGvGdNov7CoXup3L9CfDxsGmr8xLSLFZ5JS3R
	tHC65kLMQ36kTQwQZnUCCc7YUUyxbInhrZdfkhbYmGalmC6Yrhl84k2K8HTS/D3tgIJW3YJPeM6Rg
	CztwhY7QzbPstjwBTDiUuFvESQGFip/cFSvrFSF8E6gBRubU3yGkAa+JaTuP8cFxqPxwQwcXtjFFx
	J1KruMBeh2sh6upoCrU3TTIayjhsbetaU0Vd8P/TZ10ZJQTSvog5a/b2RmD/IGUCrQ7HkakOnDaoN
	0M9n6G5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbcXb-00HI38-Te; Tue, 05 Apr 2022 06:19:47 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbcXY-00HI2X-QE
 for linux-nvme@lists.infradead.org; Tue, 05 Apr 2022 06:19:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5179768AFE; Tue,  5 Apr 2022 08:19:41 +0200 (CEST)
Date: Tue, 5 Apr 2022 08:19:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 3/3] nvmet: include all configured ports in discovery
 log page for unique discover controller
Message-ID: <20220405061941.GA24290@lst.de>
References: <20220317142634.49324-1-hare@suse.de>
 <20220317142634.49324-4-hare@suse.de> <20220405054601.GC23466@lst.de>
 <a129df40-6195-8b59-aa76-e3053e0960fd@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a129df40-6195-8b59-aa76-e3053e0960fd@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220404_231945_039070_EE508E92 
X-CRM114-Status: GOOD (  15.70  )
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

On Tue, Apr 05, 2022 at 08:15:51AM +0200, Hannes Reinecke wrote:
> To make it configurable.
> Unique discovery controllers show up in configfs just like any other 
> subsystems.
> And with that we need to clarify the relationship between the discovery 
> subsystem and the other subsystems, ie which subsystems should be presented 
> by this discovery subsystem.
>
> Linking the discovery subsystem into a given port makes it obvious that
> a) this port will be presenting a discovery subsystem
> and
> b) that the discovery subsystem will be presenting all subsystems 
> configured on that port.
>
> The built-in mechanism for discovery subsystems was okay as long as the 
> discovery subsystem was built-in, too.
> But with this patchset we're moving to an explicit configuration.

Shouldn't we just require anything to be manually listed for this
case similar to how we configure referrals for the well known
discovery controller?

