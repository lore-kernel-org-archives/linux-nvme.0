Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A6E60A2629
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 17:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wj5INPY7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=nypqymsfvQMv9gnOSD48NpKI4T5P6z+DuadvXpmmCmo=; b=wj5INPY7GMFuuuZujD4HPYT3U3
	BSA67iAbioHcRfnUmQQSeCPOxWbXP+/U7SBFBVAYEb33iMvfcSV11NXEJWk3x1mO7waGEEqcMxPMI
	tY711H+LhjAeB/ZJQGSdYgLECxwMnidqMSkmvcnrqRSE1fr66Fgg9OWglZFXbX2YWgfRHBiC+oOT3
	CYUwBONkKrwDpjgPpdNRIWRJq7YfS/yEK0X99DiJY+BYrT64VMDPijbfSlXn4fHbe0Kj396dDuFD+
	Qrleiqghz/jq4u+TcuifBwTey34Ik9cuYqss6EnJng+aB0DRKp9zjkWXpjHhnCVmH7AUeT+SCu20s
	AVwvdZhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUSju-0000000FmKj-1NdN;
	Fri, 20 Nov 2026 17:49:43 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUSjf-0000000FmHG-0u78
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 17:49:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2E7A36732A; Fri, 20 Nov 2026 18:49:15 +0100 (CET)
Date: Fri, 20 Nov 2026 18:49:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: shao.mingyin@zte.com.cn
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/5] nvme: zns: reject an out-of-range zone append size
 limit
Message-ID: <20261120174914.GA1484@lst.de>
References: <202611150127512368BGQ07ZNIRAIwClkam-8u@zte.com.cn> <20261115012752774qFGtgUXwZKwN-2LDj0D80@zte.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261115012752774qFGtgUXwZKwN-2LDj0D80@zte.com.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_094920_755211_AA4B70E6 
X-CRM114-Status: GOOD (  15.96  )
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 15, 2026 at 01:27:52AM +0800, shao.mingyin@zte.com.cn wrote:
> 
> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
> index e31ec6f4f94f..c34015e68f81 100644
> --- a/drivers/nvme/host/zns.c
> +++ b/drivers/nvme/host/zns.c
> @@ -27,10 +27,15 @@ static int nvme_set_max_append(struct nvme_ctrl *ctrl)
>  		return status;
>  	}
>  
> -	if (id->zasl)
> -		ctrl->max_zone_append = 1 << (id->zasl + 3);
> -	else
> +	if (id->zasl && id->zasl + 3 < 32) {
> +		ctrl->max_zone_append = 1U << (id->zasl + 3);
> +	} else {
> +		if (id->zasl)
> +			dev_warn(ctrl->device,
> +				 "invalid zone append size limit %u\n",
> +				 id->zasl);

This warning triggers for perfectly valid values that we just can't
express.  I think we can just drop it.


