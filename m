Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE7FC61DB9
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Aug 2026 09:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=VHwIa+wXj0FuTMPPWe9jiQiTbFnEFdxNxGdvS4ouKnU=; b=KhYMbT1nu87S6vLTLFnYiaQ9si
	GAnqLhKA9IV2xEnAydbVN46hOIwTTp122Au8i7rny8obGOxNld/zqxl94CNi16XF6aw/s8HsKOuEg
	iSCDV/VFi1cgPQFUblZtiDaWtwmaeLd6inReIz7JpgCZoOoPWbFCh+aMOBCm3DimbktJ2yuhVRT0x
	rmyH0z1KoP6n9WMawQw5wjo1b8fPLAcBmId1Q3FgaIfsOa8t2Yjkp1AY5G2WTwPtrCjV1FyO7R7YB
	PO8Q1TlIaxqzO467b2+Q7ZcOhCZdQcS7xEAUxjJz+Zxv6g43N9oip4RZQmUC8Awwd7QTcxqhnsHZp
	X1zb4w5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wztDM-00000005VnJ-0pSQ;
	Fri, 28 Aug 2026 09:49:36 +0000
Received: from pv-2003d-snip6-8.eps.apple.com ([2a01:b747:3003:205::27] helo=outbound.pv.icloud.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wztDJ-00000005Vmm-2UPt
	for linux-nvme@lists.infradead.org;
	Fri, 28 Aug 2026 09:49:34 +0000
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-1a-60-percent-3 (Postfix) with ESMTPS id A25DD18001AD;
	Fri, 28 Aug 2026 09:49:23 +0000 (UTC)
X-ICL-RepId: 01a047c6-26f7-7bbb-bac9-3d68c80fe63d
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQhABkMAWBxBDkkdXwVaEhVdRVUIRRlTHhccRgxFGVswVB0dDlgGEhZdRV4IGQhdHRkKUFAAS1oVVRcOAkIfUB9MFldDRx0cGVoUXBhTRVEfVFhDGUVWaUELTx1dGVscQmRYVwkKBldeWhdeTVoCVk0FSgNfAVsKQgFIClkPWQReCE0DXwdbBl0IVVUIRRlTHhccRgxFGVswVB0dDlgGDFBNAUMICgJRHFYNVw==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai; t=1787910568; x=1790502568; bh=VHwIa+wXj0FuTMPPWe9jiQiTbFnEFdxNxGdvS4ouKnU=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=rgjSHScXewNLHouA6v1rjPZcpvJIQ9m3GPa5yZjrju48PlG3ITtkCLuGIx3DCnKPaSGWTkPE840i0op0pIMTJBmMP5i1FIjMlKVVQxR+eqqU+UGLiCo4kGQcrj/5BYRSPZR8VLA/hSypwPNbtT5MgM1Yma/ypaHecX5/xnGzVhRRF93Hck0aQnl+opHEC66zorpdtbmy7kElFVIlX5ncWQ4Csj+AZeY5LZsLzTrmx0ySXKV5lP2l2rCFmukbbwJvW07swXKd4J0hF184EmBePaM9YNdIbDA8qEuLUl9YY34kLRVPAnp26v8gilZxebGLbCshHNZ5bFtY2sY9wVlWNQ==
Received: from ncore (unknown [17.156.192.29])
	by p00-icloudmta-asmtp-us-west-1a-60-percent-3 (Postfix) with ESMTPSA id 5BCCF18004E8;
	Fri, 28 Aug 2026 09:49:21 +0000 (UTC)
From: Ferran Duarri <ferran.duarri@me.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ferran Duarri <ferran.duarri@me.com>
Subject: [PATCH] nvme: lower default APST max latency to 25ms
Date: Fri, 28 Aug 2026 11:48:24 +0200
Message-ID: <20260828094826.1502004-1-ferran.duarri@me.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA4NCBTYWx0ZWRfX83RAb/oqm0aQ
 4ZPXb5/jbdhg/Fa7ZQOFF0tXh+ICD0KroI799n5hBw915WGCeJqmR+tEbMJI508IxXtDiiGRvOO
 A19J9fhREjw6eZ53GEk1Cldpj30x1dp5Y7PQUbEtfEZVdZ+ZgOFmJgbhyUHrZwDRAb51iW8cfRL
 zi2qk5gnywQclOrQwPv2GkDE9Wua0HgtsER9WQ5jLU37MrB+38S1JPfyBPrSX7rzm3iiXYa7VR7
 nt0FvBk0CqS05PowGETJjhjZnFD84oEB7nRgilWqNDnuh9dyaXC3CVPhoza6eKIljzE1dv6bjml
 tcKm20npzasntWDAoCQIAnlwxZIawB9d37+lBVzuFE8rCzfIOEfOxf3OIU3v7o=
X-Proofpoint-GUID: f9By8ORZZQum0LyGQmk2G2Q5PcnzQquA
X-Proofpoint-ORIG-GUID: f9By8ORZZQum0LyGQmk2G2Q5PcnzQquA
X-Authority-Info-Out: v=2.4 cv=F45at6hN c=1 sm=1 tr=0 ts=6a9159a4
 cx=c_apl:c_pps:t_out a=aW9mcIavGNWWFvFFKOxBSA==:117
 a=aW9mcIavGNWWFvFFKOxBSA==:17 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=B9nqV3Rn1-QA:10 a=VkNPw1HP01LnGYTKEx00:22 a=HHGDD-5mAAAA:8
 a=8uIbJeaS8xPCM5DfPzYA:9
X-JNJ: AAAAAAABTjuatjBeFzf9jdS1Z7hd6NEsWInGNLZSahhkMhiqyRKBjB5q6fgJETK5Q1EX4NTqDsvGQKGwZxoPFaMu9Udk9ht+wbHJgeZ+xM6Aute5VGDQAvIaDHYSbI9fjMK8aO3PN+neWd07rSVXzFtUIyK08dj03cC1k59H0bbi4BGi1ZAg6OCBA3okaWf/GX5iurlls4DCQLBht/FWCqaYDPqxGM7B6zdQnh43URforJuSGhdP96pQEd0H/5IfxcsV09qDUNLEKj1tq9eA7hc4TDkyqBw0vTa1/MzxChgd/y76GWWW8XHa7iFN1SxDYxzUaL8VMjUp/VUNio+37A12axX31s9ZtATyqTk1koMs/Y6rjGdG3Y5Ju5qBMDkn06F77SfCmdQrPgWNNqOUTAARukRUoKlZllerp17iMl1iXVO/rYhms3FYBolJmu3gQ+dpXvu1e8n7m4hvCsKNzJMrDsOSnQuCpjetzjjU3QnzvEsDpImjZQdYWDy7YP1pvMjDVWZ20444BYefXOx9eHvo6IpBujLrvqIK3AsdBYYzqxxt1eJsdta0s7ukJNizMZ8XK0fCKR76AWki0/dSHb/IWuTFZCfQzkSYJUr7zOrXZ+rkbZAyr0U8mRsRY8eErvy85w/p/QhmoBjSlAxmpQs+K3ZnJU0Uj9O3tzpw5NIRgjmcvclGXEW01xvhvVDjNa+CKtNJCf2bjkK+emFMY9UyXa3QG/fIKlzhupNaLiutU3oOQ+V5NOuQ4mmlKse0PV6Lz1PATqWqPqAmaWytBSohVbzMaSTi8vFz7uv4dG5NuosGC5RCU6CmIZTEbNToHRnsOdecPz16y0ruUBFkBCmK0xCCqxoQNuJfLM4X62yt0dvdpbAI8WUr84oihemHZNXTay82kqFDU2ZaUSrywndAn3bVR3OwrJeufQuXtN7jMLKdAGQn+iKGt3Wp/FR76L8D+zpAXiUXEV+3+9FyqhwGX9qRcIU
 Pe73FuKER/g0VS3cXNLfchuE0gVGYw+cmoeQEIKLwn+E3Ug++9xzf9SAW+FJOmDukXVTf+XN8s5lSblzwcMMwnAeX9gep+W5zLkrByuGhKQe0YQTHL7qBnTdjD5mqP14MdfZQuJNaNrHX2oupTxvlJ0RT8kR5qQQxnqhVTXidYiqaPM7oZ9vwysflu+r24matWS+D1j1Y1eITw/UB7+0BLADD8vngA0ZiL3JbNQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260828_024933_756643_59BE5E2F 
X-CRM114-Status: GOOD (  18.19  )
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

Assisted-by: Claude:claude-opus-5 checkpatch patch-audit
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

