Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79995C282EC
	for <linux-nvme@archiver.kernel.org>; Sat,  8 Mar 2025 07:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OPqYsI3hxc9wyGnhS0r2qkmtgc1x3/udIq/UKDW7LkI=; b=NuGnu9pc7U9E3up+HX3E4f991/
	RJnfpiX9pzyegsPxuhg6iN5GSDrlAofyeF7zgVH0oy7/oln1AYQgCh5Wadq+8cF7qhPUO1EN/dfB/
	Ne6uLhDbSfyhAmKuzM49RBmxs7nKuwCjLDD1AA7UTcExlpdrGjqSmG0oP48eCgp1Xq7QRNVyvNPNu
	kTzbZcmxAg9a6zR8svFi9/WYjlGdyU81GSiBjfPbzdgI2D/FmpWuZaiSp+v4kOWm3A+jDMUHawKQ3
	8ACKetQ+vxukgfif+eWWyL5gcCB7EzrBUfKsvzRglBmIWjmYDVZEWT+smqqvxp8m42BtVhciyj7Nn
	JupWISsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqp1J-0000000GLS7-0n9L;
	Sat, 08 Mar 2025 07:54:53 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqoy9-0000000GKd5-3xiQ
	for linux-nvme@lists.infradead.org;
	Sat, 08 Mar 2025 07:51:39 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52831RF1009850;
	Sat, 8 Mar 2025 07:51:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OPqYsI
	3hxc9wyGnhS0r2qkmtgc1x3/udIq/UKDW7LkI=; b=A3u+oraodwBMwWxF7CUjis
	ZblRoeqPejY3sgn2wvImfHBSQSqMyGi27xznYM26bNHr+4sV4g8RBImtGYhxQ5vy
	qARvtZxZ6gHZl5KTHsQKwE18BofYOIGQskrk5UpTQDF1kz6nyUwG06Ecbmgauz/k
	Pz4PNCMEB3cS7UuGsMHYbtkNs4obKNpVrB1W1GvSCtN9FlCEU/ooVArJItzTnMna
	4eoS5C9Z4ysIG3PufB8S9u/UNrS/ILCGVqNWzWndZxav6MA+kbVQbqr2qKlC/vcD
	/LXAdnMeQKFbVPm2rYv2+v2D0+wF9FSS7PZEBSB8GAqes7EvDOE3BPznF+LIvMjA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 458dm9rqa8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Mar 2025 07:51:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5286DUxg025026;
	Sat, 8 Mar 2025 07:51:23 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 454f92jska-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Mar 2025 07:51:23 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5287pN1H27460138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 8 Mar 2025 07:51:23 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 394FD581C3;
	Sat,  8 Mar 2025 07:51:23 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9229D581A0;
	Sat,  8 Mar 2025 07:51:21 +0000 (GMT)
Received: from [9.61.47.242] (unknown [9.61.47.242])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  8 Mar 2025 07:51:21 +0000 (GMT)
Message-ID: <8750615b-fa8f-4c39-a530-6770e8cd7553@linux.ibm.com>
Date: Sat, 8 Mar 2025 13:21:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] nvme-pci: fix stuck reset on concurrent DPC and HP
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me, Keith Busch <kbusch@kernel.org>
References: <20250307232618.2141065-1-kbusch@meta.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250307232618.2141065-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YlD-qpSN8kT__mKQx2-dkcFbG9KYEqqI
X-Proofpoint-GUID: YlD-qpSN8kT__mKQx2-dkcFbG9KYEqqI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-08_02,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0 clxscore=1015
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503080050
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250307_235137_997543_F08A394E 
X-CRM114-Status: GOOD (  15.22  )
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



On 3/8/25 4:56 AM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The PCIe DPC handling has the nvme driver quiesce the device, attempt to
> restart it, then wait for that restart to complete.
> 
> The DPC event also toggles the PCIe link. If the slot doesn't have
> out-of-band presence detection, this will trigger a pciehp
> re-enumeration.
> 
> The DPC's error handling that calls nvme_error_resume is holding the
> device lock while this happens. This lock prevents pciehp's request to
> disconnect the driver from proceeding.
> 
> Meanwhile the nvme's reset_work can't make forward progress because its
> device isn't there anymore with admin IO, and the timeout handler won't
> do anything to fix it because the device is undergoing error handling.
> 
> End result: deadlocked.
> 
> Fix this by having the timeout handler disable the nvme queueus for a
> disconnected PCIe device. We're relying on an IO timeout to unblock
> this, which is a minute by default.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Loos good to me:

Tested-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>




