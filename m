Return-Path: <SRS0=YFbx=KA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F94C433ED
	for <linux-nvme@archiver.kernel.org>; Wed,  5 May 2021 15:27:34 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B1F0613BA
	for <linux-nvme@archiver.kernel.org>; Wed,  5 May 2021 15:27:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B1F0613BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6cUDq0fErM7u6BsROo+HUfG15Xj7rl5qY51pioa8JCk=; b=OCo98beqRtS2D4tLnfhAz5PDA
	ppSxVprqpzRlokdqejPvLzZPElEUZzq3H9TjnRadBXDVMQm85Gcsm1L4EDxeNNMFZASFssGNA8YrA
	QhPkS52VSahSnltQU+y414f5xdw0X/iy5bdPtmP95GxicD6jPfTxOTTZb+jtmqaSRKkxDkHjVigX+
	kTq8n/lb3eEm7KoBqpSKJB4empvIGcQKzSNQJxPdiGZi76zSiYD49Ykt7PBPgTFUEXSATHlUOvbLD
	7hKHHsN8L9z1FJ2Dj3wWdXrp3qobPaavn7VGArziidYP53cMDNgoaEslnfXp7OJ0pr5vT0kLw01iZ
	hDxXw+vcg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1leJQc-001Ybv-45; Wed, 05 May 2021 15:27:10 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leJQZ-001Ybg-HT
 for linux-nvme@desiato.infradead.org; Wed, 05 May 2021 15:27:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
 :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=QQ8P0nJMpxllex6HFSXhUSqZdLwQs9NaLvqNidO9Xjs=; b=nlWORrExMfWLcNHyzNhtJHGKHo
 SwKOf+5jPCL+1c36Z8fajzwkghrJm94/LRySKCpgtvgOW/dzSy1ypjgFkUnsFLnhX9/xr97cNDNa+
 HKE9r1TkfoSKcXTDY7zfsx9H7SiX3y7YWvVtPeWtyXMJ9J0RsWujbSGldjv5iY77U2YLBSCpUlvJG
 LcDEz1smFAdg/EEusgCP1BeR4IWYPJtk4OweLyeLlgy6N2bGt8wdTh4kCdz+OLfCcngosbwPlePKd
 OuZPvKNqR71fIUNVMfcvsveZvxDCZfo/RVViyvb2Ah7epyPrudNZy1eNGJs8+n62yDJgVynBvleH2
 GYrdjp4g==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leJQW-004sBk-Q5
 for linux-nvme@lists.infradead.org; Wed, 05 May 2021 15:27:06 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id A323A613BA;
 Wed,  5 May 2021 15:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620228423;
 bh=kiZOsB+u4n2SM/XUfFq6WeyAGFr9ZLrqdmdbmrsSs30=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XoqalqK7XkJozooK7AEBn4hRoArKEa1Y4LrqFpVR15X0tNhPTVClMTZGwb8lRb7fO
 bp06kj1+2Jc00FvoBT5qqePgdEE+WHDgKUL1GzSaLd/RvwhxHdrQvVHl+rQChwJbsu
 SSjVC5q46O2msI1jlEMoo5/yIUbVWIwiVIlOMBv9v4UKCIdIwSDvncWTtKRffBrSio
 uCHJwWj2upAIfwioD5X+ckaosrh09iDf+1BMe7ibX8V1ukZ6lnDEFdln0uB3zCfXP6
 i/miH8cS2p6558UhX8KTffpbsJAkxo1UEC9KnG7pdiX7iqfe1fmk1+7keRQVuGz5+g
 +svfcPeot1YPA==
Date: Wed, 5 May 2021 08:26:59 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 Daniel Wagner <daniel.wagner@suse.de>
Subject: Re: [PATCHv3] nvme-mpath: delete disk after last connection
Message-ID: <20210505152659.GB912679@dhcp-10-100-145-180.wdc.com>
References: <20210501120447.45478-1-hare@suse.de>
 <20210504085457.GA21826@lst.de>
 <5e4df9ec-c66c-17cf-542f-bac71b490e62@suse.de>
 <d1ca6eab-1ec9-d6c7-ed8a-00d9110bf023@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d1ca6eab-1ec9-d6c7-ed8a-00d9110bf023@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210505_082704_924650_245F2244 
X-CRM114-Status: GOOD (  23.13  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, May 04, 2021 at 12:54:14PM -0700, Sagi Grimberg wrote:
> =

> > > As stated in the v3 review this is an incompatible change.=A0 We'll n=
eed
> > > the queue_if_no_path attribute first, and default it to on to keep
> > > compatability.
> > > =

> > =

> > That is what I tried the last time, but the direction I got was to treat
> > both, NVMe-PCI and NVMe-oF identically:
> > (https://lore.kernel.org/linux-nvme/34e5c178-8bc4-68d3-8374-fbc1b451b6e=
8@grimberg.me/)
> =

> Yes, I'm not sure I understand your comment Christoph. This addresses an
> issue with mdraid where hot unplug+replug does not restore the device to
> the raid group (pci and fabrics alike), where before multipath this used
> to work.
> =

> queue_if_no_path is a dm-multipath feature so I'm not entirely clear
> what is the concern? mdraid on nvme (pci/fabrics) used to work a certain
> way, with the introduction of nvme-mpath the behavior was broken (as far
> as I understand from Hannes).
> =

> My thinking is that if we want queue_if_no_path functionality in nvme
> mpath we should have it explicitly stated properly such that people
> that actually need it will use it and have mdraid function correctly
> again. Also, queue_if_no_path applies really if all the paths are
> gone in the sense they are completely removed, and doesn't apply
> to controller reset/reconnect.
> =

> I agree we should probably have queue_if_no_path attribute on the
> mpath device, but it doesn't sound right to default it to true given
> that it breaks mdraid stacking on top of it..

If you want "queue_if_no_path" behavior, can't you just set really high
reconnect_delay and ctrl_loss_tmo values? That prevents the path from
being deleted while it is unreachable, then restart IO on the existing
path once connection is re-established.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
