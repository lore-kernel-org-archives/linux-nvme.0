Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C79C4345F
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Apr 2024 07:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f+/vNikpkNGB+U0L/JI//0s1Nr170NH6+TtAwq78zVI=; b=xl1qVo5Otq8di304CUp14oe5zG
	dI9EhdxycGlvew0ytDFV/8FHaSyQKny3TeEVoR753FrQcBBAGnrMe4MN3mVMmaXwgMdnSV4SikAp/
	SGWfHSRnt/j+w23uxm5Ua6rcs7B7qyEV7VcVESJMRCR4tWSwkzG9n/o7KDGvuav3/BqZRcneiDLNE
	KfeOyY5Asra2KdCFX4XZ6vmaw72XxqElUMGomlrRIBUfaobNx/pjrj3L+UBwQtly6OWzYk+SK2fNX
	qp5Ea5e1EiWDxQGfiHrN5MXCtBPdZsN828QsnbkeBQiSwczHmnqei+of1YtkwTz/PEaUwzathMM/O
	fEVztMDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0c50-0000000F0h3-1tw4;
	Sat, 27 Apr 2024 07:02:38 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0c4q-0000000F0gG-2SVT
	for linux-nvme@lists.infradead.org;
	Sat, 27 Apr 2024 07:02:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 63E76227AA8; Sat, 27 Apr 2024 09:02:14 +0200 (CEST)
Date: Sat, 27 Apr 2024 09:02:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, kbusch@kernel.org,
	hch@lst.de, brauner@kernel.org, asml.silence@gmail.com,
	dw@davidwei.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH 01/10] block: set bip_vcnt correctly
Message-ID: <20240427070214.GA3873@lst.de>
References: <20240425183943.6319-1-joshi.k@samsung.com> <CGME20240425184651epcas5p3404f2390d6cf05148eb96e1af093e7bc@epcas5p3.samsung.com> <20240425183943.6319-2-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425183943.6319-2-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240427_000228_790998_B4B7077B 
X-CRM114-Status: GOOD (  11.35  )
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

On Fri, Apr 26, 2024 at 12:09:34AM +0530, Kanchan Joshi wrote:
> From: Anuj Gupta <anuj20.g@samsung.com>
> 
> Set the bip_vcnt correctly in bio_integrity_init_user and
> bio_integrity_copy_user. If the bio gets split at a later point,
> this value is required to set the right bip_vcnt in the cloned bio.
> 
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Please add a Fixes tag and submit it separately from the features.

I'm actually kinda surprised the direct user mapping of integrity data
survived so far without this.


