Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6627CE9A02C
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Feb 2026 13:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3/1eXahlPCmpBagGZW1jaBzoCwXARswOYCuNJWq18r0=; b=GGJ1Ch+fVAMfBVYrPcGQ3MD9Co
	Y+c0u3Aro6OLumwUPlyuOn6V177WYe2UEum8CRrRwd+qFEJXwodNRCn5tu9wcOtBRRYJhCth2hikp
	BYKQyvpSwaIcSCTcdL1LUIVNU7Ol6380jJCobgcNqyhJx+Gpj18WnfRB8o5pcbBRYoC/CbH7GHHN3
	pOSPYYd/aNSZd7BvxZgaBjcEX+IMOfzGSGWfpEF6MgiDuCe+cwPgwMOaD//s6MdQyI8dQZlWd4kgX
	lj5C5YChYGTZdaKaFuIslRwpalgi5kd/K6oaW7cXiHERLhyUcYiwO/Jvfe2vzK6Bg499TajQvQYB3
	GB7Cdf4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vshbB-00000009shf-1Lhy;
	Wed, 18 Feb 2026 13:28:13 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vshb8-00000009sgl-0Wdq
	for linux-nvme@lists.infradead.org;
	Wed, 18 Feb 2026 13:28:11 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id 4281c428 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Feb 2026 14:28:03 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Feb 2026 14:28:03 +0100
Message-Id: <DGI4FR7YBCQ3.28N1YY210A3PA@arkamax.eu>
Cc: <kbusch@kernel.org>, <mheyne@amazon.de>, <emilne@redhat.com>,
 <jmeneghi@redhat.com>, <linux-nvme@lists.infradead.org>, <dwagner@suse.de>,
 <mlombard@bsdbackstore.eu>
Subject: Re: [PATCH RFC 4/5] nvme: add sysfs attribute to change IO timeout
 per nvme controller
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Mohamed Khalfella" <mkhalfella@purestorage.com>, "Maurizio Lombardi"
 <mlombard@redhat.com>
X-Mailer: aerc 0.21.0
References: <20260212120951.79738-1-mlombard@redhat.com>
 <20260212120951.79738-5-mlombard@redhat.com>
 <20260217202553.GJ3435530-mkhalfella@purestorage.com>
In-Reply-To: <20260217202553.GJ3435530-mkhalfella@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260218_052810_533561_7B6B74A2 
X-CRM114-Status: GOOD (  11.55  )
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

On Tue Feb 17, 2026 at 9:25 PM CET, Mohamed Khalfella wrote:
>> @@ -4169,6 +4169,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, =
struct nvme_ns_info *info)
>>  		mutex_unlock(&ctrl->namespaces_lock);
>>  		goto out_unlink_ns;
>>  	}
>> +	blk_queue_rq_timeout(ns->queue, ctrl->io_timeout);
>
> Given that io tagset->timeout has been initialized to ctrl->io_timeout
> Do we still need the line above?


Yes, the line is necessary. While the tagset is initialized with
ctrl->io_timeout, that happens only once during tagset allocation.

If the user later changes io_timeout via sysfs, ctrl->io_timeout is updated=
,
but the tagset->timeout remains at the old default value. I deliberately
do not update tagset->timeout in the sysfs handler because the tagset
lifetime is tied to the controller state (e.g., it may be freed during a
controller reset). Attempting to update the tagset from the sysfs path
introduces a race condition where we might dereference a pointer to
a tagset that is being destroyed.

Therefore, when a new namespace is allocated (nvme_alloc_ns), the block
layer initializes the queue using the stale tagset->timeout. We must
explicitly override that with the current ctrl->io_timeout to
ensure the new namespace respects the runtime configuration.

Maurizio



