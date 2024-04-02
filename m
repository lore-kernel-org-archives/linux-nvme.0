Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25DC8CD1284
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Apr 2024 13:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a+J33Vq7oicJy6ZN5iniFWHNWMzbyVjBzhRXhbMntAY=; b=Y9InfPwj0ApWDj+iNteNIgMSWm
	Bs0r1ct2Zt+4NNd1BtV7klmE+HYu8spqBHSoqU9OKflOw2G9bHyPS0MfB2eZaVC4ykxID0kZKrD5Q
	ZDwKU7C3aIaDrFNlPtOFCB1/G36rsDiQJyfWOAot4u/edsgcfN8K6evV4nAh58TQMBp+UsyLvB/x7
	Dj9AQC8vFFtpwel1vWNzn9AYxEQl5bJRk/M7kRfZwnL/gm0Qj9rmLqr29rJT1ADu9+cxekHvcwdmI
	flTyCwVOffJPlZsQovLbIY+MrMcObfgS+xP7a7P/eqx/GnLXW5pqiN+4C0JPUY2waCRpMQGNUoppM
	87SJ9+YQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rreFZ-0000000BNI4-2qzE;
	Tue, 02 Apr 2024 13:32:29 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rreFW-0000000BNH5-3DTN
	for linux-nvme@lists.infradead.org;
	Tue, 02 Apr 2024 13:32:27 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 432DKSOJ032522;
	Tue, 2 Apr 2024 13:32:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=a+J33Vq7oicJy6ZN5iniFWHNWMzbyVjBzhRXhbMntAY=;
 b=mYAcgtZrwA6Rc9UpO2guG0LVBxAr7o2Lds5yeR4wubRwekegQZQpk01BbNCbwME/TyMt
 lkEPmMPM9vz+Tv1fFTl8VPzJN7AB4guS/Ky7MRESUIhrPfH0RgK/9OtBU6x18OKTFEAb
 ZkE+739GCykJwjzOrNGgFhCTzKjSp8OVN45T0WERi4+DlYA4KLlrq2yaDeykzhhxjBjW
 g9iWF0FGbrG5KVO9ivOm6CyWK/+Tb5ypPNYAv6Zt2upOfOAP8jlLgoefWBt1iX1cq1Jx
 55GY9u0WOkbBJ5afK8FrsR45Ui6gMDeBUi04SFt5CvdyKNw9grUhogQxkqDL7xjq2yr8 3w== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x8gn48f18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 13:32:22 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 432CoveV029563;
	Tue, 2 Apr 2024 13:32:21 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x6ys2x7ja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 13:32:21 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 432DWIFZ25690646
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Apr 2024 13:32:21 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BAF4358059;
	Tue,  2 Apr 2024 13:32:18 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F369C58055;
	Tue,  2 Apr 2024 13:32:16 +0000 (GMT)
Received: from [9.109.198.231] (unknown [9.109.198.231])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Apr 2024 13:32:16 +0000 (GMT)
Message-ID: <67debc81-6d3e-4ce5-b79d-03398513e81e@linux.ibm.com>
Date: Tue, 2 Apr 2024 19:02:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tree: Add NVM subsystem controller identifier
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, dwagner@suse.de, gjoyce@ibm.com
References: <20240326065752.164286-1-nilay@linux.ibm.com>
 <7bfe1296-3bd6-4c5e-a1a7-5fdb5c346404@suse.de>
 <5c54f9eb-6a86-4240-bba8-eee8b72469c2@linux.ibm.com>
In-Reply-To: <5c54f9eb-6a86-4240-bba8-eee8b72469c2@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Kzl2Ypla-1Xl2ojEjfRDa4Ktqg-ozv-T
X-Proofpoint-ORIG-GUID: Kzl2Ypla-1Xl2ojEjfRDa4Ktqg-ozv-T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_06,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0 spamscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404020099
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240402_063226_871809_0702324C 
X-CRM114-Status: GOOD (  29.70  )
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



