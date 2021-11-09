Return-Path: <SRS0=GOb3=P4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A21C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Nov 2021 14:31:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40C0F61105
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Nov 2021 14:31:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 40C0F61105
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=erB6vCCuzUGoEK3Rq6tRUkBAcAo/iLYN3wQrjVyxcgE=; b=yqLjM/nDFkBweCJRLQGkMn6n7b
	HeXhIDt9EtTTmUwUOd9cgbkuL2EMOxd9hq1xo26sDuuNS2sX+mwuIK7TUJEQDM6ozfqNAnEOp7PBG
	DOk+MhcdbbsDi9WnAzvaoxuepqv3dOs8Pv5yGQan8yoyb4O82cD1n/NToZYGyhtBta31lg5QVDSYh
	IOD9J9BrndK6U5wWVHinar28i4UNp2WeQusdRCdoSxCYVvVbYZhp0fBYSzF7AjtfZOYYpSy4xdq+J
	EI0nKSTGhWjo9T5T1NdSHIWebhDN5b8nSY2om9cZ0gLscMobdBsU3BryXbuV3yF8rTV1CHJqzZ/hp
	oJl9ysug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mkS9V-002Qgf-D7; Tue, 09 Nov 2021 14:31:09 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mkS9S-002Qfe-VQ
 for linux-nvme@lists.infradead.org; Tue, 09 Nov 2021 14:31:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id CC98967373; Tue,  9 Nov 2021 15:31:02 +0100 (CET)
Date: Tue, 9 Nov 2021 15:31:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, sagi@grimberg.me,
 chaitanyak@nvidia.com, oren@nvidia.com, benishay@nvidia.com,
 borisp@nvidia.com, aviadye@nvidia.com, idanb@nvidia.com,
 jsmart2021@gmail.com
Subject: Re: [PATCH v1 0/4] Add command id quirk for fabrics
Message-ID: <20211109143102.GA25263@lst.de>
References: <20211108144703.7971-1-mgurtovoy@nvidia.com>
 <20211108164511.GA2660170@dhcp-10-100-145-180.wdc.com>
 <20211109080903.GA28785@lst.de>
 <6292cd43-c746-0316-1820-aa52ec85d375@nvidia.com>
 <20211109131510.GA19713@lst.de>
 <9c740227-8c98-5877-9a9a-ae17756e851c@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c740227-8c98-5877-9a9a-ae17756e851c@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211109_063107_209224_039DDE80 
X-CRM114-Status: GOOD (  15.55  )
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

On Tue, Nov 09, 2021 at 04:23:33PM +0200, Max Gurtovoy wrote:
> On 11/9/2021 3:15 PM, Christoph Hellwig wrote:
>> Max, if you can't point us to a broken target (and yes, it is broken)
>> this will not go anywhere.
>
> Any target that uses Apple device as backend can be harmed.
>
> Most simple example is Linux PT target that copy the sqe as-is and passes 
> it to the NVMe Apple drive.

Take another close look at how command_id are assigned my Linux driver.
We obviously do not pass it through as that would be completely broken.

