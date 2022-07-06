Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A16C43334
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jul 2022 16:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d2HhyJ575AUCL8zwydlL/BRWmkuXOdQ4bmMIEsQcQQw=; b=qo3+Kmb3yHWvZE4ZCzHj07+zZO
	nfeaaqjJ2xfvpSS4XW3Ws+blxq2iOVb6vD+pruGToH/OahDUbyymZ4vrla+eZ3kPHuuQiVq+hErwp
	Z0utCvJ9bGZ9xnQCbE12zik/aZwpepvxf8Iq0rzuyX65Hpjpy62Jqhp+oTjAauvSgCR2YSUc1hRbl
	UeUg9LmcAU+nqZ35Vap93eC+y14MLjlM3+1zce7eyOSlL8tpgc4T5BKfpFDCY5yEWpZcNCgl1C3cW
	myqn4AfnrniKApDmSMKsXkd5ifTLu7T04q3gkKooW5+y7uY76Lxz1wwxAEm+cSYncacFz5qOCe7ub
	id76ixFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o97jU-00BI93-Uo; Wed, 06 Jul 2022 16:18:32 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o97jR-00BI6V-GU
	for linux-nvme@lists.infradead.org; Wed, 06 Jul 2022 16:18:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7E1AB68B05; Wed,  6 Jul 2022 18:18:25 +0200 (CEST)
Date: Wed, 6 Jul 2022 18:18:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: John Garry <john.garry@huawei.com>, axboe@fb.com, hch@lst.de,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: Fix nvme_setup_command metadata trace event for
 cdw10
Message-ID: <20220706161825.GA1962@lst.de>
References: <1657095398-114310-1-git-send-email-john.garry@huawei.com> <YsW0orMaDFfrHbx+@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsW0orMaDFfrHbx+@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220706_091829_731488_9A932189 
X-CRM114-Status: GOOD (  15.16  )
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

On Wed, Jul 06, 2022 at 10:13:22AM -0600, Keith Busch wrote:
> Did you test what the trace looks like afte this? We're losing valuable trace
> data here. The field is supposed to get CDW's 10 - 15, so that's 24 bytes. I
> don't know why it cares that the address of the field being read is only 4
> bytes; we want everything that comes after it too.

Because accesses should not spawn boundaries of members in structs unless
copying the entire struct.  If we want to trace the various fields we
need to individually assign them.

Anyway, I'm dropping this patch from nvme-5.19 for now to let the
discussion conclude.

