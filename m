Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D5AAD13570
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2024 04:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7LlfeZ4TkZRvvQ5YD0F7oeoEFU7h1k+qsLa8VBGelX4=; b=mpCQ8Y93qJfJfNms1AeQK1OVTI
	+uErf1ilo7j6SfUZewxE8oMLlJgoMtb0SmKE9mxtzXaBkU6wcy1UClPa+PUnd69oTtfgfYmQpj8Sh
	MXrEQLT3noFL0m/+DVC1GbWCjjMr7VKa4BcALXGPZHq56Akvc3A+oZacsjfwIB/KjqGVfpIW0YfU4
	5VgAj4wPR4JX28HwbQ/+dPSACLTPJQoqkLxwpr5v5cyBZ+X8uRP71hYSI5D7vKlMqlFpOVfN7dmE2
	7HGjEKxikf/o9OjcxXHPGfU4e++B6KGv5l+btTbyXymRUQtHdvYBJUS/bQLCKtt5+2PM+w/riFrOS
	doDg7rDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5HbS-00000009XIb-2yZs;
	Mon, 28 Oct 2024 04:43:42 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5HbP-00000009XHo-21uN
	for linux-nvme@lists.infradead.org;
	Mon, 28 Oct 2024 04:43:41 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49RLrsER021651;
	Mon, 28 Oct 2024 04:43:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7LlfeZ
	4TkZRvvQ5YD0F7oeoEFU7h1k+qsLa8VBGelX4=; b=bvfoOuB1D33eMLoOQc5d6j
	qJIdOiaXF+zWUdDZn4uQhcHRIUsOxGCkyJ6ZCqT4SC/sdceg4UxS63k9e2lRJKxS
	nrSAycx3o+IF/QfhFpTqBdQ+jJurUgQOIYr6ddCJXL+jzZXT1MVgHKQKBkzflSdI
	N0HEBOADuwIvVb+tKvcjHFC8KatKFhLpVb7A4og6RQPBWKTrwhN+latCBCvXVz2E
	+VNsNsyn45S9d7D7WHJZaNS/St4e2xGDkjOepooprhZj88ahoxHgIFGSZoREIu4I
	LFnWGI3xtf5Aj6CujJ9+p6VxtSLd6n+592rQqPvAXOAioOzfc/EOHEJNQqDmA6VQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42grway6ej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Oct 2024 04:43:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49S3BUFG013670;
	Mon, 28 Oct 2024 04:43:30 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42hbrmmkh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Oct 2024 04:43:30 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49S4hTmM46661948
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 04:43:29 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BCF75804E;
	Mon, 28 Oct 2024 04:43:29 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A52065803F;
	Mon, 28 Oct 2024 04:43:26 +0000 (GMT)
Received: from [9.171.1.253] (unknown [9.171.1.253])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Oct 2024 04:43:26 +0000 (GMT)
Message-ID: <15db6283-726c-495f-b7d7-eb368559b0ee@linux.ibm.com>
Date: Mon, 28 Oct 2024 10:13:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme: use helper nvme_ctrl_state in
 nvme_keep_alive_end_io function
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, axboe@fb.com, chaitanyak@nvidia.com,
        dlemoal@kernel.org, gjoyce@linux.ibm.com
References: <20241027170209.440776-1-nilay@linux.ibm.com>
 <20241027170209.440776-4-nilay@linux.ibm.com>
 <2c77692c-5a67-4a79-a483-350ba02c8fec@grimberg.me>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <2c77692c-5a67-4a79-a483-350ba02c8fec@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: okJATfBiUU7patlTrnnBDwaL9YK3r2Up
X-Proofpoint-ORIG-GUID: okJATfBiUU7patlTrnnBDwaL9YK3r2Up
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 phishscore=0 mlxlogscore=565
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410280037
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241027_214339_773573_07F75212 
X-CRM114-Status: GOOD (  13.91  )
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



On 10/28/24 03:37, Sagi Grimberg wrote:
> 
> 
> 
> On 27/10/2024 19:02, Nilay Shroff wrote:
>> We no more need acquiring ctrl->lock before accessing the
>> NVMe controller state and instead we can now use the helper
>> nvme_ctrl_state. So replace the use of ctrl->lock from
>> nvme_keep_alive_end_io function with nvme_ctrl_state call.
> 
> The patch description is not clear. Why do we "no longer need"
> to take the ctrl->lock? What exactly changed for this?
> 
The update of ctrl->state is now done using WRITE_ONCE(). So it 
makes sense to pair the read of ctrl->state using READ_ONCE(). And
the helper nvme_ctrl_state(), in fact, reads the ctrl->state
using READ_ONCE(). So, if we use the nvme_ctrl_state() for 
retrieving ctrl->state value then we don't need locking. 

I think I would better format the commit message of this patch
to describe the above intent.

Thanks,
--Nilay 

