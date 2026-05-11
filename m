Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C88CD37B2
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 15:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xz6h1Q/JpAFlzCvk/bnc6ORYIPZgzd/q9LCXEj1g7Mk=; b=VAsCeq96WaJHYqKVGTouKGZ5vb
	r/79Wu6yQ2tl39jAH6k5KA/IsOma3h0dVx4z3Xf3vPG9Rf0WwgxNEFMvYEA5WdaR8cwIZmh+ql/uu
	Jb8yFOYgGPOTi1jq7rchbjgpH4Ku6uZyzYvAxNJc/2ELeoNPW3r61eZagwJe8lEFHpsVMaO+2uupG
	YsgwEwicZMXA5MwF9KRzoWeeHNzJIOIONDUABTYBEJzVwZk83rgDjK8Bng0Doc5H96r14SSJrq4LD
	oXwC+vxwzWrkEX8QpUKhDotvywiUYekJnPvAm5ODp8YKhshlZDr90TTeQujnUyOgLXfS4Scqus0Su
	JLY9Up/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMSpD-0000000E5z7-3QI2;
	Mon, 11 May 2026 15:45:43 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMSp9-0000000E5yO-00qi
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 15:45:41 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 133aa772 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 May 2026 17:45:36 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 May 2026 17:45:36 +0200
Message-Id: <DIFYPQP2Z8D5.QSBMLF4V9FNX@arkamax.eu>
Cc: "Christoph Hellwig" <hch@lst.de>, "Maurizio Lombardi"
 <mlombard@redhat.com>, <mheyne@amazon.de>, <emilne@redhat.com>,
 <jmeneghi@redhat.com>, <linux-nvme@lists.infradead.org>, <dwagner@suse.de>,
 <mlombard@arkamax.eu>, <mkhalfella@purestorage.com>,
 <chaitanyak@nvidia.com>, <hare@kernel.org>
Subject: Re: [PATCH V4 3/9] nvme: fix race condition between connected
 uevent and STARTED_ONCE flag
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Keith Busch" <kbusch@kernel.org>, "Sagi Grimberg" <sagi@grimberg.me>
X-Mailer: aerc 0.21.0
References: <20260508133335.98612-1-mlombard@redhat.com>
 <20260508133335.98612-4-mlombard@redhat.com>
 <3512fbae-ddf5-458d-9286-214b1d89afa8@grimberg.me>
 <20260511080746.GC29677@lst.de>
 <8074044d-291b-4ac4-acda-f27e94f3243b@grimberg.me>
 <agHxJrEzw08glN1x@kbusch-mbp>
In-Reply-To: <agHxJrEzw08glN1x@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_084540_169668_85A40836 
X-CRM114-Status: GOOD (  10.29  )
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

On Mon May 11, 2026 at 5:09 PM CEST, Keith Busch wrote:
> On Mon, May 11, 2026 at 03:54:04PM +0300, Sagi Grimberg wrote:
>>=20
>> > On Mon, May 11, 2026 at 01:10:34AM +0300, Sagi Grimberg wrote:
>> > > This should even go as a separate patch:
>> > You mean a stadalone fix?  Because it already is a separate patch.
>>=20
>> Yes, this is a race condition fix that can go separately.
>
> Sure thing, I've applied patch 3/9 to nvme-7.1 as a separate bug fix.

Oh, that was way faster than I expected.

The issue is that, in explaining the rationale behind PATCH 3, I
mentioned in its commit message the admin_timeout sysfs attribute
introduced by this patchset.

You may want to remove that reference if you plan to merge patch 3
indipendently of the rest of this patchset.

In the vanilla kernel, the only sysfs attribute that could be affected by
this race condition is nvme_sysfs_delete().

Maurizio

