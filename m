Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C03E77179
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Dec 2024 12:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yc4BEe7BKj+K73PpdiIviH16FCf0tS85OTF3LXxZW0Y=; b=ZDMWtkSJw3Wurqz/wYyXfjixqO
	UnjGmHgsPXYCJoWTmV8XPHQX97hI0/9haHm6rCLUMEHd6hrRJ2I7jKqV/UJZ3S8J8dSK9i0F9Ecqp
	OJ7U3qeHKiMKMKs/0vdx3hcVZaPH766zvN/DMvw6G+1qupzHrkG9VgLpPxq3mD9rdTGaYEBhYMyRL
	JiI1zgacaAnj9rDKcqRwTSBLZkTNsN0iUgkuAsZIYJGRQ97Q5uE3AdjRqIuIPROPIBrGRwraIXJ+8
	khWC2j4mVL7CxQBdCkyfsX7fdCDwYz/VBunX8nv4f5sTz7sd3ud3Wmj0OcbroVbklJ6z7owjIkrrc
	G/2sjNwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJXhO-00000001c2e-0US0;
	Fri, 06 Dec 2024 12:44:46 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJXhJ-00000001bzp-3TuR
	for linux-nvme@lists.infradead.org;
	Fri, 06 Dec 2024 12:44:44 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20241206124433epoutp02e8856148043a007b01c3ac85fd969996~OlyDPKU0s2870028700epoutp02i
	for <linux-nvme@lists.infradead.org>; Fri,  6 Dec 2024 12:44:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20241206124433epoutp02e8856148043a007b01c3ac85fd969996~OlyDPKU0s2870028700epoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733489073;
	bh=yc4BEe7BKj+K73PpdiIviH16FCf0tS85OTF3LXxZW0Y=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=RZNPnlER4+06Nf+/vPDvBOA0dL6xh0Nmv+TUCMU9kDqlSV++JQGdQq4VPDQgI01r4
	 sVoKJ77pOTeLOqqhkyhEEa8qo8c1wmYCn2cfx6ztHBL8zRgaRqR3M0aWp3DgOIaBhc
	 La5DoKT9hET3jr1G5ZTWFdgpkb06NPJ0OUWgP4+I=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20241206124433epcas5p10de029829d5ebab13ab1bd11591fc64a~OlyC3AQjG2611626116epcas5p1o;
	Fri,  6 Dec 2024 12:44:33 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Y4WDJ0hwRz4x9Pw; Fri,  6 Dec
	2024 12:44:32 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	73.A7.19710.FA1F2576; Fri,  6 Dec 2024 21:44:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20241206124431epcas5p464e8ee56a3f519831d4f5ba16047f990~OlyBTbIJw0039500395epcas5p44;
	Fri,  6 Dec 2024 12:44:31 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241206124431epsmtrp26428836afb25bab3eb421b9afe03a90b~OlyBSyGUu2403824038epsmtrp2z;
	Fri,  6 Dec 2024 12:44:31 +0000 (GMT)
X-AuditID: b6c32a44-363dc70000004cfe-52-6752f1af1764
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	45.00.33707.FA1F2576; Fri,  6 Dec 2024 21:44:31 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241206124430epsmtip191718193b8f3ea62f14bc7fd5b3a6f89~Olx-vil760592605926epsmtip11;
	Fri,  6 Dec 2024 12:44:29 +0000 (GMT)
