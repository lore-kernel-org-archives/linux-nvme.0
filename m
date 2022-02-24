Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD1D6C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Feb 2022 15:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x7mJMPHdqqRDrqNizZWKTDrc33UEJ2n+xJttgQ2Pta4=; b=wmkVyKdFQvpzc/T0CW0q3bxhzS
	PnteBaAz67nHRENE77gej2/HpEo4vqvMff+Sltec4+75viKqYVZLHmgESydQNfmE8NySC+qSnFxBS
	wcN2TuXh348xWXms9r7yIfzLwSXp2bCpUmx+sxD48pbtsFrLaWmicS6CZboaLg1TQ6Jyl4mcWTgTn
	o1islIjtkh07/BbcJNvzdN5jfiZEiH3WH6d5KW5Y6DdhQTUBbNv8RZwJJrIQ75+i3UWUO9dFRpS7g
	LM/8c+sK+mngQtUVsNpNNXYvSjccLBUISQvQ9bWMLB0l25aqmQFuEbkAynQrO9v+P6Wvs4fgutliB
	22vrYT2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nNGGs-001MFk-Q4; Thu, 24 Feb 2022 15:43:10 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nNGGq-001MFP-EM
 for linux-nvme@lists.infradead.org; Thu, 24 Feb 2022 15:43:09 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id E05D5616B1;
 Thu, 24 Feb 2022 15:43:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07696C340E9;
 Thu, 24 Feb 2022 15:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645717387;
 bh=c914U9DCjfIos+uLvi4TC+NZ7JHuR4fZ0DvTb3XlKgg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DLf0dd31Opeq5V3JhU/X/AP2DN5ZuTADIX5/FKwfbCM9JY168+V5fKQL/JQiCCIah
 9VZXMyVEOO7l40PiSk26SOheo9o/to89tAshAiLeo+GDGrKVc4YBUAUJrXM0f/MF1l
 NiIiahLQoRqMTOKuy1wljxMszBk2IZNT5woT2yaFkZvhBrGTGH7kZ0W/Xnf8XcDdO7
 qUvf8OADyxTlMVQFMNo+rHohHWZdMvuIiTRccMxWn6IlCBk9ER7WSt6xGxgAFOTNq/
 Os4w1rPXwu5byo72Tvz4KJfxFNHWfdJ220JoS771Rne31VFB9YtUabL+NPIgf+JfSp
 puqwv3kot3Iag==
Date: Thu, 24 Feb 2022 07:43:04 -0800
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/3] nvme: check that EUI/GUID/UUID are globally unique
Message-ID: <20220224154304.GB2976831@dhcp-10-100-145-180.wdc.com>
References: <20220224105852.862715-1-hch@lst.de>
 <20220224105852.862715-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224105852.862715-4-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220224_074308_547234_F3147F38 
X-CRM114-Status: GOOD (  25.07  )
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

On Thu, Feb 24, 2022 at 11:58:52AM +0100, Christoph Hellwig wrote:
> Add a check to verify that the unique identifiers are unique globally
> in addition to the existing check that verifies that they are unique
> inside a single subsystem.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c | 32 ++++++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index ac4749f257439..4f9623d9f7ed9 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3783,7 +3783,7 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
>  	ret = nvme_subsys_check_duplicate_ids(ctrl->subsys, &head->ids);
>  	if (ret) {
>  		dev_err(ctrl->device,
> -			"duplicate IDs for nsid %d\n", nsid);
> +			"duplicate IDs in subsystem for nsid %d\n", nsid);
>  		goto out_cleanup_srcu;
>  	}
>  
> @@ -3815,12 +3815,40 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
>  	return ERR_PTR(ret);
>  }
>  
> +static int nvme_global_check_ids(struct nvme_subsystem *this,
> +		struct nvme_ns_ids *ids)
> +{
> +	struct nvme_subsystem *s;
> +	int ret = 0;
> +
> +	mutex_lock(&nvme_subsystems_lock);
> +	list_for_each_entry(s, &nvme_subsystems, entry) {
> +		if (s == this)
> +			continue;
> +		mutex_lock(&s->lock);
> +		ret = nvme_subsys_check_duplicate_ids(s, ids);
> +		mutex_unlock(&s->lock);
> +		if (ret)
> +			break;
> +	}
> +	mutex_unlock(&nvme_subsystems_lock);
> +
> +	return ret;
> +}
> +
>  static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
>  		struct nvme_ns_ids *ids, bool is_shared)
>  {
>  	struct nvme_ctrl *ctrl = ns->ctrl;
>  	struct nvme_ns_head *head = NULL;
> -	int ret = 0;
> +	int ret;
> +
> +	ret = nvme_global_check_ids(ctrl->subsys, ids);
> +	if (ret) {
> +		dev_err(ctrl->device,
> +			"globally duplicate IDs for nsid %d\n", nsid);
> +		return ret;
> +	}

It looks like a race condition exists here such that two namespaces with
duplicate IDs in different subsystems being concurrently added may not
see the duplicate.

