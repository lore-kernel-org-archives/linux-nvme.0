Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6EF0CCD199
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Oct 2025 17:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VyV9VOTrAk36tT1/PMOp0Cs/0zn0lymCL+BPMlAvB64=; b=DdUxfDtWPJXOt7z3vVvfkj8QMQ
	hYr4etGzm3a8zhdgHZcEjbNrjsslX3I9CDNud1DkrLq0GAizFROg240zsjlQ5mqbFCV6EuCaXCcsC
	AUtRRqjpyhn23+acOafCWXlKLMP0hlcc5YH2cHTrAHG0yYS70kDK3+ABzDYkg4MpQlC718LjkSCLm
	ZEzHqHqylSCGZXHmhpescBu9Tx+hen33FqIQfJSAh+rpSakR5gDia4VNjt8NXEaT5w2p2QWUPHsFR
	hV2z5gnzt+QtAM+WcEdRsoKJIdI0HOpsudY4tjcleIyXRUWTYbcTqX23upgFyEDhT3IKVOJ3Q8mie
	WWgxnX9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAtIz-0000000EPSu-1YwO;
	Mon, 20 Oct 2025 17:04:21 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAtIy-0000000EPSm-3OIR
	for linux-nvme@lists.infradead.org;
	Mon, 20 Oct 2025 17:04:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 146ED602B8;
	Mon, 20 Oct 2025 17:04:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C7BC4CEF9;
	Mon, 20 Oct 2025 17:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760979859;
	bh=o+LYPHTdRhTW52/FiWeKwFKcC4lwSFTMXXG9PTzbwK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hbn/r7YdmYEND1AAfeI2iWaufadF1wKq9/8OpbEbUcFP/Vk9cS5jVuNWt+NTQvXN4
	 zXgq5189buC+vFvpaUk4kq2dENsCtxDtLQefWc8Xl3X+B5abM+MsTAsItyaCRxha00
	 JyEkEWEXpDA0LWnyvUDSQ4c4GIk5606K/ESkhuHRPr05sfgPWtY1bJ4V8OnNJbKbEN
	 +EBVjCeakD7ML2F39QxdeCkJ7AW6G/d6sij+XJdt4GMWIzEuVngjTv2rmM3H+fLaOc
	 +yLIvBwz5YhO3d5BROhctB7WdowOJFKMoy5M4JrDKY5kDqPbyMTh1PR0QskDlrMuss
	 3VUdey412ua8Q==
Date: Mon, 20 Oct 2025 11:04:17 -0600
From: Keith Busch <kbusch@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Subject: Re: Metadata integrity, single segment and peer-to-peer
Message-ID: <aPZrka9vQKugd-o8@kbusch-mbp>
References: <73609a88-b98f-474a-8872-673cf5ca0581@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73609a88-b98f-474a-8872-673cf5ca0581@app.fastmail.com>
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

On Mon, Oct 20, 2025 at 02:50:04PM +0300, Leon Romanovsky wrote:
> Hi Keith,
> 
> I'm looking on the nvme_pci_setup_meta_mptr() implementation [1] and
> don't see is_pci_p2pdma_page() which exists in
> nvme_pci_setup_data_simple() [2]. Is it intentionally? Can single
> segment be p2p transfer?

We may be calling unnecessarily dma_unmap_page in that case for mptr,
but I think that still works anyway.

