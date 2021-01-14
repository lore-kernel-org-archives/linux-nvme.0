Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCC7C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 21:18:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA1B923A50
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 21:18:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA1B923A50
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=w2I0Zt8a1gvexHAwSV5c720249GBBAHvwuFSJW9gKk8=; b=y0qRdm6/nPf/SPh5TAEAwNl+q
	5IM19KOO/exLQxgBQHXmDr+V6BocgzQTNOmXhC6ZJ8h30w6C9OLVowez+n7c0KcmrZ95VAY9599qG
	5drUlfAeZtjUPKHtndQiY0yb5tEl4Xn53Uak4mqoJ5mZ9pOilDWoJj329dMYkhjFLt4+jTjOgnHK3
	L+r4xqPibxKv7ogH52WIPdOJdtEl9CfjfX9zoelNvQy0alhnUGUMXkBYZR3tIlGB3+HnsZIZ3NRUt
	HlaN7mTlYW3nk0n17cF1EsL0raud1nGAhgMo7wb6S0460gNSL8OhsWLbUJVAOHUwZeoJtJbcdoBNw
	lY0XfVZwQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l0A0b-0004zo-HM; Thu, 14 Jan 2021 21:18:21 +0000
Received: from mail-ot1-f47.google.com ([209.85.210.47])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l0A0X-0004z1-PC
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 21:18:20 +0000
Received: by mail-ot1-f47.google.com with SMTP id x5so6553250otp.9
 for <linux-nvme@lists.infradead.org>; Thu, 14 Jan 2021 13:18:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+KoeXsHMyF/Ao6DqLpcbzj4Ja3q4lG83NMGCDdHGwMA=;
 b=EOccNLY9qD/gRCPIgoNyVV+hx9kcOSZHMEANCfdhn6DTlqmBm2YYw707ccw93oOWXm
 zvOxlS3LRNb6MfiysUhByk0HdETbpOrlmBaAwCVbmSB+jyPfFF55zP2b2RVR0diN5a51
 FDcV03S8Ah8iJ9sMGPSpTyZnW43+3TxC7GNlyrmigL1YH/a2T0PI+sZmG9JmYQHYhGLF
 gsL/JLeavkZbaMagPl7lbbyczTbrjn8OHIKRDmqxfXuBTodBQ79CHdY/4ec45yBPZT6Q
 iUHcYfEWxd4qx6uKd6JgHh+2bSrjlrpmtaDqMqTYAcNAU6Bj+Cq9IQzCkLeVhthQ2oGE
 iIHA==
X-Gm-Message-State: AOAM533IUYkdnzj7LfZiGS5zMqLS+sPDrxEatPwRJ8+Gg0FqBCUmMzE8
 sYCjX3HwillOFsib7aLDVNeEG2Z9rDY=
X-Google-Smtp-Source: ABdhPJyymBd1ndVIAqxVcUpsQnAcb80n5kqyImRUzaEBsNlpqW9bNEYpvgVCPaZYylsYzWMBS6h/Jg==
X-Received: by 2002:a05:6830:1be9:: with SMTP id
 k9mr5938171otb.226.1610659096611; 
 Thu, 14 Jan 2021 13:18:16 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:9240:50d6:cd00:1b14?
 ([2600:1700:65a0:78e0:9240:50d6:cd00:1b14])
 by smtp.gmail.com with ESMTPSA id b19sm1298221oib.6.2021.01.14.13.18.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Jan 2021 13:18:15 -0800 (PST)
Subject: Re: [PATCH] nvme-tcp: fix a segmentation fault during io parsing error
To: "Grupi, Elad" <Elad.Grupi@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20210113115152.69692-1-elad.grupi@dell.com>
 <ad9f038b-9920-21da-755c-85f4e2228a22@grimberg.me>
 <DM6PR19MB401194016A086DDF8A82C554EFA80@DM6PR19MB4011.namprd19.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f5b8dbc2-7960-894e-47ea-b18665536e70@grimberg.me>
Date: Thu, 14 Jan 2021 13:18:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM6PR19MB401194016A086DDF8A82C554EFA80@DM6PR19MB4011.namprd19.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210114_161818_361484_989F671B 
X-CRM114-Status: GOOD (  14.57  )
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


> Thank you Sagi,
> 
> I will submit a new patch with a comment as requested.

Thanks.

> The patch you sent did not solve that issue, I submitted some comments on the relevant thread.

This was a silly typo, did you check if it addressed your issue when
you applied the needed change?

There are stuff there that I think we need to use for sorting out other
issues where your bug report is the trigger for this.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
