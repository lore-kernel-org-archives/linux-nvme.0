Return-Path: <SRS0=o8oB=PC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB77C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Oct 2021 06:04:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F16E960FF2
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Oct 2021 06:04:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F16E960FF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H0SWCxhebfwL1j9wLhL+e+0z5Do+QmXPQJydryG/Vv0=; b=UxKYgHifVHAlWPBXGMh8vAVKKV
	Nwmef0ydWkoUoHF0fo2g5vfIxGPDzjH/3ufUj+cidYNbeJz8bWez9TqXkK4TyXP7yAg/iJ9DlD9Mb
	h5l+EW8E9WOmFj7XIuEbNvgsdjU99jiiG/sn65NDadQWUM3Qkp1IBwB7soCHRozch9V8tNRdnaAsy
	ElS11S/Bg4LOIBBrcGd5ZMOH9UYkr95gt2dG1riXhT7v5QqBBc+ckTMOoue9RWzcin3h3WURo92nO
	iSwG/h6YNrFrGSMpl7pJg197sp1A7TAWkhsOVPLbwk1J9RdPEVjolhM+tkQPx6+Yks1a4Q1OwsUSe
	6JaKCksA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1matr0-001eyV-AW; Thu, 14 Oct 2021 06:04:34 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1matqx-001exe-Im
 for linux-nvme@lists.infradead.org; Thu, 14 Oct 2021 06:04:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id AC47068B05; Thu, 14 Oct 2021 08:04:23 +0200 (CEST)
Date: Thu, 14 Oct 2021 08:04:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Adam Manzanares <a.manzanares@samsung.com>
Cc: "yi.zhang@redhat.com" <yi.zhang@redhat.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
 Minwoo Im <minwoo.im.dev@gmail.com>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme: Cleanup per-namespace chardev deletion
Message-ID: <20211014060422.GA24897@lst.de>
References: <CGME20211013150421uscas1p297a8bd51cf3f3b68dcef3a1c87da2959@uscas1p2.samsung.com>
 <20211013150413.320133-1-a.manzanares@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013150413.320133-1-a.manzanares@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211013_230431_818322_3834A55B 
X-CRM114-Status: GOOD (  12.97  )
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

On Wed, Oct 13, 2021 at 03:04:19PM +0000, Adam Manzanares wrote:
> Decrease reference count of chardevice during char device deletion in order to
> fix a kmemleak. Add relese function for the device associated chardev and moved
> ida_simple_remove into the release function.
> 
> Fixes: 2637bae (nvme: introduce generic per-namespace chardev)
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Suggested-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Adam Manzanares <a.manzanares@samsung.com>

This looks good, but the subject seems wrong.  This isn't a cleanup
but a fix.  I can fix up the subject when applying it.

