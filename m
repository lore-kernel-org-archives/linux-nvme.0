Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16DF5CCF9F8
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Oct 2025 10:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jKj4VW+bsCtS7XMPcgFQJUWCPMX8yKoG6UXYZZnBu40=; b=ZuW9mJn0lhYTYAdVpOCpI0KBUl
	+SpUXtGU+jsoOyPf8MnFQme7xsY57tXTCLBpT4uDm3+TAPKRygSBW3sP9cSIT2FcDYOavG4q2CY6o
	EbRVE4EsYzzxoIT7JEeMCh+tX3LTl2OR2LkSiwH3wEfgfiUQGVaag4/zXq/aOuQpbj7Bhs97bna/Z
	A/EUZztGFNfqmSJgNErogwZJPc3eHETq9+eOkcg/cGw8c2GNzkbBDb4fcclUMMdEWGgZuhxf62i5V
	W5jA6y97E9xulSVYsqBh9eJKogN9mL7jji76Jkq+4yE48t3ge6aUrjEDI+boY3t+x0eut3kW9oWMw
	QlcJQalw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vElyi-00000005rJT-2qYn;
	Fri, 31 Oct 2025 10:03:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vElyg-00000005rJ2-3Yo5
	for linux-nvme@lists.infradead.org;
	Fri, 31 Oct 2025 10:03:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3EE90227A88; Fri, 31 Oct 2025 11:03:21 +0100 (CET)
Date: Fri, 31 Oct 2025 11:03:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: alistair23@gmail.com
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	hare@suse.de, kch@nvidia.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH 1/3] nvmet-tcp: Don't error if TLS is enabed on a reset
Message-ID: <20251031100320.GA10569@lst.de>
References: <20251030035114.16840-1-alistair.francis@wdc.com> <20251030035114.16840-2-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030035114.16840-2-alistair.francis@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251031_030327_025366_92AF2F04 
X-CRM114-Status: UNSURE (   9.42  )
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

On Thu, Oct 30, 2025 at 01:51:12PM +1000, alistair23@gmail.com wrote:
> +				dhchap_status = nvmet_setup_auth(ctrl, req->sq, true);

Please avoid the overly long line.


