Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 402D4E77188
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Jan 2025 07:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nmPTlVzrMWsZV/0UuabLUVbV1EH4j//h4cVfthapkOk=; b=ZlgsKQmGspTJkNSWPUYEh303mu
	FF2RVovTA5PFU98G6ZiYxAO1Ie+vuuAgWy9R1iquiED5GObBgN+1yPZlROlq75gkVwtB7HnCV0jyI
	+nam0wIYOXc5iLzLTwtsVfabQEYMN/WYyGXZh5dGY9WIfsvpWlaXeQx+6A2/soSsutVKhhR4HIitS
	LnpMjqWQVhDlnTA8D/T9cfve8TZyxTpkrA0R6dh4szEao7mH1QPaRsf2fBkKK7GD8Or0WY7MWxiJi
	3Ti58ZLrYTN/q4w7DHWHvlnwqh5REDkl7De/YT2OG8HfLvmtOmyBsh9YiacbSb22rezbPkv/GznGX
	kjchHxgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tTbnK-0000000CIai-43wl;
	Fri, 03 Jan 2025 07:08:30 +0000
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tRbsq-00000002G6F-1OYT
	for linux-nvme@lists.infradead.org;
	Sat, 28 Dec 2024 18:49:57 +0000
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-e461015fbd4so4300351276.2
        for <linux-nvme@lists.infradead.org>; Sat, 28 Dec 2024 10:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735411794; x=1736016594; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nmPTlVzrMWsZV/0UuabLUVbV1EH4j//h4cVfthapkOk=;
        b=HyHJ8J1Wbnob4cOmB0r/u76oDsA+kcNizRKnLuj2hYyPb/aIOeplFOLHZWM36J8T/9
         K/i3xjeJt+E+jCgUyFSvv7To0J7f8WFGZgf+HSjlR2ar3OijHXEKhpfDWj6vszdFHskY
         kOXA1cqj+wWU8jsaP9llbOVw/FZY67MHGR+YwRZVVhTmcR9ob58NhMkcW7GvXp4Sn0CV
         NOmcCSI6aIBo85iCR0C5010SPCU6OA4FhHCaZc+d2HyDl2xjiZMQTfdNhKF6IqdrL1e0
         3N1VrSpJBkPdyRglODvFkWg+Sgy8nxQHpO6Cn/OTu00JXRqu0KIfvR2nXHsq3k/W5IDI
         HmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735411794; x=1736016594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nmPTlVzrMWsZV/0UuabLUVbV1EH4j//h4cVfthapkOk=;
        b=saRi/nD/j2i0UxQ5fXLDVCIm4rxriTSv10aBLPBWC2jSbKp6ujZyIg2qnWq094eQPx
         JNQUth2Ql1VQYmqY2YQFD++au8xF2xrYQ0YxMBV8FUXWAi5XDw70JxIaY2T+LB1yAInl
         ioIkAWBeGWzIMstxCNNDl1fMxlt1HozbRrq4PPVH7uukobBHG+IEVzWqfdZT/4PuU+Pr
         N6DffEzET7WE/0TR8AHLu13VL1+k/sAKENeNEoPhBCAEi/3wKFrsSDa1feNKT2OZc5Ty
         Y+myBMiwZTQzA04swXJ2vfru4bzjYllb8e6mtmL+pbfgzN7mRA6PBJSd7mX39N/yYxg9
         xhmg==
X-Forwarded-Encrypted: i=1; AJvYcCXTbAOnv5Ii/Dr3S3NQFl87HG71qKP2UDpVse78SawWdU37GBlyesMgG/x2CJjPjDMdhDhsgBUGjrG/@lists.infradead.org
X-Gm-Message-State: AOJu0Yx3YoGvci7HQPXVAFtJvSvJZpCknIH9u/zUhIXrwE0Jys1YwQCO
	1PdRdPAPTDkrbcH03zuSX2f26BEd4nhwydiz1RCZ7lf82mni0z3Q
