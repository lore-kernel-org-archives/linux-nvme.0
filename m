Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C668C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Nov 2022 08:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KK+5grpa1GbPy3NIREUeQkAs4taWI4t9pvgUsh37plA=; b=0/sKPRFq8yuzQBDj8nAY+yqmOD
	Cv/z+CR+83VLdUIAwRfbmkSD6nq2XE8eoWFkvQMt/dnIjnyoXSrESyjDl9NiJOI6IEKhsQTJ2z/LW
	WJbWKTGIQkWS95du26bt/7ZS0HqTMVkJGszssUMdM4gDMEqzkUEX7NCr+U92EAw1teJA4Txz+sPHS
	J9gR5XRZo3t0NfUEwODXSzqmiGxeYeEIzJzRjRSKB5e/nYYTpScTtvpgDZI0iekRrPKB31fjUNE3t
	zd5gNPnLw3+LgBEvEnjNOE50U/QPdF3jCABXCDnhwIL68RFKfVXOTCcsW1KFDN88iU6YK5wg7DbeM
	jmaj1oaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oq8ia-008jfs-6P; Wed, 02 Nov 2022 08:03:24 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oq8iY-008jfJ-BM
	for linux-nvme@lists.infradead.org; Wed, 02 Nov 2022 08:03:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 94DC567373; Wed,  2 Nov 2022 09:03:19 +0100 (CET)
Date: Wed, 2 Nov 2022 09:03:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/6] nvme-auth: use xarray instead of linked list
Message-ID: <20221102080319.GB10816@lst.de>
References: <20221102075224.70869-1-hare@suse.de> <20221102075224.70869-4-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102075224.70869-4-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221102_010322_549889_D38BA608 
X-CRM114-Status: GOOD (  13.18  )
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

> @@ -907,33 +915,28 @@ EXPORT_SYMBOL_GPL(nvme_auth_negotiate);
>  int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid)
>  {
>  	struct nvme_dhchap_queue_context *chap;
> -	int ret;
>  
> +	chap = xa_load(&ctrl->dhchap_auth_xa, qid);
> +	if (!chap) {
> +		dev_warn(ctrl->device,
> +			 "qid %d: authentication not initialized!",
> +			 qid);
> +		return -ENOENT;
>  	}
> +	flush_work(&chap->auth_work);

What protects chap from going away after the load, but before use?


