Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16020CA0EE6
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Aug 2025 18:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EeV/yv32SalwDANfuQ0SPUqCT1baUKzCATJLcntG4fQ=; b=1MNIsMOXmsd4QpG3KInR4xU/6t
	An0NPFnr5JBZpFlsdRZULHjh9IDMhR/fHzxz80GTJZAIjxbp6f7DtrSRgJ/KqCwKRpmLLBvHWCYO1
	m/9dsNvEcy0XPE3qL8NTfRgbXRUuWHlpoHsEjy78mf1opHp+bc4rSOjjk/L622zJJoFHDpCE5Kpl4
	X4kkjbt8LxaaaAZ0RwycGy3AoVW2gYRUKvHvzbp8QZvUccksKh8i7Ir4aqKhbZbVtUv2iK0B1Xb2O
	f+PmdHP9AJkrKEXZOTUiM2bEbcvI1MyoelxiMkeVSCnfu3xXAJTVlaSjapf4m7VmlKZu0iWfXIlPP
	dgGuS80A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoQsF-0000000BFps-2weY;
	Tue, 19 Aug 2025 18:15:55 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoNb1-0000000An9v-2LII
	for linux-nvme@lists.infradead.org;
	Tue, 19 Aug 2025 14:45:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D9128227A88; Tue, 19 Aug 2025 16:45:45 +0200 (CEST)
Date: Tue, 19 Aug 2025 16:45:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>, Christoph Hellwig <hch@lst.de>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: Do we need an opt-in for file systems use of hw atomic writes?
Message-ID: <20250819144545.GA18364@lst.de>
References: <6c3e1c90-1d3d-4567-a392-85870226144f@oracle.com> <aHULEGt3d0niAz2e@infradead.org> <6babdebb-45d1-4f33-b8b5-6b1c4e381e35@oracle.com> <20250715060247.GC18349@lst.de> <072b174d-8efe-49d6-a7e3-c23481fdb3fc@oracle.com> <20250715090357.GA21818@lst.de> <bd7b1eea-18bc-431e-bc29-42b780ff3c31@oracle.com> <20250819133932.GA16857@lst.de> <59a0d2df-a633-4f82-8b11-147ba88b7bcb@oracle.com> <20250819144347.GC7942@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819144347.GC7942@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250819_074555_739637_3F20FAF7 
X-CRM114-Status: GOOD (  10.47  )
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

On Tue, Aug 19, 2025 at 07:43:47AM -0700, Darrick J. Wong wrote:
> What is the likelihood of convincing the nvme standards folks to add a
> new command for write-untorn that doesn't just silently fail if you get
> the parameters wrong?

In my experience that depends mostly on how much a big customers for
NVMe hardware is asking for it.  Hint:  while Oracle isn't in the
absolute top tier of the influence scale it probably is just below.


