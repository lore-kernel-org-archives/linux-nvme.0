Return-Path: <SRS0=GOb3=P4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B091BC433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Nov 2021 08:06:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7524761105
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Nov 2021 08:06:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7524761105
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GN/TiYAGxbJFcwzF452hC/K/+sMsX4GUTUxvtXcs37c=; b=LnI6g1F7jqvOguODAJKQBZ2GV2
	M3vt6EcE+XkJY8q+NMuZwdapHL4oyhLXJaIueXrqGM9skAHIOKIzoP22OkkbwuOp0Le9ccAlFLzlf
	by6wNgnweUwigeTpo5Ssczld3e4TCyyahgKIy6televbmXlqe9EL+3BoiwfH1GL+Iozw9iADJmjs5
	ed2ufSdZrkIhomZFdPhdTGO/CWEbbmWOuBv9jF4iRzW8d9X0dL+MmgiWb4XpvR/YLUnqaV1KgCjaT
	pp7MNrv+79g22HhHMe5hHq6DLW08PG0kS9krxEEegQ80IjbcRqtBHBITLxeTgTkAO/DbzH2o0BQyL
	1dlbrq1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mkM9T-000vrw-VZ; Tue, 09 Nov 2021 08:06:44 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mkM9R-000vqR-6k
 for linux-nvme@lists.infradead.org; Tue, 09 Nov 2021 08:06:42 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6199A67373; Tue,  9 Nov 2021 09:06:34 +0100 (CET)
Date: Tue, 9 Nov 2021 09:06:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Enzo Matsumiya <ematsumiya@suse.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] nvme: add NO APST quirk for Kioxia device
Message-ID: <20211109080634.GA28581@lst.de>
References: <20211106020858.18625-1-ematsumiya@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211106020858.18625-1-ematsumiya@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211109_000641_439057_1C097EC7 
X-CRM114-Status: GOOD (  14.81  )
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

On Fri, Nov 05, 2021 at 11:08:57PM -0300, Enzo Matsumiya wrote:
> +	},
> +	{
> +		/*
> +		 * This Kioxia device times out and aborts I/O during any load,
> +		 * but more easily reproducible with discards (fstrim).
> +		 *
> +		 * Device is left in a state that is also not possible to use "nvme set-feature"
> +		 * to disable APST, but booting with nvme_core.default_ps_max_latency=0 works.
> +		 */

Overly long lines here, but I can fix that up.  Do you have a product
name for this device or is just a nameless OEM controller?

