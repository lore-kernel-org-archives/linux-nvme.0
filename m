Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF58C02183
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jan 2025 20:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cLxmCJlbafkuvfH6Qxktog1C8CaKggnWioDyBY6DGok=; b=4PyfGz6EZsDwHhg7k7+ZjywK6i
	fKt5RD0xrjhTki08h/vWvaRuYlajchMWARCECKYUx+GUUE8yBH8/XoiHxNEnO9HqBMNiZkkyj43eX
	0DefIU6lZ+l13fH2wQ7WPssfiPqIeti9fStQg4FPU5eDvUgupFzvxXUzkSVRvU1+ztAWQ0/UlG/bP
	1yk56HldpXui8eez6tlVv+l2Ib1/aPROJt7yRMRuvmmvjd4U485SICqv68HnqsSJ4XQm7UUtcoX6O
	036IpKYD2xFEf0O+Bz++wQISlAF/HrMDkgLMY8roePGk9Ej+naXMHAsX7sSR4DmS7Im8ZAudPrIMp
	2YhrT81Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYsmr-00000001J1U-0Lxt;
	Fri, 17 Jan 2025 20:17:49 +0000
Received: from mail-il1-x136.google.com ([2607:f8b0:4864:20::136])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYsmo-00000001J16-34jW
	for linux-nvme@lists.infradead.org;
	Fri, 17 Jan 2025 20:17:47 +0000
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-3ce464e52bdso8619255ab.1
        for <linux-nvme@lists.infradead.org>; Fri, 17 Jan 2025 12:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1737145066; x=1737749866; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLxmCJlbafkuvfH6Qxktog1C8CaKggnWioDyBY6DGok=;
        b=EcuCmx3m3nUIe8OJCmYqJhmFWVdajvmLNWfqv5LRSZ7zWwLD2r6MeecDl8CIJ/ngif
         TKmPrSa+fstYl6tnHXyftt6ME3L9IdZY3WwxRZpIZ6UdWuWYb7vhJ9lNn251lIe7zSAh
         YQaVgBvOen/J9oXLnWFRTuejxpJI6x/hxXgxcAVZwhQEQvqVnPgPOF/oPjxEXkMBiIHz
         nVkCaH6TZkt2vmf3lsAAjCL5mq5924nllKLIyk63k6Enos4ZQXRcbX/LaXgM963DeR7B
         JIYu7G7EtIcdBDKdSKvaIAGu9JMPzysqEaN1Mq+E5YXI1/JUHRebb47FrcBnD6kVfIX0
         MZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737145066; x=1737749866;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cLxmCJlbafkuvfH6Qxktog1C8CaKggnWioDyBY6DGok=;
        b=Lg64Qaslv1oO79ohN49n5Hev86pUYFiCDGSELu/4C+uBpwBilE9PS32OfprDddNl2w
         xUxx62uIkO2lmyrzjyz+Y2i+iyv3UZBct6Ou0Z36wim80xcbT7P7m/bH92hoFF/kVji5
         bMBPcCbJ3DzNo5fPpi90NpFagfriMN9YJ8TDx3i4CpPzqXT9JkPfvU2XCh7xAP+1K6Ae
         rBTUI2AsqywfQeq64yqzMZx2gZbI15G34GPql08yYm6Vl4MPfXF0LM6FpYUPUkyKsdNR
         q1Rxytpmh/0KdZjA20N64Ld+F2DeuPPcTNISl8Uil0myjHShEjMvT48hI405Daxda1oj
         DAyw==
X-Forwarded-Encrypted: i=1; AJvYcCUMk/Cq6Svyf7Y4NYz+X35NTXgVQQFyRvIYGvU39XyDrTno0yy1PBJcWmLpTOLkSAkbHtutx2xCpiCZ@lists.infradead.org
X-Gm-Message-State: AOJu0YyjUdFZz+NEWKBKwIpPcR/Ru2zX/5leFnJUFZi8dwVQiBxeybXS
	70f+PMkFKnAx5arM2CeVbKBZwCpBWNRKhdzBXxpUFA5Fsf6FWWQEwZHWkvnWGvI=
X-Gm-Gg: ASbGncvChYNyjsN8iL1o9AheeUKCFGTZ80nbmQFmYM9N27JA5U/EEuwXZpKbhZf2EVy
	mwZUbDo50IcmKJigQJPN/V+SU9L2vfxovGRlZSXgI36DSpry3hYGABR+aMV4WLPphZrUP3e/xBv
	US2Jf90uHA4usCTLwyzvupplY1wWqhZ6vJ/yKq/IxJfdXVxuEBxmn57yn+0+Paz8wOGrObLaM6j
	02NulUAxD+PuGXJrcCAe6aobrJwPeA9wl8nLG55n1NsDKDG
X-Google-Smtp-Source: AGHT+IFKrGW/S+uGv2I4EYYiUbyKoOPoxLNw8UsgVKt5gU/rDXc3yKG6eiPIIz1vOQY4yFiQfe+oBQ==
X-Received: by 2002:a05:6e02:16cd:b0:3ce:f1b5:6d19 with SMTP id e9e14a558f8ab-3cf7447859dmr36866315ab.18.1737145065752;
        Fri, 17 Jan 2025 12:17:45 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3cf71b441e5sm7336155ab.57.2025.01.17.12.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 12:17:45 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: agk@redhat.com, mpatocka@redhat.com, hch@lst.de, 
 John Garry <john.g.garry@oracle.com>
Cc: song@kernel.org, yukuai3@huawei.com, kbusch@kernel.org, 
 sagi@grimberg.me, James.Bottomley@HansenPartnership.com, 
 martin.petersen@oracle.com, linux-block@vger.kernel.org, 
 dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org, 
 linux-scsi@vger.kernel.org
In-Reply-To: <20250116170301.474130-1-john.g.garry@oracle.com>
References: <20250116170301.474130-1-john.g.garry@oracle.com>
Subject: Re: (subset) [PATCH RFC v2 0/8] device mapper atomic write support
Message-Id: <173714506441.181264.7271209320638609494.b4-ty@kernel.dk>
Date: Fri, 17 Jan 2025 13:17:44 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-14bd6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250117_121746_778141_084F9C38 
X-CRM114-Status: UNSURE (   7.64  )
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


On Thu, 16 Jan 2025 17:02:53 +0000, John Garry wrote:
> This series introduces initial device mapper atomic write support.
> 
> Since we already support stacking atomic writes limits, it's quite
> straightforward to support.
> 
> Personalities dm-linear, dm-stripe, and dm-raid1 are supported here, and
> more personalities could be supported in future.
> 
> [...]

Applied, thanks!

[1/8] block: Add common atomic writes enable flag
      commit: 6a7e17b22062c84a111d7073c67cc677c4190f32
[2/8] block: Don't trim an atomic write
      commit: 554b22864cc79e28cd65e3a6e1d0d1dfa8581c68

Best regards,
-- 
Jens Axboe




