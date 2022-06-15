Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13324C43334
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jun 2022 18:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+plJLyc6BfesKBMfyYWeTBRHfNx/06Fk1S03G42Wxl4=; b=lijwykW+m+Zs/+HyvnqHf1ESqm
	RqP7MAF9kHDQt8z8D5Q8r0WZS5r3dcgtM9pz+ghWioo0o3Yu3CBf/DF9Jy391CXT/Poff50LMIBvI
	znloMvRRj8jlcUDNpiIEhLrWHT1vQTHFhpW8ttDsaI5c/gdBdMOijcrT1mytQ2tcd7G0Rjg0ImMag
	XSHuV5KLHRnICmQ0DOwg+K5UyQAy6twtoCnUb6ClJL1ZbLE8vEeZ6m4EnFckdfaXkd0f/FzrmZMMK
	1RQDaYgsgxT/kObmHz8grxtfMPNrezqGMjAsX4BlHwabQ7Mz3FszXtAtOE2dezltA6d/og/NxZtvq
	gf6K7FDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1Y8I-00Fyhc-JP; Wed, 15 Jun 2022 18:52:50 +0000
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1Y8G-00Fyh7-Bh
	for linux-nvme@lists.infradead.org; Wed, 15 Jun 2022 18:52:49 +0000
Received: by mail-pj1-x1034.google.com with SMTP id gc3-20020a17090b310300b001e33092c737so2866623pjb.3
        for <linux-nvme@lists.infradead.org>; Wed, 15 Jun 2022 11:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+plJLyc6BfesKBMfyYWeTBRHfNx/06Fk1S03G42Wxl4=;
        b=mOjsn2omSJQYO+C6R1n+7Va36LEjp++XQfMZQgxSRdbtYoqgUjImwjvbQoccczC3ou
         OK/8E3yx+flabo4DNZPP1FDlsfa/wuavvcUMnn3Sltx0t+EsgbhR+8+fUuzNZZ0hYpzq
         SKKwvjXO9r8BlrtMxm+PVmnl7H+JWP6Jbc+dqBFR9NJ3BLGG9GSTUN4I54zr56QOoCKs
         4ungpINDDzuBJYu67AZtMp+9+o8ePw72rKL7PRdNedynU/LKR0Hl6T+u58qaycxXX29C
         QmvgsP/EpuWm5ZCAsm28B+TL8NqUFxoWWIONQQdGxDFOmalbPBJSnIbD4uHP9QeY+U6o
         MH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+plJLyc6BfesKBMfyYWeTBRHfNx/06Fk1S03G42Wxl4=;
        b=xyt1ufKa0P7wt056P+/wmEjkKRrtp4770HJsWtDO1XxSZSAoGdoG19HqEV+VkMFiEd
         L463fT8vzroaZVUUW9DMgm6UtGcwbPo7LjHPvNA+m1u/ZH0YZJD2QMZEPVNX7WS1k8Z+
         dROI7saYqLdY3uixFydTV+7FNfx9k8TXSBe5p6BzvUMTBVWCoGt5cW8UAvZrs8zdbvSo
         lITXinp+T/0AcPAyk3DQSguyf957QDwo0w2a5HKAPmHLRtgL0CmLiK2fQbTv95iC6epW
         d5EUONAoXr5jH7DY6cZp3zzNgYvOC2ezL2VddI5/RkX6a83YzKLvSTR3IJ2yqjFuu8Lv
         cfKQ==
X-Gm-Message-State: AJIora+UCr4aEUSm5Vh3jNDtJ7gkSxZKyU+eWbhCJgyyGOmkWareMkGQ
	wYFGybIhumHj5PSLZRWDUsnetliXtW+aRuZ/+kUA7Kx/i78tTA==
X-Google-Smtp-Source: AGRyM1uv162bCxcjTyRBxlF1tp1Zb5MwY4voLjUmqFzFiEHVLDBOmRp1rYP5BwTpxmjAgvK+XJFsN6S0SJ3kInFRCT4=
X-Received: by 2002:a17:90b:4ac9:b0:1e3:1dca:d995 with SMTP id
 mh9-20020a17090b4ac900b001e31dcad995mr856644pjb.111.1655319167029; Wed, 15
 Jun 2022 11:52:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220615180213.760756-1-e.velu@criteo.com> <YqonwfjE8BL6Xowf@kbusch-mbp>
In-Reply-To: <YqonwfjE8BL6Xowf@kbusch-mbp>
From: Erwan Velu <erwanaliasr1@gmail.com>
Date: Wed, 15 Jun 2022 20:52:35 +0200
Message-ID: <CAL2Jzux0ZnrJRocxj3X8YVwAb56krPtHUtKDnNqCURUJzgPoag@mail.gmail.com>
Subject: Re: [PATCH] nvme: Report model,sn,fw,pci device information during init
To: Keith Busch <kbusch@kernel.org>
Cc: Erwan Velu <e.velu@criteo.com>, Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220615_115248_438880_E724CBAF 
X-CRM114-Status: GOOD (  10.51  )
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

[...]

> The PCI_ID: print is misleading. That format usually indicates VID:DID, but
> you're printing VID:SSVID.
True.

> This is also very similar to the recently introduced nvme_print_device_info(),
> but that one removes the annoying trailing spaces if they exist. I guess if
> we're going this direction, just use that print, but change it from dev_err to
> dev_info, and remove the call on global id collision detection.
Oh I missed it.
Shall I provide a patch for nvme-5.19 or wait until the next window ?

