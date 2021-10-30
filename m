Return-Path: <SRS0=xH1B=PS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9246EC433F5
	for <linux-nvme@archiver.kernel.org>; Sat, 30 Oct 2021 17:04:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B97560E9C
	for <linux-nvme@archiver.kernel.org>; Sat, 30 Oct 2021 17:04:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5B97560E9C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mxOtNLa1eAMR0wpGD1VMaJkJmBISmLqnmjVIAsRcHvc=; b=QLqQsXzfiguFpcZTr1Eh9LVJ3M
	20vx63b8rH7rH4tiei2i7e3L/EGcw4oY7XwKA4X5LVAN7nxnJhXSjTX6bELAj1fvLi+O20TnT2K1C
	lnNaNzSbGY64Uqb/2eR8j88iK0C2OWehGBgEl/Yp1PfuNKMobzi0/bZ4BZ77DpPLoZ22CjP1/GmwD
	V8uG1vY59h+bWHci5FGEuBc+Rav50v3LVdmiwaUibzEdjatkqRC43eQL/dj/DlpPeNiEWZhiTCE0m
	gwexb47AjiTGm7ze0yFmPN5iZi4eoOggGX5W+6itaUJx9Qzy+IyzXQLsDH12aov1fv8iGj0AukyYA
	UiCxUnVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mgrlq-00DH1c-9H; Sat, 30 Oct 2021 17:03:54 +0000
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mgrlk-00DGzm-CV
 for linux-nvme@lists.infradead.org; Sat, 30 Oct 2021 17:03:49 +0000
Received: by mail-io1-xd30.google.com with SMTP id z144so15284174iof.0
 for <linux-nvme@lists.infradead.org>; Sat, 30 Oct 2021 10:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:in-reply-to:references:subject:message-id:date
 :mime-version:content-transfer-encoding;
 bh=mxOtNLa1eAMR0wpGD1VMaJkJmBISmLqnmjVIAsRcHvc=;
 b=TxRznXHiVxPacqnwtNIIT0ht6nYzSE2RDLvhKozr3LBin/ehB9sdFZDpWWjj4OSd+b
 wNVCVAvLw46JGTiAgUNZvEmvOxN66IADWaxYxM1QrR9lkXlSakotxqRDVZM1H74gZzC3
 dptCLtGLLsAefANWtuy2n0rGMRlWfacf/IHiKhBgdqwAXaaJe6kpIkKpb32JNyUJDsPQ
 h2JfNkORS5+nxcLRKrwXOlVNT9+6p7ra3ZV/bu0Di5bdLiqfxKarFy4zEtd9fllr2oYp
 7Q6VyWuncWNiiodyabAkyjZysJUsC526HyMFP48mdzk4scwMLVB6FI1dgulKgRvL0IOy
 PuLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
 :message-id:date:mime-version:content-transfer-encoding;
 bh=mxOtNLa1eAMR0wpGD1VMaJkJmBISmLqnmjVIAsRcHvc=;
 b=OR8D69nwq8hhHlgQc8N/inuC5N0SfEa69PV/mEkAx2twYfHhinNksSrJj9gm/aMVj+
 WiaobiAbka9wDIJk+tnqDJrHypv3AiJOdsD9XXrD1SHVm3xca5YJfseKDRbaXZHNWU1N
 3eRlH//uPtIclu//4X4gjnUh/VNt0G3KQ0T98eEJRsWc+7r3PIk9Kglxp/6N7/09zPDZ
 gbgl+hx922NRykSZeSD7/M0N8ICQGCm95QPoo8xN9ScJxHFoYE8boTYSN0xcrJ4sV59S
 gK3rs3K1nJDI6CUG/Twrf5UHvBx4WICUD0T1J1mtcMZODgVTCQLqe2sHUM1SWHanF02Y
 QtAg==
X-Gm-Message-State: AOAM532XCKkRABYYrjDA1gzXz3KfEuonVG1Fi9JApspTqoiEcCoApu5X
 9DrFDrEBSBZ6b6eW6DVf0wXRYA==
X-Google-Smtp-Source: ABdhPJzMkwx+8CSrFVSVUQuPKJKJNsEs+j3d0vp9XLDv6RRzhAFgLrCeu1vNWGVlfsmYjr2iZBeQpQ==
X-Received: by 2002:a05:6602:2a44:: with SMTP id
 k4mr13067137iov.56.1635613426348; 
 Sat, 30 Oct 2021 10:03:46 -0700 (PDT)
Received: from [127.0.1.1] ([66.219.217.159])
 by smtp.gmail.com with ESMTPSA id z26sm4948483ioe.9.2021.10.30.10.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Oct 2021 10:03:45 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: kbusch@kernel.org, dan.j.williams@intel.com, richard@nod.at, jim@jtan.com,
 vishal.l.verma@intel.com, dave.jiang@intel.com, miquel.raynal@bootlin.com,
 vigneshr@ti.com, ngupta@vflare.org, ira.weiny@intel.com,
 senozhatsky@chromium.org, hch@lst.de, paulus@samba.org,
 Luis Chamberlain <mcgrof@kernel.org>, sagi@grimberg.me, mpe@ellerman.id.au,
 minchan@kernel.org, geoff@infradead.org, benh@kernel.crashing.org
Cc: linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 nvdimm@lists.linux.dev, linux-block@vger.kernel.org
In-Reply-To: <20211015235219.2191207-1-mcgrof@kernel.org>
References: <20211015235219.2191207-1-mcgrof@kernel.org>
Subject: Re: (subset) [PATCH 00/13] block: add_disk() error handling stragglers
Message-Id: <163561342513.76453.10042066842818606438.b4-ty@kernel.dk>
Date: Sat, 30 Oct 2021 11:03:45 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211030_100348_441044_E8FA1C7B 
X-CRM114-Status: GOOD (  12.41  )
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

On Fri, 15 Oct 2021 16:52:06 -0700, Luis Chamberlain wrote:
> This patch set consists of al the straggler drivers for which we have
> have no patch reviews done for yet. I'd like to ask for folks to please
> consider chiming in, specially if you're the maintainer for the driver.
> Additionally if you can specify if you'll take the patch in yourself or
> if you want Jens to take it, that'd be great too.
> 
> Luis Chamberlain (13):
>   block/brd: add error handling support for add_disk()
>   nvme-multipath: add error handling support for add_disk()
>   nvdimm/btt: do not call del_gendisk() if not needed
>   nvdimm/btt: use goto error labels on btt_blk_init()
>   nvdimm/btt: add error handling support for add_disk()
>   nvdimm/blk: avoid calling del_gendisk() on early failures
>   nvdimm/blk: add error handling support for add_disk()
>   zram: add error handling support for add_disk()
>   z2ram: add error handling support for add_disk()
>   ps3disk: add error handling support for add_disk()
>   ps3vram: add error handling support for add_disk()
>   block/sunvdc: add error handling support for add_disk()
>   mtd/ubi/block: add error handling support for add_disk()
> 
> [...]

Applied, thanks!

[08/13] zram: add error handling support for add_disk()
        commit: 5e2e1cc4131cf4d21629c94331f2351b7dc8b87c
[10/13] ps3disk: add error handling support for add_disk()
        commit: ff4cbe0fcf5d749f76040f782f0618656cd23e33
[11/13] ps3vram: add error handling support for add_disk()
        commit: 3c30883acab1d20ecbd3c48dc12b147b51548742

Best regards,
-- 
Jens Axboe



