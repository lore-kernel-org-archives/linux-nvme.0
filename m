Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE4A0D3B7EC
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Nov 2024 08:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fOhAPjepG8IxDxWR0+S1vjp4KvMbiHG0tXmeE420F+0=; b=gnqdH6U4JyVoELvVd2Crvui6ov
	nFJhrZNxFjCOC55L5IDjBagw+nwnhAOaYZiJEP2JaepAuXcPZ/l4rbAuxoBNYRNMVEhq8njMLdZ7j
	5n3ztVKCUj6W+yYlf44mNqALIuzTdNqXS6ebVJmx0C2vdLO0R1fEbUiJ40fmKfqL14nY+FlDNmSiY
	LhQOmrx/Ii0QsQQvNjq5UT4hCtp2W210UV6Ttbxj0Caqo3MYEa6i9ZiDhKYdziAlGCmEyFYXBliLs
	LA/DKwndiA+qQnTE7D+muVyVmUQX9GqRbziixgwrGns+NAOSwhNhiOPtE9BjCFWPH5ppBrCqmSxX/
	fcEZiLVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFU9Y-00000007KPC-0Gon;
	Mon, 25 Nov 2024 08:09:04 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFU9U-00000007KKb-15Tz
	for linux-nvme@lists.infradead.org;
	Mon, 25 Nov 2024 08:09:02 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20241125080858epoutp022e0e5c236f499c6de948d94c6d104212~LJ7Sayf4X2100521005epoutp02k
	for <linux-nvme@lists.infradead.org>; Mon, 25 Nov 2024 08:08:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20241125080858epoutp022e0e5c236f499c6de948d94c6d104212~LJ7Sayf4X2100521005epoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1732522138;
	bh=fOhAPjepG8IxDxWR0+S1vjp4KvMbiHG0tXmeE420F+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wt8PsEQJqgbearHYu3fxl9O/us75Sad3mB+eMUgTK9AlfNtXSu92nygcWca7gJCO/
	 xx++6j/ky446EuecC/GtaxeIFFlCLRkRZjiYjVl5uwR0A4+/yjsjqcATF1G71ER+wJ
	 7ruOq/4mVaRD+me1cyOXPVHunD+Et/U1cijyyddw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20241125080857epcas5p4d06759959548551aef4833f8d9ddad7a~LJ7R9g1tx2124121241epcas5p4g;
	Mon, 25 Nov 2024 08:08:57 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4XxddN0wM2z4x9Q7; Mon, 25 Nov
	2024 08:08:56 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	2E.02.19933.79034476; Mon, 25 Nov 2024 17:08:55 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20241125071507epcas5p3b898d0960fb411cd176aea29029d820a~LJMR62Uuv1555015550epcas5p3e;
	Mon, 25 Nov 2024 07:15:07 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241125071507epsmtrp29b66bfee5a18f9c38f5643a13d4bc316~LJMR52bbv0316003160epsmtrp25;
	Mon, 25 Nov 2024 07:15:07 +0000 (GMT)
X-AuditID: b6c32a4a-c1fda70000004ddd-72-674430975f8d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	75.55.19220.BF324476; Mon, 25 Nov 2024 16:15:07 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241125071505epsmtip1c600a3a362de2346338329f5f8a11561~LJMPdOokE0361903619epsmtip1t;
	Mon, 25 Nov 2024 07:15:05 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com, anuj1072538@gmail.com,
	brauner@kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org, vishak.g@samsung.com,
	linux-fsdevel@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>, Anuj
	Gupta <anuj20.g@samsung.com>
Subject: [PATCH v10 08/10] nvme: add support for passing on the application
 tag
