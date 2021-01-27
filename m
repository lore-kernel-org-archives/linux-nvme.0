Return-Path: <SRS0=3Lap=G6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A98C433E6
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jan 2021 15:02:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08F30207D0
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jan 2021 15:02:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08F30207D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:MIME-Version:Message-Id:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=VwoURy6jYAm1OTYDiG3a5Ih7B5xH3dZDza8bn1+H7zc=; b=3ikbBBPrgr7KKi0f4GjGLpNyM
	CG2QLwF0h+dNVYrcuRd9vMsSaf8kd+YC6paxac8jP/tZo9wjTQSOGoteiYQyfRdyFbVV4jasubolo
	l6Vm6RAIjUm+7LJ+D+XS6oaMcr3Ef19dRslfvk+rQ/f2+aWzxSRqvQk7vHp93yf78ZSoeWENRcqa3
	UL9dtORHMT3qoKN3o+S39EAYlR6m5yU4tgB4aymMakC/XHCs7N4y5NhL3yXbqa6MQysf4LEjEMHy5
	rnsN0Ql9roY1Z8L4SwOmjcL3XLzNpsvixkU1kcH9lqKq8rKEWePD9JNxoFQeRdBfe6jW4Lgmij3de
	EK/EurWWQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4mKJ-0000w3-E8; Wed, 27 Jan 2021 15:01:47 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4mKC-0000tD-Ux
 for linux-nvme@lists.infradead.org; Wed, 27 Jan 2021 15:01:43 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20210127150136epoutp04b2bab1d9aa0f4d870bf624fe492280cb~eHud5qH0m2079320793epoutp04N
 for <linux-nvme@lists.infradead.org>; Wed, 27 Jan 2021 15:01:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20210127150136epoutp04b2bab1d9aa0f4d870bf624fe492280cb~eHud5qH0m2079320793epoutp04N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1611759696;
 bh=/y/wC+y+qAXvjcOOetUDXeKAPN6Gfevzpc0/eSbAaYk=;
 h=From:To:Cc:Subject:Date:References:From;
 b=Ej2CTDdmb4UwfaKiSQ7mmkEl6psEF0Ta4Guixvtmt4LiLfKmh5vWlAcDm223t6lkA
 VHD9GRngMuXbUX+ilmtvxxe7SeHiYRiE+TI6Wl8u+g9S+CCt7DCvq28PnT+UFFKpkQ
 FUNgoY1NyPrO1cF7WEheUWgvKqgp1gXP80IwoslY=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTP id
 20210127150135epcas5p4e4d14fb8a4d32d2b8b20fe6d06583ff5~eHuc_L6aS1817018170epcas5p4q;
 Wed, 27 Jan 2021 15:01:35 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
 epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
 76.A0.33964.E4081106; Thu, 28 Jan 2021 00:01:35 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
 20210127150134epcas5p251fc1de3ff3581dd4c68b3fbe0b9dd91~eHucR5GAU2309923099epcas5p2g;
 Wed, 27 Jan 2021 15:01:34 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20210127150134epsmtrp29f12da6ad6b5258d68b481385c0eaded~eHucQ-enw0989109891epsmtrp2m;
 Wed, 27 Jan 2021 15:01:34 +0000 (GMT)
X-AuditID: b6c32a4b-ea1ff700000184ac-7d-6011804e2981
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 CA.05.13470.E4081106; Thu, 28 Jan 2021 00:01:34 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20210127150132epsmtip21a0aa87a0d2e31bc0b2c9e4ff286fdaf~eHuaSkOnQ2273022730epsmtip22;
 Wed, 27 Jan 2021 15:01:32 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Subject: [RFC PATCH 0/4] Asynchronous passthrough ioctl
