Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F76BC52D7C
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Aug 2024 05:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rYWegBJAhK5ZvoZYtZ2pLr6P490Wm6p+KDF6+zKd5Fc=; b=sVtWl+u9A14rl6DAX+9q+mYzNR
	qOfu1FiPFsPOrGCnqqCRWBVW+nMSvtqdlLOqWHAvfCXIDw44EaObrrFqypw6DvQN/p6YZPCk/2jaj
	bQh+nFJftt5kGR5bc0mP4bgH5uedc7XSTTgZSx0QgAIOnL8GLJwGSyP+vKlOv9LMY/b0zqUn8YERP
	Azwo5v1bzUgBWNYNJGpLvqIhE4VxsbOhfts5DTrFhVLyX+hgLpGgk9Fj4V1LlFCB3hfcLYQFjUFBI
	1YfKSCuHrYE+sPKKJnjL+XqY8dmkz0A73J79EIIlJXNgqLPg4WVn7Ow4+u+0mAgf/VxRItLL20dlE
	nSwaCrtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgdoA-00000007Z0j-2sH8;
	Wed, 21 Aug 2024 05:22:58 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgdo7-00000007Z0C-2GZo
	for linux-nvme@lists.infradead.org;
	Wed, 21 Aug 2024 05:22:57 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47L5EhPS027065;
	Wed, 21 Aug 2024 05:22:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=r
	YWegBJAhK5ZvoZYtZ2pLr6P490Wm6p+KDF6+zKd5Fc=; b=cn5mqbiVX6COxrukM
	3eg0Zt9/okg//tq9icLncPwMSrwn96k0yJ7b3UdLyfjdqgP2r+YfUQcF17fd2aQ/
	PfWWWNoMhsBRXyYd8K/+Aa8ePuhcJTfvyMrFHiUWGcaLljU2t2mlojnQm3poLFeW
	ogAYs+kpa3Un659Hsw9fw62sRjt9TNW3dTt0VvHLUIVXoagCJvcoCFTY76osCQr9
	4ciZOvda2Tyo395esQd8eEuSf0l4OuY82DX9fHb8dLotW1rFeH+22B+D3FqsvMA9
	WoFbclMrmdIxzbh1NyZQMv0dzm/TrcmB8wN5WLIdp6TXjqYGjmd3PNI0G4+Gqylx
	KtGVw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4141y1sgk9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 05:22:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47L1bcbS017663;
	Wed, 21 Aug 2024 05:22:44 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4138w35w7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 05:22:44 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47L5Mgjt25625284
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 05:22:44 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B41B58059;
	Wed, 21 Aug 2024 05:22:42 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 84E1858058;
	Wed, 21 Aug 2024 05:22:39 +0000 (GMT)
Received: from [9.109.198.144] (unknown [9.109.198.144])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 21 Aug 2024 05:22:39 +0000 (GMT)
Message-ID: <5a49c4e2-81e9-4fc3-81c7-c8c3db6aee1f@linux.ibm.com>
Date: Wed, 21 Aug 2024 10:52:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/1] Add visibility for native NVMe multipath using
 sysfs
From: Nilay Shroff <nilay@linux.ibm.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, dwagner@suse.de, hch@lst.de,
        sagi@grimberg.me, axboe@fb.com, gjoyce@linux.ibm.com
References: <20240809173030.2281021-1-nilay@linux.ibm.com>
 <ZrZ9WKimhqSJXGnn@kbusch-mbp>
 <5e6da341-3e2f-415b-bbd6-2aea420bf057@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <5e6da341-3e2f-415b-bbd6-2aea420bf057@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 33ftwkfxKwYa2MQ_qL9E8SVG1l2yHjns
X-Proofpoint-ORIG-GUID: 33ftwkfxKwYa2MQ_qL9E8SVG1l2yHjns
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_05,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 suspectscore=0 spamscore=0 mlxlogscore=997 bulkscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408210034
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240820_222255_838137_CB335004 
X-CRM114-Status: GOOD (  26.50  )
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

Hi Keith,

