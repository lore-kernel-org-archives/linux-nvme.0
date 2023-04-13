Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C5CC77B6E
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Apr 2023 14:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cbXk0d9AzLcaJ3sVQ6zzT60KR4SbSlBLt/Lp2VjSqrc=; b=aQQiqdAoXExPxhuCFXQo5va7sD
	S/9jgF5fHWNLWqJnI/qVDe7CMIsQERSN1oCe+XA2nvNWjz0Ruo78Bkr6+lrtdmpcApepyOMKUdmOZ
	S0WLY0GNL8srZYuacMb/xjQC4H87mDt7WkN+IGcywykC1GQGzzwuF6WI+Au6mIGWQbxHguSqEUDc/
	t7w1U+mc/zseaqPnmJeMPMqUqOPvRV0ZE0zSdaL6LQNqRQYfAUumfq7kB0SdVOahmyJQB18dqFGha
	p9t6GywhCzSo+ky3EAGY8IluuBpwSGrZWn72GcAxN3Xbk9IjXKjm7HKEmj3JejnItX7wvDFLXg7g4
	BkJBsQxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pmxYF-006LNS-29;
	Thu, 13 Apr 2023 14:03:51 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pmxYC-006LMc-36
	for linux-nvme@lists.infradead.org;
	Thu, 13 Apr 2023 14:03:50 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 0932A61124;
	Thu, 13 Apr 2023 14:03:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C317C433D2;
	Thu, 13 Apr 2023 14:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681394627;
	bh=PmE5nxO2Vww94XAom/7Da8+ydx/U57Fw7OD9Uabfns0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s7B3bND8wGztzpxThTVPUp5dUTf5o2kkZFeJ3azgJGHbLmRv/ztQPubZNi+BQUymt
	 sSZ841vkGpeWH6eu2pbto4wT3xNwSHwCLy+ZGjUDTBOQCvDuxJGSn1EJ0tPSx9rRIf
	 uY5FWKsAy9tZV5vReTQI31O5vR4GN60EYzgYIlXLmZ5Ns1E35qsHEZU/fYnZhovwoL
	 dXv6/wIygppND/l8JdQO9gepgKsgaG9j/7CAgvH3pgjc3e2vgaBcGAu3h4553ddv06
	 48O2CDWvbG89ePA9PTZfZsTyjrK618cmG7nDNys4QCDAG+N4lKFmqqn+1c5tbzW8ji
	 CN0ND99bXB95g==
Date: Thu, 13 Apr 2023 07:03:45 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] block: fix Oops in blk_rq_poll_completion()
Message-ID: <ZDgLwcxill+2WTie@kbusch-mbp>
References: <20230413091419.6124-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413091419.6124-1-kch@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230413_070349_074221_E5706B09 
X-CRM114-Status: GOOD (  14.47  )
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

On Thu, Apr 13, 2023 at 02:14:19AM -0700, Chaitanya Kulkarni wrote:
> Add a NULL check before we poll on req->bio in blk_rq_poll_completion().
> Without this patch blktests/nvme/047 fails :-
> 
> * Debug-diff:-
> 
> linux-block (for-next) # git diff
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 1b304f66f4e8..31473f55b374 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1335,6 +1335,8 @@ EXPORT_SYMBOL_GPL(blk_rq_is_poll);
>  static void blk_rq_poll_completion(struct request *rq, struct completion *wait)
>  {
>         do {
> +               if (!rq->bio)
> +                       BUG_ON(1);
>                 bio_poll(rq->bio, NULL, 0);
>                 cond_resched();
>         } while (!completion_done(wait));

This is already fixed upstream and stable.

