Return-Path: <SRS0=LwVW=6L=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08431C54FD0
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Apr 2020 15:06:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAB72206BF
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Apr 2020 15:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Sq8OZZDE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAB72206BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=trpleaO1dl9MAcnTVKJuzanzqiT+jzOAtMtSnZ4kNYQ=; b=Sq8OZZDEpKKeQ8
	M9Ra+w2pwzAAdq6uCQkyT63E8L2yMB1IeIwGxXC8nmg+yQDDUrqrdJ/hPe0beOuFT88YKd8k5ijEI
	9smHjxjGFENPfd2NGRvr6T1X0bsGo0mHA0727wZVHZdwU2gomMGX1yXTxgNILzzQxHoQcBEriEk5i
	ko0KyVDZfvo6GkZcwk2G4xRIMRz1Z68Rg3inyQVfuYLei2mcM8pkfBDppZ1M3TgAc9c0kmYTyYZb9
	uTpQcSeqPMWhLiA3tb3o1QFYHgWFUU0/3siZxvSG0acm2TuJgtxITRXXP2IUehouZkqmIEr7/G8HY
	32RRx3VGL3LKOUntxIww==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jT5Kt-0002UX-7W; Mon, 27 Apr 2020 15:06:19 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jT5Kq-0002Te-UB
 for linux-nvme@lists.infradead.org; Mon, 27 Apr 2020 15:06:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3CC5D68C7B; Mon, 27 Apr 2020 17:06:13 +0200 (CEST)
Date: Mon, 27 Apr 2020 17:06:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Niklas Cassel <niklas.cassel@wdc.com>
Subject: Re: [PATCH] nvme: prevent double free in nvme_alloc_ns() error
 handling
Message-ID: <20200427150612.GA5910@lst.de>
References: <20200427123443.520469-1-niklas.cassel@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200427123443.520469-1-niklas.cassel@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200427_080617_119738_F3E94514 
X-CRM114-Status: UNSURE (   6.22  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@cnexlabs.com>,
 Keith Busch <kbusch@kernel.org>,
 Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>,
 Christoph Hellwig <hch@lst.de>, Igor Konopko <igor.j.konopko@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Applied to nvme-5.7.

Not a huge fan of it, though - but I think I have an idea how to sort
some of this mess out with better block layer APIs.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
