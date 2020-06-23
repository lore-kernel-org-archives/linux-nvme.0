Return-Path: <SRS0=DDko=AE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40810C433E2
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2020 17:39:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1003920781
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2020 17:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="16VbOmEB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1003920781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wLODI66SmA8aaI4uvixKc1jAmeAkJGmzlFyl3gaVHCI=; b=16VbOmEBWob26py8dwrCF1BXW
	eSzaVcbZ7RsWhJRY9i+Kwxt1r+1caaU2rT66uxYcZYpfWQqbcn2hjSVxjiXWhtMscVHNsFa+jVHLq
	8LMvlmJgLXf8cXlxmAzirlwhN3xY6ZgPxYeVGlH4aZCW4JjbDdxEY1PvulQIaJ8Xd5lm6/fC/TO5y
	uTAJOw/IxgwjFvZsdNbAcLxWiJo4bqyfM2dPwOtaKBa9SwuX1Kvt2QNldwpZAfYOTQjhKgnOfcYma
	utMaPXQwS9XvIaXG31fMx3Odb4MUgskNLJylUzeFfKC0K7xnrvvpv7VV0p45Pyjq3xQUgOjJ/bUol
	W4uOrZuIw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jnmtK-0004yt-Ne; Tue, 23 Jun 2020 17:39:26 +0000
Received: from mail-pg1-f193.google.com ([209.85.215.193])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jnmsy-0004y9-9M
 for linux-nvme@lists.infradead.org; Tue, 23 Jun 2020 17:39:04 +0000
Received: by mail-pg1-f193.google.com with SMTP id z5so1697309pgb.6
 for <linux-nvme@lists.infradead.org>; Tue, 23 Jun 2020 10:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kAIQAxiLnbAZ5BAFIcJMeyR0JdJvLnsFgfO/0/AmLPA=;
 b=BGF7ZJdild9yAHZEeZGSsdinHBybSDjCtICmZEw2K8HiZ2Ppe9yNUIXT69hXA1a2AJ
 zV+ofVG0t+k6CL7Oe75KDT+FRluWb9/AsbUgl5fNMNfT5iVnZtOcuzKZS2i9WQUB2EHY
 sA/1WUHfLePa/8v7XoR2+X+rQ7G0XzX/7loWm8+dN3Ma7W9wxEZaSEqmg8uvPradeN4O
 wpiI0OycSNsjTyoIVm/Q8fRijkW2B3WOifcvevGrXzciUDL5quYEug0XGEK1VTt30LSF
 TTQIJTRt/ATFSQ6F6UksOOASquG0gQmuEE00ZtUApR4J3Vggb43dFJDheJhJetkJMzfU
 UsbA==
X-Gm-Message-State: AOAM532a9wSUL2JQx/fPKTqouvTgGD4vQ/ajmgDvNprGPu3cgUVWpRZ1
 pay6Z3t2fI6GXz+a9WRFZZQA4mAK
X-Google-Smtp-Source: ABdhPJwP+kfIPptinn90SJZmapQDZ/xaZKvE4G/xUSfG1p1yiK8fszEV/rJ0jnK8F52BozCNCteXDg==
X-Received: by 2002:a62:31c6:: with SMTP id x189mr27591959pfx.79.1592933943273; 
 Tue, 23 Jun 2020 10:39:03 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:acd7:a900:b9f:8b8b?
 ([2601:647:4802:9070:acd7:a900:b9f:8b8b])
 by smtp.gmail.com with ESMTPSA id m1sm2880457pjr.56.2020.06.23.10.39.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2020 10:39:02 -0700 (PDT)
Subject: Re: [PATCH 1/3] nvme: Add Arbitration Burst support
To: Keith Busch <kbusch@kernel.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>
References: <cover.1592916850.git.baolin.wang@linux.alibaba.com>
 <bf3f47ba50f72d0b775ca4bd098f183056d964ba.1592916850.git.baolin.wang@linux.alibaba.com>
 <20200623144014.GB1288900@dhcp-10-100-145-180.wdl.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <38482b1b-b1c7-bb41-b086-6ce00f6a9d1d@grimberg.me>
Date: Tue, 23 Jun 2020 10:39:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200623144014.GB1288900@dhcp-10-100-145-180.wdl.wdc.com>
Content-Language: en-US
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
Cc: axboe@fb.com, baolin.wang7@gmail.com, hch@lst.de,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>  From the NVMe spec, "In order to make efficient use of the non-volatile
>> memory, it is often advantageous to execute multiple commands from a
>> Submission Queue in parallel. For Submission Queues that are using
>> weighted round robin with urgent priority class or round robin
>> arbitration, host software may configure an Arbitration Burst setting".
>> Thus add Arbitration Burst setting support.
> 
> But if the user changed it to something else that better matches how
> they want to use queues, the driver is just going to undo that setting
> on the next reset.

Where do we do priority class arbitration? no one sets it

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
