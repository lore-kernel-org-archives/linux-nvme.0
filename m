Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43AC9C636CC
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Feb 2023 14:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tvOs64zU71f//KYTg5x4DbZGKGfYNT1nOvAayG7zZ3Q=; b=k38JH5Zx+MW2lzCokOOuXaIfYV
	GLg3iAZ/zaxhERww2ScY3WfSxedLYp9szMr4/VqWmDuhvD004qu5alQbB00G5bs6Uuy5AIU2l7SHC
	Sld/8lMFIQrL1AJ4JwCa71Y9Ne5jzgqujPONnfHMny5THnnjX1beU5QeG/SJJu/EJTQYbm/Kb8V6I
	dbVpEVw0JTukBKaVZeNnG9Uzem9hxeqRSWUohD8Ll9nnoBFBkCtrhcyjjYYQic16nEuJfhwErsTiy
	UPwh2sF1Pszragjk/hLLI09lUcAmt71eVXvgc1A/vDRq5+i0b4uZ732mCOdENF37CpgqF9RYp3ATh
	60ISBO0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPlAQ-00Fqtt-Gu; Wed, 08 Feb 2023 14:11:22 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPlAM-00FqtE-6q
	for linux-nvme@lists.infradead.org; Wed, 08 Feb 2023 14:11:20 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230208141109epoutp03ed8d5d9e1d0121ad81c676349e92c919~B3sPgN-S-0301003010epoutp03i
	for <linux-nvme@lists.infradead.org>; Wed,  8 Feb 2023 14:11:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230208141109epoutp03ed8d5d9e1d0121ad81c676349e92c919~B3sPgN-S-0301003010epoutp03i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1675865469;
	bh=tvOs64zU71f//KYTg5x4DbZGKGfYNT1nOvAayG7zZ3Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=udpD6FASkZGhYm3vnPeIH77mtmEwn9aX6in04u8FVI1YKY+UH7JrOwXh9lrgXUX09
	 U2Y4miVGJ3vIrJ32hw/jHAyXES/myD8ejCfbtBE8nk5xckPEaNzpMDmujYVYvcPZal
	 Jfs7weWLBHqrfQovp+4hQ2QbOGsjMmzOIm/NInqk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20230208141108epcas5p2af23c56090984d498a4e7daab55cd635~B3sOjiorV2939929399epcas5p2O;
	Wed,  8 Feb 2023 14:11:08 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4PBhk213TRz4x9Pw; Wed,  8 Feb
	2023 14:11:06 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	1C.46.55678.97DA3E36; Wed,  8 Feb 2023 23:11:06 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20230208141105epcas5p123332ad24d5dfde7eefcadd655d3d01c~B3sMHCBpc0958809588epcas5p1w;
	Wed,  8 Feb 2023 14:11:05 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20230208141105epsmtrp1396aa141628489ff983261178f4cce1c~B3sMGDhGR1006510065epsmtrp1y;
	Wed,  8 Feb 2023 14:11:05 +0000 (GMT)
X-AuditID: b6c32a4a-6a3ff7000000d97e-f8-63e3ad799d7e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	21.DC.17995.97DA3E36; Wed,  8 Feb 2023 23:11:05 +0900 (KST)
Received: from green5 (unknown [107.110.206.5]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20230208141104epsmtip24dfdae158364515aaf931b8497dbd2e9~B3sLRDFC72094120941epsmtip2T;
	Wed,  8 Feb 2023 14:11:04 +0000 (GMT)
Date: Wed, 8 Feb 2023 19:40:36 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Keith
	Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/3] nvme: split __nvme_submit_sync_cmd()
