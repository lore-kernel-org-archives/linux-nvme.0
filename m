Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83338C433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Dec 2021 07:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lGI+c5un0a6ccc/9Hs51h9xYaU9wDB+HD4c7sLwemWs=; b=n7rzk8x+1EyYEPu0z4wvsG4KPq
	Odfu0GxsCRRFQUiZACA/EG87xup8hYW+iMhw4zs0l3wb5n3CBkCuAwJih0OnjVfqrUvqTmu2waday
	mt03Cu3r6NbbgfeRbLSIx5GygIcn7dho3wkZBkYwtEV0Hs8sgHy9rAmy+nFdQ2/QoLZA/QKu6UbEF
	t+mEKLAazV49ETw+nzp8zFfzpITAlTg4sllIbFQsXsIGw9b0kVukG4x1+NfgqPLzPTTbghjr/qBzo
	FNV/xJC3FoGazQSRjDj8rDUxd8eDbHVVTbH46nJNmgk1esYGBcdJD86UXQmkPC5XO6Qk5EfQzb3VE
	Ggxn4nhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mu8aA-002mSO-RB; Mon, 06 Dec 2021 07:38:42 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1mu8a0-002mSE-UM; Mon, 06 Dec 2021 07:38:32 +0000
Date: Sun, 5 Dec 2021 23:38:32 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 2/4] nvme: split command copy into a helper
Message-ID: <Ya29+OXo3SBh7UNo@infradead.org>
References: <20211203214544.343460-1-axboe@kernel.dk>
 <20211203214544.343460-3-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203214544.343460-3-axboe@kernel.dk>
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

As mentioned last time I really don't like the proliferation of
tiny helpers with just two callers.  See my patch I responded with
for my alternative.

