Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 183BACFA466
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Nov 2025 06:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qfhWGUq06KJLXqW/n3kz0UhTOrfBK9Bhsf1cCUsicW4=; b=n6jNcKERQ4lvHupZ8rA+1g+xm1
	QK/iEGhCjxVSxIERgiW4Qmf64gB0CAHfSDk9UanV7NAkhTEu4h6CmhAyszqOWmC42t5xUBTaAUW0y
	1zR43A6AxQdGH7sNA4hWvZB2HEPuBGJr7DOKVKu/2iGfKAC8nS5JnPb0UXaXYsJTszDlpIygo/4Pi
	S9Z923tKUuXn7Skwv0ydqP3snwZgo7AiEHuFtidW8/WZuZFJraUnU6Jjh08IW9tMv4j6GiXdl00nu
	w0wlPHKU9/HsKng0Gw29oIBeX4k5ClkiHQWSuZuJGUlBCx5FGDot+FYfcvrgJCD+6Lm2RzPwn1pli
	vmRl2tAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNQ4L-0000000B9zF-2Iui;
	Mon, 24 Nov 2025 06:29:01 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNQ4J-0000000B9yd-3i3N
	for linux-nvme@lists.infradead.org;
	Mon, 24 Nov 2025 06:29:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3976468B05; Mon, 24 Nov 2025 07:28:56 +0100 (CET)
Date: Mon, 24 Nov 2025 07:28:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Cc: axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
	mpatocka@redhat.com, song@kernel.org, yukuai@fnnas.com, hch@lst.de,
	sagi@grimberg.me, kch@nvidia.com, jaegeuk@kernel.org,
	chao@kernel.org, cem@kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH V2 3/5] nvmet: ignore discard return value
Message-ID: <20251124062855.GA16765@lst.de>
References: <20251124025737.203571-1-ckulkarnilinux@gmail.com> <20251124025737.203571-4-ckulkarnilinux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124025737.203571-4-ckulkarnilinux@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251123_222900_060447_ADBD4AC3 
X-CRM114-Status: UNSURE (   8.85  )
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

> +				nvmet_lba_to_sect(ns, range.slba),
> +				nr_sects,
> +				GFP_KERNEL, &bio);

This can be condensed a bit to:

				nvmet_lba_to_sect(ns, range.slba), nr_sects,
				GFP_KERNEL, &bio);

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

