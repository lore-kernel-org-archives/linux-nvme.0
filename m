Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 991E1C4167B
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Dec 2023 04:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GE/J6CSM/3/jnl4mjE8uCZ2wJhjtMdmOt0LyLUgEpkU=; b=viZDJRTB6YYcIlnTeoVLUvcfvf
	YnDGLm/PI5ajTk79ZX5RkOUShz2CKccFMeaoPylCr0+WXz2yn2dhD/hfQHUjGEzwlDTorjKsQeSyd
	G5DH1mLGR2ISyYCYW5hTIGDbZLS4FHYk0upgP4yzlcijOvlZZ49yXCTek7JZbUyQ/mM32Vp/mgBZK
	FY6NbV6kgQAFjomJB3AV+zHceRv/0lfD149oDpuoPwIBxwkKMdbMzFf+PnSTfeyv5QqwONMhYW0TM
	E9hl0kb8zcD8cvYuSfSJ4kRGTX9Djfwy+aoJy0tAgvsch0GhOdbv0BxP3oQs4oA/wIa9bIhR/sgdu
	z5u2z6sA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rANCA-006EmX-0X;
	Tue, 05 Dec 2023 04:38:06 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rANC6-006Em5-2W
	for linux-nvme@lists.infradead.org;
	Tue, 05 Dec 2023 04:38:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 3CF58CE166B;
	Tue,  5 Dec 2023 04:38:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC530C433C8;
	Tue,  5 Dec 2023 04:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701751079;
	bh=KnCC35HVuK9trGrG8jMgcYkQhNFaYUM92vgPwH7g/9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tKKmPp4OOg8PqeiUtyXEm6I/nIOoUfooAQ8yyU8PO49ZtQNSGn4+mtqGZALeLuDHO
	 mUydTuuhIo8VeIOtEsEEU4gCb5Fwhn8qVKUDcZ0Si6UeMk0tQrLEUtGJM/NF/hqmln
	 tqv525HdMlk4+ACFhN0TXdRFqx6zbhz2nCSOSQuS2rFydtleeD9rHlysRoFQIAH4tC
	 zuX8nfponY4wSF59UUbFllplFZ/mUkcDgOnxPKYkD1ycvad48L5rhGsLSRUf7Rz0Av
	 vJF0KIzsgsFMPYSgkqx7l54R1KsEPC1fg4CG4Hr+YIV3xbkYAebDKe25/rk/cLWsLT
	 WU/2duiXBWw8A==
Date: Mon, 4 Dec 2023 21:37:56 -0700
From: Keith Busch <kbusch@kernel.org>
To: Jirong Feng <jirong.feng@easystack.cn>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	peng.xiao@easystack.cn
Subject: Re: Should NVME_SC_INVALID_NS be translated to BLK_STS_IOERR instead
 of BLK_STS_NOTSUPP so that multipath(both native and dm) can failover on the
 failure?
Message-ID: <ZW6pJAm9wgqj1HEW@kbusch-mbp>
References: <9b1589fb-6f47-40bb-8aa6-22ae61145de4@easystack.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b1589fb-6f47-40bb-8aa6-22ae61145de4@easystack.cn>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_203803_015143_409861BE 
X-CRM114-Status: GOOD (  20.04  )
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

On Mon, Dec 04, 2023 at 03:58:14PM +0800, Jirong Feng wrote:
> Hi all,
> 
> I have two storage servers, each of which has an NVMe SSD. Recently I'm
> trying nvmet-tcp with DRBD, steps are:
> 1. Configure DRBD for the two SSDs in two-primary mode, so that each server
> can accept IO on DRBD device.
> 2. On each server, add the corresponding DRBD device to nvmet subsystem with
> same device uuid, so that multipath on the host side can group them into one
> device(My fabric type is tcp).
> 3. On client host, nvme discover & connect the both servers, making sure DM
> multipath device is generated, and both paths are online.
> 4. Execute fio randread on DM device continuously.
> 5. On the server whose multipath status is active, under nvmet namespace
> configfs directory, execute "echo 0 > enable" to disable the namespace.
> what I expect is that IO can be automatically retried and switched to the
> other storage server by multipath, fio goes on. But actually I see an
> "Operation not supported" error, and fio fails and stops. I've also tried
> iSCSI target, after I delete mapped lun from acl, fio continues running
> without any error.
> 
> My kernel version is 4.18.0-147.5.1(rhel 8.1). After checked out the kernel
> code, I found that:
> 1. On target side, nvmet returns NVME_SC_INVALID_NS to host due to namespace
> not found.

So the controller through that path used to be able to access the
Namespace, then suddenly lost ability to do so, but some other path can
still access it if we retry on a failover/alternate path? I think your
target is returning the wrong error code. It should be SCT/SC 303h,
Asymmetric Access Persistent Loss (NVME_SC_ANA_TRANSITION), for what
you're describing.

