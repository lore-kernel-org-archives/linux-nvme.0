Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B30C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Feb 2022 08:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IznW8wrmCBZkD5BwAGQiSM8eU+KwdXLI6muGuQ/WvVM=; b=HaOaldaSiUcBePtRo56cdwpREy
	78BigVKkmdJCLF5uyRT4pFamv/2fomp6MAwf+lrNysYD1zI5QAgTUFffhFG/vwpEaZOz4mPZYLA0R
	21jtQwMajlx3Was2th8/mkaoVoUkS/LXp/+nHrXkoN+ctHRDnl48x5VHRIP0JidvmIMW3JlIVujFh
	uNvGg8iEuTQp4VIF0yPJBytbn0FHidutyKMbl5tTSrhlx8ZBaaDUSVFvw81xKauRoMVj3v4boQNb5
	YU9du6LyiKKsfrMSXueC7MiwFsLwWfBkL1fWkdgAafhha0TSewsW/oPVnE8kV0AzcO81LokUFq8c+
	NvDWaUdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKFGQ-005yur-94; Wed, 16 Feb 2022 08:02:14 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKFGN-005ytj-4w
 for linux-nvme@lists.infradead.org; Wed, 16 Feb 2022 08:02:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6937268B05; Wed, 16 Feb 2022 09:02:08 +0100 (CET)
Date: Wed, 16 Feb 2022 09:02:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk,
 linux-nvme@lists.infradead.org, kch@nvidia.com, sagi@grimberg.me,
 joshiiitr@gmail.com
Subject: Re: [PATCH v4] nvme: add vectored-io support for user-passthru
Message-ID: <20220216080208.GD10554@lst.de>
References: <CGME20220210054304epcas5p14aa9d83205f74b2e4942ed9b4e43fc23@epcas5p1.samsung.com>
 <20220210053755.451855-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210053755.451855-1-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220216_000211_363489_162D4803 
X-CRM114-Status: UNSURE (   7.92  )
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

applied to nvme-5.18.

