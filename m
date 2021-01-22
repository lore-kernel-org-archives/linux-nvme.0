Return-Path: <SRS0=yPeo=GZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D3BC433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jan 2021 18:54:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B30E223AC2
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jan 2021 18:54:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B30E223AC2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:To:Subject:Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tPyFslUZu3HkwXyQnZ3z4N1nQ2N1eyouX6YqNJJ4+H8=; b=nShrZ2dEw2AVx/WR0aDjgZdsbW
	u9aEj+/uwURHRNFszTBiISkeXee7PHcDDISMFS4E6agF1YDl1W/3kweLP8MZe41AFkl4JRoCXQ4xL
	6qnGoMkOZHvp9SkanETPJomaxUckT9KuOxPowJKrIae9/2jH5/l8AB4F+3NblMS/4zPpmuL4bjUKL
	WGYDTMNI2jxRCrbCax7URFIVdNM9uCaN2xJHIfaRNksmriY+Tyn7L62BwZEbHZi+Rj1jC0evEKt9N
	ftwYNMuYTfVi+DpdwY2PWGxb5/b80uoi25qOGPtNoDzw9IcZB1n6XhzVVpt2zoLgb5nDR0/U+mqat
	YsgqL/UA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l31ZE-0004jx-VN; Fri, 22 Jan 2021 18:53:56 +0000
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l31ZB-0004iq-GZ
 for linux-nvme@lists.infradead.org; Fri, 22 Jan 2021 18:53:54 +0000
Received: by mail-oi1-x234.google.com with SMTP id x71so7074075oia.9
 for <linux-nvme@lists.infradead.org>; Fri, 22 Jan 2021 10:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=R1D/d2HaVyrgElVvHzZ3KRj61F6EJ/HkipBT4AxuGlU=;
 b=CcKV73o90klf15Lqu9SZSb3OimjHyIRMMxMTnvNZRqixsaLi4RZUiy0BD+yRA2XpPw
 bONLtWZEpXn4K9LQQSaQmr6bcnTAyetBYJaqCosvTUrjsWHD1KcPZKnWNYH2de9ahJEY
 42f7fK+xgUo5i0N1o36tpvMg0YtO8UVyeoFn7hqjnSsCuKsYcoVOT7FTgTAQlEsToMb9
 sLgRupEflVOjeKdRBFLvhuIAYV0f2BEyxeVoERhhPqMZJDSkOzysOpnsZwkUHKlz/v/0
 0ncUAofgBaki64mlzTedShoGxnzJRfJZHza1QYlcJhGT147lgYYQyN36SS7CX9n3neD/
 Eq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=R1D/d2HaVyrgElVvHzZ3KRj61F6EJ/HkipBT4AxuGlU=;
 b=m3fg2t0eaTxmuCZ7Wa79wxlP0xqsjKjf0+VeYz1+rvgLZ9Z1ZsuYbDBLVKb72j/U6a
 Jy28HS26wYItDE7+I+smaPvGOvp/9dYb7aL5YPfnN0sT77ALJqsdnGG4m+kQ+NT8F033
 Bkvqe+1vmIGJUkYENETpVTxN2Vy8NfyDhlcWlp1F5ctym+PA59669Lah8jMUIbKk/GRc
 AaM7i3+kPaqe1rCRYEBAOaLggbiq2rOBUDEPYGwXpvYwGL5kBMkTVvf7gHid02HfL1S9
 lzuMrU5Z3C4iVIs29vpO4St8a9cGpAqMvCe/y6kXgrXbA/EFzlQnv7h3wlR/OQxqVOeK
 rs0A==
X-Gm-Message-State: AOAM532QwE/YmdYV2w2VDn3BjBxO6NV/foQIWHqKD3+TbAeqp6uxY+QC
 XZShDplx/E0ssa+CQWffYqJ65FPiNlgct5dQws269UyaZF4=
X-Google-Smtp-Source: ABdhPJwrmTLxHb1PvVQwra0iWdhjb1fSXxmHYDrNUs8EciUP372RDfwzC5FrxAviG2dS+U//eImkj06GndIJHyvjs1U=
X-Received: by 2002:aca:5ec2:: with SMTP id s185mr4337153oib.11.1611341630161; 
 Fri, 22 Jan 2021 10:53:50 -0800 (PST)
MIME-Version: 1.0
From: Yogi Wannabe <yogi43222@gmail.com>
Date: Fri, 22 Jan 2021 10:53:39 -0800
Message-ID: <CAGSHeY1TRkrcpnYYJhkuD9A1Qvn9vDYQh5yC=y+6x4wj5_RqKA@mail.gmail.com>
Subject: Peer to peer DMA
To: linux-nvme@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210122_135353_553949_4E51C0AF 
X-CRM114-Status: UNSURE (   6.84  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi all,

is it possible to DMA between two NVME SSD drives plugged into a
system with Intel Xeon? If it is possible, how does one do it?

thanks for your help
Yogi

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
