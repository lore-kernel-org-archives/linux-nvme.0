Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FAFBC433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Mar 2022 08:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IznW8wrmCBZkD5BwAGQiSM8eU+KwdXLI6muGuQ/WvVM=; b=4YcXIK6InEQqVTrjS5v51IQE3x
	qYvx7SV5rMEIqqBIlqznqHnMezQX86wo9hV01k68galbQgUT4uu7W7pmxppxHTOsMggyhFpLiIpP/
	apY/dU5/G+3Ns+P/llU6xGue39k+/ZMeskJ4weG2jkf0LNW4Lrv+H/tWEzACpEhmaWN2WeZYWtgb+
	10SUSuWqSzPfrnmw3MyyZsIG59Q8PS1GnlKGOPuu77Ll8UJH9BrVaGYDX9V1PpN4SFf35J0M70k/X
	8wSue3Q3dXeQb63guoTfFthZpAWweCVtkZ3CKcJC3A2wJkFcXPjw6xednCc5ugbjqF8sQOHzO+83a
	O7JMk26A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nR8Hk-00GN45-9L; Mon, 07 Mar 2022 08:00:04 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nR8Hh-00GN2y-Qi
 for linux-nvme@lists.infradead.org; Mon, 07 Mar 2022 08:00:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id AAE3868AA6; Mon,  7 Mar 2022 08:59:55 +0100 (CET)
Date: Mon, 7 Mar 2022 08:59:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org, hch@lst.de
Subject: Re: [PATCH 0/2] nvme-tcp: small cleanup
Message-ID: <20220307075955.GA568@lst.de>
References: <20220223033657.208747-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223033657.208747-1-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220307_000002_042481_453DF05A 
X-CRM114-Status: UNSURE (   8.26  )
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

