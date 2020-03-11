Return-Path: <SRS0=tokg=44=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C8EC4CC9E
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Mar 2020 15:21:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 454CB20739
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Mar 2020 15:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="baCyezWb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 454CB20739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=C4Qnq8xEFfPems08BqpKIyyyv3Ev2cEjsPDhmDwaQVA=; b=baCyezWbcHnyt2
	R3HmkJQgPaypo7CLOJw3f6IMsuhiJEYLbv+D3H5auBU9tvHzlH3WCATlAG8pbG5mFPRhg8f2Z5Ok8
	CP5wjKWVCN2HuNuMWKu8zcGCB9QtifIXvzwBw2gQaTlQtNvFTnPa9ooH3VdRQ0l4Tz8xLKkBDwJNt
	hD7AACcgxW4xr/6kVahqqrENyWjlAfPcbxVuscw101h8HpAWb6lUsej2dr9nANu/KyZy8L4hnPC4q
	ElbCUVvJCDzeCDrcYIvBtF5ZOYwJ75H0qoorrGohXSZxSOFWRId4OM4BUut5nAiLgG7czAQ7nQWxa
	KrcFWjaTtFxF9BZ4aW9w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jC3Ai-0004KY-1x; Wed, 11 Mar 2020 15:21:24 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jC3Ae-0004Jj-N8
 for linux-nvme@lists.infradead.org; Wed, 11 Mar 2020 15:21:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8684E68B05; Wed, 11 Mar 2020 16:21:14 +0100 (CET)
Date: Wed, 11 Mar 2020 16:21:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] nvme-fabrics: Use scnprintf() for avoiding potential
 buffer overflow
Message-ID: <20200311152114.GA23704@lst.de>
References: <20200311085037.18888-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200311085037.18888-1-tiwai@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200311_082120_904060_C12D4547 
X-CRM114-Status: UNSURE (   8.12  )
X-CRM114-Notice: Please train this message.
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Mar 11, 2020 at 09:50:37AM +0100, Takashi Iwai wrote:
> Since snprintf() returns the would-be-output size instead of the
> actual output size, the succeeding calls may go beyond the given
> buffer limit.  Fix it by replacing with scnprintf().
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
