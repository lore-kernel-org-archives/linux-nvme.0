Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50146C3ABC9
	for <linux-nvme@archiver.kernel.org>; Tue, 13 May 2025 21:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X9yPTIlGkj0+ymcNYfbpLyEREHrOIR3vOgC3AyVYExw=; b=OhHOpzPVLtPgbtqkXRBI/SHxCR
	o/eCAiPESBt8UOXQppordqkk7uIc3nTltV3C0DrF47FVHVyRWf1fENhjHcLcICJT7sdf5xwJl9Qfw
	7BKc3X8tzwFaB/zG6CzM+lL5oEbULyQfgNUuOl/2k0aFheUS5dBNELBlxRL0ob2orkC3I/8fZqEo8
	eUSyx1Fqzva6cFX60uwk0ALZ0o/o8QopQID13+ijow5jxe2GynUE8VIpOPBbl23ryjOQkQIMh6EQh
	Z5JmiY/SPOIkKHh9udrwBM8j9Z1Q7D7sgWUm/JaYN9TCj/zZvD1Z3n3S59wZh5F6TSEVVMuYrT4zb
	DQ08cppQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uExPO-0000000DZwB-2VWX;
	Tue, 13 May 2025 21:43:30 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uExNt-0000000DZkj-0QJb
	for linux-nvme@lists.infradead.org;
	Tue, 13 May 2025 21:41:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 3B9F2A4C9A9;
	Tue, 13 May 2025 21:41:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ABD4C4CEE4;
	Tue, 13 May 2025 21:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747172515;
	bh=8PWt1duAkSY7eSn4u0WA9MHoPcUK8ogpDcpia6Mf+yA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QYfUUcKS7ZRph5ZQSlsbksWFlsHZrbYQU91a1GdrsTJKsGnBwGd9bEjQ0JzxQGZBG
	 zRPMX5cd389R1pA+9RiAx7VsRVe0R8Vj3zm35epQASw2usv2xC1DU9h6bVGKN6Z/VR
	 PKdJ+E/bWYHTXpICV/pSE38natav9ZT3UPQaMO/HrBw/2kG831go1wIrheYPldhChd
	 QHcoDk3XFl3hFlrXxSniyVxZZVBqqlFLTsfzKkuC712ILn6HYEImlsRVr9oSRprxOF
	 rj7P/j44FWiRYyEq3MN5wnMEc+YMSKktXHFR/Wqhti6xnyIYmHFahyz036ZTbXVHg7
	 kCAXqNsJ6U2Kg==
Date: Tue, 13 May 2025 14:41:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: netdev@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-sctp@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Sagi Grimberg
 <sagi@grimberg.me>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH net-next 08/10] net: add
 skb_copy_and_crc32c_datagram_iter()
Message-ID: <20250513144154.49f8faaa@kernel.org>
In-Reply-To: <20250511004110.145171-9-ebiggers@kernel.org>
References: <20250511004110.145171-1-ebiggers@kernel.org>
	<20250511004110.145171-9-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250513_144157_209434_586C0675 
X-CRM114-Status: UNSURE (   7.82  )
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

On Sat, 10 May 2025 17:41:08 -0700 Eric Biggers wrote:
> +/**
> + *	skb_copy_and_crc32c_datagram_iter - Copy datagram to an iovec iterator
> + *		and update a CRC32C value.
> + *	@skb: buffer to copy
> + *	@offset: offset in the buffer to start copying from
> + *	@to: iovec iterator to copy to
> + *	@len: amount of data to copy from buffer to iovec
> + *	@crcp: pointer to CRC32C value to update
> + */

When you repost please toss a Return: statement here.
kernel-doc -Wall is complaining

> +int skb_copy_and_crc32c_datagram_iter(const struct sk_buff *skb, int offset,
> +				      struct iov_iter *to, int len, u32 *crcp)

