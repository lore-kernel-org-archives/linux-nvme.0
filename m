Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E9DC00528
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Aug 2023 00:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EImlXeMZVWICapqmVEubp+0gMWAM5m4kOmUkc0ZIeao=; b=rz594vOyG1n8LP96wBsZD9mY6X
	lbJxgpJMf9SDbXLT4zvJ8a8YNOsYRc//ogMe029vWbuwUp7kMTXdvVR4c+0ADLLbFL8dLXrE7V/N9
	kDx7MWorhzFGf5ZgF40pBubedg1xTQHO7kPDtjEfPLLMO/uug7ckT6f3jtUQEUc1hPM1iXm+FBo0p
	tpHzja8TG0tS/hwG2o9JgUwScIL/Ox8lhD7+WcMVS7/KtXY7wSsOA/6pxc/mrOPGdb2XBsixpPFTU
	IgrK6b3aUIn6bQAlGTUGWXBTho/Zfq3enZ6BBIpbOLolJUWRSPCFz7P6Pi5aK663N3K7mQnjffhdt
	FJ5T5acA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qS5bO-00DVPp-0c;
	Sat, 05 Aug 2023 00:57:06 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qS5bL-00DVPS-2g
	for linux-nvme@lists.infradead.org;
	Sat, 05 Aug 2023 00:57:05 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id BBD236213E;
	Sat,  5 Aug 2023 00:57:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B7DC433C7;
	Sat,  5 Aug 2023 00:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691197022;
	bh=R11BsqXSVi4wUiZMEOD+B5oPYL6Hoa/QtR76MRpQdPE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QNyPckaj6Xfs59VP9W+BxQt8XDvbRSHL1DA/MM+IzkQ4Y7gWtOOEx8pO81ml3VE8h
	 LpCQUXtROEGRadxtrvLLVRiB4Fm+ypTvysCA/AHkV0E+TUDQ4Htbv7IHpVRHDWnAQI
	 EjQ9V4r32ddBXRXIcyAkVmbZNoREIHET0m+psPUudGZMv2cM/ZkHUyRIhBBptIsWxk
	 nLB+5Ir0N2EN0Eq/uHsl0VWorzAHb3ymBtnK3SyPvwmRUX/zQUAHzNKemUmcKbXJoI
	 QwKQsHMyqBTMMHRy4xx1+s9G9VojQNpwH21ycRv+MsFIxXZoKvTf1MetNG/5xXUJPV
	 HzseGUOu5gR3w==
Date: Fri, 4 Aug 2023 17:57:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Keith
 Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH] net/tls: avoid TCP window full during ->read_sock()
Message-ID: <20230804175700.1f88604b@kernel.org>
In-Reply-To: <20230803100809.29864-1-hare@suse.de>
References: <20230803100809.29864-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230804_175703_910515_E9E8E632 
X-CRM114-Status: GOOD (  17.12  )
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

On Thu,  3 Aug 2023 12:08:09 +0200 Hannes Reinecke wrote:
> When flushing the backlog after decoding each record in ->read_sock()
> we may end up with really long records, causing a TCP window full as
> the TCP window would only be increased again after we process the
> record. So we should rather process the record first to allow the
> TCP window to be increased again before flushing the backlog.

> -			released = tls_read_flush_backlog(sk, prot, rxm->full_len, to_decrypt,
> -							  decrypted, &flushed_at);
>  			skb = darg.skb;
> +			/* TLS 1.3 may have updated the length by more than overhead */

> +			rxm = strp_msg(skb);
> +			tlm = tls_msg(skb);
>  			decrypted += rxm->full_len;
>  
>  			tls_rx_rec_done(ctx);
> @@ -2280,6 +2275,12 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
>  			goto read_sock_requeue;
>  		}
>  		copied += used;
> +		/*
> +		 * flush backlog after processing the TLS record, otherwise we might
> +		 * end up with really large records and triggering a TCP window full.
> +		 */
> +		released = tls_read_flush_backlog(sk, prot, decrypted - copied, decrypted,
> +						  copied, &flushed_at);

I'm surprised moving the flushing out makes a difference.
rx_list should generally hold at most 1 skb (16kB) unless something 
is PEEKing the data.

Looking at it closer I think the problem may be calling args to
tls_read_flush_backlog(). Since we don't know how much data
reader wants we can't sensibly evaluate the first condition,
so how would it work if instead of this patch we did:

-			released = tls_read_flush_backlog(sk, prot, rxm->full_len, to_decrypt,
+			released = tls_read_flush_backlog(sk, prot, INT_MAX, 0,
							  decrypted, &flushed_at);

That would give us a flush every 128k of data (or every record if
inq is shorter than 16kB).

side note - I still prefer 80 char max lines, please. It seems to result
in prettier code ovarall as it forces people to think more about code
structure.

>  		if (used < rxm->full_len) {
>  			rxm->offset += used;
>  			rxm->full_len -= used;
-- 
pw-bot: cr

