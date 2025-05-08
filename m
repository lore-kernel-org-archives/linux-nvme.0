Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CDF6C3ABC5
	for <linux-nvme@archiver.kernel.org>; Thu,  8 May 2025 05:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4YWZvtGWw8WYPBwLg0iS2A823hFWYQe4zeqMLTJhTEk=; b=S0nZ3+Eyu17PB+IxQbDq9gFMRw
	ANpCT5vINqLWLG3y5pbpxXf/HU8zyEJ8HyCn0zYUpYubWqTJRTalWWeqV2fNJ5QaQWeHlu9NyGMT0
	eT1JfufAMadrrpVjuno1IBEIgN7artH70z3kD5Wk1b0F17EaMTrNxMuqTLqLF0Tm9yL8/V2fWZWIL
	UU6JFqBwGmCD8pNC5oN53IMuW8lMmPjdNKUkLRpy/0XCvUu4b8bWGm2PrU9yAhmrTwErf6J8GVsQt
	Ztvhf8e/tMdjpbZDWkfZdcRgoMgk66tlk4H+YeiXvHScW5JvhSZq0/lbXJhwb/4oRGqKkaxqehGTY
	89dImc4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCtdh-0000000HM2u-3thq;
	Thu, 08 May 2025 05:17:45 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCtbt-0000000HLjw-0qfJ
	for linux-nvme@lists.infradead.org;
	Thu, 08 May 2025 05:15:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D148B68B05; Thu,  8 May 2025 07:15:46 +0200 (CEST)
Date: Thu, 8 May 2025 07:15:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, hch@lst.de,
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCHv2] block: always allocate integrity buffer
Message-ID: <20250508051546.GB27118@lst.de>
References: <20250507191424.2436350-1-kbusch@meta.com> <yq1msbot6ox.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1msbot6ox.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_221553_386605_77337F77 
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

On Wed, May 07, 2025 at 06:31:33PM -0400, Martin K. Petersen wrote:
> I know that we can't have one without the other currently but there's
> some cognitive PI dissonance wrt. keying off BIP_CHECK_GUARD only.
> 
> Maybe worth considering:
> 
> #define BIP_CHECK_FLAGS (BIP_CHECK_GUARD | BIP_CHECK_REFTAG | BIP_CHECK_APPTAG)
> 
> and validating against that? Or a bip_should_check() wrapper.

I'd vote for the helper.


