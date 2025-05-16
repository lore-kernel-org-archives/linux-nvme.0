Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B256DC3ABD8
	for <linux-nvme@archiver.kernel.org>; Fri, 16 May 2025 04:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D/sL8xKdHNXpp4F48ilzZqzQNOfczYgnjCBdaBL/BJs=; b=AZlEooBPgOOPI/Z3hrQRnCg1Ac
	tNuJMIyOoD7KDBtafqXJ0p2kLsVRaIKgMEFofcCuNVD/RqYn6VDLmGRl7egiKH0nKz5vpdyBBtYIh
	T0dA2+5hZ5ftZlCpxJKcTb9SVZR9PnpJ7SkYhUY0AKi+2aMwR3x6dUl9tWg7rSNFdteqaILtNacmr
	f6rLEdAs6gw+cON7sjPKY4NbCfGUHTPZFb82u2c4rK396Vmy2CP4XpdTCTSrmC7dchab70LE0ZerB
	Ln18WyRyRQRht+7D4QTtAywPLjFNRWZV7pcdopJlyqoUApcnKgyEoXfs5bApljJtfpjAHDyFAZ1DJ
	UrSR9x0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFmnj-00000002SsC-0hIN;
	Fri, 16 May 2025 04:36:03 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFmng-00000002Sry-45J2;
	Fri, 16 May 2025 04:36:00 +0000
Date: Thu, 15 May 2025 21:36:00 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: netdev@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-sctp@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Sagi Grimberg <sagi@grimberg.me>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH net-next 09/10] nvme-tcp: use crc32c() and
 skb_copy_and_crc32c_datagram_iter()
Message-ID: <aCbAsCkTPMNE6Ogb@infradead.org>
References: <20250511004110.145171-1-ebiggers@kernel.org>
 <20250511004110.145171-10-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250511004110.145171-10-ebiggers@kernel.org>
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

On Sat, May 10, 2025 at 05:41:09PM -0700, Eric Biggers wrote:
> +static inline void nvme_tcp_ddgst_init(u32 *crcp)
>  {
> +	*crcp = ~0;
>  }

This helper looks really odd.  It coud just return the value, or
we could just assign it there using a seed define, e.g. this is what
XFS does:

#define XFS_CRC_SEED    (~(uint32_t)0)

nd that might in fact be worth lifting to common code with a good
comment on why all-d is used as the typical crc32 seed.

> +static inline void nvme_tcp_ddgst_final(u32 *crcp, __le32 *ddgst)
>  {
> +	*ddgst = cpu_to_le32(~*crcp);
> +}

Just return the big endian version calculated here?

> +static inline void nvme_tcp_hdgst(void *pdu, size_t len)
> +{
> +	put_unaligned_le32(~crc32c(~0, pdu, len), pdu + len);
>  }

This could also use the seed define mentioned above.

>  	recv_digest = *(__le32 *)(pdu + hdr->hlen);
> -	nvme_tcp_hdgst(queue->rcv_hash, pdu, pdu_len);
> +	nvme_tcp_hdgst(pdu, pdu_len);
>  	exp_digest = *(__le32 *)(pdu + hdr->hlen);
>  	if (recv_digest != exp_digest) {

This code looks really weird, as it samples the on-the-wire digest
first and then overwrites it.  I'd expect to just check the on-the-wire
on against one calculated in a local variable.

Sagi, any idea what is going on here?

Otherwise this looks great.  It's always good to get rid of the
horrendous crypto API calls.

