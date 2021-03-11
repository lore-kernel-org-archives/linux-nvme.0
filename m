Return-Path: <SRS0=tknV=IJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E776C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 10:55:55 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 835E764EFD
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 10:55:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 835E764EFD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FS2juT455uKF8eDaNqRUYF7yUi9Ww//RLjkHluz0YJE=; b=dtVTxjvgayssNHnXx8cwEMIwM
	UVJzxs/ghghla6YKKxPqyqLnbv8R2LySBnQkjFOdGYGNLVPHMJEnqMgbB/vFEpgiJME3FEaszO8x6
	aRQnfJCPnP8wHWuWVsU/hLpjkqvq19MtsBkkdixogCWGJbk5eSdT3BieN9XzaOnrUXn9uG1Ztluo3
	7opO5gln5lLDZpnSN+hCQpZ1MmpO8GepBEuoz2Umna6ymlbzANt6Xv3SsMagdBtsNUwdWbMkzdBH9
	BgGaRUYy1tulP7pMsYDc914DfrtmGOy25gZrwDx7pDntQslS8866ULKSLA6TVsTMLRabgXnTLr3AQ
	QMpi0Dytg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKIyh-008tJo-TX; Thu, 11 Mar 2021 10:55:39 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKIyb-008tJ3-Tx
 for linux-nvme@lists.infradead.org; Thu, 11 Mar 2021 10:55:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5CF0A68B05; Thu, 11 Mar 2021 11:55:32 +0100 (CET)
Date: Thu, 11 Mar 2021 11:55:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] nvme: sanitize KATO setting
Message-ID: <20210311105532.GA16515@lst.de>
References: <20210311103727.47381-1-hare@suse.de>
 <20210311103727.47381-2-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210311103727.47381-2-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210311_105534_092091_F4B857BA 
X-CRM114-Status: GOOD (  13.23  )
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

> +/*
> + * Recommended frequency for KATO commands
> + *
> + * NVMe 1.4 section 7.12.1 states:
> + * The host should send Keep Alive commands at half of the
> + * Keep Alive Timeout accounting for transport roundtrip times [..].
> + */
> +#define NVME_KATO_DELAY(k)	(((k) > 1)?(k) >> 1:(k))

This should have been an inline if added at all, and use proper
formatting, as well as avoiding the shift obsfucation.

I think the best is to just move this into the only caller, where
we also know that ctrl->kato can't be 0 due to the check in
nvme_start_keep_alive:

/*
 * Recommended frequency for KATO commands per  NVMe 1.4 section 7.12.1:
 *
 *     The host should send Keep Alive commands at half of the
 *     Keep Alive Timeout accounting for transport roundtrip times [..].
*/
static inline void nvme_queue_keep_alive_work(struct nvme_ctrl *ctrl)
{
	queue_delayed_work(nvme_wq, &ctrl->ka_work, ctrl->kato * HZ / 2);
}

Also please keep this helper inside of core.c.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
