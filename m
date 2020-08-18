Return-Path: <SRS0=NqxM=B4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6379AC433E1
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 07:12:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34FAC2075B
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 07:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JrR0uogk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34FAC2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UO8cj5kMMTzn7trfxhfD1zevQYauHN3NROzx60DOwOM=; b=JrR0uogkXV5CxU89O8YRX/dJ/
	HXoJrG7yBPgp9s2y2T6rQ6sXFkMnJ6ULdUGNDoPpc1PHrbeqRwo0K3gMKvXMZX7lX4nJt6Q3ks6l+
	Z2dvFiyhcqWQ5Y7ZqvaZU9CDpac4zrAji7XWX3rTukstGt0zmPE9h0fTEI5PRv2Epbnn1jCi5C//N
	xbJccdf3C7Y8OiN9XQqsR+9PGYwi3D6qz5e4eD+ZI4bZNIlKVTqRaoIudVzqkPiX/xVSU+NtWDgi7
	QpJfxmQV0J6fVKmgmQXq3au782ZcGmyH8XErnK49UyipfSRbpZZq6LrhrU2e4XhuD4VYbP2QYItMN
	d8K3ylhpg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k7vn2-0001G3-8r; Tue, 18 Aug 2020 07:12:12 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7vma-00014I-Ix
 for linux-nvme@lists.infradead.org; Tue, 18 Aug 2020 07:11:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 807DD68B02; Tue, 18 Aug 2020 09:11:41 +0200 (CEST)
Date: Tue, 18 Aug 2020 09:11:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH 1/2] nvme: set io-scheduler requirement for ZNS
Message-ID: <20200818071141.GA2544@lst.de>
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053252epcas5p4ee61d64bba5f6a131105e40330984f5e@epcas5p4.samsung.com>
 <20200818052936.10995-2-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200818052936.10995-2-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200818_031145_444732_6ACB1E14 
X-CRM114-Status: UNSURE (   8.33  )
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
Cc: axboe@kernel.dk, Damien.LeMoal@wdc.com, sagi@grimberg.me,
 johannes.thumshirn@wdc.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Aug 18, 2020 at 10:59:35AM +0530, Kanchan Joshi wrote:
> Set elevator feature ELEVATOR_F_ZBD_SEQ_WRITE required for ZNS.

No, it is not.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
