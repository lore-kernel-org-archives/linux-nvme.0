Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4DB9EB64DD
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Aug 2023 16:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=rER2SxltLW8WJptcHT3X2JM9O0QBMeVwv+G6lA/CjXU=; b=QF0gpX46jDoW0FVf4toRBpwlJP
	gRAodvCkajZMSMIrIj9qY5I2benKaX7YGuu810YBLy1LMPCnKIWnrFO9qEhFgRnq3WKDWcude425d
	2D1xrYZPea+HsU9Wf+Cwfqx2Gj8b5iDZ6FSwMQkRdgeMCLjoPy1TfW7SN15Ot5/pd2eRd28MXw/08
	QIKIrvLtxwg2hZ7TFui3Rb3tvnS/VLqcLKnVhSAYMHYIKwsVv3mEkgYbnrrma1ocMXetBRlR6Dys5
	rvt4R/SjFuoMw5oy5/WPFpJDgPrtkfzGop8upPacckNVrNZuMG2WpZNw7FY21IONg4lxTo4AcWNxG
	bew8gLHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qUUdM-00B2Tr-2L;
	Fri, 11 Aug 2023 16:05:04 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qUUdH-00B2Pc-0U
	for linux-nvme@lists.infradead.org;
	Fri, 11 Aug 2023 16:05:02 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230811160451epoutp02e633962db603c50f8ba6e5f6725d3602~6X8DUxBwA2757127571epoutp029
	for <linux-nvme@lists.infradead.org>; Fri, 11 Aug 2023 16:04:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230811160451epoutp02e633962db603c50f8ba6e5f6725d3602~6X8DUxBwA2757127571epoutp029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1691769891;
	bh=rER2SxltLW8WJptcHT3X2JM9O0QBMeVwv+G6lA/CjXU=;
	h=From:To:Cc:Subject:Date:References:From;
	b=HKvBakokTwwJYLSLeA2tAwcsGC33K5Wcrgh7LXkxAweIuhufaP9Yh+yYkDDc5NVFQ
	 GKEiMQ6b/XP0kbPkkcEidFvQf7tgfLqtqfBqMuIIKiTo9NNY464okhG8AVLHPVa9bF
	 WOnT1kWw80Ec5W118uIyPPbboyN/xeHwci8TQmo4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20230811160451epcas5p3a9e6d19795ae1eec30d7d507531677b9~6X8C4DMIy0040500405epcas5p3_;
	Fri, 11 Aug 2023 16:04:51 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4RMpXK2mYFz4x9Pt; Fri, 11 Aug
	2023 16:04:49 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	EA.82.55522.12C56D46; Sat, 12 Aug 2023 01:04:49 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20230811160449epcas5p3beee9d2c65c71e95d8e92f25fb1f98c4~6X8Awpi6v1729417294epcas5p37;
	Fri, 11 Aug 2023 16:04:49 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230811160449epsmtrp2e09fed40989c8962e690f8bbf2390472~6X8Avz5FU0442304423epsmtrp2k;
	Fri, 11 Aug 2023 16:04:49 +0000 (GMT)
X-AuditID: b6c32a49-419ff7000000d8e2-19-64d65c21cc4a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D2.81.34491.02C56D46; Sat, 12 Aug 2023 01:04:48 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20230811160447epsmtip244a09f7880d2f6f62e1c0189800f5ca1~6X7-RdEFM2904129041epsmtip20;
	Fri, 11 Aug 2023 16:04:47 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, vincentfu@gmail.com,
	ankit.kumar@samsung.com, joshiiitr@gmail.com, gost.dev@samsung.com, Kanchan
	Joshi <joshi.k@samsung.com>
