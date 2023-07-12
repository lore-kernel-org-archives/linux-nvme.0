Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA91DEB64DA
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jul 2023 16:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ajD55Le3p6VC1IVEG33hnuHeIDu4X+vlLtMUqIp7XEg=; b=wTevZw+wxAB8voGASGCm09gorT
	fBlfFICCJ02n8ukScfAEd9bsBCQPfn5rOyCj8EmUcmcxESpEsxiQ1gK8xcKAoC43lhF5O9dHBjzRi
	2lDCR7AIDoWc9lm9uQItwih77rvdjkTIg3y0kITmZOZnSZ0s9iX222UoK94rrDf8W12mstHIrGd7u
	dLYrBj7wkgVtCqGx6hs7Zh1f10zHbjJLhNkRWsqQeTsv16rhNW8VuTxpIo8h+csY49Pml4vF9b38S
	DcJogTVTIFPruIOnSwWpvaykfpSfUvq02WK61cDtuf5dDL0V4Zoz+BiZxQZLL5TiL5k1bASldT/KZ
	NqrfoIgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJcrG-000cXK-1L;
	Wed, 12 Jul 2023 16:38:30 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJcrE-000cWl-0r
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jul 2023 16:38:29 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id C16F961820;
	Wed, 12 Jul 2023 16:38:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC06BC433C7;
	Wed, 12 Jul 2023 16:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689179907;
	bh=yoZl52pqq/xcmMqzWfpmUaMVskUhx3cJbfxJe6IdPe4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X1oW4GzwhopR8dvLjCn4xYBw0GtX2aafGRzudg4kvbTaecuhZg1FstTJbTvS0skC8
	 aEKPu0j6s62g+HsRMvWCaqOxBQDZfe5SIhHdKzpzj7I1ftE7P9/v6pYBrJdvKxAIhW
	 LOgFcBIjQ9cHegD31IvPWFH8dizja7jXuMxr6OTOKaHzA3Qv1PH3hnaAswdhlRccDo
	 TtAuX5xaOge1L2WjcTv8LA6n5Qm4B2ma+LjN0ebloFM6N46/XZLTK5V/+dCucKtIdU
	 E1hCOsRgo8q25n4GYDSBPMX5HBzLFCnw8lAdvei0id9Z3gMUO7rTwFs90WxTN+Ex8u
	 gPrpZ8CGwXsNw==
Date: Wed, 12 Jul 2023 10:38:24 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/4] block: don't unconditionally set max_discard_sectors
 in blk_queue_max_discard_sectors
Message-ID: <ZK7XAGnwU2CLbXiB@kbusch-mbp.dhcp.thefacebook.com>
References: <20230707094616.108430-1-hch@lst.de>
 <20230707094616.108430-2-hch@lst.de>
 <ZKvgnI5qZ/Z70ycL@ovpn-8-33.pek2.redhat.com>
 <20230712162310.GA29557@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712162310.GA29557@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230712_093828_346141_61DAF93A 
X-CRM114-Status: GOOD (  14.34  )
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

On Wed, Jul 12, 2023 at 06:23:10PM +0200, Christoph Hellwig wrote:
> On Mon, Jul 10, 2023 at 06:42:36PM +0800, Ming Lei wrote:
> > Userspace may write 0 to discard_max_bytes, and this patch still can
> > override user setting.
> 
> True.  Maybe the right thing is to have a user_limit field, and just
> looks at the min of that and the hw limit everywhere.  These hardware
> vs user limits are a pain, and we'll probably need some proper
> infrastructure for them :P

Yeah, I had to do something very similiar for the max_sectors limit too:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=c9c77418a98273fe96835c42666f7427b3883f48

