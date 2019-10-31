Return-Path: <SRS0=hE+E=YY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646DFCA9ECB
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2019 13:39:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35CFA20862
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2019 13:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FmeLN9D8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35CFA20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IOA5hCDRNxK8SxLUQfTygq6UuDV/D5+PbkCq8k2lo1E=; b=FmeLN9D8E7IIa9
	ZqGCMNWcumkZ5UWLN5Lty+qJ5am/F+bYq9nmxsOZiLHHwSJ/MTnW/m537o00C+kToa8Pcs3wwVg0k
	mUYsvVcVJhf3scnxu3b1+Xh8q4nfKvAlTots6RPeYYnkrlFLJZdBQtGXfFkIBC43UW840R18Z641p
	Rl+ZtAb3Aouc+ThL+3b0KbXMNuUk8/dzVq+MEZcmnHqNySaAwL52FCzGkH9Kep6HPadfSlBukuLJh
	JizWtU3cUz13sJaB+Xs7dAa6V13Zf7FbVHLEsxQZBJ9d9NJ1u/ZStOJPAuTUo8Ws5ID4u0VSsw5sN
	bERPUzb8qyOcf9RLjQWQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iQAfg-00060Q-1c; Thu, 31 Oct 2019 13:39:28 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iQAfc-0005zI-P9
 for linux-nvme@lists.infradead.org; Thu, 31 Oct 2019 13:39:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9831E68BE1; Thu, 31 Oct 2019 14:39:21 +0100 (CET)
Date: Thu, 31 Oct 2019 14:39:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Charles Machalow <csm10495@gmail.com>
Subject: Re: [PATCH] nvme: change nvme_passthru_cmd64's result field.
Message-ID: <20191031133921.GA4763@lst.de>
References: <20191031050338.12700-1-csm10495@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191031050338.12700-1-csm10495@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191031_063924_964808_7D150632 
X-CRM114-Status: UNSURE (   8.55  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 marta.rybczynska@kalray.eu, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Oct 30, 2019 at 10:03:38PM -0700, Charles Machalow wrote:
> Changing nvme_passthru_cmd64's result field to be backwards compatible
> with the nvme_passthru_cmd/nvme_admin_cmd struct in terms of the result
> field. With this change the first 32 bits of result in either case
> point to CQE DW0. This allows userspace tools to use the new structure
> when using the old ADMIN/IO_CMD ioctls or new ADMIN/IO_CMD64 ioctls.

All that casting is a pretty bad idea.  please just add an explicit
reserved field before the result, and check that it always is zero
in the ioctl handler.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
