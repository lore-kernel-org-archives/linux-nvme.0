Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D88CDB465
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Oct 2023 12:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ddG+iMTBPykY7aem2/d5RFRU6pD1r9HGia7WdJCIOGI=; b=v0S9pwODypwZbwgj65QuPGFbXz
	b0ymDAGtkjYL6XRNWKE4/4gpv8YQAAAPHhK4G4KdfUBUU2gBrKIiA3fALPMINQ68DmljdJ1J2I+Om
	wVoGht7/JKXTuPHWFcpBebAohjxJduQR5DVbeYEwCwhucq5FaPySG047uLQLsfb6TPZnCb57LXeI3
	8ulfZXyiCGT/qh3LBTs5C+QBbT88HNeIP1j60vpydqlQpf2kvHgwF3PNymfaqUrDyKV37OaHy1L4v
	3PHmhlIqmAs2cjeamykWJ0a5FmwH3xOX1yE/xum0KQ8ONsg9DxbhBSvPgH8XoT9eZoGXFz/Fgrkix
	ap39mQPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtRll-00HGSX-2h;
	Thu, 19 Oct 2023 12:04:53 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtRlj-00HGQB-0m
	for linux-nvme@bombadil.infradead.org;
	Thu, 19 Oct 2023 12:04:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Sender:Reply-To:Content-ID:Content-Description;
	bh=ddG+iMTBPykY7aem2/d5RFRU6pD1r9HGia7WdJCIOGI=; b=OgGF/btwEnE6cRE3HXzHGYmDOy
	c0XKxWuRiqLNruMX2Bai8FhyD6Ua1D75u7IQ0HmK1FbjKHrJ4OUztZGOVggg1CoKy3lQwRyqwDGRL
	1JOP3ajBsp39QoJA2wmkTkFVOsvueglbCXbOlR/DXL6NsJDXGLlVMcWRjyKwxpm/0tVstCIiqz6md
	QFDNpdzRUSKjCGPQXvowxY524A8gROUtdO7sPy/RUyIpTYUCZy/rw3Qlr/i3TGTzpiXl74ri3FLL7
	J9+jSTl19And9CokCEjHzPacLGJz7VD3A0zz8WyTamDFJkp79CN5eSmuzRKxBtyWfKxe+YFG4m8K2
	xn0+OVqQ==;
Received: from mailout1.samsung.com ([203.254.224.24])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtRlW-009qf4-1i
	for linux-nvme@lists.infradead.org;
	Thu, 19 Oct 2023 12:04:49 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231019120429epoutp01d21bccac46b3af6af473529b122f7fcf~PgK4LgwH32715127151epoutp01M
	for <linux-nvme@lists.infradead.org>; Thu, 19 Oct 2023 12:04:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231019120429epoutp01d21bccac46b3af6af473529b122f7fcf~PgK4LgwH32715127151epoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1697717069;
	bh=ddG+iMTBPykY7aem2/d5RFRU6pD1r9HGia7WdJCIOGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dO0aohtDW8Y+Qo5zwCcjT305ZBTbZgibKLbv4F2+TzGAZV1opHVstGZ6uaD5yvx3n
	 txG4SaChvJGZnGweFXbE+VeBqunzfkUepszUaQr6wYUFi3uQeNkyqpD1V5Ab68rdFK
	 KtBzAf+bgJ7gxVo5w0hNTogGUlaePznMI1D6gzcA=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20231019120428epcas5p4d723ca2957f7203c4d2701934872abe7~PgK3kT7Kh2715127151epcas5p4B;
	Thu, 19 Oct 2023 12:04:28 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4SB5x71dYBz4x9Pp; Thu, 19 Oct
	2023 12:04:27 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	BA.88.10009.B4B11356; Thu, 19 Oct 2023 21:04:27 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20231019111004epcas5p4ff1f40fbc56715d0b1033fa47adca93f~PfbXjg6vj2423124231epcas5p4n;
	Thu, 19 Oct 2023 11:10:04 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231019111004epsmtrp205ee1fd77aee25a662712da74be81aae~PfbXiRvXZ1629616296epsmtrp2_;
	Thu, 19 Oct 2023 11:10:04 +0000 (GMT)
