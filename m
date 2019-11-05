Return-Path: <SRS0=AJHE=Y5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F01CC5DF60
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2019 18:03:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17666214B2
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2019 18:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bxlH6m7F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17666214B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AYqhLKDm8ubjyMGbttrkiFyYeQ+QQoguy/eLO8E33J0=; b=bxlH6m7FpRIcuH
	nxxEAOQ+UTioIHpCCooX9IeEYgTA3T3Pe9aR//cMDfg0/x4xP16TCq3B+flYJlHN07jAXMVtIF8wz
	JleFgYVwMZutv77OJxyuWy2YcG7NaFaBs1Vs8BDAEwKebj9zYDcQ9AL9EYSpKCMBoDDQmSxKbLgLd
	eJzDv9Ls9DK57KuXE5lZrfotp7thQq246N6et1sZkkrf9/v6pyPEAgCSlLIvEtTfg11z4jZ5sJNwa
	e0bWt7f9j6e3ZtoJbcS54S1mudGIKSgiZIJqrW3zfjWV+NuTuLtcak7SV44t87PKLWX7usUte9rnM
	lO+cK28DfNznKtlbr6dw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iS3AU-0001Eu-Uy; Tue, 05 Nov 2019 18:03:02 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iS3AP-0001EL-4k
 for linux-nvme@lists.infradead.org; Tue, 05 Nov 2019 18:03:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 88D0D68AFE; Tue,  5 Nov 2019 19:02:54 +0100 (CET)
Date: Tue, 5 Nov 2019 19:02:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 15/15] nvmet-rdma: Add metadata/T10-PI support
Message-ID: <20191105180254.GJ18972@lst.de>
References: <20191105162026.183901-1-maxg@mellanox.com>
 <20191105162026.183901-17-maxg@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191105162026.183901-17-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191105_100259_723324_AD7ECBA3 
X-CRM114-Status: UNSURE (   7.63  )
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
Cc: sagi@grimberg.me, vladimirk@mellanox.com, idanb@mellanox.com,
 israelr@mellanox.com, linux-nvme@lists.infradead.org, shlomin@mellanox.com,
 oren@mellanox.com, kbusch@kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> +static bool nvmet_rdma_pi_enable;
> +module_param_named(pi_enable, nvmet_rdma_pi_enable, bool, 0444);
> +MODULE_PARM_DESC(pi_enable, "Enable metadata (T10-PI) support");

This needs to be a configfs attribute, not a module parameter.

> +	/* Data Out / RDMA WRITE */
> +	r->write_cqe.done = nvmet_rdma_write_data_done;
> +

We should only do that for actual PI enabled controllers.  Also please
use IS_ENABLED or ifdef to only compile this code if we actually support
PI in the kernel build.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
