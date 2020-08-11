Return-Path: <SRS0=CGXy=BV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635CCC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2020 03:45:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F90B206EF
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2020 03:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AA6uuYwi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F90B206EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1db+WwPpsE7h9scqgt1oc/P9Q1pyRTeUdN/ZX3HmUho=; b=AA6uuYwi9CmzZTX8VfZG4Xu4M
	0Rv+Lmbfg7s93sOCtXcX0OpRGgR2/2Z+3J8GWabek/trDYfzXIlePkBfkcUIx6U6ZkVx2NvxNxNtm
	6A1VNgwJNlHNvYx+ef/6Yn9VWiivj1OY83gBnfa5ohswvUwCN0E7SYal7TqkMT0tz5WhUSxh5cbkB
	btq/s3fjn8d6KqBD5KIu6GTlxvIp24j+ya3EjBNgOClC4WUBRA8SRuFO17QPlOs/qbE7fS+rHmivm
	SSEwrJrQ2PkMMMU+//BMtJiHtwXcBlMdLIgGXN4Va4RivAbVQUippGrEHXes1EEFyk0l9akJCX1NS
	z124BelnA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5LEV-0008Nz-SP; Tue, 11 Aug 2020 03:45:51 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5LES-0008NN-KV
 for linux-nvme@lists.infradead.org; Tue, 11 Aug 2020 03:45:49 +0000
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id DBEF2B0C725C53E21457;
 Tue, 11 Aug 2020 11:45:44 +0800 (CST)
Received: from [10.169.42.93] (10.169.42.93) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0;
 Tue, 11 Aug 2020 11:45:41 +0800
Subject: Re: [PATCH] nvme: restore use of blk_path_error() in
 nvme_complete_rq()
To: Christoph Hellwig <hch@infradead.org>, Mike Snitzer <snitzer@redhat.com>
References: <20200729055903.GC31113@lst.de>
 <43e5dee8-1a91-4d8b-fdb5-91f9679ddeb3@huawei.com>
 <8d01b123-478f-f057-1598-8283dd099b03@huawei.com>
 <20200805152905.GB1982647@dhcp-10-100-145-180.wdl.wdc.com>
 <255d55e3-f824-a968-e478-3efeda095696@huawei.com>
 <20200806142625.GA3075319@dhcp-10-100-145-180.wdl.wdc.com>
 <729820BC-5F38-4E22-A83A-862E57BAE201@netapp.com>
 <E3390A8E-D582-47BA-A085-21663D883365@netapp.com>
 <20200806184057.GA27858@redhat.com> <20200806191943.GA27868@redhat.com>
 <20200810124355.GB25070@infradead.org>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <67e83d28-a785-a1fd-7787-24d1217ca30b@huawei.com>
Date: Tue, 11 Aug 2020 11:45:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200810124355.GB25070@infradead.org>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_234548_948542_48E4D6AF 
X-CRM114-Status: GOOD (  16.20  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Ewan Milne <emilne@redhat.com>, "Meneghini, John" <John.Meneghini@netapp.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020/8/10 20:43, Christoph Hellwig wrote:
> Just returning from my vacation, and I'm really surprised about
> this discussion.
> 
> If you want to fix a device mapper / block layer interaction you do
> not change nvme code to use suboptimal interfaces.
Agree. Nvme define path error and local retry mechanism. It is more
reasonable to use the new mechanism.
> 
> One of the reasons for the nvme multipath design was to allow for
> tighter integration with protocol features, and making nvme do a detour
> through the block layer for no good reason at all does not help with
> that at all.
Nvme should use local retry mechanism. But now we first check the flag:
REQ_FAILFAST_TRANSPORT, if work with dm-multipath, REQ_FAILFAST_TRANSPORT
will be set, this interrupt local retry.
> 
> And if you want to support the TP that added the new command interrupted
> status code please read through it - the status code itself is just a
> small part of it, and none of the changes proposed in these discussions
> would lead to a proper implementation.
> .
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
