Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8FC4C5321E
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Aug 2024 15:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bpNBmtpwOk2K/dWtrGRMI3zxgc9pj067P9LjpoB3rqU=; b=DoIPeMS9uaG6EWdJ3hCXwM9pNf
	J2ltuGxJiYK3sVPv71seQSvfNt234v28m3djQjadhsoiAEHmBO4pFeGBArwUOyzQODCu0+9bfJAci
	HEaS5ZFd8kF43U1DHZ9tu1Ppgw2G1Hv5fD+KLzRCZ4Zl2/DGVQ312tldn/t6I0+9cfHiT2O19nkNk
	2BLpXt/XhgGUUx6dXCcfxssRL5aN0DRtlAQyKwVAiskWS0o0DtghSOETtHV2tJ5Eh1otmBmr0pi3b
	X2JKuV5cl7wZmTY/B618EH9J701k33AwmERxQYvCaFnllDLDhJiAzeq6ioOywOkAolZ7p3PxhyC5m
	i3xQhIcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sibRc-00000007mLw-0wy1;
	Mon, 26 Aug 2024 15:15:48 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sibRY-00000007mLD-300q
	for linux-nvme@lists.infradead.org;
	Mon, 26 Aug 2024 15:15:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id C6EA3A43142;
	Mon, 26 Aug 2024 15:15:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C778C56892;
	Mon, 26 Aug 2024 15:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724685341;
	bh=UR5sJwYm+EIzcsn12mEd9GyDnyh+KBeEJEemIA6Yb3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nnVoHTX3cVnZk5p3n3Wf26zT80KN8PWXguUI4vykTbvz+NlMAHf0D7Fl7j5/RIsOZ
	 HKVxxgEgWedq9bJSY373Dz6JQhTIdTpUjh4WKxlt9XYQRFAext95nEPhAK4KPi60Hx
	 mIhijZYapQapUABLIm1gCxyDfsYUOAavHM+UFLQWhEk9qHuRH+0v56Uest4w/8oExS
	 ojY/bMM1Ge6H2amZabuaSWjvKp2TuyKlYBevVzKrPScaRos9hrcybj+7Oc3N+r1ZK4
	 ULV8aYCFfUtPi0Z3hnbVG5cwYTaPRjpakrJF2BepLn8JdRUfnazAsdCaxz6Znmgx78
	 lVSgBu7QJDHJw==
Date: Mon, 26 Aug 2024 09:15:39 -0600
From: Keith Busch <kbusch@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, kamaljit.singh1@wdc.com,
	dlemoal@kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-rdma: send cntlid in the RDMA_CM_REQUEST Private
 Data
Message-ID: <ZsycG2iJ8WL6K2ky@kbusch-mbp.dhcp.thefacebook.com>
References: <20240815201131.1439811-2-cassel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815201131.1439811-2-cassel@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240826_081544_845424_EFDC017D 
X-CRM114-Status: GOOD (  14.89  )
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

On Thu, Aug 15, 2024 at 10:11:31PM +0200, Niklas Cassel wrote:
> When sending a RDMA_CM_REQUEST, the NVMe RDMA Transport Specification
> allows you to populate the cntlid field in the RDMA_CM_REQUEST Private
> Data.
> 
> The cntlid is returned by the target on completion of the first
> RDMA_CM_REQUEST command (which creates the admin queue).
> 
> The cntlid field can then be populated by the host when the I/O queues
> are created (using additional RDMA_CM_REQUEST commands), such that the
> target can perform extra validation for additional RDMA_CM_REQUEST
> commands.
> 
> This additional error code and error message is also added, such that
> nvme_rdma_cm_msg() will display the proper error message if the target
> fails the RDMA_CM_REQUEST command because of this extra validation.

Thanks, applied to nvme-6.12.

