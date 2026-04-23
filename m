Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 156F6F589C4
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Apr 2026 12:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mMY7vB3wjhwPzdKyWSfFOamrtD4JF98k0PSX43qfES4=; b=0bNBtD1hr3/CMW5hkZ4JjmTN4X
	d//PD+6/5Cb9SBnEqsQ00CX42OQhnsaAsYHGXH2rkIaHAgWtqIv0I12ASy/ZyHK/99nBL8F1+W8y7
	vdZNzsqBumoUjZ+leylr6fSrG50bDV5TeGhTqnr3KRr9N1TKrVOdp6bKggkDCHVqqJb1KWliNe3PR
	eWByw1kNGOnX8Hlsd6ZJi4XfP/FrktBqYFmTS3k+pUShVzj562D6xcTjFqn1magRj4HiQRWDHdY/R
	RfAo0Ax9Gp7tTLwu2HtkvFU1AXKZjxkSI+zXJuvENKohP/HIh/jtPx8PullwajPo+p9kNXXPlPxYv
	dbonoNHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFtda-0000000Bhti-3AYC;
	Thu, 23 Apr 2026 12:58:34 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFtdY-0000000Bhse-0HCH
	for linux-nvme@lists.infradead.org;
	Thu, 23 Apr 2026 12:58:33 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 625db35c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 23 Apr 2026 14:58:25 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Apr 2026 14:58:25 +0200
Message-Id: <DI0JVXM1ZKET.3S7JP55JIPFHH@arkamax.eu>
Cc: "Maurizio Lombardi" <mlombard@redhat.com>, <kbusch@kernel.org>,
 <mheyne@amazon.de>, <emilne@redhat.com>, <jmeneghi@redhat.com>,
 <linux-nvme@lists.infradead.org>, <mkhalfella@purestorage.com>,
 <chaitanyak@nvidia.com>, <hare@kernel.org>, <hch@lst.de>
Subject: Re: [PATCH V3 2/8] nvme: add sysfs attribute to change admin
 timeout per nvme controller
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Daniel Wagner" <dwagner@suse.de>, "Maurizio Lombardi"
 <mlombard@arkamax.eu>
X-Mailer: aerc 0.21.0
References: <20260410073924.61078-1-mlombard@redhat.com>
 <20260410073924.61078-3-mlombard@redhat.com>
 <a3171007-7cfb-45b0-b0bf-01dcc7ba51ab@flourine.local>
 <DHZMXEY4JPEF.1HHTTEZPN53ZU@arkamax.eu>
 <e99f2ce9-e47a-432a-b6ea-795081de1f4d@flourine.local>
In-Reply-To: <e99f2ce9-e47a-432a-b6ea-795081de1f4d@flourine.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260423_055832_443964_C5DE65E9 
X-CRM114-Status: GOOD (  18.73  )
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

On Thu Apr 23, 2026 at 2:46 PM CEST, Daniel Wagner wrote:
> On Wed, Apr 22, 2026 at 01:08:44PM +0200, Maurizio Lombardi wrote:
>> On Wed Apr 22, 2026 at 12:10 PM CEST, Daniel Wagner wrote:
>> > On Fri, Apr 10, 2026 at 09:39:18AM +0200, Maurizio Lombardi wrote:
>> >> +	/*
>> >> +	 * Wait until the controller reaches the LIVE state
>> >> +	 * to be sure that admin_q and fabrics_q are
>> >> +	 * properly initialized.
>> >> +	 */
>> >> +	if (!test_bit(NVME_CTRL_STARTED_ONCE, &ctrl->flags))
>> >> +		return -EBUSY;
>> >
>> > I assume the idea is to use an udev rule to set the value. Though I
>> > think this is racy:
>> >
>> > 	nvme_change_uevent(ctrl, "NVME_EVENT=3Dconnected");
>> > 	set_bit(NVME_CTRL_STARTED_ONCE, &ctrl->flags);
>>=20
>>=20
>> Not really, the idea was about to prevent the user from setting the
>> timeouts too early during the controller's initialization.
>
> Yes, but then how do you know when is too early? Do you read/poll the
> state of the controller?=20
>
>> Otherwise the user could try to change the timeout while
>> admin_q and fabrics_q are still being created.
>>=20
>> if the NVME_CTRL_STARTED_ONCE bit is set, we know that the
>> initialization has been completed and that admin_q and fabrics_q will
>> exist until the controller will be torn down.
>
> Yes, that is all fine but I think it would be good to be able to use
> udev here as we have it other timeouts.

Ok I understand, what do you think if we swap the order in
nvme_start_ctrl() so the flag is set before userspace is notified?

set_bit(NVME_CTRL_STARTED_ONCE, &ctrl->flags);
nvme_change_uevent(ctrl, "NVME_EVENT=3Dconnected");

Maurizio


