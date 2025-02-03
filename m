Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E91C02195
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Feb 2025 08:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O5ZOcb6eRlEeqZR3m2BdJeOr/ABU2XZiCq8VPElSOWk=; b=uKKiFwuCG/dltnObmkrkhEwqHU
	PzkdCm1cPaDCJJkNe4VwDybVF9MdYiXoqDhvTP8y4gauwRAmCnwdnTnYnCBKDSrHa66fd0uT82RoR
	UYIW5zk1IMAk/LjEcI7W8Fb00XZtNaR1AGzFM3zj9NcsMbTzJxvRGNhi7kTRLACNEzQ8dCUImIzeM
	uyPu+saxVOHPM3yp53cPJ3hn8BqxKPk5IsyVUwnz8N+KrFZSGMnxVUVBDbDpCKlC2lGxMaMmaKXWT
	pZl9hCUTUDGPOcDGKyN+dXPsQS0dE11rymiIG+SRw98ndPRUEsJthJu3vDaDR/l4KfyrRky/d8XBV
	m6WfsoQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tes0F-0000000EsR6-2R2Q;
	Mon, 03 Feb 2025 08:40:23 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tes0E-0000000EsPn-0c4a;
	Mon, 03 Feb 2025 08:40:22 +0000
Date: Mon, 3 Feb 2025 00:40:22 -0800
From: "hch@infradead.org" <hch@infradead.org>
To: Qu Wenruo <wqu@suse.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	Kanchan Joshi <joshi.k@samsung.com>, Theodore Ts'o <tytso@mit.edu>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>
Subject: Re: [LSF/MM/BPF TOPIC] File system checksum offload
Message-ID: <Z6CA9sDUZ_nDj5LD@infradead.org>
References: <20250130091545.66573-1-joshi.k@samsung.com>
 <20250130142857.GB401886@mit.edu>
 <97f402bc-4029-48d4-bd03-80af5b799d04@samsung.com>
 <b8790a76-fd4e-49b6-bc08-44e5c3bf348a@wdc.com>
 <Z6B2oq_aAaeL9rBE@infradead.org>
 <bb516f19-a6b3-4c6b-89f9-928d46b66e2a@wdc.com>
 <eaec853d-eda6-4ee9-abb6-e2fa32f54f5c@suse.com>
 <Z6B9uSTQK8s-i9TM@casper.infradead.org>
 <Z6B-luT-CzxyDGft@infradead.org>
 <efcb712d-15f9-49ab-806d-a924a614034f@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efcb712d-15f9-49ab-806d-a924a614034f@suse.com>
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

On Mon, Feb 03, 2025 at 07:06:15PM +1030, Qu Wenruo wrote:
> Thus my current plan to fix it is to make btrfs to skip csum for direct IO.
> This will make btrfs to align with EXT4/XFS behavior, without the complex
> AS_STABLE_FLAGS passing (and there is no way for user space to probe that
> flag IIRC).
> 
> But that will break the current per-inode level NODATASUM setting, and will
> cause some incompatibility (a new incompat flag needed, extra handling if no
> data csum found, extra fsck support etc).

I don't think simply removing the checksums when using direct I/O is
a good idea as it unexpectedly reduces the protection envelope.  The
best (or least bad) fix would be to simply not support actually direct
I/O without NODATASUM and fall back to buffered I/O (preferably the new
uncached variant from Jens) unless explicitly overridden.


