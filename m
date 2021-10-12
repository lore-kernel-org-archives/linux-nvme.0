Return-Path: <SRS0=8G/6=PA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAB6C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 15:07:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEE2360527
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 15:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BEE2360527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4HbtxnZNpWYtwmfUHcQ8+jnkx/DH+Ei4eRJeRjDYSvE=; b=z+AOc8wsAb+GEU
	vOZ6vORqIAzsXNmPQpfx5N7fgHjMgBQF1c/+jJlb1rDqzvy/+Cx2nZnEA0uBV+J9ug9I6icJruIE0
	wOkOMGOZH15C20h2yWZxJya4Dk7V35BRMmD4XCh7EEOF4Z0zMhGBiCsz1mHtQD9esQ1dyF5+Nz+Vr
	HiO+GjnxcQLVTBFz8/iJ+EXxn92N5yMOMrfuPiexWNyxQu5HOfDUj2Hti749sQGn3Vh08Pc6rt1tb
	/4tDkrleGsrLiehbuC/8qTVMlrZWJwDLGzwQSUokAosaEBN8gRD4Ll3j2pAJIjfC8A51qK+fjd9wS
	r0Y9/JD136PxVGV5dk1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maJMg-00DICd-JI; Tue, 12 Oct 2021 15:06:50 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maJMd-00DIBK-Na
 for linux-nvme@lists.infradead.org; Tue, 12 Oct 2021 15:06:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7F33C67373; Tue, 12 Oct 2021 17:06:41 +0200 (CEST)
Date: Tue, 12 Oct 2021 17:06:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Keith Busch <kbusch@kernel.org>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: switch block layer polling to a bio based model v4
Message-ID: <20211012150641.GA20447@lst.de>
References: <20211012111226.760968-1-hch@lst.de>
 <07f31547-5570-4150-7a4b-1d773fb9fa87@kernel.dk>
 <040104f6-720d-35ed-7e15-a704e6488fd4@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <040104f6-720d-35ed-7e15-a704e6488fd4@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211012_080647_944606_5A44AF07 
X-CRM114-Status: GOOD (  12.55  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Oct 12, 2021 at 05:57:43PM +0300, Sagi Grimberg wrote:
> Jens, is that with nvme_core.multipath=Y ?

That is the default.  But for most PCI device namespaces are private
by default so we won't use the multipath code anyway.  Only for
dual ported devices, and even for those that flag might need to be set
explicitly at namespace creation time.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
