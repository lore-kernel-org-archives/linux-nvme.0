Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1143C46CD2
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jan 2024 21:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hFXFxTuEaHXvX9A7qiAf5sWp9HSvn9qx7g1xtaP1Otg=; b=i7wdMT0YK9gYwBodykOyECqc0W
	FFneCEWsZ6a8v9Z9xX0V2IdIjBEF0tCHr8X9+YgcpkOfJFXaY+kd7jAo6cA//sS8ORuSmJbkn3BNV
	+Qt1YpKIGn5rXz1t+9o7qhv6PgXFdAIZaUTX72nKzN9Ca8fDYQgU24t/Yy3i6gDpNIzZQSdGUqrHv
	1f3IiWVnhViJUDI0cC6gYao97LLP2V33LasNuvlkPbxKbHtcvrBOjrmgD/02muPkdVYUgLW8vE/rx
	0SbFbjPtKLVuKc/0U8t8ggaSw5Oj2j8roQ0qYeVOHa+vqa7FpU0hR0ctOQCGF/W95a1QTSXTclUX8
	XdB9EEEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKlwv-008zPx-0Q;
	Tue, 02 Jan 2024 21:05:21 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKlws-008zPR-2D
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jan 2024 21:05:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 2859AB80DBD;
	Tue,  2 Jan 2024 21:05:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA2CC433C7;
	Tue,  2 Jan 2024 21:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704229516;
	bh=hFXFxTuEaHXvX9A7qiAf5sWp9HSvn9qx7g1xtaP1Otg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K5RpcA6ZApY3sO+ey1HQJylcQsVJXBVTPdIBq0kBtZlwf9qMtA5gXoWcNBePYoQon
	 pzQOl7GouUsWmC+qmKOiVTgH6/UG5vtWTh2zm0jrcxiIwgNJiRv853ree0+LvI3GKn
	 PmBdff5vifgIAZ4RyKwP7UX2M7NIEjwsKwhRR4of8bF0LLxILYxEiwPxMi+eA+Gqua
	 ABq+w8UA5MslM3mqkjJMJx+JW7bTiW/X1nQiM7yrRbAv1ur4eXBsmTkMgrVP0Y2zYO
	 vdBdYeBhkumkQhYweHi9aFr+he3oGuMTeIosRzS+yFiKQJowEtD/7ysrMgnvOhkUy2
	 XxV+rLprdfxtQ==
Date: Tue, 2 Jan 2024 14:05:13 -0700
From: Keith Busch <kbusch@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH V3] nvme: introduce nvme_disk_is_ns_head helper
Message-ID: <ZZR6iaGiwoLbD0dX@kbusch-mbp.dhcp.thefacebook.com>
References: <20231227093106.78551-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231227093106.78551-1-kanie@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240102_130518_866596_75CA73EC 
X-CRM114-Status: UNSURE (   9.62  )
X-CRM114-Notice: Please train this message.
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

On Wed, Dec 27, 2023 at 05:31:06PM +0800, Guixin Liu wrote:
> We currently rely on gendisk's file operations (fops) to distinguish
> between a namespace head (ns_head) and a regular namespace. To enhance
> code readability, introduce a helper function.
> Additionally, we must ensure that the device is not an ns_head before
> calling nvme_get_ns_from_dev(). To enforce this, add a WARN_ON check
> within the nvme_get_ns_from_dev().

Thanks, applied to nvme-6.8 with Christoph's suggestion folded in.

