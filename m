Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9618FD12D79
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2024 06:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iUY/MMCCbdH9XEGJOdodJQR64pitTLzcJSMFJGy5RGg=; b=j8J69Et8kuhbX87iz5eX0si2/E
	+6Cw1WUiqE5AT9rwvmZ/pPEuIMPm2bi12EOZf1TyYF3sVn+GtQ6nNx1eZoXJp7QSsVqvY7eeBF6Ag
	U5W/SmoGFgAdPtaexDzh/8pBew/cKCSBHMYKRbm85TS3Mpu1SI4FhINlCl79GhyanIx2+Z/4kw5Ch
	ZH0jRim/BWAcC8BSuYRemwITRQylgfDib5xHTvA9D5vTzFDwRg38kuLxium53EQRt4agHFSGHINxj
	s4+gYF5HZnX1Rt4IHHfxhP09LU8jP8XV6kLb8v3sISzvwF2sS9jQIXR12Y8/5fZZgWE22YK+yEmuS
	aqPY2MFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAOHE-0000000GX8D-3Gq1;
	Mon, 11 Nov 2024 06:51:56 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAOHB-0000000GX7X-2fnF
	for linux-nvme@lists.infradead.org;
	Mon, 11 Nov 2024 06:51:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EBD4668C7B; Mon, 11 Nov 2024 07:51:48 +0100 (CET)
Date: Mon, 11 Nov 2024 07:51:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Javier Gonzalez <javier.gonz@samsung.com>
Cc: Matthew Wilcox <willy@infradead.org>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"joshi.k@samsung.com" <joshi.k@samsung.com>,
	"bvanassche@acm.org" <bvanassche@acm.org>
Subject: Re: [PATCHv10 0/9] write hints with nvme fdp, scsi streams
Message-ID: <20241111065148.GC24107@lst.de>
References: <20241029151922.459139-1-kbusch@meta.com> <20241105155014.GA7310@lst.de> <Zy0k06wK0ymPm4BV@kbusch-mbp> <20241108141852.GA6578@lst.de> <Zy4zgwYKB1f6McTH@kbusch-mbp> <CGME20241108165444eucas1p183f631e2710142fbbc7dee9300baf77a@eucas1p1.samsung.com> <Zy5CSgNJtgUgBH3H@casper.infradead.org> <d7b7a759dd9a45a7845e95e693ec29d7@CAMSVWEXC02.scsc.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7b7a759dd9a45a7845e95e693ec29d7@CAMSVWEXC02.scsc.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241110_225153_841838_31B9469C 
X-CRM114-Status: GOOD (  14.24  )
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

On Fri, Nov 08, 2024 at 05:43:44PM +0000, Javier Gonzalez wrote:
> We have been iterating in the patches for years, but it is unfortunately
> one of these series that go in circles forever. I don't think it is due
> to any specific problem, but mostly due to unaligned requests form
> different folks reviewing. Last time I talked to Damien he asked me to 
> send the patches again; we have not followed through due to bandwidth.

A big problem is that it actually lacks a killer use case.  If you'd
actually manage to plug it into an in-kernel user and show a real
speedup people might actually be interested in it and help optimizing
for it.


