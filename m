Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25DFBC19F32
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Mar 2025 15:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=A4ksmwHDeScs4h4MVtpUmBfEIf
	5JmjamGu3LNf4ldhlBiSWkTVHmzfqzzuV7jjfdg8SnVMOxrrmJ0oBef4aPt5mhGluD/vQZ6CkzRnN
	3dDLT1+4uhbjk1GGPzpnhDBQC+t4nj/ub6NsB3CiRGhw58E9NoBY0PTTJFohbTU5Hre8AQUtfaKzb
	RnDbnPQRLOofljeXmGAf/wYGatIFpS+Y+6BL8AMAxLPFWUaISvn9Hpza3SGSVI7hGkcBk/ETKl1PA
	FXllzZxVE2sn4chIg6m1aF9XFgz7kz6EjBfzTe7RT7ltvvU+1JsI+ge0liGc1PbopPO+dansX6xAj
	kgFz7Dkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpqHm-00000008SZA-2joe;
	Wed, 05 Mar 2025 15:03:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpp0D-00000008Dav-0woN
	for linux-nvme@lists.infradead.org;
	Wed, 05 Mar 2025 13:41:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0283668AFE; Wed,  5 Mar 2025 14:32:18 +0100 (CET)
Date: Wed, 5 Mar 2025 14:32:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
	anuj1072538@gmail.com, nikh1092@linux.ibm.com,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, dm-devel@lists.linux.dev
Subject: Re: [PATCH v3 1/2] block: ensure correct integrity capability
 propagation in stacked devices
Message-ID: <20250305133217.GA16755@lst.de>
References: <20250305063033.1813-1-anuj20.g@samsung.com> <CGME20250305063902epcas5p25cc1df91006f1bb35ea782ec430b6d4b@epcas5p2.samsung.com> <20250305063033.1813-2-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305063033.1813-2-anuj20.g@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250305_054137_402994_57260E6B 
X-CRM114-Status: UNSURE (   8.91  )
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


