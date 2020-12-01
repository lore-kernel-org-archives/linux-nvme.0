Return-Path: <SRS0=HgeD=FF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E942CC64E7B
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 19:30:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F3D52151B
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 19:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i0FjCqW7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqfI1pGO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F3D52151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6y2TtBn1aqG+AUbIVKM/8OCc5Uid8XzgFcK/H/NlzhQ=; b=i0FjCqW7ZvB6LG6fsi6D8VL8E
	xRhhWr/kcXcX8+3b1Hayf3HC10+SoWhmR/UpDegCpfXL9LXfhlsSLJDEoYqgWEn/zloBKJy+2gGjt
	/5kshK8V5pGsZNshuAu/RzsxGiQ9lspOUW92B5GVADkwxg8rohOGoPSCpSIq38JqScH0x4yB3fcFJ
	4LsoMSUXFjjmX5FEBv2TTyEgNywJkW8403IkT0x2+EYbeiiRaj4OKLhi4TLjpj6UNAXJXM5t5iJh5
	nmoh/NeEvkg09YD1VcuHTkir5BpgT9rg+1T23dLtuKXpxN+Ehs+5f1dHZ027YmtoLVvCACj57hzsd
	5dYsWG/jQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kkBLq-0005RD-4q; Tue, 01 Dec 2020 19:30:14 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkBLn-0005Q9-BP
 for linux-nvme@lists.infradead.org; Tue, 01 Dec 2020 19:30:12 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [129.253.182.57])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 68E94204EC;
 Tue,  1 Dec 2020 19:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606851009;
 bh=uXKPLA1a1Yej4SzJ0DOOepOD0FSpUn7pnq8xtF1CBXw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mqfI1pGO4DskIFbywYs6IvLJZZiiVpkN59BYg3Uo910IWmZYg6C0UMaeGJ/3PmOgR
 Qeq8c99rohTvQil0+CQUn9Qw/66D7M2rnvuVgHQJ9k459WcVIjeyM55i6iL2RC8Ii5
 JQCd4oYmn888az7/uMbON8qv21SYV8jN9SvmJjRQ=
Date: Wed, 2 Dec 2020 04:30:02 +0900
From: Keith Busch <kbusch@kernel.org>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>
Subject: Re: [PATCH 4/4] nvme: enable char device per namespace
Message-ID: <20201201193002.GB27728@redsun51.ssa.fujisawa.hgst.com>
References: <20201201125610.17138-1-javier.gonz@samsung.com>
 <20201201125610.17138-5-javier.gonz@samsung.com>
 <CGME20201201140354eucas1p1940891b47ca0c03ea46603393c844f61@eucas1p1.samsung.com>
 <20201201140348.GA5138@localhost.localdomain>
 <20201201185732.unlurqed2kaqwjsb@MacBook-Pro.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201201185732.unlurqed2kaqwjsb@MacBook-Pro.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201201_143011_498038_2548D272 
X-CRM114-Status: GOOD (  16.27  )
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
Cc: linux-block@vger.kernel.org, Minwoo Im <minwoo.im.dev@gmail.com>,
 hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Dec 01, 2020 at 07:57:32PM +0100, Javier Gonz=E1lez wrote:
> On 01.12.2020 23:03, Minwoo Im wrote:
> > > +
> > > +	device_initialize(&ns->cdev_device);
> > > +	ns->cdev_device.devt =3D MKDEV(MAJOR(nvme_ns_base_chr_devt),
> > > +				     ns->head->instance);
> > > +	ns->cdev_device.class =3D nvme_ns_class;
> > > +	ns->cdev_device.parent =3D ctrl->device;
> > > +	ns->cdev_device.groups =3D nvme_ns_char_id_attr_groups;
> > > +	dev_set_drvdata(&ns->cdev_device, ns);
> > > +
> > > +	sprintf(cdisk_name, "nvme%dc%dn%d", ctrl->subsys->instance,
> > > +			ctrl->instance, ns->head->instance);
> > =

> > In multi-path, private namespaces for a head are not in /dev, so I don't
> > think this will hurt private namespaces (e.g., nvme0c0n1), But it looks
> > like it will make a little bit confusions between chardev and hidden bl=
kdev.
> > =

> > I don't against to update nvme-cli things also even naming conventions =
are
> > going to become different than nvmeXcYnZ.
> =

> Agree. But as I understand it, Keith had a good argument to keep names
> aligned with the hidden bdev. =


My suggested naming makes it as obvious as possible that the character
device in /dev/ and the hidden block device in /sys/ are referring to
the same thing. What is confusing about that?

> It is also true that in that comment he suggested nesting the char
> device in /dev/nvme

Yeah, I'm okay with sub-directories for these special handles, but there
are arguments against it too. I don't feel that strongly about it either
way.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
