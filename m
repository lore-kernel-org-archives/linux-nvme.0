Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF74FC3DA5D
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jul 2024 05:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S+Yj4a5RN6UNpd9u4QVozaHPn8o6zThs9moLjs+9jms=; b=3lxDP3dR726rJtVgW1jowyxHjN
	+neltRI6mdQf+GA6HWRZle/xurt5IwHUFDuNPJ65a4eKfqBF0ofLnQgdanOTaUbKh5z6XRt1yW4Zz
	LPX5TqJcp0k1PgKQcpVIofm4RDqdrkve26v7G2ipHdCo9nt6QAP0EjKXd/Q10ei2c6Q1a0XAeKGtB
	NMwKj8it1Rrv9oRtM/F7j/7K2s3RSCVkOOgX7JVtuhP/bCHuJjIpbrC+vZ+3k3T87kIO8Vljrnz9y
	CCzM8/7WzmOYXTAwH89RmSUJLZRXak8F5H3eIX4sl/yC7hEurVaeN0691QPGWUq74XFE7ibDEg94k
	eZoh/X5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUgDK-00000001eAF-1hCL;
	Fri, 19 Jul 2024 05:31:30 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUgDH-00000001e8y-0heV
	for linux-nvme@lists.infradead.org;
	Fri, 19 Jul 2024 05:31:28 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0286768BFE; Fri, 19 Jul 2024 07:31:16 +0200 (CEST)
Date: Fri, 19 Jul 2024 07:31:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ping Gan <jacky_gam_2001@163.com>
Cc: hare@suse.de, sagi@grimberg.me, hch@lst.de, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	ping.gan@dell.com
Subject: Re: [PATCH v2 0/2] nvmet: support unbound_wq for RDMA and TCP
Message-ID: <20240719053116.GA21474@lst.de>
References: <20240717091451.111158-1-jacky_gam_2001@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717091451.111158-1-jacky_gam_2001@163.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240718_223127_367596_B2708F91 
X-CRM114-Status: GOOD (  13.74  )
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

On Wed, Jul 17, 2024 at 05:14:49PM +0800, Ping Gan wrote:
> When running nvmf on SMP platform, current nvme target's RDMA and
> TCP use bounded workqueue to handle IO, but when there is other high
> workload on the system(eg: kubernetes), the competition between the 
> bounded kworker and other workload is very radical. To decrease the
> resource race of OS among them, this patchset will enable unbounded
> workqueue for nvmet-rdma and nvmet-tcp; besides that, it can also
> get some performance improvement. And this patchset bases on previous
> discussion from below session.

So why aren't we using unbound workqueues by default?  Who makea the
policy decision and how does anyone know which one to chose?


