Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD23C3ABC0
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 06:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w5Mp+qN3I7CosWnjwDk99Xhd2wxOlS7ElVSUvhL+sgM=; b=QkDOu1ayZgvO2JRfjhQ3FrN5T0
	4J5GYhRxJtAc9LCDzqeO++8iHo1x6+3YjG2ebygBzsTPTak5yj7kXrukF7x50ZHXqtyFNjmoU7ln0
	om0rBZbGANYUOdcV4MZZhD+Bay6sug4zHm94gSTra2k61d656yEbHBRK/TltQDboqfnDqRZZRvm5U
	qujr3NuqYwMr08xelI77gI08nGg8w2yQZZx+rL2cnrEcnihxD4zuTKgWnRRBD4SdjDf1uQ1GfdJ8Y
	v9LANQjH3VwJ4mwfSdDCd3ewDYTXlblI93D3XAEDCryTLs3SUILFD93E88dpzzw1UWJhykJ2VQjsY
	kc4+Bimw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCYd7-0000000EQIO-03S1;
	Wed, 07 May 2025 06:51:45 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCYcL-0000000EQDd-06PA
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 06:50:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DB69968BEB; Wed,  7 May 2025 08:50:50 +0200 (CEST)
Date: Wed, 7 May 2025 08:50:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org,
	hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
	jmeneghi@redhat.com, axboe@kernel.dk, martin.petersen@oracle.com,
	gjoyce@ibm.com
Subject: Re: [RFC PATCHv3 1/3] nvme-multipath: introduce delayed removal of
 the multipath head node
Message-ID: <20250507065050.GA31543@lst.de>
References: <20250504175051.2208162-1-nilay@linux.ibm.com> <20250504175051.2208162-2-nilay@linux.ibm.com> <dd7330a2-6499-4af7-af3a-489ab86d2b5f@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd7330a2-6499-4af7-af3a-489ab86d2b5f@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_235057_209157_65D02083 
X-CRM114-Status: GOOD (  11.95  )
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

On Mon, May 05, 2025 at 08:39:11AM +0200, Hannes Reinecke wrote:
>> +	if (ctrl->ops->flags & NVME_F_FABRICS)
>> +		nvme_mpath_set_fabrics(head);
>>   
>
> Please make this a separate patch.

Absolutelty not if we keep this, as there is no other user.

But I still don't like the fabrics special casing at all.

I'd much rather just disable it if opts is present and max_reconnects
is set to non-0.


