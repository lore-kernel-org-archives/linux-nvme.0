Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C706C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Apr 2022 12:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DZV3aCrNAaiM9dj/dVXvRPLRVjHsbIsM5O1PG7Xuv2I=; b=b3Rla+86MjEgJwQsV5F0gBRO/G
	bM086igD61iPA7qd4MPC8zR2LjhKyVPktw4/xFEvxanbJGz36/BxU5i+G6a5W5qqSDwtuQIZYkkjI
	ZRcusACVThDktomqJwGfQXoyFVj/JJs0/8F+hJUM/muhVQ7waOiQSZR2PXcY/LZS6KX0cMxytAHKa
	b81I7B0Pqz9EfVDUUGnG+NmDxn2lWO7fH8VYFlncSCQlNsPj9hO7KBsQvC4eQ29sxi2BkNZuSvrWV
	qOn/6TfFETVso1i00m1akFr0gyKV+3RIltnYfwDpJxDtOl4WALXMtPB/+Uv6nHouj58VI1IOgC5Vv
	VEI6EYNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ndsuE-008uAx-TI; Mon, 11 Apr 2022 12:12:30 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ndsu6-008u5d-1p
 for linux-nvme@lists.infradead.org; Mon, 11 Apr 2022 12:12:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 51FEB68AFE; Mon, 11 Apr 2022 14:12:10 +0200 (CEST)
Date: Mon, 11 Apr 2022 14:12:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>
Subject: Re: [PATCH 2/3] nvme-core: don't check non-mdts for disc ctrl
Message-ID: <20220411121209.GA21711@lst.de>
References: <20220411031249.5158-1-kch@nvidia.com>
 <20220411031249.5158-3-kch@nvidia.com> <20220411061301.GB14797@lst.de>
 <34d61434-27cd-f918-a3bc-fdca3196ef99@grimberg.me>
 <b5dd1bb3-e001-ac66-d461-4d699a2dadd6@nvidia.com>
 <d86c4a83-ac9d-f0b1-de41-5d411f5444f3@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d86c4a83-ac9d-f0b1-de41-5d411f5444f3@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220411_051222_286535_DB3D44A0 
X-CRM114-Status: GOOD (  12.79  )
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

On Mon, Apr 11, 2022 at 12:09:31PM +0000, Chaitanya Kulkarni wrote:
> -	ret = nvme_init_non_mdts_limits(ctrl);
> -	if (ret < 0)
> -		return ret;
> +	if (ctrl->cntrltype == NVME_CTRL_IO) {
> +		ret = nvme_init_non_mdts_limits(ctrl);
> +		if (ret < 0)
> +			return ret;
> +	}

This looks better, but I don't think it will actually work as-is.
The CNTRLTYPE field is never than discovry controllers.  We
special case them in nvme_init_subsystem, which should move to
nvme_init_identify instead so that ctrl->cntrltype is always valid
after that.

