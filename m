Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A570CD343F
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2026 22:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DQQ4wuG8yjkqN6PgbCRpJKHVmyIGEubq32HbirxKFtA=; b=aGHA0ww2D0gRRyPIo/r/WFpUyx
	8La13aM/c9KBkEvFBX8sXbjXb4jC2jdsiwqvAC1CpiCR4GzjFRC+i3NWamTMGlr3ixl/Wl3FnW+/f
	ljk1HHVv859r/4oK732MXXnA/3ptlek0NB/l7ej4ouVDfExSb/xQBxiUAIUkYsGSXIqEWU0d9TAFU
	oyk0pSKEHutnllsSJ1bEjiXCNFA2AkhFnrhMtnnR/7BaEoITioAUVaKlPp0OZmwbaUH+RyexmIe91
	30V2nwR9ab60oIATpRmPJQHwY5sCePrw/7ejDvwDLykbZ/S7uqYMEQfqWUWfeXLamdZK3R5IW/efO
	gaX6a5WA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wP6f1-0000000H7Wh-0089;
	Mon, 18 May 2026 22:42:07 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wP6es-0000000H7Vq-3S9E
	for linux-nvme@lists.infradead.org;
	Mon, 18 May 2026 22:41:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id AC54840AC9;
	Mon, 18 May 2026 22:41:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D752C2BCB7;
	Mon, 18 May 2026 22:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779144117;
	bh=/m9Na+4BY6gmj3jriRMHq3pbKkdV5/qYlv0Jn+T/IOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P3SDih/1oJoL53BNzkIbzPha1oyZ50G9QNgJt5uLSnjNqpLa+oc5/40TUyDynToQ0
	 LnwVHg3OowFqBo5OrA5u2I/AfEVMw7ttgD2Eh7rKb3dpj59CzG6LSEKTb1lIytyVoe
	 ghL6Uxk5zfZwJINHHOvgTcXRsWe3PcDpIi/03deOXiZnnse6BkhPcvUMDsGZzUjnmn
	 cn9ofFhst63H2h9tzSAHpFESIlcP3jtooe3tAZtDKzETLRwjnN2uFM6h2gqT8qFVOQ
	 /Df6G/DttIjIqJhemOd1LngHslzU4MoTwdoaPZkvu4RbBlCRQQg2nvEkTuWXWdopF7
	 D1K9YL6xFEKrA==
Date: Mon, 18 May 2026 16:41:55 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chao S <coshi036@gmail.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, hch@lst.de,
	sagi@grimberg.me, axboe@kernel.dk, Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH RFC 1/2] nvme: downgrade WARN in nvme_setup_rw to pr_debug
Message-ID: <aguVs9t5Pvz_y8CI@kbusch-mbp>
References: <20260427003457.1264511-1-coshi036@gmail.com>
 <afzWCpJSqvjnTgpF@kbusch-mbp>
 <CACd_6n29MeACfWpqK5jaSPOVK+q5yop+eeuO_Wk0M0E5Wr7ujw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACd_6n29MeACfWpqK5jaSPOVK+q5yop+eeuO_Wk0M0E5Wr7ujw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260518_154158_882272_8D69AC57 
X-CRM114-Status: GOOD (  14.50  )
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

On Sat, May 16, 2026 at 11:53:54PM -0400, Chao S wrote:
> Not the freeze.  The WARN does not depend on q->limits, but on
> ns->head->ms (read live at dispatch, set inside the freeze window) and
> on REQ_INTEGRITY, never set for EXT_LBAS-non-PI.  capacity==0 only
> gates submission (bio_check_eod()), not dispatch: a writeback bio that
> passed bio_check_eod() under the old capacity sits on the task plug
> holding no q_usage_counter ref, so it does not block the freeze;
> blk_finish_plug() flushes it after the update committed head->ms != 0
> (dmesg: the capacity-change line prints before the WARN).

I'm also not what you mean about the task plug here. The plug list holds
requests, which hold queue references. The plug does not hold bios. If
you're not using a preallocated cached request, then the bio just gets
stuck on "bio_queue_enter" until the freeze completes with the new
limits, though it does proceed with potentially outdated assumtions.

So I think the problem is that the early checks are done outside the
queue entered context, and some of the following code depends on those
checks being valid.

My suggestion in the other reply isn't quite right for a couple reasons
(partition handling and issues with nvme multipath path failure), so
don't bother trying that.

