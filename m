Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3574CFA74F
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Oct 2024 07:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tAlxjbz8b45A7GVvDwyhc92wEuJPVoC4UbVXaIC8Q3k=; b=wVRpcVfPlLUipjkJKd4mjMWJYJ
	a3xulJRZDDT7J2GDzIhwQroUiJ6eO5YmhMhGs74TACSXbQDdEfeaj1XvcH+0YBc+y6iLkMnzJEwOA
	2cTre54fRvfyJfjvooP0FqkMTF2w9SNltdEu25PyrHTEzJ6Mnh8IkmgkH0scdT/AwxKSdKJmxcrfI
	/daERk+MU/y6VXNkOlDxKyT6n4246MeaL8pgiZpEkW3hikaBmYxswEumqyClJFqAdcYX5g3ifuCc8
	ZK52LRv1CjMmGZdTHFwqmo8jniyd1WPEAMWyJOSq+Beh1oq5end/n8rUuuZAcL1+IKMtV3XvHkqGt
	V7dWFucw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1swcej-0000000BDRR-2BzG;
	Fri, 04 Oct 2024 07:23:17 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1swceg-0000000BDR3-0JQJ
	for linux-nvme@lists.infradead.org;
	Fri, 04 Oct 2024 07:23:15 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4946uEPp009901;
	Fri, 4 Oct 2024 07:22:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=t
	Alxjbz8b45A7GVvDwyhc92wEuJPVoC4UbVXaIC8Q3k=; b=Iu6zF2+ELpP2VPU6n
	g9SfwrXBhcAkbiXbWGOAGmQF6uBMsmp/31ttB+Dh7fOzOdatv0/i4McSgLPqRUr2
	BwSMgWmNLW/BdwR6gC2lLFQXg+dGP5Ekg5tiBlbX3BDyaZ046hKlxo+Zy2Z5L/nX
	WOtCNKBbQjAQr39WCR4rod9XRxDxPzH4UusxYDGFF757hs0iUHqojXctMp09NkSp
	QbdzoNVhS2+eqH3xUOV7MgcQqKWts02ReBxoHCF1uFdhrm6WxbsHeMBu3I0utxkr
	KlW4HKHpahKg0yjURBIltaKQF7m4wn22fIpuex+xj7/TVASO+AmmvUaJ41KBFYYF
	NXfMg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 422bhb832s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Oct 2024 07:22:57 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4947MvV5028461;
	Fri, 4 Oct 2024 07:22:57 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 422bhb832n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Oct 2024 07:22:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49478Ffg017905;
	Fri, 4 Oct 2024 07:22:56 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42207japk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Oct 2024 07:22:56 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4947MtDP43647306
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Oct 2024 07:22:55 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F11C5805F;
	Fri,  4 Oct 2024 07:22:55 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA77F58043;
	Fri,  4 Oct 2024 07:22:51 +0000 (GMT)
Received: from [9.109.198.143] (unknown [9.109.198.143])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  4 Oct 2024 07:22:51 +0000 (GMT)
Message-ID: <884b5503-5aba-46b2-b926-6dec4993881b@linux.ibm.com>
Date: Fri, 4 Oct 2024 12:52:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nvme: retry security commands if media not ready
To: Christoph Hellwig <hch@lst.de>, Greg Joyce <gjoyce@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@fb.com,
        sagi@grimberg.me, hare@suse.de, dwagner@suse.de, msuchanek@suse.de,
        jonathan.derrick@linux.dev, okozina@redhat.com
References: <20240930164845.8406-1-gjoyce@linux.ibm.com>
 <20240930164845.8406-2-gjoyce@linux.ibm.com> <20241002081633.GA22436@lst.de>
 <dbfd87e4900bea3a28ac46f5abcfb39ef2c13fc1.camel@linux.ibm.com>
 <20241003124345.GA16754@lst.de>
 <3876a795bbaa8cef46ed0cb84f8eeccc5462f075.camel@linux.ibm.com>
 <20241003144106.GA24422@lst.de>
 <fd5ebec0dc273afd5d748a26c999254d3ed28f01.camel@linux.ibm.com>
 <20241004054123.GA14423@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20241004054123.GA14423@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: saQs-VgW_DsMY2UJupYcgCWtdXyw9saF
X-Proofpoint-GUID: 1fXTvx-KimXqn1gANb8w-Bf9yzSXJBXc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_06,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1011 malwarescore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410040051
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241004_002314_174928_5E3FFC40 
X-CRM114-Status: GOOD (  23.32  )
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



On 10/4/24 11:11, Christoph Hellwig wrote:
> On Thu, Oct 03, 2024 at 06:35:30PM -0500, Greg Joyce wrote:
>> I agree, I wonder about the value/wisdom of the CC.CRIME capability
>> especially since there is no way to read status that indicates that the
>> media is ready for the Figure 103 commands. But it is a defined feature
>> and setting it does cause CSTS.RDY to be asserted before the media is
>> ready.
>>
>> The Kioxia CM7 drive does set both CRWMS and CRIMS (CRMS=11b). And
>> these lines in the NVMe driver thus set CC.CRIME:
>>
>>         if (ctrl->cap & NVME_CAP_CRMS_CRWMS && ctrl->cap &            
>> NVME_CAP_CRMS_CRIMS)
>>                 ctrl->ctrl_config |= NVME_CC_CRIME;
>>
>> After reading more of the spec and driver code and discussions here, I
>> suggest that those two lines be removed. This has the effect of
>> returning to the NVMe version 1.4 behavior and CSTS.RDY will not be
>> asserted until the media is ready for commands.
> 
> Well, it is a useful feature unless random admin commands return
> not ready.  Which got weaseld into the spec, but really should not
> happen to make the feature useful.  So I think we'll need to put the
> workaround in instead of messing up the proper implementations of
> the feature that aren't this silly.  And make sure the big companies
> put that into their purchase specs.
> 

How about retrying the command, from nvme_retry_req(), if the return status
of the security (or for that matter any admin) command suggests to retry 
the request (i.e. DNR bit in the status is cleared to 0 and return status of 
the command is NVME_SC_ADMIN_COMMAND_MEDIA_NOT_READY)?  

Basically, nvme_retry_req() shall calculate the "delay" for retrying request.
We should first mark the timestamp the moment we enable the controller (i.e. 
time when CC.EN bit is set) and later nvme_retry_req() can use it to calculate 
the time remaining for media to be ready. And use this remaining time as "dealy"
for re-queuing the failed request.

Yes we also need to set the flag NVME_SUBMIT_RETRY while submitting request in
nvme_sec_submit() so that nvme_decide_disposition() allow retrying the request
if it fails.

Thanks,
--Nilay
  

