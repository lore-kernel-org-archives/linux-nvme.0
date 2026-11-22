Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1D0606A32A
	for <linux-nvme@archiver.kernel.org>; Sun, 22 Nov 2026 15:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=CknVWhbI;
	dkim=pass (2048-bit key, unprotected) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=JMxKDPpt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:References:In-Reply-To:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ryvEPjqew3yO9j3FoUR+1enMAncqpW1VfNIetah7IDk=; b=CknVWhbIWXfvZfDYvPSRl5K008
	80CoE2K06oul+Yw/zZSPSEIKTZjqehoftyCpay2LZlsuu1GbX3+qmFGNSnwJtA8OAf1zMKdBpCBKQ
	nXuZwyjAFpehHDkziLykiZWDoT4TisaZx1lntxJNTlXPR6OwUEJ9MtbLT6QfC1ejIucsl56Slric1
	37h+IfhviRGmGQctJa2A17hbDZcSLjRnmpZOVAshuTEAUBREYfQMFZLuv2mY8KX6LZ+mU2oqkL1Nv
	fn2wLuUF3TJm7sBzoNV2AQpfrBYHl//XbGkn1gnoKYKirDFdNKPTDLzvrrM4JNywjg4ww78wNmij6
	JFLnYbCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xV9cf-00000001HR6-2fc4;
	Sun, 22 Nov 2026 15:36:57 +0000
Received: from mxhk.zte.com.cn ([160.30.148.34])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xV8T1-00000001BwZ-2A3J
	for linux-nvme@lists.infradead.org;
	Sun, 22 Nov 2026 14:22:58 +0000
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jXWW8432Xz5BNRx;
	Sun, 22 Nov 2026 22:22:44 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1795357364;
	bh=AkAy6g5Mb/vdkDcejg0T3zp8tTGdMmRjwKRwl7qrpUE=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=JMxKDPptcJN48tRTY9gX4hH2Z3eBv2l4XHGQL6AEtoTxS6lci8TLYtJJkwhJ2sKlH
	 rOdqdaX5Zu3WJNqwWuLVzvBjwK5iocP0SVQ3E6QlfazqY3TUJSRZi72qvPyqDi/73I
	 B0dF4Zdq9K+kiOODrs2KMbNhOx2xPpTwr1BuEnd1SDRB982agHo0sZwgwQtDocwnoZ
	 WxfC6XbbPXua9oxJP2hmX6qsKZgFXJQ/zsg4fzRHgpWTjGVFj8/GDcV56Gj3RWbcFV
	 LrXZYbp3NIW3lh+2QTw09AE189s5pykSO7RpVvLQ5VsfOt2JIEyKUmz2FYH9DiqReg
	 Ic3AeAibP73JA==
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 6AMEMZUY030623;
	Sun, 22 Nov 2026 22:22:35 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 22 Nov 2026 22:22:37 +0800 (CST)
X-Zmail-TransId: 2afc6b02faad7ef-373bc
X-Mailer: Zmail v1.0
Message-ID: <20261122222237542HTrb5XjZWwOHuyfeaimCs@zte.com.cn>
In-Reply-To: <20261120175207.GD1484@lst.de>
References: 202611150127512368BGQ07ZNIRAIwClkam-8u@zte.com.cn,202611150127572887TC7vHzVUFLZ6nyW1NuhU@zte.com.cn,20261120175207.GD1484@lst.de
Date: Sun, 22 Nov 2026 22:22:37 +0800 (CST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <hch@lst.de>
Cc: <kbusch@kernel.org>, <axboe@kernel.dk>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCA0LzVdIG52bWU6IGRlY29kZSB0aGUgRkRQIEdldCBGZWF0dXJlcyByZXN1bHQgYXMgYSBkd29yZA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 6AMEMZUY030623
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sun, 22 Nov 2026 22:22:44 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6B02FAB4.001/4jXWW8432Xz5BNRx
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261122_062256_014436_35B0DAB0 
X-CRM114-Status: UNSURE (   5.70  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.1 (--)
X-Mailman-Approved-At: Sun, 22 Nov 2026 07:36:54 -0800
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Christoph,

> With this struct nvme_fdp_config becomes unused, so we might as well
> drop it.

Dropped in v2; the FDPCFG_FDPE definition stays.

> Also can you look into the Sashiko found existing issue and fix it in
> a separate patch while you're at it?

I looked, and the buffer is initialized before hdr.sze is read.  hdr is a
stack object, so nvme_submit_sync_cmd() -> blk_rq_map_kern() takes the
bio_copy_kern() path: the pages come from
alloc_page(GFP_NOIO | __GFP_ZERO | gfp_mask), and
bio_copy_kern_endio_read() copies every bvec of the full length back into
hdr before the command returns.  A short transfer therefore leaves
zeroes, not stale stack.  There is nothing to fix, so no separate patch.

Thanks,
Shao

