Return-Path: <SRS0=nCXg=ZD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F84C43331
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2019 20:44:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BE4D206BA
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2019 20:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="szqC/7L+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BE4D206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tn7iPkp8HSokHSbV3QExshvJmZiQ5VkW3ZRD/YiQUXA=; b=szqC/7L+Baz+w4
	rDHxdOc6JF2vuEiOjux6m8OYflCyi8tCkvyw/xFRowS5VB9pmfdc9/9NZ7rKDBrtRlF8HpsPLaq3I
	spKJPIdSfdOvg0GENNRO2kXJ5HC2WF2T2FOgOez/7bSVRebwG6bPNMVfdV6VUrpH7oEHAXgUypQCu
	m1qZCy3RQDOhll0gSnmlwpEDvIpekeabXJgzV5vi5mJb2CY31bU3k6UO2BOEPfHxTKD6Gi2LvUSvF
	nHK9VFu6/7wfC5FLR+Nhxwfq5s1LGA1HGoBb18TKMdOmzJWoLAl1U7PTqEPDDRgkX0VwiUqtZhqEk
	vJNRl+7nco4LkYIKT3aw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iUGYO-0006aY-8N; Mon, 11 Nov 2019 20:44:52 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iUGYM-0006aG-4u
 for linux-nvme@lists.infradead.org; Mon, 11 Nov 2019 20:44:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1AD8868B05; Mon, 11 Nov 2019 21:44:47 +0100 (CET)
Date: Mon, 11 Nov 2019 21:44:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 2/2] nvme-pci: poll IO after batch submission for
 multi-mapping queue
Message-ID: <20191111204446.GA26028@lst.de>
References: <20191108035508.26395-1-ming.lei@redhat.com>
 <20191108035508.26395-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191108035508.26395-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191111_124450_342461_60ABAEC7 
X-CRM114-Status: UNSURE (   8.28  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Long Li <longli@microsoft.com>,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Nov 08, 2019 at 11:55:08AM +0800, Ming Lei wrote:
> f9dde187fa92("nvme-pci: remove cq check after submission") removes
> cq check after submission, this change actually causes performance
> regression on some NVMe drive in which single nvmeq handles requests
> originated from more than one blk-mq sw queues(call it multi-mapping
> queue).

> Follows test result done on Azure L80sv2 guest with NVMe drive(
> Microsoft Corporation Device b111). This guest has 80 CPUs and 10
> numa nodes, and each NVMe drive supports 8 hw queues.

Have you actually seen this on a real nvme drive as well?

Note that it is kinda silly to limit queues like that in VMs, so I
really don't think we should optimize the driver for this particular
case.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
