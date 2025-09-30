Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A07CCAC5B9
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Sep 2025 02:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vLNvmAX5Xt8Q/R0A2/3tomgqsbhwzkRUJEIgjrj+27o=; b=gw5mJEy41Rwqm5bq3Q6kgS6WsF
	ySRYPg+pHwdAmfeZo82KzUlN5CPoG64/EmXqcV+c9OAjIWvjMIXIbOg4OTgwurTJy7egjDyN2kNvE
	kdQx7wLhrEUHOLoiA1cQEdgdTeeyZmsWPQVkxK2Mgv4+iZH4WmVZ8XGGVK8/sElIZVSRIpVzxCHHV
	v1kdN8PiEUBO+RJUSkM6oWYlxDd4BsuPl85VeFYLMxZyVrTOSm1C3sPjAEUPKc+HPa4c+kC0Z6bSa
	RafI2iZXtTpm2kfwtfFYiOE84ztNMC4We7RXLEr6B18Qt317BXJ9EzBxFNdWNdeqX3cHRXy+mjZMq
	J5DhBujg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3QEj-00000003v7w-1oNs;
	Tue, 30 Sep 2025 02:37:05 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3QEf-00000003v7W-3flB
	for linux-nvme@lists.infradead.org;
	Tue, 30 Sep 2025 02:37:04 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U14csg025573;
	Tue, 30 Sep 2025 02:37:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=vLNvmAX5Xt8Q/R0A2/3tomgqsbhwzkRUJEIgjrj+27o=; b=
	iWiuoS5LMMbOQC5KaqI32Svtpm/4TQA0tVW6SgmfPWYe7CTMjbtUgGjqShCKKi3Z
	v2ysLDA9MnpV2coA7gS/e2Z4U5SRYtSK1gIkvBcygZ1GdXZwbxz1kDEHaadHaLNH
	fd7P+EK5ByDgxSiYNhOnqARXrZU8jhYy2JDuzHc0NaViY3tWdZFmP3HAykEPL8Ql
	+UAvqkOGklJwYcnl037LIaHHUEu2HTQvRZ3+quHdM/OvdvnQqwha5IH7rzfn/G40
	ff3ZPojO2fqIjmxlPkWs2+Ygfc4NBljxiAesBW5mrlIRL42DJ+xt2PGN1GQ657Mc
	eGz9pNIlplnrN5fvg9YYyA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49g57j03tf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 02:37:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58TNPJfU007737;
	Tue, 30 Sep 2025 02:36:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49e6c86eva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 02:36:59 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58U2awVB004400;
	Tue, 30 Sep 2025 02:36:59 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 49e6c86eur-2;
	Tue, 30 Sep 2025 02:36:59 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
        James Smart <jsmart2021@gmail.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] MAINTAINERS: update FC element owners
Date: Mon, 29 Sep 2025 22:36:48 -0400
Message-ID: <175917739983.3755404.3468767422669757188.b4-ty@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923153857.100616-1-jsmart2021@gmail.com>
References: <20250923153857.100616-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_08,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=610 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509300021
X-Authority-Analysis: v=2.4 cv=VcH6/Vp9 c=1 sm=1 tr=0 ts=68db424c b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=0W-ltN-VO2jgyzCNt1IA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: IZ5s85aGgnrBVOB17z3qWyXDxoT2NjbE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDAwNiBTYWx0ZWRfXydp4iuJewIJB
 mZfxTPnataDsZb/Hol8HdEaAqjHAYuxO94eP8PaKMwTEX8nuHl4g5SY4NA7jWAdo2YkCWEIyQX+
 rggRCNBJ5HotQDXTH/xNkq94Imi5DNm0/uiMY/1idkee9Qrh9eDwWBrIpxTD0XJ6vUKPT+u04nO
 3b56epZCbTZqhcN+aCgbR2PEGqSDOdVBWuqgDDpLyL6+A1Wakle4zjX/dp0GrDrweClqSfkC1HM
 xBXWqgGhWep/vNrSkNYUHBOr4IGWWZTc8xjvOw1EBxbxUpNgH9E/dzJA+5GKRevLwG2TljKpoyU
 qUVFdBZz42Xru7UGMvn33SALPuiJvqaQNKDp52zHVnTfhV1Tw6AzubdL82xAzeaf+S/LQCUOLpz
 32RLMbxS94rw9/++g6V7Z8GWH+zLbw==
X-Proofpoint-GUID: IZ5s85aGgnrBVOB17z3qWyXDxoT2NjbE
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250929_193702_162116_F8668D66 
X-CRM114-Status: GOOD (  10.22  )
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

On Tue, 23 Sep 2025 08:38:57 -0700, James Smart wrote:

> I'm relinquishing my maintainer position on the different FC elements.
> I am updating them to the Emulex folk that have been watching over them
> for a while.
> 
> 

Applied to 6.18/scsi-queue, thanks!

[1/1] MAINTAINERS: update FC element owners
      https://git.kernel.org/mkp/scsi/c/fb641516a668

-- 
Martin K. Petersen