Date: Mon, 25 Nov 2024 12:36:31 +0530
Message-Id: <20241125070633.8042-9-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241125070633.8042-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te1BUVRzHO3evd3eppctrODJqO3cm2+W5aywdFCKT8kZW2GMYa4rusLdd
	ZLm7s3dXMcdxlZZK5WUQgmAgjQxQEU8RWAZBIEiQgYmEUkAhLIIJGJEZBmmXi+V/n9/vfL/n
	9/udh0TkeZvwkyRyFtbMMQaKcMMbOpSKoDxVtE514n4Emr+/gqOTWasiVFjRAFDlrUwCzXQs
	ADTSdgVD5ZWdGJqz9+PofF4qhjrXZgl0tn0YIMdoAGpx9ODom0tTYnT610YClXU/xNCN1e5N
	6EZBofglT/pKwS0xPdRnpWsqviTo2m+P080jNoKenxrF6Yy6CkBfL74mphdrttE1k7NYrNv7
	SRF6ltGyZjnLJRi1iZwuknr9nfg98ZowlTpIHY5eoOQck8xGUtH7YoNeTTQ4Z6LkhxiD1ZmK
	ZXieCnkxwmy0Wli53shbIinWpDWYQk3BPJPMWzldMMdadqpVqh0ap/DjJH125YTYVPdkSt9U
	LWYDndJTQCqBZCgc/7GZcLEn2QzgubPYKeDm5AUAh/p+EwsLSwD+Pf3JI4P9Tr1IEDkAvNy2
	JhaCRQCbKjIxl4ogn4PXpu3AteBNtgCYXvIz7gpEZBYGi/PqRC6VF7kfFi014C7GyWfh4J9r
	624ZieBndx7gQr1nYP7gg/U+pGQ4nE1rwwWNB+zJn1xnkVOTWn9+vSdI3pTAvns5mGCOhmVd
	NiCwF/yru04ssB9cnHMQAuvg8tDUht4EU7taN/RR0N6b6dxU4iyghFVNIUJ6K8zt/QET6rrD
	9JXJDasMNl54xBT8vLxwgyF09Ns2mIbZMwO4cFxnAOwYmMCzgLzgsXkKHpun4P/SxUBUATaz
	Jj5Zx/Ia0w6OPfzfNScYk2vA+kP3j2kEE+P/BLcDTALaAZSIKG+Zu+8enadMyxz5lDUb481W
	A8u3A43zwLNFfj4JRudP4Szx6tBwVWhYWFho+PNhaspXNmMv0nqSOsbCJrGsiTU/8mESqZ8N
	a9y/+xWN1isn44Kia6rdt5KbL9v7xHjc4R7iwMsD5a3Hmlpj31COtliOVg+m7d5yhL/7dvmH
	3x13myhennQEDr+7bVi6NeBpSrM6/keJKq2eTzjIBtaW7moc2957/aeJlM1Vd2sXGrC4S7v4
	/vGy7bK9q2euPnXsPXfqwL4YvXS6qMl+Nf1gX9WKWV2KGqJCprGAi6kXz7UY9NhbiwOvmb9a
	Cokd83Y3bYk6sbNEM5B2mfn6I6uubFrh8ebvwQ91hSNM7gd1Mb/kV/sPfq9IWsbnePkhQmk7
	yimayw0yn5uDxO3q0xmBY3NzOSW+UeAeSFX6pJws9YhTNH8Bc2c3pSsxCuf1jNpfZOaZfwH2
	qVcvcQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsWy7bCSnO5vZZd0g7mnTSw+fv3NYtE04S+z
	xZxV2xgtVt/tZ7N4ffgTo8XNAzuZLFauPspk8a71HIvF7OnNTBZH/79ls5h06Bqjxd5b2hZ7
	9p5ksZi/7Cm7Rff1HWwWy4//Y7I4//c4q8X5WXPYHYQ8ds66y+5x+Wypx6ZVnWwem5fUe+y+
	2cDm8fHpLRaPvi2rGD3OLDjC7vF5k5zHpidvmQK4orhsUlJzMstSi/TtErgyJq5+yF6whbvi
	7NPNTA2MRzm7GDk5JARMJFofbWXuYuTiEBLYzSgx6/4MJoiEhMSpl8sYIWxhiZX/nrNDFH1k
	lNhybT9Ygk1AXeLI81YwW0TgBKPE/IluIEXMAjOYJH7/WcACkhAW8JfYOOUEmM0ioCpx6eV/
	sA28AhYSLY++s0BskJeYeek7O4jNKWAp8bbtAFhcCKhmVudKVoh6QYmTM5+AxZmB6pu3zmae
	wCgwC0lqFpLUAkamVYySqQXFuem5xYYFRnmp5XrFibnFpXnpesn5uZsYwTGnpbWDcc+qD3qH
	GJk4GA8xSnAwK4nw8ok7pwvxpiRWVqUW5ccXleakFh9ilOZgURLn/fa6N0VIID2xJDU7NbUg
	tQgmy8TBKdXAtODahuqDRdWZy09ohrTu+7Zg2vsTHB8XPWfOXBiy+/z/ntV3HphqvuW883KV
	+6fzDWdWHdmrz+CTsituX+azRTwhIdbnpi7dyL9z4UMrJvnYNW+Kmqos13zpY5sWEND+brl5
	rGB4qNgcj+9VM981rE8wfVKU38kbor786n0me7P7Xxvf3Dv7Mvvt/I/n1Zyfua/zNzgmse1j
	48/2aau99v4x+uTlWidRuvv4c4vj/brR4R0a0YuZ5249LXDBauPzurkl4qEzddzteeMDK07o
	d1aHznKbFf3Aa5km6+cDp4r3vtaZ1xQuZqyqFbLSVnOBojEHM0PW9tA9mSmazYd27VgnXLwj
	LOCjXTNruOePd0osxRmJhlrMRcWJAIiWypgoAwAA
X-CMS-MailID: 20241125071507epcas5p3b898d0960fb411cd176aea29029d820a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241125071507epcas5p3b898d0960fb411cd176aea29029d820a
References: <20241125070633.8042-1-anuj20.g@samsung.com>
	<CGME20241125071507epcas5p3b898d0960fb411cd176aea29029d820a@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241125_000900_630030_F141CFC2 
X-CRM114-Status: GOOD (  16.20  )
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

From: Kanchan Joshi <joshi.k@samsung.com>

With user integrity buffer, there is a way to specify the app_tag.
Set the corresponding protocol specific flags and send the app_tag down.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e4e3653c27fb..571d4106d256 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -885,6 +885,12 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 	return BLK_STS_OK;
 }
 
+static void nvme_set_app_tag(struct request *req, struct nvme_command *cmnd)
+{
+	cmnd->rw.lbat = cpu_to_le16(bio_integrity(req->bio)->app_tag);
+	cmnd->rw.lbatm = cpu_to_le16(0xffff);
+}
+
 static void nvme_set_ref_tag(struct nvme_ns *ns, struct nvme_command *cmnd,
 			      struct request *req)
 {
@@ -1025,6 +1031,10 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 				control |= NVME_RW_APPEND_PIREMAP;
 			nvme_set_ref_tag(ns, cmnd, req);
 		}
+		if (bio_integrity_flagged(req->bio, BIP_CHECK_APPTAG)) {
+			control |= NVME_RW_PRINFO_PRCHK_APP;
+			nvme_set_app_tag(req, cmnd);
+		}
 	}
 
 	cmnd->rw.control = cpu_to_le16(control);
-- 
2.25.1


