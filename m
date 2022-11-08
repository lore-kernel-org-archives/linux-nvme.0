Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E322C4332F
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Nov 2022 06:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=04cDxFqhitHLpToNM/Ds7Kxi73as3g6uKjQ7kPNIssE=; b=Zux1DiyN27fAZLPly46mkc9Thm
	ZRzY9EOu2fBRW+hrWyrB4z8samPeYxCBpyRJSFUvPiPGkLkYbTOxMUUWxYAXIP9GgxPRFkejsfAh2
	WkJ10SYp4JWxntD08NdyY+O4CrYg3ZnJccNZHmfPI7NKKryIC8rUl1vMte7epI6iOTeDxGJY/Fm2x
	iY/F3spjJacMBgfK2F2HTg0dEAoZ7QjKLzuCtEKECs5UTk9QffCik9lYqz0RLymoK16i6YlAoebik
	9HR2GoxN8S823ENJbMriv1KCRKKBRu3tNUPxeQzMhqvPyQGBL0Gzn12f0gV++3r8JDIU21hoEDWmH
	W5blK6/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osIX9-003J3Y-KG; Tue, 08 Nov 2022 06:56:31 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osIX2-003J2J-FG
	for linux-nvme@lists.infradead.org; Tue, 08 Nov 2022 06:56:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3134267373; Tue,  8 Nov 2022 07:56:19 +0100 (CET)
Date: Tue, 8 Nov 2022 07:56:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>, Logan Gunthorpe <logang@deltatee.com>,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Don Dutile <ddutile@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Minturn Dave B <dave.b.minturn@intel.com>,
	Jason Ekstrand <jason@jlekstrand.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Xiong Jianxin <jianxin.xiong@intel.com>,
	Bjorn Helgaas <helgaas@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Martin Oliveira <martin.oliveira@eideticom.com>,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	Ralph Campbell <rcampbell@nvidia.com>,
	Stephen Bates <sbates@raithlin.com>, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v11 0/9] Userspace P2PDMA with O_DIRECT NVMe devices
Message-ID: <20221108065618.GA20283@lst.de>
References: <20221021174116.7200-1-logang@deltatee.com> <20221024150320.GA26731@lst.de> <743ad0e5-6936-9287-d093-2ce1c2a3e32d@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <743ad0e5-6936-9287-d093-2ce1c2a3e32d@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221107_225624_674405_E83FC263 
X-CRM114-Status: GOOD (  12.33  )
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

On Mon, Oct 24, 2022 at 12:15:56PM -0700, John Hubbard wrote:
> A little earlier, Jens graciously offered [1] to provide a topic branch,
> such as:
>
>     for-6.2/block-gup [2]
>
> (I've moved the name forward from 6.1 to 6.2, because that discussion
> was 7 weeks ago.)

So what are we going to do with this series?  It would be sad to miss
the merge window again.

