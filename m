Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 873BBF31E21
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Apr 2026 14:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=djRqfPBkNVahcZFjp0o5BzT6Z5NlQchfQKtyM/aCpRo=; b=g6Y03seQC55VZkyLf9Or2LFvNE
	6jsQ/1wzIFzdHppoDt5fq/KFkLjbUYQZLG9UqlE0OzXy09Iq68cyWZ7mpZBKs483txK5X7FsAxQ6t
	OmSjsFrTDagJqfm+P+4wWAPfiyyilXGw28SeCCsRwcGc0HEWcb5cNjfPdwCbQRyS+eI83SHm355+L
	yNevQ9OmSlJbwCote6x9yULEkowU7dWVHKvY4Oy4rpjGj81XvVwM++2xzm0J4zcn6vD80iT3HjMwM
	/b91LiYEQux2gJk3P/B2v1slZ7LRJOcEalTcaobvunTgSO0L/Ha6Tfn9D5BxzTjZfNEKAFNbJEsGR
	14twTgFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAqfS-0000000AjJQ-09AA;
	Thu, 09 Apr 2026 14:47:38 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAqfP-0000000AjIg-0CZB;
	Thu, 09 Apr 2026 14:47:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B9D9942E14;
	Thu,  9 Apr 2026 14:47:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B80C19424;
	Thu,  9 Apr 2026 14:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775746054;
	bh=djRqfPBkNVahcZFjp0o5BzT6Z5NlQchfQKtyM/aCpRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DlAisKje+O0Lnmqr+zVussfrUGx5EyoJKtv8uEoz3CJtl+tT6wWPZNX39aDECpJ8b
	 bVgP93SURRCtuaDuBFe+9ehf+jfHND0Y1/cVmfADHpr++Gl7ctLO5oUJLX9eJZ2/9S
	 UxQGVmAfT/RdYtlu4mU0wJ0T2zdB3CQVdSb8xai6em7u+iDDRmCIILxqWML+yCeKF1
	 CVmu/mYqQuz+1x+nv9+ido/yjHwdANbjiN6pfavqgqrK7+7VEVgeZG+2JYjg54j3fj
	 0qs+Viz4C1LIby2TdVLejtg1KpnWQjSfUHE0Kfpm7iYbEbLiUSbC6eMcyd6u0fpayd
	 ITvz+7dpj/YoA==
Date: Thu, 9 Apr 2026 08:47:32 -0600
From: Keith Busch <kbusch@kernel.org>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Heyne, Maximilian" <mheyne@amazon.de>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] nvme-apple: drop invalid put of admin queue reference
 count
Message-ID: <ade8BAxGrW9q3DFM@kbusch-mbp>
References: <20260408141815.375695-1-pchelkin@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408141815.375695-1-pchelkin@ispras.ru>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260409_074735_102427_DE795030 
X-CRM114-Status: UNSURE (   7.15  )
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

On Wed, Apr 08, 2026 at 05:18:14PM +0300, Fedor Pchelkin wrote:
> Commit 03b3bcd319b3 ("nvme: fix admin request_queue lifetime") moved the
> admin queue reference ->put call into nvme_free_ctrl() - a controller
> device release callback performed for every nvme driver doing
> nvme_init_ctrl().

Thanks, applied to nvme-7.1.

