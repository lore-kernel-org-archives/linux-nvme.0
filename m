Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF18BC5DF81
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2026 20:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2O/2dv3vAMW5OP3cGNIdUoe9lfLCfo93pjtBUDdPVAY=; b=ByBEfF07Mccqml1+DALh7fdzco
	LvvnHcSdyg2mkFUKOaj4vEZoZC4cVYCLst+PstLr4y2wSIlDzq3WEWApWRqWGwvAWOQD5KLQqDicA
	u0gGz8xfm0TqWaiqtUlP0VD+3qLSBPQaSJPwoWcfn9396rJT/LngGKT9kwR81nz5OaHB516eeaQHN
	0IK51/fyBEhgMAe3BuMQ0Bk5YWLkxziws6kGTUXidX4gY8O/BcnP1rKZg1WoADTntqVy9LLdA+JfB
	0b80XRwrEbbRA3Yc/bV7s2+geqSsoHt3UbUieie4Sjflu5B/wQXMJQLQ8Xc8qr+oB84i1njF/c/jx
	IhJ+Jzcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wx90G-0000000C9UF-0Erv;
	Thu, 20 Aug 2026 20:04:44 +0000
Received: from mr-2002b-snip6-5.eps.apple.com ([2a01:b747:3000:201::1c] helo=outbound.mr.icloud.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wx90D-0000000C9Tu-3P6L
	for linux-nvme@lists.infradead.org;
	Thu, 20 Aug 2026 20:04:42 +0000
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-20-percent-1 (Postfix) with ESMTPS id DA99518002A7;
	Thu, 20 Aug 2026 20:04:38 +0000 (UTC)
X-ICL-RepId: 01a020c6-8f18-73bf-8661-7521b6b172c3
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQhABkMAWBxBDkkdXwZfEhVdRVUIRRlTHhccRgxFGVswVB0dDlgGEhZdRV4IGQhdHRkKUFAAS1oVVRcOAkIfUB9MFldDWhkcGVoUXBhTRVEfVFhDGUVWaUELTx1dGVscQmRYVwkKBldeWhdeTVoCVk0FSgNfAVsKQglKA10DWAFeC0AAWANfH0EUHlYfRQpcXl0NUh9FAnIdXFZQAlpVEgRACFZQXgheH0wc
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai; t=1787256280; x=1789848280; bh=2O/2dv3vAMW5OP3cGNIdUoe9lfLCfo93pjtBUDdPVAY=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=VDncuMDDgprV5M/TsJLfg5//Z8mymeycgbeGIsCu45RzEEVLtxRdmrak7dshy/1bwarJ1n1jH9a+yHYc1wjlVSQgM2As+vK76wLxH6X2Bs83z8r2O5f219BfnIoVPnzQtxyQUCD9bvHQXZf6OFp9wMsPjM/z81Y/giTawtufT5IeDBKt2An2YTzhuYuUu4+MZHi0C/F74RZm+KuB6MIxaW7uOTC+9V61/zDqal8go7IAzTK/MJXtjAIfJr+sU9i9iSS8RDBgORNglgf28vv+3pYrB3z0uLlsM5CYePWTY38H/6HVWQ6ETmfpporK+FvXcpc/gL7Om90ioPzMegqpfQ==
Received: from ncore (unknown [17.156.200.36])
	by p00-icloudmta-asmtp-us-west-2a-20-percent-1 (Postfix) with ESMTPSA id A22C618007CF;
	Thu, 20 Aug 2026 20:04:36 +0000 (UTC)
From: Ferran Duarri <ferran.duarri@me.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ferran Duarri <ferran.duarri@me.com>
Subject: [PATCH] nvme: lower default APST max latency to 25ms
Date: Thu, 20 Aug 2026 22:04:28 +0200
Message-ID: <20260820200433.283544-1-ferran.duarri@me.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=a/Y9NESF c=1 sm=1 tr=0 ts=6a875dd7
 cx=c_apl:c_pps:t_out a=9mRn2PO/+PIrVdEbaIuMPg==:117
 a=9mRn2PO/+PIrVdEbaIuMPg==:17 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=B9nqV3Rn1-QA:10 a=VkNPw1HP01LnGYTKEx00:22 a=HHGDD-5mAAAA:8
 a=8uIbJeaS8xPCM5DfPzYA:9
X-Proofpoint-GUID: KSz-5MDIAtnjx_UfxVki10qov14QZ4ib
X-Proofpoint-ORIG-GUID: KSz-5MDIAtnjx_UfxVki10qov14QZ4ib
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE1MSBTYWx0ZWRfX7Q9Rg00vn3TL
 3YNuF0DwvA5BU0EGMPbD1ASfit7cRO4dMYF8gvZdxX4RfAHxJtzLZ6pnz4sO+Ma+63esNd2NNun
 NmseaM2RrcQRY8yqq6Wq9UQQONXlR0oeDAb+3gs5+BOvUBU9pe/mLcHpR1o7CIRz2upZ3+hW6fI
 BQMsBBj0/JfjqkEDppsHMbJdF0CIjw2aiNXiD7FUMlVkRYdkewo8FMw/0I4uwt4lt4qqekywWj0
 xVqCS6QavyKMAUEyoSUcmJdBZJzJdjCJn0h+Y3WSQSYSMDweJDawXnRvYd/3bSKTk0LJWA5U9E1
 qJVGVXGaHT5mo46wEc7L0+EC8pN4bIgvhcvvA3Mt6WU6+4GuwteJEox6Fyxhx4=
X-JNJ: AAAAAAABdqaCaZ/+/FQ0v/eobQ8WrZQ26sv7tiygf4+fCgbDke9hUIpVCKQJzXAOZzhq33XoDP7jtH+0wSt5KUSSvXTcFtMyrdpXSlvljJNCqDPME43hTTcuUxj2ch5/+7/1RGRhhDZfg/GeOObulcnJBltIaistOU4GkhR9KhWta09tk1/19VKjOJ5srDZsH9r4j0RfaaHykzBtWg191D5yUDTufXASwo2knMEdv+Q3DGztv4u+80Fm4Ydb4D5UeHM6DGtFbnRdaQ6QZJn3DdriWUqjcuzSk6hHtoo8LmUNdJOUJ9PQm14fbuD8lEslnZeSX+iLhZo5iMHSr3dMDHaRyAUPUlIXv1vTYiqe8YUDK+gJeJ1QDtaAhSstzBGtrNb7uREMbsTvqGy6OY0XJW84zMsp940TVTn8qwyFwypk/qWQkuczbBEcojHk33vGGruxJGF5Drl4RUo4l1NriIv4Za33x9pg1lTH3wWrQ8/Fz2TRGj79I/BJGYXmqtwoSikN4L/51HzlzLHvz2EjqoCGUcfdOAjLrEIjL+bQvmxJo3FsnQ5atfiqQ0CnQIje+V6dgT1jGiQxSa8fLS3s+k1g/DDqmyQ86theYVnVTFSzow2PqAz3HqiZYAfzPwH0gsGaSv4jE525mTjwVHXPuxFzUiiGqOzlVmqSIvE7fD8Hk0dVaW6M6j+JdigmJWMGW3Pw8A1AanfPpJ59VuWlCJvD8ic+3XRI/QOIUcXXU3Fxgc4Eo7emVuWUt5+zbpIxBrbmI9Tp/bC22ksheHyiG8kUZqcUI7+vlsB2F6xW1IQJxbodNsiIYRFjt6Ts7sHLKK/zkmKnYzRAw8FLQwTWaMmtMAYCtznl1v46Fj9PwN1oFQB00xDW4YyvalroX42Pmt96kvNYs7sM4WMn0upSHuL3TDPNVNGhMqQTY0nCrkQDuDfQDz5UdYrkanHuR/Ye+JtxQqfz153Vvw21b/pDzD7nSazuwMw
 /jLAHqIjFsMWD7O12HVXgIJKAN18EhIYQ+0kib3A0DSDlEbgbFz2JEIBV/vlrCYBvqe8iRYC0b+KaPAn+Iy1yhnGZ1j8Pt7Qz57ocTug0GH4IafuCDZ9wWnYehgUrCW0Gdw7OQi3RHkfzHdhBiehvhFD46zKDxORI7G2dB4gjY3V+KDq1An7K7ceppiIALwgoGiaISs/xBXR292r3EKztT7lZ8Zmo0lkIMTuThteqnRvOYn3n5Il0ZZ/o
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260820_130441_873495_0F0571BD 
X-CRM114-Status: GOOD (  18.66  )
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

That one bound decides how deep a device may sleep. On a device that
advertises a non-operational state an order of magnitude slower than the
next one up, the 100ms default silently selects the slow one, and the
first read after an idle period pays that wake in full. It shows up as a
stall rather than as reduced throughput, being a one-shot cost on a cold
access rather than a steady-state penalty. The workload that prompted
this is staging large model weights from NVMe, where a cold mmap fault
on a multi-gigabyte checkpoint is exactly that access.

Measured on a Samsung SSD 990 EVO Plus 4TB (fw 2B2QKXG7), which
advertises two non-operational states:

  ps 3   exit  4.6ms   0.0800W
  ps 4   exit 43.0ms   0.0070W

At 100000 the APST table targets ps 4; at 25000 it targets ps 3. Cold
4KiB O_DIRECT reads after an idle period, 60 trials per setting, the two
settings interleaved trial by trial:

                     p50      p90      p99      max
  100000 (ps 4)     3.3ms   33.0ms   33.5ms   33.5ms
  25000  (ps 3)     3.2ms    3.6ms    3.7ms    4.2ms
  warm, no idle     0.2ms    0.3ms    1.7ms    3.6ms

Observed worst case falls from 33.5ms to 4.2ms. Both states measured 78%
of their advertised exit latency, which is the cross-check that the two
figures measure the same thing at two magnitudes.

The p50 at 100000 needs reading carefully: roughly five trials in six did
not finish descending to ps 4 inside the idle window and were sampled at
ps 3 depth, which pulls that row's median down to the 25000 row's value.
The ps 4 column therefore rests on the remaining sixth, where it was
tightly reproducible, 32.9ms to 33.5ms. That effect can only understate
the cost of the current default, never overstate it.

25ms is not derived from this device. It is a bound on latency an
interactive reader notices; any value between 4.6ms and 43ms behaves
identically here. The device is an existence proof that the 100ms
default admits a state far slower than the next available one, not the
source of the constant. On a device whose deepest non-operational state
exits well under 25ms this changes nothing, which is correct for a bound.

The cost is idle power. Excluding ps 4 leaves ps 3 as the deepest state
the device reaches autonomously, 0.0800W rather than 0.0070W, so roughly
73mW more on an idle drive.

This changes only the compiled-in default. default_ps_max_latency_us is
consumed once per controller in nvme_add_ctrl(), so it applies from the
kernel command line as nvme_core.default_ps_max_latency_us=. A running
controller instead follows its per-device PM QOS value
(pm_qos_latency_tolerance_us), which is how the two settings above were
compared without a reboot. Any system preferring deeper idle states can
restore the old behaviour without a rebuild.

Signed-off-by: Ferran Duarri <ferran.duarri@me.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c3032d6ad6b1..e3038b880e8b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -66,7 +66,7 @@ static u8 nvme_max_retries = 5;
 module_param_named(max_retries, nvme_max_retries, byte, 0644);
 MODULE_PARM_DESC(max_retries, "max number of retries a command may have");
 
-static unsigned long default_ps_max_latency_us = 100000;
+static unsigned long default_ps_max_latency_us = 25000;
 module_param(default_ps_max_latency_us, ulong, 0644);
 MODULE_PARM_DESC(default_ps_max_latency_us,
 		 "max power saving latency for new devices; use PM QOS to change per device");

