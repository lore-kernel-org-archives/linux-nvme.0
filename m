Return-Path: <SRS0=g+aI=DG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC20C47423
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 18:34:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BD352145D
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 18:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PE2DO9M8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BD352145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2AuDcQWxRREHagEymJBlR4O+lgLHKioQ/bHGbMPGA48=; b=PE2DO9M8h8dRIPU3EiHR/VaE3
	GlyQJ8SrIdHQakZXckiB9vflZlcQ5d+EPcqle2xamazX3AZy2nu1y6QpHx5pRqI/hFOWl+QzzManm
	ujpK3GpDlS6w2qrf4SUYussIpVDCupEFubGtWbR0pUilAnbqK6iNFoEf8L+VSv3SqD3rKeLacntbZ
	TUBZfW+4COey3ZrV1WxqvUIXr4tVcW/CR6CcEXCD4Qvnc1EzvpeQNRzF5ecDKJm8cHHmJqQw0Y+ir
	2hkD//VWRQntaBsFk9hJrn5Lb/Q3bZiVh4ZSsiYq2MN2Z71ZDSrLDLQ1UNkv1AH89uZ2+HKDv1/Xj
	9s/bBbQZw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNKSj-00051h-UJ; Tue, 29 Sep 2020 18:34:54 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNKSg-00050b-Nd
 for linux-nvme@lists.infradead.org; Tue, 29 Sep 2020 18:34:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 16B2E67373; Tue, 29 Sep 2020 20:34:49 +0200 (CEST)
Date: Tue, 29 Sep 2020 20:34:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 12/20] nvme: remove the 0 lba_shift check in
 nvme_update_ns_info
Message-ID: <20200929183448.GG12948@lst.de>
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-13-hch@lst.de>
 <b565768e-9ef3-8d57-bd25-f8f16f434d2a@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b565768e-9ef3-8d57-bd25-f8f16f434d2a@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200929_143450_943095_D06E2F78 
X-CRM114-Status: GOOD (  11.39  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 29, 2020 at 01:52:40AM -0700, Sagi Grimberg wrote:
>
>> We can't reach this code if Identify Namespace failed.
>
> Technically it'd be more accurate if you write we "We can no longer
> reach.." as this used to be the case, but otherwise looks good.
>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

Ok, I've fixed this up.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
