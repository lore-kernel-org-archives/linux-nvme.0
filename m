Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E76FFC982E6
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 06:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jjXD96ylQ1rfUZEG6wNPgmG/ntSzrRNsNXx/isfnMfg=; b=tSBwSksKyVsc1t/Cgk3uYcrsSE
	TkQE0pyNj3f6ifOkAF2wv3kEo+qskeJgXkuQe2cZZe4EGj7inc0Wf3bVQHsJUMq65stZqndut7AbG
	F3hA+BeZFHygu1WUwTiMQWvB/sZOQV5P3iKZdyGhTZTsyi3XjBnPHxcXiFfNxJfjDaAhyJ9aRmoPT
	VyN9Tp4nltGTe9YhLRdnlKXEs7zAM+meR0kOW/166s5JcDszzG/0dQkNSJ0vXFUBAJ1tSyXcYvigH
	8PBHrqOIgBsn9NUOZvYec9n8dNuP8qWL7XhZd9HVifowLfcIzJ2eCK8OdqNDrsNz5kfwoVx+nZCsD
	FUJotlnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8Xtw-000000017ij-2LSy;
	Mon, 21 Sep 2026 06:53:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8Xtu-000000017hk-2sPK
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 06:53:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 04FA56732A; Mon, 21 Sep 2026 08:53:12 +0200 (CEST)
Date: Mon, 21 Sep 2026 08:53:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
	John Garry <john.g.garry@oracle.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 1/2] nvmet: return Invalid Field for invalid NSIDs
 in Set Features 82h
Message-ID: <20260921065311.GC13667@lst.de>
References: <20260920033500.3209138-1-kanie@linux.alibaba.com> <20260920033500.3209138-2-kanie@linux.alibaba.com> <baef058e-a502-4263-8d3d-1ad0a9550826@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <baef058e-a502-4263-8d3d-1ad0a9550826@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_235318_879180_349FD66E 
X-CRM114-Status: GOOD (  18.58  )
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

On Sun, Sep 20, 2026 at 04:37:08PM +0530, Nilay Shroff wrote:
> On 9/20/26 9:04 AM, Guixin Liu wrote:
>> diff --git a/drivers/nvme/target/pr.c b/drivers/nvme/target/pr.c
>> index 0948a690a1c0..a36c732883d4 100644
>> --- a/drivers/nvme/target/pr.c
>> +++ b/drivers/nvme/target/pr.c
>> @@ -51,6 +51,8 @@ u16 nvmet_set_feat_resv_notif_mask(struct nvmet_req *req, u32 mask)
>>     	if (nsid != U32_MAX) {
>>   		status = nvmet_req_find_ns(req);
>> +		if (status == (NVME_SC_INVALID_NS | NVME_STATUS_DNR))
>> +			return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
>>   		if (status)
>>   			return status;
>>   		if (!req->ns->pr.enable)
>> -- 
>
> This looks good to me. However, to avoid hand-coding the same error
> return code multiple times in the function and to make it a bit more
> readable, how about modifying it as follows?

I don't understand how that helps.  If we really want to refactor,
we could add a version of nvmet_req_find_ns that does it, but
that feels like a bit of overkill.

> 		if (status == (NVME_SC_INVALID_NS | NVME_STATUS_DNR))

Still no need for the inner braces here in all versions.


