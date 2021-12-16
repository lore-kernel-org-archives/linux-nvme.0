Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC7EC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Dec 2021 16:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tL3o525SSbhSebgjQfZMQ7uigsMTO2fDpoEDGUF4HUE=; b=XAbhYCVWDXT5wFU3b/ANBV+d+1
	ZFxB/9Io/eKZCOQuMp7YYsyz5zkjnpZVnNZ1mmXlBE5XwTTmIN/iflUwY5O6ljqz0f8GbpV03pcOk
	aMvs2aQ0onnuk3l6oQ0nheY4nQqs06+UF1UHZCNy/RW9bL4BsJOrGwBiPRLarks9TQmlPjilO0uly
	OPVhZYPf1BhrM+tsbuc9Vw575QHASeLtax8UDs0/sGqcSP17ITjUTnAJ/5is96LE7O2nGerdiCAeA
	d6QxCyzkbLDsFemRX5h9PWLVC5aFrjfFCuOBaxCYGoYG0PnIvPAfGV7Wv+zNxHjdsceScWz9KjN5N
	Pr7AQXXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mxtGK-006TPE-2f; Thu, 16 Dec 2021 16:05:44 +0000
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxtGH-006TND-7D
 for linux-nvme@lists.infradead.org; Thu, 16 Dec 2021 16:05:42 +0000
Received: by mail-io1-xd34.google.com with SMTP id k21so35765917ioh.4
 for <linux-nvme@lists.infradead.org>; Thu, 16 Dec 2021 08:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tL3o525SSbhSebgjQfZMQ7uigsMTO2fDpoEDGUF4HUE=;
 b=0LEQNGb1bTHq9e+hYsc3l+U2okJ0k4nHCnm1dhpKeonjqY5/ZM5neoakgeOcnU8rMt
 pqd/Xs3gl8OfNB5zpWbbHRemeoSAhzx4OjzZC9/nUuQ5hNpz9f5iBm0955pOnS1isizS
 JAip0m3naR8v4h1fESL4IKpKKycnMHxyPGjlktYqX9o1oKPQgvGE6+BklJ58NVHSreeu
 pIxhC+CTNkzBhAgy0G4S4qMsOTW6SLnoF3binn+Y5vangPa3tr2JNByLyvb6RJlZUOSc
 Q6M4wLWZjHPSPDI/FLUA7mI2SPGwGpULFNf82V7VdpjkSXl9392Ow7vVukUVOmKvpL0U
 /eNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tL3o525SSbhSebgjQfZMQ7uigsMTO2fDpoEDGUF4HUE=;
 b=chCiI6p5f0E3XGSwW+SVCB3LoaCKd40NH4xCosrP9G12KjqCNrBh55NCC/qJ21+r+r
 L4ycioL35rM9dT+uNv+6rEgJlIDCSZIyu97mdgKpJXWil+kBJSY6tn43EOISXr0P+wM0
 /gptUjG0JjxHYzldYp30Trr9SjaDKlMONriitd5UjLAiMV75LEqbLvUgVAtGE1Pdqjb1
 +MhX3UqgUmkIEVEQCK3Re3Kj9OBVb5a3vR7ZWZOTBJoCRbdvAaPDWXkx3+nOT/FtWY7p
 xUaHmSw8KfgLXECv3ZsPTaAaqmlExu9j9xHKCu9g+lIkzSfYn5TJcKiEmmxlK1t7PH9a
 9pIw==
X-Gm-Message-State: AOAM531o6r2ZnQFTrt0EUdBRijVvLrPnai0OHAR8KiTUejm+/7Fo4jF/
 nSR2MILLgWPRKHv6DkiIkbsxBQ==
X-Google-Smtp-Source: ABdhPJyX8QJ18MhgVKKInSNZnCJnXEn3TufvHX3LuCasO/H2/ZZH4vXTozIHee1wM/MvTcWLkJaRoA==
X-Received: by 2002:a05:6638:3381:: with SMTP id
 h1mr10264337jav.176.1639670740358; 
 Thu, 16 Dec 2021 08:05:40 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id s9sm3237155ild.14.2021.12.16.08.05.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Dec 2021 08:05:39 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: [PATCHSET v4 0/4] Add support for list issue
Date: Thu, 16 Dec 2021 09:05:33 -0700
Message-Id: <20211216160537.73236-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211216_080541_284216_4CA8FF2C 
X-CRM114-Status: UNSURE (   7.63  )
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

With the support in 5.16-rc1 for allocating and completing batches of
IO, the one missing piece is passing down a list of requests for issue.
Drivers can take advantage of this by defining an mq_ops->queue_rqs()
hook.

This implements it for NVMe, allowing copy of multiple commands in one
swoop.

This is good for around a 500K IOPS/core improvement in my testing,
which is around a 5-6% improvement in efficiency.

Note to Christoph - I kept the copy helper, since it's used in 3
spots and I _think_ you ended up being fine with that...

Changes since v3:
- Use nvme_sq_copy_cmd() in nvme_submit_cmds()
- Add reviewed-by's

-- 
Jens Axboe



