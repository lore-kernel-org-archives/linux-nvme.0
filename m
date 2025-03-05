Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE52BC19F32
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Mar 2025 14:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=R7WP8JAHy3ugpZYRlrQkHC4u9r
	smiyI0RBKSeXtHF3JXb9Sm8jWnlhrlI8xgeyL8HAb5kXPw3P++tuiN7s/f1dsZyYSbWvLevFyiyvH
	IPofk819mZTkAm5nmnCOFGHPMZqahHSJ+AJQCmql1AUuR1qcqGoCe8DdIWJXZvneRVwtFJYTBC1uX
	PeFJphmhtnSQwkAmy8h5mpRbxNI8Ju9+mjlSUlSXxh9YBcUAOrOvlzXIM7M5/ij70KHb5ZydRfmWv
	r9g9SFYtnSnJHKTGCph/LbqowhdTFyrGPFQHkW91gCIzIhnpX2DMWdpkDwwsMRfDhgAy5b+spsvro
	Vophpt8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tppY9-00000008JHV-1Qbx;
	Wed, 05 Mar 2025 14:16:41 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tppY7-00000008JGg-02D7
	for linux-nvme@lists.infradead.org;
	Wed, 05 Mar 2025 14:16:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A25FB68D05; Wed,  5 Mar 2025 15:16:35 +0100 (CET)
Date: Wed, 5 Mar 2025 15:16:35 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] nvmet-fcloop: remove nport from list on last user
Message-ID: <20250305141635.GB18065@lst.de>
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org> <20250226-nvmet-fcloop-v1-1-c0bd83d43e6a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226-nvmet-fcloop-v1-1-c0bd83d43e6a@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250305_061639_180968_85CD3B4A 
X-CRM114-Status: GOOD (  11.18  )
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


