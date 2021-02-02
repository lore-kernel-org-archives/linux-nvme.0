Return-Path: <SRS0=QQ4x=HE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69ACBC4332E
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 01:01:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 233DE64E31
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 01:01:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 233DE64E31
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BhYo6fC8QfipdR4WG4MLyBJcLn/df+yOBGonvQxU4us=; b=mus0rVTeGP9vfqCFxdO9WL4EV
	0Zl/MZsFXOJ/sokfar1ho+Yncn2yTZitIohn2y8ElKVl7DLRyBpqJxYsv+C+4Qi1oTgL+LJghZ4Cd
	LGvJtv8TJeqowgJh4mNiPJRt7MuyvvWuty6SrOwQvFISIqNXvNJczqrsx/2MUHnFYe/kaz0vJhYNV
	pQOxQyiI/tGNq5KDytXjhXc8uPzpXKlk/fqOmfNK7NMQshb7lIZwxIBifvrNJEVbOkx5LpcuHvBP1
	ajj51sB3cbTgESUijVMESBnaXzg+xAb1YeC/euadtD5hvf1FM8go2wm7HI/8+nNO/FUFk0G0pZYo8
	lxLe/fmLw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6k4m-0000Xp-AB; Tue, 02 Feb 2021 01:01:52 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6k4i-0000XS-DQ
 for linux-nvme@lists.infradead.org; Tue, 02 Feb 2021 01:01:49 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1612227707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yoAczNdr+wu+DKcbbL3I4T2aRngwvxCNnInTJBPcrSE=;
 b=ZxuyBPMP8gC+RgvtMA4JUpjLLYCBX8sNt4PHJhjdAgYRIJwZom7kbKSK1+357qD3OSIpeK
 YbMj7hqRITbG5n89YOtPZzxZBrkqjH9u+2PxOybA77moaVdKGpdRn9bgnH5IXXa9a9b84P
 9rf1vYriIr0/WmMJizS2GfR+ArBiH0o=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 6E644AC3A;
 Tue,  2 Feb 2021 01:01:47 +0000 (UTC)
Message-ID: <953df866cc397fd8231da9b8d82d97754719f459.camel@suse.com>
Subject: Re: [PATCH] nvme: avoid "(efault)" from nvme_sysfs_show_subsysnqn()
From: Martin Wilck <mwilck@suse.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, Sagi Grimberg
 <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Date: Tue, 02 Feb 2021 02:01:46 +0100
In-Reply-To: <BYAPR04MB4965FA3C4ADF1E74056D5FC686B69@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210201223713.15243-1-mwilck@suse.com>
 <BYAPR04MB4965FA3C4ADF1E74056D5FC686B69@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_200148_631104_21E607A3 
X-CRM114-Status: GOOD (  14.26  )
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
Cc: Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, 2021-02-01 at 23:56 +0000, Chaitanya Kulkarni wrote:
> On 2/1/21 14:41, mwilck@suse.com=A0wrote:
> > -=A0=A0=A0=A0=A0=A0=A0return snprintf(buf, PAGE_SIZE, "%s\n", ctrl->sub=
sys-
> > >subnqn);
> > +=A0=A0=A0=A0=A0=A0=A0if (ctrl->subsys)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0subsysnqn =3D ctrl->subsy=
s->subnqn;
> > +=A0=A0=A0=A0=A0=A0=A0else if (ctrl->opts && ctrl->opts->subsysnqn)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0subsysnqn =3D ctrl->opts-=
>subsysnqn;
> > +=A0=A0=A0=A0=A0=A0=A0else
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0subsysnqn =3D "unknown";
> Just initialize the subsysnqnq to unknown string at the time of
> declaration.

Just sent a v2.

> =

> Also, can you please add a testcase for this bug in blktests to make
> sure this
> behavior will not repeat=A0 ?

Yes, but it'll take time because I have zero experience with blktests
and little time the rest of this week. Please kindly review the kernel
patch nonetheless.

Regards
Martin




_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
