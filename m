Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2ADBCD342C
	for <linux-nvme@archiver.kernel.org>; Wed,  6 May 2026 13:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=83n9Mwh2keXXrkIESUma1xMLfV14i921O1ykhlUEb8k=; b=lHR/1dGOTcn7yu+m6X00kdfTJA
	J02LggagIOfuN2AtV6VhiFcBj5/A40If9jOtuwPez1VM6/pDfA0ciPA5YpvN7hdqDTs4qsGU1K6zX
	dNyqnTScq/dewu3Wg1MKlBDzZHsa2ziCnn1HjhXw0+WI2hNzkjVp/4XW1t/i5c/RVK5J3O8aYNJQ9
	T70iYbV1hfG3L9v7dn+qWqHHrv0mDLD4BUuIbubcZhjHpE+R+1D8luUI6opryzwN41r5yCQhEYwmu
	3ZRuxlOtf5AqmC2GG8TdVkoQ7IwBzJziitDCS0mr7od39gSzR1oBgQbWNnCVnwej3sMisHH9ZkC+V
	cMQXB+mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKcGa-00000000tMh-20MZ;
	Wed, 06 May 2026 13:26:20 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKcGZ-00000000tMO-3hsL
	for linux-nvme@lists.infradead.org;
	Wed, 06 May 2026 13:26:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0CE0860103;
	Wed,  6 May 2026 13:26:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C53AC2BCB8;
	Wed,  6 May 2026 13:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778073978;
	bh=83n9Mwh2keXXrkIESUma1xMLfV14i921O1ykhlUEb8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D/o/cYFaU3VB5RmB/mkX6wi+tfXA8K5vZKT1V2piWzU/6kwl/icBWfwvWNm8jJmP9
	 zubdgayODxa9ZYVpDih3sQ+C8JljgC+pAl1s51osagVpB+l1/e1FH3uDYEXDanUzTt
	 Vmj9+6t1NZ3rsl6WI6WgCiqhDhAry5/cvpjCSXVLQXb1Wzl208y6OgGPlK17hhKYvs
	 1eYHvAqSeYs5kBqyMmQdRE8/gAaMQ/CIV0P1jQjtDsJmFO/h4LedOZq3pvS1oEjzcp
	 FTCSWCXnMwMojguThamZp3H5rZ2Iwq0KYhJcqI3/75uB8mLMKavVTiJZ+DlI6R/CCa
	 SNjwUyM4AO1Mw==
Date: Wed, 6 May 2026 15:26:14 +0200
From: Keith Busch <kbusch@kernel.org>
To: Armandas Kvietkus <armundunelis@gmail.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] nvme-pci: add quirks for Lexar SSD NM620 512GB
 (1e4b:1202)
Message-ID: <aftBdkJuBM9ouC8s@kbusch-mbp>
References: <20260504074433.28493-1-armundunelis@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504074433.28493-1-armundunelis@gmail.com>
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

On Mon, May 04, 2026 at 09:44:33AM +0200, Armandas Kvietkus wrote:
> The Lexar SSD NM620 512GB has an invalid SUBNQN field and reports
> bogus namespace identifiers. Add NVME_QUIRK_IGNORE_DEV_SUBNQN and
> NVME_QUIRK_BOGUS_NID quirks to suppress the resulting boot warnings

The subject said this is patch 3 of 3, but I only see just this patch on
the mailing list. Where is the rest of the series?

