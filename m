Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF12DC0218A
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jan 2025 17:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Y7I3FQn+a3IeKpvoyXVLY346phLoqlukuEhizyoucyY=; b=phpX/Ip/mD1M9QbgNNeht+/6AB
	6/xJIKGiq4lEzaRKz6mKvUQXGVRKFcju4Vsex0P94WLG5Z9Nny4k/TjiOyp+N1ZXJh8G//B1F8ABk
	9/gE2RQB3kNcZ6zkBWh+BO+XnG5h/Cq/PiBkoR3ZTRmWRvG643AZi8iguiKkux/VWqKDomlqLn97k
	6PYF2ohKtrGIdn55cqdyXIimRvWl7X7hqOS5aZVwHPZrhOPyteaPonWXlui8CC2g2GMwmstXmEoCj
	2M9hOpAKwmwRyW76jbhG9g0w7gZYEZkojLJYywLpwa6XPnycnl0sSgN0WVGXchpB4MT1eC2hVzTE5
	y3eIx2ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tcpG6-00000005Qhw-3MXa;
	Tue, 28 Jan 2025 17:20:18 +0000
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tcojl-00000005N48-34hj
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jan 2025 16:46:55 +0000
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-e3983426f80so9041980276.1
        for <linux-nvme@lists.infradead.org>; Tue, 28 Jan 2025 08:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738082812; x=1738687612; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7I3FQn+a3IeKpvoyXVLY346phLoqlukuEhizyoucyY=;
        b=dUkGACV75iI248keNkzdpGlTa8vSTqnbLEF85pqBQtNs4Uy5ncgRkyXbsbIDgMfMDf
         J4wXs3+4j96i/Lbz3+0M0+fcsCUU0EHXjs5F00eBzMAZ9ld0NHtlBh9xDRLEu+SDLm5W
         5kKCRlafcITa/pjcvHtyzmTXItOtYMVQ3oBHuZj3fBZGBbWvaT/ncJBQuip24jVoF+nS
         opISWGjAMOLWA4pJ6gAeok4Flk5w6VZDu6pafWnRiMEEQry2R6ODBQcgvgSKf/FuJtcz
         KyYNCbsoVpZjOqsSRZACVZ2uTm6kOqJP6OoVPpZBIXFWwMqjvqqKbM6m4cTPx1+FeDZf
         5Exw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738082812; x=1738687612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7I3FQn+a3IeKpvoyXVLY346phLoqlukuEhizyoucyY=;
        b=f9bel39F7sKaMbBpDuWiTQdkaGLyhqxgXkHgFAHzCcuJOkVPrhJVesIlfGRPRWC3Ux
         +D9WnschDAA4Qk9n6ZfuB83fwqW+niPQtn5oM3Z69jwXowx/jzhOIq38MnfvA3Q2AZrY
         3yoP0r8CbGSgXV9eHrRm2l02MPsDiiAO0CnK9mQchW+rz5viR7/FawWpPeI3IPUXGZpX
         /VnNCqUDq6Q+1Fjni0q7F+QGn7AjrwZL5H8HkTuvLYJXuHIztPgqDuueh58zTl6qu+xh
         D5kMlwr++UG4cMlxSzZuTSoB5j4mfh7FBK/23YX+LQfPHNLeFMVMQZdFuKp9y6Bpz9xg
         BykA==
X-Forwarded-Encrypted: i=1; AJvYcCUSPwFu2HDCAVVqUsCWoMLQDmJ0xN8h6U6aVpAVLHZ5u1lFVcxIhn4JUntbAizPuSd5yrPw4sEFmqRX@lists.infradead.org
X-Gm-Message-State: AOJu0YzSUV9/usY0nFnf9zoKTsP9ALenhK2uyup9jiDUDMPZ1cj8tvZ0
	F9IevWV1V7Ua6M4oCidCRghcb6Vu7Gu4KfRsMMk3VE7ONuP9NuJ8
X-Gm-Gg: ASbGncvAXrrH0Wp1wxSwF7A+df/aesYk1LPALIlo6RuSpVuaeYi0ESQdPT5ZukdTuKp
	FHefIRdfa4i2B91nuyGOLtvmTnWN86pjX1XHwGJ3fjHE5K5BF8C0ZGIizzk7RTQINvlmAkwpmVo
	cKk3tDjeStVdpVL8q82Y6YwcCK3oE7vgatIr9Ux4XflrDuRa+6dSPJHk61G0B8GUdtNhLizuWfe
	IAN5lQGAevMsvSiFQPKVWnr+Ak4tN8IPFV3/ET2SOlNG3iYcl2AqO5v12aILXFDlrnd9eCmOsqZ
	yKUmDAYP4cMdJ2yodn85MXdsZg8E0fV3j4K2cHFv8zILcpYN8H4=
