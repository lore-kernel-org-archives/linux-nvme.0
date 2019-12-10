Return-Path: <SRS0=hdrt=2A=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6016FC43603
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2019 06:26:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FAC420663
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2019 06:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p0CldWsC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jAA4n6am"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FAC420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=F86vStu6l7iy9Km9M5PLWW0jp/J2ZyuOiEmo13e4tvc=; b=p0CldWsCiBpzAW
	pCr4M+BVW5P5bXRp5+G6EwNRDd998wDLwLw7KIDBXh61uNjSrnP+cBMKqiTI5LsQrW+1tz3mPzRnG
	bFv31S3TYyNCCzVVfToMkSyW1C3zeTMzQueaBtIYC19p7fbEhBx++F+ijeRc5HYwMXlU6JSslyXha
	Dg1sf0jS8VXKVdZ3dphtMiMa1Mi/Woo/mH0ozeP3QJXTrYCa3ICLskboq6HsRrEe24ZJMGYCb/klz
	R/V6P0ClFw/PYbIwTIPQkXtWUVd8zk5BK+Mh8tvLGxaWG5RbjnH4i6IJ8jbNj1bEmwTcbB4+tyXsX
	6T6lq6VTu42JC8m7U8Yg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ieYyH-0000ZU-RB; Tue, 10 Dec 2019 06:26:09 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ieYyE-0000YU-80
 for linux-nvme@lists.infradead.org; Tue, 10 Dec 2019 06:26:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1575959167; x=1607495167;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=VNz4YoDCF55OpfdzqO8/WK2L/iOZhq6yU7BnAD6RFMs=;
 b=jAA4n6amQ42mMUD8v/QxPcGQ0KTRm7QNZZ3+Ys2eCq3Zrgap8VI+nJZH
 /7TT/5I10TankBEV0YcU6OaLsLB8tT6MvySY4iOrg2eb6l8xdlJV9ZdFH
 xYpFWPSTSrCpqmUPJi2KVSZ+0jRK+o1YUuuNW1HCT9bIlXF2im1hethLS
 AsS+buwblydKO8edFcqslj5KRIMPd/x+ClaVAvkgGChzMF7BKZRhd92Zw
 huEslbKY3iaun9hsJfbQ4/0rCvpLspcTKdMiWL2I0RsGoMDHI5ddbBiyn
 92EQHTS35uFwdvFh+cwWcYvDTO3SNDbxi6GohgMXiQD5zdT0LUjmkePiM g==;
IronPort-SDR: H120EgLqNuLkpc1bDZWZ4nd9Swrg521Dkiej+UrYSiopNxEHqDZ+eEej40GPzysY0F2mxTxxJc
 u5b8pE1O77AeUf75DC7XvCC8V22MTQl2GRKUPIMfxDSb+RavBJCfkCFUrax8g9zEzQi0s8o+8d
 sTEOsYwRtzMqbiKa8PdZK5YPYk2FrH5nDWdzakFjGKoYMbS7pAhTwWhxX/aAGn7sR0lqdZQ4xR
 4C1M8FLLFF5fkyf4L2GzABgiA0jSQ6a52g90KXHf48jfMEYK+WivTWLHQvp4I1f3+q26BRhvGf
 FvI=
