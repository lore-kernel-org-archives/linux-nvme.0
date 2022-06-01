Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E38EC433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jun 2022 05:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XYKjVAkLTrBzziSSh1l84SObJP3Z3KtAg4mmcdtkV6s=; b=P5LqbuZzT9oP0/oFb8eTpn2j79
	2fuupSiuFwv/09JpC4yKARaYvfY2aKZOZW053WbLhidnGY5rNkMatAEdeKPZdodOQ99UqFaYv0xCs
	CjTNJ9thx//1bF8s1zMjX7re1s5C7aEPgzZWu0rcGa8S88h8MaNyOP5ef1NPm3+G6ZAY7vMhTn7F9
	g3/Na+e50X6+e2S1mVzrHM8jzvuIqiKMp8R5JNLgeJ8fe03Ye6smve4t9z9eLvvJP1IlyOJpMZHbL
	rz8KkRJ9vMtHKod/NnCT1YJfLH3kOLtYRGfWAH//7ED8UZhDvXPsM3Guzq7g2ILF+0Io78wYTL1mp
	M2/bV00w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwGwH-00Dvg2-I6; Wed, 01 Jun 2022 05:30:37 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwGwE-00Dvew-Hn
	for linux-nvme@lists.infradead.org; Wed, 01 Jun 2022 05:30:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A670368AFE; Wed,  1 Jun 2022 07:30:31 +0200 (CEST)
Date: Wed, 1 Jun 2022 07:30:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@fb.com>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk,
	Kernel Team <Kernel-team@fb.com>, hch@lst.de, bvanassche@acm.org,
	damien.lemoal@opensource.wdc.com, ebiggers@kernel.org,
	pankydev8@gmail.com, Keith Busch <kbusch@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCHv5 08/11] iov: introduce iov_iter_aligned
Message-ID: <20220601053031.GB21743@lst.de>
References: <20220531191137.2291467-1-kbusch@fb.com> <20220531191137.2291467-9-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531191137.2291467-9-kbusch@fb.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220531_223034_774869_768B185C 
X-CRM114-Status: GOOD (  11.96  )
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

On Tue, May 31, 2022 at 12:11:34PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The existing iov_iter_alignment() function returns the logical OR of
> address and length. For cases where address and length need to be
> considered separately, introduce a helper function that a caller can
> specificy length and address masks that indicate if the iov is
> unaligned.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

