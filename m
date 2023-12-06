Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0547BC4167B
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Dec 2023 08:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xPoYUxqS2RZPhcm0gVwXf4pFI+bCrmpOA2Ep16T6/cQ=; b=MtXOITXK8wsY3W54QPWPNby35l
	efxY3fNhxTIDXR0tf8n/hjhG/1G5Qk73wkG8Y4/gCPBeCztOV+j0dXR3QZEpGBPDiNUris8srkV2W
	Q89yr06kMPxVZmohmlyAqY7JSQ05Zu3oYcodD7Izui9lkHgkU+DUNyE2ZLGkpKJPsarhY6AzoX71E
	rVk8KJDmHfYbj36rjMOdZsjL5ylXnHef53AX8No/3hwiYc8XnkNivlxwQG72kt/exB/PpGiSHmtmS
	KhgwEurYS7LWoQZNpKmOT6XC46geiGU1ti/gAbJYKPBI0nug9FfGdmkpZ4Vmx9/gSR2m+DaRn6oTL
	Oz4ZYQmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAng3-009Tlg-1d;
	Wed, 06 Dec 2023 08:54:43 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAng0-009TlE-2m
	for linux-nvme@lists.infradead.org;
	Wed, 06 Dec 2023 08:54:42 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8E193227A8E; Wed,  6 Dec 2023 09:54:36 +0100 (CET)
Date: Wed, 6 Dec 2023 09:54:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 3/4] nvme: move ns id info to struct nvme_ns_head
Message-ID: <20231206085436.GB24484@lst.de>
References: <20231206081244.32733-1-dwagner@suse.de> <20231206081244.32733-4-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206081244.32733-4-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231206_005441_042481_D6086B9A 
X-CRM114-Status: GOOD (  15.48  )
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

On Wed, Dec 06, 2023 at 09:12:43AM +0100, Daniel Wagner wrote:
> Move the namesapce info to struct nvme_ns_head, because it's the same
> for all associated namespaces.
> 
> The head pointer is accessible from the ns pointer so we could just
> update all places with ns->x to ns->head->x. While this is okay for the
> slow path,

Do you have any data to show that it matters?  All the I/O command
setup functions already access the ns_head for ->ns_id, so looking
at more fields can't really make any difference.

If we have a good argument about reducing the pointer chasing I'm all
for it, but please as a separate, well-documented commit that also
explains the tradeoffs for the newly added lookups this adds in a few
places.

