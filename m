Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C14CD1284
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Apr 2024 14:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UYc73ySEqrJW5sxZAqEAigreqRM+TWlm3tDMZKgzWsU=; b=jRmGINeq08edsMko8Yc0mPAokH
	ZP9Z4Er+Iq25n/hRI5Xj9E2DaRD2N3belZoGT+KmJT2hvwESH8ZP4OgmSr6xv7iJ31FeL7ZGpcB/2
	ydze4vxU5Eq+lWHxU2OxsKV9lazk7xJpPLR+n49hELp0UEJCycAzpbLGZhuKEfTSJPNc8Rk467q/f
	b1bbMes73LkO4UgCmAzPoFU2MQ5DDWdVvfDdQFrfu7AeqPsYfo+l7jdU4noxWnAjl9wHgjnZhn5Sh
	hnFcakEb3s0e1keRhZvPpT/O6jpJo/QxzYNBQ6PRck9Zoj1DaR7yQO2Bi0K64StTsVwKx7ukeh6vO
	EtpNqzEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruC26-00000002J3F-2rBB;
	Tue, 09 Apr 2024 14:01:06 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruC1x-00000002Izh-24Um
	for linux-nvme@lists.infradead.org;
	Tue, 09 Apr 2024 14:01:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9CE6468B05; Tue,  9 Apr 2024 16:00:54 +0200 (CEST)
Date: Tue, 9 Apr 2024 16:00:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v5 4/6] nvme-rdma: short-circuit reconnect retries
Message-ID: <20240409140054.GC20883@lst.de>
References: <20240409093510.12321-1-dwagner@suse.de> <20240409093510.12321-5-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409093510.12321-5-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240409_070057_785434_6AB759BD 
X-CRM114-Status: GOOD (  12.12  )
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

On Tue, Apr 09, 2024 at 11:35:08AM +0200, Daniel Wagner wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> Returning an nvme status from nvme_rdma_setup_ctrl() indicates that the

Shouldn't this an be an a based on my highschool english.  Or does
Eeenvme count as a vowel?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

