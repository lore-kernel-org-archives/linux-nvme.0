Return-Path: <SRS0=PLgZ=IB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CA6C433DB
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 21:25:59 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71274600EF
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 21:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71274600EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Iba3alLHDq6IS+oJJxKbe48HJBEO4yrYU1aldt3Gb10=; b=O8dSmfb1uufd6KYZXKVZCrgAC
	pcljIJLPWabQCDj/VuVIofNi0woXN/3B9eGdlJlBlW/XvLNiCuAgggnhmuffpx8mUmdj/nPEuSXLd
	d/CrcSJZyzZnLIYxvCm9NK2TIX/0ihdbvRmHBVFiReQB+7wSDL4ZImbrm4lnMgt5hrph9sdCpnPUJ
	dfxOIcSKLfB56Rev02jB3mHvG2vd29jyiHicKt7Dmm2urad7qk8Jcy0eu9BIWhGpwxOLnoP6b2v2R
	xSAC7UfhI11+oFogLhsTpdPe1Af+j5Gw4UuqGtVJq3EaSFnbJ6ZUruuWMI819kNeShKu443pVHZOg
	H/xKJPO7A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHZ06-006acK-TK; Wed, 03 Mar 2021 21:25:47 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHT8E-005Jk3-20
 for linux-nvme@desiato.infradead.org; Wed, 03 Mar 2021 15:09:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=iOY6UdbgdiIfMOjOSqWRzJkNykTV3xPvrNPJRny29mI=; b=O2lxOwQ5G4+TZj793OC8U0Hday
 /eRjsj+YkbQJyYuYQGXh8TRGKowIt23EU9en7qN5AgAQ2Gvr4azAi6UkHivao4C4MLHchcXwatZ8J
 Gb77Vg6mu6lOI5AssU/otQ1u6C1TkyVOoFS5uHUDFjMGPD0CqXWe51hMDTiN/kAxgGU8zGop25sz+
 lEqgE/NyuXEkxpfohdVWlxdzK1Au9b+qJ5ixVDy2zRiWWJ54H+Ee1Z0CoEIXkPb8h+Z9UgBiMjRny
 /hxscxaWEXNtE6FViHMDMDmOxXCLKrtp2YjeRprrt3kugD4WpQgFWKU9Vj5A+wU5ssdr5TbZiCX9c
 ASUSuTfw==;
Received: from verein.lst.de ([213.95.11.211])
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHNWW-001wv9-PU
 for linux-nvme@lists.infradead.org; Wed, 03 Mar 2021 09:10:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1513A68B02; Wed,  3 Mar 2021 10:10:23 +0100 (CET)
Date: Wed, 3 Mar 2021 10:10:22 +0100
From: Christoph Hellwig <hch@lst.de>
To: javier@javigon.com
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, hch@lst.de,
 kbusch@kernel.org, sagi@grimberg.me, minwoo.im.dev@gmail.com,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>
Subject: Re: [PATCH V6 1/2] nvme: enable char device per namespace
Message-ID: <20210303091022.GA12784@lst.de>
References: <20210301192452.16770-1-javier.gonz@samsung.com>
 <20210301192452.16770-2-javier.gonz@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210301192452.16770-2-javier.gonz@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210303_091031_155349_D10AFC11 
X-CRM114-Status: GOOD (  13.38  )
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

On Mon, Mar 01, 2021 at 08:24:51PM +0100, javier@javigon.com wrote:
> From: Javier Gonz=E1lez <javier.gonz@samsung.com>
> =

> Create a char device per NVMe namespace. This char device is always
> initialized, independently of whether the features implemented by the
> device are supported by the kernel. User-space can therefore always
> issue IOCTLs to the NVMe driver using the char device.
> =

> The char device is presented as /dev/nvme-generic-XcYnZ. This naming
> scheme follows the convention of the hidden device (nvmeXcYnZ). Support
> for multipath will follow.

So I'm a little worried about the "support for multipath will follow" as
this has implications for the naming scheme, and our policy of how we
allow access to a namespace.

Ignoring some of the deprecated historic mistakes I think the policy
should be:

 - admin commands that often are controller specific should usually
   go to a controller-specific device, the existing /dev/nvmeX
   devices
 - I/O commands and admin command that do specific a nsid should go
   through a per-namespace node that is multipath aware and not
   controller specific

Which also makes me wonder about patch 2 in the series that seems
somewhat dangerous.   Can we clearly state the policy implemented?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
