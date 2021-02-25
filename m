Return-Path: <SRS0=GtbF=H3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8EDC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 17:00:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EED864F19
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 17:00:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EED864F19
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qkwcp+Yt49wd6YiCXiJ4FiP876VcWdA7lDZ0hCTOUJo=; b=IwJCjy844yDMAVQ1qTeuU32JG
	sUj2Z1igy2N7xn13aS0DITKqZaugrigQNNbFZwged+vFSUCl6R7fhFHYsvUoTHkJfbTmXOZuxM2U2
	6gdtAsYgKlPqieNfogpG95ZfiOk8XGz+sZuftY4T1Mo0XYy79kuOEI3J6G1oaz59QFrvkR3BuMl/i
	CfxvJNwJyhlKOvY0UoQimOvMCRUZJy83idW1+2UKpF+RwIMvfhCKdGqwniTFRFJH5oolZRTo5KDDe
	BKuhCUHmRQw201aEvVO3J3BFkCG9iNdPFkNWEGdfYae7k0EXaw2QYNzoQfyOOMsHGn1gBpspN/fJ1
	RrDLwo4cw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lFJzX-0008ID-Ez; Thu, 25 Feb 2021 16:59:55 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lFJzT-0008Hq-Qh
 for linux-nvme@lists.infradead.org; Thu, 25 Feb 2021 16:59:52 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3086E64E83;
 Thu, 25 Feb 2021 16:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614272390;
 bh=aIFYdiCVrRiSVn62foh1ssI9Cq464PWnNrSwnDAMX5Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LVgbAFALXuKFZ5nQqCg1SFbB51DJz2/Si3GR2sXbvn2Uaisu7OXeHeekthzr74c67
 JQA0n7Fzwuvq/m6ddNDxDo6zHHBR6X6hzZplJ34vW7HYkzC1LNDTd4RjubDQw6FF85
 BtBhe8ofseGOsTlg7kw4hu5Xk+k77eONFuaCSYM1Ix2Ywua6fGx6h9wWnKatVrc/5b
 8+FuVMMmEStqaBV1zR7w5JKrU36aj5TIrAk9oYAma3/67a4je4ZitkVQhyBkjVbkpM
 Ax+mOy2tuOYhcSRxBxtGlA4KdWxVE5xQz2wwbauiftV26z0MLDSEXRvWd2rl8+Kws2
 R3cp0kwHdBtcw==
Date: Fri, 26 Feb 2021 01:59:44 +0900
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/2] nvme: delete disk when last path is gone
Message-ID: <20210225165944.GF31593@redsun51.ssa.fujisawa.hgst.com>
References: <20210225110534.75710-1-hare@suse.de>
 <20210225110534.75710-3-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210225110534.75710-3-hare@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210225_115951_986089_8CA1424D 
X-CRM114-Status: GOOD (  15.99  )
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
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <keith.busch@wdc.com>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Feb 25, 2021 at 12:05:34PM +0100, Hannes Reinecke wrote:
> The multipath code currently deletes the disk only after all references
> to it are dropped rather than when the last path to that disk is lost.
> This differs from the behaviour in the non-multipathed case where the
> disk is deleted once the controller is removed.
> This has been reported to cause problems with some use cases like MD RAID.
> 
> This patch implements an alternative behaviour of deleting the disk when
> the last path is gone, ie the same behaviour as non-multipathed nvme
> devices. The alternative behaviour can be enabled with the new sysfs
> attribute 'no_path_detach'.

This looks ok to me. I have heard from a few people that they expected
it to work this way with the option enabled, but I suppose we do need to
retain the old behavior as default.

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
