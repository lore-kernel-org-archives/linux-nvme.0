Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C33C87FDA
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Aug 2025 12:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=41g/9cH0APsfIUsqOHFdZAgoS+pLjh1fhvOleDoY0lk=; b=2kThylMcWj5KnQwDJZkL02XV+K
	qaPl34WWvZvKTQEweExDqDeq7gY3P2QEPR2nBgIUg8+9uuI1T3/b+faOk29K8oywI3m8n3pQfcVnu
	LePnqRKHwe5EMhZgdI5QY26sM1m1xgPKm28po7dv8LZqhjE6DFT5j4fja4lXieZlCAAihRU+pgxiV
	KJFSFBfVz+GhhL/wmjGnpF5WYv3Kbmj7BA1cQtoUvjYw7+vMNgkYe4Jv1yCu8n2T2DEMV0tgT5c8Y
	Qc8QpjD0qgDsoEP2QUeiHhlNzX6LYPFPuUDeofta80NsqdgTvhkMc8eToFWbCOsm7I0SalzlgriNF
	TTnn68Gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujzx6-00000000a01-0qsp;
	Thu, 07 Aug 2025 12:42:36 +0000
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujzjM-00000000XYD-1pwd
	for linux-nvme@lists.infradead.org;
	Thu, 07 Aug 2025 12:28:26 +0000
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-76bd202ef81so1279455b3a.3
        for <linux-nvme@lists.infradead.org>; Thu, 07 Aug 2025 05:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1754569703; x=1755174503; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=41g/9cH0APsfIUsqOHFdZAgoS+pLjh1fhvOleDoY0lk=;
        b=g+wXbbuZsCXy4WWuIvcn2HxC26alU/DHsaVfLRSgxzDWXx8cMn+aiYYObU1LujxbsF
         23K7rxbJUrAfrDVyxHyzbwYFz8RH7miAtjTLcCtlsIw2plnsBgaYu8ZMliIGpM8IBb1C
         yqVHifU+mio8EmDH5k5j+KjilEnWoMjoYCS1YPWl7WRAkrqEy73xJNla2rAs6+5qLN27
         EHKoXplP1d6/rCFfc4fUiRCpuzX8NqsOk4VhLTDxNTXFDZYohOPFFXha+3emWdMJE+fg
         QLKUs6toZ68qoVnO1avwaHuHIwQyCNhmOkb53dD8znL+doPc63KZBdrfGBacqF3qPbfK
         QSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754569703; x=1755174503;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=41g/9cH0APsfIUsqOHFdZAgoS+pLjh1fhvOleDoY0lk=;
        b=pdu0C++Zb6BPCoRXWNSmhtV3NEGDAJ/ayLfMToN8Bh/wsjhLefRsocveawnw5/4CN+
         Qr5wOFLATeGg6yjQf6l+v7ofu5KWMDsjtx3N/VjdtTdgQQz/0C4OaQ2kVpD3o9UlzYXI
         GFyNmNKu0kVVl3Vh7g/d51LReEP/Ss44FP+dK456/m+aMsualV3yHFzfhtCmgFdgqxD3
         pOiXEeB8jw5dpGI0XWKjFwIqpEzgHJ+3wTSg+7jbZtt1zCAXJBDvsyeaC0BknTgLL37L
         8HLATZmktnuY63ojPOeStPHt+r4sfiyL+6+p0soUlTYmAp3utewedz+ELghHAg6xQMMa
         Dnyw==
X-Forwarded-Encrypted: i=1; AJvYcCXhQTgEc4BZEgpGA5Nzcqhmt6570FQbTulnweQNDIJ2jO6oHpKijDgh5J8JgC2p+GdIMEBsdSbMhWAe@lists.infradead.org
X-Gm-Message-State: AOJu0YwKr61urfpQza66/s54TCNhn3OTB32oeMQmJOPinquyJpB1kGmG
	Zx+sFAxKmodSyIBY4jFbz2251gTN3MSaeHampVgyrHHlpNjIrYen798lVnW/5vUZXbY=
X-Gm-Gg: ASbGnctSt3/pzKUTPfbF7A4nzExJ0f7imb2lQhE7Ddr7aZi0KfUrbZ0s8Xce7WKnli4
	PqQN1OqxhtdbuGr2fJ6i+4RTBgCGny/gG/FlDqE2qlUrMu67PceBNxYlBRfO4C8IMiDj/w/a3O3
	GdewJRE+r9DWrvvIQjujnivKwXpr2zawAOKmDFujT3tXXgbBhZoM6q16X89WmEX9oztDxPtEB7b
	nnn4bBccz/GYCLCxMCO3nJrbj+2sjWwg8tKic88xtSChSJ32ruRALEqdefciHAGhzBuNCKloItn
	MDx0VUyjWQPKF15Mdx3+DuL7K1xPnLc1n/GxNt3hiobCnt7j1rfEgnqoFVQTePp6RvsN3Mwhpwz
	83RyXZ3eqEsD46pI=
X-Google-Smtp-Source: AGHT+IFZflKqpkXCxCNuCXe0IkTo0oWflze6NE8a1yQ9TivWCEJGMOIfgjBBvn4BOsd6MO76MkWDPw==
X-Received: by 2002:a05:6a20:a11e:b0:239:1fad:a3c4 with SMTP id adf61e73a8af0-24031252cdbmr10058825637.16.1754569703349;
        Thu, 07 Aug 2025 05:28:23 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c34d23f01sm2710016b3a.23.2025.08.07.05.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 05:28:22 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Yi Zhang <yi.zhang@redhat.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
 Keith Busch <kbusch@kernel.org>, 
 Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 Hannes Reinecke <hare@kernel.org>, Daniel Wagner <dwagner@suse.de>, 
 Maurizio Lombardi <mlombard@redhat.com>, 
 Randy Jennings <randyj@purestorage.com>, linux-nvme@lists.infradead.org, 
 linux-block <linux-block@vger.kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20250807053507.2794335-1-mkhalfella@purestorage.com>
References: <20250807053507.2794335-1-mkhalfella@purestorage.com>
Subject: Re: [PATCH] nvmet: exit debugfs after discovery subsystem exits
Message-Id: <175456970208.305227.5090103339122864119.b4-ty@kernel.dk>
Date: Thu, 07 Aug 2025 06:28:22 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250807_052824_722219_F1235D73 
X-CRM114-Status: UNSURE (   8.09  )
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


On Wed, 06 Aug 2025 22:35:07 -0700, Mohamed Khalfella wrote:
> Commit 528589947c180 ("nvmet: initialize discovery subsys after debugfs
> is initialized") changed nvmet_init() to initialize nvme discovery after
> "nvmet" debugfs directory is initialized. The change broke nvmet_exit()
> because discovery subsystem now depends on debugfs. Debugfs should be
> destroyed after discovery subsystem. Fix nvmet_exit() to do that.
> 
> 
> [...]

Applied, thanks!

[1/1] nvmet: exit debugfs after discovery subsystem exits
      commit: 80f21806b8e34ae1e24c0fc6a0f0dfd9b055e130

Best regards,
-- 
Jens Axboe




