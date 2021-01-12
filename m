Return-Path: <SRS0=XnCc=GP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B211C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 21:48:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2A4623122
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 21:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2A4623122
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1PbJN1Y7uADOBYwhJRmOZQmCScL9qYviYcjLTgAkq8U=; b=NKQt6ZjR7OErWZw7ypZw5tpug
	WVKpfLym9S+jHH9U3ayIp3ExVcdrBGH/U+2IMKxT4IDxWHDPtBE5+VSYAaf1q7QoXZeo/xdhRaL88
	qSfQmoZkijAmET1tjsHWJzyLUSG8pUm2qY56E8hAq+/P3xqeXRBSm92tQd+hSgQoWHAC2iDhZmcSc
	t3GR1Gt32h4GIQTx4IKH8lv/FINy3sYWSb5M2CCvyOdq0BxM/bT0S9c90irs6nvaELlQHI4GlHj3U
	n7u6skCPWz7Wn1tHwaxn/ASEo6REfZZzKhNMsSH9jNF82XQj5Sg5IH9A78XO0YvEq7GmpAJXlzzn3
	96p1qMpPA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzRWQ-000087-Bt; Tue, 12 Jan 2021 21:48:14 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzRWI-0008VJ-9Y
 for linux-nvme@lists.infradead.org; Tue, 12 Jan 2021 21:48:07 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3668123122;
 Tue, 12 Jan 2021 21:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610488084;
 bh=IOnEQAvhvB0+sKQbUygWIhqN3B1btbQHJvS7ghIrqSU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hqVCD6JvzTaZj6PgMFAG7ZoEKGX2gVvPtxq9L34H0vEhnVj7YfKqTwKGlMJtmDb7s
 YiX8TZHymmhg9KhV0NRW/HqBrO52aOSj/+kuSUHEBZ4u6PTkdWjRoP28CIR3Ft6OUL
 CAoGHpubCSmO/vym62kedqLWSiYEo9Z3kGMKs6VXd+ePYaim8JoDviJrND64oymz/r
 BiRoaGPjLAqn+K8hpSPGoDG3+9sGiffRJdcEomppJB0q2nHvHpdbOuKp+dujc3QQjR
 2yOHNEQ/rD2y6N8NgG+NhPp1rb/BiUleYG9jzcR9kYFL42ARGv+tjRB2ySx9ybhohQ
 t1gGTjIimFTbQ==
Date: Tue, 12 Jan 2021 13:48:01 -0800
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [V3 1/4] nvmet: set right status on error in id-ns handler
Message-ID: <20210112214801.GA1505636@dhcp-10-100-145-180.wdc.com>
References: <20210112211410.24742-1-chaitanya.kulkarni@wdc.com>
 <20210112211410.24742-2-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210112211410.24742-2-chaitanya.kulkarni@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210112_164806_463876_781DC8B0 
X-CRM114-Status: UNSURE (   9.98  )
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
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jan 12, 2021 at 01:14:07PM -0800, Chaitanya Kulkarni wrote:
> @@ -541,7 +543,9 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
>  		id->nsattr |= (1 << 0);
>  	nvmet_put_namespace(ns);
>  done:
> -	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
> +	if (nvmet_copy_to_sgl(req, 0, id, sizeof(*id)) && !status)
> +		status = NVME_SC_SGL_INVALID_DATA | NVME_SC_DNR;

If the status is already in error, you don't need to copy out the
blank struct, right? Shouldn't this be like:

	if (!status)
		status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
