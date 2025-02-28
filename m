Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03BCCC282C6
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Feb 2025 18:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o8cyBZKh6Qo4N/DsrwgMxhPCUKu698NF4kLWWO8zRv4=; b=FpOxEmCE3UGPjjxnWmASWTbdFb
	ldHwRHLVQSXcFS7T7jtBNjWv63tjYeN8Jft+Z2dlAiU12z/Ecr1ZDWGXy9a9HVIDHCD0nie5L5eMU
	hVc4PBZ9ZgQZmiQzf/KNPZEIH18SNZ5nQ7C36pNNdlohcqCeRIdrTqudTaTa66RDI83FfFLK5IElP
	seXgwlsLGyMP2XJpyZ8OOJqTxYPCgSEj9f6mk1hEsUKrEzyImgkCH+9zOSKk4x72Ez6IIMuibJRH4
	Hq5/wOaYKwDlQVaKywC/B2YybENPxGmtE219lKwsWNnvd0lbTYfB9CbUizzUMBoIuI8KD5RdGRfwK
	JfecMUPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1to4eW-0000000C32E-0Z8O;
	Fri, 28 Feb 2025 18:00:00 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1to4eS-0000000C31P-3ifM
	for linux-nvme@lists.infradead.org;
	Fri, 28 Feb 2025 17:59:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7491C5C65DC;
	Fri, 28 Feb 2025 17:57:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966A0C4CED6;
	Fri, 28 Feb 2025 17:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740765596;
	bh=Bter9Gkv0LSxsD4ksAVv2q/okA9bJaPWL95th3vQYVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZyGqR4O0jJKLPr/H93yP8ihfCz9SKkPOdiWKG/F7poJ9diHzrHmq8NQaT3J5mh43R
	 fZ8mc9+bkKG2Hgd+X1k1PLvCWZilLAHNTvQApVQM9HpbJ7Og0Pk3NUAo04OBKYta9l
	 m8ZI/l/N32pzqH+aeo0TmQvqiVkd7RGUZyrcNnM0ky56yieDYWagWZ12JwL1HLuLyp
	 w0QnuG977IEBtX10rmHbw5Tt2gV9wuBKjnW2W44H1jAT8tv43o/AiJt3T4i8QyIaY8
	 K/VhgV8ULRqcrartA/zME76qy3bPIzQeIUlG0Ks07jwaF529omPQ3tc5UYY1WZfjtr
	 NqAqtv9zItrug==
Date: Fri, 28 Feb 2025 10:59:53 -0700
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org, hare@kernel.org,
	mlombard@bsdbackstore.eu
Subject: Re: [PATCH] nvme-tcp: fix potential memory corruption in
 nvme_tcp_recv_pdu()
Message-ID: <Z8H5mTykiQ39Q-Xc@kbusch-mbp>
References: <20250226134218.800559-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226134218.800559-1-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250228_095956_983283_8C524121 
X-CRM114-Status: GOOD (  10.66  )
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

On Wed, Feb 26, 2025 at 02:42:18PM +0100, Maurizio Lombardi wrote:
> nvme_tcp_recv_pdu() doesn't check the validity of the header length.
> When header digests are enabled, a target might send a packet with an
> invalid header length (e.g. 255), causing nvme_tcp_verify_hdgst()
> to access memory outside the allocated area and cause memory corruptions
> by overwriting it with the calculated digest.
> 
> Fix this by rejecting packets with an unexpected header length.
> 
> Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
> 
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>

Thanks, applied to nvme-6.14.

