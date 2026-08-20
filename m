Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B40CC5DF86
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2026 19:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2O/2dv3vAMW5OP3cGNIdUoe9lfLCfo93pjtBUDdPVAY=; b=zIpeNrlWvZ7YSEjtqacSN0y5r1
	r2xhOLozzeQ7Yduj1emFcW7Qbj5lGvrbKzAc9G+8550hzsI5AASet+8hpHoloXpJAWe7v3VROEZcM
	gl2//coCD+q2eUDjqyxRq28k8kM+k/fooxALTWfb3FBW1f+6zC2bwcnPp7qp6ivkW/R2t/OjadrST
	RmFp76APWw6jLcVtCJO1VAAnatIJPQwv/ohY3NjqmBv99rZ/WXUL3M8cY9fFC7hTn6TEj/whNk5au
	pbJq1T0kCy7sKnDMMS6flcdNnv6sz3eqK5aDCZdXNjgOAJMTtIP3yd5RD/V0VUapqIN8OcQuHjeio
	ZV/eUWRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wx8gm-0000000C8Nk-2Hzy;
	Thu, 20 Aug 2026 19:44:36 +0000
Received: from mr-2006h-snip6-8.eps.apple.com ([2a01:b747:3000:204::4f] helo=outbound.mr.icloud.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wx8gj-0000000C8Me-3XIy
	for linux-nvme@lists.infradead.org;
	Thu, 20 Aug 2026 19:44:35 +0000
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-60-percent-4 (Postfix) with ESMTPS id 5BB721800EE0;
	Thu, 20 Aug 2026 19:44:25 +0000 (UTC)
X-ICL-RepId: 01a020b4-0ae8-75cd-9a00-4ad3a401cefd
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQhABkMAWBxBDkkdXwZfEhVdRVUIRRlTHhccRgxFGVswVB0dDlgGEhZdRV4IGQhdHRkKUFAAS1oVVRcOAkIfUB9MFldDWhkcGVoUXBhTRVEfVFhDGUVWaUELTx1dGVscQmRYVwkKBldeWhdeTVoCVk0FSgNfAVsKQglJClkDWgVeC04KXAZbH0EUHlYfRQpcXl0NUh9FAnIdXFZQAlpVEgRACFZQXgheH0wc
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai; t=1787255067; x=1789847067; bh=2O/2dv3vAMW5OP3cGNIdUoe9lfLCfo93pjtBUDdPVAY=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=XCXMKZsi/GCjmOL2viUpRlb2xw431A32//nehVWKguLee2WYhZ/M2buRYaEy07b8DaIIsuGVIi9MKlsl/wgzTHQkPbJ7iueHGBG6r1zD95i5wJt3jISJNoeXAr7o1ebGjuR2V80YtmG7BUykFO2Uo+F+dRJcAMxrTlInD5HIdHjd3MJAqHiT2o3Yv5NLD2a63u1MdHx56x9wunWt7QX0mfSEJ6OM5jEGb9GSo7Mx3+Vtb6yuQMLsNLIy0Va6wmw5Hs9RAteANGGii/S1tarkOL0ecy659XRAz7zlaTlEvm3B5cbCXMOAOk5uzZc+8hu5O1Xf/38pyFAWB1O3PV2Sbw==
Received: from ncore (unknown [17.156.200.36])
	by p00-icloudmta-asmtp-us-west-2a-60-percent-4 (Postfix) with ESMTPSA id E952818003D1;
	Thu, 20 Aug 2026 19:44:22 +0000 (UTC)
From: Ferran Duarri <ferran.duarri@me.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ferran Duarri <ferran.duarri@me.com>
Subject: [PATCH] nvme: lower default APST max latency to 25ms
Date: Thu, 20 Aug 2026 21:44:09 +0200
Message-ID: <20260820194417.269110-1-ferran.duarri@me.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 8PCniyftq_elWyfdtTxJtGy3repYtQXi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE0OCBTYWx0ZWRfXwR6P1GfzwzCW
 dXvFCmoZurKIJVBkWDIxT4TH2TbyqhDu4v/m1wt8tujnQFf+sq+sxsXZOgsl/Q/ErlHcNgb+ekd
 AZaDa6PWSPK6wt093ZZ8s9JgDPWFzDFMJ+8Po+sy7t8i6TXwyb/3UncHRnBGfy5HsvonbFUOugC
 8PYIdh3ptOXadhjySuDgcnTUGaUcsZSFvcUWs9g4wh7qY08icWRCkMCVZSfb/HErbu0Y4vC/jWs
 7XCqm6nl0T0Kq8if50g/0++oQ8grAkSPgf9e6je1Z7TVeP/UBxYP0AIeAHVeA/NA4/Cqm1kDgaZ
 MixO1TlNRdcTO7S1Xx/ziyQc1bU9MTvbyO9jk12JsrUYnPcQkgXKHlbF73YrVw=
X-Authority-Info-Out: v=2.4 cv=YdCwJgRf c=1 sm=1 tr=0 ts=6a875919
 cx=c_apl:c_pps:t_out a=9mRn2PO/+PIrVdEbaIuMPg==:117
 a=9mRn2PO/+PIrVdEbaIuMPg==:17 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=B9nqV3Rn1-QA:10 a=VkNPw1HP01LnGYTKEx00:22 a=HHGDD-5mAAAA:8
 a=8uIbJeaS8xPCM5DfPzYA:9
X-Proofpoint-GUID: 8PCniyftq_elWyfdtTxJtGy3repYtQXi
X-JNJ: AAAAAAAB7CRBvKIOIY5eGsDRSQ75sjQ1vZzI0l/i1xcdLV8mRmEK7i+S41/2QtBm/24hg0yop0I/tLkLPhXio4+rxlj8WqveZ9m+5Xn/9lEQK36lXcZPddNw8Hd6P1K57HZHvf7hTALZyeRE9eH/PWSP1LX5wzU8RlcUaBfuW2bvGaiuNvOK+nMQC1LUbYPoCVTyTcBGpGYeHJhavfkl8R7iJW9elrVcbTlhB9gcPaz6TyBJuhu8TPFh0XabsrgTtxjHpUkuokZaiGFr+I78sH/5egRrdmrrB7ep726hJ4QRcYrol/UjjC8NMZuxnXEvGqreHu8KmnDf7QHZwCfg8PXaXgdEicnkaZ/xoUrNLO7Tm09jgCtd+lAuTQ4Rqn/X+kuOsnZlJYnomMVcbAdkslKsGiQBvMVgmVTVGmthrdd9qXYpj3aE5Kf5oVAgmolH+5CIHZVOUWUzonxgqvgSjAlNoGAtbKqbxrHOfCjmL4nxo1gIJTyVqpFEOBvIQZBM33+9hoHCsCBixGMCdo0IORGRUzIv9ZG2fd3mJ4dJnXFJ62rk2xJbxhWzwWbZMYMg96RS7faWY0OO76p3WWEaJRB3GmUu9yPJS4+3x5x4EGzw4JdURF8mpT4Sg03xAXCsBtAptxWb6rsckb0KZ4FUwyZxyinMaNNoU9LY9S+PVrjPvtWN4Kgj8AJg7em6JHHiExlk3iNuj0WT3qe1RByqOYe+7PnwmgCyXIpHYH9KrjpjPLL9+K5qskIAX7urVtXjDf3uBSB/OkGE2cKsVvsCuXbuUspQKVJ1VnqrU8V6Fz+r5W2naYz0Nh65KmX2/TCz8WeS9wXubwOM2994EgXx9d/yV6kQ6s3HFxpojDcn0v1KGM/Wi+nvyU1MHjO1y4o9F8o13CAImyVOjcrn/Dw3fC7V/98Ta0zeRa41aLl7Kq5qeV4uuxaOhw0qxPs1RDU+SAqf8xISIBi96L9dB6kGStZ1sBGcO/v
 lGFMpWk7qVPg+BNFFLaTR5sia2sTYCZfaSGAYG7T6+nleU4o8K/9b0mdRcXXZynDOigH0+dz9QgcQWaw0cbZjahZYLNDkR/3Pg/up5jnz7alO9/Swwkr+amC6yOqD02HJrmZ8xP/OoJ9y2vGOlBVDEQHprJMTw3CsSAaU+CmPgszo9Nz0QvWiIpmPcRQbRtJqypy8fiSoUvhLBVIu+h7RnHIq+zIW/5WQT3efxxGdgg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260820_124433_902785_CF352ADD 
X-CRM114-Status: GOOD (  18.77  )
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

