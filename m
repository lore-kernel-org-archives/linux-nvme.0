Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D252C83F26
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jul 2025 07:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=onAwLOjB5xtblQ13CkMHNcEAFW8N/uJPyt8RpJ2uRZ0=; b=uD2e1RJAXi7+b3wf7Yn02msIs4
	t5vrt1HqPvsihCOOA1YVMj29fBzkLKgUA9DjvK2lZXjTAk3GdxPTBXYpIaHdN3+OjKhWSD7SR06xZ
	zJI4tmDgibWqy2r2A1WNMHDUVdncAqj5/i7OEVK0M5y1gssVeQN3HM6rbIDH3DzPv3CYK0LWayTIM
	7M3qFfvOdRnRs8sBGS8Y3bl0ph1aDBEUhu/Jg/a3ol9MVmt2EzJGUXXbqOygqb1cdVgPk1w4b1/SM
	3yX4JyP25mWczME57/6+EihQ+0S8sXtxc6ppfXUtmR4sLpxjzcYDSfd9g5Y7p/2sKazSU/REfTUM5
	21SoN0RA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugfA9-0000000GBGc-0xL3;
	Tue, 29 Jul 2025 07:54:17 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugfA6-0000000GBEA-2WSM
	for linux-nvme@lists.infradead.org;
	Tue, 29 Jul 2025 07:54:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 66D9A68BFE; Tue, 29 Jul 2025 09:54:01 +0200 (CEST)
Date: Tue, 29 Jul 2025 09:54:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: hare@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [RFC PATCH 0/6] nvme multipath eBPF path selector
Message-ID: <20250729075401.GA23933@lst.de>
References: <20250729070653.125258-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729070653.125258-1-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250729_005414_779968_00EA6DB9 
X-CRM114-Status: GOOD (  13.51  )
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

On Tue, Jul 29, 2025 at 09:06:47AM +0200, hare@kernel.org wrote:
> From: Hannes Reinecke <hare@kernel.org>
> 
> Hi all,
> 
> there are discussion on having to deploy more complex I/O scheduling
> algorithms for NVMe,

Are "we"?  Where?

> but then there's the question whether we really
> want to carry these in the kernel.

If it makes sense, "we" do, yes.

"We" don't want to export random crap for sure.


