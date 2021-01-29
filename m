Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DEAC433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 01:42:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2345E64DF1
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 01:42:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2345E64DF1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bh4tb/uehhxrrw8a9rZpSPNBW+ErOjWBxKOy7GUHpw0=; b=1yVDyzzquIK7UyXbT8T7wqnLo
	llYZsZD/q+LyBSAKt/qY2wprnGMNkbj1YBUIyOjupoGXIw02noEXlAtSP8wO5L1M2b8FAY4UTapeo
	B1lxBUuimHf7UqmveKC1dNJq95Jhbf3hYFuY5RDewyXTEvQOGMu/zo5ygZVV/9zasxqXruUifsT9H
	PZSuht2M2QaPB0WOmXQhmzQr8/x3oJzPNhI9+2/uEZaWXfvMEYBpYuRyWe9mtsqVetcvoj645qc5h
	N+oYxyKdCtTno1/GbdXo3dUuYTKb6iyVcMRtxObkYOd+ujTaDUbtx5CiYzdE1CM/yiud0RJ1vdLB9
	yoBtZvoOA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5Io7-0001hm-IT; Fri, 29 Jan 2021 01:42:43 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5Io4-0001hK-56
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 01:42:41 +0000
Received: by mail-wr1-f53.google.com with SMTP id l12so7304525wry.2
 for <linux-nvme@lists.infradead.org>; Thu, 28 Jan 2021 17:42:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VVjkQneDDFTJ9oTx+Ry+gBBAMhGr8X7DLrSz+t7UhQs=;
 b=UCAs8XmO64dFHbY424HE+bK1IEcn9eVK4xLsdJlmCS+pm/PkDfStuiTETYX4z4Heut
 iPnIcb3uSinJgl0TmPb6f0CW6NHzZcmCjUSkyKS3eGmrLzsn0CX/UV3oTITvLLnPEOvU
 DHwRxsuHNIgQSHud1v3rTd0fmaxqJD1IvePICsBLb5550aKgyvkayKggCivGmaEdopQM
 Pb/3VZMdBVmMycVXelRonSbsvpnPWwYDhRdcgfxi0ILDgT6L36QVYYcWS7s/qO+wBwk1
 qjegopR3VaHff5iZ5S65QhEFH0xkFsux1mv8x2OjPXS+5PRRZm6oy2QASgWbYFsELXu9
 HyiA==
X-Gm-Message-State: AOAM530GNvWFxK5hb4xo8Klw5v8Q1+8D0iH/Eq/xBH5AZW8sXi+b2oyl
 ryaNwvW9J1tot0SPCOhMptM=
X-Google-Smtp-Source: ABdhPJzLYsrhEEcInNJ/93BzaKc6zmJA9nPQS58zDjk8/us582gb+RZGVaoI3OxT4S6GC3sKrnzgYg==
X-Received: by 2002:a05:6000:1565:: with SMTP id
 5mr1858778wrz.109.1611884558942; 
 Thu, 28 Jan 2021 17:42:38 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:3d48:4849:d506:e578?
 ([2601:647:4802:9070:3d48:4849:d506:e578])
 by smtp.gmail.com with ESMTPSA id p15sm9296563wrt.15.2021.01.28.17.42.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Jan 2021 17:42:38 -0800 (PST)
Subject: Re: [PATCH v2] nvme-multipath: Early exit if no path is available
To: Chao Leng <lengchao@huawei.com>, Daniel Wagner <dwagner@suse.de>
References: <20210127103033.15318-1-dwagner@suse.de>
 <db9baae0-547c-7ff4-8b2c-0b95f14be67c@huawei.com>
 <20210128075837.u5u56t23fq5gu6ou@beryllium.lan>
 <69575290-200e-b4a1-4269-c71e4c2cc37b@huawei.com>
 <20210128094004.erwnszjqcxlsi2kd@beryllium.lan>
 <ebb1d098-3ded-e592-4419-e905aabe824f@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <675d3cf7-1ae8-adc5-b6d0-359fe10f6b23@grimberg.me>
Date: Thu, 28 Jan 2021 17:42:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ebb1d098-3ded-e592-4419-e905aabe824f@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_204240_564647_F20A1AAE 
X-CRM114-Status: GOOD (  15.25  )
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
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> You can't see exactly where it dies but I followed the assembly to
>> nvme_round_robin_path(). Maybe it's not the initial nvme_next_ns(head,
>> old) which returns NULL but nvme_next_ns() is returning NULL eventually
>> (list_next_or_null_rcu()).
> So there is other bug cause nvme_next_ns abormal.
> I review the code about head->list and head->current_path, I find 2 bugs
> may cause the bug:
> First, I already send the patch. see:
> https://lore.kernel.org/linux-nvme/20210128033351.22116-1-lengchao@huawei.com/ 
> 
> Second, in nvme_ns_remove, list_del_rcu is before
> nvme_mpath_clear_current_path. This may cause "old" is deleted from the
> "head", but still use "old". I'm not sure there's any other
> consideration here, I will check it and try to fix it.

The reason why we first remove from head->list and only then clear
current_path is because the other way around there is no way
to guarantee that that the ns won't be assigned as current_path
again (because it is in head->list).

nvme_ns_remove fences continue of deletion of the ns by synchronizing
the srcu such that for sure the current_path clearance is visible.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
