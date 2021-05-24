Return-Path: <SRS0=dfbP=KU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA04CC2B9F7
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 01:59:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84B5061209
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 01:59:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84B5061209
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mxdMT/Mg+vUfQnw3oNNBdDwv/9Ya6jtle88vSpXiTuc=; b=Y7HG8UN44H2ZTn
	FLZO9X4dTY8kRCgSH+Yszrj6RMSfu1RcI2s90T5pY9t65L3z2VaSnvIS2+eh8cEy4y0kRQ0t6pkje
	s7XlK38FEUVhisCFVRk7c2of8p/9eqR8jTFwslbfR06o28WEULgRQwQu7rfUV1cgaxXJ2xrbxaBsU
	st+/cmR9MFB3r9JgcbO59cqcArisSdrCwuj6SSFBNpYFlg1g4reHsiUMw7nJ8WSQajA6V+BnXfLvu
	rEEF6FEM6LkjcXvZ7dFi4PLhu/KHu72quSLjHty7OiW7ecmKQJ4lG5hSkM2y5CJm3kwuR8RfHm+hd
	iJJT1sQWhNZDXf0+k39w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1llMLZ-002pgM-Gu; Tue, 25 May 2021 01:59:05 +0000
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1llH1f-001oGS-Kl
 for linux-nvme@lists.infradead.org; Mon, 24 May 2021 20:18:13 +0000
Received: by mail-ej1-x62f.google.com with SMTP id f18so13534120ejq.10
 for <linux-nvme@lists.infradead.org>; Mon, 24 May 2021 13:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZW8cCiAzHyHOwo3G4SSuR3ks7aYQun1vtH9zKbGIGuk=;
 b=vIJLXNbc9yDAo6QEQH9QWf4Z22/sQx5haK6JrsiBGwopXQSb3KEBU/qP+MV95muAuo
 xMqVZCuMgOodmvj4wt9A3oLssA/4E+rdJxpYOiZVaSJnO9MiXHquG13cwhiH0eokTufD
 noU1KIP0963N6ljBb4QXwWVpTmTqJLplxYpZIL3mBFr/BJahwerOUUrcdvNe7wi6YLcf
 hr6hpEpeld53rKuVINqmQscvIygKxNSrgzbsqs/LQu7uCJ6K6oG7VTN3bZgAVurry29m
 ZxosufL0sqFZnO5Fa6R61sM+6hTH04wTm2twzvsB0+9xIL5tyKSwm5NP3TqPqTAZOmYi
 MNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZW8cCiAzHyHOwo3G4SSuR3ks7aYQun1vtH9zKbGIGuk=;
 b=gMDnHOl3Q/1fxXBWUQvpErLz2rL8JBwBuYN8Gqa6bEwgR1bEAn7Qs//TxSOKP1Fwr5
 qY7LDliTzJ9L1Y82yvDRebsb8+dwvQjk7dxLjQKki4bRwi/XEVnCHw1Mgvi9ytjwTwIU
 h99Wo0f9Ic65bXQgQPSNdIQNtGM0t21BM0szt2XkcnvJTBO5lLn4hF9gcgqM6PEEzqcP
 FXAG3TS4plnJijbWq8/hCAT+lWDQ8L557mKh/pOwi7yO1Xl+VnJKGQHO2TmfdpHw3/2a
 VMUdz0M5Hu7YX1ebpuhkPA7KcxaJUa7w2NYOhk3m16DUwh41RuAOuu+tOjBAMtKrUqfx
 Onig==
X-Gm-Message-State: AOAM531XGm9uXjYz26kAENVl/l/huJxT3xbAhx+Zu/pt1jFJYMZr2Flg
 qiHXGJ0ZmhJJfjbFqSViRDPKEYW6aczf0ZMKtB6khVTDpRs=
X-Google-Smtp-Source: ABdhPJxO4DbvD/i19lelK40wBRTpdS5grbN28GfxNDNeB7glg+/HsGKu90dDD4CnW9jQyw71c2ZcPKo4Mz6CcOBXAV0=
X-Received: by 2002:a17:907:76e8:: with SMTP id
 kg8mr23522257ejc.130.1621887490023; 
 Mon, 24 May 2021 13:18:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210519111340.20613-1-smalin@marvell.com>
 <20210519111340.20613-9-smalin@marvell.com>
 <34e4a50b-4075-2364-d654-4039564f43ff@grimberg.me>
In-Reply-To: <34e4a50b-4075-2364-d654-4039564f43ff@grimberg.me>
From: Shai Malin <malin1024@gmail.com>
Date: Mon, 24 May 2021 23:17:58 +0300
Message-ID: <CAKKgK4yyf=o4S1c3svRzFoR-mhc9MUP2QGyu6aB3e-8nmW5k6Q@mail.gmail.com>
Subject: Re: [RFC PATCH v5 08/27] nvme-tcp-offload: Add Timeout and ASYNC
 Support
To: Sagi Grimberg <sagi@grimberg.me>
Cc: netdev@vger.kernel.org, linux-nvme@lists.infradead.org, 
 davem@davemloft.net, kuba@kernel.org, hch@lst.de, axboe@fb.com, 
 kbusch@kernel.org, Ariel Elior <aelior@marvell.com>, 
 Michal Kalderon <mkalderon@marvell.com>, okulkarni@marvell.com,
 pkushwaha@marvell.com, Shai Malin <smalin@marvell.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210524_131811_724133_E9F4C519 
X-CRM114-Status: UNSURE (   7.22  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 5/22/21 1:51 AM, Sagi Grimberg wrote:
> This should be squashed in the I/O patch

Sure.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
