Return-Path: <SRS0=Iqha=GV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1AAC433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jan 2021 17:41:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2387223E8
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jan 2021 17:41:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2387223E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wWjNYXbadU/pxXR8llrHe2I7LOH9+s5mvuk3yEq8aDM=; b=vBdrpoOX8RHoSrI8Yp/DxZBhZ
	ae5MnBBc/5dT4g6PQmJPU5t7KpuzuNsfIhx+KrTz9V/VG3tA3yPTguvbW1Cf9n8UJ5L0OL4TtYST7
	u3Yirb88EaSfCxWuJJkSZRcZ+7h3IpZQtmdP5nej923/G6fix5jNDHYaq6/cqSb7Bv2p73y9JvxOH
	1EBN4uQdhSfiI5i22ygcYojLW5dYlOGM3jclEAiIFeBl8EI2UIoFnDKlX2PhdRAb7/zv79BRaatX/
	jdbfknLtaevcj9QuvFr0vfwZryU4uwrkIkD6qLhBTcgQVYGuJA3PwipLEnjAeQ2wCm6CLjToBkVC2
	bhl/Pg4dA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l1YWZ-0003GW-Ll; Mon, 18 Jan 2021 17:41:07 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l1YWT-0003FZ-HU
 for linux-nvme@lists.infradead.org; Mon, 18 Jan 2021 17:41:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id ED1BE6736F; Mon, 18 Jan 2021 18:40:51 +0100 (CET)
Date: Mon, 18 Jan 2021 18:40:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH V3 3/3] nvme: retry commands based on ACRE flag
Message-ID: <20210118174051.GA8542@lst.de>
References: <20210114133110.20779-1-minwoo.im.dev@gmail.com>
 <20210114133110.20779-4-minwoo.im.dev@gmail.com>
 <20210115170412.GA1515933@dhcp-10-100-145-180.wdc.com>
 <20210115182602.GA2822@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210115182602.GA2822@localhost.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210118_124101_718111_70A6D665 
X-CRM114-Status: GOOD (  17.05  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Chao Leng <lengchao@huawei.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sat, Jan 16, 2021 at 03:26:02AM +0900, Minwoo Im wrote:
> > I am not sure we should ignore the FAILFAST for non-path errors. If we
> > need retryable admin commands, we should let the driver provide a way
> > for callers to dispatch requests without that flag.
> 
> Understood.  I thought the opposite way about FAILFAST in case with
> acre, if device is enabled with acre, all commands would be retried
> regardless to FAILFAST...  Thanks for pointing that out!
> 
> How do you think which one is right choice to go with if a user-space
> application(e.g., nvme-cli) wants a command to be retired in case of
> ACRE && Error && !DNR:
> 
>   - User-space application should figure out !DNR and retry the command.
>     (Maybe we are not able to easily figure out exact status code from
>     the user-space application by the return value).
> 
>   - Driver should retry the command right before putting result up to
>     the user-space even it's a FAILFAST request.
> 
> Thanks,

We could come up with a version of the ioctls that use the normal
retry mechanisms.  nvme_passthru_cmd64 has two reserved fields we
could use for UAPI flags like this.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
