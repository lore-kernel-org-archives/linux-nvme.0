Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62FB6F94CCE
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Apr 2026 06:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bk4eh4+y88E1ppkNmoeItMrM9HzeM1GmmNSolWA9pcM=; b=L1dhHfToRG43WKKIsnNuS1aQSQ
	j4DM+Snf/tMxps7DT3phhgRIaFtBBABMOAVMYAT/NL8RA9L9p7TIIE2zKIO6KcZsBjywVV8U0FLbc
	PSuiqr2saq/O7DIKj3gKO2Q5OqATMPW+gQewYcFrUJaXZRzbW53VpH+Pn9aBVeXu0EourEpmOv+9H
	PT22SHn6gfEj8cRxhaGPv1Wrxm65MkqdLnhGuZBknx2K4ZnL13PRiMUaPbuILOC6vxMSl1Gn+Qrim
	7ePdHVUF4NcL6GGI5KkK9L4aRDs7smMKSCevNmxNi0iCMWE1zF6ycPTlVQGoM3CyS/FffuB0ule/y
	Y1/ZBoWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFR9N-00000009fQM-2Sg0;
	Wed, 22 Apr 2026 06:33:29 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFR9K-00000009fPw-2tRO
	for linux-nvme@lists.infradead.org;
	Wed, 22 Apr 2026 06:33:28 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1038568D09; Wed, 22 Apr 2026 08:33:21 +0200 (CEST)
Date: Wed, 22 Apr 2026 08:33:21 +0200
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
Subject: Re: [PATCH 4/4] nvme-pci: Use
 pci_dev_suspend_retention_supported() API during suspend
Message-ID: <20260422063321.GA6360@lst.de>
References: <20260414-l1ss-fix-v1-0-adbb4555b5ab@oss.qualcomm.com> <20260414-l1ss-fix-v1-4-adbb4555b5ab@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414-l1ss-fix-v1-4-adbb4555b5ab@oss.qualcomm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260421_233327_272114_EB755689 
X-CRM114-Status: UNSURE (   9.77  )
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

No matter what name we end up with for the helper, this looks like
the right solution, thanks!


