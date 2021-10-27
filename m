Return-Path: <SRS0=8pqL=PP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260CBC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Oct 2021 06:07:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7C5260FBF
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Oct 2021 06:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C7C5260FBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T6MffzRMTduH9bSg0/AuC1n05pNCeTqtImf2vid4kZo=; b=oHJPnv+dcG3OaFskVEAxJfUXfi
	qMfMhF0Jn83+k1H+y0QpvTiegnMzjJD0VEbRtOfAuxgaT+NTPUhi1t5wTndhpI/5vQlMXvmYnBO0h
	D9MhOrRYGSOooNAlHfePB+xlN14E/1650o8wGGXzixZhmFIzL03Z9qHN7Tg1CCd1JgWhQ6jzCwHgI
	9MWdDXTU4LoWc9Tg0vBgwxerwqDjWTfTIWW+v2qteH1pLdHn/NAPrEe2cEnrGyqKP4c5JF8LqE57A
	1y5EKuybYUfQW+a2rY6723UZmhHDhN/QUaA2S6m4uaECBA5HEZ2R6cgij/XbMwLIg2Hm0NcG5z8LJ
	Sw3h3jpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mfc6C-003yOG-SE; Wed, 27 Oct 2021 06:07:44 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mfc6A-003yNA-Qz
 for linux-nvme@lists.infradead.org; Wed, 27 Oct 2021 06:07:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 49CDB67373; Wed, 27 Oct 2021 08:07:40 +0200 (CEST)
Date: Wed, 27 Oct 2021 08:07:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Len Baker <len.baker@gmx.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-hardening@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: prefer flex_array_size and struct_size over
 open coded arithmetic
Message-ID: <20211027060740.GB9949@lst.de>
References: <20211024172921.4110-1-len.baker@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211024172921.4110-1-len.baker@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211026_230743_048080_AB5EC786 
X-CRM114-Status: UNSURE (   8.57  )
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

Thanks,

applied to nvme-5.16 with a fixed up subject.

