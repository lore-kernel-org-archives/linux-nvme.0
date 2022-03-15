Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24621C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 08:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yMaIxRRREgXLeCQueA/xc3URDINDKiMFYEpsNJNuz9w=; b=Ky9NlZEgOwXWkamrgW4w2+PoCd
	trQigYtDljtTApA/6nUlKc+9F4e0zPq2XkSL1BnlUE9ZQtQaB4dqpRjec0ZYcTKEfGSz36HGxDJpf
	KUArK5WMHtAiz8ZU0Yy97VfDlU//bqWPVG0mo9vo+DbqtmvQ4QWyIF2RMT4TsskNRDi1lJ4rLO07B
	C/3Zl0WtXZgQ6FDSrOHE/YuKdv0NRAnXWIgEXxNkWG3yA2Y/z/xfRAznLCLwgSGTiKJUFV2oU7sHK
	V+363pbjgYoyuyLSKLZ46O/StqGXee0x8cDA81fsU0bcmPdgbJaid/E0f9Bdr/DYyDdqvTwlgBadM
	kNGUZIIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU2jS-008JQg-WA; Tue, 15 Mar 2022 08:40:43 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU2jP-008JPb-6n
 for linux-nvme@lists.infradead.org; Tue, 15 Mar 2022 08:40:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id A08A568AA6; Tue, 15 Mar 2022 09:40:35 +0100 (CET)
Date: Tue, 15 Mar 2022 09:40:35 +0100
From: "hch@lst.de" <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: "hch@lst.de" <hch@lst.de>, Sungup Moon <sungup.moon@samsung.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] driver/nvme/host: Support duplicated nsid for the
 private ns
Message-ID: <20220315084035.GA3834@lst.de>
References: <CGME20220314110545epcms2p4a227eac7c4652445050e70ee2350635d@epcms2p4>
 <20220314110545epcms2p4a227eac7c4652445050e70ee2350635d@epcms2p4>
 <20220315071230.GA2069@lst.de> <20220315071926.GA2137@lst.de>
 <a3051d85-c08e-a273-c7cc-2eb3e21df717@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3051d85-c08e-a273-c7cc-2eb3e21df717@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_014039_421113_51DBD812 
X-CRM114-Status: GOOD (  15.50  )
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

On Tue, Mar 15, 2022 at 10:18:30AM +0200, Sagi Grimberg wrote:
>> +static struct nvme_ns_head *nvme_find_ns_head(struct nvme_ctrl *ctrl,
>>   		unsigned nsid)
>>   {
>> +	struct nvme_subsystem *subsys = ctrl->subsys;
>>   	struct nvme_ns_head *h;
>>     	lockdep_assert_held(&subsys->lock);
>
> IMO it is a bit strange that we now don't pass in the subsystem but
> require that the subsys->lock is taken...

We do things like that in various places, mostly because information
needed that is subsystem-wide hangs of the nvme_ctrl structure, in
this case the various feature bitmaps.  We could move them to the
subsystem structure, which would be the right thing to do but a fair
amout of churn for little savings.

>> +++ b/drivers/nvme/host/multipath.c
>> @@ -504,10 +504,11 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
>>     	/*
>>   	 * Add a multipath node if the subsystems supports multiple controllers.
>> -	 * We also do this for private namespaces as the namespace sharing data could
>> -	 * change after a rescan.
>> +	 * We also do this for private namespaces as the namespace sharing flag
>> +	 * could change after a rescan.
>
> What happens in this case? we now have non-unique shared namespaces?

The non-uniqueue NSIDs can only happen for private namespaces.

