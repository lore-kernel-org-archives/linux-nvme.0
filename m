Return-Path: <SRS0=VrRv=6P=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CE4C47253
	for <linux-nvme@archiver.kernel.org>; Fri,  1 May 2020 15:58:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11AB724953
	for <linux-nvme@archiver.kernel.org>; Fri,  1 May 2020 15:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gnArNWD8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11AB724953
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eHo4h5vBxWnF3L9JzJcCnZB/aS75WI2Q2L6j7No0Ydk=; b=gnArNWD8+XUuZP
	2iibIp6BZUjx2U9NnHfoVjGxNmRcfahJDGp3gSOI6qJNReBHHPUAlhQEfJNqvSl0iyPnPGaCz8ANL
	52Ru26L479RvW4Fet/D2Ed25z2ykym2vm63/S+k5BLmuPxYpUO9VJK6Wm/e4CnFzYIqCU4z3bSfWE
	RQSkgtWbtL+6ARKhnUa66XNPKD8p2Iv5bLH66XZGJuZMudxPgdzFYAQLtQp879bLIceRX/o5ffTE8
	zGxtspMQk6j6+VOjr2R33FbpWwdjjqsTbbtu8QSzpNKFFioXO8etEdxvXn3BAt/YbRzjUHOS9Dtvb
	mabeAuZA1M+TrPhah9qw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jUY3J-0005AJ-4K; Fri, 01 May 2020 15:58:13 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jUY3F-00058r-Fk
 for linux-nvme@lists.infradead.org; Fri, 01 May 2020 15:58:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id B9F9F68BFE; Fri,  1 May 2020 17:58:06 +0200 (CEST)
Date: Fri, 1 May 2020 17:58:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 13/15] nvmet: add metadata/T10-PI support
Message-ID: <20200501155806.GC17680@lst.de>
References: <20200428131135.211521-1-maxg@mellanox.com>
 <20200428131135.211521-14-maxg@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200428131135.211521-14-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200501_085809_686267_14722A02 
X-CRM114-Status: GOOD (  12.32  )
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
Cc: axboe@kernel.dk, jsmart2021@gmail.com, sagi@grimberg.me,
 martin.petersen@oracle.com, shlomin@mellanox.com, israelr@mellanox.com,
 vladimirk@mellanox.com, linux-nvme@lists.infradead.org, idanb@mellanox.com,
 oren@mellanox.com, kbusch@kernel.org, nitzanc@mellanox.com, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> +static ssize_t nvmet_subsys_attr_pi_enable_store(struct config_item *item,
> +						 const char *page, size_t count)
> +{
> +	struct nvmet_subsys *subsys = to_subsys(item);
> +	bool pi_enable;
> +
> +	if (strtobool(page, &pi_enable))
> +		return -EINVAL;
> +
> +	down_write(&nvmet_config_sem);
> +	subsys->pi_support = pi_enable;
> +	up_write(&nvmet_config_sem);

No need to take a lock for setting a single scalar value.

> +	/*
> +	 * If the user requested PI support and the transport isn't pi capable,
> +	 * don't enable the port.
> +	 */
> +	if (port->pi_enable && !ops->metadata_support) {
> +		ret = -EINVAL;

In this case it might be worth to print a messag to help with debugging.

> +	if (ctrl->port->pi_enable)
> +		ctrl->pi_support = ctrl->subsys->pi_support;

I find this a little weird to read due to the mix of styles.  Either:

	if (ctrl->port->pi_enable && ctrl->subsys->pi_support)
		ctrl->pi_support = true;

or

	ctrl->pi_support = ctrl->port->pi_enable && ctrl->subsys->pi_support;

seem ok to be, with a slight preference for the first one.

> +static inline u32 nvmet_rw_md_len(struct nvmet_req *req)

Please spell out metadata instead of md.

> +{
> +	return ((u32)le16_to_cpu(req->cmd->rw.length) + 1) *
> +			req->ns->metadata_size;
> +}

Also this could probably use another IS_ENABLED to optimize out
the code if CONFIG_BLK_DEV_INTEGRITY is not enabled.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
