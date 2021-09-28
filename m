Return-Path: <SRS0=nS76=OS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F29C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 06:26:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 884E6611BD
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 06:26:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 884E6611BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JwP+l0nWXYRzYWxstF5RJMgH8168PaMi3xRsG4HQqLY=; b=Lt1n3F54lq73M3
	rhDvPN4DUM5M77PJdkKKnBrnvpb7wsLXlP5w58Lwhrdon8u/F6dyC+JsA+T7/2i4RQtF+3bNKtpCt
	OxIX6lLV33rzf7JkXILCIZlZVqOYzAQNULRYZlKo8rbG9dYrTd9/5n55aNvDfjXH/j7OfxFSaXosM
	PQvtiFYBkoPHzTsoYGBsX+5LByR6vcAu4nF7YezsFMt+n+0Z+zgX0cGYm7Djy3NgD/bwBjB8z8F+R
	p5oHsNUY2FWI4lZ8TSsRwdHdzcC76reHlMG4uQoQ3vkUXY7qLYmx4JoGYVebJtr8LVAtDbPov06g2
	SOWYtND8l/dkdw2OU+fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mV6Yt-005ppQ-SQ; Tue, 28 Sep 2021 06:25:55 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mV6XK-005pRE-R4
 for linux-nvme@lists.infradead.org; Tue, 28 Sep 2021 06:24:20 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5738961157;
 Tue, 28 Sep 2021 06:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632810257;
 bh=0+fm8nJsYppz796moPgEvC4ALZD05CQCvZuU4dzfISo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mT48iX93w7d0SztBr8/OOD9UiRU9fj1Fl4ao9SAlM8lIk2HbvJARq9xYK3+VJeJ8K
 VUExRvmeJ4Jnx+UDLP5TIkwoEt8AmmhCn0tJqTrvKmfuiYH6CJf3PDHb1u4vqgEBKQ
 +F5hcYISK83oHyr85XiBKCQR31XeTqWOlpnQ5C8UtyTuwfXtJ33Kfs/tY8jMDlxqsU
 AuU7zYXYP6/Jx/z0y6j6kVcbM7QLFFKel12NQ4/wazeAVCdUVj4ULgb6imQKh5HSQf
 vg3/5AdoGc7D8phCKl/jnB1XiYcsbYkNGuvme/Vxn8tzBUUlkd4uUjz6wbQDl4iPIk
 wsYtZn5OvjXBg==
Date: Mon, 27 Sep 2021 23:24:15 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <keith.busch@wdc.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>,
 linux-nvme@lists.infradead.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH 04/12] lib/base64: RFC4648-compliant base64 encoding
Message-ID: <YVK1D+GZgdFPRsaS@sol.localdomain>
References: <20210928060356.27338-1-hare@suse.de>
 <20210928060356.27338-5-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210928060356.27338-5-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210927_232418_939396_6485EBEF 
X-CRM114-Status: UNSURE (   8.66  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 28, 2021 at 08:03:48AM +0200, Hannes Reinecke wrote:
> + * Return: the length of the resulting base64url-encoded string in bytes.

base64, not base64url.

> + * Decodes a string using base64url encoding, i.e. the "Base 64 Encoding"
> + * specified by RFC 4648, including the  '='-padding.

base64, not base64url.

- Eric

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