X-AuditID: b6c32a4a-ff1ff70000002719-55-65311b4bc577
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D5.D9.08755.C8E01356; Thu, 19 Oct 2023 20:10:04 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
	[107.99.41.245]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231019111001epsmtip1a2133c2992c6f76748a0a7ac4ecaac12~PfbUZyLMq0547905479epsmtip1j;
	Thu, 19 Oct 2023 11:10:01 +0000 (GMT)
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Alasdair
	Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	dm-devel@lists.linux.dev, Keith Busch <kbusch@kernel.org>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
	Brauner <brauner@kernel.org>
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
	nitheshshetty@gmail.com, anuj1072538@gmail.com, gost.dev@samsung.com,
	mcgrof@kernel.org, Nitesh Shetty <nj.shetty@samsung.com>, Hannes Reinecke
	<hare@suse.de>, Anuj Gupta <anuj20.g@samsung.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v17 11/12] null: Enable trace capability for null block
Date: Thu, 19 Oct 2023 16:31:39 +0530
Message-Id: <20231019110147.31672-12-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20231019110147.31672-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TezBcVxyec+/du4vZuh6dHqTJZjMyJYNdzyMobdK6JWaMzJiRPuTW3sFg
	7ezdTfpIJyIeU4YVj5QViYpEifeqIhaViqApqSBMaKK0HeTFtJpIqtalzX/f7zu/7/ud73fm
	iHDrYqG9KF6pYdVKJlFKmhOt15ycXUId5Kzs0ldC1DB4HUdP/lwjUGreCxxdmdaRaPHaMkBz
	PZkAlVeUEWiypx1DnRX5GKq+0oeh/N5xgObH9BgyTu1DX2dUEqjTOECg0Y5zJLpweV6Isifa
	SFTV/w+G7uTNA9Q2dwqg1rULOKpffESgG1MOaPhFvyDIjm7XTwvp4Zkmgh69qaWba74kaUPl
	SfoPQwmgr06mkPTF3AIBnXP6IUk/mZ8i6EddYySd21IDaMPQ5/RK8066ee4BFm55JME/jmUU
	rFrCKmOSFfHK2ABp6OHoA9Fe3jK5i9wX+UglSiaJDZAePBTu8m584sY2pJJjTKJ2gwpnOE7q
	9qa/OlmrYSVxyZwmQMqqFIkqT5UrxyRxWmWsq5LV7JfLZO5eG41HE+LGizOFqkybT243/oyl
	gEIqC5iJIOUJyxZLhFnAXGRNXQXQWFUl4ItlAIcX6jC++AvAzKbbYFuSerOG5A+MAI4OfLcl
	Scfgb7oZPAuIRCS1Dw6ti0y8LZWOw+67S8BU4NR5HBpm+zGTlQ0VDIfqFwQmTFCOsHqpbZMX
	U37wTlU/YTKClBvU/WJlos026MbsCpxvsYIDJXOECePULnj621Lc5A+pBjPYNT4GeO1B2JVh
	zt/aBi70twh5bA9XHhpJHh+H1YXfkLw2DUD9hH4rZiBMH9RthsEpJ9jQ4cbTr8OiwXqMn/sK
	zFmbw3heDNvOb+M9sLahfMvfDo6vntrCNFzoTCP4ZeUCWGt4LswDEv1LefQv5dH/P7oc4DXA
	jlVxSbEs56VyV7LH/3vmmOSkZrD5RZxD2sD9e49dewEmAr0AinCprdiRlrHWYgXz6WesOjla
	rU1kuV7gtbHvM7j9qzHJG39MqYmWe/rKPL29vT19Pbzl0tfEi+llCmsqltGwCSyrYtXbOkxk
	Zp+CXUzYHfbFiUqtZvleJPvjunlgg09RcJiF/0i6Y3bl8Dut90PmJgNXima9IgR1T7PcInJu
	tek/6nzr+w7vjrfhr7qgwZLs2fmApajVqGYnC6/EJaf2xoxz/vmrZ0urcz1aY/bMLNqGZD97
	o8VCh0Yc7lruFUe5B7nLLkcZVFSa2PUD55Xh62d27O+tsh+ovdHHHXJ772PjT767JmlZahDh
	tHtvRb7kCPT7XTcdyvhIyJ113UWRBb1+BSeZyKSzJ6KPHuP+dh+XGEsP933YMzLx9AcPS+16
	za2x9YjHzPuKSu7AJU134I6VpQdr1cErFnYTqucBTYZnsZIOq8KqaUG/pK84TEpwcYzcGVdz
	zL+ZEfCSqwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02RfUzMcRzHfX+/3/3uV9vp57L1vY7YTZOa6pbxnacyma+nhj88rzr66UEP
	t9+VCCs1RelhNJKH6pweDkWXnESpdMiNiXQ3YdwRHdXFmrXEdbP577336/15f/54M6TYSHky
	sYnJHJ+oiJfRrlRju8xr/smpci5waNgb1T3pJNHwzzEKZRaNk+hqXyGNBtrtAFlacwAqV1+k
	kKn1DoGa1acIVHP1IYFOtfUAZH1VSqB7Zj9Uka2hUPO9xxTqbrpAo7JKqxDlvdbTqMrwm0C9
	RVaA9JajADWOlZGodmCQQo/MUvRs3CAIkeA7pX1C/OztTQp3G1NwvfYEjXWadNyvOwfwXVMG
	jS8XnBbg/KzvNB62mik8eP8VjQsatADrug7hkXovXG/5Rmx02+G6NIqLj93P8QHLI11jekpy
	hMoc9wMvb7wgMkAxmwtcGMgugJlGLZ0LXBkxexdAU3cdcAIJrBzvIJ3aHdb8/ix0hrIIWFhV
	LcgFDEOzfrBrgnH409lCEn4fP0s4Dkj2GgkbLooc2p1dDbtqvwocmmK9YY1NP5kRsUtgb5WB
	cvRANgAWvpvmsF3+2jfy1JN/xexi+L78o9AZnwYfn7NQzvpZMOvWebIIsKX/odL/UDkgtEDC
	KVUJ0QkquVKeyKX6qxQJqpTEaP89SQn1YHJx33l6cFs75N8GCAa0AciQsukibxzIiUVRioNp
	HJ8UwafEc6o2IGUomYfIoz8/SsxGK5K5fRyn5Ph/lGBcPDOIyKfSOT+mjM7VBYX7ffDZMHaY
	+NT/pNUgjkk6ougw2m1xRdbUxl+pZjJiS1C7ZvnUm2eGBlttoQ0ZApeC4Ecn364M/rRrmVWt
	J6njYctA6MFjS6R5w2np4Zd2tGxND7YtXJOPRkpyn7/v2N3SbbrFbw/S29e+6Y9Ytd4tbuFO
	N5s5syYzHy+SdIY32EJg2GHLSFdlsdf1soFq+Q+te/UuLls5oSHDpLPnezTFDLZ8GP1M2gWx
	Rl2oT23kXsGKuuymlg3NFRKwJ2qxKW+imI2vmnHFN0Szzn8l7xm3LUCkDp73xbQpbeZmUS9p
	7xml/favM1DPA5P73qxV93Q+WMPLKFWMQu5L8irFH+TAt8BgAwAA
