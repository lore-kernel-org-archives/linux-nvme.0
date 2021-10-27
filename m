Return-Path: <SRS0=8pqL=PP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABA4C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Oct 2021 05:57:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D99160234
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Oct 2021 05:57:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4D99160234
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cWD/0wcl9/aN/PJJHjD6d1fl3vzUfRdjNDXYNlslnzg=; b=wL5x7xiGX2SgWgpeO2i//y7arj
	HYjHxd9c1XYSu2xYk0oHGvVT3vhD3RFn1vi9hkbYGq4Mq0y3QkgfTDqtOTz0FfHmkDuYYPoQWsr2l
	zcihYKlo0+TTFbArCwbHBQaEgKLzPDVyNHMjLzaktjsLaHpI6fAJC2Ck4559159mCj64gaTNIE7c/
	8AiR6R2I3QfgsTaHSkrsVLbc7P8gz43h31+BCMKP/b+ALgsybPZYMaOffZeoYh62OQwk6BDo7Mgwd
	33kdS/0P7TFm6tFJMDuHrhqk4AZ2E4wnjf3j3TcsHBYu1IElJVbyWypxoHfMKvQCC19s+Wb9K0da5
	vA2x6BIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mfbwV-003wUC-9t; Wed, 27 Oct 2021 05:57:43 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mfbwR-003wSy-5Q
 for linux-nvme@lists.infradead.org; Wed, 27 Oct 2021 05:57:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9F54A67373; Wed, 27 Oct 2021 07:57:35 +0200 (CEST)
Date: Wed, 27 Oct 2021 07:57:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Varun Prakash <varun@chelsio.com>
Cc: sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-tcp: fix data digest pointer calculation
Message-ID: <20211027055735.GB9635@lst.de>
References: <1635182250-4006-1-git-send-email-varun@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1635182250-4006-1-git-send-email-varun@chelsio.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211026_225739_377673_34B5567B 
X-CRM114-Status: GOOD (  11.04  )
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

On Mon, Oct 25, 2021 at 10:47:30PM +0530, Varun Prakash wrote:
> ddgst is of type __le32, &req->ddgst + req->offset
> increases &req->ddgst by 4 * req->offset, fix this by
> type casting &req->ddgst to u8 *.
> 
> Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
> Signed-off-by: Varun Prakash <varun@chelsio.com>

Same here.

