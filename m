Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73CBAC282CD
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Mar 2025 14:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zFupihqvB7oNp8g/rAyPr7yoBVeRq6pH1yACFzLs8b4=; b=P3xdXFhxMCl+5TU0A9davWJiXp
	ovxFkm0QVRNPghznPIPUG39j/ztMuODprPb7AufE0UeuQvG7O9cTW/2ztqWqGxbZNMxt57AkRVy4P
	WPak9Xa8CSbIH1jutqyQgPzFYgWXtJjYreTHIXY9drbFKBfAKSKm2lPdHLvJez2XZ8FPmX+ZkUIRz
	GGiOk6J8bx/xureqz2QbFUj+CSZrg9D3RZrM42Nr2p7J2qSeoTN3i5slE2ma6WGuoPX9n8msKWR5I
	7b0zalYYWJKOuvdPoliZ0HkDZ5SWLPzpHxUfKK9cLD2uKvmGt8BlArDhfa7qxgd6hvVi90VxHoAAu
	Q9f7+Ntg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tp6lk-000000016RH-44eN;
	Mon, 03 Mar 2025 14:27:44 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tp6W8-000000012Op-17Ac
	for linux-nvme@lists.infradead.org;
	Mon, 03 Mar 2025 14:11:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6106768CFE; Mon,  3 Mar 2025 15:11:26 +0100 (CET)
Date: Mon, 3 Mar 2025 15:11:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, anuj1072538@gmail.com,
	nikh1092@linux.ibm.com, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	dm-devel@lists.linux.dev, M Nikhil <nikhilm@linux.ibm.com>
Subject: Re: [PATCH v2 2/2] block: Correctly initialize
 BLK_INTEGRITY_NOGENERATE and BLK_INTEGRITY_NOVERIFY
Message-ID: <20250303141126.GA16268@lst.de>
References: <20250226112035.2571-1-anuj20.g@samsung.com> <CGME20250226112859epcas5p2b97647182f58b4c6514326cf497e3fdb@epcas5p2.samsung.com> <20250226112035.2571-3-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226112035.2571-3-anuj20.g@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250303_061136_443760_846CB0B9 
X-CRM114-Status: GOOD (  12.40  )
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

On Wed, Feb 26, 2025 at 04:50:35PM +0530, Anuj Gupta wrote:
> Currently, BLK_INTEGRITY_NOGENERATE and BLK_INTEGRITY_NOVERIFY are not
> explicitly set during integrity initialization. This can lead to incorrect
> reporting of read_verify and write_generate sysfs values, particularly when
> a device does not support integrity. This patch ensures that these flags
> are correctly initialized by default.

You don't need to stay "this patch" in a commit log, just state what
it is doing.  Also please wrap commit log lines at 73 characters.

The code changes themselves here look good.


