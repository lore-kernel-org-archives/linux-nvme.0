Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF67C98304
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Sep 2026 01:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2POCr3NwEttl/9fkb+zZmDv/CNUldjtg2tQBcLAHUzE=; b=uF/SvFsu4be35D9GAgaP3K/ELx
	802a0O8+aEo4NaSDZAUYz/dgBNk0/dxhtueW7cakJAeNVSz6o3wZvrKPb9jAWWV1GMQlJdwZqZPct
	Kb4Q02FsT59nN48yL4b8TaP1F2m7kDxPDdAO7NwCNH53JELr6WkmS2se+0SNjZVf3QjVHnZR2O9IW
	1Fa3MN2lO99NW5SsKp0nzm9XBRk/xMb+MUjBqfTcHVa3wAlPBVLoff0ECA1BhqKmp9EFbpcq6XxKV
	NT6Axw+Iv9fGABtotEe5dcSfYCiMxlIn0+0aIi8d9od29APJ5O56g+sQQytqb18zes7rVr0FUafqb
	7I/GIImQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9Xvu-00000009mQj-23pn;
	Thu, 24 Sep 2026 01:07:30 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9Xvs-00000009mQa-3Epa
	for linux-nvme@lists.infradead.org;
	Thu, 24 Sep 2026 01:07:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 33B0541A98;
	Thu, 24 Sep 2026 01:07:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B38731F000FF;
	Thu, 24 Sep 2026 01:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790212048;
	bh=2POCr3NwEttl/9fkb+zZmDv/CNUldjtg2tQBcLAHUzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g79BUQG6tYtkRLhfNqdDYqYg0c7jIOSb6q6+yg+PPVd7SkIKY6vFpKFy/LxZKXur6
	 KA2DV0CxbyAF95S0B8biRjU6w8cTy0Hzk8y4UiIWD57969y5Z6Izcg2W8ltEVEiE2V
	 5uZhqq98NacsbsMuRPObsdYklJhtGyg87kZCYk7jD9Dt3Y9+n5FiOYDjnj7pqVrSm8
	 /xDRZ2EkYZW9F/krgtKhJ6F7ikgeD5nbDN9d2rStpDwLNBvRrhYaoWfKXhdnIbcvOD
	 +QRFQl4uk0XJgpA6nYjEMXz31E5CzQoywC0S5xLDePCHPSAaCAQWSM8avHq1Px9C+Y
	 CP8k+2RcfRDWg==
Date: Wed, 23 Sep 2026 19:07:26 -0600
From: Keith Busch <kbusch@kernel.org>
To: Krishna Iyer <kiyer@crusoe.ai>
Cc: hare@suse.de, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	nilay@linux.ibm.com, sjpark@crusoe.ai, saravanand@crusoe.ai
Subject: Re: [PATCH v3] nvme-multipath: add fail_if_no_path sysfs attribute
Message-ID: <arR3zlpx3Xm2mRt-@kbusch-mbp>
References: <20260923004959.88440-1-kiyer@crusoe.ai>
 <arRJLL4ki-sVQnHf@kbusch-mbp>
 <20260923225753.49224-1-kiyer@crusoe.ai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923225753.49224-1-kiyer@crusoe.ai>
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

On Wed, Sep 23, 2026 at 03:57:53PM -0700, Krishna Iyer wrote:
> On 9/23/26 2:48 PM, Keith Busch wrote:
> > I agree with Hannes that we shouldn't need a new flag for this. The
> > current behavior is just broken in a few ways.
> >
> > We just need to restrict queue_if_no_path to only if there really are no
> > paths so that we actually respect the failfast_tmo.
> >
> > And the ANA inaccessible and persistent-loss handling you introduced
> > here should just be the default without requiring a flag. But I think
> > you need to add a requeue_list kick in nvme_update_ns_ana_state() too in
> > case the ANA transition leaves the namespace inaccessible.
> 
> Agreed those are real problems, but fixing them still leaves no way
> to cover this case. Subsystems commonly expose many volumes as
> namespaces behind the same controllers, and failfast is controller
> scoped and time based: a timeout fails every namespace or none, and
> the trigger here is an event, not a duration one can pick up front,
> while sibling namespaces should keep queueing and ride out the
> outage. delayed_removal_secs does not apply either: it only governs
> the window after the last path is removed (here the controllers still
> exist and keep reconnecting), and its expiry removes the head disk,
> where this case needs the opposite, fail the parked I/O and keep the
> device. fail_if_no_path stays the only namespace scoped way to
> release parked I/O.

I get that failfast is at the controller scope, but that seems okay:
when the transport is down, every namespace behind that controller is
equally without a path. When the controller is live, the per-namespace
inaccessible case is handled separately by the ANA state, so namespace
heads that lose access bail and the rest can carry on.

Is your intention to have some namespaces wait for reconnect longer than
others?

