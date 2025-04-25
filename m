Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16095C369D7
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Apr 2025 16:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=fQSvTORcBVuHtnn0ncTdN9EivT
	viJeBftbAlj4Bl5Vy0be4pSTUl7cRbuYonrSN7b/zO1P1a0bX8Gqs7Pza7weARCSlxoKvAuA8lS7T
	6AUEoR8j+sddJaitmAF5ohuy12ziw5m52POVHVTJ4TDnuaZsIR7MswJn2Tqn0tTODvgm0Zw/gWiHu
	yOCf6oe4rL2QtA0V9mr14yF2pGSX41BzMj0JNemnz3qU9onZ09fkFSyTZKblr1A8yDio4Xw2I9IKM
	RMnbrOJOinHOR3+kZ9IYrTTo4sEdrKYBxVoFrTaMuTNn0qQZlb1efN5mgE1A6qIPsfnrAypD6axaB
	RJ+zOsJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8Lsu-00000000CxG-2eyf;
	Fri, 25 Apr 2025 16:26:40 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8KJg-0000000HTw0-0Pws
	for linux-nvme@lists.infradead.org;
	Fri, 25 Apr 2025 14:46:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3907168C4E; Fri, 25 Apr 2025 16:46:05 +0200 (CEST)
Date: Fri, 25 Apr 2025 16:46:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, hch@lst.de,
	kbusch@kernel.org, hare@suse.de, sagi@grimberg.me,
	jmeneghi@redhat.com, axboe@kernel.dk, martin.petersen@oracle.com,
	gjoyce@ibm.com
Subject: Re: [RFC PATCHv2 3/3] nvme: rename nvme_mpath_shutdown_disk to
 nvme_mpath_remove_disk
Message-ID: <20250425144604.GC12179@lst.de>
References: <20250425103319.1185884-1-nilay@linux.ibm.com> <20250425103319.1185884-4-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425103319.1185884-4-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_074612_270788_CB144436 
X-CRM114-Status: UNSURE (   8.42  )
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


