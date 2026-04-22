Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F5CF9B61E
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Apr 2026 11:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:From:
	Subject:Cc:To:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ABNlbDidDi8EqUYgi78tvXxGspU4jAenMv/vcMszMYs=; b=gd9O5MPT/GoYdb2yRja6oqrzBn
	Ym/nNzNIONXEyQZhwgU04ZYuN5xZGaoeic4IgFq2CsnqHbihWpK39t2+eeS38ibIUxOX1VcVr3Anq
	vwaAAQCcOg7al2Mpq56Gay0JbkDnkLcOOCbodLcjuowYkHc/AZmngGBhpsFzONJaLRlFO1KBmCj/I
	1ZCzvCWd9ztiN/4pRjJozyrKhmPMWuQehjXsPIjprjTOP0DKgxccGXWQYwjmyTm7Ktf+mD2h4VAva
	ZFWQutjrf1JGb/3UQyN5gfa4cucczFV6jF6QzeW0KO5NvpLgk2fDINKoCrqP6iVrxzOtmwIyvDtKu
	CgS7K7Rw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFVRv-00000009yq1-3MX3;
	Wed, 22 Apr 2026 11:08:55 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFVRs-00000009ypD-3LgI
	for linux-nvme@lists.infradead.org;
	Wed, 22 Apr 2026 11:08:54 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id e56a410f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 Apr 2026 13:08:45 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Apr 2026 13:08:44 +0200
Message-Id: <DHZMXEY4JPEF.1HHTTEZPN53ZU@arkamax.eu>
To: "Daniel Wagner" <dwagner@suse.de>, "Maurizio Lombardi"
 <mlombard@redhat.com>
Cc: <kbusch@kernel.org>, <mheyne@amazon.de>, <emilne@redhat.com>,
 <jmeneghi@redhat.com>, <linux-nvme@lists.infradead.org>,
 <mlombard@arkamax.eu>, <mkhalfella@purestorage.com>,
 <chaitanyak@nvidia.com>, <hare@kernel.org>, <hch@lst.de>
Subject: Re: [PATCH V3 2/8] nvme: add sysfs attribute to change admin
 timeout per nvme controller
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
X-Mailer: aerc 0.21.0
References: <20260410073924.61078-1-mlombard@redhat.com>
 <20260410073924.61078-3-mlombard@redhat.com>
 <a3171007-7cfb-45b0-b0bf-01dcc7ba51ab@flourine.local>
In-Reply-To: <a3171007-7cfb-45b0-b0bf-01dcc7ba51ab@flourine.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260422_040853_177006_D46CAF95 
X-CRM114-Status: GOOD (  11.11  )
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

On Wed Apr 22, 2026 at 12:10 PM CEST, Daniel Wagner wrote:
> On Fri, Apr 10, 2026 at 09:39:18AM +0200, Maurizio Lombardi wrote:
>> +	/*
>> +	 * Wait until the controller reaches the LIVE state
>> +	 * to be sure that admin_q and fabrics_q are
>> +	 * properly initialized.
>> +	 */
>> +	if (!test_bit(NVME_CTRL_STARTED_ONCE, &ctrl->flags))
>> +		return -EBUSY;
>
> I assume the idea is to use an udev rule to set the value. Though I
> think this is racy:
>
> 	nvme_change_uevent(ctrl, "NVME_EVENT=3Dconnected");
> 	set_bit(NVME_CTRL_STARTED_ONCE, &ctrl->flags);


Not really, the idea was about to prevent the user from setting the
timeouts too early during the controller's initialization.

Otherwise the user could try to change the timeout while
admin_q and fabrics_q are still being created.

if the NVME_CTRL_STARTED_ONCE bit is set, we know that the
initialization has been completed and that admin_q and fabrics_q will
exist until the controller will be torn down.


Maurizio


