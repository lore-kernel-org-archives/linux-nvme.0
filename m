Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD23AC04FFE
	for <linux-nvme@archiver.kernel.org>; Mon, 20 May 2024 11:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Reply-To:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bSZUkbC/ZQpCoDZSpk6xHyDNFo0X+YS5ZTMJ5s/Gxic=; b=VYFtZ443fhgeRWfVqPvu1zFeMA
	TYgJ7wWlj98+3HNupZMFUuakvBZ9QjditjKThUYy4RqdzSSs92b4IILXvX570bQNTEj5Gfyk4fgDm
	G1H0xIh2COQ5BtaSjIh6W7guMEsqiraeetQIDBXDzumbsvJ7GOj74jBjiOpp0arKq1U2HopQNeDaZ
	ZND72yJf9IuEsN0Yk6q7jeNi90eIH9OI/V8o5ToQltupEqJEztf9OtP1Qz9Vgg550r0UXcFFDYo3G
	d2tVs93fnM6zxjsJ5BT2wgP76XFeFsB3P+joRFmAj+HfgJklwZ7nOUr7s4CxamDQsFy2rmn3YGw00
	0NDaR52Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s91Sg-0000000EKdU-39nx;
	Mon, 20 May 2024 11:45:51 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s91Sc-0000000EKa8-2rhS
	for linux-nvme@bombadil.infradead.org;
	Mon, 20 May 2024 11:45:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=References:Content-Type:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bSZUkbC/ZQpCoDZSpk6xHyDNFo0X+YS5ZTMJ5s/Gxic=; b=eHWuB2QA3DnWmhZmfXIPi0dfN2
	J2QErwNS1v4qfy9pLsYKU/0txsMCte+5gO4jRI8acA9O8Vt+fRQw2OxSxDiVW4r/tB3CQpHkm4M2/
	TuUY7MBw5c0wTkzkJt1k6gXbufvNHi/OOcQCLQUvnzCp0S7sOmf8dVRzxxtE5rSDhc4YV3ytJwcbC
	Bl4yj469Bl3wh/vXw+jxucwLpa0M4kGmFVeBdrXwRIJt40IzQYtfn3ZJdeb9dj5ZQNLP4hTtn0/eA
	+kd3cGUydOt5eJlw6hjAorMA6c+dn4T7zlvlVYc0S4llHc/b4OHtQ07P/IPHV2o6iiWtQDfejUdhO
	/FJk91zQ==;
Received: from mailout2.samsung.com ([203.254.224.25])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s91SW-00000006S0W-0x6w
	for linux-nvme@lists.infradead.org;
	Mon, 20 May 2024 11:45:44 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240520114533epoutp02a3dffe5743eb73859c064699f42cf578~RL9bvF2wO1030610306epoutp02O
	for <linux-nvme@lists.infradead.org>; Mon, 20 May 2024 11:45:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240520114533epoutp02a3dffe5743eb73859c064699f42cf578~RL9bvF2wO1030610306epoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716205533;
	bh=bSZUkbC/ZQpCoDZSpk6xHyDNFo0X+YS5ZTMJ5s/Gxic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vbItXjMbSQNjCPdJ6bCxcJgvxWcRhv6Q2KjgWtfraq6Df6HoplhOcqKsxEkpUpLg4
	 xkhWvzhHhLJsjDuj2AtKMvdPSmMXsHEYI7wGNAHrXNKnGvxwwMtClCmI06X8fXYb8P
	 pVwf63mK3N2zXX9r+E1RZJMqrxQIt59rIFc1olcQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240520114532epcas5p3f34132c23d11b79ee9843c7df5910da8~RL9bL1Wrp0451804518epcas5p3n;
	Mon, 20 May 2024 11:45:32 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4VjbNV3HLrz4x9Pp; Mon, 20 May
	2024 11:45:30 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F5.80.19431.AD73B466; Mon, 20 May 2024 20:45:30 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240520103027epcas5p4789defe8ab3bff23bd2abcf019689fa2~RK737w-oH1831418314epcas5p46;
	Mon, 20 May 2024 10:30:27 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240520103027epsmtrp1946a4d61e2ae40463c15065f4c80c842~RK735Xxv22229722297epsmtrp1e;
	Mon, 20 May 2024 10:30:27 +0000 (GMT)
X-AuditID: b6c32a50-ccbff70000004be7-b5-664b37dab6c6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	A3.37.19234.3462B466; Mon, 20 May 2024 19:30:27 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
	[107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240520103024epsmtip228edfc3ec310b9b2361e5df416cb9fa3~RK70S6Ven2512325123epsmtip2H;
	Mon, 20 May 2024 10:30:23 +0000 (GMT)
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Alasdair
	Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka
	<mpatocka@redhat.com>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
	Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: martin.petersen@oracle.com, bvanassche@acm.org, david@fromorbit.com,
	hare@suse.de, damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com,
	joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com, Nitesh
	Shetty <nj.shetty@samsung.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v20 11/12] null: Enable trace capability for null block
