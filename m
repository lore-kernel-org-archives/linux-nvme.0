Return-Path: <SRS0=lXTb=XH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4589EC5ACAE
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2019 03:31:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17A48207FC
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2019 03:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DfGHI0Kn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oW/SS++l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17A48207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9ZWQsw+EamuTDnCw2CN36Eqk5GLzRWsx4I/lG4En8d0=; b=DfGHI0KnweIO5Q
	z3bodJKdqOyMzyAMW2lQsqfisbXu8mfaBcYRfTYjD3r3YvBRDJzkIHkVSx8V3MM4NcLBJfhNihTl2
	6L5GVdhaOqd2bQTe3MNz552UVZHKi1pp1Z2SJpDlq6bzd3ExR/ODwcYiTJhHJiSBwyTwKakbqvbV7
	vYg15JnZ05zz2QXRbFxPAQXPqvW2lV/fNrFbDnEnRhRUVNXyjb2VqPeayXejNOISiN7CHn/V52Ye1
	hNQNoPEOdXhiCHx+0MtAQy2NNLnwPygOPBBdFKF9tpPpKeK8JP3kQJP8NmdJThnBLAL8+X0mgzG+Y
	CSEQ8PNnaU+GGdxWyOuA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1i8FpC-0006zg-5u; Thu, 12 Sep 2019 03:31:14 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i8Fp9-0006zH-4q
 for linux-nvme@lists.infradead.org; Thu, 12 Sep 2019 03:31:12 +0000
Received: from keith-busch (unknown [8.36.226.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E718A207FC;
 Thu, 12 Sep 2019 03:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1568259070;
 bh=vED/K0chXApjPCKYoryEgRFi0Kavo1Fx1q+/gKBe7l4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oW/SS++lnb0AL1ioHDf5Rj4R2+BrbV17h8w4SBmtxliP2eJSmRgt1FCFdereugUHh
 YTrP0Nmx8k6ewKiUW8oXcUkVYHn3jg3OlTYC3z6Bnp+/ZkPLzE8SC1TZ9MWpGUOJo3
 EJJwcf28ou2BZ6gpiGtFN12T/yJv8qSVDGj2Jhqk=
Date: Wed, 11 Sep 2019 21:31:07 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: panic in pci driver
Message-ID: <20190912033106.GA5820@keith-busch>
References: <a1242213-47f1-ffa1-d71a-1b0abb1e1049@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a1242213-47f1-ffa1-d71a-1b0abb1e1049@grimberg.me>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190911_203111_210587_C25B7A4F 
X-CRM114-Status: GOOD (  10.46  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <keith.busch@intel.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Sep 11, 2019 at 11:46:19AM -0700, Sagi Grimberg wrote:
> Just hit the following bug on a simple test case with Qemu nvme emulation:
> 
> for i in `seq 100`; do echo 1 >
> /sys/devices/pci0000\:00/0000\:00\:0a.0/remove; echo 1 >
> /sys/bus/pci/rescan; done
> 
> Keith, is that addressed by your series with the reset_prepare stuff?

No, but this one fixes it, in rc5 (you're running rc3)

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=bd46a90634302bfe791e93ad5496f98f165f7ae0

> 5.3.0-rc3+ #325

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
