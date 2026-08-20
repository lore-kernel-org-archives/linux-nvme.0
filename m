Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8169BC5DF81
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2026 19:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2O/2dv3vAMW5OP3cGNIdUoe9lfLCfo93pjtBUDdPVAY=; b=WEQh6u94mCvCbaUiv5qSu+ud6b
	SUwndxCuZ9wS4T/G/ENB25QwWr4+6crEW5ScJJv8yM7qD2sAQQOO00fBD05ReGEsCdwbACKfSSFL/
	fGt9txFfR1Aec5aMeZH/3Q06WcrAJmoeZ9fp7hyWcxrAQtTEly9FvTixgP+/GEIElghMQqVAL4noa
	kRBqjpHUT83y+Wa4tUYab+yS/QNOSfCT+zDEGMDxMYnksJMefjGENjEsV2CQdaIIP9/rZa0RClMmq
	kBEw4ug9oOktjllia8ONLbf8CvO6uiVS9dXRvnmLwI1iiMYGhEMRohhiRInjcNA+kr/LA6GbVtYmE
	ju4sbzYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wx8qJ-0000000C97i-0cFA;
	Thu, 20 Aug 2026 19:54:27 +0000
Received: from mr-2005k-snip6-11.eps.apple.com ([2a01:b747:3000:206::6f] helo=outbound.mr.icloud.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wx8qG-0000000C97M-2tZt
	for linux-nvme@lists.infradead.org;
	Thu, 20 Aug 2026 19:54:25 +0000
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-20-percent-0 (Postfix) with ESMTPS id 795BA180016E;
	Thu, 20 Aug 2026 19:54:21 +0000 (UTC)
X-ICL-RepId: 01a020bd-2393-7420-9098-b511cb4e69cc
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQhABkMAWBxBDkkdXwZfEhVdRVUIRRlTHhccRgxFGVswVB0dDlgGEhZdRV4IGQhdHRkKUFAAS1oVVRcOAkIfUB9MFldDWhkcGVoUXBhTRVEfVFhDGUVWaUELTx1dGVscQmRYVwkKBldeWhdeTVoCVk0FSgNfAVsKQglJClgDWgdeC08GWwdTH0EUHlYfRQpcXl0NUh9FAnIdXFZQAlpVEgRACFZQXgheH0wc
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai; t=1787255663; x=1789847663; bh=2O/2dv3vAMW5OP3cGNIdUoe9lfLCfo93pjtBUDdPVAY=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=1ZNNyawkYLV8UofTOQDia9XddhfaFtGBBx7eroZsrL856vDEEJFsou5E+W4ZOtDKe7aegjbUIP2rlROrvHK4RsR8FbkXi5TOqSQabI6wg36nslEgVUKk+JmkbTp6pEffT/hDM4nKTxtsr1Dp5g3Tm2aj/bWq/EcE5mo/HgwEvb7YcExZWM1FhooNSWm0C8J0UWUsDzDWWm9Y97Yb+vJuUi1H1wzqbh6kNZk6t4HwSg27s/iFTxNX4LSa05oE4RFpCsDtRJWWgoXdhURgzKSraJCeyP5VuNkxnTQF5cqQuidlW2km/c+dLmeeWC+9ixMXvgKa5YJItWoMB1VbfnWncw==
Received: from ncore (unknown [17.156.200.36])
	by p00-icloudmta-asmtp-us-west-2a-20-percent-0 (Postfix) with ESMTPSA id 9707118008F5;
	Thu, 20 Aug 2026 19:54:19 +0000 (UTC)
From: Ferran Duarri <ferran.duarri@me.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ferran Duarri <ferran.duarri@me.com>
Subject: [PATCH] nvme: lower default APST max latency to 25ms
Date: Thu, 20 Aug 2026 21:54:14 +0200
Message-ID: <20260820195415.275608-1-ferran.duarri@me.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 93jMXTaZdV7aa5fQdYil3maPDQrrLgh8
X-Authority-Info-Out: v=2.4 cv=Wp8m8Nfv c=1 sm=1 tr=0 ts=6a875b6e
 cx=c_apl:c_pps:t_out a=9mRn2PO/+PIrVdEbaIuMPg==:117
 a=9mRn2PO/+PIrVdEbaIuMPg==:17 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=B9nqV3Rn1-QA:10 a=VkNPw1HP01LnGYTKEx00:22 a=HHGDD-5mAAAA:8
 a=8uIbJeaS8xPCM5DfPzYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE1MCBTYWx0ZWRfX3fh5XLjCE4mn
 fg2K3buaU8PfE+snEV/gYjp2MsksquT9SxarSQAvRm6i4dEqM2gPdFbImIJ09K5H3uZSlSnQ3P6
 rTi5Cx7TrTuqZ0bR7goGu5RgfHvq42+aod+aKAGGkxstprW+5zHyeKOpjkdz8r33EBjguGKBUWD
 Liu6phWPB6t5wJkjuVrh/AHQU7CHkHtzC4jxk6CyLCFLJE+53nCo54aSjFHSaZs+7PR8mEQujnv
 43etjw74q/Uq1kCmq1r0Cj36Kv3c5LA6gJXWWkMlBUmmy8dwmbTfW3kIiG4tqVGZeXjX25x1VfV
 wKMANZCNDSc8ZESlQEXkksha2zcD8GgZrC+f2C3d+Wny0dBLGKubujukC9LFkE=
X-Proofpoint-ORIG-GUID: 93jMXTaZdV7aa5fQdYil3maPDQrrLgh8
X-JNJ: AAAAAAABLCdK8t+hGldUUxRP2zxcgHZtZ69go/8nnQXTQxeQRvAzs8SQTsNIcFVhsn3a58DOAZ6fsWoNserjfJ6vl5AFzA9tMFakcpWlGeK5+HQGOcI4+Jn/aoEzUGaGmK5Yy6rXtmOBOVqEZ3TnqzaRl85shGHVn1NZWDvYogboDN6+rQ17IyIJ7sf48b4sjhGWP5Ig4k70hoBOHH7tzw4w4p6I/ZjAF+5FgqM1glBiTnPm5EC8rlTS4n+43UqLdKhvpMsKOwTTjN6eWanYCbM4X47lkVWvLBrqogo7DwFtH8O68fy5xUHZ3FL/LfmG1oMW8J8yfXiwzdV8H3ymUBzB/9746fT2P0mYR1/CKcEzZURzK+uWagxbQx95f65Ilq4xrYD9GGCuUcR5i/FPtWfamlqAdBTQVIhiZwCKfVPYKhJt2YwuQ3ceDSS+F1r/1j+gy6rgkxO364BLIFs3y4k3FLuyV+GCq776hM+2b1EfR94CugkmpBTZZJMQeuhW+zYOj8ZRuvo1F6GQtrVfyEUIOG7FuqpH85JgMvFylYs/subANvlP/Uz/G4wk0M7syws6hZgBE5pLUhhNN8KONFVA2Uk2uEkYyqxPjt0ZY5Ile6z1nsHKbkTJig1F/RmOWQmSRTUPIsYCheRw2F1JeKSH8KD6XlYmC6MLDRcMluojCpZ9QicrYi7lsBrkIwRToe59QLWxOSkYlnoIVy2JKPbf3lvij0GiJKCiRJwG5sebmIPiIgfs89ZuK1MqF6NLRdGp2waDbgCZBB3Xq/NNzz4pWq6QPqvn+vvpVtvrwyuwFz1WcEbXAFKe9Zvozjq/juTw/wGXnkeDnlUaOXw6o9l0rCM8l8w4vevIOe50F0tMPMGM3hVrlBwHVawzs+Pd5jSeg45wEh5SvuXaaKPtvs9/5bJ4tPWkhZ68B5uZdtUv10bx35SX0ttTKiYdk0F+S4aXFHamY47leqNa29hvpZLfrqjC8cL
 +dZB4GjzRe5HxvtfYgdBlpqiOQ7mTVolbad1/26c1rq7CMl89v2VwYfp4J/ODCdJmaSO7MP9x8M9GsmKzM/OrRIuFqY/0onznalBQXWLM4bT+mGi0HhZ/jMm0g/NuZOhNqu1hPEcBGpqe7Y2MJKXO6fMknW6FENPuXGnKWookn2Iii3xASj/TbTB0tQF7Bn1Qz2SnERlBdWfakUGIZ8pNWxQwEkOAg8bK8dKw48qW9mlVgUzp
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260820_125424_731718_1FD95D76 
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

