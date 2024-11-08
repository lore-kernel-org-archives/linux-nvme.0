Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24317D64072
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Nov 2024 17:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E6nOql+I8vxQxgztedJ4KzjHPXz43vgb7DqapJ/yDck=; b=PZ9qPvMWeg+hbRuswq/CI78qhX
	YiJwluNbQVWAr1w1A5WnEJ4E+F3mvl1wGwlPGsGQhKyn3XpQUt5UNSXjRDa2XemL3jMtqwUm9IjNZ
	67OEjew+n90iaNFTZ9NiA1l2Nhc187iLJ/UUxx7nYdiGtOS0tufT/SjE6ha3SHkkokeg+/iHo8+ek
	okNvwH3chcL05fIuA1vwDTiU+xQmPMvkWQANy1HCwjdxBHEO6lhI7WkAwANADJZQHDPj7Uo42gVBP
	N4jGBaUAWDcROQ3lz+M4HVDyJO61pDQJH6gqsUX4Vu2zF5QPgJS7V4OdhkNm2wUwbNDnEbDHkWnmc
	tAHxqfDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9SVL-0000000BKh6-1ERr;
	Fri, 08 Nov 2024 17:10:39 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9SBX-0000000BIdh-2sww
	for linux-nvme@lists.infradead.org;
	Fri, 08 Nov 2024 16:50:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 51273A43F00;
	Fri,  8 Nov 2024 16:48:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DEA1C4CECD;
	Fri,  8 Nov 2024 16:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731084610;
	bh=E6nOql+I8vxQxgztedJ4KzjHPXz43vgb7DqapJ/yDck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F8c93RW78V9xqQrC0NC/IP11+7gsmvM8HfcI0csNxFqxTBXpSD9XozJRqEHohQ0/u
	 FPDYSGBXFWrCviRNRgDvlQ3ujztb3svsRrlZE7ZxKGh/mjJ07yvqH4vdKO3udfMOLH
	 b3ixyBu2ccmsxAKoyg8+rc75cKELA2VfHldpowoL388mtIFCA8ZmjVisn8Tlwi0V/7
	 RCVGTi5Ud11+XnubG68XPgLzNYGERqvhglPfDvguyAYGxKgIvAXcGX/uIm2iclgj4d
	 wkyRG3Hxzbjfz8UNd2gN9wg/iVwRFpWSzOcpIU1rJRkAIUdpHhLU9aJTGm+Hgqbi2j
	 uK+0cHNjcECPg==
Date: Fri, 8 Nov 2024 09:50:08 -0700
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, m@bjorling.me,
	matias.bjorling@wdc.com, kch@nvidia.com, kanie@linux.alibaba.com
Subject: Re: [PATCHv4 00/13] nvme target 2.1 and independent identify ns
Message-ID: <Zy5BQClo4bOfUQj2@kbusch-mbp>
References: <20241107193849.995554-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107193849.995554-1-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241108_085011_812807_9EBC8BA4 
X-CRM114-Status: UNSURE (   4.45  )
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

Patches 1-12 applied after merging to nvme-6.13, folding in the
reservation logs and features. Also included feedback from patch 4 (code
style alignment suggestion) and patch 9 (cpu_to_le32(anagrpid)).

Patch 13 is on hold.