On 3/26/24 14:20, Nilay Shroff wrote:
> 
> 
> On 3/26/24 12:40, Hannes Reinecke wrote:
>> On 3/26/24 07:57, Nilay Shroff wrote:
>>> This commit introduces a field "cntlid" for controller,
>>> that contains the NVM subsystem unique identifier assigned
>>> to each controller device in an NVM subsystem.
>>>
>>> While attaching a namespace, typically user needs to specify the
>>> controller identifier (cntlid). The cntlid could be referenced from
>>> sysfs (/sys/class/nvme/nvmeX/cntlid) but it would be nice to have
>>> a direct option.
>>>  > Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>

>>
>> Errm. How would that work? /dev/nvme0 _is_ a controller, and as such will have an assigned cntlid. And if one would issue an 'attach-ns'
>> command the only controller which it could address is that controller
>> to which the command is issued.
>> I'd be _very_ surprised if you could issue 'attach-ns' against _another_
>> controller. So why do we need this option?
>> Shouldn't we rather infer the cntlid from the existing controller?
>>
> Yes it's possible to attach a namespace against the cntlid which could be different from 
> the nvmeX device we use while attaching the namespace. Moreover, if we want to create a shared 
> namespace then we need to specify all controller identifiers which would share that namespace.
> 
> For reference, I would show the example output below:
> 
> Example 1: Create a shared namespace and attach to multiple controllers:
> ------------------------------------------------------------------------
> 
> # nvme list -v 
> Subsystem        Subsystem-NQN                                                                                    Controllers
> ---------------- ------------------------------------------------------------------------------------------------ ----------------
> nvme-subsys1     nqn.1994-11.com.samsung:nvme:PM1735a:2.5-inch:S6RTNE0R900057                                     nvme1, nvme3
> [...]
> 
> As we could see above I have two controllers (nvme1 and nvme3) under NVM subsys1. 
> Lets find cntlid of each controller.
> 
> # cat /sys/class/nvme/nvme1/cntlid 
> 66 
> # cat /sys/class/nvme/nvme3/cntlid 
> 65
> 
> Now create a shared namespace and attach it against the above controllers:
> 
> # nvme create-ns /dev/nvme1 --nsze=0x156d56 --ncap=0x156d56  --block-size=4096 -m 1 
> create-ns: Success, created nsid:1
> 
> # nvme attach-ns /dev/nvme1 -n 0x1 -c 65,66 
> attach-ns: Success, nsid:1
> 
> # nvme list -v
> [...]
> 
> Device       Generic      NSID       Usage                      Format           Controllers     
> ------------ ------------ ---------- -------------------------- ---------------- ----------------
> /dev/nvme1n1 /dev/ng1n1   0x1          5.75  GB /   5.75  GB      4 KiB +  0 B   nvme1, nvme3
> 
> 
> As we could see above for creating shared namespace we need to know the cntlid of both 
> nvme1 and nvme3 controllers.
> 
> Example 2: Create a private namespace and attach to a controller other than the one specified in nvmeX
> ------------------------------------------------------------------------------------------------------
> 
> # nvme create-ns /dev/nvme1 --nsze=0x156d56 --ncap=0x156d56  --block-size=4096
> create-ns: Success, created nsid:2
> 
> # nvme attach-ns /dev/nvme1 -n 2 -c 65
> attach-ns: Success, nsid:2
> 
> Please note above that I attached the namespace against controller nvme3 (the cntlid 65 is assigned to nvme3)
> 
> # nvme list -v
> [...]
> 
> Device       Generic      NSID       Usage                      Format           Controllers     
> ------------ ------------ ---------- -------------------------- ---------------- ----------------
> /dev/nvme1n1 /dev/ng1n1   0x1          5.75  GB /   5.75  GB      4 KiB +  0 B   nvme1, nvme3
> /dev/nvme1n2 /dev/ng1n2   0x2          5.75  GB /   5.75  GB      4 KiB +  0 B   nvme3
> 

If there's no other objection to the above change then can we accept the patch?

Thanks,
--Nilay

 

