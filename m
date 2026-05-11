Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B10FCD37B5
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 08:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b3MA5PvIuwDpJghEkiB/TtaipFcoq0HCWN82l2B+X78=; b=S2Lu5HX/LAXswmTb4S0YgDQTVl
	YNuAXNbFrNYDTzJL7VAStcPF4uDdC8izxAGmTDf3PpZmF66e2BI3qB0HWawDAapa0uJ5wDSNEkHGH
	L+ebNmVAKyHCWmEtlXEb+cYDNrcjcd85Ph162u83f9GRgHrI+0zD6WydySYWBtBh0FvCylI+m6ayg
	zd1lmxRIIvRxdt4zzN8OLE8olQSwpTw9tt2/onfa2Kccv4Dz6EPSuVfaGRLMxzj1m7w30GhLE3TNy
	/uWZojIJ7GDhdor2PfJcLPw7YCVAjnV0o29yTfGBcsNx58U0i/rGNv+pOXSWTDdM709m549MPUknT
	qImeMaZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMMNO-0000000Cnmg-2Nn8;
	Mon, 11 May 2026 08:52:34 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMMNK-0000000Cnlt-2TXO
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 08:52:33 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 8080efe3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 May 2026 10:52:25 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 May 2026 10:52:24 +0200
Message-Id: <DIFPXDFB8XI5.3DUBGG0G3LG0J@arkamax.eu>
Cc: <mheyne@amazon.de>, <emilne@redhat.com>, <jmeneghi@redhat.com>,
 <linux-nvme@lists.infradead.org>, <dwagner@suse.de>, <mlombard@arkamax.eu>,
 <mkhalfella@purestorage.com>, <chaitanyak@nvidia.com>, <hare@kernel.org>,
 <hch@lst.de>
Subject: Re: [PATCH V4 5/9] nvme: add sysfs attribute to change IO timeout
 per controller
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Sagi Grimberg" <sagi@grimberg.me>, "Maurizio Lombardi"
 <mlombard@redhat.com>, <kbusch@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260508133335.98612-1-mlombard@redhat.com>
 <20260508133335.98612-6-mlombard@redhat.com>
 <86fd8b31-7264-48d1-99e6-a053ae6cae4e@grimberg.me>
In-Reply-To: <86fd8b31-7264-48d1-99e6-a053ae6cae4e@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_015231_182343_8153750D 
X-CRM114-Status: UNSURE (   8.49  )
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

On Mon May 11, 2026 at 12:12 AM CEST, Sagi Grimberg wrote:
>
>
> On 08/05/2026 16:33, Maurizio Lombardi wrote:
>> Currently, there is no method to adjust the timeout values on a
>> per controller basis with nvme I/O queues.
>> Add an io_timeout attribute to nvme so that different nvme controllers
>> which may have different timeout requirements can have custom
>> I/O timeouts set.
>
> Why is this needed? Why not simply change the timeout on
> the namespaces themselves?

One reason is convenience, having an io_timeout default value at the
controller level means that a newly discovered or hot-plugged namespace
will automatically inherit the controller-specific timeout.

Additionally, for nvmeof, the controller allocates a dedicated I/O queue
(ctrl->connect_q) that doesn't have a block device representation.
The io_timeout attribute will allow userspace to change the timeout
for this internal queue.

Maurizio


