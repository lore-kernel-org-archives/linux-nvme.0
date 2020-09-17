Return-Path: <SRS0=U7CH=C2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9A6C43461
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2020 16:47:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73BB621D41
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2020 16:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kVE2PGYx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+tMZqnS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73BB621D41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=eVz6xNn0JITjmZdkXx8BWnGU6ZCpC4Qa997MggQUuWw=; b=kVE2PGYxeZq6ki9G55upZBs8X
	PRuGBBURnKLJPtQUyyajncR8N5MpnO6gQ7gyggZZc2OKjJYvOE765Ta47RmdmlZwmLoSE7J9wUtW0
	9V61nRyBObfaZTjnXMyUQ6ICkZePcfHtwJAQ+vU9inF8+ReVxJNNWd75/A1Skk7YtBaQsoqX2RJUx
	IhnODNf3eRdZDoOltWvADEsNhEUMQN9/myEPe6CGb2epLXivCdlvthElfOc6nOwriUNiWl3LFWTYU
	oGQ/DY7YeCKN4L/1QnWWt4QfWvT6uKzimkVCUbZzvhXBw08o5wewJz7ik0H4l2CCDQcoRWBE9Ffq/
	lmldmXV4w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIx4G-00061C-Ar; Thu, 17 Sep 2020 16:47:32 +0000
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIx4E-00060F-2a
 for linux-nvme@lists.infradead.org; Thu, 17 Sep 2020 16:47:30 +0000
Received: by mail-io1-xd44.google.com with SMTP id m17so2971629ioo.1
 for <linux-nvme@lists.infradead.org>; Thu, 17 Sep 2020 09:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8pgAA/WpOQRvkDbPbejhlFgwYQX/Y8LSYUhned1NpM4=;
 b=N+tMZqnSnBMY+bqSaCx7oG/CBsUDqIQ0XeCE2Z4hKuYXVJd/FLlibFktzPFyq1FMhr
 ClR0oplrNWyUI0S/RHZYpwt9yuj6KPQpM5Tat7rmEds4CU2HQTXyMfdq7uuQFCgIPjox
 s89UW8oegaTp64M/0Uzq7OTla0cJkYu4SWkEJn37Uj/bdQL/2E8cIuaDfB9ZDm+/Ws0m
 n7sNZUYLlWHkfUp3F0bTqjjE894eRWflEZ8ARuTMVOB3cj93SDcW/67uF6WglSYCciZB
 CTICbZGHhbUP1/H8oX2cSX6IMBurEG1DG1QK4TbkkoK7pthVkFOHodF7l10atqJzS2O2
 9DuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8pgAA/WpOQRvkDbPbejhlFgwYQX/Y8LSYUhned1NpM4=;
 b=J6PZd7P3U/tYTjw5H3Qz1YoUOZvkys0TjoWkP/gfsHvxPE0oNXGWEC79efIwo5BUHq
 DFnW0CbmcbV6xT5GBt1u+Z68gXtoAoRgCdiQrbe2gJX3OhB4RyFPDE1rP+bvnJo66KET
 l0BDetIWS6J8UQWP+5uWRYvyglgrjDN/zZieRKf6xILixARWL+/TUxYyjSngbgIW/bw4
 8FWC5AzP3BHfwus+Msi8LyqdatYCsLMTQYT1B1iszqnfQWi0KbfnYXFWkHENShB2VER6
 T0OFivBxkHcBqafMBb2sOI6PT+zHVcmSvQKLWHGJwIagJ+ktTZGUZ/YRBAWC4mrf4i28
 dMKA==
X-Gm-Message-State: AOAM532YaUhgznWwtLXFBjbjSZCfiYokjWxIGmCPIUFSH1z3YcQ3L976
 vBTPDWQ5RU/tBKcQv0qQf+KMrBOk7AJYIffxeeI7iaUyC0fF+A==
X-Google-Smtp-Source: ABdhPJwrEOg9RGx08zwLZ9xxzoM9KK/jJNgUHWjAViLaeMtcsFCHaPu/K7kxRWJeDF7fkhNOV/v9KYanjnB2aJAgIH4=
X-Received: by 2002:a02:76d5:: with SMTP id z204mr25771896jab.93.1600361245956; 
 Thu, 17 Sep 2020 09:47:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200917155025.3795801-1-kbusch@kernel.org>
 <20200917155237.GA2441@lst.de>
In-Reply-To: <20200917155237.GA2441@lst.de>
From: Tong Zhang <ztong0001@gmail.com>
Date: Thu, 17 Sep 2020 12:47:15 -0400
Message-ID: <CAA5qM4A3gdyt1r-Bhm5NUdGRu5ON856RUa4gJeRUVLOXOrqOew@mail.gmail.com>
Subject: Re: [PATCH] nvme: return errors for hwmon init
To: Christoph Hellwig <hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200917_124730_120417_EE07B446 
X-CRM114-Status: UNSURE (   7.72  )
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
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks Keith and Christoph,
I can confirm this patch made the double free irq issue gone.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
