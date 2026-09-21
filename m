Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82FC7C982E1
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 08:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ny61zYs0caS3gVIz8LAYFEjQRdujeI4Q9bB1iCT9rvw=; b=DwQiz3dcqKz1s4Ov1qJu6hl7m/
	TdMIRtkgammmcisQATDOmygwrdEfxBohFH4ul0S2q3b3DDv3E9Zsrs6e2nFI8VpJqzhxkQVXQtwJx
	4YWojLAR1z4z5utSsI1IDVnPjCNztrGta/WkEYr8F3UYUADVKwRHT1XAY4CR11txzb2ES6cVG9ggP
	eOGg0NVu2jkzpxEfCT9xZSTjhSATI/lXPGI5+0IoWyTPImcwgVs1ecms7lnecXhovB5z565O0gthO
	XM2lo6DffG3KHQjHYxsbJGnBXkvbW8FjlkK1BLIzT8M5f5oFXJrp+ImWkUu+4s6eYZmyOzOMwsHAc
	8WP/PGag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8ZDt-00000001K47-2DuB;
	Mon, 21 Sep 2026 08:18:01 +0000
Received: from mail-m49197.qiye.163.com ([45.254.49.197])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8ZDr-00000001K1w-0TkX
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 08:18:00 +0000
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4e8c1e34b;
	Mon, 21 Sep 2026 16:17:50 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH v3 2/3] nvmet: avoid recursive configfs open for file-backed namespaces
Date: Mon, 21 Sep 2026 16:17:45 +0800
Message-Id: <20260921081745.15699-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260910052604.GC27133@lst.de>
References: <20260902103202.GB8095@lst.de> <20260910045400.1201582-1-runyu.xiao@seu.edu.cn> <20260910045400.1201582-3-runyu.xiao@seu.edu.cn> <20260910052604.GC27133@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0c30af3ec03a1kunmb8b1aebe3d318
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGEgYVhpJGktCHRlOHR5MGVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUJCSU
	5LVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=PV/FN0hW4FW2J7DTkvV9ZgFGikAqjvTtZI2sJ8BIF+4N87hw4bjV43BzqNv2UcyMfxULXVHmOwAT68yisU7P5VNCEExJolno1FEaEbdghIoRbK60Nyna6NXfjMoa9yjfo0mfdQH7/g79yMH3AhdNVwikZi0lqM7ejzQJEzLqekY=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=Ny61zYs0caS3gVIz8LAYFEjQRdujeI4Q9bB1iCT9rvw=;
	h=date:mime-version:subject:message-id:from;
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_011759_315328_F308F7F0 
X-CRM114-Status: GOOD (  11.00  )
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

On Wed, Sep 2, 2026 at 12:32:02PM +0200, Christoph Hellwig wrote:
> This section of code really should have a helper in configfs.  And should
> also be used in other callers like the SCSI target patches you also sent
> out.

On Thu, Sep 10, 2026 at 07:26:04AM +0200, Christoph Hellwig wrote:
> +	ns->file = file_open_root(&path, "", flags, 0);
>
> Can we please still have this in the helper?

Thanks, understood. I will move the path lookup, configfs filesystem
check, and file_open_root() call into the common configfs helper, and
update both nvmet callers to use it.

I will also keep the target-core caller on the resolved-root path so the
db_root TOCTOU fix is preserved, rather than reopening db_root from its
mutable pathname.

I will send v4 in this thread.

Thanks,
Runyu