Message-ID: <20230208141036.GB13408@green5>
MIME-Version: 1.0
In-Reply-To: <20230208084939.145257-2-hare@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+LIzCtJLcpLzFFi42LZdlhTU7dq7eNkg8vrmCz2LJrEZLFy9VEm
	i0mHrjFazF/2lN1i3ev3LA6sHufvbWTx2LSqk81j85J6j903G4CM09UBrFHZNhmpiSmpRQqp
	ecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAu5UUyhJzSoFCAYnFxUr6
	djZF+aUlqQoZ+cUltkqpBSk5BSYFesWJucWleel6eaklVoYGBkamQIUJ2Rm/ds1nLljOX/F3
	qVID4wueLkYODgkBE4lZ9+W7GLk4hAR2M0ps+f2GuYuRE8j5xCix/zQHROIzo8Ss7zNZQRIg
	Ddev/WaFSOxilGjbeoAdwnnCKHFp/TZGkCoWARWJ9RumMoGsYBPQlLgwuRQkLCKgJPGx/RBY
	PbNAO6PEzOdnmEASwgK2EgvXngPbwCugLdF5dzozhC0ocXLmExYQm1PAWGJB8ymwGlEBZYkD
	244zgQySEHjLLrHv2jyo81wk/u77xAxhC0u8Or6FHcKWknjZ3wZlJ0tcmnmOCcIukXi85yCU
	bS/ReqofrJdZIEPi84JDbBA2n0Tv7ydMkPDilehoE4IoV5S4N+kp1FpxiYczlkDZHhLT569i
	gQTKekaJ75vbmScwys1C8s8sJCsgbCuJzg9NrLOAVjALSEss/8cBYWpKrN+lv4CRdRWjZGpB
	cW56arFpgVFeajk8ipPzczcxghOjltcOxocPPugdYmTiYDzEKMHBrCTC+33i42Qh3pTEyqrU
	ovz4otKc1OJDjKbA+JnILCWanA9MzXkl8YYmlgYmZmZmJpbGZoZK4rzqtieThQTSE0tSs1NT
	C1KLYPqYODilGpjmvPp76qgRr9CyV87CKyWO1qw58e5micCVMhOHKV4zr0+7M6/+pAmDbWWF
	Rn6t4Rwms4s/lm3YU9Uv5WbVuTxrxbEHVktOx6/5l+hzjFmr6lZDvE/xH94ESZnUVy2/+RyF
	eoy9ipQOfZIvWVoQb3X30v8rOtbFls0bagsn67IuaDBx9LG5srFkldTk86t1cr0ir0dlhFno
	W82bFBEcq6/T3BlWPE18mZbYmu0rHu5iY/Ms/8Qm9nHjCS6eebMfW9kp7k343J5xMW4+p/OW
	Fo7Izg2fn1/2nPBxqytvpG/gjZNmNzYU/pIrb17HcFGw3HPfDjlZ9V2vG6ua9gkVV629p/e3
	5i/v3oN+JhNn/FNiKc5INNRiLipOBADMu8xrFQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsWy7bCSvG7l2sfJBn3fZCz2LJrEZLFy9VEm
	i0mHrjFazF/2lN1i3ev3LA6sHufvbWTx2LSqk81j85J6j903G4CM09UBrFFcNimpOZllqUX6
	dglcGS0z7zIV3OSp+NH+ja2BcQtXFyMnh4SAicT1a79ZQWwhgR2MEu87qiDi4hLN136wQ9jC
	Eiv/PQeyuYBqHjFKHJtzGCzBIqAisX7DVKYuRg4ONgFNiQuTS0HCIgJKEh/bD4HVMwu0M0p8
	Xb+VBSQhLGArsXDtObBlvALaEp13pzNDDF3PKPHq4ApmiISgxMmZT8AamAXMJOZtfsgMsoBZ
	QFpi+T8OkDCngLHEguZTYHNEBZQlDmw7zjSBUXAWku5ZSLpnIXQvYGRexSiZWlCcm55bbFhg
	lJdarlecmFtcmpeul5yfu4kRHOxaWjsY96z6oHeIkYmD8RCjBAezkgjv94mPk4V4UxIrq1KL
	8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLglGpg2tP48v/ENcHKkZEW/lc0
	DS54KGvHRl5gMHZv4dm5fW/pvtdBc+SPSXOv5ON6H3cxL6xwXfPsN+rHK18tfCauE3/7toTX
	bK6rXoaHbttKMBeIXvY8zXf2meE1j/MagT0b+IKPTbP1DTORfuSwcMf5r2WNDdxTpqlPjMk/
	eKIuN8VQQTlM+EPGwwOd+yf+Xbt184+K1+nH1TdcmeFnamiyOd/GSde2RyCo8P75hM3xR/wK
	1JyKa65nSqw+mBiUmutw7fmrvzNtrLN/Tp9ryN7TMedd03m2WaurSlJfm9gusPv0vKDBdNHU
	ReHas5RiEu4sPCS9IHKa99rCmZF7Wac5Xr75VsHFauUkKdmTKzSqlViKMxINtZiLihMBk8Ga
	A+UCAAA=
