Return-Path: <SRS0=U6YU=AK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FC3C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 06:49:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1142323134
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 06:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AhWQHmEo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1142323134
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=AhTdLIW2ldWYwWr2JZwyn9tV0U56eW8uMrFZ3x7e4sI=; b=AhWQHmEoZacn94v+lkHDsIhRB
	4+y98CG0jj1VhxZxiM7tly5bV0p+8YVt4d5xPeWGqfoVOrHlowhXMS1YFCpvEgkrEdEhPMygfHrxQ
	S5hC92RIuJlGF0Fufxp3MpfDELrm2RvLF0rFfWn75KUiXi4e5PyKoYADDBHvKwK7/7UsHTmrG+MWg
	LfEelraQiS55KD0WLl9l29ih6FfU8w4RsaFdFfioMvbbt16ofASSx3P89MPXb4KKe+vY0gQ2hVDFb
	IUrDUxNwz/qyti8R+ml7q9ZKMqspefLfhg2UEUVClL35LedJUoVFDXR0JtdaD3skjGViSFBWUbvgP
	dRr/J603Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jpnbo-00052g-Cy; Mon, 29 Jun 2020 06:49:40 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jpnbm-00052C-7b
 for linux-nvme@lists.infradead.org; Mon, 29 Jun 2020 06:49:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id BFD4468AFE; Mon, 29 Jun 2020 08:49:35 +0200 (CEST)
Date: Mon, 29 Jun 2020 08:49:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH RFC for-5.8-rc] nvme-core: fix deadlock in disconnect
 during scan_work and/or ana_work
Message-ID: <20200629064935.GC30821@lst.de>
References: <20200626174733.116093-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200626174733.116093-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> +	/*
> +	 * Controller deletion started, we may issue I/O, block and prevent
> +	 * the controller deletion process from completing
> +	 */
> +	if (ctrl->state == NVME_CTRL_DELETE_START)
> +		return;
> +
>  	/* No tagset on a live ctrl means IO queues could not created */
>  	if (ctrl->state != NVME_CTRL_LIVE || !ctrl->tagset)

Can we merge the checks into a single one?

> @@ -3913,6 +3932,9 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>  	if (ctrl->state == NVME_CTRL_DEAD)
>  		nvme_kill_queues(ctrl);
>  
> +	/* prevent mpath I/O before removing namespaces */
> +	nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING);

So with the DEAD state above isn't this going to cause problems,
shouldn't this be:

	if (ctrl->state == NVME_CTRL_DEAD)
		nvme_kill_queues(ctrl);
	else
		nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING);

But even with that I'm not sure it does the right thing for the direct
call from the PCIe code.

Also I wonder about the state naming.  Shouldn't NVME_CTRL_DELETE_START
stay as NVME_CTRL_DELETING and the new state could be
NVME_CTRL_NS_REMOVAL? or NVME_CTRL_DELETED?  But with any name we'll
need to document the difference between the two removal states.

> +	/*
> +	 * We don't treat NVME_CTRL_DELETE_START as a disabled path
> +	 * as we I/O should still be able to complete assuming that
> +	 * the controller is connected, otherwize it'll fail
> +	 * immediately and return to the requeue list.
> +	 */

This needs to run through a spell and grammar checker :)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
