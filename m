Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 346BBC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Dec 2021 16:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=WuiksDPLX46rGvth8ZoLiIY5pKEIITYAcJQliALs1ec=; b=yLS2tBdUuFM8LAuZb4NvpnRRPS
	zhYe6WIEYZO+3eqkQCgpsEt1gXf7x5/kpiJBxsKOY+lJ1sTQlAtgsTTz8P5bCULbqqII8715/xG7Y
	HByO5NQksibeghYZn/xF0rm5qlm1uVeWKmIRzJPXbWsDNDHVq7aDh/0K/XLv7V1f/IpokNapyqMha
	q3jSn+o1tZ7iPpVE1gLbtBSci9mwNTEdCAwrucsFDPBNg9W7flMp4x4Knf3Y4PUT8Lv9jG0/+4fm0
	wjNtBA35TbJJixkee/fHmnBunUzcKb3boTbK8RobedNCbesgbEqGvFj0Dk0pOLU/Y12Ftq2bh2FRV
	/EEbUrqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mxtzG-006kHB-7u; Thu, 16 Dec 2021 16:52:10 +0000
Received: from mail-il1-x129.google.com ([2607:f8b0:4864:20::129])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxtma-006fl8-D6
 for linux-nvme@lists.infradead.org; Thu, 16 Dec 2021 16:39:05 +0000
Received: by mail-il1-x129.google.com with SMTP id s11so1165892ilt.13
 for <linux-nvme@lists.infradead.org>; Thu, 16 Dec 2021 08:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WuiksDPLX46rGvth8ZoLiIY5pKEIITYAcJQliALs1ec=;
 b=4kV/CAF4VTowFvtMxlL6qG65R7GTZCDJGnm57mJgsFe2IxB8sjZV4ldX32hYm+sutJ
 ucztWjponY482RE/7JFN9AFRkvMCKrbTQBjmmmfo1NMXX9S9YNdPU+CHcwGfQQUEoK2y
 W5bBpg2mcTEHGWaFOM2ES0EXhlrl95fUuwxsBEFoF4DvK3iP2gVzj3ho5eiy79YnfA2+
 +cBkEY26aWtKl7wG9lvddzHhQiClvUjIzl1MIYODSvVSchKeXNmLZeuZE71Gd5P/NRyt
 LeTY6kB4GSzQnzW72FYH5tFp/kSUKMoOpfnPjuLM6O8OxaePESKHpUF7djO+Q3dci1p/
 yvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WuiksDPLX46rGvth8ZoLiIY5pKEIITYAcJQliALs1ec=;
 b=WI3zJv/S/P2Tndbvv66GKgv03/VlzN3IMz/PwNPis2kZkDxtRT+m/ApUksha9vzOkF
 ubZYFsi+5IwuwFqL1Twq8v5gdsLTZcSin0ionmFUpKwfFhyhpQKtnuL/yX48vu0JuAO9
 cEWfa2llg+D7GUSEruInzuOqHN/KAVW8GoN9aSLVsHQkcNjcDqaFfX9UdD87p4dYNW35
 9kJIqvpvMkDYb4NoEn4GvzrF7aT4zDjWOkzBBQoaLcg1NGHQzQCbm95t7Q04Kp9KWTq2
 0V+LJymlypQLEj3Z4wuWKVx9MSb+bEDtq7+gUxpUStE7VpSWIjsiGcY5iMyoiZuusKQQ
 rhXg==
X-Gm-Message-State: AOAM531ku7eb1LUEKvQLkucfysdPZT5VGhyc9gjz6y/myXgRu32ndh3F
 xWMl/muTYi84l+7RHHEQe5c0ng==
X-Google-Smtp-Source: ABdhPJye2SGmV1G1NKox7Eax5N3l1SrMAtCAMBAWdWiCRRAjLXyT7evL1MC0E1nB77hJVO4q9ObJ9g==
X-Received: by 2002:a92:cdaa:: with SMTP id g10mr9703007ild.142.1639672743161; 
 Thu, 16 Dec 2021 08:39:03 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id t17sm71816ilm.46.2021.12.16.08.39.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Dec 2021 08:39:02 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: [PATCHSET v5 0/4] Add support for list issue
Date: Thu, 16 Dec 2021 09:38:57 -0700
Message-Id: <20211216163901.81845-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211216_083904_478781_782DD430 
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

Hi,

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

Changes since v4:
- Get rid of nvme_submit_cmd()
- Check for prev == NULL for batched issue



