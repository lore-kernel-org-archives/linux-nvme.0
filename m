Return-Path: <SRS0=pxZf=IH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC075C433DB
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 11:31:27 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 022CB65259
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 11:31:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 022CB65259
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6mNMuVdNovsinOfAzcIjBBZ3aldl9/MNB4b3dAckv+A=; b=IhokN3hgnM1kU3giHySIzhvyf
	PgAa4XhA17wJIiuUYqr2QbRy43UEkLit318Bsg9DEe7ZiIF4B3M9/oBls1jmxqg/oBVgzPhXvGSiH
	mM2wAJ1NOL3PpZlCxMKSwjLf91cewYLXiPp+6qbKk4YrLP2vNBB4Ii2fsYxqFE3F2hb4yek1JCmy8
	G5zncbAtQjIt/OGGCREm7CDI7jmDFbq+GcYhPer9t3O9k4EMsGz6Z3vQkT64HtR58ytyfPnzlsirL
	RrshnXZYaCvzor9pXv/f2L7SMFhGDcT2f8wqWHLuK5iVHcs8gLNi9Zh69rqN9sm0NxUjNn8+BbLfK
	f5rfF7iRA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJaZz-004KEE-LY; Tue, 09 Mar 2021 11:31:11 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJaZt-004KD2-Vj
 for linux-nvme@lists.infradead.org; Tue, 09 Mar 2021 11:31:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3625868B05; Tue,  9 Mar 2021 12:31:03 +0100 (CET)
Date: Tue, 9 Mar 2021 12:31:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, kbusch@kernel.org, sagi@grimberg.me,
 minwoo.im.dev@gmail.com
Subject: Re: [PATCH V6 1/2] nvme: enable char device per namespace
Message-ID: <20210309113103.GA9233@lst.de>
References: <20210301192452.16770-1-javier.gonz@samsung.com>
 <20210301192452.16770-2-javier.gonz@samsung.com>
 <20210303091022.GA12784@lst.de>
 <20210303100212.e43jgjvuomgybmy2@mpHalley.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210303100212.e43jgjvuomgybmy2@mpHalley.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210309_113106_248004_6FD38036 
X-CRM114-Status: GOOD (  19.82  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Mar 03, 2021 at 11:02:12AM +0100, Javier Gonz=E1lez wrote:
>> Ignoring some of the deprecated historic mistakes I think the policy
>> should be:
>>
>> - admin commands that often are controller specific should usually
>>   go to a controller-specific device, the existing /dev/nvmeX
>>   devices
>> - I/O commands and admin command that do specific a nsid should go
>>   through a per-namespace node that is multipath aware and not
>>   controller specific
>
> Sounds good.
>
> The current implementation re-routes IOCTLs to the char device through
> the existing bdev IOCTLs, so I believe we follow this policy already. We
> basically default to current behavior.
>
> And I assume that for legacy, namespace IOCTLs to the controller will
> still be routed to the namespace (assuming a single namespace).
>
>> Which also makes me wonder about patch 2 in the series that seems
>> somewhat dangerous.   Can we clearly state the policy implemented?
>
> Patch 2 is the one that exposes the existing logic for multipath. How do
> you think we should do it instead?

So trying to follow the code:

 - nvme_cdev_fops implements file operations that directly on a nvme_ns,
   so they are path specific
 - we allow opening them even for a hidden controller
 - there does not seem to be a char device node for ns_head at all.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
