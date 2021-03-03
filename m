Return-Path: <SRS0=PLgZ=IB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87FDC433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 19:33:51 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47ECF64EFE
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 19:33:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47ECF64EFE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ebmdh0zIK3mAq2MRk5CTbVkhTmQ57RxG+NKWNqD6qLQ=; b=kxzj9vyHE+GXhye9yO2Bca5t9
	yCUHvESYtg8OTv3Y/JdJMsSxeXeUb3U/z91gbkk1hOfKINgy1e5H3LcTZ2X+WOyg5KMqhfIdlPfNy
	eoO4SE6KR7WVKU5wa6+EtQ1o0iXLhbjMfSvRBU8T6vK01v4eYZT+3h+89Aa4gqvCr/Ilj9lt+bwg9
	2ngP6MUM7vPc1rK0G45YxagGprZXoaO1XRoTEZzu8YWNRcbNUi5oub50fX5/dsNcfOF+VhF7U0V8e
	zOjI+13+r83M8++HqP1F5J7ySYlWz1bUamgQtkrxxh25KWz2XPN/W7rLgGNB9fsMN3fKeP7opUl38
	+DoiDUc1A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHXFb-006Eb2-H4; Wed, 03 Mar 2021 19:33:39 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHT3W-005I5U-0R
 for linux-nvme@desiato.infradead.org; Wed, 03 Mar 2021 15:04:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Ej09FALI2hwklkqA+vxW/XErRw3FT6s6YweFg1oMaYI=; b=YmIACHQuYFiW+FHhn00JbkbmyN
 zQeDFuRMTUdWmfchTc7Kk0aVAP3HUGvwyS/CKSHngtPz057afcZ3jiGQWMHmOVSurX1rJDnW8vwQX
 PtGvLoE6Q/A1fUJOXJRTsTgrLc43JvbcJgRjQtJ0RO6QJwWoLmH9K4uxEjHxTVKkm6tEYJW8yq8n5
 eZadttqzYy0cJpZMNB0oaFc4N7EhY4jfCruYRvhQOyiJT7xms8NsG/cRhwJyl3RZx0IntddV182bw
 olN40D81dLM2MDRWcYuc7BMGRv4ShELGsZIeN1+ZDTtaZKTp3w5bIfg244Z1eLEjuDbD43M9pb3my
 fPR+2iKg==;
Received: from verein.lst.de ([213.95.11.211])
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHQjJ-002ZCf-3h
 for linux-nvme@lists.infradead.org; Wed, 03 Mar 2021 12:35:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5CD5668B05; Wed,  3 Mar 2021 13:35:50 +0100 (CET)
Date: Wed, 3 Mar 2021 13:35:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, Daniel Wagner <dwagner@suse.de>,
 Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/3] nvme: fixup kato deadlock
Message-ID: <20210303123549.GB28477@lst.de>
References: <20210302092644.80701-1-hare@suse.de>
 <20210302092644.80701-2-hare@suse.de> <20210303084210.GB9898@lst.de>
 <fee91925-6e3f-69b3-2d9e-2561789425a6@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fee91925-6e3f-69b3-2d9e-2561789425a6@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210303_123553_393942_5F050358 
X-CRM114-Status: GOOD (  17.77  )
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

On Wed, Mar 03, 2021 at 01:01:50PM +0100, Hannes Reinecke wrote:
> > Adding BLK_MQ_REQ_NOWAIT should be a separate prep patch, together with
> > reducing the number of reserved tags.
> > 
> Okay.
> But why would we need to reduce the number of tags? It's not that we're
> changing anything with the allocation, we're just guaranteed to fail if
> for some reason the stack messes up.

Because we could otherwise still have to keep alive requests, or one keep
a live and one connect requests allocated at the same time.

> 
> > Also why do we still need the extra test_and_set_bit with the
> > NOWAIT allocation?
> > 
> This is essentially a safeguard; there is nothing in the current code
> telling us if a KATO command is in flight or not.
> And I really do hate doing pointless work (like allocating) commands if
> we don't need to.
> 
> Plus it'll differentiate between legit callers of
> nvme_start_keep_alive() (which can be called at any time, and hence
> might be adding the ka_work element just after the previous one had
> submitted the KATO command), and real failures like failing to allocate
> the KATO command itself, which points to a real issue in the stack as
> normally there should be enough reserved commands.

You can distinguish them by the error code from blk_mq_alloc_request.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
