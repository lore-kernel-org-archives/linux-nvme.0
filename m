Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74302C4345F
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Apr 2024 05:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mngV49Del8fY8nGoS4Fov0MaeC/nF40ZivGM0Y5REdI=; b=WRcnrROtL+BF7msOUYev3HbKoY
	J2u9VTdNLfkuwQ2RokvNCa6XozSEGx1dsvsmBvNNiDH0QdjeJyGC/T2CgKm3L/PNaaaEK0JYQ44BH
	RcfvSHOa7HFBzKTRekDkcyagt8QIOAv+67HaGipxNtp29a9Ko6mKuynWpxTLoJG7Fuk/2hfb3oz3d
	EVz2TYiHol2+s/FCCtlOGYqqZf/FEU2MgR7/VkuEy901j+R7/FJH7sd43Otdh2JX5KhSz5c6CKgMX
	hJpTSipGAwzTywQrUOItwm5W9WIBFTx7ww5vut4amWRwUvMI8vBsEaGJ0cZszP9Oe0lyZhzz2gUys
	BpQbCEVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1JM6-00000001VFr-0w2C;
	Mon, 29 Apr 2024 05:15:10 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1JM3-00000001VEu-1vTE
	for linux-nvme@lists.infradead.org;
	Mon, 29 Apr 2024 05:15:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 06EAD227AA8; Mon, 29 Apr 2024 07:14:58 +0200 (CEST)
Date: Mon, 29 Apr 2024 07:14:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	jirong.feng@easystack.cn
Subject: Re: [PATCH] nvmet: fix nvme status code when namespace is disabled
Message-ID: <20240429051457.GB32577@lst.de>
References: <20240428092540.77366-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240428092540.77366-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240428_221507_664831_CEE64DB2 
X-CRM114-Status: GOOD (  13.21  )
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

On Sun, Apr 28, 2024 at 12:25:40PM +0300, Sagi Grimberg wrote:
> If the user disabled a nvmet namesapce, it is removed from

s/namesapce/namespace/

(lines also look a little short here, maybe use up all 73 chars
when refreshing it).

> +		if (nvmet_subsys_nsid_exists(subsys, nsid))
> +			return NVME_SC_INTERNAL_PATH_ERROR;
> +		else
> +			return NVME_SC_INVALID_NS | NVME_SC_DNR;

No need for an else after a return.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

