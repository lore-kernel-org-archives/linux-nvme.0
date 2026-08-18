Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42AFBC5DF7D
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2026 11:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7CYMEYAUtaaYWYsNGYIieqaAYOTR05OAHupk2LnubI=; b=yKHvalZZjCVR6lEQTU5Kok8h8z
	tRY/2dZK5gwBbby0tLZ8uSP8C0piH3NEOe0wMAX4lQSQDzbUQn+SndOtV5mnXJi/7tSlbJo46erUk
	7LhSE8QxkTg85P5ypox3InLAP8WFrLAchjTaWn3fOeBhuRwggDVnvE7JtxenSEN1VwD2NcrjYlnZr
	/ac2VrrL1wHPGT7oqHmHImNS/IELs5H5pEGhIVQ9etr713SEqukJMkjt9JnxFdr+GjDXH3tmUKBGr
	rZUwZmwhgUQKObIiN1r8JAq/huOewjk1JD6G2lBFrgiO0FjI/M/lvzAZHVLksBTs6/ghvVp866evc
	c6YNXYjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwIU0-00000007tGX-46QU;
	Tue, 18 Aug 2026 11:59:56 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwITy-00000007tFi-2LHW
	for linux-nvme@lists.infradead.org;
	Tue, 18 Aug 2026 11:59:55 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IAVXwJ4173507;
	Tue, 18 Aug 2026 11:59:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=M7CYME
	YAUtaaYWYsNGYIieqaAYOTR05OAHupk2LnubI=; b=pZ8BtxoCfwi4/ZNeijDt5A
	TJmbV0Rh2TuI1tJo7/vKbmd5X6qCvwtMAaEPhA/Z53uaJ+MUb5WbkT6OjSFOuy5c
	qmQjYCEesk5XByQXO8TDvaZFatPx98Yoog9LrdeY+g8Y0P55BLyJ8mKjT6aCVdmT
	JTX6EgOjeTzhOD02mPYwgMYuK6xtkQ7gpwx2dF8YXQmZpHJk7iX34FB+2YygIvHL
	zUZ9VRgeK7+BYWpOTCtOarYQ5vMpRQDp2S7nKXVdeX2lk3d3HsTlVWONfiTB1ZEp
	SNbx/9lvlugdyDmQ1tlued5bMO6YKg20yczSVFNXajq3vMhQS+FZwnwLIFtZv9DA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fm3qy67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 11:59:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IBuL2e013640;
	Tue, 18 Aug 2026 11:59:39 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32tw357k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 11:59:39 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IBxd9k41026240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 11:59:39 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2AE2C58059;
	Tue, 18 Aug 2026 11:59:39 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5251D58058;
	Tue, 18 Aug 2026 11:59:33 +0000 (GMT)
Received: from [9.61.24.21] (unknown [9.61.24.21])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 11:59:32 +0000 (GMT)
Message-ID: <ebfdc6e5-36ef-43ee-bd19-53b40e4682a2@linux.ibm.com>
Date: Tue, 18 Aug 2026 17:29:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 03/10] block: support nesting for blk-mq flag
 QUEUE_FLAG_SAME_FORCE
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, dwagner@suse.de,
        kanie@linux.alibaba.com, jmeneghi@redhat.com, randyj@purestorage.com,
        martin.petersen@oracle.com, john.g.garry@oracle.com,
        gjoyce@linux.ibm.com
References: <20260815173502.1185929-1-nilay@linux.ibm.com>
 <20260815173502.1185929-4-nilay@linux.ibm.com>
 <d11d3377-a4b3-45dc-b812-9dd06c8a2a38@suse.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <d11d3377-a4b3-45dc-b812-9dd06c8a2a38@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: mJ0pFx7PZuGRyOwi0AMpoH0u_GvIwYMC
X-Proofpoint-ORIG-GUID: aCdsOEsnWemEpkPvizlTUggw-xsD_Cjv
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA4NSBTYWx0ZWRfX0lCux8YXIc2g
 FnI8pA3Q2lB0dCfrTHJyyPX/5O4Zqu9QjW9IqgTMC6O/04ELlazytAE5NCFb9g0syLSisy7Qjtn
 nlejwHL0iAER8wjAJRcEX06qnAMx+ys=
