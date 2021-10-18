Return-Path: <SRS0=IkIX=PG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590B4C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Oct 2021 04:50:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FB9B61279
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Oct 2021 04:50:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1FB9B61279
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VszlENjCJ3QQ5KvFIeSsfGOEUhb2i0XX2RaQ3R5pOdc=; b=WTxAT1eqISyUcyj57aA3RXeHof
	H8IE7PV5dkxCGJOfJgmWJCNnV3Kh2PKkOnRNEz8ARH9613YSlZy193IYRqAvLj9akpD7AF/HnaMsA
	qS+eKVfGx+aPQTvnqThlQMeis2k5rTyvTXsrj9Q31W8ulEZZrFUca9BEKmu5iNNVUms8XcvJIEcEo
	Ne08MJJs+U4fxdr+fU2KAr/AZ0UuqbjkxjeJG8EgGh1uUk2hKjXFYvAgXzft8zZYwxc529xL2UrXK
	r8dtcvL+v/OIvTHnT6D/QBvYYjP4ij8pj0KdbF+/b0eF7uHMIgREMkKRyFH60QPSufZ1Ue49zp9ri
	nArNDPCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcKbg-00E4aJ-OP; Mon, 18 Oct 2021 04:50:40 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcKbe-00E4Zb-F4
 for linux-nvme@lists.infradead.org; Mon, 18 Oct 2021 04:50:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3519D67373; Mon, 18 Oct 2021 06:50:35 +0200 (CEST)
Date: Mon, 18 Oct 2021 06:50:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, chaitanyak@nvidia.com, israelr@nvidia.com,
 oren@nvidia.com
Subject: Re: [PATCH 1/1] nvme-rdma: fix error code in nvme_rdma_setup_ctrl
Message-ID: <20211018045035.GA23817@lst.de>
References: <20211017085816.4940-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211017085816.4940-1-mgurtovoy@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211017_215038_678709_F147D33C 
X-CRM114-Status: UNSURE (   8.36  )
X-CRM114-Notice: Please train this message.
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

Thanks,

applied to nvme-5.16.

