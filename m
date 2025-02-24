Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32875C021BB
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 15:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e3foiRBgQv34sgknUUAJN0C85iqUHUU3k/vFzXbKBx8=; b=rxugvlxbT6wuUVQDrRIlpAYiBI
	yqgyzBDNFjCnE8Z9rNmbXGiM9OEX+XFm7jdbV0+L9mlHrRhHherI8xhEgjF+FlbGuKkSBAoCZar5s
	nNwbcPD0BvDkoK03s0ckm0t+Eh147TxtxvxXjCdMdyiSsN8nqJPGpAtQVxATZbAAHE3HBoOLElZ68
	0/7pP0inKXO6FZ3bHwUHsqfT0JW55Jt2YQ5As1PVkeCYzN70P0Ee1oESYuhlU10oL+UeSMKvk5zAp
	He5/W8yMEs5NfmVq0OJUPu60pZ4JE7KyMB52m5Mhnb0W98WJsBvH7Rwcb3cUHlVDqglo2/cdHT8w6
	G9bnYpBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmaAV-0000000EFBp-1y8N;
	Mon, 24 Feb 2025 15:14:51 +0000
Received: from tor.source.kernel.org ([2600:3c04::f03c:95ff:fe5e:7468])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmZrL-0000000EBX2-29Mi
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 14:55:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0EC2F611B6;
	Mon, 24 Feb 2025 14:54:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A1BC4CED6;
	Mon, 24 Feb 2025 14:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740408902;
	bh=dKZc9e3gq+oO0H966QlwGQMVdhoN7cwOA7FPVKPrTlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YqlOCL5C76tCAk6mKNeJt/4p7qAcBdHn+Ou3r2b8EiJJvT7YtvHh0ZoaKSyKzP1Ui
	 pXOEcRlvo2eNGwIZzWuK1Cxe3jkHxegR3qAUY90OozB8T+9X7fW09YojQK2huYWWZJ
	 hb5953O2gaQb1CB1oOETU5Xxib6/3P89OZLH8DrTK5C+RJktnDNLnO5NnlJajoNfD1
	 qHIfiGvGE7cte3Tk3UR5y0SbR3YWlFYkOMDzN4YRe4Bw1DMhTeoYNxQxSlxLT1ayox
	 M97/pnL/wu/b9wHa/2RiPNOxc9sqcOycc80UrW0iqZZeMqqjYpW4ZOrQmkPC+0Hybc
	 dWJ+sMuoIO61g==
Date: Mon, 24 Feb 2025 07:54:59 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Xinyu Zhang <xizhang@purestorage.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH] nvme: map uring_cmd data even if address is 0
Message-ID: <Z7yIQzPhgD1Elx-H@kbusch-mbp>
References: <20250220235101.119852-1-xizhang@purestorage.com>
 <20250224143350.GB1406@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224143350.GB1406@lst.de>
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

On Mon, Feb 24, 2025 at 03:33:51PM +0100, Christoph Hellwig wrote:
> On Thu, Feb 20, 2025 at 04:51:01PM -0700, Xinyu Zhang wrote:
> > When using kernel registered bvec fixed buffers, the "address" is
> > actually the offset into the bvec rather than userspace address.
> > Therefore it can be 0.
> 
> How is that actually going to work?  Who is interpreting that address?

io_import_fixed() treats the address as an offset into its bio_vec.

