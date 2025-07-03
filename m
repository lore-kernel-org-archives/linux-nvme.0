Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EDADC83030
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jul 2025 12:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2E4q/VTewWdAiwGBze8dCv3IXOy5Ea14A1k3uP8YBWc=; b=0hzOMFQHeovYbMsnXcxiaoqth8
	GMk3P1w6UagKADHqMude6GXNtpZ+ew8UZulUxDUHOBpOrItFMWIxYkaCWACjt3EF6ob1BEeIfaLLT
	idBW43fPtgNEvBlaEthfHID5l3Jyos6b2JBr9cijA2m6Snr+yZbQG1Ei4f6kTbxUCBkvsMob0MPIZ
	C3VAaBlJF2sabGFR0I8ohv7SsOjXtOeO6uGDm7hHoenAdreoSV8aTZuRYExSksCqf2FnNWfXOhhIB
	FKS8luKFFOv5vArVo5NfhuBxIqW++lzSURENXKoYKtP0ly6GEq7RIc+1gk9JXDawK7BK8gzVdqqj2
	5gvMbsZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXJKM-0000000BNKa-22TP;
	Thu, 03 Jul 2025 12:46:10 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXIMC-0000000BCOj-1CRv
	for linux-nvme@lists.infradead.org;
	Thu, 03 Jul 2025 11:44:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0192F67373; Thu,  3 Jul 2025 13:43:54 +0200 (CEST)
Date: Thu, 3 Jul 2025 13:43:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: linux-nvme@lists.infradead.org, rdunlap@infradead.org,
	kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, nilay@linux.ibm.com, corbet@lwn.net,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] nvme: typo and minor cleanup fixes across host
 and target driver
Message-ID: <20250703114354.GB17686@lst.de>
References: <20250625041643.174110-1-alok.a.tiwari@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625041643.174110-1-alok.a.tiwari@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250703_044400_461255_482A96DE 
X-CRM114-Status: UNSURE (   7.92  )
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

Thanks, applied to nvme-6.17.