X-Authority-Analysis: v=2.4 cv=WtQb99fv c=1 sm=1 tr=0 ts=6a84492d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=x2F-CqR5pgbWWvvpmiwA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA4NSBTYWx0ZWRfX3DV28FlH7Xwt
 58cbjwnFHYngpgBNldOWo+MeH42Jt0SMJR2RdqJcbLMBP+H45etXrDIiTj9+bit9c/I+v+cqQcG
 VLnBZgyQVWaDYFOf6Ey2nISIjMshKNbFjdZQbQMOgKCA4OIqatDDUTGn9habmmgXhiYVh9FmOeE
 DBMooL0VRlf7MDbDdvWPT1KN6Suwt7cVyM/H5EFjz2a19UkxqNxJF605/w0YJeti6oNFqXwIv+l
 XrSDejOjUYqTum59Z/6AE3z4NaMLRb9mWHeLdUpoK4pCtKMKoY+uTu6E9THbElD7W0Nx4qLcof8
 nkfotT/epZRHlg8nY+vMcuekb7J4r7BIt8xRjgTK/DIXTnVTtIXWVQEcCVg2c/BpFV6iJHPPY8P
 NB7IPMMShF9W3NVoqBVMHBBTTM+r+SIjC+Mxc3vZlLZh0omcw7WCCJk7ivCDgcLi8kjTRcVgqgk
 OdvcP7VR61xtZkU+EHQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180085
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260818_045954_610854_86733160 
X-CRM114-Status: GOOD (  20.91  )
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

On 8/18/26 3:28 PM, Hannes Reinecke wrote:
> On 8/15/26 7:34 PM, Nilay Shroff wrote:
>> QUEUE_FLAG_SAME_FORCE is currently used when setting rq_affinity
>> through sysfs as well as by UFS mediatek driver while configuring scsi
>> parameters. A subsequent patch adding a latency-based I/O policy
>> for NVMe multipath will also use this flag.
>>
>> With multiple users able to set and clear QUEUE_FLAG_SAME_FORCE, the
>> flag needs to support nesting so that one user clearing the flag does
>> not inadvertently disable it for another user.
>>
>> Add a nesting counter, q->same_force_depth, for QUEUE_FLAG_SAME_FORCE.
>> The flag is set when the first user acquires it and the nesting counter
>> is incremented for each subsequent user. Similarly, each user releases
>> its reference by decrementing the counter. The flag is cleared only
>> when the last user releases it and the counter reaches zero.
>>
>> Preserve the existing sysfs rq_affinity semantics with a new
>> q->same_force_sysfs flag. When userspace enables QUEUE_FLAG_SAME_FORCE
>> by writing 2 to rq_affinity, mark q->same_force_sysfs as set and
>> increment q->same_force_depth by one. Subsequent writes of 2 to
>> rq_affinity while q->same_force_sysfs is already set are ignored, so
>> repeated writes of 2 from userspace do not increase q->same_force_depth.
>> Similarly, writing 0 or 1 decrements the q->same_force_depth and if
>> nesting counter reached to 0 then clears the QUEUE_FLAG_SAME_FORCE.
>> This ensures that multiple writes of 2 to rq_affinity do not require
>> multiple writes of 0 or 1.
>>
>> This change ensures that sysfs interface retains its existing set/clear
>> semantics while also allowing other kernel users to hold or release
>> QUEUE_FLAG_SAME_FORCE.
>>
>> Added two new APIs blk_mq_same_force_set() and blk_mq_same_force_clear()
>> to set and clear QUEUE_FLAG_SAME_FORCE respectively. Also, updated
>> existing call paths using these new APIs which toggles
>> QUEUE_FLAG_SAME_FORCE.
>>
> Yikes. Is this really necessary?
> The flag can be set by different subsystems/drivers, sure, but from
> what I've seen each user is mutually exclusive.
> I'd rather disallow modifying this flag if the driver sets it, to
> avoid upper layers or sysfs modifying it.
> 

If we want to disallow userspace from modifying QUEUE_FLAG_SAME_FORCE
while a driver owns it, then a userspace write to rq_affinity would have
to either fail (e.g. with -EINVAL) or be silently ignored. In either case,
that changes the existing userspace/sysfs semantics and may break userspace
that expects the write to succeed.

Or are you suggesting that a write to rq_affinity to enable QUEUE_FLAG_SAME_FORCE
should succeed when the driver has already set it? If so, what should happen when
the driver subsequently releases QUEUE_FLAG_SAME_FORCE? In that case, we would
clear QUEUE_FLAG_SAME_FORCE when the driver releases it, even though userspace may
have previously written 2 to rq_affinity. That would effectively reset the state
requested by userspace without informing userspace.

This seems to require keeping track of the userspace request separately from
the driver's ownership of the flag, which is one of the reasons I introduced
same_force_sysfs along with the nesting counter.

Thanks,
--Nilay


