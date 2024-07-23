Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B443BC3DA5D
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jul 2024 00:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KJ+ANYTTYsVqMnV7EndGzWu2jyaHoFvWhDBRAx17KLM=; b=Qnj+a+Vqw4+ONxcJ8P5X2ppGjK
	KXnNKlkagUXOW2ujXb1k5JRohEIjDXUTL0yums8gZkBM/HKpDsDJmlRunbzBEe0wIR32fWCB/YY+W
	3TH4KBpNL3GJ+Biy7lOOurd5t2Uhqoo9qNy+w+Y3o9N4H9Bx6n2kEQdvP/az4sv6j2aSkwwGywklK
	8MSWAxvp+uZLZc79DV6UBTIHASYuL+gY1/ua+cE4Slgkqwj+1nR/cTc5Gn0l9caPII0HOEL0M11B3
	2VJ5v0BPXMf/uFNbOi8quikjpkyvd60FNeIT2Ez1MLsGqf9uyoQOBiWu1vgZ1FNFrDkreUQBvrG6s
	1Cdw8OLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sW3fN-0000000Aym3-0BOC;
	Tue, 23 Jul 2024 00:46:09 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sW3fK-0000000Aykm-0FU5
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jul 2024 00:46:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 82A9760AB6;
	Tue, 23 Jul 2024 00:46:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8252C116B1;
	Tue, 23 Jul 2024 00:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721695565;
	bh=HKx7wPs7b7QPHMuQbYeVTG9h9TBUySKj97W9ZT0Ui0c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ip1viDcWaSjKqoYTdz3UQLSXT7PJajQPTVUsUiYEDGIDN1MbedUq5D3fFRCkGIZKg
	 WInHaCAf+JGIwnPQc5oz3J2OegfOUReTqNHWT29Ln8C0Y44Ba8vvEf+q8MUvXjkRIU
	 uthxFtTJUBFMMtzJquCR0aESi6/zqZNRRaiaR/mgNdjMmRBR1dyQu1yLp+Uk1i2+AU
	 tGMWL58dS3RoydwI2GT+WY7aJJrZ8fz5XMCuNBlF1x29v0BdeRZsqucz6UfReFZQkM
	 kTjnYvjZf3TaVb+JcTjFkVQyaxOkw2CqPPZFAqhUEXfCLYtO88lbM58lh1ucN3tqZE
	 Fm52rSbhxZdbw==
Date: Mon, 22 Jul 2024 17:46:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ofir Gal <ofir.gal@volumez.com>, davem@davemloft.net,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, ceph-devel@vger.kernel.org, dhowells@redhat.com,
 edumazet@google.com, pabeni@redhat.com, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
 christoph.boehmwalder@linbit.com, idryomov@gmail.com, xiubli@redhat.com
Subject: Re: [PATCH v5 0/3] bugfix: Introduce sendpages_ok() to check
 sendpage_ok() on contiguous pages
Message-ID: <20240722174603.048fc4d8@kernel.org>
In-Reply-To: <20240722174548.404086ec@kernel.org>
References: <20240718084515.3833733-1-ofir.gal@volumez.com>
	<0cc50a53-fd8f-433d-bb69-c9d3f73ceace@kernel.dk>
	<20240722174548.404086ec@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240722_174606_214924_6305DDE6 
X-CRM114-Status: UNSURE (   8.84  )
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

On Mon, 22 Jul 2024 17:45:48 -0700 Jakub Kicinski wrote:
> On Mon, 22 Jul 2024 16:21:37 -0600 Jens Axboe wrote:
> > Who's queuing up these patches? I can certainly do it, but would be nice
> > with an ack on the networking patch if so.  
> 
> For for it!

Go..

