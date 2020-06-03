Return-Path: <SRS0=Mmm6=7Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2456C433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jun 2020 20:21:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7136320734
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jun 2020 20:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AI9sGuGT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7136320734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IHbz5TsTvJ24+NreIoD2kdPVlU1/5C9bS81twgn8APU=; b=AI9sGuGTHjO5TVakAQiMNp4Vn
	u5FO+qefNXU5pjbOtakhGRScPI7/DHbVxuHYmG3syWW/IEBja2ojC+exAxbAFs9YOVUKf3Zznfkp3
	7/0ODHZPa7zX+PpOad+NSyHACbkA+C6sZ5EvjlWUbcKk5XuwPQBFFGxLDkv/k9YJlEbhXlrc5/0lx
	ZCGvWKK/LpVW0nixuSluN/Gygyb9+OMQbbO7SleCVqbxabC7Ran6I2QWr0Tqdc2jxSR/J4wYH6OMH
	6RMfIt3ER8TtqVYbcOaLKFyJP/CW7n57ZEtbQnlg0NYlDKr/WETr7eFwdhlgwxQ3AkRO1g3rNyYri
	qQhPUmxDg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jgZso-00041x-1Q; Wed, 03 Jun 2020 20:21:06 +0000
Received: from mail-pl1-f195.google.com ([209.85.214.195])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jgZsk-000410-Uu
 for linux-nvme@lists.infradead.org; Wed, 03 Jun 2020 20:21:04 +0000
Received: by mail-pl1-f195.google.com with SMTP id m7so1211846plt.5
 for <linux-nvme@lists.infradead.org>; Wed, 03 Jun 2020 13:21:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+KhrMhcJSvItbb/04gtqwcqQ9SN2qd7j6u0HCMyKS6E=;
 b=Rtg2SNgjyg+WWpTylVrZsSEMGyK8vVAR7T0c8JFspRancF4tEYvrAePr7vKqYYtYMS
 Fym6A0fzhjFVyP/jSRrD2z1JFBkcKWoiMAdG4ae4K0D/MHPNeQe7xsNrg4OaeKRvjtO6
 FGMU72Y0s9Wwr9z4UotUDZI8Y3dC5NOyl49iG516U0UXG6QWex6ZzBjtzbhK2AbzkODi
 wzuQXGKhcLnHdCvg137QXhojm7fo4KPPSdvv5LPnvemKtOdMq6RexuSYZjnQPj73WCSC
 HHwOGIRYhpwP1TtIMBXMPnuqM1AZvw6gEAoo8wbVZtCaB0RzjaHAwFL7YNQ39hoX+NCs
 IL2Q==
X-Gm-Message-State: AOAM531MIVlL6rUBjl1KzahZSzubkqIj33UB/Xv97U2EB/fi1ELdj7Lh
 7o8mQCGZZANEEOsRQ6/Xup4=
X-Google-Smtp-Source: ABdhPJxVJ6fKvvQLHhYWVAMYD7pVSO/io0/PxaM9nu1B0AvOKXyI09cS3qhkXjSHQzhZaT5FsY6wCA==
X-Received: by 2002:a17:902:e9d2:: with SMTP id
 18mr1538395plk.56.1591215661730; 
 Wed, 03 Jun 2020 13:21:01 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5409:1488:6d95:bdff?
 ([2601:647:4802:9070:5409:1488:6d95:bdff])
 by smtp.gmail.com with ESMTPSA id s18sm2536776pfm.90.2020.06.03.13.20.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2020 13:21:00 -0700 (PDT)
Subject: Re: [PATCH 1/1] nvmet-tcp: constify static struct nvmet_fabrics_ops
To: Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, hch@lst.de
References: <20200601170520.15207-1-maxg@mellanox.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8b4e296b-7978-e5a8-e391-94bc8bfe2657@grimberg.me>
Date: Wed, 3 Jun 2020 13:20:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200601170520.15207-1-maxg@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200603_132102_994401_003BCA3B 
X-CRM114-Status: UNSURE (   8.19  )
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
Cc: israelr@mellanox.com, nitzanc@mellanox.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Acked-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
