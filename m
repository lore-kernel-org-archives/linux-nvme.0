Return-Path: <SRS0=Ni0e=M5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFEDC4320A
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Aug 2021 20:09:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D096561154
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Aug 2021 20:09:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D096561154
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NDl/Qo3XPauvrSge+AQ1Z0XqrJML2OiLlttVQCOVYxA=; b=Bwj5Y8wP3MXeFqBa3TpvNeYJ0c
	T854XVkoHxBuBG4miqDFyWSdAuubnqh2gR5MXK3UqCBiSh7awUN1x3I1q3HnHBYnilKswp3/aK5Ej
	V+ND++hzs/GiZVMUdFKyWRxWpzGnI2akGnxpYrIK8WXcyDmBoj1XFVQ82LgHwUg4BjLrFfe8bCCYr
	1ZEdrPxVU8CxBXJjEpw9+LXDXywaPNNlrFMjpVND56LZH+j5nr99H3Bqdw+tcfozrerJAS1+rIwzW
	Gs/nYmvBBEsrzuQqFeoKO+IWE/A0zRV3mZHLr9F2Eh779vkZeUkOlSe7QIzTsoByeX7sdfon9/Umj
	AGo0AbdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mC699-00DRr3-9u; Fri, 06 Aug 2021 20:08:47 +0000
Received: from mail-pj1-f41.google.com ([209.85.216.41])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mC67W-00DRN1-Pl
 for linux-nvme@lists.infradead.org; Fri, 06 Aug 2021 20:07:08 +0000
Received: by mail-pj1-f41.google.com with SMTP id
 m10-20020a17090a34cab0290176b52c60ddso19524617pjf.4
 for <linux-nvme@lists.infradead.org>; Fri, 06 Aug 2021 13:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6AJy43CLMalIoLg/WtPA6ZpLHKZX2UeVbc74Z/QQaV8=;
 b=Mz3GqgsooNSgP2oSJ4dbb6gcwdS0BkVEnwFPjTb7rXDjWmNbWAFJ0sZg/T4+btHcW7
 TUvBs9ZiZAuXI5XIrzBcDi70laJWhXggp0/n0kgmO4TXDhVmZYZzECxBgD/MvXC1Ehmu
 kaZkHLdNtgvC4N850rfPOltDn1sJaZjz9Tm1Uo1vRQSbvTAMEo+jq7nQnfw0FbHkh+XE
 4Up1Zzycwz/27seo3PyHKVq01gcZ4EpeQjZycj+gtDiIsWk0rMYbjm0trGcowFhaCkke
 bDTHQLbrkAjOkRZuDv4CwGye53xWnjsyNJKKHkm1JGCZYQ+g7n/mObpzhWYdlbbTafe8
 Rv9Q==
X-Gm-Message-State: AOAM532ooOq8Vw73v92b1gK2Dme7QOqiFELD2Xu4KH17EoQ/zwEF5Qj0
 OMmH98zLUUu+JrVfTrn2z1Q=
X-Google-Smtp-Source: ABdhPJy6FibPcKcy2ykUNKYQZjArN+qdr3XielsGJGbrPozfXZ+gLrPTs3h/p2ENK+sbex48diGToA==
X-Received: by 2002:a63:fd51:: with SMTP id m17mr45543pgj.395.1628280425953;
 Fri, 06 Aug 2021 13:07:05 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4a77:cdda:c1bf:a6b7?
 ([2601:647:4802:9070:4a77:cdda:c1bf:a6b7])
 by smtp.gmail.com with ESMTPSA id r7sm13232981pga.44.2021.08.06.13.07.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Aug 2021 13:07:05 -0700 (PDT)
Subject: Re: [PATCH] nvme: update keep alive interval when kato is modified
To: sasaki tatsuya <tatsuya6.sasaki@kioxia.com>,
 kernel test robot <lkp@intel.com>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <b7cde4c23c44485198f12739bb8fbca0@kioxia.com>
 <202108021253.QwqCWvYe-lkp@intel.com>
 <1f5231f5d0d14829ae72aa97e5f2487a@kioxia.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <06929ff1-107f-c00e-7fd9-3c8999e26051@grimberg.me>
Date: Fri, 6 Aug 2021 13:07:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1f5231f5d0d14829ae72aa97e5f2487a@kioxia.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210806_130706_921430_499007B6 
X-CRM114-Status: GOOD (  27.59  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="yes"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 8/2/21 7:12 PM, sasaki tatsuya wrote:
> Currently the connection between host and NVMe-oF target gets
> disconnected by keep-alive timeout when a user connects to a target
> with a relatively large kato value and then sets the smaller kato
> with a set features command (e.g. connects with 60 seconds kato value
> and then sets 10 seconds kato value).
> 
> The cause is that keep alive command interval on the host, which is
> defined as unsigned int kato in nvme_ctrl structure, does not follow
> the kato value changes.
> 
> This patch updates the keep alive interval in the following steps when
> the kato is modified by a set features command: stops the keep alive
> work queue, then sets the kato as new timer value and re-start the queue.
> 
> Signed-off-by: Tatsuya Sasaki <tatsuya6.sasaki@kioxia.com>
> ---
>   drivers/nvme/host/core.c  |  3 ++-
>   drivers/nvme/host/ioctl.c | 17 +++++++++++++++++
>   drivers/nvme/host/nvme.h  |  1 +
>   3 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index dfd9dec0c1f6..89c52da15618 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1255,13 +1255,14 @@ static void nvme_keep_alive_work(struct work_struct *work)
>   	blk_execute_rq_nowait(NULL, rq, 0, nvme_keep_alive_end_io);
>   }
>   
> -static void nvme_start_keep_alive(struct nvme_ctrl *ctrl)
> +void nvme_start_keep_alive(struct nvme_ctrl *ctrl)
>   {
>   	if (unlikely(ctrl->kato == 0))
>   		return;
>   
>   	nvme_queue_keep_alive_work(ctrl);
>   }
> +EXPORT_SYMBOL_GPL(nvme_start_keep_alive);
>   
>   void nvme_stop_keep_alive(struct nvme_ctrl *ctrl)
>   {
> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> index 305ddd415e45..0066728e77b2 100644
> --- a/drivers/nvme/host/ioctl.c
> +++ b/drivers/nvme/host/ioctl.c
> @@ -231,6 +231,23 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>   			return -EFAULT;
>   	}
>   
> +	/*
> +	 * Keep alive commands interval on the host should be updated
> +	 * when KATO is modified by Set Features commands.
> +	 */

This is too specific. I'd move it to nvme_user_cmd_post similar to how
we handle passthru commands (with start/end that does stuff based on the
effects)

> +	if (!status && cmd.opcode == nvme_admin_set_features &&
> +	    (cmd.cdw10 & 0xFF) == NVME_FEAT_KATO) {
> +		/* ms -> s */
> +		unsigned int new_kato = DIV_ROUND_UP(cmd.cdw11, 1000);
> +

The section below needs to move to a core rountine:
nvme_update_keep_alive()

> +		dev_info(ctrl->device,
> +			 "keep alive commands interval on the host is updated from %u milliseconds to %u milliseconds\n",
> +			 ctrl->kato * 1000 / 2, new_kato * 1000 / 2);
> +		nvme_stop_keep_alive(ctrl);
> +		ctrl->kato = new_kato;
> +		nvme_start_keep_alive(ctrl);
> +	}
> +
>   	return status;
>   }
>  

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
