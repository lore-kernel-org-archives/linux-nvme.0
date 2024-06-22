Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8557EC27C53
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Jun 2024 10:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NFJIO8gh5K7yuMqIjOla+4q+DQwHoonjBnD17CaRVxo=; b=AukwXDZDLFaJX2kJH9TB9Y9uyS
	JY3PnBP7VUURpn1pIVN9JfwicV0NY1QEMq0mRZ1n9TC01xnPpjXGixubn8/DRBUgkws1U8e79RZX1
	FjD16a9dGDoQhIXFua9AH2xR87TnubGSxvJmsQkIxkzfjE9TCpCEXVKE1xSZaCoxz6F4S17N1JAHG
	oBM01xyJpuhZx5zV6qsrzFsfXg2hDB2IhAh2A48NYyTXmk5oahMiDFOcslfjOLWrmPJxUcfdp54em
	yA4lj0wqBs1jPACXJIzK9BKXVD7H9gbYTL6wQkoUuIb8QnjJ9nrkKJB4POibb/B27uMAXYm+Iz2iz
	SjiGKSdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKy5h-0000000BsId-0cOY;
	Sat, 22 Jun 2024 10:35:29 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKy5e-0000000BsI8-0uN9
	for linux-nvme@lists.infradead.org;
	Sat, 22 Jun 2024 10:35:27 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45MATF9m012414;
	Sat, 22 Jun 2024 10:35:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=N
	FJIO8gh5K7yuMqIjOla+4q+DQwHoonjBnD17CaRVxo=; b=Wh8IGjxV9C7aUe/0y
	suLcJdSz0Foy7OYJiO/lPFX5s9SZ1TBL0SgnS1BAItiWhO5IBuKIc3wWzVZaMpTe
	yVhSQ0JW/LlQPNrTSEdWqHGJILQRnKm9EoZhE0/d8BaVhhsC6YXuyjq8INFiAYAK
	nu7yWjKCCLGvTK9rdRbNcn8EGI8XasWAS/+l1pzvvRnVpuI+ve2XwYX9Pn2qNCWk
	1JE+8/eoqr2pV758IZ2+XD00BAOXgoQtR9fGY09fGnVaYQem+Qgi35uzR5ZRXesx
	hE3Axla0F3FXgMNsb9B0WqaD6jFqqSB1ySyzEs4mXEP08Yqz44FRxmMpuN97NHXs
	5AX+A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ywvw4r0gh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Jun 2024 10:35:10 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45M7jeZW030990;
	Sat, 22 Jun 2024 10:35:09 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yvrst3ysb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Jun 2024 10:35:09 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45MAZ69O53084554
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Jun 2024 10:35:08 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 47E7D58043;
	Sat, 22 Jun 2024 10:35:06 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0972658059;
	Sat, 22 Jun 2024 10:35:03 +0000 (GMT)
Received: from [9.43.65.57] (unknown [9.43.65.57])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 22 Jun 2024 10:35:02 +0000 (GMT)
Message-ID: <702e63dd-8fe6-4c23-89fd-7075573bb445@linux.ibm.com>
Date: Sat, 22 Jun 2024 16:05:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nvme-cli] nvme: warn about attaching a namespace to
 unknown controller
To: Keith Busch <kbusch@kernel.org>
Cc: dwagner@suse.de, linux-nvme@lists.infradead.org, hch@lst.de,
        sagi@grimberg.me, gjoyce@ibm.com, msmurthy@imap.linux.ibm.com,
        axboe@fb.com
References: <20240620125604.3017138-1-nilay@linux.ibm.com>
 <ZnWXc8wrNR_ijnTH@kbusch-mbp>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <ZnWXc8wrNR_ijnTH@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RmKhb2x0KvhtDHzo5qGJoTGtdipbNjBv
X-Proofpoint-GUID: RmKhb2x0KvhtDHzo5qGJoTGtdipbNjBv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-22_06,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406220073
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240622_033526_513738_B4DA24EC 
X-CRM114-Status: GOOD (  18.71  )
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



On 6/21/24 20:38, Keith Busch wrote:
> On Thu, Jun 20, 2024 at 06:25:45PM +0530, Nilay Shroff wrote:
>> Sometime it's possible for a multi-controller NVMe disk to have only
>> one of its controller discovered by the kernel. And if this happens
>> then it's also possible for a user to create and then attach a namespace
>> to a controller which has not been discovered by the kernel. In such a
>> case the attached namespace can't be used for IO because there's no path
>> to reach such namespace from the kernel.
> 
> Isn't that a pretty normal thing to do, though? Like for an sriov
> situation, a primary controller attaches namespaces to secondaries, but
> not to itself.
Yes correct, but in case of sriov, AFAIK, the "nvme list-secondary ...." shall 
not list any secondary controller unless the secondary controller's corresponding 
VF is enabled (i.e. /sys/class/nvme/nvmeX/device/sriov_numvfs set to at least the 
secondary controller's VF number). 

So it means that before attaching namespace to secondaries, user would first set 
sriov_numvfs. Setting numvfs would then enable the kernel to discover all secondary
controllers. 

However, in the proposed patch we're trying to address a case where "nvme list-ctrl ..."
shows multiple controller entries however only one of those controllers is discovered
by kernel. All controllers shown in the output of "nvme list-ctrl ..." are physical
controllers on the nvme disk. In this case attaching a namespace to any of the 
undiscovered controller has a side effect due which the namespace rendered unusable.  
This patch tries to address this issue by showing a WARNING to the user and optionally
allowing user to cancel the attach operation. However if user still prefers to go 
ahead without cancelling the attach operation then nvme-cli would execute this command
as usual. 
For sriov use case, as secondary controllers have been already discovered by kernel 
before we attach namespace to secondaries, it doesn't have any side effect. 

Thanks,
--Nilay

