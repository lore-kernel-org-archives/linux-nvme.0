Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48FE1E7717D
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2024 09:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lQfC3PbjvDImXtrZcpALZIQ/Xb3Jqrkj2As+rdeo0qA=; b=QnTMTnkujnWpHkXobm1Cmye06M
	e3PF2JBOZMYgdXHrzVk6QContrnq+cBHDucAw5pL1iBM6k2rMynnQ2gwQEXuoyMSry/juoNdmlp0L
	m4kA4B9WOQ9Zl26FQH8bk45/DXNuBqlVNnUW2XOl/DKlxvtAxZyHnj9HhgAW+Mqkaj7yee96Zj4io
	ge6k8MOX+Q1oBKZ5bWWnKiGfQsFzWJ2tSB4DNA1f6hn24wWJ3F110uZLWNUCpOgZL2UXnN1kF8j+h
	WZyjFaZKNpZg0/T9/JkOINq7C12h4PlfQParbU7cheLuteEE2b/3mNfVoe+xBqSGRzLzlKgxym90P
	XRUzKjhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLJ2q-0000000EQU0-0x18;
	Wed, 11 Dec 2024 09:30:12 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLJ2o-0000000EQTR-1SFt
	for linux-nvme@lists.infradead.org;
	Wed, 11 Dec 2024 09:30:11 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB082s4008971;
	Wed, 11 Dec 2024 09:30:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=lQfC3P
	bjvDImXtrZcpALZIQ/Xb3Jqrkj2As+rdeo0qA=; b=lo4rnzUHd83YARhLJca9MB
	PdqtdDBMK3Yb3zmgMLkRSWm+9Jym38TYiNDvFw0hCeIIPFe61plflOVPh5TEPG7r
	Rgrz94SQXXS1seUsbSkIc4quff7/oRq/IPspiLLoQNcFRIqWD8CzFRnvl8Wy1ZqW
	plcygtaQmEZWVKCVnOdTHe1TEEmG1kSpa3yM+a4z+GliDu0cAuQspSvTHC5VWjiV
	pCrb4SazDljoCnqz9gptGjHybYhz8+V4PopwU3XQefl3Qp3TE1JujIVcWVIHaMRC
	XS+8cUpoqRLgoGLHG7fTTJdIyrj4stjCF3GG2k/fNpW68Am8ezlZFN+yHosJbEhw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ccsjk9an-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 09:30:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB6CUb9032589;
	Wed, 11 Dec 2024 09:30:00 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d1pn8m83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 09:30:00 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BB9TxBT51118406
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Dec 2024 09:30:00 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0DCF5805A;
	Wed, 11 Dec 2024 09:29:59 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C0415803F;
	Wed, 11 Dec 2024 09:29:57 +0000 (GMT)
Received: from [9.171.85.18] (unknown [9.171.85.18])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Dec 2024 09:29:56 +0000 (GMT)
Message-ID: <4b1cea16-675d-4167-9ccd-f5dd4ec7045a@linux.ibm.com>
Date: Wed, 11 Dec 2024 14:59:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv5 RFC 0/3] Add visibility for native NVMe multipath using
 sysfs
To: Daniel Wagner <dwagner@suse.de>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
        hch@lst.de, gjoyce@linux.ibm.com, "axboe@fb.com" <axboe@fb.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>
References: <20241030104156.747675-1-nilay@linux.ibm.com>
 <10f38d85-e9ac-46b0-9a3e-dcbae26b36d8@linux.ibm.com>
 <46e833ef-5536-4528-8a13-4b79f13e1acf@linux.ibm.com>
 <dd45a4d8-a6c6-4a9c-961d-4bdf251658c3@linux.ibm.com>
 <699ab169-daed-4c83-9ae9-65f6542ba9e6@flourine.local>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <699ab169-daed-4c83-9ae9-65f6542ba9e6@flourine.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xXO51uzeQBEpELK2NquaVfJvj37qg5jT
X-Proofpoint-ORIG-GUID: xXO51uzeQBEpELK2NquaVfJvj37qg5jT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=928
 mlxscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412110071
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241211_013010_528947_9EE8278A 
X-CRM114-Status: GOOD (  17.12  )
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



On 12/10/24 15:04, Daniel Wagner wrote:
> On Tue, Dec 10, 2024 at 12:33:45PM +0530, Nilay Shroff wrote:
>>>>> As we know, NVMe native multipath supports three different io policies
>>>>> (numa, round-robin and queue-depth) for selecting I/O path, however, we
>>>>> don't have any visibility about which path is being selected by multipath
>>>>> code for forwarding I/O. This RFC helps add that visibility by adding new
>>>>> sysfs attribute files named "numa_nodes" and "queue_depth" under each
>>>>> namespace block device path /sys/block/nvmeXcYnZ/. We also create a
>>>>> "multipath" sysfs directory under head disk node and then from this
>>>>> directory add a link to each namespace path device this head disk node
>>>>> points to.
>>>>>
>>>>> Please find below output generated with this proposed RFC patch applied on
>>>>> a system with two multi-controller PCIe NVMe disks attached to it. This
>>>>> system is also an NVMf-TCP host which is connected to an NVMf-TCP target
>>>>> over two NIC cards. This system has four numa nodes online when the below
>>>>> output was captured:
> 
> Looks good to me from libnvme's perspective. I just my question on the
> lifetime of the new link, but I might just miss the point.
> 
When a namepsace path device is removed, we also remove the corresponding 
link (if it exists) from the head disk node to the path device.Please refer
below function, from the first patch of the series, which is invoked from 
the nvme_ns_remove() for removing the sysfs link:

void nvme_mpath_remove_sysfs_link(struct nvme_ns *ns)
{
	struct device *target;
	struct kobject *kobj;

	if (!test_bit(NVME_NS_SYSFS_ATTR_LINK, &ns->flags))
		return;

	target = disk_to_dev(ns->disk);
	kobj = &disk_to_dev(ns->head->disk)->kobj;
	sysfs_remove_link_from_group(kobj, nvme_ns_mpath_attr_group.name,
			dev_name(target));
	clear_bit(NVME_NS_SYSFS_ATTR_LINK, &ns->flags);
}

Thanks,
--Nilay

