Return-Path: <SRS0=nBdQ=IC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF4BC433DB
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 08:41:27 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26CBD64EF4
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 08:41:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26CBD64EF4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=j1U9yx0xmRLJcr90XbLSuuH5WENm5MLcgLj+BUMJUoI=; b=EtxpNNluNFxQoWjYSuJnaoebL
	eswJHo1UJTbzP3h7v7JwmE0SLTfbA/3QfPStJ2e1NQ9Qzexh1ZP/ZkE7rlJuSZluxztSDC8K6L+7W
	5Dus63SzcibF+BtzJQSBMdNiMFjcJ1T6yE5gsiOLpo2ohlfCaBw2REESFKiHVSFJDbGQZ9Hd7V1zw
	IPVMMH5wF6RzWc6fSK3soQKKyDYuRJItDI5SO6APVo3l6G/rt/7+kZKdwVh4NIhkyD4iK4+o6/Vct
	odUWoRs3I39RIW/vDJ+RQNWzd+uohM3sDJXsjuWnL/zWlZc9puZGg4lP2Ul0cIDbMzXEPksnxjxF3
	oq9FcBcyQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHjXq-0089aH-Mz; Thu, 04 Mar 2021 08:41:18 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHiws-0086jU-OU
 for linux-nvme@desiato.infradead.org; Thu, 04 Mar 2021 08:03:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=5ZMWG8Fh74iwRExbMTQ9ETjCLmJFuIsEuGr6u/ZTjh0=; b=p4xqb/U0ug06X7DfD6XOFpzOAs
 McZ0uYH6jCsVnmtAM1+MoHZ4sGbjNUSj51gwRg14THMSJMxYB+pFOo7XyVBHll9IM+k7gY1STTnM4
 eFUVfWG+FhgCNxUv/LdlW0DLr5ML8t0srmMBywovJhn1fowskB8jcLXP3roGaVLm11rgLTUjB2VdM
 g8mqrCmHKeyEHbCRCAM/UIzJtref3w6UGMPY5wFy37EDNU188Gr84jzpnCliUxGh7mRVxKxPPrgO5
 /1JTLd4qbJNbtdBcJES0MKtecD7TefPnSGiQvL9giiOyLYstGkM3OLPjS7nwsPVqfDdcqOp3A06IY
 88v0Y2Sw==;
Received: from verein.lst.de ([213.95.11.211])
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHiwa-006AWL-OJ
 for linux-nvme@lists.infradead.org; Thu, 04 Mar 2021 08:02:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id D119468B05; Thu,  4 Mar 2021 09:02:41 +0100 (CET)
Date: Thu, 4 Mar 2021 09:02:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, Daniel Wagner <dwagner@suse.de>,
 Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/3] nvme: fixup kato deadlock
Message-ID: <20210304080241.GA12617@lst.de>
References: <20210302092644.80701-1-hare@suse.de>
 <20210302092644.80701-2-hare@suse.de> <20210303084210.GB9898@lst.de>
 <fee91925-6e3f-69b3-2d9e-2561789425a6@suse.de>
 <20210303123549.GB28477@lst.de>
 <9655fc98-08c8-ff7d-0aaf-f29b935221d6@suse.de>
 <9ea53e09-2ab5-733a-7f1d-fd2404794149@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9ea53e09-2ab5-733a-7f1d-fd2404794149@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210304_080254_565166_AC5CCB27 
X-CRM114-Status: GOOD (  10.03  )
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

On Wed, Mar 03, 2021 at 03:23:12PM +0100, Hannes Reinecke wrote:
> Actually, having thought a bit more, I'm not sure if we should change
> that. Changing the number of reserved commands _will_ have an impact on
> error recovery, up to the point that we cannot issue a 'connect' command
> if a keep-alive command is still running.
> Which means we might be seeing spurious connection failures during
> recovery, something which I'd be very cautious about.

We always do a blk_mq_tagset_busy_iter that cancels all requests before
reconnecting.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
