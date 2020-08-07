Return-Path: <SRS0=rw3x=BR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BA0C433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 23:29:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EB0F2086A
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 23:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uTYI4EnF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EB0F2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hU8t2dBX8Td2g5inQA+S5n0gUnIn/nRGT+pcnG+WJiQ=; b=uTYI4EnFjo2SCqviQIcjomEl3
	eGBtG5LSNa4VpY7J/4XdnLyjZzPdmNALT+xbBf8aJ7SjTkLsxp5xSHp70iqin4J8Myh4Qb0+icK7G
	xi/BVmh5hEAh2rzrH4wLxS3k77+Y7PUrXL9u8kE/z6Sa+x0mctond588o6B6l1D/GzTTC0WRRUbQy
	einYB7nMWMrX6hpxFTC3WR8uCvEgPO5ZoQuwl74f6U1D2WReDI++R8FMSgCymkZyTspwVuMMi0QWt
	/oxWjqLIfmji6rVo12p6N7uVPPDu8Z4ZPM2HFAhnPiKyt0TV4Q5dXsLTCE43qr+2CICwgoPY/De4i
	bKUS2nidg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k4Bo5-00038J-4T; Fri, 07 Aug 2020 23:29:49 +0000
Received: from mail-pj1-f53.google.com ([209.85.216.53])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k4Bo2-00036Q-F6
 for linux-nvme@lists.infradead.org; Fri, 07 Aug 2020 23:29:47 +0000
Received: by mail-pj1-f53.google.com with SMTP id t6so1777797pjr.0
 for <linux-nvme@lists.infradead.org>; Fri, 07 Aug 2020 16:29:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BZ/FCxgGXu8RcAbK92jfONYnH73tR5tVgc95SvHO+cE=;
 b=CbOrAgtuDANdKRXtrTuY/DP1nWCiv9LuVw4sPI+4m+d675OOcgunJqUj9aojyVyXm8
 lbHf5E1JLZ76m0wvTwafAi68DbO9fACCFutWwWfrPgXT/y2ns9LsdJKHlWDBx+6NC4UG
 QPx2+sf4RwQEl+EQoSdrrIxbZHdUQL/Fkq5R5hP62WzvAtxfCe46v8AcEJcOTrggFDUe
 +Lsz6Dr8/0h8nerBZlnPtG1Ir0Dw4A6/K03FpuOnhaYiBUvS/W/18vUlTtGE9y5tCAuV
 XB5gMoeV/vt39g8ahS/NzdXnhFILIzbCJMp+vqE0Fi+dW5NU+Lcp90XuD0zzjSGneHxp
 fRLQ==
X-Gm-Message-State: AOAM532/Nk9sU53txI91nHnaGshTChu8uSp5TaoMzyqfyvkQIOwnhBrJ
 H79Jomc0eyYl7Wuv5QbKAOI=
X-Google-Smtp-Source: ABdhPJzLXCFLInnnw6jzicK0aK7YYF0vrq1kR1J5tNd48MfTXiY89CJBzvsJqTOV9f1hiqJgW6GmaQ==
X-Received: by 2002:a17:902:9e04:: with SMTP id
 d4mr13756866plq.296.1596842982791; 
 Fri, 07 Aug 2020 16:29:42 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:3dec:a6f0:8cde:ad1c?
 ([2601:647:4802:9070:3dec:a6f0:8cde:ad1c])
 by smtp.gmail.com with ESMTPSA id gz7sm11703887pjb.45.2020.08.07.16.29.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2020 16:29:41 -0700 (PDT)
Subject: Re: [PATVH V2 1/3] nvmet: add ns tear down label for pt-cmd handling
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20200807193026.9129-1-chaitanya.kulkarni@wdc.com>
 <20200807193026.9129-2-chaitanya.kulkarni@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e2881bed-0403-f044-2097-c75edee4fd8d@grimberg.me>
Date: Fri, 7 Aug 2020 16:29:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200807193026.9129-2-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200807_192946_548705_7E83FA76 
X-CRM114-Status: UNSURE (   9.49  )
X-CRM114-Notice: Please train this message.
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
Cc: hch@lst.dew, Logan Gunthorpe <logang@deltatee.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Still doesn't apply... not sure what is going on here,
the tar.gz applies though.

You should check if your mailer mangles due to some configuration...

Queued for 5.9-rc

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
