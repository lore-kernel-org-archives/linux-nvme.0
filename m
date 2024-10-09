Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24ABFCEE336
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Oct 2024 17:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4RbdES/xCIEpjK4wc943aaP9C6Ee91elErXLO6o5CzM=; b=fLBpg0D64+hqRvDTb6kA75eWMB
	OdJegYteIbjjvdQFCw2nazMnlXOxn8q4i4p1I4mx5h/5TMsmfxu6Vx4IuXGWwRSyaRnSnhTk1I3Yy
	Jo5vgzs1UFc79jr7tzPYyaj1Ub48U7YL2ngqXum9cTMFitnNozIFQ5YPZWU9TqdzAutHTuRvWYZms
	CUJguutHRRkV1kDoJ1E36rWhpuz+ydq5U+0om4PGQXqjshtNGXjHyr1Spn70G0M3E7jZ4DNsMZAio
	urgExsQcDxBtvcwQrafYiCshWnicGwBbC2ZyJzCfVnAkVWrAgfLNNStPIeOcoGxHtakSqFckfBq+d
	Wm54apVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syamz-0000000AFrD-1qKV;
	Wed, 09 Oct 2024 17:47:57 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syaCK-0000000A7fh-3yjl
	for linux-nvme@lists.infradead.org;
	Wed, 09 Oct 2024 17:10:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5DB945C561B;
	Wed,  9 Oct 2024 17:09:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63ABC4CEC3;
	Wed,  9 Oct 2024 17:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728493803;
	bh=4RbdES/xCIEpjK4wc943aaP9C6Ee91elErXLO6o5CzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oCHo+ao39ur1r7LrA6GtClhdU0SWjACXp8U/WL6qHIkC5WE3ZPvKLV1Nl/lILgl4f
	 wxgBuGMIwRbCUx6M02hXcH33Z4JuC5boLFfHu9gVDvXBP9ZQ0jSNHKP6Ku5hUyd9yw
	 znG6uvtATNF3mByu77joPqBrnToKygHf48kyciDYWgo28FMW+Fa5ci6H4rxVaQdP9+
	 YnTGf1MYjS11JSvUM3uLbcQWh856YXlvWwO80mmY+/hb24KIOfiCupmS2Bu6L+McB2
	 MIoo0BKW24dJBXs9oPb7vPtjgTpfLFsabRWH8/rGiOHUsx2v08VmQnIapfkp/fWLBz
	 48sPrixm51JGA==
Date: Wed, 9 Oct 2024 11:10:00 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/3] nvme-multipath: cannot disconnect controller on
 stuck partition scan
Message-ID: <Zwa46LdLSS7WoMFf@kbusch-mbp>
References: <20241007100134.21104-1-hare@kernel.org>
 <20241007100134.21104-3-hare@kernel.org>
 <ZwQmK6dZ_goSQ4Cg@kbusch-mbp>
 <47968bf9-2b98-4e5e-9040-2db6f15d86a6@suse.de>
 <ZwWY8d3vOLUaYaJ6@kbusch-mbp>
 <3b8ff898-9529-4506-8c5d-0fcf3423730f@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b8ff898-9529-4506-8c5d-0fcf3423730f@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241009_101005_056889_1E237ECA 
X-CRM114-Status: GOOD (  10.05  )
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

On Wed, Oct 09, 2024 at 08:23:45AM +0200, Hannes Reinecke wrote:
> With my testcase _all_ paths return NS_NOT_READY during partition scan, so
> I/O is constantly bounced between paths, and partition scan never returns.
> Doesn't matter where you call it, it's stuck.

I'm trying to recreate this so just want to clarify the return status.
NS_NOT_READY isn't a path error, so doesn't use failover. It eventually
exhausts its retries, so I don't see a problem with that status.

If I synthesize a pathing error though, then yeah, I can recreate a
problem.

