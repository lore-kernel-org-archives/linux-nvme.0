Return-Path: <SRS0=Cbe1=EO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF87C388F9
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2020 19:13:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B339206CB
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2020 19:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0wTuippB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B339206CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=b+v+2WNj8AzdguOBxp5gyGwe6uHrEYujcas1XleX0Xo=; b=0wTuippBEu+ImLC2Wdw/5xkyk
	VPACBMLY76OicZEixKnf+i2yVWRLPjcGpM8D6hDlMvlH/FRses1neK0mSkfoPV96/er9QQTVZyTo0
	wyJd2V4L/c0kGUEofqL33j5SsOTyxJrhSiMG1O5djFcE2Ynm0V1It6sgmo+QgFb9UdHNWORseOYNN
	SeyR0tl9KRzutD57XMsHUROhy2bnxqTEGWSt9Vgj/MIJQAa+ahEY+hu729W9Zri9xlQA566xYXTBd
	vtimpO7KLhkGlOpu6xNXqQeFMJKh0s8Q7KLEmHgN7UPfJZK1zI+G/JjQSrsjAbOuaTRCPtUslCavR
	HfD9wdbuQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kbq7s-0007Gx-6g; Sun, 08 Nov 2020 19:13:20 +0000
Received: from mail-pf1-f195.google.com ([209.85.210.195])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kbq7p-0007Fz-FU
 for linux-nvme@lists.infradead.org; Sun, 08 Nov 2020 19:13:18 +0000
Received: by mail-pf1-f195.google.com with SMTP id c20so5773400pfr.8
 for <linux-nvme@lists.infradead.org>; Sun, 08 Nov 2020 11:13:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=r2an0zuoxHlVQmE3I5jUoDAgs/Ptaz66TgYk6snRpgE=;
 b=uIY+tBHgeAztPumcFB6iVFX6tZop7x3VMYg0drV/DObhu/b9yqE3Pt4o5mPdDLoxCP
 cjPkyXbhSGxog8IKTU7uI/f5U07rk/fpd4v8qTOwdQG8OUxQ6dWj6WfLfPwF1O3s41/L
 IOrGilKpxlCTCHrsgP2J8nN1QFXq1KA09re2eHqrujy+GhchwH+rmklCAALjOme3x7Dx
 tAhRCxgzCdksqMLoyEZCPxqrw6+PRuWGdL9Ks3QVPADY5mc+Ps7Y6OsPpU+f644z52b/
 nDVhxLYYJS/YwpvZ7guDIIbMA0Z2jkm0YtpmF3QYPOrUabxXxvp3ZsmPUpciE4GMhTCN
 BMGA==
X-Gm-Message-State: AOAM533V0UmDy1ZQxk3cQjxNF03amleAX5OBc/0If0edo/Ha3cTdQhhN
 GC9zxZIgDlpUjIYhbjXKLiE=
X-Google-Smtp-Source: ABdhPJxOi7t1YkGVXA4B5y7RIY4ctkyqTxUOTlUz3b5htEWxIKa6xNPmIgY/XOlDTCoSCpiGYJiuJQ==
X-Received: by 2002:a62:de44:0:b029:18a:ae59:4d74 with SMTP id
 h65-20020a62de440000b029018aae594d74mr10328688pfg.72.1604862794055; 
 Sun, 08 Nov 2020 11:13:14 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:73a5:373d:4376:8603?
 ([2601:647:4802:9070:73a5:373d:4376:8603])
 by smtp.gmail.com with ESMTPSA id n7sm8169580pgk.70.2020.11.08.11.13.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Nov 2020 11:13:13 -0800 (PST)
Subject: Re: [PATCH] nvme: Boot as soon as the boot controller has been probed
To: Bart Van Assche <bvanassche@acm.org>, Keith Busch <keith.busch@intel.com>
References: <20201108040903.8185-1-bvanassche@acm.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <da5be7f4-fa7e-3896-fd1e-8d2c0d80565a@grimberg.me>
Date: Sun, 8 Nov 2020 11:13:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201108040903.8185-1-bvanassche@acm.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201108_141317_539044_0D632901 
X-CRM114-Status: GOOD (  16.69  )
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
Cc: Greg KH <gregkh@linuxfoundation.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> The following two issues have been introduced by commit 1811977568e0
> ("nvme/pci: Use async_schedule for initial reset work"):
> - The boot process waits until all NVMe controllers have been probed
>    instead of only waiting until the boot controller has been probed.
>    This slows down the boot process.
> - Some of the controller probing work happens asynchronously without
>    the device core being aware of this.
> 
> Hence this patch that makes all probing work happen from nvme_probe()
> and that tells the device core to probe multiple NVMe controllers
> concurrently by setting PROBE_PREFER_ASYNCHRONOUS.

This would make the controller instance inconsistent across reboots
which is annoying for some users.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
