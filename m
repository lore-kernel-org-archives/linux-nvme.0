Return-Path: <SRS0=9ikG=CL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43482C43461
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2020 16:49:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12557207EA
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2020 16:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZSxS+yue";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJ8C6LlS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12557207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kiMsfC9YoK99coL+nayfWJe4LXMBgaBiw7ZqaJGBlHk=; b=ZSxS+yuejHfr5rmHtqNagEcSG
	QKybBSreFoJYt4gRszjud04DfuC5ts3xysSkXzkTXA6qRyg45VdU9fFbvCer/1cgPWwuGc3jfjgFF
	VitldJOqAAemqTOcdAzYQHMHmLdxk0OBIaJ7fZyEGlN8a6DW6A3dQ7Oj+Al3Uz0TKhYeCf9Hp1RXX
	pPTmNtPOKnKwh5j+lgaJrcNkC+nUS8Yt1MlSVOKR02qe2LAM1C1gNGu+JgQlkfcJPrxB80LVVdYU+
	IGez1qs3NbCsFB7/gLS5AohETCmLclwkXKm8Dc8Q14qDtYkLZYOd9R/b9RYVZ1QqFbEVjbMHVMLFB
	+/vmqlUHQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDVwU-0000kf-Tl; Wed, 02 Sep 2020 16:49:02 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDVwS-0000jN-Iu
 for linux-nvme@lists.infradead.org; Wed, 02 Sep 2020 16:49:01 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [129.253.182.57])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BAF9120767;
 Wed,  2 Sep 2020 16:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599065339;
 bh=J7Kv0j/pMMOnG00CTXhchag5FXeP1nN0FZO4KjsJM+c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kJ8C6LlS+gRMpoD0PwdmuYYW8fd6tEL7x+m5TzUWLV678oIei96PjxPi6+BVsY1yh
 Xuq/1KH02XnVlWjo84g0TuKG9VX1FvdYa1UW3TjrJXRPQG9DNCl5qes/PPquPysrVg
 wU/g2Y17jMIH/cOmnzMl59uBjRvpbfxN1QW1OLes=
Date: Thu, 3 Sep 2020 01:48:52 +0900
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH 1/2] nvme-core: use I/O timeout for I/O requests
Message-ID: <20200902164852.GB22699@redsun51.ssa.fujisawa.hgst.com>
References: <20200902021308.49606-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200902021308.49606-1-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200902_124900_694380_23EEC9AE 
X-CRM114-Status: GOOD (  12.72  )
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
Cc: keith.busch@intel.com, hch@lst.de, linux-nvme@lists.infradead.org,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 01, 2020 at 07:13:07PM -0700, Chaitanya Kulkarni wrote:
> @@ -885,7 +885,9 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
>  	if (IS_ERR(req))
>  		return PTR_ERR(req);
>  
> -	req->timeout = timeout ? timeout : ADMIN_TIMEOUT;
> +	req->timeout = timeout;
> +	if (!req->timeout)
> +		req->timeout = qid > 0 ? NVME_IO_TIMEOUT : ADMIN_TIMEOUT;

The 'qid' value doesn't quite mean what you want it to here. In this
function, qid is usually set to -1, NVME_QID_ANY, for all requests.

At least for now, the admin request_queue's q->queuedata is NULL, and IO
request_queue queuedata are not. I think that's the only indication you
have in this context for whether the command is IO vs Admin.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
