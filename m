Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA55D1266D
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Dec 2025 06:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qP5sN0hUQwWxsEVatNzNmE5VDxvJGTm+k7x61X+dsJw=; b=vdmUDfSVZj5YVQaUXA+6LFbHaD
	PP6y08qLW8WMeTFEa4odoCY+qrIm+RgNjus8KFKaW5luDB389ETLEhClK5svfJjEhVzjKutVKCgeZ
	8+2GH5o3SdISHvmWOV8z4+I0Y4WUDhpV7THhBHaouYjyPkxg/2ZyPRafdJjSuLV1ktMd0HS7Gcy+s
	aYTvXEeeO3f/YCnc094CAy1Xy6UsffjISuLkBDByJB0JOiGbPM2hOOrSlUfSxF4sxT89t+3PcZmDP
	Cg/YrBxRpmBbkiFCrgdO0YX5ZPul/coNB07+5A/5VtzR+JT1dBin1BvmTYyjL7ny2BRtGqZ/WC1d/
	L8ol5AFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQg50-00000006Agu-2hLp;
	Wed, 03 Dec 2025 06:11:10 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQg4v-00000006Aet-0hhN
	for linux-nvme@lists.infradead.org;
	Wed, 03 Dec 2025 06:11:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5CD1E68B05; Wed,  3 Dec 2025 07:10:46 +0100 (CET)
Date: Wed, 3 Dec 2025 07:10:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eugene Korenevsky <ekorenevsky@aliyun.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] nvme: nvme_identify_ns_descs: prevent oob
Message-ID: <20251203061046.GA16562@lst.de>
References: <aS8uVVBz_n4lI3bM@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aS8uVVBz_n4lI3bM@localhost.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251202_221105_345981_C82886D4 
X-CRM114-Status: GOOD (  12.85  )
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

On Tue, Dec 02, 2025 at 09:22:13PM +0300, Eugene Korenevsky wrote:
> @@ -1563,11 +1564,14 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl,
>  		goto free_data;
>  	}
>  
> -	for (pos = 0; pos < NVME_IDENTIFY_DATA_SIZE; pos += len) {
> -		struct nvme_ns_id_desc *cur = data + pos;
> +	for (pos = 0; pos < NVME_IDENTIFY_DATA_SIZE - sizeof(*cur); pos += len) {

Please avoid the overly long line.

Otherwise this looks fine.


