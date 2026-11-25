Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24961606A323
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2026 07:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=RRfTtELJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=6HwZn2Efeyth96SKkP7i8dWwO92eBr1UZoTO4pssfwA=; b=RRfTtELJZRr2zhFDekg6eYWrYR
	7VE1BTalEyNwYCB9ed0Wh/9SRctjuuvrKHn+EDOTdMuaNDZOPzV3N7wspLR4Bo8RCQzRSouzMzUqA
	2hP2pRez15qi1OHHN/rAZw+LFh+OphCgRQ9P3Z7eYTO2nMoy6fWRHoslg/Z1DSELcXqMLYXJY22Pg
	PkEKiu0IpnG8cSRbwSZECCRLYDb9GYX3SVSBIdmAdWXrIHK1t4zMp2Z1c2xMvRVohnAOFs5REEx27
	IUb/8wlAn+XSq24s/IYJI7sHzhhoLmB8SABjYT+hZGBaT4VEZ7uagwSdR1rnTvI6ZP8//DmXJ3VDC
	s5fQ67vA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW74O-00000008mZb-3aQk;
	Wed, 25 Nov 2026 07:05:32 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW74K-00000008mVh-05P3
	for linux-nvme@lists.infradead.org;
	Wed, 25 Nov 2026 07:05:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AB54368AFE; Wed, 25 Nov 2026 08:05:24 +0100 (CET)
Date: Wed, 25 Nov 2026 08:05:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>, Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v5 2/3] nvme: define the SMART / Health Status async
 event subtypes
Message-ID: <20261125070524.GC21586@lst.de>
References: <20261125061522.231591-1-kanie@linux.alibaba.com> <20261125061522.231591-3-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125061522.231591-3-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_230528_243886_BFE0F43A 
X-CRM114-Status: GOOD (  10.97  )
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 25, 2026 at 02:15:21PM +0800, Guixin Liu wrote:
> Add the asynchronous event information values of the SMART / Health
> Status event type (NVMe 2.x, Figure 154) alongside the notice subtypes.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


