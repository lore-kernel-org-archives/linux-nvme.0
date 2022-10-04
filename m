Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B102C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Oct 2022 07:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LEqoUjYUwWKdvQ/XhKBLaWo/dztRIKfyV8Szib/Sqy8=; b=s7RvQJdDzVeab7CnxiGMfnBZ5W
	pAqR6uxgmkmTceUCcrOB+I7ZpiM8UDXqGPWg70267Y3QdBFvKe9k95VAblTnNj93kRoiIR5slN6Lp
	MmF68rtWbuS8dkDLQADDUfQhxFhzUip3XmyvApW3H8eEm1IHUPGwEpqhPX5RnXy6v3Q6Lf7EGNSH4
	cPpzOvsunar5db21lbeHovk305F+6kta99yzYXzyQOIcbNWyg+Ci9pWAMmE9+c5NifqS4WnIMExDO
	0bvmhJxLH4lzuHepppqkuzoHkRpiL6xPX2iGC0VCuPtMZcl/At4sLd5zW3XVDI5V192wU0QIjkTVw
	Vx8bf/Hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofcLr-008khm-N0; Tue, 04 Oct 2022 07:28:27 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofcLp-008kgF-Hc
	for linux-nvme@lists.infradead.org; Tue, 04 Oct 2022 07:28:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 10A3768B05; Tue,  4 Oct 2022 09:28:17 +0200 (CEST)
Date: Tue, 4 Oct 2022 09:28:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Rita Lin <ritach_lin@phison.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?77+9U+aZn++/vXw=?= <redd_huang@phison.com>,
	Tina Hsu <tina_hsu@phison.com>,
	Vita Hsueh =?utf-8?B?KOiWm+S8iuWAqSk=?= <Vita.Hsueh@quantatw.com>,
	"Wang, Audrey" <audrey.wang@hp.com>
Subject: Re: nvme-pci: disable write zeros support on SSDs
Message-ID: <20221004072816.GA30470@lst.de>
References: <20220922055231.GA27560@lst.de> <1c9807fea3424be486190a99c923a228@ExMBX2.phison.com> <20220922142626.GB28397@lst.de> <97217d166814421d9de587e84c328580@ExMBX2.phison.com> <20220923061130.GA15835@lst.de> <2b685d5ccb6e492b938c1c10ce378430@ExMBX2.phison.com> <20220927070822.GA15262@lst.de> <3aeb692e9037462b9f9a23a60277b80c@ExMBX2.phison.com> <20220927072141.GA16372@lst.de> <1a5c4e8559d0495eb78479cd18fcbe95@ExMBX2.phison.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a5c4e8559d0495eb78479cd18fcbe95@ExMBX2.phison.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221004_002825_767712_70B7B684 
X-CRM114-Status: GOOD (  11.79  )
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

On Tue, Oct 04, 2022 at 07:20:01AM +0000, Rita Lin wrote:
> Hi Christoph
> 
> Would you please share the patch modified link on Gerrit Server to us?

I have no idea WTF you're even talking about.

