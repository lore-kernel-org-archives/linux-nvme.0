Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF6DC433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 06:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4MUjpnRBK+hyP6fZNOexHiDTAAjlRS0En6aid+kuUOo=; b=wk1youi8qDEoBO04RP1Zeie/AS
	N52ZHLJ2uWnm3HURp2tMffnvdRWKUKmWJaYm9C4/pX99DFUT5TuijQgTYuejr4rfimondOYq/0TIS
	phZs37LzcdBNBKe1SwBTwv7Wdt4Gd8KJT2S++gHj2D8L99ACN9hrrs/qKgAGi99A91vycnl9ePHcT
	7FuacQCb0aDIE7GrYvx6vgHkq5ZL3jjWn94Yjpq6gtVZbELojq9zT940fEwqgtb06cz0C29EU5HcN
	fmNgawfwkWDiGc5c2k9PfoBDyiPLBsRRSqAJ4psYDr9QzMTshwE4qnC5jypNBy9M2zbYZXFPBpYBV
	ZDWyBJwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oseit-00BFjV-4h; Wed, 09 Nov 2022 06:38:07 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osein-00BFbF-4t
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 06:38:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A95CD68AFE; Wed,  9 Nov 2022 07:37:57 +0100 (CET)
Date: Wed, 9 Nov 2022 07:37:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH 07/16] nvme-auth: remove redundant if statement
Message-ID: <20221109063757.GA10893@lst.de>
References: <20221109034420.1000086-1-sagi@grimberg.me> <20221109034420.1000086-8-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109034420.1000086-8-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_223801_351257_8E2E0EA8 
X-CRM114-Status: GOOD (  13.81  )
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

On Wed, Nov 09, 2022 at 05:44:10AM +0200, Sagi Grimberg wrote:
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index a6312a8846f8..07d497f49e4b 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -874,7 +874,7 @@ int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
>  		mutex_unlock(&ctrl->dhchap_auth_mutex);
>  		return -ENOMEM;
>  	}
> -	chap->qid = (qid == NVME_QID_ANY) ? 0 : qid;
> +	chap->qid = qid;

Btw, the same "transformation" can also be removed in nvme_auth_submit.

