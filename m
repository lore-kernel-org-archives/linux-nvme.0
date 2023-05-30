Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B680C7EE24
	for <linux-nvme@archiver.kernel.org>; Tue, 30 May 2023 17:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AxHqjVid+U9GB6ijYukL7i8LYsIrUahBcQcuw7jUw+I=; b=06RV+NhUp2k7YUaHKIdcc2gu/I
	PKTYLk6BrVdMeD0p75UIC7eMKfj7YTqHP6tz3Qul77WPQn27Gbd57K21TRzke7C62fxhhcoRjgptU
	pUy86/2qkb+YyUxGMv/2b9QBNI9m1ZSV8psoL+r3B2KvpJ6lkukR5I6gp1eQsOVLOiAoGsfhDEeqw
	z2oNXeiCEb6Uf6ftLb2dVd1sCj4Dz7jlUPmy3COqnM7Eb15uMYJitASaOGsKMX5L7LE+MoSAaRCNg
	3pMQ599Cnl216rBRLHvTywXCpSE41tE6Rb80oERLzVCd+c04/DlZzx1JLwXcIWiwnwEc4//Mt+EID
	W2CDGP9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q438B-00EkOL-1m;
	Tue, 30 May 2023 17:27:35 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4389-00EkNH-03
	for linux-nvme@lists.infradead.org;
	Tue, 30 May 2023 17:27:34 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 6DB2063131;
	Tue, 30 May 2023 17:27:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448E0C433D2;
	Tue, 30 May 2023 17:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685467651;
	bh=AxHqjVid+U9GB6ijYukL7i8LYsIrUahBcQcuw7jUw+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FfOuoSjATe7AJ1s+yj4ra/K1TDAcZ/z3PNxKQ3jR6KYJY+KsOJOaa0hUK6zatp7XU
	 ytP6bFkAONnXolI/0StC1JHB3bGqiCtswXUwaOmhoVauEanMisajNYK082DdrvdfNi
	 W9Wu5XAutTq4u3Y5TX5THxL1dMdaVzMC3Dv0jVIKjkVYNMdYrFlwgVv88zMhpRRc0V
	 L2XY9U29Bw3WnHDGwQrM6ORIgwoQ/oBCJ2dzpjN0YlwOXTzAjAFQOpMUz6BhaS+JIH
	 hnneH0G8IQT68sSc4FGGNh+hit4xWm7dK6+iDGAIV/uAOOtdtXK3JZrqstd619zDmG
	 DVMFb/aNCfPeA==
Date: Tue, 30 May 2023 11:27:28 -0600
From: Keith Busch <kbusch@kernel.org>
To: Daniel Gomez <da.gomez@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Pankaj Raghav <p.raghav@samsung.com>,
	"mcgrof@kernel.org" <mcgrof@kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme: Increase block size variable size to 32-bit
Message-ID: <ZHYyAB/Exo4cPdPS@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20230530154254eucas1p241e57af99e4d4ee0e1a677904c3db68c@eucas1p2.samsung.com>
 <20230530154231.8313-1-da.gomez@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530154231.8313-1-da.gomez@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230530_102733_090481_1CD1A24F 
X-CRM114-Status: GOOD (  11.55  )
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

On Tue, May 30, 2023 at 03:42:53PM +0000, Daniel Gomez wrote:
> Increase block size variable size to 32-bit unsigned to be able to
> support block devices larger than 32k (starting from 64 KiB).

Looks good,

Reviewed-by: Keith Busch <kbusch@kernel.org>

