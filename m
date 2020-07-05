Return-Path: <SRS0=sPWJ=AQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944B9C433E0
	for <linux-nvme@archiver.kernel.org>; Sun,  5 Jul 2020 06:58:02 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FCAA20786
	for <linux-nvme@archiver.kernel.org>; Sun,  5 Jul 2020 06:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gcsOG45n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FCAA20786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=gcsOG45nHIu166ud3xet9rp8s
	lYHAlaoeAExUsyfrW/UqBS3EvDzY3pgWFBJGIEXwkEAk2ZBQOaSWYeKIOmcGy+pwxjPlN+ovNpZnL
	GF2P/sKPUdZ3sM2t5fn5Q42OWRASrjB7nbDxpqrUwORuoFy7Pc9VICb4yQt4CGAtL8MKz+kZqB2Xo
	z00/o133wHVTf4+i9DVs0eJCuoW32fqdUp3GawF+hGIwFwMn37KUEjV+p5PTEr+cYr/B9xut0yC7u
	JL3SlJ8WzZrs+i/mk7P4Mm4ybotTMQbV3CldWPoiNcO4GpZ0nhEPUc3H6zD6K+aAj5M81ieJezzb7
	lht9qyw8g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jryb4-0001t3-Rh; Sun, 05 Jul 2020 06:57:54 +0000
Received: from mail-pj1-f53.google.com ([209.85.216.53])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jryb1-0001sL-BD
 for linux-nvme@lists.infradead.org; Sun, 05 Jul 2020 06:57:51 +0000
Received: by mail-pj1-f53.google.com with SMTP id md7so529440pjb.1
 for <linux-nvme@lists.infradead.org>; Sat, 04 Jul 2020 23:57:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=bPuMrM9bExJVtdlRUZyAmpYRB6pVBy8HpQIxWhAqe+j0XIn+iVQiLUIGT8YtpNIgZH
 natd6xaSQlY3seIMX75W758CZVNQecOgtmn7VvpiU563nzeY09+jYhh8EVseqGB8+soy
 Qh/Ak09WnBdeX3yGkddFa5bSFALNo86kfi3pUGZUR1yDVVj2XgoJrdZpyg9uFI2uS9u/
 6dVTYsnIuRtuX1fl5oXEYxPmlDJiu7HJ4LowBRuOVuzrRmA/gFKibHWvNl8BunthLfML
 CLsr55PvYKHS97/WIL05BtihcjphCaKySEenJlrJvmAFY1gq/a7cNHG7ZaZTbMKSNLIb
 v00g==
X-Gm-Message-State: AOAM533z5nTbyr/Y848bgxiqYG7BLJFRWwd8VDjpFTbdTFcSrn0s8kb0
 jvXPJ/fkPYMH5OSR0/tcaPA=
X-Google-Smtp-Source: ABdhPJypWSm9W9bqR3VR6bTyuGv9UTH4hvnCUSOcXNB3QyCHDa8bAzBTf3ID0QEgL7VrehVs0MPhnA==
X-Received: by 2002:a17:90a:fd12:: with SMTP id
 cv18mr39950621pjb.66.1593932270252; 
 Sat, 04 Jul 2020 23:57:50 -0700 (PDT)
Received: from [10.10.10.239] (068-186-033-250.biz.spectrum.com.
 [68.186.33.250])
 by smtp.gmail.com with ESMTPSA id w9sm16328111pfq.178.2020.07.04.23.57.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jul 2020 23:57:49 -0700 (PDT)
Subject: Re: [PATCH 2/5] nvme-pci: Add a blank line after declarations
To: Baolin Wang <baolin.wang@linux.alibaba.com>, kbusch@kernel.org,
 axboe@fb.com, hch@lst.de
References: <cover.1593743937.git.baolin.wang@linux.alibaba.com>
 <dbb9c52aeb4030387a17342ca9e76fd09d84a0ed.1593743937.git.baolin.wang@linux.alibaba.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8ccb5416-1c55-41f2-8808-b102d32cb55e@grimberg.me>
Date: Sat, 4 Jul 2020 23:57:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <dbb9c52aeb4030387a17342ca9e76fd09d84a0ed.1593743937.git.baolin.wang@linux.alibaba.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200705_025751_416410_5C7E0B2C 
X-CRM114-Status: UNSURE (   7.97  )
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
