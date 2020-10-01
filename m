Return-Path: <SRS0=dhBa=DI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336CCC4727E
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Oct 2020 18:06:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BEBC20848
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Oct 2020 18:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rsakGjJc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LwI79KyM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BEBC20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ax6kNcP9w8EkoFdZGofFEw+gmTtc0Th0sYVNZHr6pdY=; b=rsakGjJcW+LD2rMLpwUVaFI31
	HGxRGQ0l9RAtNPhGSKy9LjYM3ttR1MyjyRswoSBZeWvMjWsuD4l9rXAZ+z3OHdqtwMZK04AMh5qm/
	DeJQlazi1X5OJIIs2lbV2tCrnbZXRarfuJ3KiGLM1De+uXq8zW9cWmGyxdIcjdQS+K4+7AF7jb5Yv
	CurMHc/FFgXxwy7utghc1a/0et/wbIIjJaSVn4Pe80B3XESPP9njACirsGyXvCqUfGbIxFbPN2jzp
	4d5JKQ0YDO/1zEDL4su765za0+IVyzjSWacOJfOc6rPlVhEDgHPJa55B5gWsKNK3RzOfGlBHNVCt9
	yVDkh9D/A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kO2y0-0001nC-GZ; Thu, 01 Oct 2020 18:06:08 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kO2xx-0001mc-T7
 for linux-nvme@lists.infradead.org; Thu, 01 Oct 2020 18:06:06 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E81B720848;
 Thu,  1 Oct 2020 18:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601575564;
 bh=fw1wEFH8i15KF02fc92rGeK/pBzt43tbe8TR3wGpDgk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LwI79KyMZy1b9IelPpGlP73ROKL00os2pesHOCmCLKsGG1TpEXBReEOYdiIHWzgRb
 YIypTuhvZ9QR0kQqVylhdn1JOJOyl4RKlehPqYwvaP8jJ0fS3AJdPjKs8NyRvi50/Q
 6zlGASl55RJz5Mmt0Ix5AN9sN/CccJKCCuZ/oF50=
Date: Thu, 1 Oct 2020 11:06:01 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH 2/2] nvme-core: remove extra condition for vwc
Message-ID: <20201001180601.GB564827@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200930232447.20677-1-chaitanya.kulkarni@wdc.com>
 <20200930232447.20677-3-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200930232447.20677-3-chaitanya.kulkarni@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201001_140606_025486_9991C6BE 
X-CRM114-Status: GOOD (  11.98  )
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

On Wed, Sep 30, 2020 at 04:24:47PM -0700, Chaitanya Kulkarni wrote:
> @@ -1970,7 +1970,7 @@ static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
>  static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
>  		struct request_queue *q)
>  {
> -	bool vwc = false;
> +	bool vwc = ctrl->vwc & NVME_CTRL_VWC_PRESENT ? true : false;

No need for a ternary here. It can just be:

	bool vwc = ctrl->vwc & NVME_CTRL_VWC_PRESENT;

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
