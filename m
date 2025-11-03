Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C55A0CCF9F8
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 11:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MKJuDyzMYpC4p9udbkgW6jYEMAYBxEipPY7uSuKbOr4=; b=k2mwuKRrqzK4SbcBkgeyLvOFk5
	bJOvk+8yt2CHh5R0QlR4OIj/XoZGhzexNFpEn39BDGSdm/szEKLv0pQaTFocat7gcjsY+5ZFCksV5
	vhL+6hFR/7YAhB6w7R0SWGOYZLsFzb48xJZiWHMfMF0ba56q/e8XA4p9Wf01OsnlaaUqyVKEh5hRQ
	DvHfCzO11ENR+1NlBL9gcTvpEqcE7YUwRcJAkNK//hdiMjqpOsIJtTSS/49oBtlr6y1Fj83Q4CaPT
	bo+6a4GDpzABdXTB1vNCg5H5tcVfSIj0eiyJqwv2phj+3P5w0DNcN6XO/1HJ+dqMVyFijRLeeolGI
	/FKve/gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFt0Q-00000009lVU-0hqO;
	Mon, 03 Nov 2025 11:45:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFt0N-00000009lV0-2YOT
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 11:45:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 44D44227A87; Mon,  3 Nov 2025 12:45:43 +0100 (CET)
Date: Mon, 3 Nov 2025 12:45:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chu Guangqing <chuguangqing@inspur.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: Fix typo error in nvme target
Message-ID: <20251103114542.GA15280@lst.de>
References: <20251103024131.1855-1-chuguangqing@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103024131.1855-1-chuguangqing@inspur.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251103_034547_806428_83F3593C 
X-CRM114-Status: GOOD (  10.14  )
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

On Mon, Nov 03, 2025 at 10:41:31AM +0800, Chu Guangqing wrote:
> Fix two spelling mistakes.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


