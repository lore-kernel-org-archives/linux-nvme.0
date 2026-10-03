Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25692CA5FEC
	for <linux-nvme@archiver.kernel.org>; Sat,  3 Oct 2026 13:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TyfxVXOoBof91OwTiEmFt4WF3sFAvG5dlDx8dAIQTxM=; b=IAswF+RbG/su0XGgelfVmsHVSO
	CKzxR6jl3HEKGvgfZLYnoW+M1HzQ67ONatmZdLcGHBMuiAqnCjBG1TUMzHY9lmTcNI3Y7QlByAfda
	KFOnn+wZ/hK1pO5tR3kxFbZ6k+phYEZzVbCJcURQCtKN3bv7+DqjAd3wEaGv0eUWSn1XPUEpexccK
	6zvI1n4J8g0pQN/nassmIw3hGmi+lIYH6dshcYhu28mUelpw7kToXaf8egSwj8Aet0Ogzm+wGixhF
	9Fv3bFSb9Ur/bgyJyEd2rbp6MSmR+jZfYHzs4BHYAZIMPBIzMJ5GcPnxMn0M00Aemi+uPOQXBWd7h
	cC7H8mGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCzUy-0000000DWL3-3I3V;
	Sat, 03 Oct 2026 13:09:56 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCzUw-0000000DWKQ-05LI
	for linux-nvme@lists.infradead.org;
	Sat, 03 Oct 2026 13:09:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=TyfxVXOoBof91O
	wTiEmFt4WF3sFAvG5dlDx8dAIQTxM=; h=in-reply-to:references:to:from:
	subject:cc:date; d=arkamax.eu; b=IXot2zbv+fNlaVGZ8rueQ55Zcdpn4wV3EmL6W
	hg1TvcmSmToi3RA9ach7MMkJohxESdpSsFtKpml8eZcgUj8xj4nEKpL0nkJEKnbkotocvV
	X+dYTYLSt8ANB/nmNkjGapBwOKdPQ7f0RtAPhtw/Dlq6ZIXzKMpw5AkAUAu1aALVODFmaG
	pwsEsceDlFs1bqgfEUOrkpQL6/ZiskNqVyO2N+A8XlGOiTy40xRhOxzAv3o7YSZHL1UFMX
	tKE6xipSJXXuNEvtZd1xun/u68JpgwJcTmyfXZCKNmIr4YYnn51DtqTzgUDrYO+SYUfC20
	bibCT6hfKDJv6LC+0yAgjp4Lg==
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id f2ea9b1a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 3 Oct 2026 15:09:51 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 03 Oct 2026 15:09:51 +0200
Message-Id: <DLV87HMYWE6U.BG10862VYDK@arkamax.eu>
Cc: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <hare@suse.de>,
 <dwagner@suse.de>, <asahi@lists.linux.dev>, "Sven Peter" <sven@kernel.org>
Subject: Re: [PATCH] nvme: do not reset controllers in NVME_CTRL_NEW state
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Maurizio Lombardi" <mlombard@arkamax.eu>, "Yureka Lilian"
 <yureka@cyberchaos.dev>, "Maurizio Lombardi" <mlombard@redhat.com>,
 <kbusch@kernel.org>
X-Mailer: aerc 0.22.0
References: <20260915095827.698928-1-mlombard@redhat.com>
 <94912d46-381d-4988-800a-6ef3b595233f@cyberchaos.dev>
 <DLV7F9W5HSFS.1D5WQW59ZEHEL@arkamax.eu>
In-Reply-To: <DLV7F9W5HSFS.1D5WQW59ZEHEL@arkamax.eu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261003_060954_411098_4F4708FA 
X-CRM114-Status: UNSURE (   7.90  )
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

On Sat Oct 3, 2026 at 2:33 PM CEST, Maurizio Lombardi wrote:
> Thanks for reporting this,
> it seems that nvme-apple is the only driver that still initializes the
> controller by performing a reset directly from a NEW state.
>
> This should be easy to fix by moving the state to CONNECTING in
> apple_nvme_probe, just before nvme_reset_ctrl() is called.

Ops, this won't work, as we can enter the resetting state only when the
controller is live.

Keith, I think we have no other option but revert this patch to unbreak
apple-nvme until I find a proper fix.

Maurizio

