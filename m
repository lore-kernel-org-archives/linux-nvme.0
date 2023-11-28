Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96599C07CA9
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Nov 2023 12:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BSUSv8XcwqzwuDPREXtILUdUH5dufXGhbdk536S9dds=; b=A4aeRM3IXsjmVGV5fX30Fn+Gyn
	iyogbPZ+6KL0CowWeU8lq7SDMoWoJlb/TtdKxROLKTm1r5skW765rnayHJ3bjf/h9yQ1pZXIVq3H/
	bbt02gbNqtqkGrDeupyDmfoERzSdHlk8VWfHDnSqOCfGmSgp8LGptfa+L57Opj/+54eNY+lhnq+R4
	tuwkM3k2i9+Jjg5OOtGDgrNIQRkYtTR4kiv6r9jKe2alA+zyXfZG1H9i7n86ueAm34iz3za95EODs
	goQaNiSUAigDv6sx2NfQCfeZGSkHOr1Ph4WDGnRhaxA4kxKcy/d/DxWvcQ+d40YQDoPCgW2O4ukLL
	gNMGUjpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7xec-005Kmn-0q;
	Tue, 28 Nov 2023 12:57:30 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7xeZ-005Km4-1w
	for linux-nvme@lists.infradead.org;
	Tue, 28 Nov 2023 12:57:28 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 50D0D227A87; Tue, 28 Nov 2023 13:57:19 +0100 (CET)
Date: Tue, 28 Nov 2023 13:57:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Jim.Lin" <jim.chihjung.lin@gmail.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	jim.lin@siliconmotion.com, cj.chen@siliconmotion.com,
	david.yeh@siliconmotion.com, hardaway.tseng@sk.com
Subject: Re: [PATCH] nvme-pci: disable write zeroes for SK Hynix BC901
Message-ID: <20231128125718.GB7613@lst.de>
References: <20231128025737.53026-1-jim.lin@siliconmotion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128025737.53026-1-jim.lin@siliconmotion.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231128_045727_784309_39BF73E8 
X-CRM114-Status: GOOD (  11.71  )
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

On Tue, Nov 28, 2023 at 10:57:37AM +0800, Jim.Lin wrote:
> SK Hynix BC901 drive write zero will cause Chromebook takes more than 20 mins to switch to developer mode
> "disable write zeroes" can fix this issue and Sk Hynix has been verified.

Did you test this on an upstream kernel with

ommit 1b96f862ecccb3e6f950eba584bebf22955cecc5
Author: Christoph Hellwig <hch@lst.de>
Date:   Sun Oct 30 16:50:15 2022 +0100

    nvme: implement the DEAC bit for the Write Zeroes command

included?  Or in ther words, does this drive not implement DEAC
or does it not work properly?  What are the chances of actually
fixing the fimware to work properly?  Also WZSL limit does the
drive report?