Message-ID: <bcfd9c63-797b-4f6b-aa6e-0e639247003b@samsung.com>
Date: Fri, 6 Dec 2024 18:14:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv11 03/10] io_uring: add write stream attribute
To: Keith Busch <kbusch@meta.com>, axboe@kernel.dk, hch@lst.de,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
Cc: sagi@grimberg.me, asml.silence@gmail.com, Keith Busch
	<kbusch@kernel.org>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20241206015308.3342386-4-kbusch@meta.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMJsWRmVeSWpSXmKPExsWy7bCmlu76j0HpBnOarS3mrNrGaLH6bj+b
	xcrVR5ks3rWeY7GYdOgao8WZqwtZLPbe0rbYs/cki8X8ZU/ZLda9fs/iwOWxc9Zddo/z9zay
	eFw+W+qxaVUnm8fmJfUeu282sHmcu1jh8XmTXABHVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxz
	vKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtCBSgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJb
	pdSClJwCkwK94sTc4tK8dL281BIrQwMDI1OgwoTsjCUHJrIUTOKr+L8upoFxHlcXIyeHhICJ
	xM9561i6GLk4hAR2M0q0XJ7FCuF8YpRY/fsLE5yz5GQvM0zL7FWXWEFsIYGdjBJfmwIgit4y
	Slz78oUdJMErYCfxbeJNoG4ODhYBFYnbJ1wgwoISJ2c+YQGxRQXkJe7fmgFWLizgJHF19jM2
	kDkiAjsYJTpfPmUCSTAL+Evc6/jDCGGLS9x6Mh9sJpuApsSFyaUgYU4Bc4mV11uhyuUltr+d
	wwwyR0JgKYfE3RX9bBBHu0hseHMV6gFhiVfHt7BD2FISn9/tharJlnjw6AELhF0jsWNzHyuE
	bS/R8OcGK8heZqC963fpQ+zik+j9/QTsHAkBXomONiGIakWJe5OeQnWKSzycsQTK9pD4/3IH
	GySotjNKvPs0g20Co8IspGCZheTLWUjemYWweQEjyypGydSC4tz01GTTAsO81HJ4dCfn525i
	BKdeLZcdjDfm/9M7xMjEwXiIUYKDWUmEtzIsMF2INyWxsiq1KD++qDQntfgQoykweiYyS4km
	5wOTf15JvKGJpYGJmZmZiaWxmaGSOO/r1rkpQgLpiSWp2ampBalFMH1MHJxSDUzF2VYOh5iT
	DM9d+jRJ+P3qSJVV22ue30zPt/APcspw7k4q6DTLmPZadGJURIfM7O+TdNO815y/q/f+U/uj
	BU+vzlsU2vOL65quXE+VwIYtKy9ukWR5xVYm8kW3o6smlVtKP8vNWCAqxLvhzs/kqqWlhXFO
	ew4m6JpEet1qvBuofXeJxKQDGdObYzaobE6ZafpzUdvqc6Y1Ah/7t/WVzvU78UVpqdveV0w9
	k17dLF5+c6VrT2ibwKmGxer61X2rFncIZqUyuPG9Xyn0t2BZJ8dLrr2zG44ZHp8V9vc9w46z
	/wXiQlV6hM3OZwgwz3FYFceqN2UNm3rLk7sbrbSXW0nVLFPO2pi3Zupc7hla1UosxRmJhlrM
	RcWJAJrzzTxGBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LZdlhJTnf9x6B0g/Z1ShZzVm1jtFh9t5/N
	YuXqo0wW71rPsVhMOnSN0eLM1YUsFntvaVvs2XuSxWL+sqfsFutev2dx4PLYOesuu8f5extZ
	PC6fLfXYtKqTzWPzknqP3Tcb2DzOXazw+LxJLoAjissmJTUnsyy1SN8ugStjyYGJLAWT+Cr+
	r4tpYJzH1cXIySEhYCIxe9Ul1i5GLg4hge2MEtPOvmGFSIhLNF/7wQ5hC0us/PecHaLoNaPE
	selPWEASvAJ2Et8m3mTqYuTgYBFQkbh9wgUiLChxciZEiaiAvMT9WzPA5ggLOElcnf2MDWSO
	iMAORon/63aygSSYBXwlHly9xQZ3xdIDF9khEuISt57MB1vAJqApcWFyKUiYU8BcYuX1ViaI
	EjOJrq1djBC2vMT2t3OYJzAKzUJyxywkk2YhaZmFpGUBI8sqRtHUguLc9NzkAkO94sTc4tK8
	dL3k/NxNjOAI0wrawbhs/V+9Q4xMHIyHGCU4mJVEeCvDAtOFeFMSK6tSi/Lji0pzUosPMUpz
	sCiJ8yrndKYICaQnlqRmp6YWpBbBZJk4OKUamLZbFKoKsd861HXroMnxt7dju5WSbYvUbpvn
	X/aY+Gz17ffMoe3nFR+sqd57uiLHQFX765oFk1dFyoSumP1xgsXimXlvpyhasfWV35W5qKN7
	vn3z77Z4Tl2Tn6me39uaKy1aT/l5721WXGjo/U7X9wab9Wvr45fqN++5/dR5ddLsjYFJJ64G
	uL75NSVja51O6r0zHu4bdeb/Unsqqzpl9to469nCC/Y+Cd8m8Nps8zrnJ7ln1qwp+u6gZWp5
	eE26plLIhJNVvY2P3HwMTZzOTWpR4jW5wMT6ZondTKGo9RPDROss93kG+Un1uGWlRsziePn9
	1/cXE42XdNi4PTDer3/EQC9+/vtW3j9Tqjs9uZRYijMSDbWYi4oTAboZuucfAwAA
X-CMS-MailID: 20241206124431epcas5p464e8ee56a3f519831d4f5ba16047f990
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241206015353epcas5p174318c263e73bfe8728d49b5e90a14e8
References: <20241206015308.3342386-1-kbusch@meta.com>
	<CGME20241206015353epcas5p174318c263e73bfe8728d49b5e90a14e8@epcas5p1.samsung.com>
	<20241206015308.3342386-4-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241206_044442_207818_F28F7F9B 
X-CRM114-Status: GOOD (  17.39  )
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

On 12/6/2024 7:23 AM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Adds a new attribute type to specify a write stream per-IO.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   include/uapi/linux/io_uring.h |  9 ++++++++-
>   io_uring/rw.c                 | 28 +++++++++++++++++++++++++++-
>   2 files changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
> index 5fa38467d6070..263cd57aae72d 100644
> --- a/include/uapi/linux/io_uring.h
> +++ b/include/uapi/linux/io_uring.h
> @@ -123,7 +123,14 @@ struct io_uring_attr_pi {
>   	__u64	rsvd;
>   };
>   
> -#define IORING_RW_ATTR_FLAGS_SUPPORTED (IORING_RW_ATTR_FLAG_PI)
> +#define IORING_RW_ATTR_FLAG_WRITE_STREAM (1U << 1)
> +struct io_uring_write_stream {
> +	__u16	write_stream;
> +	__u8	rsvd[6];
> +};

So this needs 8 bytes. Maybe passing just 'u16 write_stream' is better? 
Or do you expect future additions here (to keep rsvd).

Optimization is possible (now or in future) if it's 4 bytes or smaller, 
as that can be placed in SQE along with a new RW attribute flag that 
says it's placed inline. Like this -

--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -92,6 +92,10 @@ struct io_uring_sqe {
                         __u16   addr_len;
                         __u16   __pad3[1];
                 };
+               struct {
+                       __u16   write_hint;
+                       __u16   __rsvd[1];
+               };
         };
         union {
                 struct {
@@ -113,6 +117,7 @@ struct io_uring_sqe {

  /* sqe->attr_type_mask flags */
  #define IORING_RW_ATTR_FLAG_PI (1U << 0)
+#define IORING_RW_ATTR_FLAG_WRITE_STREAM_INLINE        (1U << 1)

