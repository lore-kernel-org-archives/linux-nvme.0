Return-Path: <SRS0=roYe=ID=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92A4C433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 22:41:01 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A6A3650A8
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 22:41:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A6A3650A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Di1N0dl60hw0Q5ZwElDluwHLqylPHFmp7g60D7vc+rg=; b=LjSx1fNlIigyYIDiN9N14ZVN1
	P1nnKNQKH0emosHhYQgJyJPGwAA5ytGX8n4bJ65JHnkV1gEfWqiHeB4ZPHKBC79PUKqhCVJXqflfO
	JNC4HzghEJhOb28Yx5YEREEq2FePa3+SV0iKfOjQCzXVM14WwHgQcZyyHfAlr+6iwDFJSpmNXFFqn
	setEBhblPjWJNGWQ2N93tsaT+O1hoGjQbQQMZvpq5Yh8DF+eBngEiYpHnulZYsM4vn5PjsXplC5Ub
	rZ2pBQ1kupRJUwNwpDHWxLDEQgGEi0d2Pju1Jxkb4ssJCM3mZTst9Ci6qymKg9+MLZsY8sAkeYenA
	32HX0/Anw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIJ7l-00Gt6E-Cv; Fri, 05 Mar 2021 22:40:45 +0000
Received: from mail-ot1-f42.google.com ([209.85.210.42])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIJ7e-00Gt4J-0Z
 for linux-nvme@lists.infradead.org; Fri, 05 Mar 2021 22:40:43 +0000
Received: by mail-ot1-f42.google.com with SMTP id w3so3348038oti.8
 for <linux-nvme@lists.infradead.org>; Fri, 05 Mar 2021 14:40:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9N5hL0wohWhk6dd1r6uX2KNDCogER8JLOG03sm2t++A=;
 b=LrbxbjZvztSJRyv167Q+pCYb68xv/pWNghK0Rwi7mUKwtdv6NKi+13Z/ygUollfnGw
 c5hSrg48rAbL8Ndqb+dmaggUiDtFRukZVqh7+oSBbJfsaMd3KIv0R7amO7BfdinqpSjE
 /ipH4fhgtGeMs48MZixEvSZbKL33tGkJP3kdanSPR5Je1piQe8kk+4A7jamLIAoV2USU
 0v1erJvUiT8NESGmojJirhtLdUg1jTq3Pe6EEqArT6JdTR+gMZcXaKq7+RNwOSGN9koR
 ko+L++w5tDogL7WDX+inuES6TcU+ZxCJTE4V9loa1EuZDrVhc883kc5KvsrX7E5Mx4vH
 gbeg==
X-Gm-Message-State: AOAM5312rMv/ncTFfib5ZdkJEqbouF6PTFN5DQ3/sgKU7ycpNoyDpffR
 odlMQJH0dwvGepmuxPIemLE=
X-Google-Smtp-Source: ABdhPJxf9VZcTHV9q6bzDnhz9qWQ8v01WpZy1hoEA3BzOiTg9nRA2ZOt2e9qx/Ko4eubmC4jH1v2hA==
X-Received: by 2002:a9d:404b:: with SMTP id o11mr285801oti.342.1614984036828; 
 Fri, 05 Mar 2021 14:40:36 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:e55e:67c6:e7ec:9?
 ([2600:1700:65a0:78e0:e55e:67c6:e7ec:9])
 by smtp.gmail.com with ESMTPSA id w10sm336736oic.45.2021.03.05.14.40.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Mar 2021 14:40:36 -0800 (PST)
Subject: Re: [PATCH V2 3/6] nvmet: remove unnecessary function parameters
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
Cc: hch@lst.de
References: <20210225015642.29288-1-chaitanya.kulkarni@wdc.com>
 <20210225015642.29288-4-chaitanya.kulkarni@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <7cf9d715-37a7-d2df-d10e-de2215767598@grimberg.me>
Date: Fri, 5 Mar 2021 14:40:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210225015642.29288-4-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210305_224041_625348_7C82FA01 
X-CRM114-Status: UNSURE (   9.76  )
X-CRM114-Notice: Please train this message.
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


> The function nvmet_ctrl_find_get() accepts subsysnqn, hostnqn, cntlid,
> nvmet_req, and out pointer to nvmet_ctrl structure. The parameters
> subsysnqn, hostnqn and cntlid can be derived from the caller's
> struct nvmf_connect_data.
> 
> Replace these parameters with structure pointer nvmf_connect_data *d.

Usually its preferable to use explicit parameters instead of a wire
transferred data structure. Not sure this particular change is useful.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
