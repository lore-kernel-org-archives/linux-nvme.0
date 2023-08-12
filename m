Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62AF9C04A6A
	for <linux-nvme@archiver.kernel.org>; Sat, 12 Aug 2023 05:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oISa8d6yK8KUGdVyQrBIXRWJ0VgXOKcHW1RvvSCvhcY=; b=d8ClXoerLLvNRlNrp+cm7AGtIU
	hP6v2ScRly4MHY7ANNzEo29pOLHzW+jh7fzFD7zZakNbbTEO0f+m3D/krYwe88BTf3JcO8bTyyc7b
	fbsQ46/JA+xEKnB5mFL9ySWillx2XznmsdwpuRK2rRERgewwxadiH9LB6pOSgMeeizMqwQYiL+I5o
	2y2aaOVJCq83WaYQnpSYNNa7wxL2pzNxIIddWVXEqVqHZqOW4QVl3GBN+ZZwb28+vbXauG4tQUBXs
	SCk96xnmi5jYRwTlweJYtUXZ7MJRXZu5r1rLpVEQClDaYEp6nWVMtRRMIY3AOzVD+2zJ6GL4wfav9
	QDC62aug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qUhcm-00Cjj9-1d;
	Sat, 12 Aug 2023 05:57:20 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qUhcj-00Cjif-0a
	for linux-nvme@lists.infradead.org;
	Sat, 12 Aug 2023 05:57:18 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 73BEF64273;
	Sat, 12 Aug 2023 05:57:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87FE9C433C7;
	Sat, 12 Aug 2023 05:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1691819834;
	bh=uZAQzoFipmUZFtQmE1dYQ0dK9Re2VCDZAO2Fa835pA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vYEDECX3e+qlIBCjFXTFoSXjDWaaE3HBOjxoaqJdu6VtlSmIxpWiGua1+T8qOcdzY
	 pO6pRKDpltvo/7GsGENkwomPvYHIOodRH6i48t8iZQd8T/y03ueN3e2yH4W6tT/Ug6
	 DPYuEpoM7flDE9oQ8I42t41AsaFvymolriNXb46A=
Date: Sat, 12 Aug 2023 07:57:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: August Wikerfors <git@augustwikerfors.se>
Cc: stable@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	axboe@fb.com, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, nilskruse97@gmail.com,
	David.Chang@amd.com
Subject: Re: [PATCH] nvme: Don't fail to resume if NSIDs change
Message-ID: <2023081258-marital-idly-e4da@gregkh>
References: <ZMgHE2wu4T4OfrTR@kbusch-mbp>
 <040c5788-1a7b-26ea-23cc-ba239c76efa9@augustwikerfors.se>
 <39697f68-9dc8-7692-7210-b75cce32c6ce@amd.com>
 <20230731201047.GA14034@lst.de>
 <36319a0f-34a6-9353-bc52-4d4d0fac27a5@amd.com>
 <20230801112403.GA3972@lst.de>
 <ae7fb9b2-d692-f9b8-5130-4555cc489846@amd.com>
 <ZMlrGNw5OMW3yxId@kbusch-mbp.dhcp.thefacebook.com>
 <b2e741b3-b581-40fe-2c28-e4660f52003d@amd.com>
 <0f422dbe-2e3f-4401-be87-2963cbbc1234@augustwikerfors.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f422dbe-2e3f-4401-be87-2963cbbc1234@augustwikerfors.se>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230811_225717_276847_FF7D8A0E 
X-CRM114-Status: GOOD (  10.68  )
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

On Fri, Aug 11, 2023 at 10:19:35PM +0200, August Wikerfors wrote:
> On 2023-08-01 22:34, Mario Limonciello wrote:
> > If you can still change it before sending out can you add a stable tag
> > as well?
> 
> This didn't get added in time, so, stable team, please backport:
> 
> 688b419c57c1 ("nvme-pci: add NVME_QUIRK_BOGUS_NID for Samsung PM9B1 256G and 512G")

Now queued up to 6.4.y and 6.1.y, thanks.

greg k-h

