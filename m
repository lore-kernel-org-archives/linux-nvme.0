Return-Path: <SRS0=AvHe=JX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434B1C433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 14:36:39 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD6EB61026
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 14:36:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD6EB61026
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=klmD3p83SQgogj8djfI3iolOIPMeLCcBHd7fi8roSds=; b=iDqSE0YlN0DMSUptW6Kt8g26K
	ArJTJOIWwF335b/cBRFdTU0Q3B8DWCrj4c1zXjjpT/y98DoPRuYn7fDnPcyBsCMe/0ZImaFp4tiR+
	qLa91/r+/ENERKkxLWq6kXPf5IGChYo+oJmmRyKlqWsFQZnW4Gnrtmfea5aje5RiHsGGtRnYqJnBB
	7MYy0/DGMn8rzuNxfBnUNeYcU4NXVkjFwqtKGnqiOKrXSugEm8BJezRyTAZlEwkfrHmDFZwzrHNU5
	0QCJ1yKu0oXPfDC/G08tAq9pynarx0cBQTlyfEdvWZLmAhtbUi/BbrlNDkHK9agvyaVMlj1d63DZY
	+F8mmtltg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lb2Lb-007rCt-VL; Mon, 26 Apr 2021 14:36:28 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lb2LZ-007rCX-RS
 for linux-nvme@desiato.infradead.org; Mon, 26 Apr 2021 14:36:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=S5RYPk/5MkfQVD3sOFTpf3aLIazZ9cbPc5S5lWQrYkA=; b=T6EpGl/bx5hlYVNeGEJ9ezJyKf
 3/rFlKmZJy1/ExPiQid+ahFGuzSyzDawMkXXFy3gfPFQ3bLvggqmWaZCxWerrBWnbMzOyurwm/tps
 Rdr9uvDBcethICiXuTYjxzEio5bt4dq2szeECMya1XJ9Z8GUdCVVjtThl3mA9B8T+nuIC6ppkXFwK
 xPv/xeccpvh5azLY10UNVMfGIkbg99GkwXJkNRUVLhQMJxGoEr9dRXl55M7LQBKLuPyT0XAqqw86/
 2dNfbLSgEYpdBh6qbHXHUU0s/KATCFS8FMwhEpT2Mg3/EjjSe4Zt61xtklwxjGOR21FYdwxMgGRwR
 hGTIvAKg==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lb2LW-00G13q-Ed
 for linux-nvme@lists.infradead.org; Mon, 26 Apr 2021 14:36:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8832768C4E; Mon, 26 Apr 2021 16:36:20 +0200 (CEST)
Date: Mon, 26 Apr 2021 16:36:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 axboe@kernel.dk, linux-block@vger.kernel.org,
 Yuanyuan Zhong <yzhong@purestorage.com>,
 Casey Chen <cachen@purestorage.com>
Subject: Re: [PATCHv2 3/5] block: return errors from blk_execute_rq()
Message-ID: <20210426143620.GC20668@lst.de>
References: <20210423220558.40764-1-kbusch@kernel.org>
 <20210423220558.40764-4-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210423220558.40764-4-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210426_073622_660965_57B3232A 
X-CRM114-Status: GOOD (  10.40  )
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

On Fri, Apr 23, 2021 at 03:05:56PM -0700, Keith Busch wrote:
> The synchronous blk_execute_rq() had not provided a way for its callers
> to know if its request was successful or not. Return the errno from the
> dispatch status.

Same comments on the accidentally sent other version of the patch.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
