Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E5D6EBFD21
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Apr 2026 09:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kxjVzw8V9Lcvz+NzEaiY0znxGfFm7EBWoqzTSE59sBQ=; b=xp9xc1DTb5Vj9i+dom7QlNm6dN
	RDfeYt/l0MPGsp6eMZS/eksfCRiThoDx82TpU16LiqEI9H4+prZs46OIswkijfsOQjqS1wVOh2aFH
	n08cUjXbSeQbEdnvuS7UmDqLcw8XrEqVslV+jztqyMecAa8HsSpFekAXbXfuNDcouWNoE6NmHaiYm
	G5iu2Sf1skkhhAVoai8jTpJB7gd+effCOpBlDso54+m8jRvYwVmnkqfZMGI4/qHfhOmdkxq+rCruk
	MY5e8AU5SxzkoMqZmpckNFA/e54hoz2d4/RSmNBEpoRE/UBFF1eiUggrYotuSNNgHx4aBT/W1Glvq
	oXnhp/+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCDUS-0000000FM2i-0yQ1;
	Mon, 13 Apr 2026 09:21:56 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCDUO-0000000FM1Z-0bKp
	for linux-nvme@lists.infradead.org;
	Mon, 13 Apr 2026 09:21:53 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id c11fd561 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Apr 2026 11:21:45 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Apr 2026 11:21:45 +0200
Message-Id: <DHRX0LGNILAX.LTFZVPDRLGOH@arkamax.eu>
Cc: <mheyne@amazon.de>, <emilne@redhat.com>, <jmeneghi@redhat.com>,
 <linux-nvme@lists.infradead.org>, <dwagner@suse.de>, <mlombard@arkamax.eu>,
 <mkhalfella@purestorage.com>, <chaitanyak@nvidia.com>, <hare@kernel.org>,
 <hch@lst.de>
Subject: Re: [PATCH V3 0/8] nvme: Refactor and expose per-controller timeout
 configuration
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Hannes Reinecke" <hare@suse.de>, "Maurizio Lombardi"
 <mlombard@redhat.com>, <kbusch@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260410073924.61078-1-mlombard@redhat.com>
 <e7a5ab7f-722e-4767-a9a6-2a1ae73bd8b7@suse.de>
In-Reply-To: <e7a5ab7f-722e-4767-a9a6-2a1ae73bd8b7@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260413_022152_579683_B205A747 
X-CRM114-Status: GOOD (  15.97  )
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

On Mon Apr 13, 2026 at 10:12 AM CEST, Hannes Reinecke wrote:
> On 4/10/26 09:39, Maurizio Lombardi wrote:
>> This patchset tries to address some limitations in how the NVMe driver h=
andles
>> command timeouts.
>> Currently, the driver relies heavily on global module parameters
>> (NVME_IO_TIMEOUT and NVME_ADMIN_TIMEOUT), making it difficult for users =
to
>> tune timeouts for specific controllers that may have very different
>> characteristics. Also, in some cases, manual changes to sysfs timeout va=
lues
>> are ignored by the driver logic.
>>=20
>> For example this patchset removes the unconditional timeout assignment i=
n
>> nvme_init_request. This allows the block layer to correctly apply the re=
quest
>> queue's timeout settings, ensuring that user-initiated changes via sysfs
>> are actually respected for all requests.
>>=20
>> It introduces new sysfs attributes (admin_timeout and io_timeout) to the=
 NVMe
>> controller. This allows users to configure distinct timeout requirements=
 for
>> different controllers rather than relying on global module parameters.
>>=20
> What about KATO?
> With this patchset the user can set arbitrary values to the I/O timeout,
> which easily can be lower than KATO.

it's worth noting that unless I am missing something the user can already
trigger this exact scenario today by setting an I/O timeout lower than KATO=
,
using the global nvme_io_timeout module parameter.=20

> And as per spec a KATO timeout implies a transport disruption, requiring
> a controller reset.
> But due to the internal design of the nvme error handling we do conflate
> transport disruption and command timeout, so an _I/O_ timeout triggers
> a controller reset.

this is true only for TCP and RDMA host drivers,
because PCI and FC already support I/O aborts.

Apple doesn't support abort, but it's not clear in the comments if it's
the driver that lacks support for it or it's the controller that
doesn't handle the abort command.

> Which means that a command timeout lower than KATO will result in false
> positives, with the controller being reset even though the connection
> is perfectly happy.

Right.

We could try to send abort commands in RDMA and TCP host drivers timeout ha=
ndlers.
Maybe cancel, if supported, and falling back to abort if cancel
commands are not available. I already had patches for this kind of
stuff.

Maurizio

