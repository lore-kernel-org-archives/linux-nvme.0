Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45CC8C54F55
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2026 04:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=eqjfbKdgIuPueWsYTjZqNE00oB
	zpTNXgn6d3FbiLwlEL5Cn6SHbwcpJl/P8Qne0fPyHXVryF9FSAAySK8KDudDY6SeP1hPE3Qzl50WD
	DqjWFhrwJSulrGXQYHf9WHZa3wLrmYDGQwMYgR3LGn5wM4jfc27xqzOlUJQVqoZwSXYlb5KKfxstQ
	zEqNwUh5062svQaGM5ZeqwY0SxPxsAbzbJkhV3luR+szLmA1eJEQBrLylaXrBEIZqDp4IhzQMU6YQ
	GD25o8s9veXpJcAUX19sIiOrcc4qAMCWOZrNR3NLkW7kvYXljMDgywj0AOfLOYkx4cbCPqxG/rrLI
	72wFEjZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woZMJ-00000004NsK-0iYo;
	Tue, 28 Jul 2026 04:24:03 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woZMG-00000004Nrj-0ikZ
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jul 2026 04:24:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4C40968B05; Tue, 28 Jul 2026 06:23:57 +0200 (CEST)
Date: Tue, 28 Jul 2026 06:23:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chao Shi <coshi036@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, Weidong Zhu <weizhu@fiu.edu>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: stop the timeout timer when releasing a never
 added disk
Message-ID: <20260728042356.GA19874@lst.de>
References: <20260727201257.211635-1-coshi036@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727201257.211635-1-coshi036@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260727_212400_368252_EAFDB45E 
X-CRM114-Status: GOOD (  10.57  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