>>
>>  /sys/block/nvme0n1/multipatch/nvme0c0n1/
>>  /sys/block/nvme0n1/multipatch/nvme0c3n1/
>>
>> And each directory has their attributes so they print exactly one value
>> instead of the multi-line output. You'd know which path the output
>> corresponds to from the file's directory.
>>
> Yes you were right, we need 1 value per file but I thought keeping 
> multipath details concisely in a single file may be then easier for 
> libnvme/nvme-cli to format and parse. 
> 
> I also read in the sysfs documentation, "attribute file should preferably 
> contain only one value per file. However, it is noted that it may not be 
> efficient to contain only one value per file, so it is socially acceptable
> to express an array of values of the same type." 
> 
> Anyways, I believe, most of us prefer 1 value per file rule for the sysfs 
> attributes, so how about exporting multipath details as shown below?
> 
> Let's assume namespace head node nvmeXnY points to two different paths: 
> nvmeXc1nY and nvmeXc3nY.
> 
> First we create the "multipath" directory under /sys/block/nvmeXnY 
> 
> The multipath directory would then contain two sub-directories (which are
> the two paths pointed by namespace head node)  named nvmeXc1nY and nvmeXc3nY. 
> In fact, these two sub-directories are actually soft link to the respective 
> namespace block device under /sys/block
> 
> For instance, we have a namespace head node nvme1n1 which points to two 
> different paths: nvme1c1n1 and nvme1c3n1.
> 
> # ls -l /sys/block/nvme1n1/multipath
> lrwxrwxrwx. 1 root root     0 Aug 11 12:30 nvme1c1n1 -> ../../../../../pci052e:78/052e:78:00.0/nvme/nvme1/nvme1c1n1
> lrwxrwxrwx. 1 root root     0 Aug 11 12:30 nvme1c3n1 -> ../../../../../pci058e:78/058e:78:00.0/nvme/nvme3/nvme1c3n1
> 
> # ls -l /sys/block/
> lrwxrwxrwx. 1 root root 0 Aug 11 12:30 nvme1c1n1 -> ../devices/pci052e:78/052e:78:00.0/nvme/nvme1/nvme1c1n1
> lrwxrwxrwx. 1 root root 0 Aug 11 12:30 nvme1c3n1 -> ../devices/pci058e:78/058e:78:00.0/nvme/nvme3/nvme1c3n1
> 
> As we see above, /sys/block/nvme1n1/multipath/nvme1c1n1 is soft link to 
> /sys/block/nvme1c1n1 and similarly /sys/block/nvme1n1/multipath/nvme1c3n1
> is soft link to /sys/block/nvme1c3n1. 
> 
> For round-robin I/O policy, we could easily infer from the above output 
> that I/O workload targeted to nvme1n1 would toggle across nvme1c1n1 and nvme1c3n1.
> 
> We also create two new sysfs attribute files named "numa_nodes" and "queue_depth" 
> under /sys/block/nvmeXcYnZ. 
> 
> # cat  /sys/block/nvme1n1/multipath/nvme1c1n1/numa_nodes 
> 0-1
> # cat  /sys/block/nvme1n1/multipath/nvme1c3n1/numa_nodes 
> 2-3
> 
> For I/O policy numa, above output signifies that I/O workload targeted to nvme1n1 and
> running on node 0 and 1 would prefer using path nvm1c1n1. Similarly, I/O workload 
> targeted to nvme1n1 and running on node 2 and 3 would prefer using path nvme1c3n1.
> 
> # cat /sys/block/nvme1n1/multipath/nvme1c1n1/queue_depth
> 423
> # cat /sys/block/nvme1n1/multipath/nvme1c3n1/queue_depth
> 425
> 
> For I/O policy queue-depth, above output signifies that for I/O workload targeted to nvme1n1, 
> we have got two paths nvme1c1n1 and nvme1c3n1 and the queue_depth for each path is 423 and 425 
> respectively.
>

A gentle ping about the above proposed solution.
 
As you proposed about 1 file 1 attribute value, I reworked the proposal and would like to know if
you have any further feedback/comment. If this looks good then shall I resend the RFC v3 with the 
above changes incorporated?
 
Thanks,
--Nilay

