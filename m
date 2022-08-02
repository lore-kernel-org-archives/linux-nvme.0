Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A99FC00140
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Aug 2022 13:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZYabjQ2Kp1Vp92lS+kqLez96XRrl6TthLjQ2vLU9+JA=; b=YZBiEaGweqyuU8UCT0N5h6zIyX
	wRSpq8NWsPtFaZkTI3q6jdF7KVFzYsj3gyAESsl6ELYYkG6k2HDByiHBzU0UY0V5JU/rg1Vi8fGYf
	eMCPg+7ObDXsd2P9MwXH4fagStqhNWf4DrU70UTVEzqM+1OoXjTFSp7dQzWmfYLMi7YzVK3n/KAc/
	gIkU7C2zzsuqWNnax8YW78VgQpxhZ9a9LolZVVqTlcmhYZUW07feJv3DUcWYD6Xn1KZOA8zRU+VYx
	hW9j83/5CftNosCdB+3515P3elmxojhyHTecAti39n1/D2nCaiZOw9MO/vz5GqcUsQeQ/+2F/sWpk
	96o7Du2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIs6J-00EXAc-Fa; Tue, 02 Aug 2022 13:38:23 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIs6F-00EX7S-K4
	for linux-nvme@lists.infradead.org; Tue, 02 Aug 2022 13:38:20 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0129E68AA6; Tue,  2 Aug 2022 15:38:16 +0200 (CEST)
Date: Tue, 2 Aug 2022 15:38:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Chao Leng <lengchao@huawei.com>, Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	kbusch@kernel.org, axboe@kernel.dk
Subject: Re: [PATCH 0/3] improve nvme quiesce time for large amount of
 namespaces
Message-ID: <20220802133815.GA380@lst.de>
References: <20220729073948.32696-1-lengchao@huawei.com> <20220729142605.GA395@lst.de> <1b3d753a-6ff5-bdf1-8c91-4b4760ea1736@huawei.com> <fc7a303f-0921-f784-a559-f03511f2e4be@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc7a303f-0921-f784-a559-f03511f2e4be@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220802_063819_834915_876A87E8 
X-CRM114-Status: GOOD (  17.12  )
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

On Sun, Jul 31, 2022 at 01:23:36PM +0300, Sagi Grimberg wrote:
> But maybe we can avoid that, and because we allocate
> the connect_q ourselves, and fully know that it should
> not be apart of the tagset quiesce, perhaps we can introduce
> a new interface like:
> --
> static inline int nvme_ctrl_init_connect_q(struct nvme_ctrl *ctrl)
> {
> 	ctrl->connect_q = blk_mq_init_queue_self_quiesce(ctrl->tagset);
> 	if (IS_ERR(ctrl->connect_q))
> 		return PTR_ERR(ctrl->connect_q);
> 	return 0;
> }
> --
>
> And then blk_mq_quiesce_tagset can simply look into a per request-queue
> self_quiesce flag and skip as needed.

I'd just make that a queue flag set after allocation to keep the
interface simple, but otherwise this seems like the right thing
to do.