Date: Mon, 20 May 2024 15:50:24 +0530
Message-Id: <20240520102033.9361-12-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240520102033.9361-1-nj.shetty@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTe1BUdRTH+91797LLuM1tgennGkqLTAHDY21ZfjggFD6ugQPlP5kVbssV
	CNhd9i6RphNPSeTpo3IDIUB5LAnyCghs2w0QhGhal4RBSWItJAGxxogB22XR/vuc7+98zzlz
	fnO4uGCFFHITFBpGrZAliUhHot3o+bLPeGDEYf+TCwLUONiHo8ziFRzpbhWRaNa4CNBnC0s4
	mtbnArQ8PIKj1r7bAFVUlhFoTN+Joe7K0xiq0/Vi6MvPszDU+/g+iU4bRgGymLUY6hn3Rl+d
	qCZQd88AgUxdpSQqv2RxQDX9qxgq+dSMoY7pDIDal8txdHl2nkDXxjehkZV+TtgLtOlGBD1Y
	CelO7S0HeuT2FYI2DafSzfUnSbql+hP6j5bzgP52LJ2kqwrPcOiCrDmS7syZ5NAPLOMEPX/V
	TNKFrfWAHqr4wSHa6e3E4HhGFsuo3RiFXBmboIgLEUXsjwmPCZD6i33EQShQ5KaQJTMhop2R
	0T67E5KsGxK5fShLSrVK0TKWFfntCFYrUzWMW7yS1YSIGFVskkqi8mVlyWyqIs5XwWi2i/39
	twVYEw8lxo8ZHnJUjwQfme4a8HSQTeUBHhdSEtiW8Q0nDzhyBVQ3gAOWK6Q9WARwPlOPPQ2y
	akdBHuCuWf7+zdeud1qTqvvWHTkYrM7WO9iSSMobXn/MtenOlA6Hp1pKCFuAUy04zDDayvK4
	TtQeePF6DbAxQXnA1eFujs3Mp7ZDc228fb4tUNekx23Ms8r6tgVgqwMpHQ/W3Wzg2JN2wgbt
	EGFnJ3ivv9XBzkI4U3RindNg3dla0m7OBlD7ixbYH0JhzmARbmuMU56wscvPLrvCc4OX1+bE
	qWdhwfI0Ztf5sOPCE3aHDY0VpJ03wtFHGetMw6Xp3PWlFgB4wTyGF4PN2v9bVABQD4SMik2O
	Y+QBKrGPgkl7+m9yZXIzWLsDr+gOoGta8TUAjAsMAHJxkTO/uXXvYQE/VnbkKKNWxqhTkxjW
	AAKsGyzBhS5ypfWQFJoYsSTIXyKVSiVBr0jFouf5szllsQIqTqZhEhlGxaif+DAuT5iOtd7Y
	3Wt86YF8lzIz8GvzRKRlZulAd8lscPieyhdfy//LZavu9QIX+mOj8k2yh1foqTs6V/PdzGbL
	u6vytMr7UdBVvhi98nDhfCgMuFvt+GPYF2drXALYgT+f+Scv1Oxt6j53c9NV15S9x76vcXdf
	nLpokjKX3tuaNDdTqO06FTZ1POXQ8bKffEIG8pQupbvyJ6vKO7F9Byu3qX9/66Db8juR4WXX
	+qv2HxsiDDuIRUcjD5tqINK6nO9E5Cee2RdxoO3Vsoktsg1YbhFKidyg9KKhX6jHv79KIL/q
	iHsP0ZQZymJRQz9jRjZ/WWt8Lqr4jcmJO70baz+4V/q+sH3UwxxlUYkINl4m9sLVrOw/6406
	/JAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsWy7bCSvK6zmneawYwXxhbrTx1jtmia8JfZ
	YvXdfjaL14c/MVpM+/CT2eLJgXZGi99nzzNbbDl2j9FiwaK5LBY3D+xkstizaBKTxcrVR5ks
	Zk9vZrI4+v8tm8WkQ9cYLZ5encVksfeWtsXCtiUsFnv2nmSxuLxrDpvF/GVP2S2WH//HZDGx
	4yqTxY4njYwW237PZ7ZY9/o9i8WJW9IW5/8eZ3WQ8bh8xdvj1CIJj52z7rJ7nL+3kcXj8tlS
	j02rOtk8Ni+p93ixeSajx+6bDWwei/sms3r0Nr9j89jZep/V4+PTWywe7/ddZfPo27KK0ePM
	giPsAcJRXDYpqTmZZalF+nYJXBk3D31mLfguVHH52SHmBsYWgS5GDg4JAROJr4/1uhi5OIQE
	tjNKXDjwgKWLkRMoLimx7O8RZghbWGLlv+fsEEXNTBJXTtxmB2lmE9CWOP2fAyQuIrCdWeJj
	czcTSAOzwFFmiQtrLEBsYQF3iaWnlzOC2CwCqhL/zu5hBenlFbCSuLoiA2K+vMTqDQfAdnEC
	hQ9s/QBWLiRgKXH3+ge2CYx8CxgZVjGKphYU56bnJhcY6hUn5haX5qXrJefnbmIER6hW0A7G
	Zev/6h1iZOJgPMQowcGsJMK7aYtnmhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe5ZzOFCGB9MSS
	1OzU1ILUIpgsEwenVANT0ObT0idPVk6euerWpKztq3Kn3opyVyhcEp0r37H+2FutzrkVfRMe
	F3Hs35r56Xbc0dV/e7lYp37jaZYQuBefyBZy/N/HvmxhCYNAptbnu49zWqhI3grw41av1quK
	zla02//S6bXwNStvZymvuD7z8zLdu4/5Z8U8Lvi+ti/0f7fY2cQXSoYd12U2Py0zWrxL0cVT
	MbRqoqNOaDNj3Fs94XXT+k09wmxLLRaLH/0w8zDzYu0DWQ233HhP7vqhdkLvtoF/otGSF0rJ
	E1YbaHdvsTUxf/zzvq3VDsWa/b63p2WuUVmZsfTxXdltBiFne9z3b12Se8z2Z4tE45+KEw/5
	oq5WsfXdf+hiWyZ3+aMSS3FGoqEWc1FxIgBOVbFnPwMAAA==
