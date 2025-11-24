Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D2ECFA466
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Nov 2025 06:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AbkeFVJ7qDSlV8hqE4hJxAujZBvjESiTLsenNqOfrxc=; b=sihnBguQPGgb+mwifT7IZFdYc8
	06nC+4zsK7vn05Fz5ERyIz24FsIK8G5eu2sWOMBz0TwlzW1BIR854FRFCURp18i/lbzzhHADC9cx6
	UbDnXfRlMhUiCjfGkSD7dLTCOd45ZUmXvPWZGyzewQDqkY2qa5B8o8aPHq715aK3PdpSek192IxVU
	UmYcBsyfu5ecI3+J33+F/4ulZRSmhUpEPizSmCZLcYEHh/FtnHpYaPanc/WPM/Czqj5piWU4XCClB
	AVtbvaWmf1PUe1UexfpS7m8qa2nJhLexCScQ+3AFpMRcrTM3JJa63ynMg/982AZA0OZ5gQOyH5WDY
	uZrtsSSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNQ3O-0000000B9qx-0oqa;
	Mon, 24 Nov 2025 06:28:02 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNQ3K-0000000B9qQ-0kGV
	for linux-nvme@lists.infradead.org;
	Mon, 24 Nov 2025 06:28:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7A37968B05; Mon, 24 Nov 2025 07:27:54 +0100 (CET)
Date: Mon, 24 Nov 2025 07:27:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yu Kuai <yukuai@fnnas.com>
Cc: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, axboe@kernel.dk,
	agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
	song@kernel.org, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	jaegeuk@kernel.org, chao@kernel.org, cem@kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH V2 2/5] dm: ignore discard return value
Message-ID: <20251124062754.GB16702@lst.de>
References: <20251124025737.203571-1-ckulkarnilinux@gmail.com> <20251124025737.203571-3-ckulkarnilinux@gmail.com> <d86b820a-46c9-43b6-9fe2-dbd991b76520@fnnas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d86b820a-46c9-43b6-9fe2-dbd991b76520@fnnas.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251123_222758_357989_C89AA836 
X-CRM114-Status: UNSURE (   9.76  )
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

On Mon, Nov 24, 2025 at 02:24:05PM +0800, Yu Kuai wrote:
> mdraid and dm are different drivers, please split them.

Yes.  Both parts looks fine to me, though.  So:

Reviewed-by: Christoph Hellwig <hch@lst.de>

for the next round.


