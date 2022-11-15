Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A5E4C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 10:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wHEvef8guB5hGSNGQ/OXZngSR0dMGq+JXdAL6RgLQts=; b=RDLH/ZxBMZfcQ/BmEYRP6YAKzr
	HRc/VuT43gEKQZk/uJCarxagkx5yQ6hryBOKMCTuiKCqW8HGWYZwiZ/aJmzSZFSSYMBAMg3u5m5AD
	RqCl9UlsQ30bKX5gW/FX0hjN/N8qETrgmHO9ZZ86rYpXczLfEMt/WwY0QSMaLuZXlrM5+kTlplGBM
	d5LFELmi3klFmCwSzbvJzndNuzAYBelkIaey1r4pomI3CQ7vfaewQR97PJjmsTOTH4y+ygeP2lVNv
	BccH0WYURoO8Q7svRZh7gouYBcGZb666VTp+RKnKRN73oIwZEXhS4ocm0hzVtq4urrB65VuShsoD2
	OeTb3C7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1out4I-009qww-J5; Tue, 15 Nov 2022 10:21:26 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oush8-009e4k-Cn
	for linux-nvme@lists.infradead.org; Tue, 15 Nov 2022 09:57:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id ED3C367373; Tue, 15 Nov 2022 10:57:26 +0100 (CET)
Date: Tue, 15 Nov 2022 10:57:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
	Gerd Bayer <gbayer@linux.ibm.com>, asahi@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: Re: nvme-pci: split the probe and reset handlers v2
Message-ID: <20221115095726.GA26021@lst.de>
References: <20221113161138.883195-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221113161138.883195-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221115_015730_602187_139996B0 
X-CRM114-Status: UNSURE (   8.21  )
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

I've pulled this into nvme-6.2 now.

