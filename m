Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D90C2D0CD
	for <linux-nvme@archiver.kernel.org>; Sat, 17 May 2025 17:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gw67pyno8KLGWQqAlFn2wkBCfL3WmzsaLG+Tl3zOJH0=; b=hHpwQRfPlkRYyH7F2ilyTsop/e
	q5/YuNuzZLmbjlWIwvy1jOS6mwJbIxVaIx4/XmBZDk198xE1831M2ACHC27oEMaVMX5Ph+Rrd7p4Y
	ZiT5W2JZOuNUbkpmJEj9id9pPUW+vddg49LetpqCSUloZpg7+nM064VWDEWzMWdH0puE/93sjmbOm
	lyApCfn8LiMRsJPw2Jmm8Ot0rtevP2TSuZy1kDJVqxJjAu0Ly5UlmXG7W7caI90pTaS5OCCwp9p1E
	LxY+33Gyl/NX2yDVMk8yiCMj/Fb/buO8/PxB/TOVVXYy6zAX0sDVcubR6DkHJ3xPun9SLVeeB2RTM
	vrVqNtzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGLbt-000000064KE-17DZ;
	Sat, 17 May 2025 17:46:09 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGLbn-000000064J8-1L9I
	for linux-nvme@lists.infradead.org;
	Sat, 17 May 2025 17:46:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id AED724440C;
	Sat, 17 May 2025 17:46:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3353EC4CEE3;
	Sat, 17 May 2025 17:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747503962;
	bh=7/27gGuAO+opB7qDSlkxsDQOtI6hEvDd/hdxFCWHj3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tq0DH6KXX9NRv3ifq9zWCcgIkIisXar1upGP0dZfAOxX/1CK8mmpbD2+XzhZodLGS
	 zH0RTmSq+1NguowNMBpHoiW/bBAmwFsjyr68tRP1dce6DFxX9BtLRnmqfGvjWucQVR
	 wkgR8NIg14iSz1TXnwDFYN905bLZKa17jb+KfohwSVrJSo8QBnt/W6QIaPyyIHK9hR
	 +gt48u1e1zwrC/eUWS3QVuZ5LWX7oh0T78mvP+LHUGjP9E8W9ZpMQTEe4XIiJFAe8L
	 EnkRjS80iJUrcGt+uvBhqrb19Evv5yxMuLVTwWASELtQj+B+pKHmLTe6gbe7pH6oAs
	 CDexrVCAuG/KA==
Date: Sat, 17 May 2025 10:45:52 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: netdev@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-sctp@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Sagi Grimberg <sagi@grimberg.me>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH net-next 09/10] nvme-tcp: use crc32c() and
 skb_copy_and_crc32c_datagram_iter()
Message-ID: <20250517174552.GB1239@sol>
References: <20250511004110.145171-1-ebiggers@kernel.org>
 <20250511004110.145171-10-ebiggers@kernel.org>
 <aCbAsCkTPMNE6Ogb@infradead.org>
 <20250516053100.GA10488@sol>
 <aCbWAFNoBUjci7HG@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCbWAFNoBUjci7HG@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250517_104603_378596_81CE1944 
X-CRM114-Status: GOOD (  15.57  )
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

On Thu, May 15, 2025 at 11:06:56PM -0700, Christoph Hellwig wrote:
> On Thu, May 15, 2025 at 10:31:00PM -0700, Eric Biggers wrote:
> > +static inline __le32 nvme_tcp_hdgst(const void *pdu, size_t len)
> > +{
> > +	return cpu_to_le32(~crc32c(NVME_TCP_CRC_SEED, pdu, len));
> >  }
> 
> This drops the unaligned handling.  Now in the NVMe protocol it will
> always be properly aligned, but my TCP-foo is not good enough to
> remember if the networking code will also guarantee 32-bit alignment
> for the start of the packet?
> 
> Otherwise this looks great:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

The nvme-tcp driver already assumes that the header is at least 4-byte aligned,
considering that it accesses hdr->plen and the struct doesn't use __packed:

    struct nvme_tcp_hdr {
            __u8	type;
            __u8	flags;
            __u8	hlen;
            __u8	pdo;
            __le32	plen;
    };

On the send size, the header size is always sizeof(struct nvme_tcp_cmd_pdu) or
sizeof(struct nvme_tcp_data_pdu) which are multiples of 4.  On the receive side,
nvme-tcp validates hdr->hlen == sizeof(struct nvme_tcp_rsp_pdu) and then does:

    recv_digest = *(__le32 *)(pdu + hdr->hlen);

So, using put_unaligned_le32() is unnecessary.  I just had it there in v1
because I had directly translated crypto_ahash_digest(), which does ultimately
do a put_unaligned_le32() once you unravel all the API layers.

- Eric

