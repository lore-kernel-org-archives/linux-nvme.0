Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE61DC27C53
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jun 2024 10:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/Rj6uGU++1hB8jn000lJ8DZPwnf+z59uWsb47QYCAdg=; b=Zzee05pta8vhHBwrRd+X+ZAUjK
	53/EuL2Jmi+9CTFq0wyUiac+OVIX0I4VuRzCDBmR4TrvsOPG4T/rOV3wSjC/heJV0d8jssp4C5AJd
	FaQKZrQgOUFrQiq/JNUDAZY9deHG2vF9xCQBTeaqOiHsBU9k7L1oRNVLfNEZUGv9aj9Qgu0x98fhd
	Vu9b6xS58kQCyuGFA9xXAYON8JlNgLm9jdOtgkW1YDAm1Zr4wslKqf8jH6eomjAYhqHhgM8Vjh6ln
	IHZvv3ecNNTeNq3k4yuPQU+ej5+JW+n77+CemFLJ3DKvIYbF7KKXbpoB8NKDbkOe23A3IO+aaLTv2
	LltA7oYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJstL-00000000qwQ-1j2i;
	Wed, 19 Jun 2024 10:50:15 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJstI-00000000qvU-1O3Y
	for linux-nvme@lists.infradead.org;
	Wed, 19 Jun 2024 10:50:13 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45JAQYmZ017859;
	Wed, 19 Jun 2024 10:50:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=/
	Rj6uGU++1hB8jn000lJ8DZPwnf+z59uWsb47QYCAdg=; b=kC301Qk6rnNMOnAMq
	/0NQU9sLLxAIKwBIoD02TFqAJwZowa7+yaoOefhqiKcV0Su6uKmSMS40U/83nQLw
	k6ZfzF70hRw1rxYp4IGkm0wD510aoMdLwBK4EXNPw8HNQQKXt7GdOr2oPpyKSpCw
	QObj+hySFhjZNYJNL+XuNFz1ttw1AC9ft1CsWPc7kC5jz79exSjfHz8jg7/jZLhB
	pc/gPgHQ0cWjgij/3F0E9PO05ga9Ft7k6gZUHyNKXVgdtWb58F1trvs6SIT43oxU
	AyoFF+XgHDEMZTD+m6Qxg3cuSiVMxyVaoOau2MahwDCskhoZ2JFkxtcqSyv0mLRu
	P2jdg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yuwbxg26e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 10:50:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45JAMwQQ023881;
	Wed, 19 Jun 2024 10:50:04 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ysp9qbhad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 10:50:04 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45JAo00G19071518
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jun 2024 10:50:03 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A90A058068;
	Wed, 19 Jun 2024 10:50:00 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 009DE58067;
	Wed, 19 Jun 2024 10:49:57 +0000 (GMT)
Received: from [9.43.48.107] (unknown [9.43.48.107])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Jun 2024 10:49:56 +0000 (GMT)
Message-ID: <9383e2de-7431-44af-9c9e-80135df2e79a@linux.ibm.com>
Date: Wed, 19 Jun 2024 16:19:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nvme-cli : attaching a namespace to an undiscovered nvme
 controller on multi-controller nvme disk
From: Nilay Shroff <nilay@linux.ibm.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Gregory Joyce <gjoyce@ibm.com>,
        Srimannarayana Murthy Maram <msmurthy@imap.linux.ibm.com>,
        "axboe@fb.com" <axboe@fb.com>
References: <f1a7c1e2-3203-4b7a-a922-82fa812455bd@linux.ibm.com>
 <yhvmfctxhfzrcsq4lx6nr3f5n67kegrixtthh3pals7vn5qr26@k5as5whcdrum>
 <dfb2488a-6275-4822-94ec-07a575cbf09c@linux.ibm.com>
 <88f230c4-e16e-4a16-a4e6-a48e605147f1@linux.ibm.com>
 <56198b02-b8fa-4afc-8405-5232d1bf23ab@linux.ibm.com>
 <i2pwif6tfqt4cuodue7bs2lrithuxplmtwmsgwioraih4h3ppd@krnf2pxuijet>
 <73e15f32-950c-416f-b488-bc5244f8fcf3@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <73e15f32-950c-416f-b488-bc5244f8fcf3@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8aaeM5GzKFKHYDlaNi6bq89GHsrzZVRy
X-Proofpoint-ORIG-GUID: 8aaeM5GzKFKHYDlaNi6bq89GHsrzZVRy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=737 phishscore=0 impostorscore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406190077
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240619_035012_408887_4139C981 
X-CRM114-Status: GOOD (  12.77  )
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



On 5/27/24 19:32, Nilay Shroff wrote:
> 
> 
> On 5/27/24 19:06, Daniel Wagner wrote:
>> On Mon, May 27, 2024 at 04:50:34PM GMT, Nilay Shroff wrote:
>>> A gentle ping, if the proposed patch looks good then may I send a formal patch?
>>
>> Sorry for the delay, very busy month. I'll look into it next week.
>>
Hi Daniel,

A gentle ping, just wanted to check with you whether you got a chance to review this change?

Thanks,
--Nilay

