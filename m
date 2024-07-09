Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1420C2BD09
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jul 2024 07:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jbobbBlfjkNFUqKAXucfDO5jopaGCqSEpUbcImtR+Ao=; b=ZXT9BtwG97204Tvy/EnLtiBcMs
	Pdj7fCCmtZcGat7Vbb0/3zbM+DQhE3qit8Xse9F94D8HWvEMjfCC7YFgsNZU9E66lJ/hZASNsAKLa
	ds5QhsAFcbVU12pk/ZeD1zY9oxgdz8H2eGugckwe9G1aj62/gJaSlUx+D6hEdvYKeCv/TVIG3+jNM
	RB6VtZ3t8vErToZMFve9v56dD3svOuzSUuc/gBSCn/NpJrrF6PUgp3LlnK87KdNu8TU/wkQ7+SeQ8
	oeNml3R02O5KLHfev6EGOmUnMDx0J8DfALisUrUKC58fBxxgmW/oAJvFrRzLc3FlrN/TRr1JL/zAY
	l/yWOq3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sR4xW-00000006BpL-2JQz;
	Tue, 09 Jul 2024 07:08:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sR4xT-00000006BoV-35GR
	for linux-nvme@lists.infradead.org;
	Tue, 09 Jul 2024 07:08:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 869BD68AFE; Tue,  9 Jul 2024 09:08:08 +0200 (CEST)
Date: Tue, 9 Jul 2024 09:08:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj gupta <anuj1072538@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: fine-grained PI control
Message-ID: <20240709070808.GA18993@lst.de>
References: <20240705083205.2111277-1-hch@lst.de> <CACzX3AvXAhcjE0PEB_PO7B2e0pRB7mj2QMdw5Gj_sNH-acTfYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACzX3AvXAhcjE0PEB_PO7B2e0pRB7mj2QMdw5Gj_sNH-acTfYg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240709_000815_936903_7A6E01F1 
X-CRM114-Status: GOOD (  15.30  )
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

On Mon, Jul 08, 2024 at 07:47:59PM +0530, Anuj gupta wrote:
> > Last but not least the fact that all reads and writes on PI enabled
> > devices by default check the guard (and reference if available for the
> > PI type) tags leads to a lot of annoying warnings when the kernel or
> > userspace does speculative reads.
> In the current series the application can choose not to specify the
> GUARD check flag, which would disable the guard checking even for PI
> enabled devices. Did you still encounter errors or am I missing
> something here?

Well, this is for probing reads from libblkid, the partition parser
or file system mount routines.  So we'll need a flag for the case where
PI is not controlled by the user, as we don't really want all the callers
to actually deal with PI.

