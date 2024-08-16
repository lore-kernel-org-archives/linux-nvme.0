Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98AB6C3DA4A
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Aug 2024 08:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZSKAiHcliGD6jG67OFbdjXSH7FOjBWw7FI5WsLId49M=; b=N8fwl7JD7jNJAQ9+wI5ztQ9321
	rMTUhOl8F1ZSLjYUqgbLOUrd4DO2h53VpyIgZ7GZcMVGdrMpmAVt9ioS1KErCGvI2Re++/lmUG5/y
	AM+WQd9qc6K4MdeupKZ2LdFdNpVd30NUjnwVqdOdaHvwoZYZOStls9FZgWDh7Q7VGlQ3EC7fGlhUQ
	Zfv52mirCmlnSPd6UzyqbJxjlUFAFNCuOJZW2Y/suxk1i8xsOAfQb/5pCRCiC6Db+sdYJ988IMbxY
	ADso3RdDnNjDXd5iQNE3EoWq4+JHIwjiMo3oIM836YvVC706O7r7sKuZB82gdTKUXoyJY9g72KXOE
	bCge07uQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seru0-0000000CD1s-2aGq;
	Fri, 16 Aug 2024 08:01:40 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sertx-0000000CD1K-3Q7G
	for linux-nvme@lists.infradead.org;
	Fri, 16 Aug 2024 08:01:39 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47FLqWhW001403;
	Fri, 16 Aug 2024 08:01:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=Z
	SKAiHcliGD6jG67OFbdjXSH7FOjBWw7FI5WsLId49M=; b=hecPdNwglgPoQ77Ol
	X+zO9tDWtnOxSBO5iYsZsLCgdFLrfBCTIFhTPBvFGHcL0PxMmfyYhb2puARRusoi
	nx8G6BKzp9nNwVEFMyarG9cNEgbjk82z33AzDnHivHrVDets/pIimU6OCxxnSuqe
	iZeazZyplQY7msYFHfxpRVqIFAscj95Fq8r73jTGe7mRAAm3ATl4GoFlQKmtua0m
	4kFApqXwe9KBcosNGEWgfKxJ8GptU7hf/S/OJ7GvdT6I94t3DQTkhPbu7R6ftsZr
	ZUV2PRA2vi+Egxq9iV0ew9ABJ+52aYIzy5DkddRQ1WYPehGAf6UbeWmxEHGhOq3K
	fKomg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4111j5yfvk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 08:01:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47G6geU0016237;
	Fri, 16 Aug 2024 08:01:24 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40xkhq2pcg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 08:01:24 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47G81Mag3015196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Aug 2024 08:01:24 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3059D58061;
	Fri, 16 Aug 2024 08:01:22 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A68D5806E;
	Fri, 16 Aug 2024 08:01:20 +0000 (GMT)
Received: from [9.171.88.190] (unknown [9.171.88.190])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 16 Aug 2024 08:01:19 +0000 (GMT)
Message-ID: <03e0c314-1b56-47bb-802c-49b4020224e2@linux.ibm.com>
Date: Fri, 16 Aug 2024 13:31:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: Remove unused parameter
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, gjoyce@linux.ibm.com
References: <20240814135702.99402-1-nilay@linux.ibm.com>
 <20240816054111.GA29113@lst.de>
 <16c5ec69-da33-49ef-9032-ef0cb9ac09f7@linux.ibm.com>
 <20240816075953.GA6703@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20240816075953.GA6703@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TclhsoKpHodErKFO8GycRiNn-_oKDvQ9
X-Proofpoint-GUID: TclhsoKpHodErKFO8GycRiNn-_oKDvQ9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-15_18,2024-08-15_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 mlxlogscore=693
 bulkscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408160053
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240816_010137_889778_57BE66B9 
X-CRM114-Status: UNSURE (   9.84  )
X-CRM114-Notice: Please train this message.
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



On 8/16/24 13:29, Christoph Hellwig wrote:
> On Fri, Aug 16, 2024 at 12:30:45PM +0530, Nilay Shroff wrote:
>> Yeah ok, if you prefer, shall I update the patch subject line and 
>> resend the patch?
> 
> Maybe Keith can just fix it up.
> 
OK thanks!

--Nilay

