Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8598C43217
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Oct 2022 10:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4kajveFilTfP+a7/zkmsBqY+P5MBUkubBpbr/PfelZs=; b=XpNNbt/F4rN1XW1RWqGYd0ah2h
	xGv1R7WgCzqrkNeAxTngTG7F85WDvm69tQLIeFkWalLeGiRksCgVRMkQZ74YjSThd4N3ayJ/sjIji
	pdqr5bI5A5OV1JLe2Ols/9PqPTUIWIOlMiqf+SXyDuhF/i4idXrw81aHS4FgmUPTInUXHtUlffeyu
	YcCDAw2v5P0DGUj7/WNLEBZZGSFW4zUS07IRoLTryCoJeSwO9Qcaxny9IMmPG3DD+AcjYU91lMsjr
	GZg+aYGjkSPSEm6kORWgrygW5gSK9+Wu6vPGbF6cUWemACZl/3xMgJGHd5t+MEzFyVrUrEsc++P4E
	6bIDDKdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol6WZ-000PVl-QS; Wed, 19 Oct 2022 10:42:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol6WW-000PLZ-3l
	for linux-nvme@lists.infradead.org; Wed, 19 Oct 2022 10:42:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 01F1368C4E; Wed, 19 Oct 2022 12:41:59 +0200 (CEST)
Date: Wed, 19 Oct 2022 12:41:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org,
	fancer.lancer@gmail.com, linux@roeck-us.net,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme-hwmon: consistently ignore errors from
 nvme_hwmon_init
Message-ID: <20221019104158.GA25515@lst.de>
References: <20221019083744.993792-1-hch@lst.de> <3ba99d83-e8ac-8aa1-4ae6-28a99f9417be@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ba99d83-e8ac-8aa1-4ae6-28a99f9417be@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221019_034208_330829_D01ED3F7 
X-CRM114-Status: GOOD (  13.75  )
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

On Wed, Oct 19, 2022 at 12:39:08PM +0300, Sagi Grimberg wrote:
>
>> An NVMe controller works perfectly fine even when the hwmon
>> initialization fails.  Stop returning errors that do not come from a
>> controller reset from nvme_hwmon_init to handle this case consistently.
>
> Maybe I'm missing something, but nvme_hwmon_init is not called
> from the reset flow, only in the first init, I don't understand
> how the commit msg follows the code.

If the controller is reset during initialization we'll get EINTR
here.

