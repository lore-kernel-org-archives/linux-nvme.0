Return-Path: <SRS0=7/L5=4P=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C941C3F2C6
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Feb 2020 23:16:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CC7F246A4
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Feb 2020 23:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Kj7bWK5K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CC7F246A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=dZUcB/Cn9F2WIf+AmhxdRbSuoLGA4c7FhIjmklBZA0o=; b=Kj7bWK5KwupeWRWUZDa8fpq1Q
	uecKrvibdwmxmBk47dZ3nzFnBZsCu3l2uwnn0UwR/R9RdrcE39rcRMsd4JL8NDxrmUlnb/wLcVmy9
	Ml67vQ14ef9d1uNyFZa2/Gq52dX2zvavg9YTc+o9Y0w0609gnWrK0G1pSoa5diN0NQm9dcAeFsSsz
	DlsEQhA6mgYDthHh3kNy84X8zTFcbUHHUFyywo0sfSlKdGH+vhu6DT8u1YPMKdcG6DCgWWIgHaTa9
	WLsJd5BWP3cwi2BsBpbILswcIoSJ3Ga+Mze/5o7LfQISfUAYI0XBplXUP7vy/FUmQdGXrwtQzMtWg
	obNbm8TZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j7SOO-0004pa-Ha; Thu, 27 Feb 2020 23:16:32 +0000
Received: from mail-yw1-f67.google.com ([209.85.161.67])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j7SOL-0004p8-Gj
 for linux-nvme@lists.infradead.org; Thu, 27 Feb 2020 23:16:30 +0000
Received: by mail-yw1-f67.google.com with SMTP id l5so1469785ywd.4
 for <linux-nvme@lists.infradead.org>; Thu, 27 Feb 2020 15:16:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=M+md6h9QhtMFlUGRzTmlWfIUW/XaVFDHTsusp/qff44=;
 b=HioCjvlsZGkfJinoXUBg9aut10c2sDfhAnUANo7uydM0cVuWfE2EnK/Yf/cyq+dKel
 GDFihuak0iXWE+KGz3fCe4YsK28Qrjw3qLMq5yya6ChrG/hUm/om5Q7o+rvsk3DEtzI0
 WBYEN6UwbA6ijaLrbLFiSH0lGnWoNvNRdyc5gTzMiSPmgYlROy5VBGP5cegZoNrqBtSW
 8ZHKNZ88wHpaI+StzsOAGEU6XCsrV5UXwbJV7fWPjdgQP5cz9k0XudtxmMvydjLDgBcE
 rZdT8VUG7esozeyFq0Pqfvp/UzvDYVT+PVwZW6k7nPNmlZ4xI7SjzuTwgiq4dsm21UEY
 Au8g==
X-Gm-Message-State: APjAAAUDwwPGTTbv4rSI2jwG4bb2hYzAm9viuZqDPKk3QhvhIgAszRsc
 e2xZ4FNRbJbYHaM0RulWTZNxVveu
X-Google-Smtp-Source: APXvYqzgfrFzdrp3FpRGZ3a2qt0iWvkmSY61Lp6IheF+vWUxRZlHo+cxjgvByo7o0nwisrUPrw+TXg==
X-Received: by 2002:a05:6830:134c:: with SMTP id
 r12mr1052979otq.126.1582845387239; 
 Thu, 27 Feb 2020 15:16:27 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id y13sm2444587otk.40.2020.02.27.15.16.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 Feb 2020 15:16:26 -0800 (PST)
Subject: Re: [PATCH] nvmet: return Invalid Field error on set features cmd fid
 07h
To: amit.engel@dell.com, linux-nvme@lists.infradead.org
References: <20200227141652.80584-1-amit.engel@dell.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <599c5eb6-f7d1-291f-5fbb-9a688da0c1e7@grimberg.me>
Date: Thu, 27 Feb 2020 15:16:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200227141652.80584-1-amit.engel@dell.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200227_151629_557032_C85B6643 
X-CRM114-Status: GOOD (  20.05  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> From: Amit Engel <amit.engel@dell.com>
> 
> If the value specified in NCQR and NSQR fields (0's based) is 65,535
> the controller should return an error of Invalid field in command
> 
> Signed-off-by: Amit Engel <Amit.Engel@dell.com>
> ---
>   drivers/nvme/target/admin-cmd.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index 19f949570625..f76b44768100 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -733,16 +733,25 @@ static void nvmet_execute_set_features(struct nvmet_req *req)
>   {
>   	struct nvmet_subsys *subsys = req->sq->ctrl->subsys;
>   	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
> +	u32 cdw11 = le32_to_cpu(req->cmd->common.cdw11);
>   	u16 status = 0;
>   
>   	if (!nvmet_check_data_len(req, 0))
>   		return;
>   
>   	switch (cdw10 & 0xff) {
> -	case NVME_FEAT_NUM_QUEUES:
> +	case NVME_FEAT_NUM_QUEUES: {
> +		u16 ncqr = (cdw11 >> 16) & 0xffff;
> +		u16 nsqr = cdw11 & 0xffff;
> +
> +		if (ncqr == 0xffff || nsqr == 0xffff) {
> +			status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
> +			break;
> +		}
>   		nvmet_set_result(req,
>   			(subsys->max_qid - 1) | ((subsys->max_qid - 1) << 16));
>   		break;
> +	}

I'd avoid parenthesis in the switch-case statement, just declare them on
top and assign them here.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
