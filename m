Return-Path: <SRS0=TRJs=IE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C939C433DB
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 07:10:09 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80C2B64FED
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 07:10:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80C2B64FED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jR15m8b8Bwxoy90eYXvEAd6FeSqbyRAZbhINjubYgOU=; b=pUKfwnBs7/fRP27I7OWEea8Qb
	M2sumA7Y1/3axvPwLedy+gGi3jYnOVcGwdW4mpNghNuF4hvMv4M7cLA0wi+8sryIa9sjgk4QACjRt
	+0miOZuhEl3I52rIUYMLUtKb4xmtX1KSGOUr4YMK6GUJQKZ71S4S4Rka5JSReOhDDWxOeFIsJzOUY
	VyEj8WpQnOYKh5yNgl926XSYZhAhyT1WoqlFeFSQhE6WRT9c/up430z+gNgeh5l9rRbbmnjOl1xe/
	Zxz84nX6OjO1nCqyoz01HK6VE9Pvir0sRZUxj+gc5xIfa4kDNR5g8ZPQfQ0TzbVc4H8lUIJwkNNMd
	wiydHcL8Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIR4T-001s4t-06; Sat, 06 Mar 2021 07:09:53 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIR4O-001s1q-K5
 for linux-nvme@lists.infradead.org; Sat, 06 Mar 2021 07:09:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5668B68B05; Sat,  6 Mar 2021 08:09:44 +0100 (CET)
Date: Sat, 6 Mar 2021 08:09:44 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/3] nvme-fabrics: only reserve a single tag
Message-ID: <20210306070944.GA28323@lst.de>
References: <20210303125304.1200789-1-hch@lst.de>
 <20210303125304.1200789-2-hch@lst.de>
 <49d65274-002c-237b-163e-c3d482644a80@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <49d65274-002c-237b-163e-c3d482644a80@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210306_070948_806369_7E350C7A 
X-CRM114-Status: GOOD (  19.65  )
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

On Fri, Mar 05, 2021 at 12:51:15PM -0800, Sagi Grimberg wrote:
>
>> Fabrics drivers currently reserve two tags on the admin queue.  But
>> given that the connect command is only run on a freshly created queue
>> or after all commands have been force aborted we only need to reserve
>> a single tag.
>
> Umm, I think this would be an issue for non-mpath fabrics devices...
>
> When we teardown the controller, we iterate over all tags
> and cancel them, however for non-mpath devices these actually
> stick around until they exhaust the retrys counter (with the
> hope that the controller will reconnect again) unlike the mpath
> case where the requests are failed-over.
>
> Now if the admin queue is absolutely full during a reset, we won't
> have a keep-alive command.
>
> One possible solution is to make sure that
> nvme_decide_disposition to complete a request for admin
> commands. However note that this means that admin commands
> would fail immediately when the controller resets, which is
> a regression from the existing behavior and we may piss off
> users with that...

We never retry admin commands!  And the reserved tags are set aside
and not relevant to the "normal" commands.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
