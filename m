Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 763A3C3DA49
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jul 2024 23:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n/5iiahINF900SNwvQe86Q7Y1IoMssWcNoC6L6Clr0Q=; b=ks8LkkUOfVZ3WwLkJz/bj87RiT
	2ROnxnxWJZnmMvy4cLGHk+AIRioqLx96eT8Ewos1QeaP4n/HMJEk5Drbew4fYLVBimt9NqPIyPtT5
	5N22q5DyrV/MviKg+EjK3LJ0Eh2QBbt9SXjayXCAgiCp8m+wKq1qteOG6ZV/Taav15s+Vr4NgYacc
	m2vvWipSTowCOBiRuYJQMnjcSukDbaToFhnaOHL7amcQJ7K7cofy9bnHUxH3Vm2UDAheRveIZ9y6i
	pHXzqT8o+7c3HaUN7kjwtWcevfWMXSokTL7uWUiYM7raOz37Y/bX+kajThocngJDzYcbHWYIjpk/X
	XGUadXaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUaKW-00000000xRn-49t2;
	Thu, 18 Jul 2024 23:14:32 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUaKT-00000000xR2-451F
	for linux-nvme@lists.infradead.org;
	Thu, 18 Jul 2024 23:14:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id D3306CE1AD4;
	Thu, 18 Jul 2024 23:14:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C72C116B1;
	Thu, 18 Jul 2024 23:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721344466;
	bh=lwCQ3RqpIS7D64LHT01YQB3FMaupHjYiipi2lAPfVhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aYTvzBTGcLc9/ugDIJy8U76mKjzyrrh90dFAKuDXZsgw+d4ArCRXr8O2qF6Qo0Vh3
	 6hvYI6Fx+eUoL2HSG2UCTfxDs96AI1r0o+2HRqhOOvEr51TwYc7Hu3/Vr8Jh1WGULe
	 TuqGMF5XwoyK/Z1YEcysXHw9ybhmwIv/xvg62IhbrxEKx3LmCX22b3vMY7Z4O3p41o
	 5xk32phujj8Unr/6Rg7q/m7ClLsMycEBWZ2e0OPFaymwoZxfJXpGAgQDt3cSU65Lxa
	 s5YNMU6fgGiWxk3loTllk82g4e5ScZfHjGc4YJWNd+9BUHHJPPnQxRyrwJZ0ky5awz
	 I8QonjxMZecyg==
Date: Thu, 18 Jul 2024 23:14:24 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCH 1/8] crypto,fs: Separate out hkdf_extract() and
 hkdf_expand()
Message-ID: <20240718231424.GA2582818@google.com>
References: <20240718150658.99580-1-hare@kernel.org>
 <20240718150658.99580-2-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718150658.99580-2-hare@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240718_161430_220856_C8E44930 
X-CRM114-Status: GOOD (  11.76  )
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

On Thu, Jul 18, 2024 at 05:06:51PM +0200, Hannes Reinecke wrote:
> Separate out the HKDF functions into a separate file to make them
> available to other callers.
> 
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: linux-crypto@vger.kernel.org
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>  crypto/Makefile       |   1 +
>  crypto/hkdf.c         | 112 ++++++++++++++++++++++++++++++++++++++++++
>  fs/crypto/hkdf.c      |  68 ++++---------------------
>  include/crypto/hkdf.h |  18 +++++++
>  4 files changed, 140 insertions(+), 59 deletions(-)
>  create mode 100644 crypto/hkdf.c
>  create mode 100644 include/crypto/hkdf.h

I was only sent patch 1, so this is unreviewable as there is no context.

- Eric

