Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50CDCC4828F
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 21:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DKsfim+MSI6UjpZNmqlpyaYz4vfSV3UB0ihkiyu43MQ=; b=rRiBQUhaQJngAzWzSAzkWEvcPv
	eIeS8tB0La/9b+EMoaiXN3dUFo2IDgMehHLrx6jrZMbO+rU7KE4nHfHHgFc3VISfDqEenAzKF4pF3
	+6AF4a3O3uvCdW4Eyb8vcinc/bBXKYepi0WD147u4CoZNTN+MuLjsbCcYRgmbThujhhQH15EX6lRA
	v5SpbdpbyW05cVkrppGw/LjWFkUCVpdPHQh6Xqf7NsDx5/NlulmV0Uyn51SbY8QnXL83lvIC25FdR
	fSZ5EjPjigGKkpjsrO6ad6JlccXAYxLmNDRgMtKON2hP6C8KDsHS3TEqu/ll7lQNw0rUSJ0mOP1RY
	1RCa7z9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpf5-0000000Bx6U-2cBZ;
	Wed, 07 Feb 2024 21:40:55 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpf0-0000000Bx4A-3sV8
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 21:40:52 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1d51ba18e1bso10485085ad.0
        for <linux-nvme@lists.infradead.org>; Wed, 07 Feb 2024 13:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1707342049; x=1707946849; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DKsfim+MSI6UjpZNmqlpyaYz4vfSV3UB0ihkiyu43MQ=;
        b=N9OkqduoVcX9lne2UlBoD71l+0jwhYZI72zTlfYILhN+7uFUW0Cbn28cFcUXpA1g7h
         yhHYtx6eqn22/T7YcZ91iQzc8myr9by7Z6P51zIQsVjnh1A9/1UWi2tD+mtn0mDWXdA/
         ptIE3LOGbLrVIT10ehAbFmnoBmxTqFMp864fL6qMlEPZIy+B/1ZvpL0Q0b3iWNCGmssR
         bXqGy1YZJEjS0mTHYm7h8PpqbsDN/2NOvgQm3GgwEXpRGB80iI/zFR65tE6Rs7Ltmlgt
         To8lsopLyhHz9Gjr6EcYxr2TAL3axwuezqHSzrwJ3ypNlP/+UTTWDAfigVYdvm/ncvDE
         65Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707342049; x=1707946849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DKsfim+MSI6UjpZNmqlpyaYz4vfSV3UB0ihkiyu43MQ=;
        b=fgOVRhaxgDI+oUpmuldqULCKnbctdnsibNISijRO+JCmmorZATLiW3kzaGSya3ZLxI
         +CrsnmfrdqFBlNe6WXZjnh4ZbnYwPkG79YUUrzBHI9ZdUI+77Jj40ZtMb//GPO8GjfFI
         0aJKQZ6JNFzNIJVgi5IqXtQtEcLib3RiI7OPusgFZ5QR1/c5tycADt7gtD3+4b235cYP
         s9p2dTDeW+FT7DJgZ2faM2eQsi2v1r0ZOhNvwJP2edDhlPC4T9d6aH2YxesWfNFWgA4/
         AiUXlR4fGP4olLVbqwdD885j3Q4L7V7r+sDDQpEqtRLgUJJtIdCnLRXu/kzQwVxZQ0M2
         8Qrg==
X-Gm-Message-State: AOJu0Yw+uqbsFiEzSzbe/j4dRD2M002Ib4+btD4EIy2NtOznp3k5P4wj
	TTAP1A2SLVJSzABAO/ZO/Y6acIphsPodLYA0zNIzofpmd0MW8hxwRyWTnDtK6FY=
X-Google-Smtp-Source: AGHT+IGzcfJjDrlQ3m3xG0S3FFHN5hJI5ZgJviqgozjKBF9cKRwKUbPDUr9rgvJSwArILGQ5I4xSiQ==
X-Received: by 2002:a17:902:f68e:b0:1d7:b1f:be9e with SMTP id l14-20020a170902f68e00b001d70b1fbe9emr7868371plg.66.1707342049073;
        Wed, 07 Feb 2024 13:40:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXzxAVg9C8dvg5lch0yxQfD58BLbbO1S62+z5OCDczERkDdNxFNbl2djCpeq7OfIJ3LZULfLEeqK1pib13zmOZAOr/ard2iIufbG1sNhDqq02mqc50r5QPp5adurRjvTrnSH49PCpewFHZ7QLw16coCzcOLgdw4dyRA3IxiXYDSAv3TV53LT2TVADArtfOeIau5d7ay45rJH14KisPMCtq6Sn8gWXyNPUCsb62hyRHm0V1fFBsSwBfuz+oXbSiFXirG1SJcXlYdUssp
Received: from localhost.localdomain ([50.76.39.125])
        by smtp.gmail.com with ESMTPSA id ml7-20020a17090334c700b001d7274cbd33sm1939005plb.121.2024.02.07.13.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 13:40:48 -0800 (PST)
From: Jeremy Allison <jallison@ciq.com>
To: jallison@ciq.com,
	jra@samba.org,
	tansuresh@google.com,
	hch@lst.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com,
	sagi@grimberg.me,
	djeffery@redhat.com
Cc: linux-nvme@lists.infradead.org
Subject: Make NVME shutdown two-pass - Version 6
Date: Wed,  7 Feb 2024 13:40:39 -0800
Message-Id: <20240207214044.2374295-1-jallison@ciq.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_134050_999593_735B0C2E 
X-CRM114-Status: UNSURE (   8.78  )
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

This is version 6 of a patchset originally written by
Tanjore Suresh <tansuresh@google.com> to make shutdown
of nvme devices two-pass.

Changes from Version 5:

1). Function nvme_request_shutdown() name changed to
nvme_ctrl_shutdown_start() as requested by Sagi Grimberg.
2). Git commit message reformatting to 75 columns
as requested by Bjorn Helgaas <bhelgaas@google.com>.

NB. An alternate patchset from David Jeffery <djeffery@redhat.com>
has been proposed that covers much of the same ground.

I'm happy to collaborate on merging these two patchsets
if that is requested by the Linux nvme community.

-------------------------------------------------------------
Currently the Linux nvme driver shutdown code steps
through each connected drive, sets the NVME_CC_SHN_NORMAL
(normal shutdown) flag and then polls the given drive
waiting for the response NVME_CSTS_SHST_CMPLT flag
(shutdown complete).

Each drive is taking around 13 seconds to respond to this.

The customer has 20+ drives on the box so this time adds
up on shutdown when the nvme driver is being shut down.

This patchset changes shutdown to proceed in parallel,
so the NVME_CC_SHN_NORMAL (normal shutdown) flag is
sent to all drives first, and then it polls waiting
for the NVME_CSTS_SHST_CMPLT flag (shutdown complete)
for all drives.

In the specific customer case it reduces the NVME
shutdown time from over 300 seconds to around 15
seconds.
-------------------------------------------------------------

Jeremy Allison
CIQ / Samba Team.



