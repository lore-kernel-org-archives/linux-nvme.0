Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2C5C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 14:03:26 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DACD36506D
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 14:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DACD36506D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:MIME-Version:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=qeCCPDaUPdasjKngCS6jW0jRVybxutVfXAGg0fytSu4=; b=ZI1e3+zdIQc3B41zQJBQhwht0
	84XN1313LQYK57lkTfdowGcOQ800pUi1m+woBFu5jHXtxBi8pbW9gmFxRt+s7942zMocDpyildPVh
	4K1UWrz1rkC+5f03hP8JOYMlyEFgID01M9hqKggWdKosxUQBcG5/tj0vwAtgnTfYOLlQDOR18dXrg
	Lp8tLGVzZTSsGPUnkHP4hYXdegHqke6VjcqRjzk2LBuKKcbs2+7GuP7LJRDeDtB6PJ7VrgQYk5jsP
	erOaKIJZkSaP6kneelbHJkV9FCfZxjQDlZkHbFte3KEL73QA0VcOjBE5nEbUa/pIjyHEUUgNRgWhK
	nupCTkSnQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMAHp-000tbv-1I; Tue, 16 Mar 2021 14:03:05 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMAHL-000tag-FH
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 14:02:40 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20210316140230epoutp015a0c871d6de8899f06b84b8fe33d40b3~s14k_GrXm2857528575epoutp01W
 for <linux-nvme@lists.infradead.org>; Tue, 16 Mar 2021 14:02:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20210316140230epoutp015a0c871d6de8899f06b84b8fe33d40b3~s14k_GrXm2857528575epoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1615903350;
 bh=mdaufHx0bUEjBhPOkbAgzTzXCyGCDsn9xgfDjFd/sFo=;
 h=From:To:Cc:Subject:Date:References:From;
 b=RJga9IX92nACli0Pd+DullxEgaa9ro8x+j2vuNprOldJj3BanqMLMUDeKd7KpTtdO
 agS3AIpGi2K7dlKmlk3tkS5BlkK60rYY5pek2E51J7uWBHlrYQmDrFYBSZqWIgATPY
 CdmrQc2EpLcqE4EBEeDDz6/Bnsm4f3DI0BzpDn0c=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTP id
 20210316140229epcas5p499a7458cd8e3a1fc647f67dd1cfea63a~s14kKeEpw1408314083epcas5p4z;
 Tue, 16 Mar 2021 14:02:29 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
 epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 0B.A5.15682.57AB0506; Tue, 16 Mar 2021 23:02:29 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
 20210316140229epcas5p23d68a4c9694bbf7759b5901115a4309b~s14jk27NG3056830568epcas5p2q;
 Tue, 16 Mar 2021 14:02:29 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20210316140229epsmtrp102b7fcee7a9570c0a48787924323628f~s14jj-6UY0307603076epsmtrp1X;
 Tue, 16 Mar 2021 14:02:29 +0000 (GMT)
X-AuditID: b6c32a49-8bfff70000013d42-16-6050ba7584d4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 3D.54.08745.57AB0506; Tue, 16 Mar 2021 23:02:29 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20210316140227epsmtip2fddaddf9cd8d4a779024d06a3fc53e58~s14h38ylC1114511145epsmtip2d;
 Tue, 16 Mar 2021 14:02:27 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, chaitanya.kulkarni@wdc.com
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 anuj20.g@samsung.com, javier.gonz@samsung.com, nj.shetty@samsung.com,
 selvakuma.s1@samsung.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: [RFC PATCH v3 0/3] Async nvme passthrough over io_uring
