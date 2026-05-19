Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D8E0CD4F52
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2026 08:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=gfHHFCmQzznNlxyfnBAo15BETP
	A15Qg5avU3pn//LTCC/41SUXi8OHyawzDWv+JTfhFrvPWseRf8c4fpg/twtu94KqhBbwB/HP+LERk
	3xel83vxQgUKjIiKTuAtLWbknuSw7Wvo31DGUMXov64hjFskx0qGs4kvSulRe6h7kSwfXvUYJHpau
	agbpdHruyJ6v4qgxqyQV6LHbBQz+pTrP0Y9nn8EecDJToRHC8xg2kPgtoSz63a9HkYjgjxZJPiJXI
	ENK7hr5FYi8+tR0xiQXoYJ9vFZamTp6ENW4sfE6sJNJ4NwnuXAybIwGnnvRzXnHEqXOcAmVuaD845
	c/uR5hbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPG6e-00000000jQg-3s7t;
	Tue, 19 May 2026 08:47:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPG6c-00000000jPb-42h9
	for linux-nvme@lists.infradead.org;
	Tue, 19 May 2026 08:47:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AD4BF68C4E; Tue, 19 May 2026 10:47:09 +0200 (CEST)
Date: Tue, 19 May 2026 10:47:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 4/4] nvme-pci: Use pci_suspend_retains_context() API
 during suspend
Message-ID: <20260519084709.GA17226@lst.de>
References: <20260519-l1ss-fix-v2-0-b2c3a4bdeb15@oss.qualcomm.com> <20260519-l1ss-fix-v2-4-b2c3a4bdeb15@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519-l1ss-fix-v2-4-b2c3a4bdeb15@oss.qualcomm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260519_014715_147764_3A75070C 
X-CRM114-Status: GOOD (  10.23  )
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

