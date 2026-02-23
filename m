Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3847FE63C8B
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Feb 2026 10:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VM4egV706YBIeNxCp2+0uiBFD2cw8ReQidhE5I5Vh8g=; b=PQW9qzFKCxnIzdOWfYBAODG343
	awh4fASWG3qlcTPV4/KFwki2G9m5cm/82wxCKDucH86jdOMLubZLhRKh4plsyGduqk2/Udjv2AAIq
	o6VrwS9AmmbW7kCABbzkbu2rw+u1SGKzmBfodR5FU9OyRsiTzNutwSQoSzdjFM2ffi13q07iqlUyi
	y3pE6SsmEURqpS561E5McRuPrHfCFgmA7eWO8fcBbOILDfybkeWrQT291KHh7GaV3xfWr15DohrIF
	IJnrhXMGtvyr3RurbzatCVCrGqP3GpgMc8XZmluHgXsdFsRl41HRibWKpE6HA/VW5KsYw63oes0Ma
	Z2GzEZcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuTOw-000000004on-1zaY;
	Mon, 23 Feb 2026 10:42:54 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuTOt-000000004oN-46Q5
	for linux-nvme@lists.infradead.org;
	Mon, 23 Feb 2026 10:42:53 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id a4f82591 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Feb 2026 11:36:09 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Feb 2026 11:36:07 +0100
Message-Id: <DGM9WUGICE31.3UDKXWISDQW4G@arkamax.eu>
Cc: "Maurizio Lombardi" <mlombard@redhat.com>, <kbusch@kernel.org>,
 <mheyne@amazon.de>, <emilne@redhat.com>, <jmeneghi@redhat.com>,
 <linux-nvme@lists.infradead.org>, <dwagner@suse.de>,
 <mlombard@bsdbackstore.eu>
Subject: Re: [PATCH RFC 4/5] nvme: add sysfs attribute to change IO timeout
 per nvme controller
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Mohamed Khalfella" <mkhalfella@purestorage.com>, "Maurizio Lombardi"
 <mlombard@arkamax.eu>
X-Mailer: aerc 0.21.0
References: <20260212120951.79738-1-mlombard@redhat.com>
 <20260212120951.79738-5-mlombard@redhat.com>
 <20260217202553.GJ3435530-mkhalfella@purestorage.com>
 <DGI4FR7YBCQ3.28N1YY210A3PA@arkamax.eu>
 <20260218175452.GK2392949-mkhalfella@purestorage.com>
 <DGJ42477U84O.MIIO0U7J75II@arkamax.eu>
 <DGJSTIHMGMV2.316EK4AH62YKU@arkamax.eu>
 <20260220175323.GL3435530-mkhalfella@purestorage.com>
In-Reply-To: <20260220175323.GL3435530-mkhalfella@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260223_024252_367209_2B22DEDA 
X-CRM114-Status: GOOD (  18.21  )
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

On Fri Feb 20, 2026 at 6:53 PM CET, Mohamed Khalfella wrote:
> On Fri 2026-02-20 13:47:08 +0100, Maurizio Lombardi wrote:
>> On Thu Feb 19, 2026 at 6:22 PM CET, Maurizio Lombardi wrote:
>> > On Wed Feb 18, 2026 at 6:54 PM CET, Mohamed Khalfella wrote:
>> >
>> > So changing the timeout field in the tagset should be doable, the
>> > only problem is avoid racing against nvme_alloc_ns().
>> >
>> > I will try to come up with something.
>>=20
>> I decided to keep the current design, calling blk_queue_rq_timeout()
>> with the namespaces_lock mutex locked is the easiest solution
>>=20
>> I am sending a V2 in a few moments.
>>=20
>
> How about restricting changing io timeout to LIVE controllers only. This
> will make the problem easier to solve. Maybe something like the below?
>
> 	enum nvme_ctrl_state state;
> 	unsigned long flags;
>
>         spin_lock_irqsave(&ctrl->lock, flags);
> 	state =3D nvme_ctrl_state(ctrl);
> 	if (state !=3D NVME_CTRL_LIVE) {
> 		spin_unlock_irqrestore(&ctrl->lock, flags);
> 		return -EBUSY
> 	}

I previously considered this solution, but I discarded it for two reasons:

1) If the user sets the io_timeout too low, the controller ends up
resetting non-stop. With this patch, it becomes hard to catch the
controller in a LIVE state and fix the problem, because the controller is
almost always RESETTING. You essentially have to wait until the driver
gives up and removes the controller.

2) This doesn't prevent nvme_alloc_ns() from racing against the sysfs
path.
Suppose that thread A is executing nvme_alloc_ns() and has just called
disk =3D blk_mq_alloc_disk(ctrl->tagset, &lim, ns);

immediately after, the user changes io_timeout. Thread B takes the
namespaces_lock, scans the namespaces list and calls
blk_queue_rq_timeout() on each namespaces' queues.

thread A now can take the namespaces_lock and adds the new namespace to
the list, but the problem is that the new namespace is using the stale
timeout setting it inherited from ctrl->tagset.

Maurizio

>
> 	if (ctrl->queue_count > 1)
> 		WRITE_ONCE(ctrl->tagset->timeout, timeout);
> 	spin_unlock_irqrestore(&ctrl->lock, flags);
>
> 	/* Take the namespaces_lock to avoid racing against nvme_alloc_ns() */
> 	mutex_lock(&ctrl->namespaces_lock);
>
> 	ctrl->io_timeout =3D msecs_to_jiffies(timeout);
> 	list_for_each_entry(ns, &ctrl->namespaces, list)
> 		blk_queue_rq_timeout(ns->queue, ctrl->io_timeout);
>
> 	mutex_unlock(&ctrl->namespaces_lock);
>
>
>> Maurizio
>>=20


