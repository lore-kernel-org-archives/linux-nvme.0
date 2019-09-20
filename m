Return-Path: <SRS0=jFtc=XP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE28DC3A5A2
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Sep 2019 18:05:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95F0420B7C
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Sep 2019 18:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ebg1EHRu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95F0420B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=HtCJYZBjYT+2YIxEl93GtjwB8Dt6tpVN2AAYvg769As=; b=ebg1EHRuYVms1pcmAAWNbQbsi
	1L+y53s66FbUJ57azgeYWNLmlmTPjCPEUB7AHiP/Bd0WVlLrM0jvQ4aw5WJkl8UaAkADrgyYvbj/n
	SAjYfKkUj7JDBDIrxq/G1QfvWqx1bzhnL2pHR6BcXFE6V+TUmKWi3zi8Kwr7ANse1Zfeh5Kz46hLA
	Myokp/xRjay/BEyj9Y+mP+OxoiZoJiOkTbnkpL5Tb8l+JvCbVxiV7KiuyhI8WQjxBc7Di7lmKJ0qd
	hW/INCk8ifANIjFeImTV6fKNACoSv8vc5KpeflqbPIlsxm2XPPgFTqtOt3DzKcf/lpCyUOv0g3jVD
	umblHAcig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iBNHd-0002hF-Qe; Fri, 20 Sep 2019 18:05:29 +0000
Received: from mail-wr1-f66.google.com ([209.85.221.66])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iBNHb-0002gs-TB
 for linux-nvme@lists.infradead.org; Fri, 20 Sep 2019 18:05:29 +0000
Received: by mail-wr1-f66.google.com with SMTP id v8so7712603wrt.2
 for <linux-nvme@lists.infradead.org>; Fri, 20 Sep 2019 11:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=grg7EcEzpE0OLBPrvFARClQ6KUZN40qfBjG/YomASuY=;
 b=fCnN1atqxzQQzwf2LPeJQJdjneuzLVZV8nLtGcUCt7EOytUBn8+uoINgkKSQV9O9qr
 IVwO9S71a3ydlnA7AZsxQQJYBqKVW1o2MWdCbZM3yVreqSK7HWd2YFU+64faeY7cIpL8
 7PdCIh+v2QiM/rrij5EqXh81tLunT1VZtvsj5c+r1+4re65wN8EDnpzWoawB13kNbC83
 PsM3AZ48/J2IAXQ2tspYEdYflb48ocEMuLgdj7jyYjCZNw7WmqzKpp5sS1pmYjayPnf6
 P+I1z1IsS/yjY63GntX7bWfUkG0ONc+QsdrIrTDnG/pliKIfX7lYQmf8LBatNl9JcsBn
 HM7A==
X-Gm-Message-State: APjAAAXVLmV5HvOiid7KhkGRf1qTSPRNd40F2lq7DEJ7lmnFFxdOuPT9
 TcNNSL9MdJkCMDclELGMmvI=
X-Google-Smtp-Source: APXvYqwgCT7jKgWK2rb0cxVaTZIbL8PF/XodpCl5wZ30o3I4g4TDqe80s9Jmw0k/0jVjABgHkAG72Q==
X-Received: by 2002:adf:b648:: with SMTP id i8mr478373wre.372.1569002726286;
 Fri, 20 Sep 2019 11:05:26 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id a71sm3514187wma.43.2019.09.20.11.05.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 20 Sep 2019 11:05:25 -0700 (PDT)
Subject: Re: [PATCHv2 5/6] nvme: Prevent resets during paused states
To: kbusch@kernel.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
References: <20190919213431.7864-1-kbusch@kernel.org>
 <20190919213431.7864-6-kbusch@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c31bee2b-5f43-9744-8fbc-971c3504622e@grimberg.me>
Date: Fri, 20 Sep 2019 11:05:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190919213431.7864-6-kbusch@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190920_110527_943691_5B9D11CB 
X-CRM114-Status: GOOD (  16.28  )
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
Cc: Edmund Nadolski <edmund.nadolski@intel.com>,
 James Smart <james.smart@broadcom.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>   drivers/nvme/host/core.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 95b74d020506..33b5729763c2 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3742,15 +3742,14 @@ static void nvme_fw_act_work(struct work_struct *work)
>   		if (time_after(jiffies, fw_act_timeout)) {
>   			dev_warn(ctrl->device,
>   				"Fw activation timeout, reset controller\n");
> -			nvme_reset_ctrl(ctrl);
> -			break;
> +			nvme_reset_continue(ctrl);
> +			return;
>   		}
>   		msleep(100);
>   	}
>   
> -	if (ctrl->state != NVME_CTRL_LIVE)
> +	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE))
>   		return;
> -
>   	nvme_start_queues(ctrl);
>   	/* read FW slot information to clear the AER */
>   	nvme_get_fw_slot_info(ctrl);
> @@ -3768,7 +3767,8 @@ static void nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
>   		nvme_queue_scan(ctrl);
>   		break;
>   	case NVME_AER_NOTICE_FW_ACT_STARTING:
> -		queue_work(nvme_wq, &ctrl->fw_act_work);
> +		if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
> +			queue_work(nvme_wq, &ctrl->fw_act_work);

btw, what happens if someone just initiated a reset here when the event
is handled? just ignore the fw activation?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
