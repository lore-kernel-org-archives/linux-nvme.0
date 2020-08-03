Return-Path: <SRS0=Ae0q=BN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B05C433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Aug 2020 08:29:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FB51206D7
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Aug 2020 08:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tqblMpNU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FB51206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=tqblMpNU7TpHvslpLDeQ9477E
	5DXRXwX+Ax08sDEQJRSLzUpGg2d+afbNlqkf7DxLtwTK5hUQqYkLH5JERK6LuQRRWx2w5kPUPKj9c
	VSDIuEao0YCD/PnG/M2bTZerE+Mywsqv67KTDVXRjsAQbwxHbkpUnBccNNM1QtYRwL4LMg/MyOgzI
	Z1/hGGuQbBw/7H90w9hsPIOO+DfH2euJS0hLG0C1WTlV6Rinw/glnlxakc3EBnZPAAXY1gB25JnAJ
	62pI4F4EK31vFgNQYEYsXxjZnzOJXZBubEWg5m5NeBcmBmRLK/m+4WH+U1OlYOEYr2d+sDR0QxrQT
	2Wf1xaowQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k2VqL-00005H-2n; Mon, 03 Aug 2020 08:29:13 +0000
Received: from mail-wr1-f65.google.com ([209.85.221.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k2VqG-0008W3-Vt
 for linux-nvme@lists.infradead.org; Mon, 03 Aug 2020 08:29:09 +0000
Received: by mail-wr1-f65.google.com with SMTP id y3so33350281wrl.4
 for <linux-nvme@lists.infradead.org>; Mon, 03 Aug 2020 01:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=MP+5nTHF/f16zBVpL+ihRgj/dAAuh/ukdTG/9OUzyXXiiSOAhU/t9WRzlZ+jkiAnY4
 FvuUkpvTK0MQn63bQ7hICBtgGsRuAARx7992+HKKoKplH16sZcMEuBvTG8vDGwVR5cF+
 gFaS1Kokmv0mwZLDcO97yy3BBUOY0jLWAOTWr8QsYyINw1ysLCraHIjL6y9LiwtysP+X
 uDW1TTN9Jg9I2AFVXNwCC5YtKFdJRwrwaz+lEB8TymrVGoSxrx8PfQZVqO1payOu7+gs
 767QgKNodJf3eebzZOM+EZXOBd/smM15qA7oO4ytqO3mDv/40jRbYOhhz2Njb+s6Oqi+
 2SMQ==
X-Gm-Message-State: AOAM530zH5s/G1DkOofZY8JbQwfIyBDt5/J6gOst+7TXAvOHGOQ4vSWr
 yMk/VKg+ozJXaC4+FmlbKYc=
X-Google-Smtp-Source: ABdhPJyPx3/rVzkllsJRPSUy4Uln2/0isGBUXD0h1FIFBnnuS6eoK6QJVjYkInrN0SJMUbG3t5N2Yw==
X-Received: by 2002:adf:f151:: with SMTP id y17mr15055163wro.179.1596443347274; 
 Mon, 03 Aug 2020 01:29:07 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:6dac:e394:c378:553e?
 ([2601:647:4802:9070:6dac:e394:c378:553e])
 by smtp.gmail.com with ESMTPSA id m1sm5183485wmc.28.2020.08.03.01.29.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2020 01:29:06 -0700 (PDT)
Subject: Re: [PATCH] nvmet-passthru: Reject commands with non-sgl flags set
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20200729191009.4485-1-logang@deltatee.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4641649c-b777-b2cf-2c40-16c0c9d23cfb@grimberg.me>
Date: Mon, 3 Aug 2020 01:29:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200729191009.4485-1-logang@deltatee.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200803_042909_125869_24B1EDFD 
X-CRM114-Status: GOOD (  10.26  )
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
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Max Gurtovoy <maxg@mellanox.com>,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
