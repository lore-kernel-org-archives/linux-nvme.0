Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83CC8C001E0
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jul 2023 20:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dgaK3GMlgmxREX6ogI2dmUjFB/kR5DwRjKuZxlyyR8w=; b=MBGBUQ4Nhu5WmwgyJsuJ3989LX
	ZN1vpuij2vd1z7bE78Xd8zvtvA6SD0JOGsyeztNRAi3eh3AzyRkSbmaQvA6YqYOx5uZMHsAjw8txy
	rgKCDYcKq/CoL9Byi5CWVay97i0AK3zUUuQYUpKWa32tEv0zZdl0FnjLIfMI3Fr3bMefBgsR70aKH
	d/Li4rz1UDmce9WONV5Wmjqsp2iBTFToGXGVEHA3kRe+fUkgQySYBXxSnQyKBx8TVjo/Wo8kGrsys
	ZiZWJhEENGLCUD0bLTrxolEjmfDa1mR0EQPB3mi1Ri2OR5sc0iQcMQChSht6IgDX+/UqhgShCYvwD
	7jNiBL5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQZEF-00HDB0-2B;
	Mon, 31 Jul 2023 20:10:55 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQZED-00HDA5-0L
	for linux-nvme@lists.infradead.org;
	Mon, 31 Jul 2023 20:10:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9F65C68AA6; Mon, 31 Jul 2023 22:10:47 +0200 (CEST)
Date: Mon, 31 Jul 2023 22:10:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Limonciello, Mario" <mario.limonciello@amd.com>
Cc: August Wikerfors <git@augustwikerfors.se>,
	Keith Busch <kbusch@kernel.org>, axboe@fb.com, hch@lst.de,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, nilskruse97@gmail.com,
	David.Chang@amd.com
Subject: Re: [PATCH] nvme: Don't fail to resume if NSIDs change
Message-ID: <20230731201047.GA14034@lst.de>
References: <20230731185103.18436-1-mario.limonciello@amd.com> <ZMgHE2wu4T4OfrTR@kbusch-mbp> <040c5788-1a7b-26ea-23cc-ba239c76efa9@augustwikerfors.se> <39697f68-9dc8-7692-7210-b75cce32c6ce@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39697f68-9dc8-7692-7210-b75cce32c6ce@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_131053_286671_0C3F2ADA 
X-CRM114-Status: GOOD (  12.18  )
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

On Mon, Jul 31, 2023 at 03:09:08PM -0500, Limonciello, Mario wrote:
> So is it reasonable to just add a check for
>
> ctrl->oacs & NVME_CTRL_OACS_NS_MNGT_SUPP
>
> In the same error handling path as this patch?

No.  There are tons of NVMe devices that only support creating and
deleting namespace out of band, especially in virtualized and cloud
setups.