Date: Wed, 27 Jan 2021 20:30:25 +0530
Message-Id: <20210127150029.13766-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsWy7bCmpq5/g2CCwaMlTBa/p09htVh9t5/N
 YuXqo0wW71rPsVg8vvOZ3eLo/7dsFpMOXWO02LP3JIvF5V1z2CzmL3vKbrHt93xmiytTFjFb
 rHv9nsXi9Y+TbA58HufvbWTxuHy21GPTqk42j81L6j1232xg8+jbsorR4/MmuQD2KC6blNSc
 zLLUIn27BK6MKRsOMhdcEKs4PN2vgbFXqIuRk0NCwERix59ZLF2MXBxCArsZJba9usME4Xxi
 lLjftZAVwvnGKPHv1zs2mJZfvSugqvYySkxZ9hiq/zOjRG/3ceYuRg4ONgFNiQuTS0EaRARc
 JC78PsAOUsMs8I5R4vy9LYwgCWEBc4lXPx+C2SwCqhJTdm5jBbF5BSwk7m2awwKxTV5i5qXv
 7BBxQYmTM5+AxZmB4s1bZzODDJUQ6OSQeP8YokgCaNvzqS9ZIWxhiVfHt0DFpSQ+v9sL9UKx
 xK87R6GaOxglrjfMhNpmL3Fxz18mkA+YgT5Yv0sfYhmfRO/vJ2BhCQFeiY42aOApStyb9BRq
 lbjEwxlLoGwPiW+3doGtEhKIlZhzdSr7BEa5WUhemIXkhVkIyxYwMq9ilEwtKM5NTy02LTDO
 Sy3XK07MLS7NS9dLzs/dxAhOS1reOxgfPfigd4iRiYPxEKMEB7OSCK+dgmCCEG9KYmVValF+
 fFFpTmrxIUZpDhYlcd4dBg/ihQTSE0tSs1NTC1KLYLJMHJxSDUzrmGKjvY1VXvvqTdCc3bMw
 53pn9crYCzsmybtM0ft+wuxf6G+LFIF5Se7fP+s9qhF4w7bUuW7GJSF+4Zk6+p6nn9UmXkua
 VNAwb/Iu7zWTjmYwHf+mt3lLwRRWk6sHb0SU+fxQc/RInuY98RbXs63nj0y1Z93JGfFzW//U
 ZiXHH9m3ov4J/d5qe7XrLoP4wUy+ZHb+kICg+vI7jxTlI5QqkgPVBLQNVHkuPdvjdcm8rkQh
 Rn9aWnNaYeehxYFP1jrG1bGp5tSsauVQdjhttYhtj1FYmpvbq98BUwstdzrnqnl4Zx7QLNPd
 l3pPTG1BxcPSeqGTH6fd2WjOWD41fsKzxPY1EsESZ76VvtWXVmIpzkg01GIuKk4EAKIkCGy6
 AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOLMWRmVeSWpSXmKPExsWy7bCSvK5fg2CCwaJ7Aha/p09htVh9t5/N
 YuXqo0wW71rPsVg8vvOZ3eLo/7dsFpMOXWO02LP3JIvF5V1z2CzmL3vKbrHt93xmiytTFjFb
 rHv9nsXi9Y+TbA58HufvbWTxuHy21GPTqk42j81L6j1232xg8+jbsorR4/MmuQD2KC6blNSc
 zLLUIn27BK6MKRsOMhdcEKs4PN2vgbFXqIuRk0NCwETiV+8KJhBbSGA3o8Ttq5YQcXGJ5ms/
 2CFsYYmV/54D2VxANR8ZJWa+/Q/UwMHBJqApcWFyKYgpIuAlsW2pIUgJs8A3Rok1a0+xgvQK
 C5hLvPr5kBHEZhFQlZiycxtYnFfAQuLepjksEPPlJWZe+s4OEReUODnzCVicGSjevHU28wRG
 vllIUrOQpBYwMq1ilEwtKM5Nzy02LDDMSy3XK07MLS7NS9dLzs/dxAgOey3NHYzbV33QO8TI
 xMF4iFGCg1lJhNdOQTBBiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+FrpPxQgLpiSWp2ampBalF
 MFkmDk6pBiZmPX3T50d+53ma8ggwR15vn8A+OUjkjtVrGUejXUFxB0PzpjC5SMmmX7s7XeqG
 hfX3T1Jy5YcVK2/1rnss0eK8LaRCnkVl59ff6V7ZmVsf3q52vM64w1Wyz/5imNjRfR9WzVaV
 WWbPf2RbuvLlQ8ahjQL+b1bp6qtdyUsRj4jldlbt7mSa2/Vy+8yGoHNRvnNb139f48Oj3PCt
 livsf8MPdofKNAEDlj/Fiz7YrCquiF50o7NfUXnK7TAVF46iX3MKZXLXiV32PLmw/Kmi8a7v
 jcfZRWXWvmTQrxZ5eWH5M85XBv+0b95Jswj6rMwyVzZ8/6VlkdNXqVzttpu9QWn/42uqukJS
 1uWsx+8yKLEUZyQaajEXFScCAOnBizvqAgAA
