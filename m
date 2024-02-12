Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AABEC48297
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Feb 2024 15:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BaynTH9pMydfhvq1EdD/6Y3LrUBXYd3m2w1fILaHNjE=; b=Gzvgth3XkUrBA2fp1XFEFekuUF
	r57bB7021diL/WOsyVbfk0henWX0ZcI/o272IlyI1oL1wilKPI0lMbzbscbqg4e1BcwdUHqbPm7No
	VHc881/IrJIHitb49GoswTBBl/RqAc3Yc0nSNLvUkOS8/cgOEXHyAm5+JjYSpNWUGKFBnP8guPXez
	hU5zYtVYwR7y4DxNvMgXtXULYM2wXeMHFRteGDleGWmXm0yl5ZOxDqnxYjcNI0Cd6Ew/5P81GRHp0
	/6wYTCnTAzD9R57QLCc+B9IwSo/pKWU5Ejexd3TlRS1QpXuNIlxc8Tk1w50iSMiEv9YnuKSJYvfTO
	QJn5D2NA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZYgc-000000063Df-1kSB;
	Mon, 12 Feb 2024 15:57:38 +0000
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZYgZ-000000063DD-15ue
	for linux-nvme@lists.infradead.org;
	Mon, 12 Feb 2024 15:57:36 +0000
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-363f0a9cf87so5442115ab.0
        for <linux-nvme@lists.infradead.org>; Mon, 12 Feb 2024 07:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707753454; x=1708358254; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BaynTH9pMydfhvq1EdD/6Y3LrUBXYd3m2w1fILaHNjE=;
        b=3SXEr8cPDt1gdLV80Nd8G4/n46wg2577u7qK5uYomIdmDCjkECz1R+M63wy7GC1VwV
         fM3sX1F6fD573vbw72Hr296Ia7cLmkI5VWz0PkCX6tRdIhTtJo/L/V4dIEOC/wF3tAtc
         UB/uQYQeO7iqgyNstvV70tk1wZmm+BB50Is8r3Pw1B3YhCeD0hltu/WlUBV8i2M/tNSD
         a0lHf5wjhNhhVQsU7ioCtpStdD8/Pt2j9cdjTRBLHmQVvgBnB9SEHlhpNDx3HHMVozW9
         /NzMA8gLH/9pO1hbyg+vxk5HndLCjgjzZ9so7mgIXvu7vIz9Xbjlrdnbcuumk34GorTf
         /ZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707753454; x=1708358254;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BaynTH9pMydfhvq1EdD/6Y3LrUBXYd3m2w1fILaHNjE=;
        b=P5wuwIieeMKpV1MnoTjHW7GyuXYaCp9ziHmXhSMBeaLNL6tGST3k5U6D+UU5UdFQga
         ACyrIeU6bBuDQ/ZBfay80EM+EYC4gyEy6GdlTI5J/K3l9iSJzLHum0+Sx0zQELZM4qdu
         u1aP9CMUV4UcT+mYju6mA04cwjhbo6eknzv8xX3d5Hmgl4NyllbhckyWE2t5EB6fDIiC
         wB1lirW+pu3BkLZoixLbB/oAA9Qe4j/hanu05ik30PqGfvnJNdeBApxqxs/zAegWdcP2
         yPdA7X6ppbOPqun01hx3RKNhCU8tfMJ0uqey7vNhV6eYVCcN4kdNyyMM40Vr/Sk9u8I7
         QuUQ==
X-Gm-Message-State: AOJu0YzWTAgY/FNO2X25hNdK5g/7mXX+HrUebffmvSTPNl27f3MCGEN+
	QV5ypfZhQ+IwbSta2f18s8hWhGfL/1SLH0Hsmq2KjjeZig3Tqcc9I2frQbZHyC4=
X-Google-Smtp-Source: AGHT+IEfRx3FWxgGHWmntgqJQoFE7HENnxyzWuguASDfqyWZ7rcmJVU1YUwn3EUOd3+i552Y0c8+2Q==
X-Received: by 2002:a05:6e02:1d93:b0:363:d7d2:1ddb with SMTP id h19-20020a056e021d9300b00363d7d21ddbmr7164162ila.0.1707753454127;
        Mon, 12 Feb 2024 07:57:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVfxKtYa15lRVvNjy/1m9LMda5eb/rXCMv14SY9YWAJBPanw/6EKSm3pJDzUnNRU/XrSy5iO5trXAPgLbUYhG5+HAeg1/PdYVWyfE9THwyyYUqOyUkj9BNBrByLgRjbzwQwhkRhdIOu38wYONYxmSP9nEOjLJ85L0v4cnWNhTnP3yXDu1ZVmziLlJv+aS8vpPWb7xwrOhgIXZJPQPz0Xgle5WuNrI7xqeLMDiJcWokSMQ==
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id bs19-20020a056e02241300b00363f1de3813sm1960211ilb.53.2024.02.12.07.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 07:57:33 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: kbusch@kernel.org, hch@lst.de, martin.petersen@oracle.com, 
 sagi@grimberg.me, Kanchan Joshi <joshi.k@samsung.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
 gost.dev@samsung.com
In-Reply-To: <20240201130126.211402-1-joshi.k@samsung.com>
References: <CGME20240201130828epcas5p10bd98bcb6b8e9444603e347c2a910c44@epcas5p1.samsung.com>
 <20240201130126.211402-1-joshi.k@samsung.com>
Subject: Re: [PATCH v2 0/3] Block integrity with flexible-offset PI
Message-Id: <170775345334.1919824.14569482933790271087.b4-ty@kernel.dk>
Date: Mon, 12 Feb 2024 08:57:33 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240212_075735_337613_A5FC420A 
X-CRM114-Status: UNSURE (   9.97  )
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


On Thu, 01 Feb 2024 18:31:23 +0530, Kanchan Joshi wrote:
> The block integrity subsystem can only work with PI placed in the first
> bytes of the metadata buffer.
> 
> The series makes block-integrity support the flexible placement of PI.
> And changes NVMe driver to make use of the new capability.
> 
> This helps to
> (i) enable the more common case for NVMe (PI in last bytes is the norm)
> (ii) reduce nop profile users (tried by Jens recently [1]).
> 
> [...]

Applied, thanks!

[1/3] block: refactor guard helpers
      commit: 6b5c132a3f0d3b7c024ae98f0ace07c04d32cf73
[2/3] block: support PI at non-zero offset within metadata
      commit: 60d21aac52e26531affdadb7543fe5b93f58b450
[3/3] nvme: allow integrity when PI is not in first bytes
      commit: 921e81db524d17db683cc29aed7ff02f06ea3f96

Best regards,
-- 
Jens Axboe




