Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C515FC433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 17:44:28 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59FC3650DE
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 17:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59FC3650DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=AggQQaYw0LRa7z+BCLC6ftebzAByqnFEc8ZAjRmKGKE=; b=Je/Ex+VxJKP6bbywIIrTt43OB
	OlDW+oNzFcwfp3bgZL40sN3zIiRmHmi1j9dchMVPb8dAz55+Z/0X7vqAZCgNIxoYl1VcqB9U4p5e5
	CkV4N3IAxItrabGhXEt43VVYLKhCNWiZXvOaHBH61AGn8+YNMsBYHL71sHh/HERKVW2MfxUP84KqT
	QEm5gb+ju2hpb8ti+I/uG2uBe0P8ugS++J5I9wOFPDcFEZSEKonsjgwe5bYwIeGh357z5K1MpsSUz
	8pgEUbU1BSbh6aw2PRN3OEgv0FT0C6V0sIZ1F6Lygdh9s+xT0WLhkHsxgzm6WBxaD+YmY2Az1NWGH
	0N23Peynw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMDjv-001Qbf-Q2; Tue, 16 Mar 2021 17:44:19 +0000
Received: from mail-pj1-f52.google.com ([209.85.216.52])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMDjr-001Qb0-5W
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 17:44:17 +0000
Received: by mail-pj1-f52.google.com with SMTP id bt4so11025229pjb.5
 for <linux-nvme@lists.infradead.org>; Tue, 16 Mar 2021 10:44:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oedJ225ic1gq2kbSPrGpiTpT8hq6Xcsz+JtYFrsDyyY=;
 b=Iw0+iLBNINcBa2fbVB39+DZBTkDlyrYo3WXB63Qc8tSQlHRuxsGTl5Xn4vCaC+aaH8
 tsWs8t1/NTosMNv8yycD3irksMfcBuoSwSdO01Kfdz8m7/kncznijnguMrMp1MX2WzS5
 0R2quulsKMKAL92BMKLDkpMWKYyHycsFyvHNi/zf/DWj4bPqPfK0o5G9AdRMDZGEcERx
 T3PaIWI2kQBrs4EFpSq1LhOaxksJ/65hz74+ADTAzg/swAeCIUkshCOhsc5eDeVa/0Fy
 sDD4LcjxYot18Ox8OAxyX/p45s+383X/i3jRrFIxpbNVDlUQ99shOVyFnzApp+apG6b5
 I6HA==
X-Gm-Message-State: AOAM531i/Q/TlLHtXSOJv/EwIyF9V/L1YQxneTnhilQXUXVhQb4zSbXU
 1/bT5JMHcHOz2qTsBPeop4It+xv8hxk=
X-Google-Smtp-Source: ABdhPJzDctdQzf4N0KFpqoB1wiqjuKmizOm5UOYrBKIi/qs4dfBJHUrjmxBd9v9ZwlF7mLZAUdNqeA==
X-Received: by 2002:a17:90a:5889:: with SMTP id j9mr205356pji.69.1615916653328; 
 Tue, 16 Mar 2021 10:44:13 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:52e4:89ef:d916:a3a6?
 ([2601:647:4802:9070:52e4:89ef:d916:a3a6])
 by smtp.gmail.com with ESMTPSA id v126sm16975349pfv.163.2021.03.16.10.44.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Mar 2021 10:44:12 -0700 (PDT)
Subject: Re: [PATCH 2/2] nvme: use driver pdu command for passthrough
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 hch@lst.de, Kanchan Joshi <joshi.k@samsung.com>
References: <20210316170632.4161183-1-kbusch@kernel.org>
 <20210316170632.4161183-2-kbusch@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <7d077a33-8100-245f-37c0-a6f66ff29ded@grimberg.me>
Date: Tue, 16 Mar 2021 10:44:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210316170632.4161183-2-kbusch@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_174415_469881_54478F42 
X-CRM114-Status: GOOD (  10.70  )
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


> -blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
> -		struct nvme_command *cmd)
> +blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
>   {
> +	struct nvme_command *cmd = nvme_req(req)->cmd;
>   	blk_status_t ret = BLK_STS_OK;
>   
>   	if (!(req->rq_flags & RQF_DONTPREP))
>   		nvme_clear_nvme_request(req);
>   
> -	memset(cmd, 0, sizeof(*cmd));

I'm assuming nothing broke with this clearing removed...

Did you happen to run blktests?
- ./check nvme
- nvme_trtype=rdma ./check nvme
- nvme_trtype=tcp ./check nvme

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
