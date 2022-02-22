Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F328FC4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Feb 2022 19:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uFuaHdC482ZXw0/nrHhH2Wu2476wJbp+qZXsL+bYp5g=; b=TN+6hqfIfNUHcHVr1RP2auL7fd
	iqS8Rro1G8w7y6TsvqPXGiId7VPTVaqbk1JkOoUwlot2/R/oRs41K38zz6FF8w3Mf8PrBQBzsR+6t
	mVdIZz3Z/v/1iZ8Zv+2iMT2b5i9uQR1qjjPYzN2la0mcooMNVriLICJwfsPkC4zPNQiWAthDJ0e1r
	t4uheOprDGGKYLvSCzqVelffDtTR8MOL/9Kvqyz8lTnuCOreHXyDeg8UsXfUa8E6vQ5hbDFzvfDTq
	n4X14XoivJ2BLHfVc6dzY8hOHzbuh+cI8LlKx23i+VBccfQ4xqsp0ripVnM0KtFtNVSNrc/06Sh3p
	dHTbOMIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nMbF7-00BQJW-JQ; Tue, 22 Feb 2022 19:54:37 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nMbF4-00BQIc-RV
 for linux-nvme@lists.infradead.org; Tue, 22 Feb 2022 19:54:36 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5C69C6163D;
 Tue, 22 Feb 2022 19:54:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75EEAC340E8;
 Tue, 22 Feb 2022 19:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645559673;
 bh=2yoZXAZ2q0++zmDjP+ejRntLgW9usbykRPKM+jn7RvA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=F8UWrXJujLmvHh1w9CqBKy4QutjAMfCCUw/wULVyy+4whPVz+AQ6eIhIlZ5+tvwIF
 Uo6oIDK8PmySh3bxyFhbUoVovrdntR/sm7clciM6v5dW+KSTLkQ+TOXvsNAfFuQekU
 smFD6X+zDZiKjlpeYgxSinerPqxZdGO1YAzOh51O5n17SXSNsfynAh4TYGYm3R6Ml0
 VJrIy8r+nqrYalv3nLt5W4otYLms6QueecW67VJ7SpQ2nL3Q9MupfWvk97Sv1IeXkx
 wSPCXynfm22snba36Zg9KqZzFctDsZCQgVIvfWguIIbV+jddkxUz6YmtMFaRCEeQH8
 WyPUgnsOv6hXg==
Date: Tue, 22 Feb 2022 11:54:31 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-crypto@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
 martin.petersen@oracle.com, colyli@suse.de
Subject: Re: [PATCHv3 06/10] crypto: add rocksoft 64b crc framework
Message-ID: <YhU/d6wn55/GWPxm@sol.localdomain>
References: <20220222163144.1782447-1-kbusch@kernel.org>
 <20220222163144.1782447-7-kbusch@kernel.org>
 <YhU+kuMhueXVQvxe@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhU+kuMhueXVQvxe@sol.localdomain>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220222_115434_965622_9D507222 
X-CRM114-Status: GOOD (  13.62  )
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

On Tue, Feb 22, 2022 at 11:50:44AM -0800, Eric Biggers wrote:
> > +config CRC64_ROCKSOFT
> > +	tristate "CRC calculation for the Rocksoft^TM model CRC64"
> 
> I'm sure what the rules for trademarks are, but kernel source code usually
> doesn't have the trademark symbol/abbreviation scattered everywhere.
> 
> > +	select CRYPTO
> > +	select CRYPTO_CRC64_ROCKSOFT
> > +	help
> > +	  This option is only needed if a module that's not in the
> > +	  kernel tree needs to calculate CRC checks for use with the
> > +	  rocksoft model parameters.
> 
> Out-of-tree modules can't be the reason to have a kconfig option.  What is the
> real reason?

Also this option can be enabled without the CONFIG_CRC64 it depends on, which is
broken.

- Eric