X-CMS-MailID: 20230208141105epcas5p123332ad24d5dfde7eefcadd655d3d01c
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----20UT-5VtB2RXxRyC_PhwUj8OofNvbA-fDS5AX-3x2UrzL_bJ=_4a7b1_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230208090014epcas5p4a10459c8d27dbe4d8e8f457f845fa271
References: <20230208084939.145257-1-hare@suse.de>
	<CGME20230208090014epcas5p4a10459c8d27dbe4d8e8f457f845fa271@epcas5p4.samsung.com>
	<20230208084939.145257-2-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230208_061118_980651_0BA0ED88 
X-CRM114-Status: GOOD (  14.91  )
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

------20UT-5VtB2RXxRyC_PhwUj8OofNvbA-fDS5AX-3x2UrzL_bJ=_4a7b1_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Wed, Feb 08, 2023 at 09:49:37AM +0100, Hannes Reinecke wrote:
>Split a __nvme_alloc_rq() function from __nvme_submit_sync_cmd()
>to reduce the number of arguments.
>
>Signed-off-by: Hannes Reinecke <hare@suse.de>
>---
> drivers/nvme/host/auth.c       |  9 ++++--
> drivers/nvme/host/core.c       | 59 ++++++++++++++++++++++------------
> drivers/nvme/host/fabrics.c    | 42 ++++++++++++++++++------
> drivers/nvme/host/nvme.h       |  8 ++---
> drivers/nvme/host/pci.c        |  8 ++---
> drivers/nvme/target/passthru.c |  3 +-
> 6 files changed, 85 insertions(+), 44 deletions(-)
>
>diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
>index 787537454f7f..cbb6f1cb2046 100644
>--- a/drivers/nvme/host/auth.c
>+++ b/drivers/nvme/host/auth.c
>@@ -62,6 +62,7 @@ static int nvme_auth_submit(struct nvme_ctrl *ctrl, int qid,
> 	struct nvme_command cmd = {};
> 	blk_mq_req_flags_t flags = nvme_auth_flags_from_qid(qid);
> 	struct request_queue *q = nvme_auth_queue_from_qid(ctrl, qid);
>+	struct request *req;
> 	int ret;
>
> 	cmd.auth_common.opcode = nvme_fabrics_command;
>@@ -76,9 +77,11 @@ static int nvme_auth_submit(struct nvme_ctrl *ctrl, int qid,
> 		cmd.auth_receive.al = cpu_to_le32(data_len);
> 	}
>
>-	ret = __nvme_submit_sync_cmd(q, &cmd, NULL, data, data_len,
>-				     qid == 0 ? NVME_QID_ANY : qid,
>-				     0, flags);
>+	req = __nvme_alloc_rq(q, &cmd, qid == 0 ? NVME_QID_ANY : qid, flags);
>+	if (IS_ERR(req))
>+		return PTR_ERR(req);
>+
>+	ret = __nvme_submit_sync_cmd(q, req, NULL, data, data_len, 0);

First argument 'q' of above can also be killed.

------20UT-5VtB2RXxRyC_PhwUj8OofNvbA-fDS5AX-3x2UrzL_bJ=_4a7b1_
Content-Type: text/plain; charset="utf-8"


------20UT-5VtB2RXxRyC_PhwUj8OofNvbA-fDS5AX-3x2UrzL_bJ=_4a7b1_--

