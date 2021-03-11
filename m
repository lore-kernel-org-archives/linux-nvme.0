Return-Path: <SRS0=tknV=IJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332C9C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 09:44:12 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6D9564F4D
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 09:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6D9564F4D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=NUTbx0D2zFy5SDGkGjJSOCXC5KsfNaiFr8KXJSQiPrU=; b=KWdoqqP0vJR0We4HNsoHT/G93
	yLk+5EXwdIJCpqyhf61+QXGIwTxW/qn5lWkvKVRoqSfHdfyhm1olzVpxo0iNFy001/5SEniLRB9rR
	03hh4pzGME+XE0pGHP2xUzFSFxeicKN+q6ciuAVrxGF6yHB72vkp1fLb3nZYsuTcXhOyxjXy3Njjn
	Up9y5r2nJEXxBT9UAbS6ntjnsG2AmZCg6XTuzo/ighGkwVg23t7PKyWV9fKpNL2iFEF74ct6HsUi9
	425pV9V8k94ycQ8ewUp/tUckd0yREpvfHCWUexEKyHm2tNEzcg71Nm9xZvxDuND1TdP3O46WbX5IH
	2fmm6vNXg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKHrC-008m0t-98; Thu, 11 Mar 2021 09:43:50 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKHr8-008m0Q-Ot
 for linux-nvme@lists.infradead.org; Thu, 11 Mar 2021 09:43:48 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id AC78DAC16;
 Thu, 11 Mar 2021 09:43:45 +0000 (UTC)
Date: Thu, 11 Mar 2021 10:43:45 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jens Axboe <axboe@fb.com>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] nvme-tcp: Check if request has started before
 processing it
Message-ID: <20210311094345.ogm2lxqfuszktuhp@beryllium.lan>
References: <20210301175601.116405-1-dwagner@suse.de>
 <6b51a989-5551-e243-abda-5872411ec3ff@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6b51a989-5551-e243-abda-5872411ec3ff@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210311_094346_884140_14CD0439 
X-CRM114-Status: GOOD (  15.38  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Sagi,

On Fri, Mar 05, 2021 at 11:57:30AM -0800, Sagi Grimberg wrote:
> Daniel, again, there is nothing specific about this to nvme-tcp,
> this is a safeguard against a funky controller (or a different
> bug that is hidden by this).

As far I can tell, the main difference between nvme-tcp and FC/NVMe,
nvme-tcp has not a FW or a big driver which filter out some noise from a
misbehaving controller. I haven't really checked the other transports
but I wouldn't surprised they share the same properties as FC/NVMe.

> The same can happen in any other transport so I would suggest that if
> this is a safeguard we want to put in place, we should make it a
> generic one.
> 
> i.e. nvme_tag_to_rq() that _all_ transports call consistently.

Okay, I'll review all the relevant code and see what could made more
generic and consistent.

Though I think nvme-tcp plays in a different league as it is exposed to
normal networking traffic and this is a very hostile environment.

Thanks,
Daniel

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
