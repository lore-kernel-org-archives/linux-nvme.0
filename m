Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB291093188
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Mar 2026 07:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=lDUFpqP/cq8Jwrwpuf+c46ttVR
	dMJcLnIrbbb45QdzTCd2aESUZBwoi0YdgkzLW6fNHdEdCydFHkoyWU+oVePLWgU0lexHoCsHZhxTN
	VZnfXBzoTQrcDVbfBzMiNC6FGOu4tniRwu6C4Q9i0jZnvLMsBHJRX7ihLLeP5nLRSTPGxclnR08u0
	yG1lR6bEtVbIVx53sbZhsSXQhFfNhGlrsx8q8DbCFt/ttC85cJVHEdb7Nwte821UAiVmDlyDrIKF2
	Pg3nZaRg0W/5bN4RMgZ3uF6uBscP/jQzp8ZPJOnXVvkk/fP8BYwK4DwlZcgPS0Bv0ThSD8MLrBKgQ
	DIt3HuUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3UkY-0000000CIdS-3DvH;
	Fri, 20 Mar 2026 07:58:30 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3UkX-0000000CIcx-0jHB
	for linux-nvme@lists.infradead.org;
	Fri, 20 Mar 2026 07:58:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C2A5C6732A; Fri, 20 Mar 2026 08:58:26 +0100 (CET)
Date: Fri, 20 Mar 2026 08:58:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>
Subject: Re: [PATCH v2 3/3] nvmet-fc: add WQ_PERCPU to alloc_workqueue users
Message-ID: <20260320075826.GC14771@lst.de>
References: <20260223102336.108512-1-marco.crivellari@suse.com> <20260223102336.108512-4-marco.crivellari@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223102336.108512-4-marco.crivellari@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260320_005829_345577_CBE786D0 
X-CRM114-Status: UNSURE (   9.69  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


