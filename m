Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 051B6C3ABC6
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 16:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ljjro079q9uwRgw13jqGTcCMnLnd9SzNPEgxRUxU6ZI=; b=akWJGl1D9beoogcKG3G9SkqIkN
	SQMXMI3VgM2Cg65o3eVnFHlYC0MZbYF9v5zhOETpbG9CmEdYbZceDRtVSCkima42Rha+9169Ikx6E
	+GSoONRQnTlwjLqwmnYEGbAqF8mWZwegDzi3p3gFoYc44LbNKOFlCkt7B6sy53wNeCL/ebw9LyyFf
	wawcfgOeAejYnaAgrfjw4SLS4PeXqcyS7xkvgHv6q6DnygvpNZHvb2/PKSzWyeGs/WWqRnwePB3qb
	vw73o76dZEpmpwt4gSYd0LcODagmVwp6qQd+clvyYjpb/+8Wk/IwnGSqkPG9zA4qS3zdpCxUKrO8i
	DcpB4SBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCKjM-0000000CaKW-0NW3;
	Tue, 06 May 2025 16:01:16 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCHO4-0000000BuI8-0JDI
	for linux-nvme@bombadil.infradead.org;
	Tue, 06 May 2025 12:27:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Sender:Reply-To:Content-ID:Content-Description;
	bh=Ljjro079q9uwRgw13jqGTcCMnLnd9SzNPEgxRUxU6ZI=; b=UINJT62MXt9LUhwIxseG3aCCsC
	R9ucPd+H37QckSl4et/MLA3wiS0oLwwiItQXebvYIfO41wN9CQgYyBwHDPAWg7uD5UFZC4RyRP2L2
	cJCaCkAN8ie7urorf9ny9kmZXdLAg5unCELRGnHy2RQIyNQDXcpmv4XtIUMy92tA6XCVNwehHRVbr
	UrVtNx2xjbqObXbLGgmVjy5+kbkCat9Bt+dLtsJgXSyLM46j1tH3qr8XeG0cPIaTwuuh8U2hjaHEm
	wILtKa+++ns16wuuO6jrdR2VHyIV/7hKPcK2G0H5JFncrBp9496xdXPySsl30raloYL23PmwCaxTN
	XWKndjDQ==;
