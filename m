Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF12EDE99A
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Sep 2024 15:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JCuYXDIYAMRLLhMyF5/3TpwXM4WY9NEpCFPuDA6qSy8=; b=b6xz092gVAtvhnG8gExg3eM95Z
	BIW3pjhl0/UYPBiFbQK4oI8qBkkG5hd+HAt+q/jw3I5huO34FCgDu+xOo5UOcYljRRuRHpHoPlEOS
	/M8oB1hwR99L6KqpvizUVvUXY4QrIQWaFstXaJ3SBeTN6w0uAzIl8ZPAKeGMfA2UQZE8tpkDOdKj9
	4gWAk+EVHduh136LGvDgRjB7yLqETYCzzZYAsDJ/Q/7BTLdGTdhzwxSHenEEakkyNE4ys5aex7CeL
	BVfCp8an3qaRujTg08AbtcL0DNaYL9avxc0buRuOD7j6z6YOCorExuSgYBXtDysjPg2Y+IGX9QFsa
	SEwz+XrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1so3Ah-00000006EYt-45Mn;
	Tue, 10 Sep 2024 15:52:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1so36l-00000006DhV-1TOg
	for linux-nvme@lists.infradead.org;
	Tue, 10 Sep 2024 15:48:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1AA3068AFE; Tue, 10 Sep 2024 17:48:44 +0200 (CEST)
Date: Tue, 10 Sep 2024 17:48:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 09/10] blk-integrity: consider entire bio list for
 merging
Message-ID: <20240910154843.GI23805@lst.de>
References: <20240904152605.4055570-1-kbusch@meta.com> <20240904152605.4055570-10-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904152605.4055570-10-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240910_084847_579955_E977A69A 
X-CRM114-Status: GOOD (  11.99  )
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

On Wed, Sep 04, 2024 at 08:26:04AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> If a bio is merged to a req, the entire bio list is merged, so don't
> temporarily unchain it when counting segments for consideration.

As far as I can tell we never do merge decisions on bio lists.  If
bi_next is non-NULL here it probably is due to scheduler lists or
something like it.


