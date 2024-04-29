Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91482C4345F
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Apr 2024 17:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LkAjrdKGyLtBERAH5qRJOiuxc4YbxxrTszaEEa1ikN0=; b=hcsj7930tcbWR9RQw1S35j+xUX
	mZEEzBNc/IqaGKM7ZGRpOHvJLpvWmulhGhEPFrfwiKkb+GMhva9VwhIef8f9A48G0ATKMuKQTysTR
	o2JGr66CWd5WXsMERkvAuajJivVs3UyQAKxu+7SeePC6zxv4Ij4xTafG954n+AwuxNP7VcTHvUAwh
	r1sePFhef12dS5LWx8SJbIq2CrZ2MY3rmBWhoQQ4e+qyQ1lLnhrly3pBnO7S4fSuna30NI+rNjnDa
	ViwHGUrGuXX9WOrUBYhsi0P242QV6YEEKg4WyLDXNAiMvnCAGP6XoUeG+5Fl7Uc1lQI9GEhSKhkTA
	o/0Wnzgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1UX9-00000003gl6-0JSu;
	Mon, 29 Apr 2024 17:11:19 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1UX6-00000003gkC-1oby
	for linux-nvme@lists.infradead.org;
	Mon, 29 Apr 2024 17:11:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 97297227A87; Mon, 29 Apr 2024 19:11:13 +0200 (CEST)
Date: Mon, 29 Apr 2024 19:11:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
	martin.petersen@oracle.com, kbusch@kernel.org, brauner@kernel.org,
	asml.silence@gmail.com, dw@davidwei.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH 05/10] block, nvme: modify rq_integrity_vec function
Message-ID: <20240429171113.GC31337@lst.de>
References: <20240425183943.6319-1-joshi.k@samsung.com> <CGME20240425184700epcas5p1687590f7e4a3f3c3620ac27af514f0ca@epcas5p1.samsung.com> <20240425183943.6319-6-joshi.k@samsung.com> <20240427071834.GE3873@lst.de> <56f3d65b-5dda-f5fc-68c2-ab9cf368f066@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56f3d65b-5dda-f5fc-68c2-ab9cf368f066@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240429_101116_653252_C021DED2 
X-CRM114-Status: GOOD (  12.28  )
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

On Mon, Apr 29, 2024 at 05:04:30PM +0530, Kanchan Joshi wrote:
> >> +	return (struct bio_vec){0};
> > 
> > No need for the 0 here.
>   Um, I did not follow. Need that to keep the compiler happy.
> Do you suggest to change the prototype.

Just removing the NULL as in:

	return (struct bio_vec){ };

compiles just fine here, and at least for non-anonymous struct
initializers we use it all the time.

