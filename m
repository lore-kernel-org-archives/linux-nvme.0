Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4D4C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 22:39:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ED3B206DA
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 22:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="1LKAxph3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="BsuoMBlX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ED3B206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=o3vMvbf0L4R5lf/0CKHFC8zx0FiYLqWyA9h487K1EJw=; b=1LKAxph3uP8Q32A3JMqzUmh6T
	FbyZIMWPUv1fe0zALw4PbFYMHPjA4NO0n9VASevY4tzDb4u3YsDQin6pADg4kAWef4Agp4BDtyOYh
	zBsr95Hcik56iKBD2bp+w2TQfMW38Fy/KQFXfcLI0vFzVtHUJLUsr0z6EwW1falYDmULIEHFOh3z7
	3KS08x1L8d746M/vRDlvA1CFNKAMT0o0ICrYRjm4uof+9Pkw7gyWBdS3cX1kW/2mtWkYSp7JThrRX
	2WLf+XJueqCQKOtN2/AkHhkdZI3JgJ4YcI/65AEi/Fqgmb6DY/tWsjYr2TxppugS6/WjgHHXl2+kT
	go8ln+sGA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5GSQ-0004vA-SW; Mon, 10 Aug 2020 22:39:54 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5GSN-0004um-QC
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 22:39:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Bkx14H9g6ZjU9N/XxWjv7Zey1/xy4rTbjVjrJ5x3U/0=; b=BsuoMBlXXh2qTmILjWcAU/eybJ
 bxHZRgFmtuxrAkssLkgTgIzn0FoyTVdZbNAUc1vD9WShYaMrM9CEf+IU7fUYyZySWCogofVF3RdbC
 vbEzyIQDGjHYs1XHezQWA6VJ9R0ss1iy2qV0apJF36cnj3SBzjNv+AXUnIAjLRsfQeUf5b4PxJmt/
 s66QdRQ7CkouDhGBx3P/h1P6c8rPI6+0w1qdqn/P45Mk3t12b8WucZrTeEeaKSUEGlbROxr/kE4/7
 l2/lzdowpWArZB0kz5k/YZAtvwHeWH4kFEfvoDwNmelgFvCW/Adrzena3/H01JTqcAd+N0IxDShIV
 HBWttglg==;
Received: from [172.16.1.162] by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1k5GSK-000160-LF; Mon, 10 Aug 2020 16:39:49 -0600
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
 <20200810185456.7713-12-chaitanya.kulkarni@wdc.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <9f8b2a69-2ba8-f34b-fe30-ce9e5e83372e@deltatee.com>
Date: Mon, 10 Aug 2020 16:39:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200810185456.7713-12-chaitanya.kulkarni@wdc.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org,
 chaitanya.kulkarni@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 11/14] nvmet: fix nvme module ref count Oops
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_183952_286250_39A0AF46 
X-CRM114-Status: GOOD (  17.07  )
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
Cc: hch@lst.de, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020-08-10 12:54 p.m., Chaitanya Kulkarni wrote:
> In the passthru controller enable path current code doesn't take the
> reference to the passthru ctrl module. Which produces following Oops :-

Please mention the steps required to reproduce the oops.

[snip]

> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 05aa568a60af..ba019c0b514b 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4608,6 +4608,11 @@ struct nvme_ctrl *nvme_ctrl_get_by_path(const char *path)
>  
>  	ctrl = f->private_data;
>  	nvme_get_ctrl(ctrl);
> +	if (!try_module_get(ctrl->ops->module)) {
> +		pr_err("try_module_get failed\n");
> +		nvme_put_ctrl(ctrl);
> +		ctrl = ERR_PTR(-EINVAL);
> +	}
This looks racy. If the module goes away after the nvme_get_ctrl(), then
it will still crash.

But there might be a similar problem here with the core code. If a user
opens a char device, they get a pointer to the ctrl in private_data
without a reference. If the ctrl then goes away and they try to do an
ioctl, it will crash. Similarly, if the underlying driver module goes
away it will probably crash in the same way as this oops.

Looks to me like we need a reference taken to the ctrl and the module in
nvme_dev_open() (which are put in the file release). Then we know the
module can't go away inside nvme_ctrl_get_by_path().

>  out_close:
>  	filp_close(f, NULL);
> diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
> index 32f4951a1df7..5925e93c4682 100644
> --- a/drivers/nvme/target/passthru.c
> +++ b/drivers/nvme/target/passthru.c
> @@ -488,6 +488,7 @@ u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req)
>  
>  static void nvme_pt_put_ctrl(struct nvme_ctrl *ctrl)
>  {
> +	module_put(ctrl->ops->module);
>  	nvme_put_ctrl(ctrl);
>  }

Given that this must be done for every caller of nvme_ctrl_get_by_path()
shouldn't this be in the core code?

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
