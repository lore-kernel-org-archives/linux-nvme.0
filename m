Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B9BC35FF3
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Mar 2025 06:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=27KmGi7h5nB1p8p4616q7p1chkRefL+ulFQEMrpSQVk=; b=YlbBtUjGlt8PDTJfcmhmFyEP1P
	kaC8zxYJ9bKWPR5cbsE0SfDkC5dsmaBMaxmu2BDfOwe4Gkl8unR99SIgUPSHVD9pSxFkCMZxiUGSt
	Mvn+9IIddLFtt7W8tNL51qq5zQXhb1nWX6UFjRkfJs+Ws4vDtCrAgoejfIhwBQMbi0mVXUZvWwvpH
	CajwJm9hmyncEq/uRQitlxGhxCIo3xs6rJguTAwKhfKabqggKVkRffvbhX5T+RrPI5A7CAOQrWQYc
	oR9A8DWdsuxLmP4H1mDhI850x5a/Ys/Y3Tfz47od1byUG5Cdo6Cz76pFc0fY00lhrLittaKQHjRHc
	SlcOWXhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvVj6-0000000DyuY-1aVL;
	Fri, 21 Mar 2025 06:19:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvVj3-0000000DytU-3TVZ
	for linux-nvme@lists.infradead.org;
	Fri, 21 Mar 2025 06:19:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8ABA768AA6; Fri, 21 Mar 2025 07:19:22 +0100 (CET)
Date: Fri, 21 Mar 2025 07:19:22 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 17/18] nvmet-fc: put ref when assoc->del_work is
 already scheduled
Message-ID: <20250321061922.GH3198@lst.de>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org> <20250318-nvmet-fcloop-v3-17-05fec0fc02f6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-nvmet-fcloop-v3-17-05fec0fc02f6@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250320_231926_008238_F1EDD23A 
X-CRM114-Status: GOOD (  12.49  )
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

On Tue, Mar 18, 2025 at 11:40:11AM +0100, Daniel Wagner wrote:
> Do not leak the tgtport reference when the work is already scheduled.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


