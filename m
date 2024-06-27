Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 403E2C2BD09
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jun 2024 06:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=21mm+9MfkyKm6E81p7Okj3TCzK
	kefZGsX/nG+16yfpQjf7iRCBIa0Lo1DaMkooScCJ9sNu9A5ivEEcJ1f4UEQHg3NsUjNkdBbSjndkw
	Pwi4zIQfZnsav6t/ug6HqYyFeL4cn2zxVfs4/jvYCi19UPirwJO5dERYhFCVCn8MHszsCWGY9zFRV
	hCGERLeGl8yuR7eXFmY82QV3qHsfPGNBIpCTi8l94xLb7F4KO+A8255CmrmS21wPRDp/VFfNz/iaM
	5Djo+WaMhPUBbxITUIaGAiCXckHvoL3P148fz1d7LQJhzGBJX4aMl/vRrpIHVHII32R7Pn3aU0dHq
	h4NnZOOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMiXd-00000009NNU-3ReI;
	Thu, 27 Jun 2024 06:23:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMiXZ-00000009NKc-1geS
	for linux-nvme@lists.infradead.org;
	Thu, 27 Jun 2024 06:23:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id F2A4968AFE; Thu, 27 Jun 2024 08:23:25 +0200 (CEST)
Date: Thu, 27 Jun 2024 08:23:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: asml.silence@gmail.com, mpatocka@redhat.com, axboe@kernel.dk,
	hch@lst.de, kbusch@kernel.org, martin.petersen@oracle.com,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v2 06/10] block: modify bio_integrity_map_user to
 accept iov_iter as argument
Message-ID: <20240627062325.GE16047@lst.de>
References: <20240626100700.3629-1-anuj20.g@samsung.com> <CGME20240626101521epcas5p42b0c1c0e123996b199e058bae9a69123@epcas5p4.samsung.com> <20240626100700.3629-7-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626100700.3629-7-anuj20.g@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_232329_607981_B5B1A5E9 
X-CRM114-Status: UNSURE (   8.29  )
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


