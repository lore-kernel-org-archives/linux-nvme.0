Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D41C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Sep 2022 06:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MR0Nh8WSHiqs9W6l+h3NEfJZaGghNzGG8BWU1zOdy6A=; b=MaVQPk7YiurXWiJ/p5yAhJ+EvV
	pyR6FUL0wlz1LTAEBZscColTGhYwqVvXSGxIeXJXlqpKSEtdCMwvuwcBprKpa4eLKPcsjZIpR6k9z
	BdWS50XZ2fylx1gbvKL6vicNtZ47wgwlsNm7wP3ML+WjcRKb54LUeA3jAuCF3znCnTfhRZNSLXGyt
	zbcbaw3gDEfokUzDbq9FjV6U22YTIbsnH/Mog2+7BOvm2ZZMq3Tx4mCV2dEhKBxxLK25cyiXdkMfN
	SLVPa8NSGWWyIIJIT58OREZLMrdbwpV1RDEqskXf34tbO0aC9Xe3fawbeeY+ZcPQukpZUksY8HrOM
	vShZDrtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oe9h4-007Ytk-4y; Fri, 30 Sep 2022 06:40:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oe9h1-007Yrb-A0
	for linux-nvme@lists.infradead.org; Fri, 30 Sep 2022 06:40:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2F2C468BFE; Fri, 30 Sep 2022 08:40:04 +0200 (CEST)
Date: Fri, 30 Sep 2022 08:40:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Yogev Cohen <yogev@lightbitslabs.com>
Subject: Re: [PATCH] nvme-multipath: fix possible hang in live ns resize
 with ANA access
Message-ID: <20220930064003.GA23345@lst.de>
References: <20220928135816.132213-1-sagi@grimberg.me> <04bf1cdd-3093-99c8-3aff-32ed3278c805@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04bf1cdd-3093-99c8-3aff-32ed3278c805@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220929_234015_531886_25C7F37F 
X-CRM114-Status: GOOD (  18.43  )
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

On Fri, Sep 30, 2022 at 08:29:54AM +0200, Hannes Reinecke wrote:
>>   void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
>>   {
>>   	struct nvme_ns_head *head = ns->head;
>> +	struct nvme_ns *n;
>>   	sector_t capacity = get_capacity(head->disk);
>>   	int node;
>>   -	list_for_each_entry_rcu(ns, &head->list, siblings) {
>> -		if (capacity != get_capacity(ns->disk))
>> -			clear_bit(NVME_NS_READY, &ns->flags);
>> +	list_for_each_entry_rcu(n, &head->list, siblings) {
>> +		if (capacity != get_capacity(n->disk))
>> +			clear_bit(NVME_NS_READY, &n->flags);
>>   	}
>>     	for_each_node(node)
>>   		rcu_assign_pointer(head->current_path[node], NULL);
>> +	nvme_kick_requeue_lists(ns->ctrl);
>>   }
>>     static bool nvme_path_is_disabled(struct nvme_ns *ns)
>
> Hmm. I guess the real issue is that we use 'ns' as both function argument 
> _and_ iterator, so that after 'list_for_each_rcu()' 'ns' is pointing to a 
> _different_ namespace, such that we end up kicking that namespace and not 
> the one used as argument.
> But in either case, patch is fine.

BEfore this patch that wasn't an actual problem as the ns pass as
argument was only used to derived the ns_head but not used after
the loop.  It was a bit of a landmine, though.

