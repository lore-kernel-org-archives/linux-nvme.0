Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F5CCC47DDB
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 08:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8CVz7mA8PTi/ouTdQChBOEuYLbOjA9OnouxrGstRWDc=; b=uwjx7C0yYJQUFgsBjI3uJ3FMc1
	anY8WYzZr4S845x2zY8k9SPx/dG4AEYlCy/gZKusstYssqPMEvu2ZYg3TFLyp0RiNqW+W3hyxM658
	BhqVyj+x6AyKsL5K0LXRLwoYtDEzi6O0g70in/SH8CY1XNtPY3/r1yCv1Tq9CfrJZeX5Qt+TVxFSr
	lOP8QGw+Z45qaJKCmvGnm28OFxgOTe3rs1YdpXHW5mFDP231JRLDCpeIAhFsScvGtTCRW7xse4vj4
	WQbr9/hTP1FbRErBgLa7jhT8iLKzs8iz9suiKpFrKOkwf8fV2olmJrcxM+jOMVjV2PsV8ofV5PKsA
	I898vDhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUMvC-0000000BkkY-2qlX;
	Mon, 29 Jan 2024 08:23:14 +0000
Received: from out30-97.freemail.mail.aliyun.com ([115.124.30.97])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUMv8-0000000BkjA-03j9
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 08:23:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706516584; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=8CVz7mA8PTi/ouTdQChBOEuYLbOjA9OnouxrGstRWDc=;
	b=NvxYsIMZRTELuMeim5soWcQ7VjfbAFrwg7wqc5nivrmsJKYoXAT/QVWU2YXWBr5DE15SuOUiB4u/P7LJRrtiyHeLVj31BGsgdZb84q4ku4EqNL7pWcZaeLX0d9TH3bDHt21xCLuyAvfmCVEQZv4hmBW8hqusFm8iA+2RYfUhpSQ=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R351e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W.YlJkT_1706516576;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W.YlJkT_1706516576)
          by smtp.aliyun-inc.com;
          Mon, 29 Jan 2024 16:23:01 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 0/3] *** nvme: add some commands tracing ***
Date: Mon, 29 Jan 2024 16:22:53 +0800
Message-ID: <20240129082256.63239-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_002310_844088_3EBDCC9E 
X-CRM114-Status: UNSURE (   5.32  )
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

Hi guys:
    I found that there are no reservation commands tracing and some
commands's parsing aren't fit the newest NVMe spec, and aren't readble.
    Changed as follow:

Guixin Liu (3):
  nvme: add tracing of reservation commands
  nvme: parse dsm command detailly when tracing
  nvme: parse format command's lbafu when tracing

 drivers/nvme/host/trace.c | 74 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 70 insertions(+), 4 deletions(-)

-- 
2.43.0


