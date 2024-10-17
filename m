Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF57D2F7FE
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2024 08:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4TldNJ9VBiUvGheIZBqqzqF/PH1EwQ8ZC2qgP+oYNf0=; b=vPCHa/WeGikfYhKxA+jxRVeZTt
	2LDS0jcEKLwB0YCbN7izd6GNFspTfIqvwqzCkkoA0y+zPa/V8Tya3iYyvu2Tz6UvVybGYpyuZQiIH
	csWbdQycbkshVyzb/dS27k7jUiSO00CynhKpuC3xd1Yfd6Hc+QZDH0ytFiTIl8CoO7gILvTeQCIq+
	saLrwRsjYrpoPHiYqVaaRMHg2D5PAR17oBdY5behU0OLWb3wbpx8Rz2KYuj6041g7YNnzwjGFWjOg
	HzsnUl9i9Rk9vLCcov6thT/L3OGrcCI1teoEGGoJZaFoWwbP9b6XziIWod+cylF5qv9tBwsnMDTdw
	7qZ4+nsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1Lfk-0000000E887-0PdI;
	Thu, 17 Oct 2024 08:15:52 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1LcQ-0000000E79x-1mCr
	for linux-nvme@lists.infradead.org;
	Thu, 17 Oct 2024 08:12:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E042D227A87; Thu, 17 Oct 2024 10:12:23 +0200 (CEST)
Date: Thu, 17 Oct 2024 10:12:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com,
	anuj1072538@gmail.com, krisman@suse.de, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org,
	vishak.g@samsung.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v4 08/11] block: introduce
 BIP_CHECK_GUARD/REFTAG/APPTAG bip_flags
Message-ID: <20241017081223.GB27241@lst.de>
References: <20241016112912.63542-1-anuj20.g@samsung.com> <CGME20241016113750epcas5p2089e395ca764de023be64519da9b0982@epcas5p2.samsung.com> <20241016112912.63542-9-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016112912.63542-9-anuj20.g@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_011226_627623_0443A4FC 
X-CRM114-Status: GOOD (  11.52  )
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

On Wed, Oct 16, 2024 at 04:59:09PM +0530, Anuj Gupta wrote:
> This patch introduces BIP_CHECK_GUARD/REFTAG/APPTAG bip_flags which
> indicate how the hardware should check the integrity payload. The
> driver can now just rely on block layer flags, and doesn't need to
> know the integrity source. Submitter of PI decides which tags to check.
> This would also give us a unified interface for user and kernel
> generated integrity.

The conversion of the existing logic looks good, but the BIP_CHECK_APPTAG
flag is completely unreferenced.


