Return-Path: <SRS0=1ZDZ=LV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2BAC48BC2
	for <linux-nvme@archiver.kernel.org>; Sun, 27 Jun 2021 14:05:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 550B661C18
	for <linux-nvme@archiver.kernel.org>; Sun, 27 Jun 2021 14:05:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 550B661C18
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WIxndXhGFUYRmykYcYZVHcntaa5VbRVdTRP3I0mStxI=; b=sWWEPdjjWGKyJ8HfYAhBmOH7QO
	I4Zkcy+i89wRvMOXyfcQpFm0OaJAQfY3ToyA+vksBOANCc4I1NM+2ED/7tQIYS9DZmMEZRc+YM5Hm
	TJT7JcmhMzok1HtElPYvIJMT3906mP/KjigMfIpsKflAfPoCtYhuUInpVatUoRLWVEb4xybkGwDYS
	/WUROInP6NRrHCIfWOwP8Wf2NypehTtGkRkCTZwD35JyPIN+vFDQiY7hfA6pPDcAG8XmefNrC19f4
	GKpHVwcDSbMfQCQLohb5Sln55oQmkTbA+6dM3uoAaCmC6U6WGpoeLb/3QNFhKlsXpJWnJxdvDXxqB
	LZJjpjPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lxVP8-005eVD-HN; Sun, 27 Jun 2021 14:04:58 +0000
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lxVP6-005eUs-Ba
 for linux-nvme@lists.infradead.org; Sun, 27 Jun 2021 14:04:57 +0000
Received: by mail-pf1-x435.google.com with SMTP id s14so10520295pfg.0
 for <linux-nvme@lists.infradead.org>; Sun, 27 Jun 2021 07:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7IC+DTzBx0Yh5RP/xh0gD6mgUcbBwa/Ap670J7IrdFk=;
 b=C1LC1+yt5BmDvVjWbUSEFUONlSQsg/cmELJVooFUXgSZNcw+r1sblrcwedoxVUVqzP
 E+QB08JPXFLFWgn33wVq8DnFj5UvAtVo7hTsw0XjeWIRfdRbW+r98MRTzfskEirTD+EN
 JaBLJDsBIeHijO0chNfokM/FG880TifMBab+lyPsqaBDplV5oDPZbovQhu8p8u0RGpoi
 FS8/cc7XE07Gnu+QF8fdjDmCtFGI9oAqH4mI1A7guViLWSw0xyFeJ/qQ9swDw2Dut1gB
 57Uu0SyFU4UiScXZk871WlTiPUM63zgVuj5YNg9NgQdpVSzz+l/RIggMwqVIiamo4oTn
 i26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7IC+DTzBx0Yh5RP/xh0gD6mgUcbBwa/Ap670J7IrdFk=;
 b=fyrlKIqLaGKu/i+q3L70gvWGEyBzrB++PcDZQSZn743VcL8GZ0HYnBrtIiNNPX6RC8
 +J0dHSjqvylpbsaCnNYfkveYmNWm46mJAafBmdZwOEVgSfI6zykBtPvIXC8uPYVGS3yR
 ubMd8BifEIQnD0tkrZiDsybNY4TQ9+roFS+ct0vc+CK9QvILXr8n53ule1evbl9UcpFS
 q/fI7uJsxtNT5E09oarcrTfAlN01uQw0wOpTeI1KgCyPhLOSICnA0fEIK9kIF17jQyzx
 A41ia2nVFn0Kdf2DmRJ6zql7O6cCq22OfU3dJVypUxvmC09DbsWbqVqjWxAOyVR/0nme
 OInA==
X-Gm-Message-State: AOAM532/LcjeLO+2WU/FZSSqYeizfygaq2SFOpY9tksRsoGNo4KeauCj
 pmO6TO01AbbN9GoiwKER3mw=
X-Google-Smtp-Source: ABdhPJxTiOswHpwnAg5OcepBNu6oBL+sjCDLZSiGCQk4K/HXf6HmwBLFbpP2kQEPUI07EWDHFby8zQ==
X-Received: by 2002:aa7:86cd:0:b029:30c:2b9b:2a77 with SMTP id
 h13-20020aa786cd0000b029030c2b9b2a77mr1420927pfo.47.1624802694527; 
 Sun, 27 Jun 2021 07:04:54 -0700 (PDT)
Received: from [192.168.1.30] (ip174-67-196-173.oc.oc.cox.net.
 [174.67.196.173])
 by smtp.gmail.com with ESMTPSA id j13sm11252849pfh.145.2021.06.27.07.04.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Jun 2021 07:04:54 -0700 (PDT)
Subject: Re: [PATCH 2/2] nvme-fc: Wait with a timeout for queue to freeze
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Ming Lei <ming.lei@redhat.com>, Sagi Grimberg <sagi@grimberg.me>
References: <20210625101649.49296-1-dwagner@suse.de>
 <20210625101649.49296-3-dwagner@suse.de>
From: James Smart <jsmart2021@gmail.com>
Message-ID: <9362fb6c-8a98-3189-453a-69d4c0b622e3@gmail.com>
Date: Sun, 27 Jun 2021 07:04:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210625101649.49296-3-dwagner@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210627_070456_453589_C22F3957 
X-CRM114-Status: GOOD (  20.86  )
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
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 6/25/2021 3:16 AM, Daniel Wagner wrote:
> Do not wait indifinitly for all queues to freeze. Instead use a
> timeout and abort the operation if we get stuck.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/host/fc.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index a9645cd89eca..d8db85aa5417 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2955,7 +2955,14 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
>   		dev_info(ctrl->ctrl.device,
>   			"reconnect: revising io queue count from %d to %d\n",
>   			prior_ioq_cnt, nr_io_queues);
> -		nvme_wait_freeze(&ctrl->ctrl);
> +		if (!nvme_wait_freeze_timeout(&ctrl->ctrl, NVME_IO_TIMEOUT)) {
> +			/*
> +			 * If we timed out waiting for freeze we are likely to
> +			 * be stuck.  Fail the controller initialization just
> +			 * to be safe.
> +			 */
> +			return -ENODEV;
> +		}
>   		blk_mq_update_nr_hw_queues(&ctrl->tag_set, nr_io_queues);
>   		nvme_unfreeze(&ctrl->ctrl);
>   	}
> 

Looks fine. This is one of those that changed in the other transports 
but fc wasn't part of the patch set.

Reviewed-by: James Smart <jsmart2021@gmail.com>

-- james


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
