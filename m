Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D48C3DA4A
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Aug 2024 12:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:Subject
	:Date:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gfrQUcaV+s7Gq+mfEJj2TyZrzhoHEQtKSiBupzjJV6w=; b=vk9pOKerC5REwUSqd9FvLx9tlO
	52K9rfy88SPqyyxk7SIx1qFn5I47yRGtGCMazAFjBHOew+M0wIiZEpGjF1bb4xCxryGc4Y0kd/Y46
	3FwNGDbdk4eyCF70p9yuoKWGmwkkQmUHn0AIi9hZrirvGduB+RNe+uBy68eppu2j5oq+vv1Lq1a1I
	dkBrUsDmWHrBzbOJeKWOHBTx1f1CYGS3ySmv9xMQBTkEbV4Ch7NbTz79rBfV8iVqtAFDXdgR3sL+P
	QOdUSXnPlb3p6zY5bJ8hjA8kRJPO3jN1AbLskD+pMVc15i3lvunVrNPQ+ODnmuq5qgqQzn4awpJ9J
	jyzuNcvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZrDQ-00000008mi2-3xC9;
	Fri, 02 Aug 2024 12:17:00 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZrDN-00000008mgf-1ZGh
	for linux-nvme@lists.infradead.org;
	Fri, 02 Aug 2024 12:16:59 +0000
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 472AuAU3022965;
	Fri, 2 Aug 2024 12:16:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	gfrQUcaV+s7Gq+mfEJj2TyZrzhoHEQtKSiBupzjJV6w=; b=WbN0ni5jlWG+TLVK
	tjVqme9RTMj8HccdsCMCd+LnwFdp+l1FboMEB6tD/JrW0MK/x0qAN3VF+6xyikKJ
	YV/DXHoPzp/rXirQmwroXXop/oNkC3UuE5NoFx+lvPnXAH69/X26WIGpB+m1K6Gg
	rctsAE2V7NOQxxvrImmEk5W3H8P+oO2fQclFWJlu9UHR0IJO0gIrqQpIold1o6d4
	YwjyR/VdYAfBvxhLd2wKUynfQ+fbAzUwrksUno3aV8qy/8NkB0/KbEEr3lN1Fw5b
	3uaxtZzJ6fk/tyBLZPPVQLWdDYn/G+DYE1WblYRjU5HDj14Ly5uGNJ2Pjp8nd2Sn
	LnzDMA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40ru3grjp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 12:16:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 472A02Gl007682;
	Fri, 2 Aug 2024 12:16:53 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40nb7uqd6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 12:16:53 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 472CGpuZ25625122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Aug 2024 12:16:53 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 379225805D;
	Fri,  2 Aug 2024 12:16:51 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 11C6758052;
	Fri,  2 Aug 2024 12:16:49 +0000 (GMT)
Received: from [9.109.198.216] (unknown [9.109.198.216])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  2 Aug 2024 12:16:48 +0000 (GMT)
Message-ID: <ab363932-ab3d-49b1-853d-7313f02cce9e@linux.ibm.com>
Date: Fri, 2 Aug 2024 17:46:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: blktests failures with v6.11-rc1 kernel
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "nbd@other.debian.org" <nbd@other.debian.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <5yal5unzvisrvfhhvsqrsqgu4tfbjp2fsrnbuyxioaxjgbojsi@o2arvhebzes3>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <5yal5unzvisrvfhhvsqrsqgu4tfbjp2fsrnbuyxioaxjgbojsi@o2arvhebzes3>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bGpNXLnrJPuFn3RsWliBR8kq6B5Dy3Py
X-Proofpoint-ORIG-GUID: bGpNXLnrJPuFn3RsWliBR8kq6B5Dy3Py
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_08,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 clxscore=1011 spamscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408020081
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240802_051657_564906_7FEF8EB5 
X-CRM114-Status: GOOD (  13.79  )
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



On 8/2/24 14:39, Shinichiro Kawasaki wrote:
> 
> #3: nvme/052 (CKI failure)
> 
>    The CKI project reported that nvme/052 fails occasionally [4].
>    This needs further debug effort.
> 
>   nvme/052 (tr=loop) (Test file-ns creation/deletion under one subsystem) [failed]
>       runtime    ...  22.209s
>       --- tests/nvme/052.out	2024-07-30 18:38:29.041716566 -0400
>       +++ /mnt/tests/gitlab.com/redhat/centos-stream/tests/kernel/kernel-tests/-/archive/production/kernel-tests-production.zip/storage/blktests/nvme/nvme-loop/blktests/results/nodev_tr_loop/nvme/052.out.bad	2024-07-30 18:45:35.438067452 -0400
>       @@ -1,2 +1,4 @@
>        Running nvme/052
>       +cat: /sys/block/nvme1n2/uuid: No such file or directory
>       +cat: /sys/block/nvme1n2/uuid: No such file or directory
>        Test complete
> 
>    [4] https://datawarehouse.cki-project.org/kcidb/tests/13669275

I just checked the console logs of the nvme/052 and from the logs it's 
apparent that all namespaces were created successfully and so it's strange
to see that the test couldn't access "/sys/block/nvme1n2/uuid". Do you know
if there's any chance of simultaneous blktests running on this machine?
 
On my test machine, I couldn't reproduce this issue on 6.11-rc1 kernel.

Thanks,
--Nilay
 

