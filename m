Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A53D69100
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Nov 2024 11:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cRuOygxyfLjl7ybgQ+EVk9IvCIBAqSeYwRZ/zr1tr/8=; b=ACN5uDHQWG2yRPkTfL4TeCJN6w
	eerwy+1ixijo73Jck5l420PkM3pvRCAM/pyF87+yWGSC/XRPTn+uzR8TLtVjhCzjWX66OFvf3Nzl4
	oGpoSCLk3DA3MdTj2azjjk+PT/5El8r4Zq9vjhj0fB3onXjZRCfEzl4KdsolmriIhPULQFXxr9wkx
	X85876btC5MI/MhMB+7Mt+Wr9QxvT0kpEI3mxlIOa3CkK3RFxCzflnuROzJZ4w5xpbA255Cxp5djf
	m2CGokTPxqVhK7nc1XuzUkqbAfCwpEcOFjHyr+y4rE2s91OnSqcGHECBvWPGzPa54xa717y86do7P
	yxxgmEyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGcyP-0000000FO3B-181D;
	Thu, 28 Nov 2024 11:46:17 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGcyO-0000000FO1V-083j
	for linux-nvme@bombadil.infradead.org;
	Thu, 28 Nov 2024 11:46:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Sender:Reply-To:Content-ID:Content-Description;
	bh=cRuOygxyfLjl7ybgQ+EVk9IvCIBAqSeYwRZ/zr1tr/8=; b=N3oG/1uT4mJ1YYguvOJwUiFlpj
	UZzDk3px93bNEHPJBwMIYGxRF86mT1EOev8xtqxkezoKxEBIwuh/XaoqoAmMGJsG2bkkBEcBcGF0k
	apnB7ktCPZ28xebeWEJ+qxxKceBBoQwEXUVvLXcejtHTOcx+QpCOqRh/JShPanDKSYbGTmhyMVNjB
	O6Fx/HLswntvfwrbbDnkWOyk3VJNb4PVrbCdry8AWARY69U7UhwsBlyeR5dY1oj45pZkDzh4F7my0
	HIHet53QlTBJqeXIRiAc+JdxyNYKVqh6LCd5Dv0JKABhRTot/0xYElr40HYag5/fBZjSOztU2Pkp5
	pvwlfWuA==;
Received: from mailout2.samsung.com ([203.254.224.25])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGcyK-00000001azM-3A27
	for linux-nvme@lists.infradead.org;
	Thu, 28 Nov 2024 11:46:15 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20241128114609epoutp02032dad55167cd3306a5e9fece5ca2f9c~MH0xE3wHO1307013070epoutp02C
	for <linux-nvme@lists.infradead.org>; Thu, 28 Nov 2024 11:46:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20241128114609epoutp02032dad55167cd3306a5e9fece5ca2f9c~MH0xE3wHO1307013070epoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1732794369;
	bh=cRuOygxyfLjl7ybgQ+EVk9IvCIBAqSeYwRZ/zr1tr/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JzLRZu9ihGM6g1beIxWgzgI5b0ZoECOIlcbkGAf4edK8wugmOSwVFL27tKcQ+oJci
	 CUj1LAkSGkpVharDM4exT0ZuOMNY1qbUypvBWCpaJN/S/9KzehiJuO8gbTiIrNyjU/
	 eq42oGTDSXLf7UR0C+JfP1slhwbmE/+i/50imHZE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20241128114608epcas5p19b71a782a4aaf32b6af0939969df31a4~MH0woohAk2942729427epcas5p1x;
	Thu, 28 Nov 2024 11:46:08 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4XzZJb1LSxz4x9Pr; Thu, 28 Nov
	2024 11:46:07 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	9B.B3.19710.FF758476; Thu, 28 Nov 2024 20:46:07 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20241128113106epcas5p1b5b06683bfa72225f3c1ab102b9f361c~MHnok8sA41555015550epcas5p1s;
	Thu, 28 Nov 2024 11:31:06 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241128113106epsmtrp2ce54218dc402e02bcb6731b7b6bf72f8~MHnokAPLv0091000910epsmtrp2a;
	Thu, 28 Nov 2024 11:31:06 +0000 (GMT)