Date: Tue, 16 Mar 2021 19:31:23 +0530
Message-Id: <20210316140126.24900-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsWy7bCmum7proAEg6eNJhZNE/4yW6y+289m
 Mev2axaLlauPMlm8az3HYvH4zmd2i6P/37JZTDp0jdFi/rKn7Bbbfs9ntrgyZRGzxesfJ9kc
 eDwuny312LSqk81j85J6j903G9g8+rasYvT4vEnOo/1AN1MAexSXTUpqTmZZapG+XQJXxq+f
 e9kLNnFV7O37xd7AuJaji5GTQ0LARGLx9H1sXYxcHEICuxklTn6+zgzhfGKUuP/mJTuE85lR
 4tKHfkaYlosv9rKA2EICuxgl+u8LQthARTvb5boYOTjYBDQlLkwuBQmLCARI7Dr4mQnEZhY4
 yijxaGU1iC0s4CCx9tNrVpByFgFViSsPrUDCvAIWEusmP4baJC8x89J3doi4oMTJmU9YIMbI
 SzRvnQ12p4RAI4fE5xW9rBANLhJ3V21gh7CFJV4d3wJlS0m87G+Dsoslft05CtXcwShxvWEm
 C0TCXuLinr9MIAcxA92/fpc+xDI+id7fT8DCEgK8Eh1tQhDVihL3Jj2FWisu8XDGEijbQ+LM
 nTYmSIjESvR9O8k0gVFuFpIXZiF5YRbCsgWMzKsYJVMLinPTU4tNCwzzUsv1ihNzi0vz0vWS
 83M3MYKTj5bnDsa7Dz7oHWJk4mA8xCjBwawkwmuaF5AgxJuSWFmVWpQfX1Sak1p8iFGag0VJ
 nHeHwYN4IYH0xJLU7NTUgtQimCwTB6dUA9OyHZ9kf3yddTn2Ybrl23y342LafDO7o6TkIzib
 hRe/ePKAc4L/xjVr7KeKGD/655n55bdS7631QkrrM68xnX2ru6bkVdGtx7G7+e7d5KhNWyfG
 bmbwYcfkf291Uxveqzk6X1TvPPrsxkKeEyLVQqvDpv55N+XWd6vcb2snmLKv7jmhK3GkhF9q
 30oux0nJCoenfXZ58vFopSef/p5V+4qkK3ov3XH7dmFDY8SBN+8iP8Rzm6saywTeKN1w+szb
 QzJzc/50q8TdXTQj1i53qY6f3Ws2M+sFpyecFbyywdT84vanLTvTD5+erZy9jf+CEPve4ngF
 zxO7g24Fa/KcXcLbcvFz3W8mBaHfn6csr/HeqsRSnJFoqMVcVJwIAOBHFoetAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPLMWRmVeSWpSXmKPExsWy7bCSvG7proAEgzd3OS2aJvxltlh9t5/N
 Ytbt1ywWK1cfZbJ413qOxeLxnc/sFkf/v2WzmHToGqPF/GVP2S22/Z7PbHFlyiJmi9c/TrI5
 8HhcPlvqsWlVJ5vH5iX1HrtvNrB59G1ZxejxeZOcR/uBbqYA9igum5TUnMyy1CJ9uwSujF8/
 97IXbOKq2Nv3i72BcS1HFyMnh4SAicTFF3tZuhi5OIQEdjBKNP6ZygSREJdovvaDHcIWllj5
 7zk7RNFHRolfy1cBFXFwsAloSlyYXApSIyIQItE1bxsTSA2zwFlGieWP2xlBEsICDhJrP71m
 BalnEVCVuPLQCiTMK2AhsW7yY0aI+fISMy99Z4eIC0qcnPmEBcRmBoo3b53NPIGRbxaS1Cwk
 qQWMTKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz0vWS83M3MYLDXEtrB+OeVR/0DjEycTAeYpTg
 YFYS4TXNC0gQ4k1JrKxKLcqPLyrNSS0+xCjNwaIkznuh62S8kEB6YklqdmpqQWoRTJaJg1Oq
 gYk1O2y/6+Vy7c+zrBR/+L0JXlvzzFvhXEZNQtQll7SYPW8r36y5YjbT+lSokzK3Fb/NOacj
 8ftV198+9INrVfgBjhvLLHcwBl1k4n36LU7UVzm1KviDLf/Wg5/nO7cyXmeT3VHC92T96vnS
 O8/3hh7xfH69uiXs7qS9unXmvgnyfZlzr/foPZJ6HmfvKb9C3uCBplbbumANhoeFba9DLHzD
 FstdFm5Zvb9a8OQEudk3NDN3l148XlEpEF658a1kvY3A/19vHh50X3itU7+AvSD26E+1GRM/
 7Zng0u0T/jvn3PHXR/YusTBcod9Tm7UmzvxZ0sKr4R7MZaJuK1T+LY3SNa76Jb8rYxZj8v89
 r5VYijMSDbWYi4oTAd2JUEfiAgAA
X-CMS-MailID: 20210316140229epcas5p23d68a4c9694bbf7759b5901115a4309b
X-Msg-Generator: CA
CMS-TYPE: 105P
X-CMS-RootMailID: 20210316140229epcas5p23d68a4c9694bbf7759b5901115a4309b
References: <CGME20210316140229epcas5p23d68a4c9694bbf7759b5901115a4309b@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_140236_333710_BFFFADCB 
X-CRM114-Status: GOOD (  14.28  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This series adds async passthrough capability for nvme block-dev over
iouring_cmd. The patches are on top of Jens uring-cmd branch:
https://git.kernel.dk/cgit/linux-block/log/?h=io_uring-fops.v3

Application is expected to allocate passthrough command structure, set
it up traditionally, and pass its address via "block_uring_cmd->addr".
On completion, CQE is posted with completion-status after any ioctl
specific buffer/field update.

Changes from v2:
1. Rebase against latest uring-cmd branch of Jens
2. Remove per-io nvme_command allocation
3. Disallow passthrough commands with non-zero command effects

Change from v1:
1. Rewire the work on top of Jens uring-cmd interface
2. Support only passthrough, and not other nvme ioctls

Kanchan Joshi (3):
  io_uring: add helper for uring_cmd completion in submitter-task
  nvme: keep nvme_command instead of pointer to it
  nvme: wire up support for async passthrough

 drivers/nvme/host/core.c     | 186 ++++++++++++++++++++++++++++++-----
 drivers/nvme/host/fabrics.c  |   4 +-
 drivers/nvme/host/lightnvm.c |  16 +--
 drivers/nvme/host/nvme.h     |   5 +-
 drivers/nvme/host/pci.c      |   1 +
 fs/io_uring.c                |  36 ++++++-
 include/linux/io_uring.h     |   8 ++
 7 files changed, 213 insertions(+), 43 deletions(-)

-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
