Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DDD9D12669
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Dec 2025 18:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z3GLYGyJ1LwbrYvAMmGyym3KcGWoWG6ckdKY2z/4hWA=; b=rpoDcbSG4rzSHJgQE88H50Y+J4
	f+EEHo/nZ2iMb+CNqxTrxejd2bwA2GYw1Tf2DrAswGp6+K3DoVm6VWZnrjgKqHq1viw0jlArK5ODg
	TVvn7xTu2ERbIznuie+XXco7y6CUynIT1DUlWOccyIoGyYoAKWig8iR04YMzBZcNEdUmZb8c7C7XG
	CHndB72UUR+OPbh4750PyFGSBxJH5YXHKY0184jEBv44CqHMiX12RePeVmM+DLg/3bp14P8gUcA1f
	0Mh9qoRPyQ+ni8e9HjwrIC7QBPz1kFvy2dt/CC8W88v2CMecc6+VcZwRQ9kJJm16C8B4djjiDDzUN
	p13nQ6yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQV8Q-00000005ila-1nhc;
	Tue, 02 Dec 2025 18:29:58 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQV8P-00000005ilL-1RwU
	for linux-nvme@lists.infradead.org;
	Tue, 02 Dec 2025 18:29:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2C3AF6019A;
	Tue,  2 Dec 2025 18:29:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A682C4CEF1;
	Tue,  2 Dec 2025 18:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764700195;
	bh=b91d4Sj/zOc1Uxp75EeHjQ7LhV7sLgUQXLlKeqKkWUw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kRCOKJPYoXWImxAR5irj7Clj8Kvh3CWOdd6PImAWYa3CFDuymiOwXHPeAtGsfktua
	 z+F2UPfiLp45Um4B3mOfOcFPeahev9+K0fzS5ihAOq0d93bNVbsSDiHU981ZXcSbwZ
	 QcX7AeCh5PTu4nbFucW72OPaXMiWJJfsuaSJhC/nKgbOfzqInX404Lu4/ctGC+lPN4
	 /vNgggKoMznnyn9Q0D/XPEMbMbLCUuZ3Tyir8Rnd0Czc2ZwBPvZPmm9qhdWtJKHj9z
	 C+b6PDHpCdQUAFRpaZkC4Bp9Xhvi5HMDXihv0aakP8RRXtlHmj18GgxXCW7jRNGj6x
	 MJsQks5kmrmaQ==
Date: Tue, 2 Dec 2025 10:29:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: alistair23@gmail.com
Cc: chuck.lever@oracle.com, hare@kernel.org,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
 kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, hare@suse.de, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v6 1/5] net/handshake: Store the key serial number on
 completion
Message-ID: <20251202102954.048fb6e5@kernel.org>
In-Reply-To: <20251202013429.1199659-2-alistair.francis@wdc.com>
References: <20251202013429.1199659-1-alistair.francis@wdc.com>
	<20251202013429.1199659-2-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue,  2 Dec 2025 11:34:25 +1000 alistair23@gmail.com wrote:
>  net/handshake/genl.c                       |  5 +++--
>  net/handshake/tlshd.c                      | 15 +++++++++++++--

We don't process -next patches during the merge window in networking.
If someone thinks this is urgent do what you gotta do, otherwise please
repost this once merge window is over.

