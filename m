Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9B8C6FD1F
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Apr 2024 13:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bp6hXtrWK2w+Y0Y5ZIajHV66zEk7Wlfs2ir30f7dwpA=; b=v09zgx3q2Q8+4b0QMzOJ63Y5/A
	nJuXwIidB+OUvLi3Ra9KZd/xlWdzmkkYVSx+4HDajJmm5rLH5zA0Oi3b7eoQ3PvNZiK1V23qF6Mh/
	TzVNCjDo3/OtZnhmSWiRIF1p1+ykBiwgF0mvGDCkSsQqf+d8Y7tApoxxJZDaS+Qf1D+kkCNK/Bzso
	Vc3crUexVCymvrV6AIazKYoy3tOA9jvn5y9hkTaaxWnkLWZ62yZo3qFP29sdill+YiT1F9atubpKL
	il7z8PMEY+8zPZMf9tZye9lTpo8yJDI3QtZRtKYv7ZskXsn7w1AyCrh18StlE4DBK5P/xMmZtjXuc
	g4JHMueA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rre4o-0000000BKt6-3WKK;
	Tue, 02 Apr 2024 13:21:22 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rre4k-0000000BKrP-107T
	for linux-nvme@lists.infradead.org;
	Tue, 02 Apr 2024 13:21:20 +0000
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 432CXc6r001547;
	Tue, 2 Apr 2024 13:21:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=bp6hXtrWK2w+Y0Y5ZIajHV66zEk7Wlfs2ir30f7dwpA=;
 b=ncD8lmzTvL4ym+qofNmv6NjEA/UIx+eUb9kQQy7MTUCPZVeuKjfEnvOzScLYxhn1Osrc
 5YPoMaxasW6Jxb2MiU13f6p7R/u9FsaWQcnBug2ZmVuwITwgCeA+i4wQ8hT2It5txZLC
 Apq/ZQDpn/MrWOu6kJygLHBPA7CjtPtsxS8updetP5y2VrTXnV/m8NfYRMDx3/24IE8E
 z55jMoqlzfmMk7M6Ccz9FSWC6RA2piFQaHAKFzCwbm68gSgpebVzFKcH8ZHBRghf5nJC
 kaEf9Jj+KbbvligbwfQ+zyys/Q9fYLyTm880iJqpelOdd/6irWKb5RkzEkIuFsVwI9ad 4w== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x8j4gr48e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 13:21:09 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 432BSEYm002181;
	Tue, 2 Apr 2024 13:21:08 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x6xjmefde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 13:21:08 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 432DL5ug19727098
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Apr 2024 13:21:07 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCA3658061;
	Tue,  2 Apr 2024 13:21:05 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 207BD58043;
	Tue,  2 Apr 2024 13:21:04 +0000 (GMT)
Received: from [9.109.198.231] (unknown [9.109.198.231])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Apr 2024 13:21:03 +0000 (GMT)
Message-ID: <128c950a-57e1-428a-baa1-67765860661b@linux.ibm.com>
Date: Tue, 2 Apr 2024 18:51:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-multipath: don't inherit LBA-related fields for the
 multipath node
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org
References: <20240321210819.1246749-1-hch@lst.de>
 <Zf2wRtNqNU2qTpHE@kbusch-mbp>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <Zf2wRtNqNU2qTpHE@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xRSzi9U72a80wFYxKreJrytArzNDUuyY
X-Proofpoint-ORIG-GUID: xRSzi9U72a80wFYxKreJrytArzNDUuyY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_06,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 bulkscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404020098
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240402_062118_555999_5D620331 
X-CRM114-Status: GOOD (  20.62  )
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

On 3/22/24 21:52, Keith Busch wrote:
> On Fri, Mar 22, 2024 at 07:08:19AM +1000, Christoph Hellwig wrote:
>> Linux 6.9 made the nvme multipath nodes not properly pick up changes when
>> the LBA size goes smaller after an nvme format.  This is because we now
>> try to inherit the queue settings for the multipath node entirely from
>> the individual paths.  That is the right thing to do for I/O size
>> limitations, which make up most of the queue limits, but it is wrong for
>> changes to the namespace configuration, where we do want to pick up the
>> new format, which will eventually show up on all paths once they are
>> re-queried.
>>
>> Fix this by not inheriting the block size and related fields and always
>> for updating them.
>>
>> Fixes: 8f03cfa117e0 ("nvme: don't use nvme_update_disk_info for the multipath disk")
> 
> Applied to nvme-6.9. This just missed yesterday's pull, but at least
> it's queued up for the next one.

I found this one couldn't made into 6.9-rc2. So are we planning to queue this fix
for the next rc?

Thanks,
--Nilay


