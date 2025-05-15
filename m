Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 041BCC3ABDD
	for <linux-nvme@archiver.kernel.org>; Thu, 15 May 2025 18:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+TwV4or/kUntN2YxuQUNL3qz4L6H9orSzaN+VVS3fI8=; b=0r+y2249xa5nb1KL096UHnglwP
	6BmrKjS+9tGJzw0aW9ze1mwqAYDRzXHnQY1irFbV/7zNt4FZOKySaIXq6eZgMR6LIayMGwmLkFPKK
	CZhh2WOxQwcsWKQKkHyCnFVZrBjUzu7lVgFOIwU3YOnjWS5gc2haZiRViFN9o6p+zB2v3A+EozaZ4
	STQO5MGflJNHHWAgcheQ9I4zkPpzIoT+Uwn+ECGC+g9gDBpVLHBGoVWHfqe9W1l6OaraA/X3x9X+X
	j2R0lr9/50R+bA+4QU4K6Eeg72bPpkRBDZ3ntfm2aA0r1ngJy24DGO5/CnsMEPRwjJIw+ATtqWI/o
	nM+36hBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFd11-00000001VUO-2OZz;
	Thu, 15 May 2025 18:09:07 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFd0z-00000001VU1-20sh
	for linux-nvme@lists.infradead.org;
	Thu, 15 May 2025 18:09:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 2F794A4E3B9;
	Thu, 15 May 2025 18:09:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BBDBC4CEE7;
	Thu, 15 May 2025 18:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747332543;
	bh=EMbkV613PdDRHIH0TklJGK8IdRcNls/AaRkWvfzUGpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mgTeyS0nRo/8GGQox7waepWvBt89X11Tjc4IIkuPLN0GqeY5JaU0dP3ym2OYbstyL
	 hPFl1HqPwySKYVlNGI38eFb3BPYb3C2/AcLkuR50wXRdHE08PjpxH9cqqp+Mas8EYK
	 myf9BJtwv/4ZVcfwyLFJvrIrIAML+DPXg8il6uwFuWTw6hOY1VNhSmZOBCVAOktZe5
	 jIGzEPHRseWZPp8ondAPHuPX3YYAZUytRpBBj/4SyF2rV8x/Ga8V0gNi+mZuNkdA/z
	 rU46XFYpoJRDo7+XpyKuN9P7N0Qyw6cTd0saAbr5xlcFyL2S1yity0q4TbtzPQ+f7d
	 z44zZxxq4c07w==
Date: Thu, 15 May 2025 11:09:01 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-sctp@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Sagi Grimberg <sagi@grimberg.me>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH net-next 08/10] net: add
 skb_copy_and_crc32c_datagram_iter()
Message-ID: <20250515180901.GA1411@quark>
References: <20250511004110.145171-1-ebiggers@kernel.org>
 <20250511004110.145171-9-ebiggers@kernel.org>
 <20250513144154.49f8faaa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513144154.49f8faaa@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250515_110905_582512_28F5361B 
X-CRM114-Status: GOOD (  12.35  )
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

On Tue, May 13, 2025 at 02:41:54PM -0700, Jakub Kicinski wrote:
> On Sat, 10 May 2025 17:41:08 -0700 Eric Biggers wrote:
> > +/**
> > + *	skb_copy_and_crc32c_datagram_iter - Copy datagram to an iovec iterator
> > + *		and update a CRC32C value.
> > + *	@skb: buffer to copy
> > + *	@offset: offset in the buffer to start copying from
> > + *	@to: iovec iterator to copy to
> > + *	@len: amount of data to copy from buffer to iovec
> > + *	@crcp: pointer to CRC32C value to update
> > + */
> 
> When you repost please toss a Return: statement here.
> kernel-doc -Wall is complaining

I'll plan to fold in the following:

diff --git a/net/core/datagram.c b/net/core/datagram.c
index 3599eda959917..fa87abb666324 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -538,10 +538,12 @@ static size_t crc32c_and_copy_to_iter(const void *addr, size_t bytes,
  *	@skb: buffer to copy
  *	@offset: offset in the buffer to start copying from
  *	@to: iovec iterator to copy to
  *	@len: amount of data to copy from buffer to iovec
  *	@crcp: pointer to CRC32C value to update
+ *
+ *	Return: 0 on success, -EFAULT if there was a fault during copy.
  */
 int skb_copy_and_crc32c_datagram_iter(const struct sk_buff *skb, int offset,
 				      struct iov_iter *to, int len, u32 *crcp)
 {
 	return __skb_datagram_iter(skb, offset, to, len, true,

