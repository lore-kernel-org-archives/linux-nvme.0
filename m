Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D493C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Oct 2023 08:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:Cc:To:MIME-Version:Date:Message-ID:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=59ItUKeKAfQl6Pm0GuI2gI2GpUNLzTXJ8v/99uj7RTc=; b=JASZu7PbrnqMlYqBAEXwJVoDVb
	RTD3SSz6qllqAmxm+81+nehSYaqYXPumyR81pVvTW8BHw5SmUFRRbTQrV9+LxqMQHBZ+3m57sadCf
	qMC1NIxtESIxkJ4LMer2QoEw5rHIA1E1RQpxc95mSkJeg8qH6rqgC0VAusi3k4x/kUzyGCRx2vRcW
	AeA1x/4wP0f3pHzrNHSsBVHEhhoy6FoCzUkcsfXW296cPiawyM0IsAvfduGixQD+w2moANYHw0rw3
	sAx7XFA1NRdffKqjpZ5s74on6K9FSsWsl7jJ6hSDiAPHy0KgFsnhbsR1sP3Y7oRNtxCIzG8SGpZUU
	pFEgLbow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qxk0G-004kud-0V;
	Tue, 31 Oct 2023 08:21:36 +0000
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qxk08-004ktq-1R
	for linux-nvme@lists.infradead.org;
	Tue, 31 Oct 2023 08:21:34 +0000
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6bd96cfb99cso4701381b3a.2
        for <linux-nvme@lists.infradead.org>; Tue, 31 Oct 2023 01:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698740486; x=1699345286; darn=lists.infradead.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=59ItUKeKAfQl6Pm0GuI2gI2GpUNLzTXJ8v/99uj7RTc=;
        b=MafYtrFTWranD9N5iE1gOPQimxtd3fZwD4pqlT6P5CBVTcNp6iyWmk30mO/rmSy9Nz
         bF8QEia2utIShvQMQpgvdj9rAy+aRGIRnNXhXgKkZV6QCuvnNewjlbcCzKGyfEs86MSY
         LztGEH7YKRxXI5OpmpmceMRGaArd95S1Bim0WeWO977IIjfsQ9Aeoq8e5uWywDK8R3R7
         TrBpcsZqW1wjmNiy4yuEJCIcm4DZvTjieIjG7Ww0+jCyBQsIR6APM9riPQiom5SFHIT2
         1K6WIPixGZPT/K5FJV+v5QKsdwX5RFoayloXehbEyFTThqLAQHqV2rKFJz9NwqD9HEK7
         IHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698740486; x=1699345286;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=59ItUKeKAfQl6Pm0GuI2gI2GpUNLzTXJ8v/99uj7RTc=;
        b=IF2P7+d19jnJuXKYCcQ+bEsr2cnuoMqKRwna7gJ+MR7RbUkLuYqGfy5rB/6j035CfC
         Qffy2IcAfIcD3sy5x70uKVHRJD26bKJi5c4MEP8mR3bSs+mchRLWh4JoOk//9aJ9Wnfz
         SQGS+l6bC+WJYvEuCJ1UnoVzQ7kJUgWOzpzvAtygNrVH0pExdjoWOEuw0z6hgzfvOdb8
         QttanbYuM6C2Ll0zZLhXR6wBCpLxWVxIOM7n6Ak2tOq16+fzzOdcl3OTQHY1v1sdgrJf
         q2QBdYFXsUg6mYE7wdZHaduC96bA9UaVIq+yHyQ1QdsbffYJxtYdf04uHsIls3ofH/gx
         30dQ==
X-Gm-Message-State: AOJu0YzA7hRqRK+vknEJPzs6fO4SypiBNl1Ws2afxPfX4AaOGI63dmmG
	JVwFr7uoQre1D0esypzx+BM=
X-Google-Smtp-Source: AGHT+IHHBHVRJNDBt0RAGcu/t+Q6uNYCEvGjtPkxGzeePph6Ndp8DOdzVsRjMIOiIjmUcvhZ8C81LQ==
X-Received: by 2002:a05:6a21:7747:b0:180:f227:57f3 with SMTP id bc7-20020a056a21774700b00180f22757f3mr1149592pzc.60.1698740485779;
        Tue, 31 Oct 2023 01:21:25 -0700 (PDT)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id fi18-20020a056a00399200b0068fb8080939sm733810pfb.65.2023.10.31.01.21.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 01:21:25 -0700 (PDT)
Message-ID: <0e784280-02bb-4e0e-a5ae-4e0a40ea4c51@gmail.com>
Date: Tue, 31 Oct 2023 15:21:20 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 Linux NVMe <linux-nvme@lists.infradead.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, gloriouseggroll@gmail.com
From: Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: Regression: Kernel 6.4 rc1 and higher causes Steam Deck to fail
 to wake from suspend (bisected)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231031_012128_484687_45A0EA2F 
X-CRM114-Status: GOOD (  20.16  )
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

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> On Kernel 6.4 rc1 and higher if you put the Steam Deck into suspend then press the power button again it will not wake up. 
> 
> I don't have a clue as to -why- this commit breaks wake from suspend on steam deck, but it does. Bisected to:
> 
> ```
> 1ad11eafc63ac16e667853bee4273879226d2d1b is the first bad commit
> commit 1ad11eafc63ac16e667853bee4273879226d2d1b
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Tue Mar 7 14:32:43 2023 -0600
> 
>     nvme-pci: drop redundant pci_enable_pcie_error_reporting()
>     
>     pci_enable_pcie_error_reporting() enables the device to send ERR_*
>     Messages.  Since f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is
>     native"), the PCI core does this for all devices during enumeration, so the
>     driver doesn't need to do it itself.
>     
>     Remove the redundant pci_enable_pcie_error_reporting() call from the
>     driver.  Also remove the corresponding pci_disable_pcie_error_reporting()
>     from the driver .remove() path.
>     
>     Note that this only controls ERR_* Messages from the device.  An ERR_*
>     Message may cause the Root Port to generate an interrupt, depending on the
>     AER Root Error Command register managed by the AER service driver.
>     
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
>     Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
>  drivers/nvme/host/pci.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> ```
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-6.4.y&id=1ad11eafc63ac16e667853bee4273879226d2d1b
> 
> Reverting that commit by itself on top of 6.5.9 (stable) allows it to wake from suspend properly.

See Bugzilla for the full thread.

Anyway, I'm adding this regression to regzbot:

#regression introduced: 1ad11eafc63ac1 https://bugzilla.kernel.org/show_bug.cgi?id=218090
#regression title: Steam Deck fails to wake from suspend due to pci_enable_pcie_error_reporting() removal

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=218090

-- 
An old man doll... just what I always wanted! - Clara

