Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1DA9C48260
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Feb 2024 09:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LWkC4kHnd5rDNmh5GwYHGYDQ5SpZJY4qV1M3oGrOn2g=; b=rQb9InEVd9NVjbizT2U9s/Zgs1
	Ik2RIFZMmQbe23xJJwauw6QKgre1bT74kJ015gio2AKaYYm5nxg2ctyIrcI8E9S1jwpAuRsRzRNhC
	NGGOyOQd2iMI6XPuOusT6NDcsSCRPjP7wJhtZ3APee6/phZMsuhgeP0CvU+faOx9RHaopzotQqGrq
	Rql1NNoCDubjK8RmWuyIGxlCTZcSDPgQUJIgVtwDsayHhJmXKHR8sjcfuJdgShxJ+r1/HWC+7bDW9
	YkSLYEJcEjnxHGpDWtf1pz0tXL4SwsM8G03CCj0NmpRVYCsSjSNYtOEHin8JGvOWRInZjz5pXIppH
	G8VU+aJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raurK-00000001nYo-3nyI;
	Fri, 16 Feb 2024 09:50:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raurI-00000001nWA-00uL
	for linux-nvme@lists.infradead.org;
	Fri, 16 Feb 2024 09:50:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 63D7168BFE; Fri, 16 Feb 2024 10:50:13 +0100 (CET)
Date: Fri, 16 Feb 2024 10:50:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v0 4/6] nvme-fabrics: introduce ref counting for
 nvmf_ctrl_options
Message-ID: <20240216095013.GD19961@lst.de>
References: <20240216084526.14133-1-dwagner@suse.de> <20240216084526.14133-5-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216084526.14133-5-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240216_015016_209247_3403F250 
X-CRM114-Status: GOOD (  13.19  )
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

On Fri, Feb 16, 2024 at 09:45:24AM +0100, Daniel Wagner wrote:
> The FC transport is offloading the connect attempt to a workqueue. When
> the attempt fails the transport is starting to cleanup resources. It is
> possible for user space to trigger a crash because nvmf_ctrl_options are
> exposed to sysfs.

Eww.  I think the async offload is the real problem here..


