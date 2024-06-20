Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F6E0C27C79
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Jun 2024 06:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z18WgKjQ8+RjN+5e7/DXZkZL8mOlFdPeNGebr3JvIMI=; b=13HT7KHW0Wmr8Vn+auR/qgtjVT
	K8IiMWHNGW+Yoza0od6H3KvrcOv3vU0DoedUdG/WhYSc9+yL5oG3A+6x85ZWt1fP5qaX6XIKjHPCa
	I4SQ/d/jnW9NIYMVd9CJU+WUbaOEVRKSaulh5h1cgeCGW/VrcTc3O52eYBVJM+TWgJ/++rXHiRJ0a
	SQT9Ysn3K//jr85CPIg/ROpTuv/h/MfIYsANckPdZDQdI1F3UVSF0Ru3QUIjDMy2fKLRyGU6ejHdE
	NXaqbWd9f3C92dDK0xNT9ayPsEpgpPwESNA1FdU28QJSAsfN3zybu+Bvfepb3G4tFXBLxIs58FLd3
	WwipvySQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKBj0-00000003siX-2qSE;
	Thu, 20 Jun 2024 06:56:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKBix-00000003sha-1x5E
	for linux-nvme@lists.infradead.org;
	Thu, 20 Jun 2024 06:56:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7ACF568AFE; Thu, 20 Jun 2024 08:56:41 +0200 (CEST)
Date: Thu, 20 Jun 2024 08:56:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Meneghini <jmeneghi@redhat.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	emilne@redhat.com, jrani@purestorage.com, randyj@purestorage.com,
	chaitanyak@nvidia.com, hare@kernel.org
Subject: Re: [PATCH v7 1/1] nvme-multipath: implement "queue-depth" iopolicy
Message-ID: <20240620065641.GA22113@lst.de>
References: <20240619163503.500844-1-jmeneghi@redhat.com> <20240619163503.500844-2-jmeneghi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619163503.500844-2-jmeneghi@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240619_235647_797516_B646A2BF 
X-CRM114-Status: GOOD (  14.84  )
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

> [jmeneghi: vairious changes and improvements, addressed review comments]

s/vairious/various/ 

> +	if ((nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE))

No need for the double braces here.

> +		WARN_ON_ONCE((atomic_dec_if_positive(&ns->ctrl->nr_active)) < 0);

Overly long line.

But I don't understand why you need the WARN_ON anyway.  If the value
must always be positive there is no point in atomic_dec_if_positive.
If misaccounting is fine there WARN_ON is counterproductive.

> -static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
> -		int node, struct nvme_ns *old)
> +static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head)
>  {
> -	struct nvme_ns *ns, *found = NULL;
> +	struct nvme_ns *ns, *old, *found = NULL;
> +	int node = numa_node_id();
> +
> +	old = srcu_dereference(head->current_path[node], &head->srcu);
> +	if (unlikely(!old))
> +		return __nvme_find_path(head, node);

Can you split the refactoring of the existing path selectors into a
prep patch, please?

> +static void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys,
> +		int iopolicy)
> +{
> +	struct nvme_ctrl *ctrl;
> +	int old_iopolicy = READ_ONCE(subsys->iopolicy);
> +
> +	if (old_iopolicy == iopolicy)
> +		return;
> +
> +	WRITE_ONCE(subsys->iopolicy, iopolicy);

What is the atomicy model here?  There doesn't seem to be any
global lock protecting it?  Maybe move it into the
nvme_subsystems_lock critical section?

> +	pr_notice("%s: changed from %s to %s for subsysnqn %s\n", __func__,
> +			nvme_iopolicy_names[old_iopolicy], nvme_iopolicy_names[iopolicy],
> +			subsys->subnqn);

The function is not really relevant here,  this should become something
like:

	pr_notice("%s: changing iopolicy from %s to %s\n",
		subsys->subnqn,
		nvme_iopolicy_names[old_iopolicy],
		nvme_iopolicy_names[iopolicy]);

or maybe:

	dev_notice(changing iopolicy from %s to %s\n",
		&subsys->dev,
		nvme_iopolicy_names[old_iopolicy],
		nvme_iopolicy_names[iopolicy]);


