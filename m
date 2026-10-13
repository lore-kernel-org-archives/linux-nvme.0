Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD5DECC6B08
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 14:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hISCIOq3zZTIeWuECdggdpzdSfCe3bOvUSju4mOZVMY=; b=1vL5DRP+dBK11iWxWc2jfnZGKA
	nPAexrgq/I455CR49vf4B9rek3/jj4TcXWkD6j+mixgMT0CG3IjGQVQUajSXdV+KYbkuI/cwrUmlQ
	2dGlVLpaDpa1GJtXm6sIePBgojLcIOORw/zSzkYacoLXTAwVYQbrFt1FJ2orp+27wGi5+KO+lbuOM
	rXU3f/aKVBFNdFCa5A7f//blaBWX8mhUmCL77KDdrgek3g/hZJmg+Tzyp1rydU5JdgfkjHFSCltiy
	XDkUz/ntDfNXpWiq8Zq+ctFcm6OwzVI+dGPCtN6KkZCRvcHFwIY7iVRwAkCp3s8YaQqO5SxK2cGzX
	HpEN7HaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGdZO-0000000D79e-1mei;
	Tue, 13 Oct 2026 14:33:34 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGdZL-0000000D78x-0gSf
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 14:33:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id F2385227A88; Tue, 13 Oct 2026 16:33:26 +0200 (CEST)
Date: Tue, 13 Oct 2026 16:33:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yogesh Gaur <yogeshgaur.83@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
	stable@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	syzbot+76c0f0ce8f1e846b4f84@syzkaller.appspotmail.com
Subject: Re: [PATCH] nvme: keep a private copy of the effects log in the ns
 head
Message-ID: <20261013143326.GB15395@lst.de>
References: <20261004072052.1574-1-yogeshgaur.83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261004072052.1574-1-yogeshgaur.83@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_073331_615823_DC22802C 
X-CRM114-Status: UNSURE (   8.39  )
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

Isn't all this already taken care of by commit 72ece656abd4 ("nvme: fix
command effects log lifetime for multipath heads") ?


