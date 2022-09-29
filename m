Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3408C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Sep 2022 18:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B27xDRFLYn8dmcI7ZG2AD+gsAXOG5ADCrJjraPayd4c=; b=F4Xl/alhyEWKA/5tmlBinSdMvm
	T70xKXdt+L+2JZMFbHOtDKJ6J+dx6hVn6FsRJJaYmqEFjIv8JywIIwucV4vDn52dQMICvnU5b46B1
	xnJ8UWicYTZm3gf94ziC6h2Tt6VVs5vGJYI12mKQzA2IJI4Ev5OWDPmVCHF16rADyWOT3dFBWeZJZ
	8/YgRZ8oHjoQ9s7+bXH1/ZkIS199Rq0nWwz1Ip+RBnAmhbauJqXMkhKgYuz2OSmHM+x2FpR2UDj9y
	266S7+gbWf7yJzkjO97KYl77EnW0LEDDSrDpptmqhlOoY3xzHNReWw2OGeLav87trodxA7gp2F5vh
	HxKTj0Qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odyi5-0054ZB-Mo; Thu, 29 Sep 2022 18:56:37 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odyi3-0054Xi-0a
	for linux-nvme@lists.infradead.org; Thu, 29 Sep 2022 18:56:36 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 2953162138;
	Thu, 29 Sep 2022 18:56:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 004D0C433C1;
	Thu, 29 Sep 2022 18:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1664477793;
	bh=hOQQv7VOlaYsgaMDOtt7wdfKpZzYcGIEQozcBJ0GMaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eKbFpwJD9tSzzsgei5Bjpb/Homwc/r5q/GzBoIw095obUSWPhjWfnTgvGLsIQv39r
	 OcRWeRkeycoqhccbyYnEcmAFB3UO0B1TozICX9jwxy50NJBTQnwLBp/3Il02YPRZHE
	 641TYmdoLfn5XL/Rz8W+LprXDtFbir6yzdKY+a+JVivtPyTz4IRVSoQExXTtatVTVn
	 T+oeZC4K8Dtp/rER6jBqBjrWx+6Q/TMHKa+sry9/0PNJC9XmUr/8iqoQYE1epiD7Y1
	 isHtwJ5SxmPPNsQEMNczahXtXQkvZKpswb/prWx4sSD6IC5fTPITjUj18eOdH02HmG
	 UCGF3MZbKQaFw==
Date: Thu, 29 Sep 2022 12:56:30 -0600
From: Keith Busch <kbusch@kernel.org>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
	oren@nvidia.com, chaitanyak@nvidia.com, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/1] nvme: use macro definitions for setting reservation
 values
Message-ID: <YzXqXhQaV82ZWyEb@kbusch-mbp.dhcp.thefacebook.com>
References: <20220929115919.9906-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929115919.9906-1-mgurtovoy@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220929_115635_106735_F6FE12D4 
X-CRM114-Status: GOOD (  10.79  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Sep 29, 2022 at 02:59:19PM +0300, Max Gurtovoy wrote:
> +/*
> + * Reservation Type Encoding
> + */
> +enum {
> +	NVME_PR_WRITE_EXCLUSIVE = 1, /* Write Exclusive Reservation */
> +	NVME_PR_EXCLUSIVE_ACCESS = 2, /* Exclusive Access Reservation */
> +	NVME_PR_WRITE_EXCLUSIVE_REG_ONLY = 3, /* Write Exclusive - Registrants Only Reservation */
> +	NVME_PR_EXCLUSIVE_ACCESS_REG_ONLY = 4, /* Exclusive Access - Registrants Only Reservation */
> +	NVME_PR_WRITE_EXCLUSIVE_ALL_REGS = 5, /* Write Exclusive - All Registrants Reservation */
> +	NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS = 6, /* Exclusive Access - All Registrants Reservation */
> +};

The comments are unnecessary, and this would be more readable if the values
were tab aligned like 'enum pr_type'.

Otherwise looks good.

