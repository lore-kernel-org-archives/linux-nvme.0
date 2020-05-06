Return-Path: <SRS0=TIQn=6U=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF85C28CBC
	for <linux-nvme@archiver.kernel.org>; Wed,  6 May 2020 07:08:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E74E20721
	for <linux-nvme@archiver.kernel.org>; Wed,  6 May 2020 07:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N+gYXYRI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E74E20721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cBM2dz90xppLfLT9HNzKP42oZZgHtHTI1mEAuPy9wgU=; b=N+gYXYRIyH4edS
	oO9WM7M4OnpuLXX+RNtLKYejPgF/PfjXQVtG6YiZzZDRgR6KcKAiMGgAbUsLGYUvobcID6aNIJGt3
	IQXCxCmxXchBWorxtDqfL1BHzTIOAJgAUb9RhyvkeRohWwHWmfxXIcCOmKH+eh+TumOy2KN627WFo
	UerZzULh5zcopPBdOYsxFa4fMJTcyIRX7EgqLBA1WR8nxk9d56YgwHqhrLGUkZAj1Amd/LrFP+ggR
	CaYFoQBQucZ7rorM8+PcPdX10wr8g85QFGRNSrusq5bD0+ua7Y3aVYmMRZbX14IQfaHI7Y9uED6oy
	j+OJyaCsQidm1KtQnQAw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jWEAk-0008TF-GG; Wed, 06 May 2020 07:08:50 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWEAh-0008SW-UV
 for linux-nvme@lists.infradead.org; Wed, 06 May 2020 07:08:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id D220168C4E; Wed,  6 May 2020 09:08:44 +0200 (CEST)
Date: Wed, 6 May 2020 09:08:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH 05/16] nvme: introduce max_integrity_segments ctrl
 attribute
Message-ID: <20200506070844.GA12096@lst.de>
References: <20200504155755.221125-1-maxg@mellanox.com>
 <20200504155755.221125-6-maxg@mellanox.com>
 <0deb0516-0183-e7a5-0e0c-668e589438e7@broadcom.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0deb0516-0183-e7a5-0e0c-668e589438e7@broadcom.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200506_000848_132098_818B032F 
X-CRM114-Status: GOOD (  10.18  )
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
Cc: axboe@kernel.dk, jsmart2021@gmail.com, sagi@grimberg.me,
 martin.petersen@oracle.com, idanb@mellanox.com, israelr@mellanox.com,
 vladimirk@mellanox.com, linux-nvme@lists.infradead.org, shlomin@mellanox.com,
 oren@mellanox.com, kbusch@kernel.org, Max Gurtovoy <maxg@mellanox.com>,
 nitzanc@mellanox.com, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, May 05, 2020 at 04:51:02PM -0700, James Smart wrote:
>
>
> On 5/4/2020 8:57 AM, Max Gurtovoy wrote:
>> This patch doesn't change any logic, and is needed as a preparation
>> for adding PI support for fabrics drivers that will use an extended
>> LBA format for metadata and will support more than 1 integrity segment.
>>
>> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
>> Signed-off-by: Israel Rukshin <israelr@mellanox.com>
>> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> ---
>>
>
> Would have preferred this was known as max meta segments without typing to 
> pi. But this is fine.

I can't find pi anywhere in here - it says integrity.  That's the Linux
name, metadata would be the NVMe one.  I'm fine either way.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
