Return-Path: <SRS0=8PNV=AM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36D4C433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 00:18:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 827992074D
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 00:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VUmD7XXP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 827992074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MyWmKT/I2jM0+sdm60DgcOP1o2hytk+PWxuYnE1a/HI=; b=VUmD7XXP3OvgqKnuV7iOY3jy7
	Rk3PWEgMEeKW0MHeT4lQWp+I3wW8txwEAhPfTbsOy8U8ORfMUMqbF6MngBIvXDXI6SHNAtk0aqVhD
	OWXM+2gym7Vq9hoH6KCRliNO3Z9ImfQRbJFqUAfs8kn0SjpeTkPBnZN1y8kJQi5ur/VNi6yZrKwUj
	Hbb5rkPvrL+2Jlk3kgL25dOCF3XJvIhgJQh8VDAb9+mrJu7wLdUBBG86Dj/TNX9Bwn25jhH032+Yh
	y+Jb67b5Keg9oK+5agltkwABfE1XLJWjSKvzsL78d7nWzZp4XVLVEPznjixA1Ecl/DK5m3SsluvFi
	8E8a3LUIA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqQSG-00061f-71; Wed, 01 Jul 2020 00:18:24 +0000
Received: from mail-pl1-f193.google.com ([209.85.214.193])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqQSD-00061C-BL
 for linux-nvme@lists.infradead.org; Wed, 01 Jul 2020 00:18:22 +0000
Received: by mail-pl1-f193.google.com with SMTP id u9so5558397pls.13
 for <linux-nvme@lists.infradead.org>; Tue, 30 Jun 2020 17:18:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jLtMs9xMVt/IptEBWiY6idPLXM12cKSs02HLveTOFqI=;
 b=cyb3wlMcZkjt1JbYLGKDqa4Em+u2w3WioPGSi7G57mSiaJg2W5ER93R5/8McimZx9V
 sqAgsxGSjdd49leNekWUK4rsxutlwrbb8ZhKuTqWqZSSsFFdkKQl6hLcE2oW+azWOeIQ
 jjUhaDVAawC5EnxnoJ7poPa1oeB7XPmzj4B6UCL9CkKhAfNhrYrdP42Dh97U2BJJA8Nl
 Vltdnj8Okel6LmgepDd6ybe7t+GhYtbyMUGHyrgCK/nmxoltnlbSV3oIi+L3/HgeRLCM
 gIy/P6pPOZ7PWdCwpd7X7MuX+joP87VZgwNg/FtbGoithFyUqKGYSzD8J0zW2xCFu9Hl
 2wsA==
X-Gm-Message-State: AOAM532g/BRqYvj+JFRggRQ3WGr8uQ3tLlqp6quA/1rRY9IZLOQU8+41
 aRL+TaBraqwYV6Qoqi0xZJkaW9az
X-Google-Smtp-Source: ABdhPJxFuGXM56tEcj0401Qvz7eJpVUsQMqUX/TWHZ7JxvRMeXG8kRwGCO0hG5ftsHOU4yqMLCPuRg==
X-Received: by 2002:a17:90a:930a:: with SMTP id
 p10mr23366088pjo.203.1593562697953; 
 Tue, 30 Jun 2020 17:18:17 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:8cfd:8b2d:99be:d61d?
 ([2601:647:4802:9070:8cfd:8b2d:99be:d61d])
 by smtp.gmail.com with ESMTPSA id 21sm3741924pgy.20.2020.06.30.17.18.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2020 17:18:17 -0700 (PDT)
Subject: Re: [PATCH v5] nvme-fabrics: reject I/O to offline device
To: Victor Gladkov <Victor.Gladkov@kioxia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <cde32cd53001412889cea1e1fe28e7f7@kioxia.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8ddc3564-494a-d32d-cf97-ce7d8174f91c@grimberg.me>
Date: Tue, 30 Jun 2020 17:18:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <cde32cd53001412889cea1e1fe28e7f7@kioxia.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200630_201821_421830_39F00A95 
X-CRM114-Status: GOOD (  13.75  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> @@ -612,6 +613,8 @@ bool __nvmf_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
>   	{ NVMF_OPT_NR_WRITE_QUEUES,	"nr_write_queues=%d"	},
>   	{ NVMF_OPT_NR_POLL_QUEUES,	"nr_poll_queues=%d"	},
>   	{ NVMF_OPT_TOS,			"tos=%d"		},
> +	{ NVMF_OPT_FAIL_FAST_TMO,	"fast_io_fail_tmo=%d"	},
> +	{ NVMF_OPT_FAIL_FAST_TMO,	"fast_io_fail_tmo=%s"	},
>   	{ NVMF_OPT_ERR,			NULL			}
>   };
> 
> @@ -631,6 +634,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   	opts->reconnect_delay = NVMF_DEF_RECONNECT_DELAY;
>   	opts->kato = NVME_DEFAULT_KATO;
>   	opts->duplicate_connect = false;
> +	opts->fast_io_fail_tmo = NVMF_DEF_FAIL_FAST_TMO;
>   	opts->hdr_digest = false;
>   	opts->data_digest = false;
>   	opts->tos = -1; /* < 0 == use transport default */
> @@ -751,6 +755,28 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   				pr_warn("ctrl_loss_tmo < 0 will reconnect forever\n");
>   			ctrl_loss_tmo = token;
>   			break;
> +		case NVMF_OPT_FAIL_FAST_TMO:
> +			if (match_int(args, &token)) {
> +				p = match_strdup(args);
> +				if (!p) {
> +					ret = -EINVAL;
> +					goto out;
> +				}
> +
> +				token = strcasecmp(p, "off") ? 0 : -1;
> +				kfree(p);
> +
> +				if (!token) {
> +					ret = -EINVAL;
> +					goto out;
> +				}

Rethinking about this when reading the code, let's drop the "off" string
option, nvme-cli is probably the better place for free text processing...

I think that overall this looks reasonable. But I'd like to hear others
on this. Keith, Christoph, Chaitanya, James, Hannes, please review
this approach.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
