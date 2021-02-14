Return-Path: <SRS0=P1pc=HQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718C7C433DB
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Feb 2021 07:31:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB3DB64DCD
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Feb 2021 07:31:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB3DB64DCD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Qj99JCSgdDBqOIOjSJL5s9Vk+8YHwF9Jariryj8cf7o=; b=gnR2a0/qb8sH+p+Vun+Cv/vei
	xSMj+sR+PQv5rEMmXvjcqv7zaFl0oECY5NpA7Xlk/2ZcD3ZzMJysNNMaUONeQRAfYeUYQ6Gl4EE6U
	IPuYl7IbatXRtSjUSgLzYGlOl3Y0xAuDvWrxFKCkdTjPdPuJNdZUAOJy+BS9DaMM6GxuWfDZkN9Gd
	Vv+HdoEPi4UR+io0NATFVdpkilosKxb1YGAQbTQpY7O7CrcwJL36noSbI953JRovCtRXkrZO7JtQ5
	X1Inzt7VJ6bf1By6bSEPRvJPsrCLR9ln7Vht8CiQHZYSDpO12Tzt6k6gOP9shdLM/GAzZsBNkhFlw
	HF9MQmW0w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lBBsC-0003Yf-6Y; Sun, 14 Feb 2021 07:31:16 +0000
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lBBs5-0003Y3-69
 for linux-nvme@lists.infradead.org; Sun, 14 Feb 2021 07:31:10 +0000
Received: by mail-yb1-xb2c.google.com with SMTP id b10so4048706ybn.3
 for <linux-nvme@lists.infradead.org>; Sat, 13 Feb 2021 23:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=L0NFRMoCIBg17R5WvEqGuR3xkawgs31RwTgIaRPst34=;
 b=dsVHVGbtHkov8jBqlz2FSgwta/3qkQr6mHHhp0x69Z8ZWLa836pVL8+eHt72/hhcBI
 l+jCG8n09/sfS/dqnWaokD2BJ7D+zbExgeaKGimKDz+ttZTyFiRTxZa4jqbDBOoetZ/8
 DNKS29n8PNjoFFS7iqxjQzopUSZXVemprP68662kBW7GlUn33sWPVD7kjqB51fpLs5Os
 fl1Oe1+aWci/OwxY/xl4c+A/I8yJlwmUyNwkNzsMN5oD5Jv+wuhmYp3+B6xPrOe08DGb
 dP5XymjiwNuVpZBoXxalcbzzYkD2x53HEPSr3iUwK73hWPjPZElEYsDzHJx9XhIuX3Ai
 2USw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=L0NFRMoCIBg17R5WvEqGuR3xkawgs31RwTgIaRPst34=;
 b=O/J+5GFNyYIe6IpxKPWsylQ7MTlDrp37Oa8KcnuW04BvT40hUgyFCv42dzoBm9eKy3
 LdUQ6pxAxaSJV0F8nUQ6RqAOS6EXVyuBllWpIDiM3aq3iT4yJ7FHpVRe+/9AbH8rHEAV
 h5uyVZRS3Ybh40uLDk7i19YUcJ6eJSavfSge1XtQw3lg4XzhmC/nLlR9fb64qJj007w/
 wu6Qc/fB436bvJJAp1sYaJW1lZpwHCfA0PSTzhsz52ZPCVDebFgbrX5DQizDMSdi8gW2
 Pjri7ggCcE1Ok12dirxxFG9czQz005pMKqAPnWbHD6BPG0qAftWHW+GMMQ8YM6RSPLeT
 V9KA==
X-Gm-Message-State: AOAM531PZP+Tm5XShkGwFgMXLZXXxkrZAxCwd8fEwluUl2l6lfDCtmkB
 vdhT7NhxemkFaMM3Lnk6pzVLOQ9lDlQL+l7Mr6Y=
X-Google-Smtp-Source: ABdhPJxayp8Zt2wT/Mw2a6//3LBN8nDdADL915m2lPMX3ay1vpCHTqgiHlVD8f/oTBxu3HVrM1XFDyxjxRle/57GQUA=
X-Received: by 2002:a25:ae14:: with SMTP id a20mr4110229ybj.129.1613287861584; 
 Sat, 13 Feb 2021 23:31:01 -0800 (PST)
MIME-Version: 1.0
References: <20210212052031.18123-1-borisp@mellanox.com>
 <a18aaeec-049e-72c1-f981-3e18381b0f49@nvidia.com>
In-Reply-To: <a18aaeec-049e-72c1-f981-3e18381b0f49@nvidia.com>
From: Or Gerlitz <gerlitz.or@gmail.com>
Date: Sun, 14 Feb 2021 09:30:50 +0200
Message-ID: <CAJ3xEMi0574vgmHMt8LCe36RhH0XJg=LoTU2Jdx+W7+FWMmkBQ@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 21/21] Documentation: add TCP DDP offload
 documentation
To: Nikolay Aleksandrov <nikolay@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210214_023109_359664_055DE74A 
X-CRM114-Status: UNSURE (   6.96  )
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
Cc: smalin@marvell.com, linux-nvme@lists.infradead.org,
 Boris Pismenny <borisp@mellanox.com>, yorayz@nvidia.com,
 boris.pismenny@gmail.com, Ben Ben-Ishay <benishay@mellanox.com>,
 Yoray Zack <yorayz@mellanox.com>, benishay@nvidia.com,
 David Miller <davem@davemloft.net>, axboe@fb.com,
 Eric Dumazet <edumazet@google.com>, Linux Netdev List <netdev@vger.kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, David Ahern <dsahern@gmail.com>,
 Keith Busch <kbusch@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Or Gerlitz <ogerlitz@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Feb 12, 2021 at 4:11 PM Nikolay Aleksandrov <nikolay@nvidia.com> wrote:

> I got interested and read through the doc, there are a few typos below.

thanks for spotting these, we will fix them

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
