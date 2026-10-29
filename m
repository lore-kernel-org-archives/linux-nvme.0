Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14CD606A322
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 12:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=UtXDvJeW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=kE/aup/iAkKSyqA1EGcSzojt0yBgl10lJYtlTnXTIYM=; b=UtXDvJeWj0ScuDdfhXZXGtz3am
	p+JUwZn+KSB/Tpiqf21nMdZbSo9Vvkb5ZhjK8Q47vCpa89nuUklHoSqvIZ6kejmHTgSVcKK+FXo11
	U9YMD5av+dc4gGGll3DLZPax8LPYM6mGr1tG/bqvroRStSQzdnpD9AC2kapSJ5ay5c1mUMh/yKhnA
	rD7ptTtbMwUKWiAJjVbpJP5LEVAmV6Pw+Fx93TVA7JQRENaJ0Lj4lUvKrRRByR69iVQub6+eJwyuv
	vadfrVQ52V/SfbbBoknV35ltqa9ExouN3Mwr0l6fp3eFjus/81r5//gYw44ldzIOaQfHOm0WN+8Yf
	+1Jlk7mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMPEU-000000098vC-2Y3C;
	Thu, 29 Oct 2026 12:27:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMPER-000000098uF-2r4m
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 12:27:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 00C3E68D07; Thu, 29 Oct 2026 13:27:41 +0100 (CET)
Date: Thu, 29 Oct 2026 13:27:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Kyle Bader <kbader@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Kyle Bader <kbader@ibm.com>, Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Tushar Gohad <tushar.gohad@intel.com>, linux-block@vger.kernel.org,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: only fail dma-buf bios that need block layer PI
Message-ID: <20261029122741.GB25162@lst.de>
References: <20261028181412.1919506-1-kbader@redhat.com> <134aa376-7441-46e1-8d04-be327747b4a9@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <134aa376-7441-46e1-8d04-be327747b4a9@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_052747_874996_E0F5AF48 
X-CRM114-Status: GOOD (  16.10  )
X-Spam-Score: -1.9 (-)
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
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 11:51:31AM +0000, Pavel Begunkov wrote:
> Thanks, looks good from a quick glance, I'll take another look in
> a bit. It might be nice to somehow support kernel generated PI
> as well later, looks like there will be a good bunch of cases that
> might want to have CPU access.

I don't think the kernel auto-PI makes sense for P2P.  The data lives
on a remote device, so generating PI for it would have to transfer
the data to the host.  Instead we probably should just force PRACT
for that case.  It would make sense to support PI generation for
dmabufs using local memory, though.