X-CMS-MailID: 20231019111004epcas5p4ff1f40fbc56715d0b1033fa47adca93f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231019111004epcas5p4ff1f40fbc56715d0b1033fa47adca93f
References: <20231019110147.31672-1-nj.shetty@samsung.com>
	<CGME20231019111004epcas5p4ff1f40fbc56715d0b1033fa47adca93f@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231019_130441_836292_D98476BD 
X-CRM114-Status: GOOD (  20.44  )
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
index 968090935eb2..c56bef0edc5e 100644
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
index 6b2b370e786f..91446c34eac2 100644
--- a/drivers/block/null_blk/trace.h
+++ b/drivers/block/null_blk/trace.h
@@ -30,6 +30,7 @@ static inline void __assign_disk_name(char *name, struct gendisk *disk)
 }
 #endif
 
+#ifdef CONFIG_BLK_DEV_ZONED
 TRACE_EVENT(nullb_zone_op,
 	    TP_PROTO(struct nullb_cmd *cmd, unsigned int zone_no,
 		     unsigned int zone_cond),
@@ -67,6 +68,7 @@ TRACE_EVENT(nullb_report_zones,
 	    TP_printk("%s nr_zones=%u",
 		      __print_disk_name(__entry->disk), __entry->nr_zones)
 );
+#endif /* CONFIG_BLK_DEV_ZONED */
 
 #endif /* _TRACE_NULLB_H */
 
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 55c5b48bc276..9694461a31a4 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -3,7 +3,6 @@
 #include <linux/bitmap.h>
 #include "null_blk.h"
 
-#define CREATE_TRACE_POINTS
 #include "trace.h"
 
 #undef pr_fmt
-- 
2.35.1.500.gb896f729e2


