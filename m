Return-Path: <SRS0=tyWw=HF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEC5C433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 12:31:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 950A064F87
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 12:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 950A064F87
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2OsvksceWSbdzJ5IhilcjEJRZ161z5Xdf71sahpfBo0=; b=aV0Pq8ECtayLKGiQ5mFc0BQ1I
	iin0umC6BdBvctfyQVU8eOfO0YR13cTOV00zueOzRVjrXpSo7zTXLiKJwdAmb1W0jr/l3y3m2+hlj
	nVtGRCoBgjgG1ShQjNAyPjjKBno4/L7LmvN3i9N31rQm+dcuI5qtCgk1YHkxGIQeN2VcrdHqWqcqA
	p/H1+yrQ6xXHVbdGyMt44vF7FLT6XsO74PZ3GSvWZGNEXo1s4xVJQdl9qqU1a/u9biW5uC/AdU45X
	AjWJHYkqg1Furn0jdiI4ygEfQxecdbfzf1C43M9EOoxAXuLB4zq0p7JASZv68EI6leGys4B33LCuu
	9MZXU0agQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7HJX-0001ph-VI; Wed, 03 Feb 2021 12:31:20 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7HJU-0001pB-Pz
 for linux-nvme@lists.infradead.org; Wed, 03 Feb 2021 12:31:17 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1612355474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KPEqL0RfGA9kcGGTWqyMgrR0mcKqd6Rc8CsQ4DEm/7o=;
 b=eIOJsl1XyE+mbidafHRiE14QgjkkwBbpTElorDxr6gihWHwLBn30P8sI8hhZc/6Rlm7Lxa
 4cCi3VtX4JSuxdaM/ZJcwpRfeKSd9E3PLrmeq43ohjBX4ReydEg371426mkD6meYOVfSfs
 OJV7AO7t12RcjPRriiFeRFMM/NVUlsc=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 27442AD78;
 Wed,  3 Feb 2021 12:31:14 +0000 (UTC)
Message-ID: <a7f3114e22a07e60abfd98155df91dea3a83b386.camel@suse.com>
Subject: Re: [PATCH v2] nvme: avoid "(efault)" from nvme_sysfs_show_subsysnqn()
From: Martin Wilck <mwilck@suse.com>
To: Christoph Hellwig <hch@lst.de>
Date: Wed, 03 Feb 2021 13:31:13 +0100
In-Reply-To: <20210202075828.GA12160@lst.de>
References: <20210202005951.26614-1-mwilck@suse.com>
 <20210202075828.GA12160@lst.de>
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210203_073117_005542_000796DA 
X-CRM114-Status: GOOD (  20.19  )
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
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, 2021-02-02 at 08:58 +0100, Christoph Hellwig wrote:
> On Tue, Feb 02, 2021 at 01:59:51AM +0100, mwilck@suse.com=A0wrote:
> > From: Martin Wilck <mwilck@suse.com>
> > =

> > While a controller is still connecting, ctrl->subsys is NULL and
> > thus reading the controller's "subsysnqn" sysfs attribute returns
> > "(efault)". This happens all the time when user space processes
> > "add" events for NVMe controller devices.
> > =

> > Fix it by returning the nvmf_ctrl_options' subsysnqn attribute
> > if ctrl->subsys isn't initialized yet.
> =

> This is just papering over symptoms.=A0 We should not be sending
> events or display sysfs files until the controlle is live.

I don't follow.=A0What's wrong with a "connecting" controller device in
sysfs?=A0

Controllers can loose connectivity any time. What's the difference
between a controller that is reconnecting after a connection loss and a
freshly created controller that's just not live yet?=A0You wouldn't
delete the former from sysfs, I suppose.

From the user space point of view, it's the same, a controller device
that is not in usable state. I don't see a general problem with that.
Seeing a controller appear in connecting state might actually be useful
for user space.

The subsysnqn attribute is correct for controllers that were once
connected and lost connectivity. My patch was only intended to fix the
"just created and never connected" case, where it is not, nothing more.

Regards
Martin

> =

> In other wwords - I think we should remove the cdev_device_add
> from nvme_init_ctrl to nvme_start_ctrl (+ any error handling changes
> resulting from that).
> =




_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
