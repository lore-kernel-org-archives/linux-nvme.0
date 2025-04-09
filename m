Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F295C369A1
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Apr 2025 10:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YViNYDQw4VsdudezqF3bvfbHcUGdp4pjcccRrbiYMys=; b=husgwrZifPN3iZzdgd77BLs7uX
	2CdapdDiNoStbZZ+Pf6rn+CWtu/Nzk529DYOrwa6Dhg42O2wVvNMGH1FibkNcWcUG5J34ICgfkuzB
	d/SgeR7EObcFEmZ8m/HCw36D5CERXPGh+9fZFr4kWmqkaVcpQQBz39R3mFqtvM4G7f/yA1/qmEePm
	eO1XsrIGrvZIz4A3WhTzsAWXvSweE/0b9YHtRu1p6wQX6xtPUiFrpwpTVmS2aE3TpLYYYiB7nX6vU
	jfwKDV+F0zGIHNpVP/H4h9DIXnFQ5Hp0tuL+8nSmxDG7euOH0q6kWzsKAQWOafgBIIf/ZtcE92Hbi
	cy8FCGSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2Su5-00000006sOh-1Vxl;
	Wed, 09 Apr 2025 10:43:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2Su2-00000006sNp-41NK
	for linux-nvme@lists.infradead.org;
	Wed, 09 Apr 2025 10:43:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 56BBB68AA6; Wed,  9 Apr 2025 12:43:26 +0200 (CEST)
Date: Wed, 9 Apr 2025 12:43:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, kbusch@kernel.org, hare@suse.de,
	sagi@grimberg.me, jmeneghi@redhat.com, axboe@kernel.dk,
	gjoyce@ibm.com
Subject: Re: [RFC PATCH 1/2] nvme-multipath: introduce delayed removal of
 the multipath head node
Message-ID: <20250409104326.GA5359@lst.de>
References: <20250321063901.747605-1-nilay@linux.ibm.com> <20250321063901.747605-2-nilay@linux.ibm.com> <20250407144413.GA12216@lst.de> <5db5ab7b-fdf2-4b40-86fc-3ab4ccff9a41@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5db5ab7b-fdf2-4b40-86fc-3ab4ccff9a41@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250409_034331_151132_D61D1516 
X-CRM114-Status: GOOD (  17.47  )
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

On Tue, Apr 08, 2025 at 07:37:48PM +0530, Nilay Shroff wrote:
> >> +	 * For non-fabric controllers we support delayed removal of head disk
> >> +	 * node. If we reached up to here then it means that head disk is still
> >> +	 * alive and so we assume here that even if there's no path available
> >> +	 * maybe due to the transient link failure, we could queue up the IO
> >> +	 * and later when path becomes ready we re-submit queued IO.
> >> +	 */
> >> +	if (!(test_bit(NVME_NSHEAD_FABRICS, &head->flags)))
> >> +		return true;
> > 
> > Why is this conditional on fabrics or not?  The same rationale should
> > apply as much if not more for fabrics controllers.
> > 
> For fabrics we already have options like "reconnect_delay" and 
> "max_reconnects". So in case of fabric link failures, we delay 
> the removal of the head disk node based on those options.

Yes.  But having entirely different behavior for creating a multipath
node and removing it still seems like a rather bad idea.


