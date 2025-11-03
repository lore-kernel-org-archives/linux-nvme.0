Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F691CCF9FE
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 11:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=fkR9xcK0Qq7tpLpg6axNdrChug
	53RYd8aZV570wTO/zL6GbmMBLqOz29MHQfXFiPWnAfRirMA4vT3H9A4Hy6g7nXnosRa/T3ukxzNC+
	/uXGgt/lT0UrfR35Q/gVtkvB/lXAEFe6D7q2j6tHqOag5ajEXBUYLyhuhw7mP/C0tyjTYV/RyQxPG
	20HK2gwmX5Rhst+CflUSYr4JLhebhOL++5nEOv8orhiEAH2AyuqYMvPA0Ke0jf3e0p3Z6d4qq3Usu
	KVr1NdQx5ulLK/vqn0ovZ/3pvqZf6kV3+/MBD/ZTs25pvVOlOOL2T4ye66CovU4mABlf5mnIj+XTd
	F1CiYFPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFt1O-00000009ldi-09xT;
	Mon, 03 Nov 2025 11:46:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFt1L-00000009lcC-49sA
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 11:46:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3070C227A87; Mon,  3 Nov 2025 12:46:44 +0100 (CET)
Date: Mon, 3 Nov 2025 12:46:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de,
	linux-nvme@lists.infradead.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] nvme-keyring: mark nvme_dhchap_psk_hash() as static
 inline
Message-ID: <20251103114643.GC15280@lst.de>
References: <20251102031701.69920-1-ckulkarnilinux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251102031701.69920-1-ckulkarnilinux@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251103_034648_168796_48B6E71B 
X-CRM114-Status: UNSURE (   9.08  )
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


