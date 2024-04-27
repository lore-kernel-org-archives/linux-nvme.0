Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070FFC4345F
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Apr 2024 07:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ahkTgsjUFb5puqWeuFm9FKEmX+spbtidyadTWH6oSDk=; b=LI5EOwcV2siDO4KaJymwG3W2pp
	iSKEsi1ujergrvEhm+eiSW/kiAg9vuXQT3dLZZAHQUWOQ3gPBWGHHkS18ClrB0dMOiDILGgubGgYq
	eq5iO71yBRW31SrNTNzlvAleWvF3lqUZM+9Fd2xVlwl0I4cFXJhDqZkT9FUPG7p1sIWZ/ddJuLPhH
	YxzSVpaQZFYB1T1Uy2oWakE2kRJVmnwPcCECJ98eZbhMrVuepThTKCRcAyWu9rgK/TOgkJoudzj5D
	8m9Q6BLLqXbW10J+poOvHA472SxNEwj1MyxWuo7ihO75t5xZGbRudMLHIDlQ7LsyJG0Po3NBa7PYP
	bQL1qI6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0c5x-0000000F0py-45EJ;
	Sat, 27 Apr 2024 07:03:37 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0c5u-0000000F0pF-2JaG
	for linux-nvme@lists.infradead.org;
	Sat, 27 Apr 2024 07:03:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A4E81227AA8; Sat, 27 Apr 2024 09:03:31 +0200 (CEST)
Date: Sat, 27 Apr 2024 09:03:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, kbusch@kernel.org,
	hch@lst.de, brauner@kernel.org, asml.silence@gmail.com,
	dw@davidwei.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH 02/10] block: copy bip_max_vcnt vecs instead of
 bip_vcnt during clone
Message-ID: <20240427070331.GB3873@lst.de>
References: <20240425183943.6319-1-joshi.k@samsung.com> <CGME20240425184653epcas5p28de1473090e0141ae74f8b0a6eb921a7@epcas5p2.samsung.com> <20240425183943.6319-3-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425183943.6319-3-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240427_000334_755773_2ACC80A4 
X-CRM114-Status: GOOD (  11.03  )
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

On Fri, Apr 26, 2024 at 12:09:35AM +0530, Kanchan Joshi wrote:
> From: Anuj Gupta <anuj20.g@samsung.com>
> 
> If bio_integrity_copy_user is used to process the meta buffer, bip_max_vcnt
> is one greater than bip_vcnt. In this case bip_max_vcnt vecs needs to be
> copied to cloned bip.

Can you explain this a bit more?  The clone should only allocate what
is actually used, so this leaves be a bit confused.


