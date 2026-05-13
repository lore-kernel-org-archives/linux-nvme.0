Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686FBCD37B6
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2026 08:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0Biy+89y0c7CCMYpDz64+cmVWqgaKENqrU8M4qgHLGQ=; b=CeaKb0upJj13WMSNOdiNzLZ0+7
	3X4phdaskE2dBOns6iJi/OCHoaI1zkLgJ0d+fC36rxc3UyF/sD2ki7ftWuVVm7jAZpVPRj37XbmWf
	bbQ/iOCArd8S0nf5C0Qi1gcp+ZHFKca5ihT8OsnsJcp2nzurD1degGzco/8XBvZrbMfodoK750vPF
	dxrBzEX5EoRD/BNllwU45dcIAeSVTpvhEV07F+0i3E2BiWTUKBud9UDl3cz7shfx+0emd5/yqBUxK
	29BcULqs9qnvnvm4HgtoKqrhS3o0igJP+BI1gIt1GuBPhU9StZhscLERxTHWAk18SAYz7aBvIi1EO
	ynbZBISQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wN4gl-00000001h6q-2Tfl;
	Wed, 13 May 2026 08:11:31 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wN4gg-00000001h5E-1dRV
	for linux-nvme@lists.infradead.org;
	Wed, 13 May 2026 08:11:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1BB8D68BEB; Wed, 13 May 2026 10:11:16 +0200 (CEST)
Date: Wed, 13 May 2026 10:11:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 01/10] file: add callback for creating long-term
 dmabuf maps
Message-ID: <20260513081115.GA5477@lst.de>
References: <cover.1777475843.git.asml.silence@gmail.com> <ae941457cf6cacb9d4c16b6ec904da9ef7fed97f.1777475843.git.asml.silence@gmail.com> <f0dd8f89-835e-4331-b593-4405ec59f4fe@amd.com> <6cce2f4d-7400-4618-82ce-cbd5004c92a4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cce2f4d-7400-4618-82ce-cbd5004c92a4@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260513_011126_577064_8E5CA865 
X-CRM114-Status: GOOD (  14.95  )
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

On Thu, Apr 30, 2026 at 07:33:39PM +0100, Pavel Begunkov wrote:
>> Then the patch should probably define the full interface and not just add the callback here and then the structure in a follow up patch.
>
> I strongly prefer splitting patches so that they touch one tree at
> a time whenever possible. tbh, I don't see much of a problem it being
> not defined as it's just forwarded in first patches, but I can shuffle
> it around in the series so that definitions come first.

file operations without users are pointless.  This really should go
with "lib: add dmabuf token infrastructure" as it is the only way for
the reviewer to make any sense of it.  I'll move my discussion of the
interface there for that reason.


