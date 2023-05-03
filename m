Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC2BC77B75
	for <linux-nvme@archiver.kernel.org>; Wed,  3 May 2023 16:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9zti7q8ZyeKskrlUo5qOh/lOMsR3cQk6t/fkiOgVlZ4=; b=BRc1Q5ib6SzoLJziKf3sBZdCj2
	Ozqz6mqeun7qPixoHbwDElcFaMtnfMxckSN8IfAPN/geUxOrchxvRHy3j/YQj9ABpT5aklWtuegbL
	K9gXDgouJqx+RELCKXM8z2yqN/o69Nq8hFGX7zPekVFY+a0YiOLPxJedpslDXKU+CCeRmWaHFe3J+
	vHtF99BviIwqUqgzSE9ecBLunUwjQB2McfWY0Nki4j4IufL4rtvW0UI/GH2v+dCEbkmJsFDS7ag9P
	/BO56I1ZnYYND9qyDXQXdIGJ9Lf28XJZMEEtGnOnM7sDyoX1NcauLYKpzfoy+oPLFR8ZCdMi/rRcM
	hG7itOvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puF1L-00536q-1y;
	Wed, 03 May 2023 16:07:59 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puF1I-005366-26
	for linux-nvme@lists.infradead.org;
	Wed, 03 May 2023 16:07:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D258068AA6; Wed,  3 May 2023 18:07:52 +0200 (CEST)
Date: Wed, 3 May 2023 18:07:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: jiweisun126@126.com
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
	ahuang12@lenovo.com, sunjw10@lenovo.com
Subject: Re: [PATCH] nvme: add cond_resched() to nvme_complete_batch()
Message-ID: <20230503160752.GA683@lst.de>
References: <20230502125412.65633-1-jiweisun126@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230502125412.65633-1-jiweisun126@126.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230503_090756_849898_37A740B6 
X-CRM114-Status: GOOD (  12.08  )
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

On Tue, May 02, 2023 at 08:54:12PM +0800, jiweisun126@126.com wrote:
> From: Jiwei Sun <sunjw10@lenovo.com>
> 
> A soft lockup issue will be triggered when do fio test on a 448-core
> server, such as the following warning:

nvme_complete_batch can be called from irq context, so I don't think
a cond_resched is a good idea here.


