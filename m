Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498EEC36010
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Apr 2025 06:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ClQDOVRaAVXfX5ipXHv3zKXwa6BLsiTGg4eC2d35SuY=; b=2jzkU1XcPrRJlOET2YxUPavjQv
	2d6goXGnICqbLF8Qw3fPq11rMajd+29coqQUsJ5aZX0tjplEgFZZXgvKi2ajAZO6G4se4FxER+Rzw
	iYIjSRk814JiuOztmmOVWYnKvQ3I++TTz6W4/YCrM1V26nnl6NuMeUtrm8BOVme1qf2rRhVx6yA3Q
	9P4ocJ86XdLcn6U9rFUjTZr7i8WmO9/H2PfY1RxFjxMUJhpHhssjqUjDfcY8Py2I9raaGNB4PNx6T
	4NpqArNSYIBSptliGLsTpcrfjaQM4vjIr7FDdTqFTH/fOLckQc/sNBrMkvUp22yMG+P4bURd1Rgh9
	Q66Unjfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0aWe-0000000Asjm-127w;
	Fri, 04 Apr 2025 06:27:36 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0aVR-0000000Ascd-0Zyf
	for linux-nvme@lists.infradead.org;
	Fri, 04 Apr 2025 06:26:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DD2E668C4E; Fri,  4 Apr 2025 08:26:17 +0200 (CEST)
Date: Fri, 4 Apr 2025 08:26:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvmet: implement persistent read-only namespace
 feature
Message-ID: <20250404062617.GD31468@lst.de>
References: <20250403144747.43043-1-hare@kernel.org> <20250403144747.43043-3-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403144747.43043-3-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250403_232621_317749_B85C33D0 
X-CRM114-Status: GOOD (  13.77  )
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

On Thu, Apr 03, 2025 at 04:47:47PM +0200, Hannes Reinecke wrote:
> Per default we try to open the 'device_path' read-write, which might
> fail if the device is read-only. So retry with opening read-only, and
> implement a new 'persistent_ro' flag if we did so.
> And map that flag onto the 'Permanently Write Protect' setting in the
> write protection feature.

This sounds like a really horrible interface, but maybe there is logic
for it so explain why we don't require the explicit read-only attribute
to open read only.


