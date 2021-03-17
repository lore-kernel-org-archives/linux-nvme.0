Return-Path: <SRS0=uaVC=IP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3948BC41620
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 16:46:15 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8DC364F80
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 16:46:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8DC364F80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=oPtFANTVU9HzkA4qF/7jgYwVeCCnbgKRV2GCyBYmiXg=; b=n1ACPDxX0iYHesyD+E+cgI3At
	XrJ2ypjsZmBRGPLz3dOcPCmd6x0PQzRuI+5qClNxnrCE7pBXIbik3ZsmxdldTJn5FOZDcS/lBPJBx
	aE7uKU9lcWnCyI3+C32cbC/JyXTAQmdqticF/znquHZycoSRp+Hs0zgmUdYSFy53ONYNmUzwk/PP+
	pvy6eYk/9+H4OJIQ9c7qjHKpTllhgDi5sS4iXNu5Ct7VqWuUGQATi3jg6mkXxAXBkXkqV+05mmV1f
	EmOTKkpnNKLRBgJ5vtyEyz+Ltd7enyntVaGDiO8cWIQA5FeiAjJWwI4kSaAe20N8ppilOasjpZkQ1
	uu/RGaeyg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMZJ1-003a5b-9f; Wed, 17 Mar 2021 16:45:59 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMZIx-003a5J-OR
 for linux-nvme@lists.infradead.org; Wed, 17 Mar 2021 16:45:57 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 407B764F3E;
 Wed, 17 Mar 2021 16:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615999554;
 bh=OceBWOdyv6zBcY5gO2hevchCnwcOyefFaOPT/whYD8s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PThgmE4AoCFXNi2ZqOPyv0UxPd1tK8LT0AY0VXzQGAyRY3whkfsN1IoH5KqZW18yN
 Ik/OBktasXRCDKAEcMSi+WCP8I4siYcyL8zOhjmqSRcgxRHRYwuMZebCowCbBQEx/x
 ZywohqoruxcIHSdQDg6C44dmRdiEuvhj25STMgIHi0tN8B554UYu7nRLCmdlfpersy
 UUn9cFiu5eHfJvqpoq2ElIIWkSQNzkwk2awe7nozyo+H7vg5KgBMtAbdVg32LFAz2P
 LCvTmDiiS9R2uDFZdp3KZJjgap71p7lHIrKlNKviKmPd6wwK+r1WK4WV69ViKfwsVA
 guyzgcy3DEcwQ==
Date: Wed, 17 Mar 2021 09:45:50 -0700
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, chaitanya.kulkarni@wdc.com,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 anuj20.g@samsung.com, javier.gonz@samsung.com,
 nj.shetty@samsung.com, selvakuma.s1@samsung.com
Subject: Re: [RFC PATCH v3 3/3] nvme: wire up support for async passthrough
Message-ID: <20210317164550.GA4162742@dhcp-10-100-145-180.wdc.com>
References: <20210316140126.24900-1-joshi.k@samsung.com>
 <CGME20210316140240epcas5p3e71bfe2afecd728c5af60056f21cc9b7@epcas5p3.samsung.com>
 <20210316140126.24900-4-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210316140126.24900-4-joshi.k@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210317_164556_036653_C7FEAEFC 
X-CRM114-Status: GOOD (  10.59  )
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

On Tue, Mar 16, 2021 at 07:31:26PM +0530, Kanchan Joshi wrote:
> @@ -1179,6 +1278,20 @@ static int nvme_submit_user_cmd(struct request_queue *q,
>  			req->cmd_flags |= REQ_INTEGRITY;
>  		}
>  	}
> +	if (ioucmd) { /* async handling */
> +		u32 effects;
> +
> +		effects = nvme_command_effects(ns->ctrl, ns, cmd->common.opcode);
> +		/* filter commands with non-zero effects, keep it simple for now*/

You shouldn't need to be concerned with this. You've wired up the ioucmd
only to the NVME_IOCTL_IO_CMD, and nvme_command_effects() can only
return 0 for that.

It would be worth adding support for NVME_IOCTL_IO_CMD64 too, though,
and that doesn't change the effects handling either.

> +		if (effects) {
> +			ret = -EOPNOTSUPP;
> +			goto out_unmap;
> +		}
> +		nvme_setup_uring_cmd_data(req, ioucmd, meta, write);
> +		blk_execute_rq_nowait(ns ? ns->disk : NULL, req, 0,
> +					nvme_end_async_pt);
> +		return 0;
> +	}

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
