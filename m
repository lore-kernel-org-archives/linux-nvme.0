Return-Path: <SRS0=z7iv=AZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C472C433E4
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2020 11:19:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDD6221D90
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2020 11:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N/r/BBZe";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j62qzG0G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDD6221D90
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VCXGyVjj8aMCTByO/suRDm4ejZK/tHy2X5hTv7B4iFM=; b=N/r/BBZecvihpb/yyK4WU3Dbm
	7V4jAXH00+B75T3CDTZ/ULvPzuYxrqTL23YaK5mLz6fn2VYUbWhIeU4ug/8eEC1G9OQEAXTWZOQk3
	VA27VNDGCuEtQEGyLqZ9kNA6x6XjyQUwNZt8xNFfRmE/4agIgKfv+jjzfLnkQ9zAC2YNYK0H9B5UA
	u4eIffZN5fnn0oiBs44BpNNLE1JgcJjsQLtdxEInmm0PTe0RjOe1amlUc1a6aC834H57Rj0aDReVo
	gIch4Qzqrx4JR/ploPXUgio5hiwUy7zj7BAvUoH0XvFNi6R8TsObCEoMHfwnG4GKTgCdwC/84YrkX
	sXXGKWFAg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jvIyR-0005fO-Re; Tue, 14 Jul 2020 11:19:47 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvIwn-0004bC-7s
 for linux-nvme@merlin.infradead.org; Tue, 14 Jul 2020 11:18:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=1xpbZGm2nJL6UnmEc7LAIubbLFVj3d9FLCGiaCncAyo=; b=j62qzG0GJPeJ1eIB78lrpN50Ze
 0zdfFLU5GukcfMUMRO4vKRJR/HUZ6rOB3WpuyLmCJIAtOeAtXA6Ejw1RJof1K2i5Zr8LU+D4Wyoo9
 1+HxqMaMxvvGdtc1MshHl3+baEIwx+F7EdOt85ieUj0eEnzjpa3OLl1Bu5uReY/isSa1J2Xqgy/yd
 zTMyB9eoe1W+gWK2peLhlIFohoIOUO9jN+ka2a847UTu8NW9mk+jdEziIKKkXGZ5edlfETQ5nbjih
 p/OSOPgfttj8wELaE+l+Jt91r04em0uwRmSYAP+vWXBIKFCWBXv1nhuuEr+Tilrzs0ttFKIs+KXsZ
 qK1KoytQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1jvIwl-0006on-HB; Tue, 14 Jul 2020 11:18:03 +0000
Date: Tue, 14 Jul 2020 12:18:03 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 0/2] NVMe/RDMA CQ pool patches for 5.9
Message-ID: <20200714111803.GA26195@infradead.org>
References: <20200713085330.133842-1-maxg@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200713085330.133842-1-maxg@mellanox.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: yaminf@mellanox.com, sagi@grimberg.me, israelr@mellanox.com,
 linux-nvme@lists.infradead.org, hch@infradead.org, idanb@mellanox.com,
 jgg@mellanox.com, oren@mellanox.com, kbusch@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Jul 13, 2020 at 11:53:28AM +0300, Max Gurtovoy wrote:
> This series include 2 patches from Yamin that were removed from the
> merge window of 5.8 since it caused conflicts between RDMA and Block
> trees. It uses a shared CQ API that was merged to RDMA core layer to
> improve performance and reduce resource allocation.

Thanks,

applied to nvme-5.9.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
