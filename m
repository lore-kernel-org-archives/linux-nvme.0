Return-Path: <SRS0=sPWJ=AQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43562C433E0
	for <linux-nvme@archiver.kernel.org>; Sun,  5 Jul 2020 06:58:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1400E20786
	for <linux-nvme@archiver.kernel.org>; Sun,  5 Jul 2020 06:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KbX+vt/l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1400E20786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=KbX+vt/lTOfsFAT0siWHo27ZV
	ctjtotJMY5m2bScK88XNFHAW8k5xGILa+Jo4FU9G8sRewdAr6gzQJSkUUQ40Gl8T8KIHIuoLYm2i0
	MTmGQ1J98/ok6koHI+U2qBv7tg9ZSXbVE48SKRRLOPx4SorYXLoz2zoXozH7/9bT8rhmWZ3a+CTrv
	umb6w/kJxwi2SRgD47McvtlUX035sUxS6AGFA8k18+imYfBd3Ees+SzB+O9Sky72cW44laBgFJsKm
	r1nPTbiCHUGf1AOfALyOAxwLr3L5RIKUEP6//lTn1Epgj9P5oYwuxL5SLSuv/wFVEd035CR7WLHYq
	M3y+0v7VA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jryb3-0001s8-Sz; Sun, 05 Jul 2020 06:57:53 +0000
Received: from mail-pg1-f194.google.com ([209.85.215.194])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jryax-0001rW-KI
 for linux-nvme@lists.infradead.org; Sun, 05 Jul 2020 06:57:48 +0000
Received: by mail-pg1-f194.google.com with SMTP id w2so16155233pgg.10
 for <linux-nvme@lists.infradead.org>; Sat, 04 Jul 2020 23:57:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=PhcSXZzKDln5G4OxdIFKDpG6d5ApeXiFTXcgxUvp4fm9NMlBGvOMTYOIILtFbAUdiW
 VC9Q+vTs1b9c/cTAjRBJUoIF0FpMdfw5+VEfy62s9xFNndbW8yeKkZDoa4MiE3FGbt0T
 cz27J2ENFH9ZumETrtO+OPpmnnTX8l2Yg88Ivudf8voLKSd+Tz2nLURtsnDyKJyJHOP2
 0P9TyaJ2ddbzNr/zx1MFYEGXWGp55n2uPdSfHUUqpMSY7KGVGvPLi/5WDBFz8CCFMn4n
 cOboNzzmzkrGVCV1UJlR4LrzptSG2u+V+2JlbhAYEAQbGy8c1MN4lv18IdfW55P2fViU
 byTw==
X-Gm-Message-State: AOAM532rbpm1tNohmvdfX21ofjaZK2a3JoZer1QmoK4GVO1vYOMJHDvp
 YvWSju8kljN5kuPgTqq0W7k=
X-Google-Smtp-Source: ABdhPJySiIKdxUgJ5KvNkSJIlMB6oJcFhp/aQflJgSvhdfl1UVB4puezU51EnI++76D74RV4ZWqE9Q==
X-Received: by 2002:a63:29c8:: with SMTP id
 p191mr36769320pgp.333.1593932264458; 
 Sat, 04 Jul 2020 23:57:44 -0700 (PDT)
Received: from [10.10.10.239] (068-186-033-250.biz.spectrum.com.
 [68.186.33.250])
 by smtp.gmail.com with ESMTPSA id y12sm15886090pfm.158.2020.07.04.23.57.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jul 2020 23:57:43 -0700 (PDT)
Subject: Re: [PATCH 1/5] nvme-pci: Fix some comments issues
To: Baolin Wang <baolin.wang@linux.alibaba.com>, kbusch@kernel.org,
 axboe@fb.com, hch@lst.de
References: <cover.1593743937.git.baolin.wang@linux.alibaba.com>
 <3820a0fc3c74f9a70a8856172d499de4dee3c2b7.1593743937.git.baolin.wang@linux.alibaba.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3c46f453-f215-0478-2acb-87d73ee477ae@grimberg.me>
Date: Sat, 4 Jul 2020 23:57:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <3820a0fc3c74f9a70a8856172d499de4dee3c2b7.1593743937.git.baolin.wang@linux.alibaba.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200705_025747_690693_0728BD2A 
X-CRM114-Status: UNSURE (   7.94  )
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
Cc: baolin.wang7@gmail.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