X-Gm-Gg: ASbGncu10YWqXNbB4iAsoZw8UI3WBSx0WzQOeN6ASrPONksfO+UhFx5gzptdqdhoGZV
	cn/DtG2BfNVpaat0RxHnTrgd2fGqIWkFnf0pErFZhSSebxm6eHUYF4JhsRVLRd7EwbAsc0Vf/1x
	PcpLxGUYjPknD358W2iP1hrVrfRjHnFYMAjUnilXWg8ruvHh2z6aFNbpKL09eWU5v0xWH0c506y
	QLZzL7t4LvzESZhmwsuX5YvFyI1t/O1nmagtgKLhhxf36Lic1ogb2w0oi6RtWFFgmL9aae39rxf
	Z7vXJflJW2ZOWTWj
X-Google-Smtp-Source: AGHT+IEkJJFH0m3oTNAbR0yAINMZTww0cO+zE7+Lf9uNhKvuTxiLtpcDAvH2RV2/PHCyo+AVfgp8KA==
X-Received: by 2002:a05:6902:18c1:b0:e39:8b94:16e6 with SMTP id 3f1490d57ef6-e538c3a2eb7mr19599866276.39.1735411794393;
        Sat, 28 Dec 2024 10:49:54 -0800 (PST)
Received: from localhost (c-24-129-28-254.hsd1.fl.comcast.net. [24.129.28.254])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e537cbedbe7sm5061343276.4.2024.12.28.10.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2024 10:49:53 -0800 (PST)
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
Subject: [PATCH 00/14] cpumask: cleanup cpumask_next_wrap() implementation and usage
Date: Sat, 28 Dec 2024 10:49:32 -0800
Message-ID: <20241228184949.31582-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241228_104956_384332_D3726CB9 
X-CRM114-Status: GOOD (  13.59  )
X-Mailman-Approved-At: Thu, 02 Jan 2025 23:08:30 -0800
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

Yury Norov (14):
  objpool: rework objpool_pop()
  virtio_net: simplify virtnet_set_affinity()
  ibmvnic: simplify ibmvnic_set_queue_affinity()
  powerpc/xmon: simplify xmon_batch_next_cpu()
  cpumask: deprecate cpumask_next_wrap()
  cpumask: re-introduce cpumask_next_wrap()
  cpumask: use cpumask_next_wrap() where appropriate
  padata: switch padata_find_next() to using cpumask_next_wrap()
  s390: switch stop_machine_yield() to using cpumask_next_wrap()
  nvme-tcp: switch nvme_tcp_set_queue_io_cpu() to using
    cpumask_next_wrap()
  scsi: lpfc: switch lpfc_irq_rebalance() to using cpumask_next_wrap()
  scsi: lpfc: rework lpfc_next_{online,present}_cpu()
  PCI: hv: switch hv_compose_multi_msi_req_get_cpu() to using
    cpumask_next_wrap()
  cpumask: drop cpumask_next_wrap_old()

 arch/powerpc/xmon/xmon.c            |  6 +---
 arch/s390/kernel/processor.c        |  2 +-
 drivers/net/ethernet/ibm/ibmvnic.c  | 17 +++++-----
 drivers/net/virtio_net.c            | 12 +++++---
 drivers/nvme/host/tcp.c             |  2 +-
 drivers/pci/controller/pci-hyperv.c |  3 +-
 drivers/scsi/lpfc/lpfc.h            | 23 +++-----------
 drivers/scsi/lpfc/lpfc_init.c       |  2 +-
 include/linux/cpumask.h             | 48 ++++++++++++++++-------------
 include/linux/objpool.h             |  7 ++---
 kernel/padata.c                     |  2 +-
 lib/cpumask.c                       | 37 ++--------------------
 12 files changed, 60 insertions(+), 101 deletions(-)

-- 
2.43.0


