Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62F33C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Feb 2022 16:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3G5lw+PV7G0Wje19hfP/64hKJJPJFsiy1tAZm/+V/LU=; b=GokUkpyUKxHD0go1Uj6AJw+WlF
	BrGVTU3eTfBNKvZUr5c18KvApYxQGHKD1fp+SOg6+s4IM/LoY9kn2Y4vP5f4r9JXkFkvqohgbAWWo
	23639jfR7CDQISjmcVjONqwkVhJoRVesu+Pzy5VyQfyOqqVXJJRvY0r2/MIVWa+NFi5fTkuiw2VPH
	80W+UeglK+PadbWEEqlgPnhyhuDKdULuD4hwy8OxeDfV6Ovos/gHMt48HH1kLQ0pMSjSQY/+Qw265
	2jlpihLoEhVEWjODc1Y9g0jVcPDN9eGVA0OVPEd34mMvN/DDDbr6yCAcRRW+UNpUC99eyy/2kAX/U
	vN1jVJSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nNd5n-005nc8-S7; Fri, 25 Feb 2022 16:05:15 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nNd5k-005naf-GH
 for linux-nvme@lists.infradead.org; Fri, 25 Feb 2022 16:05:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id B73CC68AA6; Fri, 25 Feb 2022 17:05:09 +0100 (CET)
Date: Fri, 25 Feb 2022 17:05:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-crypto@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
 martin.petersen@oracle.com, colyli@suse.de
Subject: Re: [PATCHv3 07/10] lib: add crc64 tests
Message-ID: <20220225160509.GE13610@lst.de>
References: <20220222163144.1782447-1-kbusch@kernel.org>
 <20220222163144.1782447-8-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222163144.1782447-8-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220225_080512_731232_078F5D41 
X-CRM114-Status: GOOD (  10.27  )
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

On Tue, Feb 22, 2022 at 08:31:41AM -0800, Keith Busch wrote:
> Provide a module to test the rocksoft crc64 calculations with well known
> inputs and exepected values. Check the generic table implementation and
> whatever module is registered from the crypto library, and compare their
> speeds.

The code looks good, but isn't the trent to use the kunit framework
for these kinds of tests these days?

