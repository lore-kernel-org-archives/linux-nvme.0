Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92ED9C3ABDB
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Sep 2024 06:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dFj4PXIWzhbmUJOFmzQNt1qgtQ8syeC3KliuYY5z/vY=; b=rDIdZZsBXc+mUY0tJ/CM3utRaZ
	xmVtL7+anohhiMQK5S8GZhms7qqMFNldfXApEYycxmMl3fNLjw8d1Kc1MmOiCIUjrjBC4dzSHCvUy
	BZycoyihYYE/KDBk3p6IxVokrMfKB6hnQyzFw6UXKNvBrL3dWVtdeAr8Z7KWM7FXj5QGsbPin/jFh
	fZbiE5ABKeHehDxnozgRlMixVQy3ciepNagMtTRv19OVQRI6pavBUIqhnJyY6AbeRfZlNoKn8comZ
	2uG5aGpMVeyrI6TBEyCiViWv0qV9RLlaCE0bFlPlTCUtEVx/Wq0ynQqGP13kOycs0s2o8dtUlhxCE
	KMMB2jYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sqRS2-00000005SuQ-3Zh7;
	Tue, 17 Sep 2024 06:12:38 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sqRRz-00000005Stk-1jhV
	for linux-nvme@lists.infradead.org;
	Tue, 17 Sep 2024 06:12:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 303AE227ACB; Tue, 17 Sep 2024 08:12:27 +0200 (CEST)
Date: Tue, 17 Sep 2024 08:12:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Vitaliy Shevtsov <v.shevtsov@maxima.ru>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet-auth: assign dh_key to NULL after kfree_sensitive
Message-ID: <20240917061226.GA3839@lst.de>
References: <20240916174139.1182-1-v.shevtsov@maxima.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916174139.1182-1-v.shevtsov@maxima.ru>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240916_231235_621190_0DACEE13 
X-CRM114-Status: GOOD (  10.04  )
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