Subject: [PATCH 0/2] Fix memory-corruption for passthrough metadata
Date: Fri, 11 Aug 2023 21:29:04 +0530
Message-Id: <20230811155906.15883-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjk+LIzCtJLcpLzFFi42LZdlhTU1cx5lqKwbKDohZrrvxmt1h9t5/N
	4uaBnUwWK1cfZbI4+v8tm8X5t4eZLCYdusZoMX/ZU3aLda/fs1hsaBN04PLYOesuu8f5extZ
	PC6fLfXYtKqTzWPzknqP3Tcb2Dz6tqxiDGCPyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUz
	MNQ1tLQwV1LIS8xNtVVy8QnQdcvMAbpOSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQ
	klNgUqBXnJhbXJqXrpeXWmJlaGBgZApUmJCd8WzTB/aCf2IV76/tYG1g3C7cxcjJISFgIjH9
	zUXmLkYuDiGB3YwSLw9sZ4FwPjFKtFz5wwjhfGOUmPj8PitMS1/3f6jEXkaJkwc7oPo/M0rc
	2LALqJ+Dg01AU+LC5FKQBhEBF4mGf2/AGpgFljBKzH+3hBkkISzgLLG9fx87iM0ioCrR9X0J
	C4jNK2AhMW3nfiaIbfISMy99Z4eIC0qcnPkErIYZKN68dTbYYgmBj+wStyasZ4ZocJF43f2M
	EcIWlnh1fAs7hC0l8fndXjYIO1ni0sxzUAtKJB7vOQhl20u0nupnBnmAGeiB9bv0IXbxSfT+
	fsIEEpYQ4JXoaBOCqFaUuDfpKTRQxCUezlgCZXtI7H12BewCIYFYiVcTdrBOYJSbheSDWUg+
	mIWwbAEj8ypGydSC4tz01GLTAsO81HJ4ZCbn525iBCdMLc8djHcffNA7xMjEwXiIUYKDWUmE
	95b7tRQh3pTEyqrUovz4otKc1OJDjKbAYJ3ILCWanA9M2Xkl8YYmlgYmZmZmJpbGZoZK4ryv
	W+emCAmkJ5akZqemFqQWwfQxcXBKNTDxz58cecVl/ceOE72/JtzhrvrgxB/1tKvc5WvNWV2P
	aKUGQ/U3CWlTZaV+WqR1Bmd+uBf7wSY142XGsrlnH1VOqzmxZeOvuddOxmjG3j4s4vPiXrvg
	4spjfls5Ph6Y3e5gu/OZqoFBh6BV5ZX3v2bkCaQb1UyeOu/u1odXnZcf2TJ9tfyji/wfT1Uy
	v+lbGXHreanAzdozMj0vHt72Mg1W01l5lfcN+8wn1v+cnFb5Fy8weKhoetZRYerLqSyCn13l
	ufVi/7y4tnmjmkzno7SJ8lqd++eWvpG2WSCze/P6vutaUYfS+JkPHOrZOlF7v1e7+4O7zuwM
	j02+NP5vqj48kad58d/+2HMZazdftjwXrsRSnJFoqMVcVJwIAPmJFwAhBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsWy7bCSvK5CzLUUg+6t1hZrrvxmt1h9t5/N
	4uaBnUwWK1cfZbI4+v8tm8X5t4eZLCYdusZoMX/ZU3aLda/fs1hsaBN04PLYOesuu8f5extZ
	PC6fLfXYtKqTzWPzknqP3Tcb2Dz6tqxiDGCP4rJJSc3JLEst0rdL4Mp4tukDe8E/sYr313aw
	NjBuF+5i5OSQEDCR6Ov+z9jFyMUhJLCbUeLrxsVsEAlxieZrP9ghbGGJlf+es0MUfWSU6Hty
	naWLkYODTUBT4sLkUpAaEQEviXmzF7CA2MwCqxgl/n7WA7GFBZwltvfvA5vDIqAq0fV9CVgN
	r4CFxLSd+5kg5stLzLz0nR0iLihxcuYTqDnyEs1bZzNPYOSbhSQ1C0lqASPTKkbJ1ILi3PTc
	YsMCw7zUcr3ixNzi0rx0veT83E2M4JDW0tzBuH3VB71DjEwcjIcYJTiYlUR4b7lfSxHiTUms
	rEotyo8vKs1JLT7EKM3BoiTOK/6iN0VIID2xJDU7NbUgtQgmy8TBKdXAJKT2fkWL6ysGXt+7
	tdOvN/oouctfnnOuoNzhsGLh+al7PrZGlG/a1azC2bW9+teJSjbpKvOs82uVnjat7DEVyOhP
	57+d+c3WYPUmy7tsP/cf5BQMt9PWOrEqV1200fIvk+XCnxOqLROdivQ/PZf9/bP1mUKz2wfx
	RXp3F7gwv8ivXtCX+EFL+My6rVcLF2+99EQ5xsRE/Vn9n8Iqg+qvczVs/5TIur/Ts1hn7jFh
	/qOjvZ0v5A6/7vwQf63mXCTzi7gWnbCvk3898ptYLsCp821r8IUDfjY7qiYlZ3tW1D1OePiV
	43mKUGmNEteeDUaHmqr/GUs865boXPnxTXtCf9X/yLncQRkrr/H+EA5UYinOSDTUYi4qTgQA
	2N+BxNgCAAA=
