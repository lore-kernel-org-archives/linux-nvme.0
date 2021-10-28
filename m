Return-Path: <SRS0=3Qb0=PQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A421C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Oct 2021 14:01:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 908AD610CA
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Oct 2021 14:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 908AD610CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ctLX+z4iLAcuduw4sgngT+jIVB4tE9HoTdKvJusmcak=; b=mXXZYo85zPaRQcQYfHEn4lpZYa
	3dtL3C8SiXU58+7rQa+chlbsno41QRy34QEHv/+CVyyCbgc7Z9/T573rvlGo5QDJ+1LaVkOVRqvtO
	wWCfOZXC8vfYFeM4WtEjPc9hTzaSONie6mHCLvJ8DVtJ/oHJX2SYkeazC7CQbpvRAMyhvTzNss7IR
	cVF6lVSPwiIXdOShoA4hlZqANve1IXfjivSK7avBuqfZSskx1lMkgGyu0sp5jd24LIh/f5cD2yZzr
	UJTBgfEgxEIKt2y2k/avZ6k08cZYEAI738/rycLZzWGjUNzR56mnAvlgCzaXbjZn129QZcgq8v+xh
	KTviu+Kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mg5xw-0082vE-Bm; Thu, 28 Oct 2021 14:01:12 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mg5xu-0082qL-0c
 for linux-nvme@lists.infradead.org; Thu, 28 Oct 2021 14:01:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0E1EA68BFE; Thu, 28 Oct 2021 16:01:00 +0200 (CEST)
Date: Thu, 28 Oct 2021 16:00:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Varun Prakash <varun@chelsio.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet-tcp: fix data digest pointer calculation
Message-ID: <20211028140059.GA3550@lst.de>
References: <1635182214-3958-1-git-send-email-varun@chelsio.com>
 <20211027055725.GA9635@lst.de>
 <26648af7-f459-5d43-bc2a-ef2c63715418@grimberg.me>
 <20211027071316.GA11266@lst.de>
 <252308fb-d557-34ce-5c7f-a6307f92b111@grimberg.me>
 <20211027144914.GA1851@chelsio.com>
 <9dc338a1-d047-0d48-15cd-317b637d5491@grimberg.me>
 <20211028104947.GA1690@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028104947.GA1690@chelsio.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211028_070110_235953_A47E89E8 
X-CRM114-Status: GOOD (  11.62  )
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

On Thu, Oct 28, 2021 at 04:19:48PM +0530, Varun Prakash wrote:
> Both the patches are already applied to nvme-5.15, should I send v2 or
> create a new patch for u8 * -> void * change?

I'm about to send the pull request with them to Jens.  It is too late
in the cycle now to respin again.

