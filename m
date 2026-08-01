Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E3AC54FCD
	for <linux-nvme@archiver.kernel.org>; Sat,  1 Aug 2026 06:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8jsHQYZsIv+UEcM/v6JhPnpCp7qXtARbFHI5o9bFxNg=; b=Jp2af0REUSQ3+zkh+cZkavJ5j1
	2Akf9ajxsfAnSfK3rsTCjH1aazeBhltIHfwzIvERDd3wrNB2iHE9NPxauyrwIiCWwWnXyPSO+Csgv
	dOveEIVr9+23ffYpmzW7YyHcJSI1nm2ADGtrGf20S8Vv51S3LSHSA9e3sSBlp6uKMi+YIujOycwQF
	uttEv15NM4Yprr98zu03GyLztGjL43usg78h193r8ClhoNqwtQcDRicrpSCVdO5Juv5IiIULyt2S8
	cSP9ZATsK1b7UAJjMbTAyR2iRFxEPn97M6tFvKjuxf8TxgLCY2VQZtq4agK1NsD+2UmnVW9CQkNvD
	ipqgC69w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wq2o1-0000000DvWY-1Co3;
	Sat, 01 Aug 2026 06:02:45 +0000
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wq2nv-0000000DvVa-3yBB
	for linux-nvme@lists.infradead.org;
	Sat, 01 Aug 2026 06:02:41 +0000
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso1404037a91.3
        for <linux-nvme@lists.infradead.org>; Fri, 31 Jul 2026 23:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1785564159; x=1786168959; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8jsHQYZsIv+UEcM/v6JhPnpCp7qXtARbFHI5o9bFxNg=;
        b=ZhSas4sJlJC0FjtUHYMCfqDlmePt4ZNBh25ByXxMCjRSdfsa9O51hFGVyhLg2Br++o
         xymJ1K5x1sxYMj7fiuD4G+BXTon/D2xNJM7JReuNGIzuDrsG3Hunphbs3bnwJxCgF+hc
         bTFcG60BiEd8r73NrGL2C0CN7UrfXk8YvYiah5bygk7IKVSJGHo8NtXsqjl81IEpJwbp
         HWnolm8T0v2VahbO+GTBWy8sJpednf9CjuL4RXP0W5E/T65V+TwQSbBDveIAXKUMbZ1/
         c+Bg1BJEfLPdclEBpUdA37kkkRRwJcNIyNr3rA6NAA9tRr0YUML8JB5aq61EVE45Thoc
         HCtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785564159; x=1786168959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8jsHQYZsIv+UEcM/v6JhPnpCp7qXtARbFHI5o9bFxNg=;
        b=BbrX5ztYF5R4Z+1gZLvLkFJoiYwT7Touy0ceaQLDgPPB6mBaEeHn3jDYKPWerhvDgP
         SKpFQArjj35gC/nBy4VN4dL+ZyxRrQt7SUyl2N2gW80nDwgKn2X+qiTZd1gwm2ZNOAhN
         Pjkkqq2L3CWxcIGDYwwVtew4eUiNM8eYcxOWRfj3T3nRraHTD5ANMCojw3Pl2MJec1Zz
         SLrIZdqDDTWk2iPpwOh+SxjTZWPDiSghrhUlIZmxkYSrpvoVrPWJmTafpR3PxzKk4ul9
         PdIJkAsaX3ffgh0IQNtQ8hOjXR6ljmW5B9Wg1H3OrWVfhrYuHgUArKXziipqpkz6wsWV
         XUdw==
X-Gm-Message-State: AOJu0YwFLgp86Ek+v6wOloH2fUYb3xDdyxvtGrJzEtc13zzK+JfzTVr3
	+jbLG75DLG8HuXNS1eahYbsGFe6HD1o8CxmHV3xGvVagI3JjJahcFhiTmgtObcqt+nhgC6yGRxH
	U16OUFkQ=
X-Gm-Gg: AR+sD10epUHG481xGwxvnyMBDGYRY3FD9ED4dirs7FQd26WbC54DW7p1m7m5FKjxASj
	0335RvTaEbXd9OmOri/AbCjaKuzg9yw53uHzT1ifW5froFWKm1FH9npGmi05YU3/PjvOuPSewdS
	dhhSN8UzTD614L5T5mSvrJCGWRaBs2Cf1Ol/HAcMd7d76IDFqsky/f4vRz/vhFaSKi3csGeeiBt
	QoswS8vY2fqPCfqIjRPNCJ/VUE3Z6gydaapIq1EmB+NWuEToU/9hNQfUhnucp6NRARG2Gsxdo1a
	ZJHKYNb3H3SKGKyHCl+pLjNhiEhtspn4UmQD8tOVXwpb5CSjPdie8F8NcJoeVCVYpSAm/OclYyV
	/xHFZpU2Dj6eTBRd3Aeyd/Yuermn/pU5jQPfYwLw4qL7fBrMtOeXxBK50mTV2Wtjp86Kr83P5T+
	uNwnjqCMVT599MlJhIsRSBjY4VXe6/gVJJDHfZHOcbL/6UD4/d/tD/+UqRdHE6cg/zIzt2GRSRk
	lf15enhOXs=
X-Received: by 2002:a17:90b:3912:b0:38e:6a44:671b with SMTP id 98e67ed59e1d1-38fbc0a436emr2481271a91.0.1785564158719;
        Fri, 31 Jul 2026 23:02:38 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:c329:7b28:fe02:5dc8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb2bae2efsm1598856a91.11.2026.07.31.23.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 23:02:38 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Subject: [PATCH v2 0/2] nvme-tcp: two checks on the C2HData receive path
Date: Sat,  1 Aug 2026 15:01:59 +0900
Message-ID: <20260801060201.1879499-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260731_230240_115525_9E2644E1 
X-CRM114-Status: UNSURE (   9.91  )
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

Two problems on the nvme-tcp host receive path, both reachable by a
controller sending a C2HData PDU that does not match the command.

1/2: nothing compares the bytes actually received against the length the
command asked for, so a 4096-byte read answered with 512 bytes completes
as fully successful.

2/2: the C2HData gate reads blk_rq_payload_bytes() without first
checking blk_rq_nr_phys_segments(), the rule commit 25e5cb780e62
("nvme-tcp: fix possible crash in write_zeroes processing") established
for the send path.

Reproduced on v7.2-rc5 against a test target on loopback; no real hardware.

1/2 returns -EPROTO, which resets the controller rather than failing one
command, matching the other protocol-violation returns in this file. I can
fail just the command instead if you prefer.

Link: https://lore.kernel.org/r/20260731143116.1870962-1-yhlee@isslab.korea.ac.kr

Yehyeong Lee (2):
  nvme-tcp: reject a read that transferred too few bytes
  nvme-tcp: do not accept C2HData based on blk_rq_payload_bytes() alone

 drivers/nvme/host/tcp.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

-- 
2.43.0


