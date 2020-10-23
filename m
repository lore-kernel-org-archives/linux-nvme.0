Return-Path: <SRS0=yBWI=D6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B482C4363A
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2020 18:01:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E54822201
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2020 18:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AO8kXgK1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E54822201
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5wcMJh4XFPN6YWx77rqcpRD23oLr0oFSw8kZ+4QFh8Q=; b=AO8kXgK1fnF8GlZ3g4Zhfb6YL
	KyaSc31YXhPHwQ2aAv4Pxq2tgeih5cmj8baAAldV6gi6nsKTRzLX9Tf7a5gmANDrPEXcI6sgMB82D
	0vI8VFxW8NPkgoN9etPIb8hh3wZf/SVUvQGjTJ8WptCYJvQegkzGf5VV1z+BG30HYFnGRiWPKc8kh
	DDVfAvijCpU1xQsUtTVnYzRmKY/sdGzf5C7Vw/l/nZ3RNaiWEBO4Pb5NL/qoII5Cyw8bG5dq1mhGi
	0AHEphv5/7bo0/b5ynY7sgmzBpkOKGFqWEsPSke+cHPw2iCbGcQonPvQEsLNxRJMPY5/8hA7YpAdp
	/hLpHRhag==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kW1Nu-0005hR-AH; Fri, 23 Oct 2020 18:01:50 +0000
Received: from mail-wm1-f66.google.com ([209.85.128.66])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kW1Ns-0005go-2x
 for linux-nvme@lists.infradead.org; Fri, 23 Oct 2020 18:01:48 +0000
Received: by mail-wm1-f66.google.com with SMTP id k21so1573976wmi.1
 for <linux-nvme@lists.infradead.org>; Fri, 23 Oct 2020 11:01:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FOoNRIlK8tVk9G9mU4rHeaxRE409AWMqWNc43DoFZTI=;
 b=EjXbiB2twH9zfHcYYui+MzMbsj8XatG0cXDV8JWhR0afZvi/P6T+DFgy3pFIrY+Png
 a0R3xGzjA0rIJSkvNiz4XH/0o0KM8Q1OQcjd1/0ks2wPk2GP/cI3uXqfUPMmpPOZh042
 JWltsATnoCh4v8V4QWwd8liQOYwQcsGjw1Y2cOlmxzJMdGKPHXWYoQdHKSciMN2wsYxc
 8cSdwymuZc6+7oTZzdEj5bCJnWXDe220X/tPSUg76S2Xt2bk+Vw7LocNLgXTJdk+c4eL
 vhAEYkgshdGiBKxleidRxlh7d2H0CfGQFos0knCQggTmdxA3kJvEYIKok3dSnvKzwjK7
 +KHg==
X-Gm-Message-State: AOAM531uQTYL/XiwLbzUwKNWdbUyfwsMliRuR6ali63j+SsZ+9vLnY93
 eM8dy5iTmcqc6CENXSLTXn0=
X-Google-Smtp-Source: ABdhPJznH3Ks3tjgn71i4pENBXnNM8JvrRyqwAx0NlW5n8cK5ihA/6xBD2I2jPlbzbwaXvfHerufMA==
X-Received: by 2002:a1c:1b46:: with SMTP id b67mr3681152wmb.82.1603476105288; 
 Fri, 23 Oct 2020 11:01:45 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:f912:ab69:c0c3:c2f7?
 ([2601:647:4802:9070:f912:ab69:c0c3:c2f7])
 by smtp.gmail.com with ESMTPSA id k203sm5045341wmb.37.2020.10.23.11.01.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2020 11:01:44 -0700 (PDT)
Subject: Re: [PATCH v2] nvme-rdma: handle nvme completion data length
To: zhenwei pi <pizhenwei@bytedance.com>, kbusch@kernel.org, hch@lst.de,
 axboe@fb.com
References: <20201023065910.1358586-1-pizhenwei@bytedance.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d23e33e7-d545-2ad0-d163-5182dd5430b1@grimberg.me>
Date: Fri, 23 Oct 2020 11:01:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201023065910.1358586-1-pizhenwei@bytedance.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201023_140148_196360_34FE6DF9 
X-CRM114-Status: GOOD (  15.54  )
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
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 9e378d0a0c01..2ecadd309f4a 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1767,6 +1767,21 @@ static void nvme_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
>   		return;
>   	}
>   
> +	/* received data length checking */
> +	if (unlikely(wc->byte_len < len)) {
> +		/* zero bytes message could be ignored */
> +		if (!wc->byte_len) {
> +			nvme_rdma_post_recv(queue, qe);
> +			return;
> +		}

Nothing in the spec defines zero-length messages, hence we cannot
support something that is not standard. If your array needs this,
please submit a TPAR to the NVMe TWG.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
