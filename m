Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A43C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 19:09:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D9A864DE2
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 19:09:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D9A864DE2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jr9FkauSb7hADqubIRwZthAe+VcMHNL1Y+YL4wqlvpA=; b=Kvln97Qbotba4PAOgAIeZyJJ3
	thxKaeM4EGwA0fPSrEHI4uyPxsIO/GIIBXTdAS8oB+ZKzt9zJJ7Nb+OR6SlT0UMvF8o3h0DOoQqlx
	qkxctMAR/cThicK2TcCUVbzFz4/8nPJ6F4SywSW1OI/NB6qSNagiD6Bv5Xx9FT6QU9LhfL+6qvaj/
	eFMV7a9+ostpCe3SJml9Rg+ZFwf5/4EOr9yEXwSM40QNvyipRzMcos/k+8G72VNw7IPRc6f9hdxpb
	6vN3R4MZHSAdP/6rH2SZTiN5KhksEs4okGhdIz1r8UNCdorS5Sdk2jsE98DQ2pZn2QPfR38hrlSz1
	KOOac916A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5Z8e-0007G0-Gt; Fri, 29 Jan 2021 19:09:00 +0000
Received: from mail-pl1-f180.google.com ([209.85.214.180])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5Z8c-0007FU-GG
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 19:08:59 +0000
Received: by mail-pl1-f180.google.com with SMTP id d4so5773536plh.5
 for <linux-nvme@lists.infradead.org>; Fri, 29 Jan 2021 11:08:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fwUsAPyhIoSF2avprdQo/UoCbkJPbp+fh51f8uXanRc=;
 b=DgnFDYZCYBXMj53c0jBrOL88cpQmhZGhFHBNLz9+MIra+Z4pr6KNIxzcPfy56J27sg
 TaHWZkJkjMcZ6IwsYGdaTR4giHBmxYnO2Si54Sq9p8BT2fe5yCl+oKzG18jHtarzTTf3
 Jkik2F3vBfscxVlhpDcBdEHTT5BzqW1H4AYMSMEOCMdt4iMvEvWKoi3B7nuEkGZlvISW
 hL8D4KEzvL121CmKYsm4HYBU+tCi/Hg8Z/W95H/F6k29wy6gkOemmi7foqJUud9wnVp1
 Ndn3voRUj/UfhkwNNbRj/XvrVpm1Hc+RsUnyMxeauqCMfnE2yuC9716pYaJk82ujeAt4
 TiQQ==
X-Gm-Message-State: AOAM531Tahb8uxQ73bDqrzPNFXO47lbYyCWwH/8xtXPCG22xbhX9Y8ss
 U7f2cs7Ltvf7iHe8WEVZ7LU=
X-Google-Smtp-Source: ABdhPJxJ4Ej2tRcjELNZUFmBqV1wSV8L2kLMKYstGUX3qXZWIR0PM5T6Dn0ccyEUSRHEEu2z9TBEHA==
X-Received: by 2002:a17:902:c209:b029:de:76f8:395 with SMTP id
 9-20020a170902c209b02900de76f80395mr5640564pll.85.1611947337208; 
 Fri, 29 Jan 2021 11:08:57 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:db7:4f5:6eca:f1ab?
 ([2601:647:4802:9070:db7:4f5:6eca:f1ab])
 by smtp.gmail.com with ESMTPSA id 124sm9532558pfc.196.2021.01.29.11.08.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Jan 2021 11:08:56 -0800 (PST)
Subject: Re: [PATCH 32/35] nvmf-autoconnect: add unit file for
 nvme-monitor.service
To: mwilck@suse.com, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20210126203324.23610-1-mwilck@suse.com>
 <20210126203324.23610-33-mwilck@suse.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0aaeb938-4d72-f138-6e24-0a7f95d05b39@grimberg.me>
Date: Fri, 29 Jan 2021 11:08:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210126203324.23610-33-mwilck@suse.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210129_140858_606053_9BFE1296 
X-CRM114-Status: GOOD (  14.71  )
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
Cc: Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Signed-off-by: Martin Wilck <mwilck@suse.com>
> ---
>   nvmf-autoconnect/systemd/nvme-monitor.service | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
>   create mode 100644 nvmf-autoconnect/systemd/nvme-monitor.service
> 
> diff --git a/nvmf-autoconnect/systemd/nvme-monitor.service b/nvmf-autoconnect/systemd/nvme-monitor.service
> new file mode 100644
> index 0000000..d85b133
> --- /dev/null
> +++ b/nvmf-autoconnect/systemd/nvme-monitor.service
> @@ -0,0 +1,17 @@
> +[Unit]
> +Description=NVMe Event Monitor for Automatical Subsystem Connection
> +Documentation=man:nvme-monitor(1)
> +DefaultDependencies=false
> +Requires=systemd-udevd-kernel.socket
> +RequiresMountsFor=/sys
> +Conflicts=shutdown.target
> +After=systemd-udevd-kernel.socket
> +Before=sysinit.target systemd-udev-trigger.service nvmefc-boot-connections.service
> +
> +[Service]
> +Type=simple
> +ExecStart=/usr/sbin/nvme monitor -A -p

I've seen issues with assuming nvme sits in /usr/sbin/

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
