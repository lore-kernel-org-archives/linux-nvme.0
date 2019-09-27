Return-Path: <SRS0=X9H7=XW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E61C4360C
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Sep 2019 21:41:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0EDD2075D
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Sep 2019 21:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EHEz3d8f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0EDD2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=c26/1dpj0C1SDrxDZ0FXfFnzkZcg2/Wv6AJAFmnaBDY=; b=EHEz3d8fpqiLxc
	olY52SAJTwUNmGWOpbKZofJVXAnEX+AdHVOTz/doFQoeAs+ZFiG9PUtkhY8w3yq9+v3bytmjYGcUF
	n+JnxSn92hqwJWr/rWeYC6gkDRK6FAOTR4MG4S0DeCbv0X6s7+/pL/wIosTYFW9AakjKWmr6AGYYK
	/UJCmzWUdyvXCMzYkftgpTtMnhaXkDuxFNncq3Ptv3ylGRRahDgF7YV9qnZYhO0zj8h/gQ4dgQ9Yb
	Rx19oyaGzMquqNdWxuEYTANfTK1GW3umntzCoFKPAtgthoqfrvLV9iJRBkajnLp+2uEsejLA/MI0m
	kCGlB9vuf+lyNb90vb8g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iDxzU-0004ox-W2; Fri, 27 Sep 2019 21:41:28 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iDxzR-0004oX-U0
 for linux-nvme@lists.infradead.org; Fri, 27 Sep 2019 21:41:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2968868B05; Fri, 27 Sep 2019 23:41:22 +0200 (CEST)
Date: Fri, 27 Sep 2019 23:41:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org
Subject: Re: [PATCHv2 5/6] nvme: Prevent resets during paused states
Message-ID: <20190927214121.GK16819@lst.de>
References: <20190919213431.7864-1-kbusch@kernel.org>
 <20190919213431.7864-6-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190919213431.7864-6-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190927_144126_113331_166F5B12 
X-CRM114-Status: UNSURE (   9.67  )
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
Cc: James Smart <james.smart@broadcom.com>,
 Edmund Nadolski <edmund.nadolski@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Sep 20, 2019 at 06:34:30AM +0900, kbusch@kernel.org wrote:
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 95b74d020506..33b5729763c2 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3742,15 +3742,14 @@ static void nvme_fw_act_work(struct work_struct *work)
>  		if (time_after(jiffies, fw_act_timeout)) {
>  			dev_warn(ctrl->device,
>  				"Fw activation timeout, reset controller\n");
> -			nvme_reset_ctrl(ctrl);
> -			break;
> +			nvme_reset_continue(ctrl);
> +			return;

Hmm, I find the use of a function named nvme_reset_continue here
rather confusing, as there is no reset we are continuing.  Yes, we place
the controller in resetting state, but it isn't really a reset in the
traditional sense.  What is the rason against a separate paused state?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
