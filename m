Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A26A2C27C4F
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jun 2024 05:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cJXkhnquzbdxLxNVB5x8gwlk5TMFWlb6rr1aDKaOa8A=; b=Qbk606OoOnJTIvOCvIIaQ5SAxW
	Q+Vtoz6R/kmGFOsCEKJOtIrLVKj26r8VzuRBiEf9rDTDl3OFv/QfNwqGJic9a5IkSs6oBXFeM3M30
	BVfOSFaMsbnkrOr6XyHyS+JtHxqbUyXWbJlCExSU6d6QvlpYO2rxXhNO07DUzG0HyQ/RpFvc+Utco
	kYPl+H9GVzNX9FvZ8rcbUtpffwTkWNBt8dTE2Eey+Fo1xpiVUYRBdWIV3g4afrCN8h5/50H90mb6y
	rsV0yMP6RJ+C9zdW50hx4OSOutpozp7P8SLMpKPbY5v1MPK0mDMZWDJ9lkwElQTGk40YTD3Fd48Rc
	6mDsf+ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMKr2-00000005OpM-2jyP;
	Wed, 26 Jun 2024 05:06:00 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMKqw-00000005OoG-2Eln
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jun 2024 05:05:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E16AB68BEB; Wed, 26 Jun 2024 07:05:48 +0200 (CEST)
Date: Wed, 26 Jun 2024 07:05:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Meneghini <jmeneghi@redhat.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	emilne@redhat.com, jrani@purestorage.com, randyj@purestorage.com,
	chaitanyak@nvidia.com, hare@kernel.org
Subject: Re: [PATCH v8 1/2] nvme-multipath: prepare for "queue-depth"
 iopolicy
Message-ID: <20240626050548.GA21922@lst.de>
References: <20240625122605.857462-1-jmeneghi@redhat.com> <20240625122605.857462-2-jmeneghi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625122605.857462-2-jmeneghi@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240625_220554_738997_908CC667 
X-CRM114-Status: GOOD (  11.00  )
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

On Tue, Jun 25, 2024 at 08:26:04AM -0400, John Meneghini wrote:
> +	struct nvme_ns *old = srcu_dereference(head->current_path[node], &head->srcu);

Please avoid the overly long line here.

> +inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
> +{
> +	if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_RR)
> +		return nvme_round_robin_path(head);
> +	else
> +		return nvme_numa_path(head);

No need for an else after a return.


