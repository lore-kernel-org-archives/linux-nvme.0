Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 158D3CD3420
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Sep 2024 11:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gIF42JgRfNoD2mega2iFl31DQpUNAP9pRUthkoFXGqQ=; b=0nPwsl+3JLnyvpBRbppS8sWq5a
	NoE7UsIrARaxkNXsBcnwkFDVKoDGUMOjSbNJrIa4U/e1oUXXdttxDPbHGthahd2TWTen1P7oIYYpN
	+Nth3LT3y5ChEsPw6hS8TTv1LYLk0IZerTbP5tRihKaoLEBFhJP6lxBoaPFJY3br6BfERDo8kucSD
	7Lzs6KER04/hucVOKLwYq3suVfJ9zhZyH8pzWciKExYUDbswcAzdLc64cUKLizgqiXZMxEs8UFM8u
	Jduitkaw1//QaP9ECWOD65Y/9tlEkjjx3l/MxBsu++4m5QWkSYrb+buhnLEVwtWvWLKhxfXe8A0lE
	K9zTyxTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slRRH-0000000HU9J-0cPY;
	Tue, 03 Sep 2024 11:11:11 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slRQz-0000000HU4g-19hr
	for linux-nvme@lists.infradead.org;
	Tue, 03 Sep 2024 11:10:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 48B68A432AE;
	Tue,  3 Sep 2024 11:10:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C8AFC4CEC4;
	Tue,  3 Sep 2024 11:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725361852;
	bh=mB23K2EPv3W5yk5ymchBdKJS7P31zj6vmBl01X3EDWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YcBm97YG03UTh0iWiqh+8IuJXwGmDgee6YbExSOwKN9+a81k8q3tND4PTNW7fq46k
	 +N9MK75UNsQAhYYlsBkVZWmH2TuYQMh5fA6ZrCGx7BBniLcHmkbv34qsDC55LiuoQE
	 UoTmZnmmGIBLHkBUEcB5DUhzax41VvJAI2C/U6tM=
Date: Tue, 3 Sep 2024 13:10:43 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v8 0/4] shut down devices asynchronously
Message-ID: <2024090330-frostily-hazing-f6de@gregkh>
References: <20240822202805.6379-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822202805.6379-1-stuart.w.hayes@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240903_041053_399911_FE90758A 
X-CRM114-Status: GOOD (  11.53  )
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

On Thu, Aug 22, 2024 at 03:28:01PM -0500, Stuart Hayes wrote:
> This adds the ability for the kernel to shutdown devices asynchronously.
> 
> Only devices with drivers that enable it are shut down asynchronously.
> 
> This can dramatically reduce system shutdown/reboot time on systems that
> have multiple devices that take many seconds to shut down (like certain
> NVMe drives). On one system tested, the shutdown time went from 11 minutes
> without this patch to 55 seconds with the patch.

Thanks for sticking with this, all now queued up in my tree

greg k-h

