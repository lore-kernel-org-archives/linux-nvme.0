Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B279AC52D6F
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Aug 2024 13:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MglC5clNHdbSp55OHZ4udKN14Tq074u+E/zf5iWpN+E=; b=RG7LZrayxNFxIc9SZp/TVV6xP4
	PsoZwW9sFCeZcQhQ5gEK/J9UVzUy2FEzZGOPAN0V1loVHOxgUA2kPZmmC6bJyig0mbVR20xNeRRYg
	uJjpujDEkHi9PYmd5NDCmd4iDND2h6zVli9dyoOP068MJAr18nfcURzjLhcgDYztdEB+LPEA51/ct
	wxrHamDEy6bvSXPN+F6pQPd1mXjwqT1pFh9lKQfIHYiNZwu/V97yyWnwxcJdpyY6KgU+tbdA70Ex9
	I3+3uYeU3ay2qjmUjPYWK2FH5U0KuxVrr5EEcQfdCHTYHkTQkwDvM0zP1D/8mDxIbvQwCoPwngFfV
	G+pxg/Dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sc392-00000008MhC-3u91;
	Thu, 08 Aug 2024 13:25:32 +0000
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sc38x-00000008Mgn-0mpi
	for linux-nvme@lists.infradead.org;
	Thu, 08 Aug 2024 13:25:28 +0000
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-654cf0a069eso9335097b3.1
        for <linux-nvme@lists.infradead.org>; Thu, 08 Aug 2024 06:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723123525; x=1723728325; darn=lists.infradead.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MglC5clNHdbSp55OHZ4udKN14Tq074u+E/zf5iWpN+E=;
        b=CcRTbd6LsIrBHtQUIpYu0Ispv+/cAv8YYYG125apFTOhCBsMgjnOob6nk40glsp6PZ
         v5oHx8EEJLXx17kOmtpwfIK39tAMVXE7F2hqWvDOSyooifBuNEmaUf+SqpaoMO35aH67
         4DVfK0hdhw/Mz0xQxbOccJnUQ/ZEPejMLFyFVkpt/yUR6wx3kteGpo4byQW+0ijHUKiE
         KeXvoKkWnWHt0Uxadd6q2a9bg3SwcxYzCayjfo0anLeBXKJuysVDo/eOQImfXP3M9bre
         Yyd0DzJmTnPknGbMgAF1HDsgydCUN9rBHtU02GLr+dkbAGR/QAx7b2YOKx2Z720QHfsX
         1mPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723123525; x=1723728325;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MglC5clNHdbSp55OHZ4udKN14Tq074u+E/zf5iWpN+E=;
        b=myT9xcAs1tmN0YA/NYRUyj19+YPuHwETahnDuUpqOnFjLEaKKmxIQpfbOI8PNsYj7U
         EmyyX67Jwnp1B81I97AcvmBe+YGN2qNIme0r06Ycg+FhwN7H1QhA1gw9xpQ/rRdVPKep
         hnapJnCiGjA61t7sLtRtNrLX8JdsURQM5p8S8gBmOqhTudx0OVTTg6VlPo/AN07cCLEW
         HX9f+Yqlkmta19nqdW0HP863so4KsArXn3zw9f5490Lp+UoLT2vlvHpFnTWZzLUW46WK
         9LQicJ36n8pAfeLyZ/uIMBdg3LjWAUAYizPPE/zMF0bxRAutVSoIxGZcFcSUcxe59Cyt
         VTUA==
X-Gm-Message-State: AOJu0YxqxhM2ugDjpYLRof1YnrRQL4xkm9fxMicT5LBCJqAFRk4U4i5w
	+PjwuFMgmkRy/0/NLXQsTzcWKQOsNs6XsBjAQ8Rg2815OWw9mxkZcHiU1ChB3exKBfh8Tfz1tCM
	644yxmTgdj51rsWmqAL/E40hTl7Bb8snU9OI=
X-Google-Smtp-Source: AGHT+IGZoyBvhJJaNnM/EzpcwAwjgqnNnlLA/qQaFTis16NjOvIQ5+fii/X2vreV2YLAv9Swtur+BGNpuu/YTkgnp2A=
X-Received: by 2002:a05:690c:690c:b0:665:657d:9847 with SMTP id
 00721157ae682-69bf77327bcmr20812887b3.13.1723123525450; Thu, 08 Aug 2024
 06:25:25 -0700 (PDT)
MIME-Version: 1.0
From: Dileep Sankhla <dileepsankhla.ds@gmail.com>
Date: Thu, 8 Aug 2024 18:55:14 +0530
Message-ID: <CAHxc4btbwU7z1AhYqUBzTeuULpRZbZpDj5Zodvr_p39FNPi44A@mail.gmail.com>
Subject: Bug while creating the first i/o completion queue (NVMe over PCIe)
To: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240808_062527_247411_D764A586 
X-CRM114-Status: UNSURE (   3.80  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Raam Raam sa _/\_,

can anyone immediately help me in solving this issue asap:
https://github.com/robstat7/Raam/issues/4

Regards,
Dileep

