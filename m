Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C68C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Feb 2022 15:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TzXNiQNaRgXtWV94AXrT3Eov+lG1hTHW/yu41Xbd1pA=; b=5Fb61VNKBeeQI4CF5EaHYeT2b9
	pFtFaSFAHrO+CjFjWBZg+9bwuukpsvC0JqzYGPLnxpB1BsKx5ftlyKFKourvAzhfiJZij7WN4VvsX
	JeiQiW9hOZn4GN2H41nKqmvmFYhvy+D6kxUYg+arrAOBZuFfunEiLFIxoDT3Xm6FXrk1GYprW3UBC
	QzDzv73R+pxRTaBLv48dEEdimDXHmxFkcvlmBAuakZAZCR3Q1CeW+0zkiRVxFL/XjpkZfEbkbmkiN
	5n3LnaiCk3xN4r8V9ucvzFNvFGt4As0OyZXtsT12Tjw84hFdkKUlbUtRlqlS8ybctm7WU79RdWTrv
	WV4dMAsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nNG3p-001Jlo-OE; Thu, 24 Feb 2022 15:29:41 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nNG3m-001Jk7-61
 for linux-nvme@lists.infradead.org; Thu, 24 Feb 2022 15:29:39 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 3B0A6B82695;
 Thu, 24 Feb 2022 15:29:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BAF3C340E9;
 Thu, 24 Feb 2022 15:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645716574;
 bh=HPrjLfSaLWnD5rcJUG0ti2faGatt8A3QMoN1lsoElMs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=r4QQHDOCOVNsLVp3QVrbYAmEm6pgVzqsoWhz01GdCTVuuLaOYj9VYYzqsBNuLkQJQ
 sVYWJ063YQb/TwmXu0btMX6jsmrY22fZSnvzspx+vnJGE5xdSgZeQ08sHLn7DydTZp
 u3v1/9scY83OZ0AgzCMij1QcwahYMtyyh9OJLrJ37ThZCIh7hvCBxy1+oCiVIW0ryf
 pMMZt3Rj96ZERI/gMTwSYsR+rnXckhml0eaAmc8kGxghwNfCq77cuQg4RsB3S+DnyS
 ZvsnMqowmb3LDzrmu+fC2Fk99QG4xQ0ZRbOKYl/mCNEE4RIDhJaklAzhYiCX+cZCIR
 QB45VYEfmcetQ==
Date: Thu, 24 Feb 2022 07:29:32 -0800
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/3] nvme: cleanup __nvme_check_ids
Message-ID: <20220224152932.GA2976831@dhcp-10-100-145-180.wdc.com>
References: <20220224105852.862715-1-hch@lst.de>
 <20220224105852.862715-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224105852.862715-2-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220224_072938_436463_35590A12 
X-CRM114-Status: GOOD (  20.98  )
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

On Thu, Feb 24, 2022 at 11:58:50AM +0100, Christoph Hellwig wrote:
> Pass the actual nvme_ns_ids used for the comparism instead of the
> ns_head that isn't needed and use a more descriptive function name.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 9cffc4770e737..076a03b801b7e 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3673,16 +3673,15 @@ static struct nvme_ns_head *nvme_find_ns_head(struct nvme_subsystem *subsys,
>  	return NULL;
>  }
>  
> -static int __nvme_check_ids(struct nvme_subsystem *subsys,
> -		struct nvme_ns_head *new)
> +static int nvme_subsys_check_duplicate_ids(struct nvme_subsystem *subsys,
> +		struct nvme_ns_ids *ids)
>  {
>  	struct nvme_ns_head *h;
>  
>  	lockdep_assert_held(&subsys->lock);
>  
>  	list_for_each_entry(h, &subsys->nsheads, entry) {
> -		if (nvme_ns_ids_valid(&new->ids) &&
> -		    nvme_ns_ids_equal(&new->ids, &h->ids))
> +		if (nvme_ns_ids_valid(ids) && nvme_ns_ids_equal(ids, &h->ids))
>  			return -EINVAL;
>  	}
>  
> @@ -3781,7 +3780,7 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
>  	head->ids = *ids;
>  	kref_init(&head->ref);
>  
> -	ret = __nvme_check_ids(ctrl->subsys, head);
> +	ret = nvme_subsys_check_duplicate_ids(ctrl->subsys, &head->ids);

Looks good.

As an afterthought, now that we don't need the "head", a further cleanup
can move this check further up in this function prior allocating the
head. That simplifies the error handling since there's nothing to
unwind.