X-IronPort-AV: E=Sophos;i="5.69,298,1571673600"; d="scan'208";a="125753997"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2019 14:26:04 +0800
IronPort-SDR: R2fntkghWK63UFrq0quB11A0/h69xy8gfES3c6u/Wp+VQMPwXIK2Ma0dhqGT7xraYCurs8slkc
 6EuFxMmADnjIzA2W/9N+CbZ17O482pAkef5r9x06jQIQvgNyPFWrdNzU8FFZ+U5GQAGGeOt9B/
 yeFKLcYfHJsbIrOM2NBhpGe1rA/SDbEbisxiiHasuVdtwMU0bMm7uPoMo8WTn2WxyGm9mHjaW4
 df7DwHAqe5vpMMlv8zAa1PHvTnsWpbyUd4A/MQ1bve41duTuaKdWR4BFrlgxFFdIVud9hpPNrL
 MG5ooFVrGq7zPpAzICzMgMo7
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2019 22:20:19 -0800
IronPort-SDR: nWwbka/LOP50gFNu01gD77VgT+VbFn3RU40fZyIvHwDmDHHgJp+v5lbF/V76HK3x/tG9lCQHOL
 MLATWBdj1VbrL96AGUKry++5caZiZdnT5HpTma74ewNETiEEEodGWrMQMdOS7wlnb4r8q+O+Tp
 6xc3M71CRlZFrfNsbNI9PmS+5BAT7uRcdIGWjZh4Q68Df/kywKMY064a5ER5MY9xLIY8fQGaVY
 U8ibJxl0py6xE1XN6+FrtzBTXnjW+jA1EupGULqUSbIEzV30G3XkigJ8R9gVyhh/GfTWUhtzrj
 26o=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Dec 2019 22:26:03 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: sagi@grimberg.me,
	hch@lst.de
Subject: [RFC PATCH 0/2] nvmet: add polling support
Date: Mon,  9 Dec 2019 22:25:55 -0800
Message-Id: <20191210062557.5171-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191209_222606_292105_99E5B13B 
X-CRM114-Status: GOOD (  16.27  )
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
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Christoph/Sagi/Keith,

This patch series implements the polling support for the NVMeOF target
with maintaining separate kthread for polling.

By implementing the polling for the file and bdev I was able to create
stubs for the target polling which will be useful for passthru code.

1. General approach:-

After submitting the request in (nvmet_file|bdev_execute_rw()) code path
we issue request on the available polling thread's list (poll_list)
which is shared between submission thread and the polling thread. We
create per CPU two polling threads to improve the scalability for I/O
submission.

When polling thread is woken up by the submission thread it moves the
request to its private list (done list) for processing if it finds
completed request (by the backend bdev/file). This allows outstanding
submission requests to make forward progress under pressure.

When there are no completed requests on the poll_list then polling
thread removes the request from the poll_list and calls backend
specific poll function on this request until it gets the completion.
On completion, it finishes the request in the same context over
trandport.

2. Testing and verification:-

I did fio verification tests for a couple of days and didn't find
any issues with data verification. Also, for bdev and file I could see
the io_poll stats under debugfs with considered/invoked/success numbers
being increased.

3. Performance improvements:-

There are still some performance improvements which can be done.

4. User interface:-

Users can optionally enable/disable polling with newly added configfs
attribute use_poll. This only enables polling in case backend
(bdev/file) supports it otherwise we just ignore this value.

It will be great if you can provide some feedback.

I'm aware of the io-wq code for io_using posted on the mailing list.
I was just wondering should we explore that to implement the polling ?

Patchset info :-

Repo:-          git://git.infradead.org/nvme.git
Bramch :-       nvme/for-5.5
HEAD:-

commit 7e4c6b9a5d22485acf009b3c3510a370f096dd54 (origin/nvme/for-5.5)
Author: Keith Busch <kbusch@kernel.org>
Date:   Fri Dec 6 08:11:17 2019 +0900

    nvme/pci: Fix read queue count

Regards,
Chaitanya

Chaitanya Kulkarni (2):
  nvmet: add bdev-ns polling support
  nvmet: add file-ns polling support

 drivers/nvme/target/Makefile      |   3 +-
 drivers/nvme/target/configfs.c    |  29 ++++++
 drivers/nvme/target/core.c        |  17 +++
 drivers/nvme/target/io-cmd-bdev.c |  61 +++++++++--
 drivers/nvme/target/io-cmd-file.c |  60 +++++++++--
 drivers/nvme/target/io-poll.c     | 165 ++++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h       |  40 +++++++-
 7 files changed, 354 insertions(+), 21 deletions(-)
 create mode 100644 drivers/nvme/target/io-poll.c

-- 
2.22.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
