Return-Path: <SRS0=tyWw=HF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA28C433DB
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 16:52:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C85B864F7C
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 16:52:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C85B864F7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=P2gNG8+iufm+4zfFZ+XtMMu8lNrd9T0UKZtHWxffkl8=; b=G2pT5QmZBTIfcFTSHoJmUO5F6
	Fxu4NPcifDcOZDloGq0crOlcIagguctfQBEhYu1lHQvjRchbyM6mTbIw54EQ2S46WLh4TlcAUPJMd
	SRhkTNWcofs4SV3BKU9Bk8lfmi3Ixo9QrAndITIIg+WVN4IC70jp4iEygMYj/y0kCjV0HZbeAwyCV
	pohDYWRV1kvF5Hj0BJyEStrleZUJZZdOQfxn6GqcIwU0drf1PutsPOsP+lK9J8k+xFay3oHKIUBfH
	nDVX+Kk/DjMcoSjXsCUXHA1d/FbfQWLaLTy0sKYNm+0zMUy2w4hysQRqc0KlOhZKze/uNCAFFMf6j
	W8lZa6eeA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7LNj-0003j6-7h; Wed, 03 Feb 2021 16:51:55 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7LNg-0003iT-Md
 for linux-nvme@lists.infradead.org; Wed, 03 Feb 2021 16:51:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id D74E468AFE; Wed,  3 Feb 2021 17:51:49 +0100 (CET)
Date: Wed, 3 Feb 2021 17:51:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Martin Wilck <mwilck@suse.com>
Subject: Re: [PATCH v2] nvme: avoid "(efault)" from nvme_sysfs_show_subsysnqn()
Message-ID: <20210203165149.GA6691@lst.de>
References: <20210202005951.26614-1-mwilck@suse.com>
 <20210202075828.GA12160@lst.de>
 <a7f3114e22a07e60abfd98155df91dea3a83b386.camel@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a7f3114e22a07e60abfd98155df91dea3a83b386.camel@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210203_115152_851897_D455061B 
X-CRM114-Status: GOOD (  14.11  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Feb 03, 2021 at 01:31:13PM +0100, Martin Wilck wrote:
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

What is wrong is that we should only add the device and thus send the
uevent notifcations when the device is fully set up.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
