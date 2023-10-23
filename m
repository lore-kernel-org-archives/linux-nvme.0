Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 732FDC00A8F
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Oct 2023 23:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H1ivkXcr+66tURHXyctCsEOxTVIY4BjtCVwEL5HhTE8=; b=PMFHbIb/Ty61lUWhHdvu5EqVS1
	LEhh6YEnAOaV2ppRnpEVa+xckyPzSqeg1HxRdDWZHjCZ/uHoiNO+7T2rtHWDz0bh3fScvm3/Dj1jC
	1XeBaAlWa1q30/vA8yFDUntxSJijne0MYIQAcX3JXnsg70nPAyCwbr7JXgRhDqX78gcViY0T7fX6E
	wQXGKL/+A3IMAQLBDL7rEQkNKxBL0BDfbSBIDT/7MaC8iBj0ozHc8yOri80EMzG7J1IsLhP05SI0o
	iwV1KCML9x7HYjN5IVfiDogXyJuDFoGODkH6MdtdK+16lQM52VKnyZr+ibVopbjltaN/meXFgD7jy
	hZsKnuiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qv4AE-008Rdb-1g;
	Mon, 23 Oct 2023 23:16:50 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qv4AB-008Rci-1x
	for linux-nvme@lists.infradead.org;
	Mon, 23 Oct 2023 23:16:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 47046CE29F1;
	Mon, 23 Oct 2023 23:16:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346A1C433C7;
	Mon, 23 Oct 2023 23:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698103000;
	bh=wuN54UsyNNv+JyJ6blhNxh1QMt4TS++YoVS2RdrTFfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RSJnUsLo2ycGNEAWeAw7zzuTm01aKO5q+qDgHo6XPxTjVh0Qyx7JBBJ8jlRXrO4aJ
	 P64kWXFg0r+eaQIVwR7p/y5u0KHHLnILpSpCyLZB1acPdercBLRhYEE4DPacHoARDE
	 RarYKEkgbFhv4ypDu+MrhtS5I2ABH2KA/Wxa7fOtYA220Qh2hDFBR5ekeTTMye4AIk
	 HXpB3rQwpHNWt2d5a4jDNz1gVtn6rcebHAxFpCH+OUhk9K6Uo0Xtnbv4pB/MqLk3KR
	 fj4383h+ldDAMDZgYUC7LOf8MVTSUQhGhSTrSVbV+QaO288bDkFXA5JAKOOlNEw1wY
	 aSQ+g/sNXqCYA==
Date: Mon, 23 Oct 2023 17:16:37 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 0/4] nvme: start keep-alive after admin queue setup
Message-ID: <ZTb-1XJyQfLrSC1a@kbusch-mbp>
References: <20231020142600.47246-1-hare@suse.de>
 <ZTKdFHTw3949UKTv@kbusch-mbp>
 <94326b59-60c1-4d0b-863b-cec0f9bfe1ac@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94326b59-60c1-4d0b-863b-cec0f9bfe1ac@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231023_161647_824003_55ACDAF8 
X-CRM114-Status: GOOD (  10.32  )
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

On Mon, Oct 23, 2023 at 11:54:37AM +0200, Hannes Reinecke wrote:
> But we start keep alive unconditionally nowadays; each and every
> host driver (including PCI) is calling into nvme_start_ctrl(),
> which calls nvme_start_keep_alive() without any checks.

I see nvme_start_keep_alive() is always called, but that checks
'ctrl->kato' which will always be 0 for PCI.
 
> Be it as it may, tying it into the state transition won't work
> as the 'CONNECTING' state is entered _before_ any queues are setup,
> so starting keep-alive here would be too early.

That's just IO eueues, right? Keep-alive is an admin command, and the
admin queue should be up in the CONNECTING state.

