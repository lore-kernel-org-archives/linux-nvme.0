Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94888C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Nov 2022 07:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=YZOr4dqWY6A4IYjzyjJAX4AuaRMVwaVU935IQJ9xfZQ=; b=38WugZkEnX+aAl
	sBemofo19WRpBWKIZ6OZOEttdnfeUmiRTekBGky1euLJW7jje4g4tpgBPrYTKfF/kJl3eRZoJEaO5
	uoUPwMTDEFRATcYN/LwGRu/EVt4TLDgSj/NmhkZY9iMC4YxQ0Fcpwn7uoUIr1PBg4CC6wEAYRVN/q
	TRqBfse13n7IWQ9k7LhGTP1GoPFno8uGLFSO6DJwmfWUmBXJw0cQFoJ8pAO3fnqSvg5HF7n7MDgeB
	/V5UqKL+yWhhrOwzlZF/KNtTQfUidNExknACnXVR6uuzoPRJ7ejJ27EC1jH1GcFvSp5QVDqWi3sbX
	a6Xl43HsZwzz+CgE8IVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox1QH-00AUOM-HR; Mon, 21 Nov 2022 07:40:57 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox1Q6-00AUDr-JY
	for linux-nvme@lists.infradead.org; Mon, 21 Nov 2022 07:40:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2DCDB68AA6; Mon, 21 Nov 2022 08:40:40 +0100 (CET)
Date: Mon, 21 Nov 2022 08:40:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Caleb Sander <csander@purestorage.com>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org,
	Uday Shankar <ushankar@purestorage.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] nvme: fix SRCU protection of nvme_ns_head list
Message-ID: <20221121074039.GA24507@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfcd682c-126d-34ab-3858-a7a7fc0afcb3@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221120_234046_823119_5EFE8C0A 
X-CRM114-Status: GOOD (  14.38  )
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

On Sun, Nov 20, 2022 at 01:24:51PM +0200, Sagi Grimberg wrote:
>>   	sector_t capacity = get_capacity(head->disk);
>>   	int node;
>> +	int srcu_idx;
>>   +	srcu_idx = srcu_read_lock(&head->srcu);
>>   	list_for_each_entry_rcu(ns, &head->list, siblings) {
>>   		if (capacity != get_capacity(ns->disk))
>>   			clear_bit(NVME_NS_READY, &ns->flags);
>>   	}
>> +	srcu_read_unlock(&head->srcu, srcu_idx);
>
> I don't think you need srcu here, rcu_read_lock/unlock is sufficient.

So the code obviously does not sleep.  But I wonder if anything speaks
against mixing SRCU and RCU protection for the same list?

