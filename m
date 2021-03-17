Return-Path: <SRS0=uaVC=IP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A44C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 06:47:33 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A49D64F96
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 06:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A49D64F96
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=44IWjIwiTOqgiicaOibs/fEjP1F7cKsDLj9rh/Gtxpo=; b=gwZuzXL077N2yVeRQsXMxVut+
	1zr0wZpvagKEwe4g9/wboAq2j2rpgzUCaASkal5oXyIXNi7atFwMCpVXmL58RDYr0Vg6jEGDlopJW
	bjMLdsTi8AqfVwQ9fKuhEqFYWDdM0oNqekd0zuAJLEgRFw9xatTZcYqxUeIa1rznKKBbMwOf3xPqM
	UJNAp7cg4QDmWRJKjhy3yjvxXq11cTRjfOQgXpKO2S7XUMjNi/jNNOqgzZG0wv5rtChUlrE3DU50G
	bRggP95w62ET/OAJ3IAqsnV9zHdrpgGJQegzqWu4JfVGD5CCr/8UUzwDb532cE3eQoJan3iKzTNHv
	7NpPr43xg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMPxY-002aRX-Un; Wed, 17 Mar 2021 06:47:13 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMPxV-002aR0-Gm
 for linux-nvme@lists.infradead.org; Wed, 17 Mar 2021 06:47:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id CDACA68BEB; Wed, 17 Mar 2021 07:47:06 +0100 (CET)
Date: Wed, 17 Mar 2021 07:47:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH 2/2] nvme: use driver pdu command for passthrough
Message-ID: <20210317064706.GB14498@lst.de>
References: <20210316170632.4161183-1-kbusch@kernel.org>
 <20210316170632.4161183-2-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210316170632.4161183-2-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210317_064709_707451_04C6DC24 
X-CRM114-Status: GOOD (  12.27  )
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

On Tue, Mar 16, 2021 at 10:06:32AM -0700, Keith Busch wrote:
> @@ -724,14 +727,6 @@ static void nvme_assign_write_stream(struct nvme_ctrl *ctrl,
>  		req->q->write_hints[streamid] += blk_rq_bytes(req) >> 9;
>  }
>  
> -static inline void nvme_setup_passthrough(struct request *req,
> -		struct nvme_command *cmd)
> -{
> -	memcpy(cmd, nvme_req(req)->cmd, sizeof(*cmd));
> -	/* passthru commands should let the driver set the SGL flags */
> -	cmd->common.flags &= ~NVME_CMD_SGL_ALL;
> -}

I think we need to keep the sanitization of common.flags here.

The rest looks good.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
