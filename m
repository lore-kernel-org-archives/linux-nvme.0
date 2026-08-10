Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A368C5B56A
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2026 17:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LoE0Dq18YtpC8TIrQHLsVs0BdNyHQn1se03jEp6FKWc=; b=4dzbMDIGAN7PLqO+0xpyTcRvEE
	/oTqr21XYi9RVg4p2K6LiRPUTcfX1akl6Wauh8mlX58xGqlyc/F3BhcEOkmmBq6Cro1YAE53yHD7e
	5x7uW3RV7Mxc/buNtS7Qr/HrxxNsOvbTkEjrQCxmz2UaRWG6nmAKiNLvjesZGGHkJ3uYkqp8CdGlb
	UbAddF/LycjixsSHX/4/uUxk6tsprP9EKL2Raexk4StUeHhSOIdDF/N8ldFOmJrPZj9LwBQ7lUTmI
	5CHHuppNBIph2PteuQdA7WKT1BgR+6Q3kvtANClPu0ZYSPCpwXwfvQBOUWW1HYWVeXhnCe0oRBRXj
	PTbSP9jQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtTmq-0000000CWp5-1JMc;
	Mon, 10 Aug 2026 17:27:44 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtTmo-0000000CWoj-1jkk
	for linux-nvme@lists.infradead.org;
	Mon, 10 Aug 2026 17:27:43 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AGVhDG2069732;
	Mon, 10 Aug 2026 17:27:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LoE0Dq
	18YtpC8TIrQHLsVs0BdNyHQn1se03jEp6FKWc=; b=Xyd4dDd1S6eP/o/dQf+3gt
	AK0502E12TuWCf2/UzpJoX18t9CJYPAUpN5ROXcSn3GKPpeSZ6DkaBQyS5pPwjn7
	doxxnb8uM+vZVHYFkRXSZwiwQVNxShI6nmuD79LDuNLFiYl+eb7LXaboMJNm5mM8
	i3U70nGNI0jTfh32Fv8FonTXlDdv4K7Tf1q3t9k8HqN2BZBHNAMtKKfdl6xlX6cx
	XWsCNdx2yRA8ol7rWmDXxX6VfnsNoXgH42+KyhuG07S6FQSu/urFW2QVPfVi4lx5
	SccYKxxbPiBp9j5a23kYrACYGza5ZVptNtHtkhHGzxdScYieC5IiK15bfIRvLrgQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp2rua6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 17:27:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AHQHrX012746;
	Mon, 10 Aug 2026 17:27:33 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5vwvqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 17:27:33 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67AHRXhF32834128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 17:27:33 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 906FB5805B;
	Mon, 10 Aug 2026 17:27:33 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D132158059;
	Mon, 10 Aug 2026 17:27:28 +0000 (GMT)
Received: from [9.43.109.88] (unknown [9.43.109.88])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 17:27:28 +0000 (GMT)
Message-ID: <e229a15e-26d1-44e6-8cb6-fa59255d609e@linux.ibm.com>
Date: Mon, 10 Aug 2026 22:57:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/9] nvme-multipath: introduce latency I/O policy
To: John Garry <john.g.garry@oracle.com>, linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, kanie@linux.alibaba.com, jmeneghi@redhat.com,
        randyj@purestorage.com, martin.petersen@oracle.com,
        gjoyce@linux.ibm.com
References: <20260809100825.2014133-1-nilay@linux.ibm.com>
 <35c99788-ad97-420d-b16d-5ba8f6a28f82@oracle.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <35c99788-ad97-420d-b16d-5ba8f6a28f82@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7a0a07 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=9umD5zGNq9ShWiyR0NYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 4K5_Muv-JYjOpHCg2UGTeFk3sCcHb5-X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE0NiBTYWx0ZWRfX0wtVyd322SMP
 IwHnoXwLIdp+l3IMFH3SAhaALNcNRRSTpJQ+Kkj/z4fifflrWRd6Jg/WoUD8ME1sM5ZUB/3e4Ku
 ZD4r/2dIJRZWfRRVS8LIJXSeCPqnJV3pvuWCMVxTpywTcEMI0VblZF3wHHugkHzuWPfHUrO3iEv
 kkqVStMZ8pO8/7cPJwb7qqONY8kyCtqSd9/2D0mSerbzgnf57zYun11QkvZR3FWYz++j98r88ed
 Gp1TfeQrKSyhoXHTI/Cz1naV+MGfc+l418kfBK4h777yAxgmOC5Ajbml+ZlXSEVFkjbbjspmZmm
 Ghnu4cyVCKLd+kO3xcoFrOcYtGCtbMdBDXonmkP7N/JbTw7kBumrv58G2ooNhUQcG7iQJBX3xuX
 uS8/GoTdBfncYxHNY/7CMu0QXhNhzJBvfH+GXf2xAq+ynJZdHMAC4Vkj97ttfCTq25oha6kgRNH
 EFrkvbNGNgJMnSe52rw==
X-Proofpoint-ORIG-GUID: VU7LeymR74vSDwXaNkSLWMAGWcyxY1PJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE0NiBTYWx0ZWRfXyPmVwN3A4ElB
 XO1tGFEm1qtCc8rLIrD/4+BEDWH21Zt1z2PQ/kdBKaz6snDgUKSOmk3dit71FQG4ZM+n+Tfg6g7
 GT1SibYQq/UMp10b/BTKpMt/V1fBwzY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_04,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100146
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260810_102742_595122_BC3FC1A0 
X-CRM114-Status: GOOD (  11.33  )
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

On 8/10/26 1:20 PM, John Garry wrote:
> This does not apply (cleanly) to the nvme-7.3 branch. It applies to v7.2-rc7. I would think that it should apply to the nvme-7.3 branch. Or am I missing something?

Yes, you're right. It should have been rebased onto the current nvme-7.3 branch.
I'll rebase it and send the updated version in the next revision.

Thanks,
--Nilay

