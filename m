Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D27C43334
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jul 2022 05:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+DcPBcHU5PVAmG0GHe/yyBDo0u+ZeTdeTelZP/18JhQ=; b=stjxLCVE/2ro2hvXgBLxq0L0xJ
	kDsiDT0p3laN3efXtbV8KEqLBLLSowh2uZ6vnOG7dZlv+1Q1aN+LF4j/ocgj9T8SznaEbLU+APGSD
	218Q9SShP9Z/+1qzmW+pyBb9NDfiye38ddY4WMgf9awJYvfDQHdvxULQtIb9ngpBp87LPbz8b8KNK
	9qkUxZCnQvMRpNzbxzzcvcpjwDO5uJd28QLjoOoOd4Knesxl7v0ftn074mM7X7PDQ/+6xXvbByGP5
	VBNm8YiX9NjceQnzVsq8FRYzT6qDb0RzXY5LGUHhudwsh+T9lGVjI4WLUmzaxdEM3YzJOydCGrClF
	lT7GbP+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEOw0-0003zU-Js; Thu, 21 Jul 2022 05:41:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEOvx-0003gz-HV
	for linux-nvme@lists.infradead.org; Thu, 21 Jul 2022 05:41:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EDF9968AFE; Thu, 21 Jul 2022 07:41:00 +0200 (CEST)
Date: Thu, 21 Jul 2022 07:41:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: hare@suse.de, linux-nvme@lists.infradead.org, hch@lst.de,
	sagi@grimberg.me, Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 1/2] nvmet: fix return value check in auth send
Message-ID: <20220721054100.GA19978@lst.de>
References: <20220718231233.3886-1-kch@nvidia.com> <20220718231233.3886-2-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718231233.3886-2-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220720_224113_744285_D5D8BD26 
X-CRM114-Status: UNSURE (   7.91  )
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

Thanks, both patches applied to nvme-5.20.

