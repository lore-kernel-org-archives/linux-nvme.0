Return-Path: <SRS0=g+aI=DG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC71C4346E
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 08:36:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DB3C2075A
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 08:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ngm3LRbm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DB3C2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=Ngm3LRbm87n3KQY3SUqFumkoR
	W0GPmW/XvSjny1m5GieYAcNf/7s8NIZ9dxAloC5AUx9G806drJjwgiy5dktPw5VL6rDtMFeiq8XN6
	blP5F2OSvJoqcEtL1cEjLSTy1UN/a6UoAqVuS99GWxqdhX2NriAxVSfyZETXvyKcsqm+5lI5iOA6t
	HvY9DqOCq26obSQQuzK9ucxsic70uieImlotLEaGWknY9eWfY4u7u2CXHqZC9YN7fBQlOdw10opwS
	Vfd7ONJ1SnhpdqI/hrFxN7P0iryDAiBimXpa2OLoj77paoRhtloVjtTbY/MUswAooWLQYu3Q70NoG
	9MbSd49tw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNB7l-0005Dt-FF; Tue, 29 Sep 2020 08:36:37 +0000
Received: from mail-pf1-f195.google.com ([209.85.210.195])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNB6e-0004ZR-JT
 for linux-nvme@lists.infradead.org; Tue, 29 Sep 2020 08:35:35 +0000
Received: by mail-pf1-f195.google.com with SMTP id w7so3818301pfi.4
 for <linux-nvme@lists.infradead.org>; Tue, 29 Sep 2020 01:35:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=qvUzWoIXgicM0epFYp+ROCOcxpvYuxtRmt5hzrEWq4zKyH5bakO3saNBY/QFhOH3Pd
 xTC3uakVZBqZn2Ncuo3wwjeO9ayRT6dHx9sx2Ql0xgornct2HXvX2eOIxzQE65JGM26Z
 UgCjl6KLZPie7CaRM9V3aOp+5uY6az3L6ROhSxVimaaoPU8VqeW9xY7kgwt9OYzXesmp
 zCAyfsci29R9U7JL+uPIDj20mJvcMT+eM4kGSKLk8CpDj05SOu+QTLOZgJnkHklBxlFc
 OKO9ZvxgJOvy0y0zgkArRXDvktMhCMtM16GDdo1f+DaCXs40l01mhmTDUKozQ3gGv/TM
 txAA==
X-Gm-Message-State: AOAM530CiyTl/UVXfQlis8G2qgKPRRNJv/WPYbmBfVqmmtBqdZVZBhie
 lpSRtgqQsfJJClqQg3zZS6s=
X-Google-Smtp-Source: ABdhPJyce4WIcV7SPjXBy7ZE7P/jlEwXm9w0NbRzAv2mxEh6x8orNfFUyqDRFVX5Y1hCfoQ5e7ud8A==
X-Received: by 2002:a63:ce17:: with SMTP id y23mr2493115pgf.447.1601368525987; 
 Tue, 29 Sep 2020 01:35:25 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:8ff9:9348:1454:22ce?
 ([2601:647:4802:9070:8ff9:9348:1454:22ce])
 by smtp.gmail.com with ESMTPSA id l21sm3580243pjq.54.2020.09.29.01.35.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 01:35:25 -0700 (PDT)
Subject: Re: [PATCH 06/20] nvme: rename __nvme_revalidate_disk
To: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-7-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <7a263eec-4d57-05fc-1cca-b14ee830d587@grimberg.me>
Date: Tue, 29 Sep 2020 01:35:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200928123502.435373-7-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200929_043528_705400_1A75ACBC 
X-CRM114-Status: GOOD (  10.55  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <Damien.LeMoal@wdc.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
