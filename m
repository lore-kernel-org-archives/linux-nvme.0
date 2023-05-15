Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABCFFC77B75
	for <linux-nvme@archiver.kernel.org>; Mon, 15 May 2023 14:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YZhc2D9jkVzy7AfJk2YUVgKBvfauZh1OHpirItMVirU=; b=o9zMh0w3kbU4WVkQpOzwY26ECM
	jEaPtVTWz0pwsq1+HAVo12lJ4k6p+uQlpi2+IWkjyVIYecK1nCkQT8lE5TR2li8q0oRYitI1lVIn7
	O9IiNrqPv8MqjVNS2ZmimtBliMJ8ZSMWuyUgu5qTmy9Ek8yePp3whz5eN+8Del6Al5A0YoukOwZsa
	A0GxOHTI9c+Xw7hIPJ8REcj2HgWfqqWlaDZTNgh5x1FNlt0VAidko0xpTHT5NrTaZY56hEC+g+sS7
	OJZR5Tb+4+iLH/8jHqIKPXk6ZgGWJaobmWWZj41r2OlpFAfNs95XVdHRKeX2JNociZeVIvAri1/qb
	63J7whFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pyZ4w-002O4Z-2g;
	Mon, 15 May 2023 14:21:34 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pyZ4u-002O3q-1N
	for linux-nvme@lists.infradead.org;
	Mon, 15 May 2023 14:21:33 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 9DE9662021;
	Mon, 15 May 2023 14:21:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7C5C433EF;
	Mon, 15 May 2023 14:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684160491;
	bh=lKnul3tmWj3tLZgkEsGa1O/MPi5gzvyT3nQCUJQZQgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=efanRrlp5TXWSXfEaTLmJYO493vRVgbH414MpVOnof0Jub0X1E9pIJ6nA0U8vhtfV
	 LxLsPREW9qyNpLMVi+SFKRaFktXjmUAzvKW+lGPk1pJ+SPV7vFnXtdCRpy15ADs3er
	 2lGfJH/8RDtwMcFZnIZlxNkQUYytG3zZz2HWS9PnePKdTm7hU1U6/cx0M+0B1QWVTP
	 hOMPDDPohr7LZGfltSdL8vEnqoPUfq8BWW0tXrFdy1nCAYPYSYwPeTF5pLc/D/fuFR
	 q4/RPbQu3nMDaPuSsD9hVFPv9aCBTqWl+GRooqyr+q+/o3ns21R/QvgUCBvbPq8h5p
	 w1ltF0SA1+7Dg==
Date: Mon, 15 May 2023 08:21:28 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/5] nvmet: Reorder fields in 'struct nvme_ctrl'
Message-ID: <ZGI/6DT30JBfQPnG@kbusch-mbp>
References: <cover.1682941568.git.christophe.jaillet@wanadoo.fr>
 <af016d2a5e7e7bb503eadb15037b80bc9813b94c.1682941568.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af016d2a5e7e7bb503eadb15037b80bc9813b94c.1682941568.git.christophe.jaillet@wanadoo.fr>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230515_072132_528613_FE26CAB5 
X-CRM114-Status: GOOD (  12.90  )
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

On Mon, May 01, 2023 at 02:40:26PM +0200, Christophe JAILLET wrote:
> Group some variables based on their sizes to reduce holes.
> On x86_64, this shrinks the size of 'struct nvmet_sq' from 5368 to 5344
> bytes when all CONFIG_* are defined.

This patch is changing struct nvme_ctrl but the commit log only mentions
struct nvmet_sq, which was handled in patch 1/5. I'll just fix that up
when applying.
 
> This structure is embedded into some other structures, so it helps reducing
> their size as well.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Using pahole
> 
> Before:
> ======
> struct nvme_ctrl {
> 	bool                       comp_seen;            /*     0     1 */

