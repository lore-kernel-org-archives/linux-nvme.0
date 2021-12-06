Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ACE7C433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Dec 2021 07:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VszlENjCJ3QQ5KvFIeSsfGOEUhb2i0XX2RaQ3R5pOdc=; b=TMXUn0yHpWnuuiACB7G25W0UwE
	AFpw6eywp3Fk6uQvK3uy3EcUnuGjTXPfODPfqX2v/AsMvxqQtApcNYbgvZAM9a+EkgtX9SPHGVz78
	VUQhBt1lLR7TeWjnd2MIwPIqXXmwTnD39TH+RZ4YbeRJJuwCFBARKN5Jy09Inpx1qN+X7DFNy+oBS
	DfZnPucCSMgrgAWIXAKD7eVc9v9Gf8RzPUFRJjH17J+kws3gM5Ac7mlfLicxnYJdnFcMbvliqDjbM
	Kj5N4hFFZAj6o8LlA05HTHtVlgZ3FD/klpjs+ErtprEv7FsEEskwKNLzvA9uVPIh6tAXg01PtGp9h
	cAhrX8lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mu8pZ-002oOR-7f; Mon, 06 Dec 2021 07:54:37 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mu8pW-002oN6-U2
 for linux-nvme@lists.infradead.org; Mon, 06 Dec 2021 07:54:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 33E9068AA6; Mon,  6 Dec 2021 08:54:32 +0100 (CET)
Date: Mon, 6 Dec 2021 08:54:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de,
 Max Gurtovoy <mgurtovoy@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCHv3] nvme: disable namespace access for unsupported metadata
Message-ID: <20211206075432.GD10917@lst.de>
References: <20211130161454.3835061-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130161454.3835061-1-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211205_235435_143656_5C5FEB93 
X-CRM114-Status: UNSURE (   7.29  )
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

