Return-Path: <SRS0=yUYt=43=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B71BC10F27
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2020 17:54:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E218521927
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2020 17:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nbm55tHB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E218521927
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OC4sYSxTj+Wl7F9nAEAwzQNX5s7ft6U5UA0hkFIYWhM=; b=nbm55tHBxj3tEn
	QcRMB7W7agr1HLQi3aWFLuJ1yd2mpWQ4IK8By62Qtol/NkncRjrcOcPb1tTd/4sLAt/8xR+awAcN8
	cUm+FC7kfTsxwC+3ZS2s89hed4axqGNENWFOW3oE7zJ7qG8wFI6XvsQ/j6/YRV8KMUyQKDCcQikSw
	LVvGcSfLvNXB5jgrE/CdWTVnJc9AEafbLhJFlvm3KPs9GdJ/zn6J08AsV3jY6HlGgs6Z5kVNWkQGU
	71ZwV6nn49ZCLP2RlogMeo2PYbKallpuF6or/mp8r2nRgLsVyLQuZWGnaNiuzQN1Qf3y7sXfW9B2d
	JZ88nK9XxumTP+nh+C+g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jBj5T-0002sB-7I; Tue, 10 Mar 2020 17:54:39 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jBj5R-0002s2-Qi; Tue, 10 Mar 2020 17:54:37 +0000
Date: Tue, 10 Mar 2020 10:54:37 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 1/1] nvme/pci: properly print controller address
Message-ID: <20200310175437.GB9203@infradead.org>
References: <20200309150412.63297-1-maxg@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200309150412.63297-1-maxg@mellanox.com>
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
Cc: kbusch@kernel.org, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Mar 09, 2020 at 05:04:12PM +0200, Max Gurtovoy wrote:
> Align PCI address print with fabrics address that is printed with
> newline character.

Should be nvme-pci: in the subject.  Otherwie looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
