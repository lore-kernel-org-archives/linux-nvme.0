Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD090C77B75
	for <linux-nvme@archiver.kernel.org>; Wed, 17 May 2023 15:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N9sTOt9kI0Yb9+TAnXE9LOm7dJ8ZedMAf3coSN8YOLA=; b=VHOL84IFiGlc7Zc6rVsxWD7OVh
	YCycLFrFanO+M4FrFRL3e0JhJpPSeT3ZJH52Llt7HFhieU89I2Et0SxHjXyEzu97kYbAy0awxN7Ya
	0eQw4YT6N0bOKpm9xJrOg4k0U6wglwrBKPXcDh7xrDROhVtIpjl2DvS63MIRwne+uX1IRjFHfby2c
	uXas1n2hrou09kqUQD3wniY/UkvsydM564GexPzY2y4Cf9Ldl3rY6Q5uwvjm/bj7L+4E2myxWnikj
	hLyU8lGCb0fpAq7BtjcQOHx0QDHhc7q6y7Snc6dVIGG64NAZJSfJAuNIIJsLHrkvlnmZ30kN7zahZ
	STsCFP3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzJGQ-00AKO3-0z;
	Wed, 17 May 2023 15:40:30 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzJGJ-00AKKY-0x
	for linux-nvme@bombadil.infradead.org;
	Wed, 17 May 2023 15:40:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=N9sTOt9kI0Yb9+TAnXE9LOm7dJ8ZedMAf3coSN8YOLA=; b=rIA6k8UWWn0ZJMMW9/hbuyH9A+
	9rFPxBbh56KL6CdXrQOviPqBdOeBbOZgOFZdsGliY5sEwJssWQgBu7YyrSGY+p5OdVst7P0UOl/Sl
	9undP0MDhUG6bPGqVVye8svEevksG0pV4YqAMl27xGLMebNSdbqy4bbpO8xGZeUxKyEu2hnqq3pnr
	VFm1ZHSi/bvydKCzuD+RDBtjgXS+kuw7+v1RnxyR9LR+x2D3z0p4221lGp9MBxQY8hXk+RqzpResA
	JxrRUDTLt4PPTBp1RrLB7xEMLL4cnylNprrzvM8W2QZc4IjvTzLBBluUkvw8g3zng723oPb08kj8K
	CqMWW6kQ==;
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzId4-00DFwz-32
	for linux-nvme@lists.infradead.org;
	Wed, 17 May 2023 14:59:52 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B421F64847;
	Wed, 17 May 2023 14:59:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D705AC433D2;
	Wed, 17 May 2023 14:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684335586;
	bh=N9sTOt9kI0Yb9+TAnXE9LOm7dJ8ZedMAf3coSN8YOLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IiZVuS63UPLBaRU4Dz+V6HW1rlKj6Ktp7z65ETazSw0Qypzkza/WR/vEh9/Qu5fIm
	 AG3tn/E+w6sganQCwgQ9I/uL4W/qyk3B/8vuSnpFHnJzpEaqVwvk/QFnzqJJQXekK6
	 icIkXn9AAqgmFGfCe9fGLTkGvJt/x3SzyCChDIq5urlrT89E609V48lrrHrJK5j4pa
	 mdhyomFxrUS9VrKF+1uobPw5sRCWI6Bp8MjQM3glbkh6a1UVUlDCMTcdCeEirrizg7
	 l+lTTbp4dMR3OdTu1I/iZ2RyZY6Ck9fkztztOcBVHxv8E6Qv++PNky5P4JseQv+B87
	 LeUDVyMKHfCuw==
Date: Wed, 17 May 2023 08:59:44 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-multipath: don't call blk_mark_disk_dead in
 nvme_mpath_remove_disk
Message-ID: <ZGTr4AyeFiebpWSi@kbusch-mbp>
References: <20230517075345.246138-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517075345.246138-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230517_155951_174440_1C3E2BB8 
X-CRM114-Status: UNSURE (   8.08  )
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

Thanks, applied to nvme-6.4.

