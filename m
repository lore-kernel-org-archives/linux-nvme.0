Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D87E1C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Feb 2022 00:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9pDbdUv9vekYKMQY6X902Orh6k+1NkU2Uv7Kau9/j4M=; b=AGjU84/bcCiagdwZvPXacP9AaZ
	j3TRB3cBtfrNxMypcwTSiDPFV/wgmnApcqgzB/YzySon77gO3JjXO1C7IGrbSC3qt8ndY3J3702Zd
	6a/1ELarPRpYSFQJrha0wolvbga1y+rFG1/tC1MVUXwQOFVOdFRGpqP2J6JSMVLrW+f2gMZkm8aez
	ZRKkVgC1i4dKKf6XNayFMWidkSlCm12S6DhEuCgi+WLhB+nYiKUVRLWLwJ3oWDthlg6fDb7R8dsun
	4xbp7J7djInFtva8FrCw/emrpv/AOesmf8aGVYTEjZlwfRhTe9PQ5SLKrU1ZXt9f6bupcVyomGeBq
	6Xvc9oxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nNOrC-002ouR-G5; Fri, 25 Feb 2022 00:53:14 +0000
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nNOr9-002osZ-7V
 for linux-nvme@lists.infradead.org; Fri, 25 Feb 2022 00:53:12 +0000
Received: by mail-pf1-x42c.google.com with SMTP id a5so2498152pfv.9
 for <linux-nvme@lists.infradead.org>; Thu, 24 Feb 2022 16:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purestorage.com; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=9pDbdUv9vekYKMQY6X902Orh6k+1NkU2Uv7Kau9/j4M=;
 b=b62wu55YJd8b1Ay2Z7N+O4vo2txA9uz29rKx6wiMIOi/cxXnDzeomRxZXhDIbP1Ucw
 dOXuYK9BYpcNPPpwzC6fDvoNmHjjbaMRt/VO4lX57c7ZgnWhQFd/jjWYYISXvjef4Jqi
 YUK1OwdhcPJ5ifguCtXOBgx0/GKQljwCH5cHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9pDbdUv9vekYKMQY6X902Orh6k+1NkU2Uv7Kau9/j4M=;
 b=5LHakBiOelx1o/ZVxiXn4R+zdBmW7unMNlpW7mMfUJGriMpjawLPVTQih0aAJu+BuN
 SQwNg5o0gX5zoFGIS0DJqn+MDn9u78bJIXWBRGaAWT/AQYYh3/p5ZQjg7TbrG7dA8Kgq
 SxEY63HxSFpo0WyZrnzjgK8VCfcDw3pnEYJmKkfVQ3auFecY6S606HwxtWZczvihYRdP
 HCqXK+FAotSghajAwI6ar8uzFbh0V69molU23q76ofMs6yX16Y97sbUQTWNm+bd5U3OH
 q3m55vi8hAN9Ghh+mVDh+JL55tkS7IHxhMNT9qkRNIQ8JhWzmJqNv0tG+LpGwt+8Ax/8
 G1UA==
X-Gm-Message-State: AOAM533nU63YGCQ81W48s9begvnRa1e7e5yzTezpuDUQFcFsQ2QRyQco
 JHI6jQ45gzuNo7xSbNBeiZ1JCA==
X-Google-Smtp-Source: ABdhPJw2Is2RASiY5ZZss7E+BJ2bxM1SPbEsx2TZvOHmCK1sQ+Ue/u/RkG0Z8qYT20ioZGmnK8foEQ==
X-Received: by 2002:a05:6a00:ac1:b0:4f1:29e4:b3a1 with SMTP id
 c1-20020a056a000ac100b004f129e4b3a1mr5344956pfl.63.1645750389834; 
 Thu, 24 Feb 2022 16:53:09 -0800 (PST)
Received: from dev-randyj2.dev.purestorage.com ([192.30.188.252])
 by smtp.gmail.com with ESMTPSA id
 g12-20020a056a001a0c00b004e1307b249csm705531pfv.69.2022.02.24.16.53.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Feb 2022 16:53:09 -0800 (PST)
Date: Thu, 24 Feb 2022 17:53:06 -0700
From: Randy Jennings <randyj@purestorage.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org,
 Prabhath Sajeepa <psajeepa@purestorage.com>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Uday Shankar <ushankar@purestorage.com>
Subject: Re: Native multipath across multiple subsystem NQNs
Message-ID: <20220225005306.GA904231@dev-randyj2.dev.purestorage.com>
References: <20220211220714.GA370236@dev-ushankar.dev.purestorage.com>
 <20220212063422.GA16561@lst.de>
 <20220212212221.GB1660900@dhcp-10-100-145-180.wdc.com>
 <20220214081252.GA18231@lst.de>
 <20220225001547.GA3454995@dev-ushankar.dev.purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225001547.GA3454995@dev-ushankar.dev.purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220224_165311_370365_293D2520 
X-CRM114-Status: GOOD (  13.80  )
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

> The fact that NVMe with ANA required namespaces
> to be be attached to the same subsystem is good and important.
> TPE 4034 is retrograde and completely broken in this respect and should
> have never been ratifier.  Please fix your storage system to export
> virtual subsystems like everyone else and don't break the nice NVMe
> architecture.
Supposing we did implement virtual subsystems to handle exposing
namespaces on multiple arrays.

In addition to other considerations, migrating a namespace with hot data
from a different storage vendor array nondisruptive to client i/o would
be difficult to do without having a namespace exist under multiple NQNs.
One approach that has been used for SCSI is by multipathing to both
targets & a proxy mirroring writes; on cut-over, the other path
disconnects.  If the filehandle has to change, that is disruptive to the
client software.

Unifying different storage arrays behind the same NQN/virtual subsystem
requires coordination of nvme ctrl_ids at least, and doing that between
different storage vendor arrays is unlikely.  Having a mechanism to
migrate between different JBOF devices non-disruptively would be helpful
regardless of the source/destination vendors.  Such devices will
probably not have the option of virtual subsystems.

Additionally, the granularity at which NQNs/subsystems are exposed to
hosts affects how many connections the host creates with the controller.
Each connection has a cost in hardware & software.

In other words, even with implementing virtual subsystems, we still have
use for non-disruptively moving a namespace between subsystems.  How
will this usecase be supported on Linux?

Sincerely,
Randy Jennings

