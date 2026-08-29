Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498DDC61DD3
	for <linux-nvme@archiver.kernel.org>; Sat, 29 Aug 2026 03:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QEyjoaZ4YFjTz4SvMH2FwGTjy4G9kfHjnURcu2krxnw=; b=nLcpsqVH0FOkDA6jVwe/Yr3+ju
	Z937z1ZGI6OeAtnoKxdj4Qt+GGCYiXsBZYMBzDpEbYLRo6t0Ui1EcD717eia3Go2B6ANr389hdZkW
	N4XzBa8gHBiUYKf/5cXDKqAwdcuw02dx7jt+eHL3ubPe49M8+1uFucSRzYOlsdqt7BfL0Ls70ZvPs
	eIfXspYGtcNI4zVfqwMSVvTHv56mL1PYBPz/JM/l/ZmxZuXzDf9TZnOze+bQKbggx1ZZq71g5zYbJ
	+KEprZGxLKwb/46RqFDU+KbY5ES/OIDRHjd+0ONEm+xK3yn7qK0lF+Tgp1sC1Wv6BkOmZr0k3ijlo
	O8q8IWSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x09qG-00000006fxl-1cwL;
	Sat, 29 Aug 2026 03:34:52 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x09qB-00000006fx7-0Ujk
	for linux-nvme@lists.infradead.org;
	Sat, 29 Aug 2026 03:34:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DC17D4067A;
	Sat, 29 Aug 2026 03:34:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE461F00A3E;
	Sat, 29 Aug 2026 03:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787974486;
	bh=QEyjoaZ4YFjTz4SvMH2FwGTjy4G9kfHjnURcu2krxnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GKNrdz92hRUt5GwZfvog3RF/vTywz+sE0LZgnw39/XLuZRnXtn3bq9zN702zGcIvG
	 Mb0LHuL79lvasVe6LgONDUg/sSSgWcBXsxKlkz+Ex6eVKrQzcWNQnboggHlGEzD83n
	 yp0mV9Lha6uUIvFvq467r8s114/eleOk92vav5FPHmLKUxVpNaKB69YJ9dr5TPfoAh
	 oQRcnAw7XTgCb9mrQzzfT0fscBONNTHkNqTiikZ4aYisW3e71ylud86OciLIORrC69
	 X6rDxuNFOCZxHIKvm48nJLSik4Z+l3KZATenHh0d/pBkrQkas+aCc8+tfrGBmkKdWI
	 VJJ5GyRu+8/0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	d.bogdanov@yadro.com,
	wagi@kernel.org,
	linux-nvme@lists.infradead.org,
	bilbao@vt.edu,
	ryan.arnold@lambdal.com,
	krishna.mohan@lambdal.com,
	christian.jones@lambdal.com,
	eduardo.habkost@lambdal.com,
	brian.kopp@lambdal.com,
	Carlos Bilbao <carlos.bilbao@kernel.org>
Subject: Re: [PATCH 6.18.y] nvme-tcp: fix usage of page_frag_cache
Date: Fri, 28 Aug 2026 23:34:33 -0400
Message-ID: <20260828-stable-daily-0002-nvme-tcp-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260827222022.45428-1-carlos.bilbao@kernel.org>
References: <20260827222022.45428-1-carlos.bilbao@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

> commit 36ac05f7cfd59d90c597071304b14e98090d5dd1 upstream.
>
> nvme uses page_frag_cache to preallocate PDU for each preallocated request
> of block device. Block devices are created in parallel threads,
> consequently page_frag_cache is used in not thread-safe manner.
> That leads to incorrect refcounting of backstore pages and premature free.

Queued for 6.18, thanks.

-- 
Thanks,
Sasha

