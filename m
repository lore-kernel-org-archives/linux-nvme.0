Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E5DFC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Dec 2023 08:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mwkc528HanmxGoV1BA9I0RmMiUxOQWARDUcRsErdUqM=; b=QR7zVVR/jlCmW1pjT/rB+KqueZ
	HDUl7G0YMMSm6j3IR/Xdjb9asRt1PH19r+WETs+y2sjNjhQfjH3etEOYNnPBqKG37QGjHs+7JT7MT
	4nrXPtFOA3iO+lKKUWC/3yK44fUtVTITPGE70v7w5piwkZvwEtcRsQOP7CK+aIz9aq8W9g3/XdyRA
	nGQKROWUB0G08Y0vjosWeTj8Wj3O/KfpccKmIujph8OzGDm0zMMRb+bEkHjM+CBf+9gRiJQ2J2lyH
	NG8Jo33NO/+SB51czCTAET4z5DjDUZ5N/uKTv5EsuC875Y7dNN68d5bd2y8Uey5T8jRMWd71B2ctr
	RoeazSlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDKtL-00E4pT-2p;
	Wed, 13 Dec 2023 08:46:55 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDKtJ-00E4p2-24
	for linux-nvme@lists.infradead.org;
	Wed, 13 Dec 2023 08:46:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1337868C4E; Wed, 13 Dec 2023 09:46:50 +0100 (CET)
Date: Wed, 13 Dec 2023 09:46:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/5] nvmet: relocate the cntlid_ida to the internal of
 subsystem
Message-ID: <20231213084649.GE6184@lst.de>
References: <1702449172-8920-1-git-send-email-kanie@linux.alibaba.com> <1702449172-8920-5-git-send-email-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1702449172-8920-5-git-send-email-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231213_004653_819551_1BF9D3F6 
X-CRM114-Status: GOOD (  10.32  )
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

On Wed, Dec 13, 2023 at 02:32:51PM +0800, Guixin Liu wrote:
> As per the NVMe specification, the cntlid must be unique within an NVM
> subsystem. Therefore, the cntlid_ida should be moved internally within
> the subsystem.

Sagi added this with a commit log of:

"
nvmet: Make cntlid globally unique
    
We usually log the cntlid which is confusing in case
we have multiple subsystems each with it's own cntlid ida.
Instead make cntlid ida globally unique and log the initial
association.
"

which seems reasonable.  If you have a reason for not making it unique,
it needs to be stated here so we can weight it against the original
reason for making the ids globally unique.

