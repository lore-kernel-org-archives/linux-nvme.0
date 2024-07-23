Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C162EC3DA49
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jul 2024 05:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mixbGeHK5nyimLmWe4cCnEjGp01FlVlElH9CDeVNYik=; b=a35nF82Grs25sCBBc265dQznwS
	CRNfURjK34kn+1xkbL+jpqL801wKtiZRoVpTa4kssVoRc07+H+ep4zczANwUS8kYL58t2PRcBPXlE
	ko6v4piQX2vZ2y+OsbvSirvQhoBheqBd6uJ2odVLmhLkl0aNeXfr9+Di2DX+ctynDxOMy/LyV0WE6
	mI+Of1Jx79Np64Ln9rvb6H41CACJiikwLZchw4o941B1Zi5SKcVjijZoKkvmc4mRbOL8rQz6+bk5I
	L7cO4J6lDalD9Do1A3s9VJolSSeSV9KywerZRyIheCvRR3r9whf/5S73+LsrSezRjxrYTdGnGAIS4
	GpDfPAKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sW7ut-0000000BMzB-1LRx;
	Tue, 23 Jul 2024 05:18:27 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sW7up-0000000BMyY-1Zbr
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jul 2024 05:18:25 +0000
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46N2jKtU031861;
	Tue, 23 Jul 2024 05:18:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=m
	ixbGeHK5nyimLmWe4cCnEjGp01FlVlElH9CDeVNYik=; b=DlhrSlUdsl8f0Ppkn
	lqTF1ub2NTevq7hTjM8CgeJtHf8A4r2zxvQtSfYFAzYZvMJdIs3TKq0d1Fn3BFYE
	NcJZcqJASLSaLLTZPKxjmPox/9UCoVkv2YGKceB8lbiMeNf0a9IrAH0rwkpQfjeJ
	SUhIBpPE/oYEvtWu8pFvhsJrlb7jt9hA1rSsnCuYCxe3uwS1YxJcetf51/4xCALU
	T6LNmiSlV9z2QYU30V7LhlB7c9UrqV/8umhB3ZAQOmKHcZGE0z2O55eQK/wQb4E4
	VusjmVMovM3eZoGHrFagXgGuM0kCHexMbVRGAa+foOspWIFxkwfLeLe8XQeEShCu
	69mWw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40hva3h1wk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 05:18:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46N11TVq005818;
	Tue, 23 Jul 2024 05:18:09 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40gy2p8rwx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 05:18:09 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46N5I66T41943604
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jul 2024 05:18:09 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD86958059;
	Tue, 23 Jul 2024 05:18:06 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 19F1D58067;
	Tue, 23 Jul 2024 05:18:04 +0000 (GMT)
Received: from [9.109.198.253] (unknown [9.109.198.253])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jul 2024 05:18:03 +0000 (GMT)
Message-ID: <831af264-7f8a-495e-99b0-51f294e0948f@linux.ibm.com>
Date: Tue, 23 Jul 2024 10:48:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/1] Add visibility for native NVMe miltipath using
 debugfs
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, axboe@fb.com, gjoyce@linux.ibm.com
References: <20240722093124.42581-1-nilay@linux.ibm.com>
 <5nwflcpqoyknrruzdlvgnt5bpcoxh6nrirjwnjes4oazkr7nai@uwsynbuduibr>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <5nwflcpqoyknrruzdlvgnt5bpcoxh6nrirjwnjes4oazkr7nai@uwsynbuduibr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LDWN0U4I43vHBSsasCxwFzHcdCTGl11E
X-Proofpoint-ORIG-GUID: LDWN0U4I43vHBSsasCxwFzHcdCTGl11E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_18,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 mlxlogscore=836 impostorscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407230034
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240722_221823_589619_9CB24D4C 
X-CRM114-Status: GOOD (  18.45  )
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



On 7/22/24 19:48, Daniel Wagner wrote:
> On Mon, Jul 22, 2024 at 03:01:08PM GMT, Nilay Shroff wrote:
>> This patch propose adding a new debugfs file entry for NVMe native
>> multipath. As we know NVMe native multipath today supports three different
>> io-policies (numa, round-robin and queue-depth) for selecting optimal I/O
>> path and forwarding data. However we don't have yet any visibility to find
>> the I/O path being selected by NVMe native multipath code.
>>
>> IMO, it'd be nice to have this visibility information available under 
>> debugfs which could help a user to validate the I/O path being chosen is 
>> optimal for a given io policy. This patch propose adding a debugfs file 
>> for each head disk node on the system. The proposal is to create a file 
>> named "multipath" under "/sys/kernel/debug/nvmeXnY/".
>>
>> Please find below output generated with this patch applied on a system 
>> with a multi-controller PCIe NVMe disk attached to it. This system is also
>> an NVMf-TCP host which is connected to NVMf-TCP target over two NIC cards. 
>> This system has two numa nodes online when the below output was
>> captured:
> 
> Wouldn't it make sense to extend nvme-cli instead adding additional
> debugfs entries to the kernel, e.g. extending show-topology?
> 
Yeah we may extend nvme-cli to print this(multipathing) information however from
where would nvme-cli retrieve that information? AFAIK, today this multipath information
is not exported by NVMe driver. So we have to first make this information available from
driver either through sysfs or ioctl and then nvme-cli could parse it and show it to the 
user. If everyone thinks that it's worth extending nvme-cli so that it could display this 
information then yes we can certainly implement it. Please suggest.

Thanks,
--Nilay