X-CMS-MailID: 20230811160449epcas5p3beee9d2c65c71e95d8e92f25fb1f98c4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230811160449epcas5p3beee9d2c65c71e95d8e92f25fb1f98c4
References: <CGME20230811160449epcas5p3beee9d2c65c71e95d8e92f25fb1f98c4@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230811_090459_905665_2A81FD19 
X-CRM114-Status: GOOD (  11.61  )
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

Malformed user-space application can specify smaller meta-buffer and
larger data-buffer.
For DIX namespace, nvme-driver allocates a meta-buffer (of same small size that
user specified) and that is passed to the device for DMA.
Device can do DMA writes (of larger length) into unrelated kernel
memory, leading to random crashes [1].


Patch 1: avoids the above for uring passthrough
Patch 2: avoid the same for sync passthrough


[1]
[ 6815.014478] general protection fault, probably for non-canonical address 0x70e3cdbe9133b7a6: 0000 [#1] PREEMPT SMP PTI
[ 6815.014505] CPU: 1 PID: 434 Comm: systemd-timesyn Tainted: G           OE      6.4.0-rc3+ #5
[ 6815.014516] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
[ 6815.014522] RIP: 0010:__kmem_cache_alloc_node+0x100/0x440
[ 6815.014551] Code: 48 85 c0 0f 84 fb 02 00 00 41 83 ff ff 74 10 48 8b 00 48 c1 e8 36 41 39 c7 0f 85 e5 02 00 00 41 8b 45 28 49 8b 7d 00 4c 01 e0 <48> 8b 18 48 89 c1 49 33 9d b8 00 00 00 4c 89 e0 48 0f c9 48 31 cb
[ 6815.014559] RSP: 0018:ffffb510c0577d18 EFLAGS: 00010216
[ 6815.014569] RAX: 70e3cdbe9133b7a6 RBX: ffff8a9ec1042300 RCX: 0000000000000010
[ 6815.014575] RDX: 00000000048b0001 RSI: 0000000000000dc0 RDI: 0000000000037060
[ 6815.014581] RBP: ffffb510c0577d58 R08: ffffffffb9ffa280 R09: 0000000000000000
[ 6815.014586] R10: ffff8a9ecbcab1f0 R11: 0000000000000000 R12: 70e3cdbe9133b79e
[ 6815.014591] R13: ffff8a9ec1042300 R14: 0000000000000dc0 R15: 00000000ffffffff
[ 6815.014597] FS:  00007fce590d6940(0000) GS:ffff8a9f3dd00000(0000) knlGS:0000000000000000
[ 6815.014604] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 6815.014609] CR2: 00005579abbb6498 CR3: 000000000d9b0000 CR4: 00000000000006e0
[ 6815.014622] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 6815.014627] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 6815.014632] Call Trace:
[ 6815.014650]  <TASK>
[ 6815.014655]  ? apparmor_sk_alloc_security+0x40/0x80
[ 6815.014673]  kmalloc_trace+0x2a/0xa0
[ 6815.014684]  apparmor_sk_alloc_security+0x40/0x80
[ 6815.014694]  security_sk_alloc+0x3f/0x60
[ 6815.014703]  sk_prot_alloc+0x75/0x110
[ 6815.014712]  sk_alloc+0x31/0x200
[ 6815.014721]  inet_create+0xd8/0x3a0
[ 6815.014734]  __sock_create+0x11b/0x220
[ 6815.014749]  __sys_socket_create.part.0+0x49/0x70
[ 6815.014756]  ? __secure_computing+0x94/0xf0
[ 6815.014768]  __sys_socket+0x3c/0xc0
[ 6815.014776]  __x64_sys_socket+0x1a/0x30
[ 6815.014783]  do_syscall_64+0x3b/0x90
[ 6815.014794]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[ 6815.014804] RIP: 0033:0x7fce59aa795b


Kanchan Joshi (2):
  nvme: fix memory corruption for passthrough metadata
  nvme: avoid memory corruption for sync passthrough

 drivers/nvme/host/ioctl.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

-- 
2.25.1


