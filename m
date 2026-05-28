Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C5FCD5BC9
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2026 01:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rdtLjZRzzi4Hvfw3bGgNgmDgVfzp0+IJ1PQoZ22aJSM=; b=e7/D5EzOzMkYaKVLluG2copW9u
	1igAG/cL4i96FJgGpZr05GUP5fWWLSrEcVBKMGoe0A9hY0fvCrmTcPIa15UJJTKtCv5HXB4eUB74P
	9MuW6PEYHKdPkshe+jswUMhDaWV6zifMhTOF/wNcZkGXp/Usy/eXZWOlgz3M4eVJlv+4DSFb3+CMa
	r5+g8QcpIK4yqgk0+85dMXlMVMpxBBTK1oynb+M+D8xycFHFXNyNFH37ndMFfwBGfhHlKrHL3MGMy
	2gnDuabwS1+U9idxb1FJX3fCmbqtCWdnQgWPbMhGyRSaew1/Bg5CxfoHMxSGVV/XxpwV4XnfXUHI8
	VG1I6Lqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSP6c-00000004v38-4BeX;
	Thu, 28 May 2026 01:00:14 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSP6b-00000004v2r-2tIp
	for linux-nvme@lists.infradead.org;
	Thu, 28 May 2026 01:00:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 92EA760572;
	Thu, 28 May 2026 01:00:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C401F000E9;
	Thu, 28 May 2026 01:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779930011;
	bh=rdtLjZRzzi4Hvfw3bGgNgmDgVfzp0+IJ1PQoZ22aJSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y6LIgsWwyumTRHyWeiBRdwhd1wLHcgb3ht+cRRsv1zQ64Sc27317bg7VgTuO5G32T
	 xhbEndXZ4yS4Wt0YC0RjjPcMosquUpM5balyoyNGloeXsWbf2Uq0inI9sXqMdzXaqO
	 M4L0kN+cheE/2n8ojtwex9BaKaEqOSf/C8kQJvMrJSgB09EG4drmsd2vd/jt6T5z2T
	 rUkjJ4LVsi8vhUcm/ukYJf0C1ha2NkFOs3rstZyJypeiMtAptZAz+8xzjUj/bXSKPn
	 K4xUjPEFs18dDmrei4zONI2gzVrwPF5+FpdCTMf2+528a51X+OeRRBhL/MX3DPH46n
	 U4j7nT4RGxGUA==
Date: Wed, 27 May 2026 19:00:09 -0600
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, hch@lst.de
Subject: Re: [PATCH] block, nvme: export and use passthrough stats
Message-ID: <aheTmeADV8aw8_iZ@kbusch-mbp>
References: <20260528005848.1517715-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528005848.1517715-1-kbusch@meta.com>
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

Sorry, please disregard. I pointed send-email to the v1 directory by
mistake.

