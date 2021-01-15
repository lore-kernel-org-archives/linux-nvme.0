Return-Path: <SRS0=b72z=GS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B942C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jan 2021 17:04:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE975222B3
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jan 2021 17:04:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE975222B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FyltzDhm0GGHvyl7jszBpSOlUxB6hQ+/++0sFBquehE=; b=tX7rPne5ASb4J2vU78WI9jM8J
	GcjT/9BChk1v1BL0XbN92Eh5aqVY0YzwM7gCA+AvRyJrXvAu+HaS2lxDZI6ZgeCAFl7HSgJfphKNs
	/gqrKEBHi+gr1kEyRWPi30Dh+hkdrsZQG7hwHJYEB/wpqfv2387Vp6yylljlPn/uz+uP1LYbDSASZ
	iXhQgh1hFIsZ3njOJLGDyNG1oldvXBNbk+Zx2E3YL2Jrpjr2sA35RGZtcvgvJqjjqTg2c4+NYpnXI
	XjNstLO3Rry1o+A+17xj+8tNtp5mBflEqu+ZNLYXxgkWFIRjgwKGF8uRNuaD9cpAINV5El8GyoO5T
	e22elpFbQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l0SWP-0007Ux-Gp; Fri, 15 Jan 2021 17:04:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l0SWH-0007T4-1k
 for linux-nvme@lists.infradead.org; Fri, 15 Jan 2021 17:04:18 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5995B2313E;
 Fri, 15 Jan 2021 17:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610730254;
 bh=9R5C4N+YT/ms2VUV3IMMvhIMdnsXT0DQrJYCqnVujXs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GDiYl8W9BikdPaDKLUtDWOozfDrxvZCJgiDcJtVEUcb4FICPVnMiCOtgYB5i7ZLCT
 cYSZN2EO/fWssaG8ziONydWpK4Sb/31ppG7g6b0hgs2839PmGYicHhabMMA7NEyLnr
 7haoANJatZBD7MSIMtDtitjCPXDQQ0d+CK5PO/Ky/9WnHEtihOubRAZsELhcI1Rphc
 F4kJOLiI3NEgwwtiXTg6xdTWFda/eRfG5OoGKeTg8yO0cTJ4CMrPBLA2Fav13GjPSy
 ZmtU46pw9jqll9ACWAIK4/KOoVE12dV10g68OFM3l2Oz1V7oFQzOgFOOeN+YJ7c4SA
 z7SBNJE1He/nA==
Date: Fri, 15 Jan 2021 09:04:12 -0800
From: Keith Busch <kbusch@kernel.org>
To: Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH V3 3/3] nvme: retry commands based on ACRE flag
Message-ID: <20210115170412.GA1515933@dhcp-10-100-145-180.wdc.com>
References: <20210114133110.20779-1-minwoo.im.dev@gmail.com>
 <20210114133110.20779-4-minwoo.im.dev@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210114133110.20779-4-minwoo.im.dev@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210115_120417_185314_E58B8B42 
X-CRM114-Status: GOOD (  12.15  )
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
Cc: Jens Axboe <axboe@fb.com>, Chao Leng <lengchao@huawei.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jan 14, 2021 at 10:31:10PM +0900, Minwoo Im wrote:
> @@ -317,6 +316,13 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
>  			return COMPLETE;
>  	}
>  
> +	if (nvme_req(req)->ctrl->acre &&
> +	    !nvme_is_path_error(nvme_req(req)->status) &&
> +	    !blk_queue_dying(req->q))
> +		return RETRY;

Is there really any reason to tie this to acre?

> +	else if (blk_noretry_request(req))
> +		return COMPLETE;

I am not sure we should ignore the FAILFAST for non-path errors. If we
need retryable admin commands, we should let the driver provide a way
for callers to dispatch requests without that flag.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