X-CMS-MailID: 20240520103027epcas5p4789defe8ab3bff23bd2abcf019689fa2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240520103027epcas5p4789defe8ab3bff23bd2abcf019689fa2
References: <20240520102033.9361-1-nj.shetty@samsung.com>
	<CGME20240520103027epcas5p4789defe8ab3bff23bd2abcf019689fa2@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240520_124541_492469_9E3E4038 
X-CRM114-Status: GOOD (  18.60  )
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

This is a prep patch to enable copy trace capability.
At present only zoned null_block is using trace, so we decoupled trace
and zoned dependency to make it usable in null_blk driver also.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 drivers/block/null_blk/Makefile | 2 --
 drivers/block/null_blk/main.c   | 3 +++
 drivers/block/null_blk/trace.h  | 2 ++
 drivers/block/null_blk/zoned.c  | 1 -
 4 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/block/null_blk/Makefile b/drivers/block/null_blk/Makefile
index 84c36e512ab8..672adcf0ad24 100644
--- a/drivers/block/null_blk/Makefile
+++ b/drivers/block/null_blk/Makefile
@@ -5,7 +5,5 @@ ccflags-y			+= -I$(src)
 
 obj-$(CONFIG_BLK_DEV_NULL_BLK)	+= null_blk.o
 null_blk-objs			:= main.o
-ifeq ($(CONFIG_BLK_DEV_ZONED), y)
 null_blk-$(CONFIG_TRACING) 	+= trace.o
-endif
 null_blk-$(CONFIG_BLK_DEV_ZONED) += zoned.o
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 5d56ad4ce01a..b33b9ebfebd2 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -11,6 +11,9 @@
 #include <linux/init.h>
 #include "null_blk.h"
 
+#define CREATE_TRACE_POINTS
+#include "trace.h"
+
 #undef pr_fmt
 #define pr_fmt(fmt)	"null_blk: " fmt
 
diff --git a/drivers/block/null_blk/trace.h b/drivers/block/null_blk/trace.h
index 82b8f6a5e5f0..f9eadac6b22f 100644
--- a/drivers/block/null_blk/trace.h
+++ b/drivers/block/null_blk/trace.h
@@ -30,6 +30,7 @@ static inline void __assign_disk_name(char *name, struct gendisk *disk)
 }
 #endif
 
+#ifdef CONFIG_BLK_DEV_ZONED
 TRACE_EVENT(nullb_zone_op,
 	    TP_PROTO(struct nullb_cmd *cmd, unsigned int zone_no,
 		     unsigned int zone_cond),
@@ -73,6 +74,7 @@ TRACE_EVENT(nullb_report_zones,
 	    TP_printk("%s nr_zones=%u",
 		      __print_disk_name(__entry->disk), __entry->nr_zones)
 );
+#endif /* CONFIG_BLK_DEV_ZONED */
 
 #endif /* _TRACE_NULLB_H */
 
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 5b5a63adacc1..47470a732d21 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -3,7 +3,6 @@
 #include <linux/bitmap.h>
 #include "null_blk.h"
 
-#define CREATE_TRACE_POINTS
 #include "trace.h"
 
 #undef pr_fmt
-- 
2.17.1