X-CMS-MailID: 20210127150134epcas5p251fc1de3ff3581dd4c68b3fbe0b9dd91
X-Msg-Generator: CA
CMS-TYPE: 105P
X-CMS-RootMailID: 20210127150134epcas5p251fc1de3ff3581dd4c68b3fbe0b9dd91
References: <CGME20210127150134epcas5p251fc1de3ff3581dd4c68b3fbe0b9dd91@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210127_100141_716444_AA90E357 
X-CRM114-Status: GOOD (  16.49  )
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
Cc: selvakuma.s1@samsung.com, Kanchan Joshi <joshi.k@samsung.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 javier.gonz@samsung.com, nj.shetty@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This RFC patchset adds asynchronous ioctl capability for NVMe devices.
Purpose of RFC is to get the feedback and optimize the path.

At the uppermost io-uring layer, a new opcode IORING_OP_IOCTL_PT is
presented to user-space applications. Like regular-ioctl, it takes
ioctl opcode and an optional argument (ioctl-specific input/output
parameter). Unlike regular-ioctl, it is made to skip the block-layer
and reach directly to the underlying driver (nvme in the case of this
patchset). This path between io-uring and nvme is via a newly
introduced block-device operation "async_ioctl". This operation
expects io-uring to supply a callback function which can be used to
report completion at later stage.

For a regular ioctl, NVMe driver submits the command to the device and
the submitter (task) is made to wait until completion arrives. For
async-ioctl, completion is decoupled from submission. Submitter goes
back to its business without waiting for nvme-completion. When
nvme-completion arrives, it informs io-uring via the registered
completion-handler. But some ioctls may require updating certain
ioctl-specific fields which can be accessed only in context of the
submitter task. For that reason, NVMe driver uses task-work infra for
that ioctl-specific update. Since task-work is not exported, it cannot
be referenced when nvme is compiled as a module. Therefore, one of the
patch exports task-work API.

Here goes example of usage (pseudo-code).
Actual nvme-cli source, modified to issue all ioctls via this opcode
is present at-
https://github.com/joshkan/nvme-cli/commit/a008a733f24ab5593e7874cfbc69ee04e88068c5

With regular ioctl-
int nvme_submit_passthru(int fd, unsigned long ioctl_cmd,
                         struct nvme_passthru_cmd *cmd)
{
	return ioctl(fd, ioctl_cmd, cmd);
}

With uring passthru ioctl-
int nvme_submit_passthru(int fd, unsigned long ioctl_cmd,
                         struct nvme_passthru_cmd *cmd)
{
	return uring_ioctl(fd, ioctl_cmd, cmd);
}
int uring_ioctl(int fd, unsinged long cmd, u64 arg)
{
	sqe = io_uring_get_sqe(ring);

	/* prepare sqe */
	sqe->fd = fd;
	sqe->opcode = IORING_OP_IOCTL_PT;
	sqe->ioctl_cmd = cmd;
	sqe->ioctl_arg = arg;

	/* submit sqe */
	io_uring_submit(ring);

	/* reap completion and obtain result */
	io_uring_wait_cqe(ring, &cqe);
	printf("ioctl result =%d\n", cqe->res)
}

Kanchan Joshi (4):
  block: introduce async ioctl operation
  kernel: export task_work_add
  nvme: add async ioctl support
  io_uring: add async passthrough ioctl support

 drivers/nvme/host/core.c      | 347 +++++++++++++++++++++++++++-------
 fs/io_uring.c                 |  77 ++++++++
 include/linux/blkdev.h        |  12 ++
 include/uapi/linux/io_uring.h |   7 +-
 kernel/task_work.c            |   2 +-
 5 files changed, 376 insertions(+), 69 deletions(-)

-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
