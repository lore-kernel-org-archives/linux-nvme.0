Return-Path: <SRS0=sGEd=4I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B3FC11D05
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Feb 2020 14:25:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92A10207FD
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Feb 2020 14:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jG7nPEvY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92A10207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ABFn22OpRYmo8zTP6VDNTED4/erjz2t+dwTZsnBbOvI=; b=jG7nPEvYRzyCyg
	Z6bBxPW35cTfL37fF4axXeF0buRM5qMaGJyOCzMyKKRrZZ59vyCoN1+zTbWnYuTI4XlJdGIQEcCpC
	sQS0SwkY/tnTlFL3tdRJNY1hH1d2EC7hA3zzJdIEA3BjU0OURVq42YKCdaNiAoP5p8qtc+83SyKUh
	G+L/uHM5pWkYvYij/myZx2i3kCmwjYiImxIBmanRPRza1RxbWbFPmVYuD6tmgL+3uE4eN5MQLqOke
	bZ33v4uyoknTNH2l0nSFr7y4b/XzAx7DNvdPh1cZwWUwmkxaoCnAz2uitVJM/mqnzVd0d2FcciP8T
	Y83ZqvPG5oc3HDA9iePg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j4mlU-0007Em-WF; Thu, 20 Feb 2020 14:25:21 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j4mlR-0007ED-SL; Thu, 20 Feb 2020 14:25:17 +0000
Date: Thu, 20 Feb 2020 06:25:17 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: NVMe/IB support
Message-ID: <20200220142517.GA20993@infradead.org>
References: <12132471581079402@vla4-9d01d86ae0b7.qloud-c.yandex.net>
 <20200219152053.GA13942@infradead.org>
 <e2f116a2-ee5a-ee53-32c2-1f1e8d998567@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e2f116a2-ee5a-ee53-32c2-1f1e8d998567@mellanox.com>
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
Cc: Christoph Hellwig <hch@infradead.org>, Talker Alex <alextalker@yandex.ru>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Feb 20, 2020 at 04:13:07PM +0200, Max Gurtovoy wrote:
> 
> On 2/19/2020 5:20 PM, Christoph Hellwig wrote:
> > On Fri, Feb 07, 2020 at 03:43:22PM +0300, Talker Alex wrote:
> > > Hi,
> > > 
> > > is there really exist NVMe/IB solutions?
> > All the original NVMeoF development was done on IB, just using the
> > RDMA/CM IP based addressing.
> 
> I guess we can consider adding this code one day, for users that can't use
> RDMA/CM (SRP supports both options).

The NVMeOF RDMA transport requires RDMA/CM.  But RDMA/CM can also use
IB addressing, which should be easy enough to implement if someone
cares.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
