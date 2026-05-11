Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66EADCD37AC
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 11:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To
	:From:Subject:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TFb3hTiZZJrgQ8Oektnr4uo1mZRd6hDQkQ3KuxK1Bo8=; b=TNGmlvVdouyMeZXNt/qIQjaBq6
	Vb8LpMq32cy/ezN01e/IasV6fJYPeX18DvXAQIUHovafRk3QVByYXPljDa1AIj4T1ffKZTqtBwzar
	43XWj3zG5rKdohgjPzdinihKNNiPJhz/IEznvoexgApeKHWPW4NsEekuHGLdc961mTh/2U4BJOKdv
	GmBAqpc3pRT2oFl5YbWEoUWnsIu1Jvbf37L8q/xDgOzlVbdoDkyLlYVLZfWtFzbV/XCBq2MwO+472
	pAkzevmKNCzNGBGf225DxlNAu1vaXyoXE6VASVo7j/wh7UYpCXi/hZ/Z0FWPva57wIy9CFaJHwJW6
	5Bd96jAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMP2C-0000000DN3E-2Foo;
	Mon, 11 May 2026 11:42:52 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMP2A-0000000DN2J-04bB
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 11:42:51 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 05fc103b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 May 2026 13:42:48 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 May 2026 13:42:47 +0200
Message-Id: <DIFTJU624OOA.3TZPJSC4SF1CC@arkamax.eu>
Subject: Re: [PATCH V4 6/9] nvme: use per controller timeout waits over
 depending on global default
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Christoph Hellwig" <hch@lst.de>, "Maurizio Lombardi"
 <mlombard@redhat.com>
Cc: <kbusch@kernel.org>, <mheyne@amazon.de>, <emilne@redhat.com>,
 <jmeneghi@redhat.com>, <linux-nvme@lists.infradead.org>, <dwagner@suse.de>,
 <mlombard@arkamax.eu>, <mkhalfella@purestorage.com>,
 <chaitanyak@nvidia.com>, <hare@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260508133335.98612-1-mlombard@redhat.com>
 <20260508133335.98612-7-mlombard@redhat.com>
 <20260511081040.GF29677@lst.de>
In-Reply-To: <20260511081040.GF29677@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_044250_397414_A3D96224 
X-CRM114-Status: UNSURE (   8.07  )
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

On Mon May 11, 2026 at 10:10 AM CEST, Christoph Hellwig wrote:
> On Fri, May 08, 2026 at 03:33:32PM +0200, Maurizio Lombardi wrote:
>> Instead of passing NVME_IO_TIMEOUT as a parameter with every call to
>> nvme_wait_freeze_timeout, use the controller's preferred timeout.
>
> This should probably go very early in the series before even adding
> configurable timeouts as it just drops a pointless paramter.

It drops the parameter but uses the timeout value stored in
ctrl->io_timeout, so it actually depends on the patch introducing
the per-controller io_timeout.

Maurizio

