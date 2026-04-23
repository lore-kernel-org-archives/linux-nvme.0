Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD3BFDEE3F
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Apr 2026 18:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:
	Subject:Cc:To:From:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9TEYGznWHi20tgJwP5nPqzlDlM+Vd4kQBXcIhq8hWqs=; b=W1sj0EIRvGkAnHQRLV2yZii9xY
	qTaoVeLRuJjPy+PISmSoFqXNd6OO+NLTLsaqdoUmgMxjwnMgNpA+wEMgYrWoGuQBzNNElixwSZxzY
	+FZxUnhdBTn/ngQbcitGo1cP6AcghNru4HfGeECngmslgFh2Q8Pv7OjAElIpM1LS4YHiOb7nFVgFg
	sCTTLSRKQpadTkjMiIaFQJhOGSrFdzkb7DkgoY3UKJMhPXp0fwN0nkDuN1ybTvyDy6qB6RMpMj5EV
	8tfNQcPHSh0NoWo6zwvBta+8uy+qxPfb1FwDt1IooBHu7MC9fiCMsinjDVofaK1JrzwAo1iFsh7BQ
	PxT4/uMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFytX-0000000C7sb-3Ec9;
	Thu, 23 Apr 2026 18:35:23 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFytV-0000000C7qZ-0IRX
	for linux-nvme@lists.infradead.org;
	Thu, 23 Apr 2026 18:35:22 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 947b07c5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 23 Apr 2026 20:35:18 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Apr 2026 20:35:18 +0200
Message-Id: <DI0R1V67MWR5.BZJQCCDV0XJN@arkamax.eu>
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Daniel Wagner" <dwagner@suse.de>, "Maurizio Lombardi"
 <mlombard@arkamax.eu>
Cc: "Maurizio Lombardi" <mlombard@redhat.com>, <kbusch@kernel.org>,
 <mheyne@amazon.de>, <emilne@redhat.com>, <jmeneghi@redhat.com>,
 <linux-nvme@lists.infradead.org>, <mkhalfella@purestorage.com>,
 <chaitanyak@nvidia.com>, <hare@kernel.org>, <hch@lst.de>
Subject: Re: [PATCH V3 2/8] nvme: add sysfs attribute to change admin
 timeout per nvme controller
X-Mailer: aerc 0.21.0
References: <20260410073924.61078-1-mlombard@redhat.com>
 <20260410073924.61078-3-mlombard@redhat.com>
 <a3171007-7cfb-45b0-b0bf-01dcc7ba51ab@flourine.local>
 <DHZMXEY4JPEF.1HHTTEZPN53ZU@arkamax.eu>
 <e99f2ce9-e47a-432a-b6ea-795081de1f4d@flourine.local>
 <DI0JVXM1ZKET.3S7JP55JIPFHH@arkamax.eu>
 <ad70df1f-46e9-48ee-b5af-f6c1bb0c4e70@flourine.local>
In-Reply-To: <ad70df1f-46e9-48ee-b5af-f6c1bb0c4e70@flourine.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260423_113521_444983_9138EEDE 
X-CRM114-Status: GOOD (  14.37  )
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

On Thu Apr 23, 2026 at 7:04 PM CEST, Daniel Wagner wrote:
> On Thu, Apr 23, 2026 at 02:58:25PM +0200, Maurizio Lombardi wrote:
>> >> if the NVME_CTRL_STARTED_ONCE bit is set, we know that the
>> >> initialization has been completed and that admin_q and fabrics_q will
>> >> exist until the controller will be torn down.
>> >
>> > Yes, that is all fine but I think it would be good to be able to use
>> > udev here as we have it other timeouts.
>>=20
>> Ok I understand, what do you think if we swap the order in
>> nvme_start_ctrl() so the flag is set before userspace is notified?
>>=20
>> set_bit(NVME_CTRL_STARTED_ONCE, &ctrl->flags);
>> nvme_change_uevent(ctrl, "NVME_EVENT=3Dconnected");
>
> I doesn't look like there is anything else depending on this order. So
> yes, that would make this race go away.


Noted, I will fix it in the next version.

Thanks,
Maurizio