X-AuditID: b6c32a44-36bdd70000004cfe-9f-674857fee0ec
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E4.5E.18949.A7458476; Thu, 28 Nov 2024 20:31:06 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241128113104epsmtip27d46969dee4538ebbdc537c9a941345f~MHnmQAdcM2660826608epsmtip2Q;
	Thu, 28 Nov 2024 11:31:03 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com, anuj1072538@gmail.com,
	brauner@kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org, vishak.g@samsung.com,
	linux-fsdevel@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH v11 05/10] fs: introduce IOCB_HAS_METADATA for metadata
Date: Thu, 28 Nov 2024 16:52:35 +0530
Message-Id: <20241128112240.8867-6-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241128112240.8867-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf0xTVxTe7WtfH2VdHj+2XZoI9WVG+U2l1FsiY4l1PMeSQYYhWaLwhLcW
	KG1ti05jsrrKFphMQIVQioA61BK3gIggrY7CVkHFicqAhG0usIkEEn46wurW0ur877vnfOd8
	5zv3XgILHsFFRIHGyOo1jJrCBdzOvsjI2H+zaWXCchuG5pfXuOiLSjeGrLZOgFonTuBopm8B
	oLEfujnoUuuPHDRXOsRF9bVmDqp2jgDkGI9GdscAFzW2TPHR17904eiC6zkH3XO7eOiexcp/
	L4jutkzw6Qd3S+h2WxlOXzn/Od0zZsLp+alxLv1Nhw3Qd5r6+fRiezjdPjnLyRB8UrRdxTL5
	rF7MavK0+QUaZQqV/nHOjpwkWYIkViJH2yixhilmUyjFhxmx7xeoPXYo8QFGXeIJZTAGAxX/
	7na9tsTIilVagzGFYnX5ap1UF2dgig0lGmWchjUmSxIStiZ5iLlFqgXXBZ7uIe+zAdsqZgIj
	3HIQQEBSCi8u9GLlQEAEkz0A3qrt4XkTweQCgO3du32JFQBna2deVkxaevk+kgPAh6f1PrwI
	4OOGQi/Gyc2w/69S4C0OJe0AVjTf5noPGDkN4Le2s+udQsg0uHrxnKcTQXDJTXDlyQZvWEgi
	+Gefg+MTi4B1w8/WxQJIOawfWeH5OEFwoG5yvQ3m4Ziv1q9bgOTPBJw7avVPqoBXa4aBD4fA
	p64Ovg+L4OKcA/dhJfz7wZRfTAfNP93w81Nh6eAJzDsbRkbC76/H+8Ib4OnB7zg+3Tdgxdqk
	v1QIu868wBT86pLVjyF0DJn8mIbT9iv+7R4H0HwusxKILa/Ysbxix/K/chPAbCCM1RmKlWxe
	kk6iYQ++vOM8bXE7WH/gUYouMNr4PM4JOARwAkhgVKhQF5imDBbmM4cOs3ptjr5EzRqcIMmz
	7ipM9Gae1vNDNMYciVSeIJXJZFJ5okxCvS2cKW3IDyaVjJEtYlkdq39RxyECRCZOZNtOd9s8
	2ji6ebrmWcTh3iPNv06fPHLg9yZ8ZH+yKDW96rdDuc77hcqkisqPTO6u6Oxt/PGUxWx9o3ko
	Z6ay8x/X2LXcXVsrsoYUnS1Hr99WrYWtHrsco1nSgvDHiRRKHVUtZb3VUWa/WZbGCmPuxgrv
	17wTerLhy5vH1uSPnoItUc3u16JFptWZ2ERz752NMS2ZdsXUKf7r+M6D8luP+vV7w4eL/9jf
	7ApzJvP2ZAZWt1QFFio7UuOTQ1v3CXBscMveqk8vS/vS3XFik0BRnoWOx23qX5D0muzJzdWz
	Aep91xh2155VR1BIxO4noUsTN0brZB8IpuaJqB3WZesZGcU1qBhJFKY3MP8BExQUYmkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42LZdlhJXrcqxCPd4HKntMXHr79ZLJom/GW2
	mLNqG6PF6rv9bBavD39itLh5YCeTxcrVR5ks3rWeY7GYPb2ZyWLSoWuMFntvaVvs2XuSxWL+
	sqfsFt3Xd7BZLD/+j8ni/N/jrBbnZ81hdxD02DnrLrvH5bOlHptWdbJ5bF5S77H7ZgObx8en
	t1g8+rasYvQ4s+AIu8fnTXIem568ZQrgiuKySUnNySxLLdK3S+DK+HR8OWvBFdaKk6t+Mjcw
	XmPpYuTkkBAwkXgy6yB7FyMXh5DAbkaJ1t872CASEhKnXi5jhLCFJVb+ew5V9JFRYuvc16wg
	CTYBdYkjz1vBikQETjBKzJ/oBlLEDFI04ctssBXCAu4SP1csBurm4GARUJX49kIWJMwrYCHx
	7PBeJogF8hIzL31nB7E5BSwlZl/7BjZfCKjm8uPrrBD1ghInZz4BG8kMVN+8dTbzBEaBWUhS
	s5CkFjAyrWKUTC0ozk3PLTYsMMpLLdcrTswtLs1L10vOz93ECI4zLa0djHtWfdA7xMjEwXiI
	UYKDWUmEt4DbPV2INyWxsiq1KD++qDQntfgQozQHi5I477fXvSlCAumJJanZqakFqUUwWSYO
	TqkGpnj/NUfKv+w2+ZMjUKGzUiFWbOucDx5nnBh/eO09sD05XN87+c6vUMlp19zULJY9+7dw
	Dd+enyyn1gm5sF/9fDr67ea/sWyRjnL7eM00YxgkW50ET6653f4z19h2arids/SL4E13t2ww
	vzpbZ8kWn3U3tuxeKHbO7oz0lv4SpSlrftQvb90YGqx1ZI7zioM3zxbKa2ywOxA06WXvBu5N
	dc13Fi+NDj2QbOj/svFl1xfZWGl/5qO5F2LeHNlzrERZuEasa+MhmUWO56MLcqMXf0iNC63i
	DnqjqlsZdWBZ4g7PI01q1S7sqUUxPsKnM6002p4fOpWYWaS+6oBwS2/F3q1qxwIXdP35Jjt5
	9okvB5VYijMSDbWYi4oTAaMA8ZgiAwAA
X-CMS-MailID: 20241128113106epcas5p1b5b06683bfa72225f3c1ab102b9f361c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241128113106epcas5p1b5b06683bfa72225f3c1ab102b9f361c
References: <20241128112240.8867-1-anuj20.g@samsung.com>
	<CGME20241128113106epcas5p1b5b06683bfa72225f3c1ab102b9f361c@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241128_114613_548769_32CFA167 
X-CRM114-Status: GOOD (  13.32  )
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

Introduce an IOCB_HAS_METADATA flag for the kiocb struct, for handling
requests containing meta payload.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/fs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 7e29433c5ecc..2cc3d45da7b0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -348,6 +348,7 @@ struct readahead_control;
 #define IOCB_DIO_CALLER_COMP	(1 << 22)
 /* kiocb is a read or write operation submitted by fs/aio.c. */
 #define IOCB_AIO_RW		(1 << 23)
+#define IOCB_HAS_METADATA	(1 << 24)
 
 /* for use in trace events */
 #define TRACE_IOCB_STRINGS \
-- 
2.25.1


