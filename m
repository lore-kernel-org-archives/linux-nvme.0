Return-Path: <SRS0=/SuC=JR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16F2C433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 18:29:23 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 206436135F
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 18:29:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 206436135F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tarNWEwx8CTAE2aLAZeNllJGH1fJySTFS88On9zAJNA=; b=qBgyaxc0iipcF5ZNsVkMTu8D9
	DO4Irc4qomszveboiU4GdS0HxpJ+OXboWkvmmTBf3dk3onCHpmpnBtweihtfoh2i/Ejz9dfLkM/yt
	Y9iuTikagMByn3LRuaD9W39SpyLzv0kWymQf9f8748QnUOyChrtz+DVyg4SAmnMr4WgxgugHmzuo4
	/7HUlvc+ysb/bbCS6tG7VVld87B8Fkeo0cHIrvvmSvFp14Ux/XyWVRRNUusXDo1YzbU58RqjtN+08
	t0UB3WyD/6sUXcnzUnniZ6n12NAq4GgGuo/s80tC9e47RHnCjcoXmy4JiHKHSZ4EzqgKbdUPi3mEt
	29sa1BQqA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYv75-00CpUk-5B; Tue, 20 Apr 2021 18:28:43 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYv71-00CpUA-Ns
 for linux-nvme@desiato.infradead.org; Tue, 20 Apr 2021 18:28:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=z+YOFRLY+bbcjq7cx1e4XTqChlJ2yrdY3qCjw9z4x4c=; b=xm2lRT4bh3iXLwYW6ZlbvdeKq5
 ndiKfpBZSSqVjOQhw1A1K+HOf91aFxJCgNZDm8odRIWZgLOBczRdl3y2MJ3Foznp3teq4xRBJ8S6l
 1k5dShQ4Khx4BlWMRvfHh/xiSS0OstiuQEXvYxSRlwZ+sAYRuE/fg3pPUIZs4oTeJ0yblu2L/Tj3x
 PG9GkF+7CvjbvCnObg/bz5MRv/2tflKNBkoM5pzyYwhu++4hkGgTg3lI6x6LcBhDdBDRQkA9b1ylC
 sPrXje6iEhWXmZMlFactBBL+qoCUwrzh+dgZUmpCoTYIcEsS9Ppqr2LbXU+FoKgS3FICIv02VpzTZ
 rx6Z20eA==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYv6u-00CLRH-3l
 for linux-nvme@lists.infradead.org; Tue, 20 Apr 2021 18:28:38 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 6C7CBB312;
 Tue, 20 Apr 2021 18:28:30 +0000 (UTC)
Date: Tue, 20 Apr 2021 20:28:30 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Roman Bolshakov <r.bolshakov@yadro.com>
Cc: linux-scsi@vger.kernel.org, GR-QLogic-Storage-Upstream@marvell.com,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
 Nilesh Javali <njavali@marvell.com>, Arun Easi <aeasi@marvell.com>,
 James Smart <james.smart@broadcom.com>
Subject: Re: [RFC] qla2xxx: Add dev_loss_tmo kernel module options
Message-ID: <20210420182830.fbipix3l7hwlyfx3@beryllium.lan>
References: <20210419100014.47144-1-dwagner@suse.de>
 <YH8QzgWiec8vka20@SPB-NB-133.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YH8QzgWiec8vka20@SPB-NB-133.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210420_112832_316639_A2576CBF 
X-CRM114-Status: GOOD (  15.86  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Roman,

On Tue, Apr 20, 2021 at 08:35:10PM +0300, Roman Bolshakov wrote:
> + James S.
> 
> Daniel, WRT to your patch I don't think we should add one more approach
> to set dev_loss_tmo via kernel module parameter as NVMe adopters are
> going to be even more confused about the parameter. Just imagine
> knowledge bases populated with all sorts of the workarounds, that apply
> to kernel version x, y, z, etc :)

Totally agree. I consider this patch just a hack and way to get the
discussion going, hence the RFC :) Well, maybe we are going to add it
downstream in our kernels until we have a better way for setting the
dev_loss_tmo.

As explained the debugfs interface is not working (okay, that's
something which could be fixed) and it has the big problem that it is
not under control by udevd. Not sure if we with some new udev rules the
debugfs could automatically discovered or not.

> What exists for FCP/SCSI is quite clear and reasonable. I don't know why
> FC-NVMe rports should be way too different.

The lpfc driver does expose the FCP/SCSI and the FC-NVMe rports nicely
via the fc_remote_ports and this is what I would like to have from the
qla2xxx driver as well. qla2xxx exposes the FCP/SCSI rports but not the
FC-NVMe rports.

Thanks,
Daniel

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