X-Google-Smtp-Source: AGHT+IFvmgf54bypeg06iXMG7R6vW3zKyn1725RIYJUIjUALciExdJNbHjTn7B/5gtx7qirVGTp6aA==
X-Received: by 2002:a05:6902:70c:b0:e58:5a:7694 with SMTP id 3f1490d57ef6-e58005a7945mr26770575276.20.1738082811957;
        Tue, 28 Jan 2025 08:46:51 -0800 (PST)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e583b7697c9sm2098812276.16.2025.01.28.08.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 08:46:51 -0800 (PST)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Haren Myneni <haren@linux.ibm.com>,
	Rick Lindsley <ricklind@linux.ibm.com>,
	Nick Child <nnac123@linux.ibm.com>,
	Thomas Falcon <tlfalcon@linux.ibm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	James Smart <james.smart@broadcom.com>,
	Dick Kennedy <dick.kennedy@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Matt Wu <wuqiang.matt@bytedance.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kurz <groug@kaod.org>,
	Peter Xu <peterx@redhat.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: [PATCH v2 00/13] cpumask: cleanup cpumask_next_wrap() implementation and usage
Date: Tue, 28 Jan 2025 11:46:29 -0500
Message-ID: <20250128164646.4009-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250128_084653_772106_409F37EF 
X-CRM114-Status: GOOD (  15.68  )
X-Mailman-Approved-At: Tue, 28 Jan 2025 09:20:17 -0800
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

cpumask_next_wrap() is overly complicated, comparing to it's generic
version find_next_bit_wrap(), not mentioning it duplicates the above.
It roots to the times when the function was used in the implementation
of for_each_cpu_wrap() iterator. The function has 2 additional parameters
that were used to catch loop termination condition for the iterator.
(Although, only one is needed.)

Since 4fe49b3b97c262 ("lib/bitmap: introduce for_each_set_bit_wrap()
macro"), for_each_cpu_wrap() is wired to corresponding generic
wrapping bitmap iterator, and additional complexity of
cpumask_next_wrap() is not needed anymore.

All existing users call cpumask_next_wrap() in a manner that makes
it possible to turn it to a straight and simple alias to
find_next_bit_wrap().

This series replaces historical 4-parameter cpumask_next_wrap() with a
thin 2-parameter wrapper around find_next_bit_wrap().

Where it's possible to use for_each_cpu_wrap() iterator, the code is
switched to use it because it's always preferable to use iterators over
open loops.

This series touches various scattered subsystems and To-list for the
whole series is quite a long. To minimize noise, I send cover-letter and
key patches #5 and 6 to every person involved. All other patches are sent
individually to those pointed by scripts/get_maintainers.pl.

I'd like to move the series with my bitmap-for-next branch as a whole.

v1: https://lore.kernel.org/netdev/20241228184949.31582-1-yury.norov@gmail.com/T/
v2:
 - rebase on top of today's origin/master;
 - drop #v1-10: not needed since v6.14 @ Sagi Grinberg;
 - #2, #3: fix picking next unused CPU @ Nick Child;
 - fix typos, cleanup comments @ Bjorn Helgaas, Alexander Gordeev;
 - CC Christoph Hellwig for the whole series.

Yury Norov (13):
  objpool: rework objpool_pop()
  virtio_net: simplify virtnet_set_affinity()
  ibmvnic: simplify ibmvnic_set_queue_affinity()
  powerpc/xmon: simplify xmon_batch_next_cpu()
  cpumask: deprecate cpumask_next_wrap()
  cpumask: re-introduce cpumask_next{,_and}_wrap()
  cpumask: use cpumask_next_wrap() where appropriate
  padata: switch padata_find_next() to using cpumask_next_wrap()
  s390: switch stop_machine_yield() to using cpumask_next_wrap()
  scsi: lpfc: switch lpfc_irq_rebalance() to using cpumask_next_wrap()
  scsi: lpfc: rework lpfc_next_{online,present}_cpu()
  PCI: hv: Switch hv_compose_multi_msi_req_get_cpu() to using
    cpumask_next_wrap()
  cpumask: drop cpumask_next_wrap_old()

 arch/powerpc/xmon/xmon.c            |  6 +--
 arch/s390/kernel/processor.c        |  2 +-
 drivers/net/ethernet/ibm/ibmvnic.c  | 18 +++++---
 drivers/net/virtio_net.c            | 12 ++---
 drivers/pci/controller/pci-hyperv.c |  3 +-
 drivers/scsi/lpfc/lpfc.h            | 23 +++-------
 drivers/scsi/lpfc/lpfc_init.c       |  2 +-
 include/linux/cpumask.h             | 69 ++++++++++++++++++++---------
 include/linux/objpool.h             |  7 ++-
 kernel/padata.c                     |  2 +-
 lib/cpumask.c                       | 37 +---------------
 11 files changed, 81 insertions(+), 100 deletions(-)

-- 
2.43.0


