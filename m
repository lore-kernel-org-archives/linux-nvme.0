Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 091C9C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Dec 2022 16:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ceaPtYcw9u4YS49PkJyz+Ahnp83LFsBTpdyhwKba7k0=; b=3+OAVc3CPU/1D++k2vHX2LNjsZ
	KTxCitVmK7Gxd1PH3BWr2jvuLYcCWAzv0grAljzFyaPtTwBK0ZmH6W/dOD6c0TqWkUsbdbJChkr5D
	XPehDJwCquFB/jL5VcbiXDXuLyTon1xbsxWJiY4UxkHy2MQ2DdLM1gHLczhKvENHMzIcTaoedm+it
	RQBjn8h9dLaFjNX6U6AbAUdLq5GQQ+yELRm1nvCvKB37ILnR+xCradZ9BVIxAoA+YR7oH/mq2W208
	zV7XLkpJJ6FDAuGkLqAAm4p4VKsZp8UMugJc8z/pa6/8w1Xh4ZbUpTUNir1sjmv9C4jvcLyqJ3bZ3
	e5Bd5tyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5UkH-000h3P-S0; Wed, 14 Dec 2022 16:36:37 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5UkE-000h1e-Rk
	for linux-nvme@lists.infradead.org; Wed, 14 Dec 2022 16:36:36 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 6065B61B39;
	Wed, 14 Dec 2022 16:36:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55ABCC433EF;
	Wed, 14 Dec 2022 16:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1671035793;
	bh=ceaPtYcw9u4YS49PkJyz+Ahnp83LFsBTpdyhwKba7k0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DZomkb+xFxVRTBZJJ5JaQirKMrAemzNVfPmwQ/y+vIGWuy8F61UJR2oWUzdQAWMzz
	 f4AJwauhiah7JiCBOAdva4DJlB2dykF5vOYxN+zFbHCKOlg4db6nc8CWXl2p2GaZKN
	 mw/w2A2/ZzT3zVqfTdo1FyHe1WA3kKf2A8gsO5n2deeddG+dTB+GyJ+LJImKhzNflT
	 rxv35SlSk8DJFrvamt7YVQs93ZSE5quRb+1L45bUpvYA/+wwfFyDu30d+yeEs6B38j
	 f98jd3JskT8LopVWvZWEv7JA4KMnehAFpBog+G3oc/beN+ot6TzSV6YFFg8CaYHIeK
	 QgHvCIiaG6HaQ==
Date: Wed, 14 Dec 2022 09:36:31 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org
Subject: Re: only allow unprivileged passthrough for commands without effects
 v2
Message-ID: <Y5n7j/Fx63k0dojY@kbusch-mbp.dhcp.thefacebook.com>
References: <20221214161347.764071-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214161347.764071-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221214_083634_956332_404B87E8 
X-CRM114-Status: UNSURE (   7.96  )
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

I only have just the one comment on patch 7. The rest looks good!

Reviewed-by: Keith Busch <kbusch@kernel.org>

