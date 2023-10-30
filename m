Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B71EC4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Oct 2023 15:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FsHp93QXvHsHxlWc3TDgYmS83zu4knkqaWNm259CP/g=; b=WtJilz4vKdOrMqyoS7LAegXsIC
	F8Kc/OqnR11nOuoWbcrk/RwQKWQcUYroKCsCgIdiLaIMF6OdtaJakg/M9bdCeE30kAscrJx7bOGpL
	jtO6JA77ltrUJZQK/U+3HitfZzw/Yc69UFtdyJQlHzDTIDFtKMm43w3irbBjiHsS7Tj1aOAlZDYkK
	L4mU9XlS9DTGb2J3JNwBLLkR5xpvEwobDFKouF2qSMdBy1f+BBTyt7Za/Va0R9ywEUDTEIJVTpyh8
	eywhOZz9ANACJJ1MA0iaHc352iArqKfsp4N0FESO0vAPOyjTRRTnRcCvQ4k1ZcCpku5LAY+UEKmvY
	Dn6ID1bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qxTnK-003Wy0-2b;
	Mon, 30 Oct 2023 15:03:10 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qxTnI-003Wx3-2L
	for linux-nvme@lists.infradead.org;
	Mon, 30 Oct 2023 15:03:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B8C3260AF6;
	Mon, 30 Oct 2023 15:03:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00FFBC433C8;
	Mon, 30 Oct 2023 15:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698678187;
	bh=yycAgp2NnUVNke1Fr3RlVfSDjyPhoJ5zWLXggicfNK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aishvX/EedZSTyi6JKlva9cX/u8ikxWV036JVb5w2p/pKZaPjrgFzGfI7/gqNM4HM
	 qmgt1GaDsjHrPVST0yixiR2OBVUnsHRxNa21hhdMMGkNise/VJrPc6J92tUuaRhUGh
	 KAVmIJuYdSEr6BRorUfavzUYM6G6kPa2gDADwcHijFYkZjdff+F4HfwCJ5SRc/xR5L
	 2wOjDcrpSeaWOpb5e7L1+5vPfGwdenjHv2KtgkhgCC9lTgFbS3aTLTqzCcXWNB83+t
	 FXp7pmyGZBooAyKZYiaZDxbgFyAUOJ4J0rehIA3TlynLMUY34jUTNCbgHmLWmuUSrh
	 8H4YVT0bjtRjg==
Date: Mon, 30 Oct 2023 09:03:05 -0600
From: Keith Busch <kbusch@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCH] nvme-auth: use crypto_shash_tfm_digest()
Message-ID: <ZT_FqTrckF3TOc7U@kbusch-mbp.dhcp.thefacebook.com>
References: <20231029050040.154563-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231029050040.154563-1-ebiggers@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231030_080308_808944_7E68948B 
X-CRM114-Status: GOOD (  10.46  )
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

On Sat, Oct 28, 2023 at 10:00:40PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Simplify nvme_auth_augmented_challenge() by using
> crypto_shash_tfm_digest() instead of an alloc+init+update+final
> sequence.  This should also improve performance.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks, applied to nvme-6.7.

