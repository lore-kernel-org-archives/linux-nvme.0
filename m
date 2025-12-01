Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB08D116E2
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Dec 2025 06:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=n1fxi/pROePUXiApQWSRfo/yEP
	pMvtO1bAkZI9GjR9JDLlgdpWWabMDb7UdBakisWONx70liLgUiZO6aT5LnqwqXgFUGkcnq86AoK5a
	K0LDy4z0BljKlcj5cAbaaw4i8mURyJ1rk4IlsCPzr3Sj7tCy8H9AACDCGYTS0vsoEMj2uMeY+NqFs
	t+3srIOo4O6LuOfLrorFdNb7cShMgRfsjBbtAKoj7JMNVF/IEKgaeBC4seT9FFrzfVZwPUO06YuWV
	lyUrooTgnJzRj0b6hHS+qLkwwfoLOWbWihmEDBL4tnc4pyj0YQ6A7+YGxbqM2V47nCggMTslWgN4+
	sPPf5YkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPxao-000000030Py-3ile;
	Mon, 01 Dec 2025 06:41:02 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPxam-000000030PD-11Dz
	for linux-nvme@lists.infradead.org;
	Mon, 01 Dec 2025 06:41:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4C2AA68BEB; Mon,  1 Dec 2025 07:40:57 +0100 (CET)
Date: Mon, 1 Dec 2025 07:40:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Christoph Hellwig <hch@lst.de>,
	Mike Christie <michael.christie@oracle.com>,
	linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v2 4/4] block: add IOC_PR_READ_RESERVATION ioctl
Message-ID: <20251201064056.GD19461@lst.de>
References: <20251127155424.617569-1-stefanha@redhat.com> <20251127155424.617569-5-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127155424.617569-5-stefanha@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251130_224100_427847_FEB5C9D8 
X-CRM114-Status: UNSURE (   9.75  )
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


