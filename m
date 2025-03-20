Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A03EC28B30
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Mar 2025 07:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=85L13trZfCuQ7be6Es1EZ0KB2bRH0NDjktwQYu6e/CM=; b=IVvpeNRVo3EQCyK8D6MNERZlSk
	b5u2TCAfdgmX9DnqGb3DozRLZY9hW0TQC5aheic1ObIpGiIS4g4UV7SKn1L8pf3WeJPYHEGb4Y4nX
	6uumsCGiSW6bZKTLC1+Pak93EDTxDiLTAMn0wj8TuPwWX0aOvnYv0MzurCp9TugsYHBQVhm+oblEd
	SPUWYzyilGi3BaAJ8bbS74BgKUO4oGboj8SoS+Udows+Kdpfgzc06rjkUtgqIVWfSgG2qRvHEZ7kY
	gU/qkVabL3XKQ5B55UCavpG/YJqgho7CHCVv6i/d20AWTSJLPkfGuZFqmWcw46BMOOQuyAMtRn5lW
	mWp6YxHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvAIs-0000000BPKO-3Yam;
	Thu, 20 Mar 2025 07:26:58 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvAHO-0000000BP9j-3N7F
	for linux-nvme@lists.infradead.org;
	Thu, 20 Mar 2025 07:25:28 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 359CC68B05; Thu, 20 Mar 2025 08:25:18 +0100 (CET)
Date: Thu, 20 Mar 2025 08:25:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: shaopeijie@cestc.cn
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	zhang.guanghui@cestc.cn, gechangzhong@cestc.cn
Subject: Re: [PATCH] nvme-tcp: fix selinux denied when calling sock_sendmsg
Message-ID: <20250320072517.GA14672@lst.de>
References: <20250320063523.2201926-1-shaopeijie@cestc.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320063523.2201926-1-shaopeijie@cestc.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250320_002526_982468_16ECBD49 
X-CRM114-Status: GOOD (  10.20  )
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

Can you send a patch for the target side as well?


