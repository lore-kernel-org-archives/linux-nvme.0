Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 907DBC4332F
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Nov 2023 14:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HWULfG+abF+ePQG7l/L/5GjH+Gvs41lpYGoGn55mDBQ=; b=4K8v7OIFvdgxW4CwjCl3Tl+pc9
	5AmYJ9Qgw0E+45YoUy/FjcerARL2tTCO8OmVc4iGO5vpPgb2HuWdbLN7lNvlsoInwoWJPRLooCAfX
	4p8exkWaRCksEvgVXy7O6NqESkthKp2D2zOpw8lsaHo4YuPGsPHyYhk3vhInP4xEWzL7skY/7SPL5
	GxQJrPIC8jf0IlaxpCDWWIF/+hk9KjsLSoQs+gLUL9OwwzYVpOo+SQ725+QH54YVP9Iuwn90Pn+IY
	/9mQXeM3iQKTAD33pZyU9jkE+tPy2OjWA7YnBNtEUwIjlHknXg66YRXTxVpu/p/0TfyaMdvLSzW6o
	YYmuHPbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0N7P-001jWt-33;
	Tue, 07 Nov 2023 14:31:51 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0N7J-001jVZ-0n;
	Tue, 07 Nov 2023 14:31:50 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7EHHSf009639;
	Tue, 7 Nov 2023 14:31:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=mime-version : date :
 from : to : cc : subject : in-reply-to : references : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=HWULfG+abF+ePQG7l/L/5GjH+Gvs41lpYGoGn55mDBQ=;
 b=Jhiet6KsZaDdIS6W7iRQ2rtP8h6P/FK6eTPxv2Q7v2VyyqRBURjyeoCQCvqGEWvtNxa1
 6x5/Q35DN5BxgueClfsjjNzha5lsXWrJiffo/6mbqVjf/A9PEg1V7IA/JkjeVrrv6bVk
 qhsFRIGeod5aWLDfg2v7fFa5N2+I6osKCWPjA9c/G/nUlXLLnOWStKcikRSbZ2HF/TXV
 7obZRel818YyL2pnboaSSOlcVaxqBhs5/qPGe64cVCXPYnjAbeY2C/lRBtkjRqrSA5pH
 GL0yF9dLyn4QrVG4iB65sOnvkd+Lt3A9nA+J6F3l1rNeZLFmIPltSetGb1qbWBTQGE7J 0g== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u7pvb0p94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Nov 2023 14:31:41 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7E8E0i028276;
	Tue, 7 Nov 2023 14:31:38 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u62gk0su9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Nov 2023 14:31:38 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A7EVbNC8127070
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Nov 2023 14:31:37 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B376058057;
	Tue,  7 Nov 2023 14:31:37 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 715C758061;
	Tue,  7 Nov 2023 14:31:37 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Nov 2023 14:31:37 +0000 (GMT)
MIME-Version: 1.0
Date: Tue, 07 Nov 2023 08:31:37 -0600
From: Wen Xiong <wenxiong@linux.ibm.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-nvme@lists.infradead.org,
        Wenxiong <wenxiong@us.ibm.com>
Subject: Re: Saw I/O errors while delete/create/attach a namespace on nvme
 device.
In-Reply-To: <299987e5-ffb8-461c-9228-cad7e17cc542@nvidia.com>
References: <ee222a8c6574d754d7e6355591e1a06a@linux.ibm.com>
 <ZUn70pL+YV0adqd0@infradead.org>
 <299987e5-ffb8-461c-9228-cad7e17cc542@nvidia.com>
Message-ID: <dd07dbc043e38a7a4dcaee0b6d2835ec@linux.ibm.com>
X-Sender: wenxiong@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RJo3lpRbQczJMJE5c3Txxfu_UEg0CWBC
X-Proofpoint-GUID: RJo3lpRbQczJMJE5c3Txxfu_UEg0CWBC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_06,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 spamscore=0 clxscore=1011 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 mlxlogscore=687 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311070120
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231107_063145_326106_1AF41C8B 
X-CRM114-Status: GOOD (  11.97  )
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


> To check exactly which id is problematic something like in [1] can be
> used, totally untested ...
> 
Steps:
# nvme detach-ns /dev/nvme0 --namespace-id=1 --controllers=0x81
# nvme delete-ns /dev/nvme0 --namespace-id=1
# nvme create-ns /dev/nvme0 --nsze=562805846 --ncap=562805846 --flbas=0 
-dps=0 -nmic=1
# nvme attach-ns /dev/nvme0 -n 1  --controller=0x81

Below is linux log with your patch:

[  149.570987] nvme nvme0: rescanning namespaces.
[  149.578714] nguid mismatch
[  149.578719] nvme nvme0: identifiers changed for nsid 1
[  149.582291] block nvme0n1: no usable path - requeuing I/O
[  149.722140] block nvme0n1: no available path - failing I/O
[  149.722157] block nvme0n1: no available path - failing I/O
[  149.722165] Buffer I/O error on dev nvme0n1, logical block 281402912, 
async page read
[  149.722171] block nvme0n1: no available path - failing I/O
[  149.722175] Buffer I/O error on dev nvme0n1, logical block 281402913, 
async page read
[  149.722181] block nvme0n1: no available path - failing I/O
[  149.722185] Buffer I/O error on dev nvme0n1, logical block 281402914, 
async page read
[  149.722191] block nvme0n1: no available path - failing I/O
[  149.722195] Buffer I/O error on dev nvme0n1, logical block 281402915, 
async page read
[  149.722203] block nvme0n1: no available path - failing I/O
[  149.722208] Buffer I/O error on dev nvme0n1, logical block 281402916, 
async page read
[  149.722217] block nvme0n1: no available path - failing I/O
[  149.722226] Buffer I/O error on dev nvme0n1, logical block 281402917, 
async page read
[  149.722231] block nvme0n1: no available path - failing I/O
[  149.722233] Buffer I/O error on dev nvme0n1, logical block 281402918, 
async page read
[  149.722237] block nvme0n1: no available path - failing I/O
[  149.722239] Buffer I/O error on dev nvme0n1, logical block 281402919, 
async page read
[root@ltcrain119-lp4 ~]#

Below is nguid changes:
# nvme id-ns /dev/nvme0n1|grep nguid
nguid   : 37444630577000630025384700000245

  nvme id-ns /dev/nvme0n1|grep nguid
nguid   : 37444630577000630025384700000246

Thanks a lot!
Wendy

