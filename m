Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E08CD1288
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Apr 2024 13:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OzkaRMl38U1fr/NRTunPsHunHTJ4PVR70b1Hql6F0nM=; b=ZWRYohdLltptmJv3zuF4kN28nI
	PFsUvD+lxkAXfFoJdQVt6HLPBlEzqLlWUCGAngZVxvn1pJL2y3rMQxxhYg3aLZTJ+zybJmR2ovguk
	3kCF93YeRamAYvtvWR5cpASRaGGFbeaC1+wE1G62pLM3uOLagd2aeCHmcHn+kHVVdinWOMZdwwyew
	g7lG1wHrkb1lUQ7cWuGCehcoTfmivnmkOkGY8ujHJlkMR3cl+ZOv8JmzPz5SkBBq4ddBwLA0ZlFd7
	vbSsHahPtamN9jFtgz3dzW5uLxl8FNzYGmJFhwGEQJpy5UNO44ls7ogwPqQ8Wcf+py+EftHJdtpYX
	/DpemuhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rs0eY-0000000GCcP-03f2;
	Wed, 03 Apr 2024 13:27:46 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rs0eV-0000000GCZk-11tS
	for linux-nvme@lists.infradead.org;
	Wed, 03 Apr 2024 13:27:45 +0000
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 433DIDH0028098;
	Wed, 3 Apr 2024 13:27:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=OzkaRMl38U1fr/NRTunPsHunHTJ4PVR70b1Hql6F0nM=;
 b=VmqUaUGs/KCTT7vVtx0OQ4fuvqF40dk09+vw/Rqd7pY+n+Z8xfAQ/VCFyf70GSmH0tyj
 uvJr/wsmXqC0vOa6/qGMeT7OQkhgoQ3J/3asNkwdl2JuCuMPZ4gmT9qi8bGgDJovQfJX
 0rRZqcnPpUwihi7TZNH2Vz13wANCQ9AH/amB2/885KtfsizdRKSYPP0C7stxs3E4fdj7
 e8he3GQkoTZLwjk799LYpYghDdM9C2SWGv31/+3+DLyUuiLG3si+X6q07zy3ME3QGchA
 o9Ao6VMzPYhSQPDxTSy6tnnIsfR8NIK5v0KzPNLHrECk82ondVxdxQyYsh2GMetSpVW8 ow== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x97qn81mt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 13:27:38 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 433Ca2DC002184;
	Wed, 3 Apr 2024 13:27:22 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x6xjmnay9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 13:27:22 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 433DRKdC19923498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Apr 2024 13:27:22 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C571F58069;
	Wed,  3 Apr 2024 13:27:18 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B838E5805E;
	Wed,  3 Apr 2024 13:27:16 +0000 (GMT)
Received: from [9.109.198.231] (unknown [9.109.198.231])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Apr 2024 13:27:16 +0000 (GMT)
Message-ID: <4c990147-1ed8-4fb5-9f8f-dde537eab7b9@linux.ibm.com>
Date: Wed, 3 Apr 2024 18:57:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_nvme-cli_=E2=80=98nvme_connect=E2=80=99_--duplicate?=
 =?UTF-8?Q?-connect_flag_=28-D=29_is_not_supported_anymore?=
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>
Cc: "Engel, Amit" <Amit.Engel@dell.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "Cohen, Yonatan" <Yonatan.Cohen@dell.com>,
        Gregory Joyce <gjoyce@ibm.com>
References: <CO1PR19MB48850C446CA2FED70F7E5D69EE3D2@CO1PR19MB4885.namprd19.prod.outlook.com>
 <bce9276a-c1bf-4faa-8fab-bfc81724646e@linux.ibm.com>
 <endkd6bc5yooykdv4kkfb6uvijpkhlic6g7qut6yg5342cjo6j@cvmjm7hy6wk7>
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <endkd6bc5yooykdv4kkfb6uvijpkhlic6g7qut6yg5342cjo6j@cvmjm7hy6wk7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iSLGGdt3-kcCXH0dpj5dAKt1NY5BzReG
X-Proofpoint-GUID: iSLGGdt3-kcCXH0dpj5dAKt1NY5BzReG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_12,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=666 priorityscore=1501
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404030093
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240403_062743_437454_55026D48 
X-CRM114-Status: GOOD (  18.23  )
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



On 4/3/24 18:18, Daniel Wagner wrote:
> On Wed, Apr 03, 2024 at 06:07:29PM +0530, Nilay Shroff wrote:
>> I think this is a bug in nvme-cli.
> 
> Yes, regression from
> 
> 07d6b911e081 ("fabrics: Do not attempt to reconnect to already connected
> ctrls")
> 
>> If you want to use nvme-cli then you may try this patch:
>>
>> --- a/fabrics.c
>> +++ b/fabrics.c
>> @@ -999,7 +999,7 @@ int nvmf_connect(const char *desc, int argc, char **argv)
>>         };
>>  
>>         c = lookup_ctrl(h, &trcfg);
>> -       if (c && nvme_ctrl_get_name(c)) {
>> +       if (c && nvme_ctrl_get_name(c) && !cfg.duplicate_connect) {
>>                 fprintf(stderr, "already connected\n");
>>                 errno = EALREADY;
>>                 goto out_free;
>>
> 
> Care to send a proper patch?
> 
Sorry my bad. I will send a proper patch in next mail.

Thanks,
--Nilay