Received: from mailout4.samsung.com ([203.254.224.34])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uCHNy-0000000FdiH-3SeX
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 12:27:02 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250506122647epoutp04d7f546b4454ba6f58c9af6a140338ff1~878oqNx2X1220912209epoutp04M
	for <linux-nvme@lists.infradead.org>; Tue,  6 May 2025 12:26:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250506122647epoutp04d7f546b4454ba6f58c9af6a140338ff1~878oqNx2X1220912209epoutp04M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1746534407;
	bh=Ljjro079q9uwRgw13jqGTcCMnLnd9SzNPEgxRUxU6ZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tD8ykrXE5pBouR+sE8Jf8Llb3QwgTA12J0zQXSru7dkPefySWZ5ssTedaO5rYxRg5
	 zCymAI+gJ3r02H6L2P/NihrmEi6uic4o7KO/6JJzkvyc7/TJTHOLEQXfgMFarhDUqZ
	 SmmCpAb1YQqjsMLrNGm62O9lJ+h+6xeTdsoN5eIw=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250506122646epcas5p4545d498ae204a164aaf8df513fe97221~878n8Q1m11362913629epcas5p4D;
	Tue,  6 May 2025 12:26:46 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.180]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4ZsHh50LGgz6B9m5; Tue,  6 May
	2025 12:26:45 +0000 (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250506122644epcas5p2b2bf2c66172dbaf3127f6621062efb24~878l_uqDD2629626296epcas5p2e;
	Tue,  6 May 2025 12:26:44 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250506122644epsmtrp24528d3c8914722ebd4d6ec319bab9deb~878l_FpCV0522005220epsmtrp2P;
	Tue,  6 May 2025 12:26:44 +0000 (GMT)
X-AuditID: b6c32a29-566fe7000000223e-94-681a0004a83a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8D.B6.08766.4000A186; Tue,  6 May 2025 21:26:44 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250506122642epsmtip2edfe940f28a765b8e06ac20119c395b2~878kclVT91704417044epsmtip2T;
	Tue,  6 May 2025 12:26:42 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, asml.silence@gmail.com
Cc: io-uring@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org, Hannes
	Reinecke <hare@suse.de>, Nitesh Shetty <nj.shetty@samsung.com>, Kanchan
	Joshi <joshi.k@samsung.com>
Subject: [PATCH v16 06/11] io_uring: enable per-io write streams
Date: Tue,  6 May 2025 17:47:27 +0530
Message-Id: <20250506121732.8211-7-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250506121732.8211-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsWy7bCSvC4Lg1SGwYVfHBZzVm1jtFh9t5/N
	Ys+iSUwWK1cfZbJ413qOxeLo/7dsFpMOXWO02HtL22LP3pMsFvOXPWW32PZ7PrMDt8fOWXfZ
	PS6fLfXYtKqTzWPzknqP3Tcb2Dz6tqxi9Nh8utrj8ya5AI4oLpuU1JzMstQifbsErowz/X3s
	BY8FK5YvmsjUwHiZr4uRk0NCwERi+uoXbF2MXBxCArsZJXrW/GKESIhLNF/7wQ5hC0us/Pec
	HaLoI6PE6+M3WbsYOTjYBDQlLkwuBakREQiQeLn4MTNIDbPAB0aJPRNngw0SFnCQ6Ji1hhnE
	ZhFQlehetZ8NxOYVMJf4fe4PC8QCeYmZl76DLeMUsJBYvmcWWK8QUM2Lo0fYIeoFJU7OfAJW
	zwxU37x1NvMERoFZSFKzkKQWMDKtYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQIjgot
	zR2M21d90DvEyMTBeIhRgoNZSYT3/n3JDCHelMTKqtSi/Pii0pzU4kOM0hwsSuK84i96U4QE
	0hNLUrNTUwtSi2CyTBycUg1Msq9yLjErPjn1f9Ji78Dv5dNjNBrf1gXnhAi+yJNau+nKbLN9
	asdy5WIFd+cmvw5tSff9yFV0SO+F5tb1X2+oajkGuh6qFb03hblCVFlFRXtN/OpTS9q2HNjV
	9TyAt6bNZfK6F+I3tFasNamWOyTlbCP9PHhvw57zxU21s4vKm74VmOYrVyVf/8Pz9fiR7MM2
	06PfV+z8wZI96f9at6RzO0s2qskYn//yf/9DrfclrUd7tjw3ULr13bJVf6XO87MHVP99YFS6
	9TZ6fmDFmZgp4i9//kztnPTC3D/Qotm+6dqF2zzqFz4fEkqMmXon8965C7O3Lw3c+nDiWt63
	v37W/DV4cyWjaaa/o4dA6a4MKyWW4oxEQy3mouJEAAvDjnf5AgAA
X-CMS-MailID: 20250506122644epcas5p2b2bf2c66172dbaf3127f6621062efb24
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250506122644epcas5p2b2bf2c66172dbaf3127f6621062efb24
References: <20250506121732.8211-1-joshi.k@samsung.com>
	<CGME20250506122644epcas5p2b2bf2c66172dbaf3127f6621062efb24@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_132659_976326_AEB16BAD 
X-CRM114-Status: GOOD (  15.45  )
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

From: Keith Busch <kbusch@kernel.org>

Allow userspace to pass a per-I/O write stream in the SQE:

      __u8 write_stream;

The __u8 type matches the size the filesystems and block layer support.

Application can query the supported values from the block devices
max_write_streams sysfs attribute. Unsupported values are ignored by
file operations that do not support write streams or rejected with an
error by those that support them.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 include/uapi/linux/io_uring.h | 4 ++++
 io_uring/io_uring.c           | 2 ++
 io_uring/rw.c                 | 1 +
 3 files changed, 7 insertions(+)

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 5ce096090b0c..cfd17e382082 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -94,6 +94,10 @@ struct io_uring_sqe {
 			__u16	addr_len;
 			__u16	__pad3[1];
 		};
+		struct {
+			__u8	write_stream;
+			__u8	__pad4[3];
+		};
 	};
 	union {
 		struct {
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 703251f6f4d8..36c689a50126 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -3916,6 +3916,8 @@ static int __init io_uring_init(void)
 	BUILD_BUG_SQE_ELEM(44, __s32,  splice_fd_in);
 	BUILD_BUG_SQE_ELEM(44, __u32,  file_index);
 	BUILD_BUG_SQE_ELEM(44, __u16,  addr_len);
+	BUILD_BUG_SQE_ELEM(44, __u8,   write_stream);
+	BUILD_BUG_SQE_ELEM(45, __u8,   __pad4[0]);
 	BUILD_BUG_SQE_ELEM(46, __u16,  __pad3[0]);
 	BUILD_BUG_SQE_ELEM(48, __u64,  addr3);
 	BUILD_BUG_SQE_ELEM_SIZE(48, 0, cmd);
diff --git a/io_uring/rw.c b/io_uring/rw.c
index 17a12a1cf3a6..303fdded3758 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -279,6 +279,7 @@ static int __io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	}
 	rw->kiocb.dio_complete = NULL;
 	rw->kiocb.ki_flags = 0;
+	rw->kiocb.ki_write_stream = READ_ONCE(sqe->write_stream);
 
 	if (req->ctx->flags & IORING_SETUP_IOPOLL)
 		rw->kiocb.ki_complete = io_complete_rw_iopoll;
-- 
2.25.1


