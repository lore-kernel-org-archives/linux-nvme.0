Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A37C5DF81
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Aug 2026 00:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XntyYDA1IUOiK2jqljWcQAW3VFMpiU4sihEonPM8NQw=; b=vGtM+RzU++fGFofo42HtOgWKZa
	SJL9nBjgyem7Kn8NXUWXhN2AFiah1GokXIWRcz9pNK7AGsKo5MiuDcIYEsrkpTEqN4yuLx3pik5I+
	DRpGQJ2tnnWQ1xcidwHG44qcS+TozjZ+37SoVMzhwtodLU+BOgBVgu6puImeTXe0HRhyUUTQAqhKK
	nipHb8iqKT5ueLpheNt0RQu2SVH2jYFka8jzv4IQroHzfMzLAcKd1ycyquMNOHi525EEwDzB4GPKQ
	VSqCc8kjxTobQyUvoSEVZPL+tAObfRmgGmQYCsLjuXecQO/kTgJ9AjVeg0j7clZAVPOgkfsykAH1a
	UCo/SNag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyfV3-0000000HaZY-2vvt;
	Tue, 25 Aug 2026 00:58:49 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyfV1-0000000HaZS-0bPk
	for linux-nvme@lists.infradead.org;
	Tue, 25 Aug 2026 00:58:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E5DFA6011F;
	Tue, 25 Aug 2026 00:58:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59CEE1F000E9;
	Tue, 25 Aug 2026 00:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787619525;
	bh=XntyYDA1IUOiK2jqljWcQAW3VFMpiU4sihEonPM8NQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gVwgYlDL7qoHOtmpgcVdR2bFZHvJzBr2Z/L7TOyc4cOjyz8Pc3ScH2fj8CYf/xWB6
	 hhaJW7xZO6sQBfaBzIhCNdlFQ90sU+NiUvAbV/zHKWnMJsVHxk02KxSZM/WMqXJ0Sj
	 KfwvF41QdMdGH1CbkiRoyyPuOGzMH2rtIFzr9b1QddmMvzF+G5TONP4o6indgIW4GU
	 JRQjYiZzYTdXoTP+76Z27mf4wbxOSk3iC2X9AfwBrXtjnGLeynwYDIJLa52GodMJ3A
	 kEFe+AhYJZQKNO33ard1GKs3MKgE/9yjQ3HU0sqlEy/PKrNPAgdiA80TfLqUXLDvaU
	 XOJKZdl0evyMw==
Date: Mon, 24 Aug 2026 18:58:43 -0600
From: Keith Busch <kbusch@kernel.org>
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Cc: sagi@grimberg.me, hch@lst.de, axboe@kernel.dk,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-tcp: return -EPROTO for a C2HData on a write
Message-ID: <aozowwwfA35zGM4S@kbusch-mbp>
References: <20260823074616.1996509-1-yhlee@isslab.korea.ac.kr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260823074616.1996509-1-yhlee@isslab.korea.ac.kr>
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

On Sun, Aug 23, 2026 at 04:46:16PM +0900, Yehyeong Lee wrote:
> The direction check in nvme_tcp_handle_c2h_data() returns -EIO.  A
> C2HData PDU naming a command that did not ask for data is a protocol
> violation, and the check that rejects a PDU on those grounds a few
> lines below it - SUCCESS set without LAST - returns -EPROTO.
> 

Thanks, applied to nvme-7.3.

