Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3AFDC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Nov 2021 18:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/oGeobPgKEELQ9jR8Tid54S7CEBgVi/4RdF59awrB6M=; b=E7wqx7fcgr3l1Vs5CYvNXLBE7U
	1q7suEol4N9zcXT9YtQrzFjhYk1KH9op3v4qT4CxeO91ml+2QS11pzosRjkbOysKfUxoxIioohCTp
	iDe2cKXAnVJM2RALaleC7mrREIBnrjKBiEBkMunimzFosGngW3KHfUr94wd0q6Lz898DikuRP/kBt
	x8DISOLmETWA5ayujXvEjGtyt/skai81RJaL0MpsTHNSU9DopWSAWURnIujU0kCoduNdseOSygsau
	THWQKoZX27tSBxQ1sRTrnb6WIxmN1JPUABg6rVxBuc639+kM12baGKykIs8C3996VY05BoaP6bj5O
	bcA4m2AA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mpaOj-003BSU-Ms; Tue, 23 Nov 2021 18:20:05 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mpaOf-003BRn-Uf
 for linux-nvme@lists.infradead.org; Tue, 23 Nov 2021 18:20:04 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id C53C660F6E;
 Tue, 23 Nov 2021 18:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637691601;
 bh=/oGeobPgKEELQ9jR8Tid54S7CEBgVi/4RdF59awrB6M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lOfhWqjGTMY5cSS2hechhcQTagHANlBU6FDHuZ2Gx3PVuM29N1MzlIItLdulSljk6
 AEmseKxSX1kUPxFkzDtwbVA8y3Do5Vi7QLPh5Mh5oQ1YQytBuo/AWn0y/czdQ5xg+s
 jQvU64VrSM1KEl7bS/z/hVnHOdyAe6mUzjLPkMvK85xRmDgjlrnFEkp/2hyPNF79ig
 o0AbmsZ++TXC356q4reWTN4DLbPUWamUR/JrWFN7BujPlpgK4ivzEz9raSeP8gH8/4
 tNfFVGgAp/z5DiSWE9KxaFIJqs22D0cZ+qoqmQQ7VKJje2RvzN04jVKtq5dbFHe/Ys
 A3VjoccNiSyXQ==
Date: Tue, 23 Nov 2021 10:19:59 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 Herbert Xu <herbert@gondor.apana.org.au>,
 David Miller <davem@davemloft.org>, linux-crypto@vger.kernel.org,
 Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH 04/12] lib/base64: RFC4648-compliant base64 encoding
Message-ID: <YZ0wz+4uA4Nk+aVQ@gmail.com>
References: <20211123123801.73197-1-hare@suse.de>
 <20211123123801.73197-5-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123123801.73197-5-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211123_102002_037320_C8423F48 
X-CRM114-Status: UNSURE (   8.34  )
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

On Tue, Nov 23, 2021 at 01:37:53PM +0100, Hannes Reinecke wrote:
> + * Return: the length of the resulting base64url-encoded string in bytes.

As I mentioned on a previous version, this is base64, not base64url.

> + * Decodes a string using base64url encoding, i.e. the "Base 64 Encoding"

Likewise here.

- Eric

