Return-Path: <SRS0=tyWw=HF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7B1C433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 16:52:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DC5164F7C
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 16:52:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DC5164F7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=dvx1pt+N3lV3gYIX30Kz9ctCjkq3SU/mbYLadzH7PqA=; b=m/5vu1OGu3eC6vngjGToqRWcW
	gr2jhwoAl3xs3Q4xZ1IazZ5kVNDP3bd8A9nnCaMAl9mLVOBqd4IrLCkQLEWjITK6/o3cIYcJi4+29
	f5cfBh5v1KkQF+/QCaVG8gAfNpq/39/1jJnq7PwHPEVNv/tdhgINRItX55dXeVP6JyIkooiVss//P
	7yeOxIY+J/qA5T95wQ8Ko027emIlhXU2zUpp5QlKlGSJ61KDSm15AmVBxWrv5vMpEGGOxtiCbeJab
	5/u+JsYM6wl75Qc5x2TZJgZdODoH3C+OsqS98sNQhypDSpj6fuFO5e8KFeD7eYt4C6RMKb20511Sz
	P/pLML4nw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7LNy-0003mG-9Q; Wed, 03 Feb 2021 16:52:10 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7LNv-0003lS-Iy
 for linux-nvme@lists.infradead.org; Wed, 03 Feb 2021 16:52:08 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0773F64E35;
 Wed,  3 Feb 2021 16:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612371126;
 bh=DkZ2FEvMqtHSwS7IVTgNrIV7fSeFB6xpAKDGrlCXwdg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YuGjcHeRD7W6enCQNaoSE8RsT5UkH78tRfYCo1iVcwcpzGVNSgG2L6Tq+wv0SF1Ae
 9L+Uqjo3yPu3cVbl35RmtWMHUtRHLUvWJzhOuQSz5wI8urcHqgECttdtk/RMrcU8/8
 ShkWHHGrWpXK2qSgdCX/OF28CRq36pUxVWM+UN6SJaaprzni/jczk4T8UA//+VEXa9
 m1U9v9OhLV3ICp87LzbrA+AgLEZS21tWiaC5/oicr6MnlqbUSWXe3ORIn6lWGxv2Db
 qAhHlQaNC42uAOKnRJCJ1JKLmoMwGYebCWvNjQ4oXpGwgRWAaa1GUWvgKrIeLXnALb
 w0vHCKAfF1hig==
Date: Wed, 3 Feb 2021 08:52:03 -0800
From: Keith Busch <kbusch@kernel.org>
To: Martin Wilck <mwilck@suse.com>
Subject: Re: [PATCH v2] nvme: avoid "(efault)" from nvme_sysfs_show_subsysnqn()
Message-ID: <20210203165203.GA2182779@dhcp-10-100-145-180.wdc.com>
References: <20210202005951.26614-1-mwilck@suse.com>
 <20210202075828.GA12160@lst.de>
 <a7f3114e22a07e60abfd98155df91dea3a83b386.camel@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a7f3114e22a07e60abfd98155df91dea3a83b386.camel@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210203_115207_778935_C4F44C58 
X-CRM114-Status: GOOD (  26.36  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Feb 03, 2021 at 01:31:13PM +0100, Martin Wilck wrote:
> On Tue, 2021-02-02 at 08:58 +0100, Christoph Hellwig wrote:
> > On Tue, Feb 02, 2021 at 01:59:51AM +0100, mwilck@suse.com=A0wrote:
> > > From: Martin Wilck <mwilck@suse.com>
> > > =

> > > While a controller is still connecting, ctrl->subsys is NULL and
> > > thus reading the controller's "subsysnqn" sysfs attribute returns
> > > "(efault)". This happens all the time when user space processes
> > > "add" events for NVMe controller devices.
> > > =

> > > Fix it by returning the nvmf_ctrl_options' subsysnqn attribute
> > > if ctrl->subsys isn't initialized yet.
> > =

> > This is just papering over symptoms.=A0 We should not be sending
> > events or display sysfs files until the controlle is live.
> =

> I don't follow.=A0What's wrong with a "connecting" controller device in
> sysfs?=A0
> =

> Controllers can loose connectivity any time. What's the difference
> between a controller that is reconnecting after a connection loss and a
> freshly created controller that's just not live yet?=A0You wouldn't
> delete the former from sysfs, I suppose.
> =

> From the user space point of view, it's the same, a controller device
> that is not in usable state. I don't see a general problem with that.
> Seeing a controller appear in connecting state might actually be useful
> for user space.
> =

> The subsysnqn attribute is correct for controllers that were once
> connected and lost connectivity. My patch was only intended to fix the
> "just created and never connected" case, where it is not, nothing more.

I think Christoph is suggesting just wait until we have all the
properties the driver exports rather than specifically exporting only
during a 'live' state. Something like this (untested) should do the
trick:

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1a3cdc6b1036..4c0258d7eb91 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3069,6 +3069,9 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 		if (ret)
 			goto out_free;
 =

+		ret =3D cdev_device_add(&ctrl->cdev, ctrl->device);
+		if (ret)
+			goto out_free;
 		/*
 		 * Check for quirks.  Quirk can depend on firmware version,
 		 * so, in principle, the set of quirks present can change
@@ -4545,9 +4548,6 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct dev=
ice *dev,
 	nvme_get_ctrl(ctrl);
 	cdev_init(&ctrl->cdev, &nvme_dev_fops);
 	ctrl->cdev.owner =3D ops->module;
-	ret =3D cdev_device_add(&ctrl->cdev, ctrl->device);
-	if (ret)
-		goto out_free_name;
 =

 	/*
 	 * Initialize latency tolerance controls.  The sysfs files won't
@@ -4560,9 +4560,6 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct dev=
ice *dev,
 	nvme_fault_inject_init(&ctrl->fault_inject, dev_name(ctrl->device));
 =

 	return 0;
-out_free_name:
-	nvme_put_ctrl(ctrl);
-	kfree_const(ctrl->device->kobj.name);
 out_release_instance:
 	ida_simple_remove(&nvme_instance_ida, ctrl->instance);
 out:
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
