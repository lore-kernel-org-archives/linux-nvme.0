Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F5ACF2570
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Nov 2025 05:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b3eFLRn/KkgBqjxxam0IU7m1abpWqu3NI1u75CKjcTg=; b=P+1NeiVq1YFCVP6xXFNU8jR2PY
	W4ENdATWljYB6u9MTfXxz/a+2EELthJO3HSNl/4RaqjV3b50Y3XoKw+W+FIcyYGs8NT3DMmjISOGz
	Atr7z+MV8mNEv03pWLoGLyZwomKkWubwNSzWz6+O5Tgj3EA226V1pmdWdPiKZyHKrQkL49QtXyZyL
	xYTng7xU4vqqmziWbpZCQWFSRJfPT0+kkMvXGavdkLUqnP+RK9nTEVh+Gmn+Z7OgIZR0HI+7OhmFH
	kuG/hyxH/bkyJ8AE4NW1yfLaE8uw5ISqc3bSlNHA4PmCkDLZyW3/JyR9fXx9HXrPnL7Sr0rSKoEzX
	cN7wpuIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLb3r-00000002Q6T-1gkA;
	Wed, 19 Nov 2025 05:48:59 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLb3p-00000002Q4v-0Xfp
	for linux-nvme@lists.infradead.org;
	Wed, 19 Nov 2025 05:48:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7E3C168AFE; Wed, 19 Nov 2025 06:48:48 +0100 (CET)
Date: Wed, 19 Nov 2025 06:48:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: deduplicate empty request list checks in
 nvme_queue_rqs()
Message-ID: <20251119054848.GA20072@lst.de>
References: <20251119021701.3165123-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119021701.3165123-1-csander@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251118_214857_310401_56AB8948 
X-CRM114-Status: GOOD (  15.77  )
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

On Tue, Nov 18, 2025 at 07:17:00PM -0700, Caleb Sander Mateos wrote:
> nvme_queue_rqs() checks that nvmeq is non-NULL before calling
> nvme_submit_cmds() and nvme_submit_cmds() checks that submit_list is
> non-empty before doing anything. A NULL nvmeq means no requests were
> processed from the rqlist in nvme_queue_rqs() since the last call to
> nvme_submit_cmds(), which implies submit_list is empty. So just check
> that submit_list is non-empty before calling nvme_submit_cmds() and drop
> the check for NULL nvmeq.

What is the rationale for this?  I had a hard time understanding the
logic in the new version, so I don't think this helps with readability
at least.

