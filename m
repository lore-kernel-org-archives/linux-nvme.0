Return-Path: <SRS0=ETB4=CR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0DEC2D0A7
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Sep 2020 16:48:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AD8520708
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Sep 2020 16:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="xQqcaw7J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AD8520708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ptmRb/4n7nINLxbOBQqFS76PRu2SE5YtB0W9rB00q9Q=; b=xQqcaw7JicIr8Qmg9j6JxUnpj
	UM9Gunp8B6mZILYAJyBIxzB0dryiDyKcH4cl+Xq/PwPZNhGxeQ0eopoH/5v/ahf4BdPC24YsiU4mu
	Ir7pDcUOT/qVeG2bo1E1wcXLmlDCQAgmYCFA0LiX+rXPBOOggMuGHjuQwjF4OCQFgzDx+Y5Znjm42
	FF+yQ6SVnjYeBe6qtVVNeBG1eyYYb/Vikf6u9gecwAyTSqJXuWQOUi1rl1EAKACJ881kcEL8DiRN2
	Ak8VljMWu3LohHqleuuuodwaIvQKH9Cbt9pYBxd+yEKh5KsvqkPIkPbWym5fgIRJAkoj79jqxBPb/
	h+3f05QLw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kFgn9-0007nN-Fm; Tue, 08 Sep 2020 16:48:23 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kFgn7-0007lj-7b
 for linux-nvme@lists.infradead.org; Tue, 08 Sep 2020 16:48:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4E88C68AFE; Tue,  8 Sep 2020 18:48:18 +0200 (CEST)
Date: Tue, 8 Sep 2020 18:48:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v3 2/9] nvme-fabrics: allow to queue requests for live
 queues
Message-ID: <20200908164818.GA17210@lst.de>
References: <bdd4f4b8-be68-2edc-5378-32c97eb3f1ae@broadcom.com>
 <20200821062217.GC28559@lst.de>
 <77e27c4e-f939-2c14-8e63-209197f1133c@grimberg.me>
 <20200825071345.GF29268@lst.de>
 <cf1a5428-2378-213a-7c7f-1fca81fda77e@grimberg.me>
 <128d9766-292f-1e6c-1c0f-3651b4863e6a@broadcom.com>
 <9a1bd3fb-203b-8a33-76b9-cb373d02744d@grimberg.me>
 <c24eeef2-e235-f095-0a34-8b62fe917e5a@grimberg.me>
 <20200908090518.GA18666@lst.de>
 <d8567289-1c33-9e82-570c-c77ba52e7a5d@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d8567289-1c33-9e82-570c-c77ba52e7a5d@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200908_124821_392562_7D2BEF87 
X-CRM114-Status: GOOD (  15.21  )
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
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, James Smart <james.smart@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 08, 2020 at 09:47:24AM -0700, Sagi Grimberg wrote:
>
>>> Guys, we need to resolve this one, this is needed to prevent freeze
>>> during reset from hanging.
>>>
>>> As I said, any I/O that will use the ns->queue shouldn't be denied here
>>> because it takes the q_usage_counter and will prevent a freeze (this is
>>> true for both fs or user I/O commands).
>>>
>>> I still think we should allow the admin ones as well and deny them
>>> somewhere else if we want to, but I'm fine with keeping this exception
>>> now because no one is expected to freeze the admin queue.
>>>
>>> Let me know what you think. I want it to go into an rc soon.
>>
>> Let's do the minimum change variant for now then.
>
> The patch in its current form is that minimum. I suggest we take that
> and work our way from there.

Can you resend it?  I'm about to do a patch sweep.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
