Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0683ED12D7B
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2024 06:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MyRJo0c+NyaPDL4c3n7Q2mszqzDaJv+7DP3yQK5Ty4k=; b=M687jpISDfyJSuqjkmZA942tMq
	CY68sHiH9UlJauzu7N7b91AqQNHPQwUXL0tgzLT6OKX9qq4NtWLjHNcQcYBICLkKL9+pu/wnn2cIG
	0IJGd4AVz2MKxyNhmfZDAImLGtUuQZHEAJnkmVcsum6L696Y1gFw+R9l3xeapu5er1Tpx5tyjYTDq
	gALYZkLgNKVgB1jIGcyvrXpIWJlBksqXjfokpT0RDlKmlMw7r4PqDOy82B7CdSMTOOluKBSsz9xHT
	xAIY4nlGcrx8J82EwQr85jdQBFfaFsqvWxJKnI+PLHbbbVDL0Fgkv6Ll1GtTrbEKg7UGeBx9zjzff
	FLUYr8tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAOFE-0000000GWrn-3B4x;
	Mon, 11 Nov 2024 06:49:52 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAOFC-0000000GWqr-0qN1
	for linux-nvme@lists.infradead.org;
	Mon, 11 Nov 2024 06:49:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 94AC968C7B; Mon, 11 Nov 2024 07:49:46 +0100 (CET)
Date: Mon, 11 Nov 2024 07:49:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com, javier.gonz@samsung.com, bvanassche@acm.org
Subject: Re: [PATCHv10 0/9] write hints with nvme fdp, scsi streams
Message-ID: <20241111064945.GB24107@lst.de>
References: <20241029151922.459139-1-kbusch@meta.com> <20241105155014.GA7310@lst.de> <Zy0k06wK0ymPm4BV@kbusch-mbp> <20241108141852.GA6578@lst.de> <Zy4zgwYKB1f6McTH@kbusch-mbp> <Zy5CSgNJtgUgBH3H@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zy5CSgNJtgUgBH3H@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241110_224950_402254_7D43E23D 
X-CRM114-Status: GOOD (  12.54  )
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

On Fri, Nov 08, 2024 at 04:54:34PM +0000, Matthew Wilcox wrote:
> I like the idea of using copy-offload though.

FYI, the XFS GC code is written so that copy offload can be easily
plugged into it.  We'll have to see how beneficial it actually is,
but at least it should give us a good test platform.


