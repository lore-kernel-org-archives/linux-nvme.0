Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B431C433FE
	for <linux-nvme@archiver.kernel.org>; Thu,  5 May 2022 13:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gvLc0y/ug8Memj0czFkqlDVuvWddD/1bAJ569krEl6E=; b=zUvSopSdGlRhbH3GqViQEHq0/R
	MhcjySm8pw7BlIvkqQBJgW33dNNlXIbRWYnWMTkc+cz53qdXVJT6UmiBIdUdWuYiPyGTa1jlPK0s1
	bSrucKzLgxggm5J+8L1NHRW+XYH4Ck9U4ploWuh3nW3LeAnJQuMRuota/+dSn6j3uls9k94DetRWo
	fXdsTGKEQTBBVpXPifcIYGo3gES7oA+lpCEY8kKiUul6e8iWJvaO20Ly6afCTSvQMuJG0Bi4NVMWP
	3UMR0Swnq35tttajl3vNEGwM9b2HPovrCfbzf5T3+RcMk+b3oN5ohxzVWrOvuPNFDl/cuxu2MIh0t
	7PtHxAQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmbYv-00G2XT-HM; Thu, 05 May 2022 13:30:33 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmbYs-00G2WG-91
 for linux-nvme@lists.infradead.org; Thu, 05 May 2022 13:30:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6BE0568AA6; Thu,  5 May 2022 15:30:27 +0200 (CEST)
Date: Thu, 5 May 2022 15:30:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, asml.silence@gmail.com,
 ming.lei@redhat.com, mcgrof@kernel.org, shr@fb.com,
 joshiiitr@gmail.com, anuj20.g@samsung.com, gost.dev@samsung.com
Subject: Re: [PATCH v4 3/5] nvme: refactor nvme_submit_user_cmd()
Message-ID: <20220505133026.GB11853@lst.de>
References: <20220505060616.803816-1-joshi.k@samsung.com>
 <CGME20220505061148epcas5p188618b5b15a95cbe48c8c1559a18c994@epcas5p1.samsung.com>
 <20220505060616.803816-4-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505060616.803816-4-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220505_063030_497697_AF2E2924 
X-CRM114-Status: GOOD (  10.01  )
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

On Thu, May 05, 2022 at 11:36:14AM +0530, Kanchan Joshi wrote:
> +{
> +	struct bio_integrity_payload *bip = bio_integrity(bio);
> +
> +	return bip ? bvec_virt(bip->bip_vec) : NULL;
> +}

Nit, I'd prefer this as the slightly more verbose:

	if (!bip)
		return NULL;
	return bvec_virt(bip->bip_vec);

