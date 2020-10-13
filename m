Return-Path: <SRS0=D3oK=DU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E2DC433E7
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2020 22:25:32 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC20C21D6C
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2020 22:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qqUvEUNh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC20C21D6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=qqUvEUNhojpM031s8G+NjZj7I
	JZLLyF2h5i6vLOC9xNTECgs41vuiVcak9UMglI9eftjeaigpBGfLidv9UfRM5YnHKNmJdLcfaMolA
	5oxYYKvTWKwHEOCfEJ1P7zW8uG6Qi+X+2RaMSB49REy/UnoMygfeuNkvzXGQiSfRPBXM2Tte6tpHk
	BZIlxmOl3taJJ9B7FsBbCFbv6LVCbdLrrIMLrLACLsKS+9UEQ/yB3o/zCs9uEJ41xWKq1e5V7tlhv
	l9F2N2m7wWi7Iee03+n1QSZBECK5fyqamCEkQo0wgqVccI4RjilbDjhuRiCdTsuoFptJHkow7DMWM
	uoq+fwJhg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kSSjX-0001gE-VL; Tue, 13 Oct 2020 22:25:27 +0000
Received: from mail-pg1-f195.google.com ([209.85.215.195])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kSSjV-0001fl-Hl
 for linux-nvme@lists.infradead.org; Tue, 13 Oct 2020 22:25:26 +0000
Received: by mail-pg1-f195.google.com with SMTP id r10so613532pgb.10
 for <linux-nvme@lists.infradead.org>; Tue, 13 Oct 2020 15:25:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=bQrQePpgupHUuXEPTwRrb6D0KHivFBBwHckU1dkMe/gR26Kz/tgyo74zKMDqrAb+bm
 CfRA6xJmP3WbOuqif8t1nA7q2wM/Zg39BlHGmEZirr6FXANEp4AcX8l1etM3VL8rFIiO
 9l/E7yMNI+q4T/hIyofGKmYiicgj5xMrAhWBbQgKIClVsfdMNCqJasnO4/aAyK/ApkIf
 NcZdhP6NE7ItV1lVk6mqJ+JqLOsaTVvpwP9OuxYjmySQ9p1daTA0vcmpY5h+5SMe8Hk0
 OO7RxnuPStri7EcJY/OyWQuxsYcpGHcRqb4EOySD2h4TK5i/s6P+izQSsJnOy9l14zOc
 kJQQ==
X-Gm-Message-State: AOAM533E+sIaLWlxeQdQfL4yHPk04YQ2SV4Ws/CnVEJFcEIee6tp5UYL
 bBcALe6W+U12c/vr5ZrF4Ag=
X-Google-Smtp-Source: ABdhPJxoXl3mqeZprMDkGxb/SGSKX87McmejNPzyBiAjx7rrKkYVq0oAvxmViqPSKBcpDNKyPa9D1Q==
X-Received: by 2002:a63:4457:: with SMTP id t23mr1370919pgk.108.1602627923346; 
 Tue, 13 Oct 2020 15:25:23 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5a09:2d7:19f0:1ee0?
 ([2601:647:4802:9070:5a09:2d7:19f0:1ee0])
 by smtp.gmail.com with ESMTPSA id t12sm689327pfh.73.2020.10.13.15.25.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 15:25:22 -0700 (PDT)
Subject: Re: [PATCH] nvme-rdma: fix crash when connect rejected
To: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org
References: <20201012081040.31741-1-lengchao@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <cbbe61ba-4061-3150-911d-db4aa0baf85d@grimberg.me>
Date: Tue, 13 Oct 2020 15:25:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201012081040.31741-1-lengchao@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201013_182525_616171_A02F6FB3 
X-CRM114-Status: GOOD (  10.07  )
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
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
