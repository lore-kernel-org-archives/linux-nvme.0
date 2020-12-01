Return-Path: <SRS0=HgeD=FF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD93C64E7B
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 14:04:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D43DD206A5
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 14:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ToOl9hV0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cr8nYcM7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D43DD206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mytozQqv/eCMwS8KNsau+CXxUg9xKsuQsBYYBfZuauU=; b=ToOl9hV0FW4MkGCXmYIjff2b2
	nneDmpGbQwILpmu6nzLXnsOqXWrqUOK8ZBl37t0d2JLHIjO9Rcre0MAPoH7L+Syk5LvwJeUWBhWFt
	8/leUUKJ2dZhz1lTyShq4Zv+eHDEMXPx2/XU6oVnoKI/L4H3SNUixiV7k1ptpdSfY+2UsN3pYox6o
	gEDA++NAAkmNllnh6sdKeiAJYXKkduCJAFt4bYhlDtwDmFPDvDIJrskQ6YelRnadZEddkufzYb3ps
	/u8oB7dVoWHLpItr0SNoeLZer5H+vszFk5Em5KQGoy0IHtBXnbTjLefizHzIMooA1lyCJVk2wgB+d
	oq4rt1nbg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kk6Gc-0004Re-WD; Tue, 01 Dec 2020 14:04:31 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kk6Ga-0004Qi-EA
 for linux-nvme@lists.infradead.org; Tue, 01 Dec 2020 14:04:29 +0000
Received: by mail-pf1-x443.google.com with SMTP id w6so1189592pfu.1
 for <linux-nvme@lists.infradead.org>; Tue, 01 Dec 2020 06:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=Wp+3VtFlwupaso5xzNNSSHMU/XlvxPbQQMG9fDuF0wo=;
 b=Cr8nYcM722dhBnC+B1T7MVFBU40CBtgxWGdnZ99e1J2Aj0Rjn7Xv/8IpeqN4BQ1RAo
 9PvgugcypnlRIjLCCHnNDQq+F3yv/5KPUdWnb/IH6mvCK+BrUMcF0sZeubuVfTCzUqaE
 dZ+jjfpm85rYsslU4XL2ntz3ahQu0kGLtG5zhQDjy7bTqfbUSfP5jmUj9k8s9Xogjh7z
 6EVozktjYnoBhhrkr0V0PfrS7Q1vbvgQ/6kK7l3zq9fsR8ZaVUnR/LR4v9nnbPV/tnI6
 wU1Npko8Y42FO+Ubk9im0ee44iYDIWCvvHyS9LAQ/kQvAV7itxQiRM4psGyDtZqHXzCe
 Q4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=Wp+3VtFlwupaso5xzNNSSHMU/XlvxPbQQMG9fDuF0wo=;
 b=LdfD6kRykc9Tov9EaWqmnot3XyFR6yyTzAOo/nJjyNTDbOUv/zZ623xmlWLwZdI6qb
 KwdTVUYm0hOZHTnBOHe2yXc4xNg90o6FyTSUiWurtvH1kdR/NtLYu/2IFS/+OwG1lD3c
 WF4iNkHtABT4hMjNLW1klKgVD4yKGBy0lmX+wF9fMruRUigk0FSG8FVLVZqdG4cB8O2x
 GZ05b1WEEqBa+4AyaHqDAwCByx4JdVZUDB5IjCwjpVoCUzbY1Zu+ATil+Q8CxG3shqLE
 wlxtqXvNBrIhfPpI2wrehW4Enm55d5pDvsk6p+QQQiqIBbLQIlE6XzFHEjApmMmIiQAo
 ElxA==
X-Gm-Message-State: AOAM530hQLkYxvB6dcKQIpb+YHqBxd5MvZpJOhWLy8cHMTcKMV+MruGO
 JMHMclqyraM3vJqLC2KyjQI=
X-Google-Smtp-Source: ABdhPJw9O1XpQSrqoTsTfkvUvMvp9nmBjI42VUoh2IFNkKkRbPlxaA3MGhhAXQfWIG6bIJYLrYSkYw==
X-Received: by 2002:a63:cb47:: with SMTP id m7mr2310226pgi.395.1606831466356; 
 Tue, 01 Dec 2020 06:04:26 -0800 (PST)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id w35sm3103625pjj.57.2020.12.01.06.04.25
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 01 Dec 2020 06:04:25 -0800 (PST)
Date: Tue, 1 Dec 2020 23:04:23 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: javier@javigon.com
Subject: Re: [PATCH 1/4] nvme: remove unnecessary return values
Message-ID: <20201201140423.GB5138@localhost.localdomain>
References: <20201201125610.17138-1-javier.gonz@samsung.com>
 <20201201125610.17138-2-javier.gonz@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201201125610.17138-2-javier.gonz@samsung.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201201_090428_510875_C59D487D 
X-CRM114-Status: GOOD (  11.67  )
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, kbusch@kernel.org,
 Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>, hch@lst.de
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SGVsbG8sCgpPbiAyMC0xMi0wMSAxMzo1NjowNywgamF2aWVyQGphdmlnb24uY29tIHdyb3RlOgo+
IEZyb206IEphdmllciBHb256w6FsZXogPGphdmllci5nb256QHNhbXN1bmcuY29tPgo+IAo+IENs
ZWFudXAgdW5uZWNlc3NhcnkgcmV0IHZhbHVlcyB0aGF0IGFyZSBub3QgY2hlY2tlZCBvciB1c2Vk
IGluCj4gbnZtZV9hbGxvY19ucygpLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEphdmllciBHb256w6Fs
ZXogPGphdmllci5nb256QHNhbXN1bmcuY29tPgoKUmV2aWV3ZWQtYnk6IE1pbndvbyBJbSA8bWlu
d29vLmltLmRldkBnbWFpbC5jb20+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1udm1lCg==
