Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39ABBD6B6B5
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 17:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3DtqE1Xm3h/1759Uwrs5AVCXCgSav+wxnTVicElldR8=; b=WXX+IPY6Qz2PfbLDSSJFv5nZTU
	azsJnIFvre3rpLc3e587gBSE+Rkb3rQyLEfE/HiG2GBKNGIJWX0kx4OQ9COqfJH8YOOasI7ZUQnMz
	AAFMumFNNVfzdjUL2KByvPks8o62otFgy9xQSb3iL1qXZprJ2SS+ESk/RfrSpGRqPo4+eSSGsM6vX
	4SXTQqvMNrie2FidDRkx/LgUCKpD8IA3t+4vDDR7oFlvS2sjrZTGugRXD5+wXXlc4vVd7jbtdkq7j
	9T4pNcdX3G+1SVwYG7SASYyRngOWA8WVQkfe1BJK9a1bGFAPVxtvsEAIS6Ptkn9CcvaqGck5J7+JT
	8wGvHVbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6C85-00000001BR5-2YKS;
	Wed, 30 Oct 2024 17:05:09 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6C83-00000001BPg-1kA0
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 17:05:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id CCC36A4143E;
	Wed, 30 Oct 2024 17:03:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75BA4C4CED0;
	Wed, 30 Oct 2024 17:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730307906;
	bh=3DtqE1Xm3h/1759Uwrs5AVCXCgSav+wxnTVicElldR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q5B+uCf1RL9n9/HcoMYEhvnpYkDohIwvQgt5BsVCpivE8c10FEeCMZV2NGjy2k8h5
	 vkPqdSn6hSwNwygEiKLDA9l9DTmbBY/mxtxELLR3MsBivajYApT7jr4dOJNvBEhvf0
	 kM+crSIpMac+xGhPlcmpcvPes+kroyzg3RtAwhp5SorjHy6LaRmWJHaNZVKLVDMKLF
	 Sorvd2SBOMzsWCHwfbBcEHUN6GjrZb+p6Ser8X+B054K72MfeV0yCbcLU6UnZ4Ec1/
	 sgJWLkuE2GesRYxZthGfEtblBgSNiCHdor6TD9f32Lg+RB6cV2LmoIVqgrbR4cX0zL
	 QqrRRBMWSyaxA==
Date: Wed, 30 Oct 2024 11:05:03 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com, javier.gonz@samsung.com, bvanassche@acm.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv10 9/9] scsi: set permanent stream count in block limits
Message-ID: <ZyJnPwqIufrcMkFg@kbusch-mbp.dhcp.thefacebook.com>
References: <ZyEBhOoDHKJs4EEY@kbusch-mbp>
 <20241029155330.GA27856@lst.de>
 <ZyEL4FOBMr4H8DGM@kbusch-mbp>
 <20241030045526.GA32385@lst.de>
 <ZyJTsyDjn6ABVbV0@kbusch-mbp.dhcp.thefacebook.com>
 <20241030154556.GA4449@lst.de>
 <ZyJVV6R5Ei0UEiVJ@kbusch-mbp.dhcp.thefacebook.com>
 <20241030155052.GA4984@lst.de>
 <ZyJiEwZwjevelmW2@kbusch-mbp.dhcp.thefacebook.com>
 <20241030165708.GA11009@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030165708.GA11009@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_100507_542498_878BE2DA 
X-CRM114-Status: UNSURE (   7.87  )
X-CRM114-Notice: Please train this message.
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

On Wed, Oct 30, 2024 at 05:57:08PM +0100, Christoph Hellwig wrote:
> And once it uses by default, taking it away will have someone scream
> regresion, because we're not taking it away form that super special
> use case.

Refusing to allow something because someone might find it useful has got
to be the worst reasoning I've heard. :)

