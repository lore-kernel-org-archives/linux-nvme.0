Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B4E7C2BA18
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Jun 2024 16:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rXm22aa4uNfLbj5oHoqEtahnhATqX9TBEK1apmGNxQQ=; b=gH3v0zDmyyCnQiCS6kvXz2H5f6
	Y+D2FPFihfzaowbEISoCk9/fVDWh7T0LbjuJLll/AuoNFeNCltmBHJ4IRIktTYokHcYcPtxRrawv5
	rz/+JUs/Ma5Oj6dOLaCyzjWqojkkS2PDm7LYjNUGIH3eVVU+YKOVNby+GsfIfsGZNmdnXI7PTDlJJ
	qRwM2Gb9jHZve6JQGEvSbBMz80Fkwshgt0A4veo/Yqtw0zLWIhiYPCXFWHag4LbzmAyXQR3kXTWrj
	U7oDL5waB+DAm9wJOr9UHjCzi8kz9ZhuAB6VQafZgGZhIxVGBQ+jtCt8siw//WR4UTQxoADWkpR4e
	lzZ4IEgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJbNp-0000000Fl2h-3k7A;
	Tue, 18 Jun 2024 16:08:33 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJbNm-0000000Fl0S-01Wf
	for linux-nvme@lists.infradead.org;
	Tue, 18 Jun 2024 16:08:32 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4W3WrX6QzlzlgMVS;
	Tue, 18 Jun 2024 16:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1718726904; x=1721318905; bh=rXm22aa4uNfLbj5oHoqEtahn
	hATqX9TBEK1apmGNxQQ=; b=NhmEOlrQaPts2vm1dA+hSzHL6zOzrF14r201rIfL
	WlXlzeNTFzxO3m0fXXUsdX+kySWS3S76lquG6v2/lZ2rqKpCvzfh23IK2ejHj/Bx
	AkERAjTTcjyMZlWXvgKUNjr9Xa8msRXHpaTH7DGbD3wkOehhCfqWeBQFQEXdYQXv
	fCLVFxHncNpYCDHkZLpzl2sioB8YsLHXX96YZdw8ppkslr0B57KG+CritpB9jvAE
	lffmqU3Zq2G8qyeqkNu9+cgOufkFM3jEhJDtUtSnruw6t6uYvPF95IQj6Qirx/b1
	Lm/hahq2/c0bSjSEcyyqiJwn51fOBXJMjNEFDLG8dFtauw==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id a2Ikwti1Rv3a; Tue, 18 Jun 2024 16:08:24 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4W3WrP3F8YzlgMVR;
	Tue, 18 Jun 2024 16:08:21 +0000 (UTC)
Message-ID: <8d8ada7d-81c1-4706-9263-7854a7847a85@acm.org>
Date: Tue, 18 Jun 2024 09:08:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] RDMA/srpt: remove the handling of last WQE reached
 event
To: Max Gurtovoy <mgurtovoy@nvidia.com>, leonro@nvidia.com, jgg@nvidia.com,
 linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
 chuck.lever@oracle.com
Cc: oren@nvidia.com, israelr@nvidia.com, maorg@nvidia.com,
 yishaih@nvidia.com, hch@lst.de, shiraz.saleem@intel.com, edumazet@google.com
References: <20240618001034.22681-1-mgurtovoy@nvidia.com>
 <20240618001034.22681-4-mgurtovoy@nvidia.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240618001034.22681-4-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240618_090830_136757_6E07F789 
X-CRM114-Status: GOOD (  12.00  )
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

On 6/17/24 5:10 PM, Max Gurtovoy wrote:
> This event is handled by the RDMA core layer.
> 
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>   drivers/infiniband/ulp/srpt/ib_srpt.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
> index 9632afbd727b..8503f56b5202 100644
> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> @@ -231,11 +231,6 @@ static void srpt_qp_event(struct ib_event *event, void *ptr)
>   		else
>   			ib_cm_notify(ch->ib_cm.cm_id, event->event);
>   		break;
> -	case IB_EVENT_QP_LAST_WQE_REACHED:
> -		pr_debug("%s-%d, state %s: received Last WQE event.\n",
> -			 ch->sess_name, ch->qp->qp_num,
> -			 get_ch_state_name(ch->state));
> -		break;
>   	default:
>   		pr_err("received unrecognized IB QP event %d\n", event->event);
>   		break;

Acked-by: Bart Van Assche <bvanassche@acm.org>

