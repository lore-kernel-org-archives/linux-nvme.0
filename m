Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA907C4345F
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Apr 2024 13:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ABlDRtFjeAQT7l8XUGbwG8c/qMzUnQybKuhUUM+QhZI=; b=gHvgQfxk/WBM9FjzicRjxMDy0j
	VGewat2AX4SJz9PZzBYVzKvIY7Nx1eetF7oueeg8KY2ZqGrYXhLcfVhKVS0qzQB4mYjNAj2Hc3ZzY
	A1GimADnpQXAO36AYA+xLnr57fz5Z++8KpD+58n9kvVudBy52wXa0icM1PsXklhg3T9f8733XKMdu
	eT8ZmU6SOonTHmtJaJCQgLyYA4Bk85dmA+x2g1kRHE9kKTLaCtV0P8GOwwa7R9UTn2oKLjyuANoG8
	1JY5vL8C+3e/3YvNg1lsOk2H8ahW5Wej4XIHh1bSP0sCOcb4wEvyau3sRSf2mdQQK+wU8rgopWvIA
	R4Am5zCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzzUD-00000008btj-19zO;
	Thu, 25 Apr 2024 13:50:05 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzzU8-00000008bs3-2ehQ
	for linux-nvme@lists.infradead.org;
	Thu, 25 Apr 2024 13:50:02 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43PDgFqJ016790;
	Thu, 25 Apr 2024 13:49:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ABlDRtFjeAQT7l8XUGbwG8c/qMzUnQybKuhUUM+QhZI=;
 b=LXT0lKSag1Rr64UkMUTajoUjoBBCDVA0gUOTI+YSGRvCmjZvEVS9DhQIJvQgWpvuhdj/
 8TJZ6C8M1HT9kWRaD3GZsJc07IoO1umkiQxW0gybS3pULokG5dkwmuFLUoc28pbJ/07P
 tKzEGR7LdIPl4ir27BXq4gkCB179Ind9zFmmBIug00nTqrqdMVuh3PL/u+VltqZJo+Lw
 hBlhnKCWk44wjq5+x4b+BGt0aN0aoKnDm3NaV30pDSmD/cHOFy7R75BW75MIF3RKHkfL
 QgCUgSPcdh0DYDJaghAC3wCebsdKLGgpzs/3GHHDeF01wlh/zL9AYT6qTC8CgSrjHUaA QQ== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xqr9qg0m3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 13:49:50 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43PD401Z028763;
	Thu, 25 Apr 2024 13:49:49 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xmtr2sj10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 13:49:49 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43PDnkok61080010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 13:49:48 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BD7458052;
	Thu, 25 Apr 2024 13:49:46 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 284D95805A;
	Thu, 25 Apr 2024 13:49:44 +0000 (GMT)
Received: from [9.109.198.163] (unknown [9.109.198.163])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 25 Apr 2024 13:49:43 +0000 (GMT)
Message-ID: <43cf1234-5d86-402f-a690-95244cf920ff@linux.ibm.com>
Date: Thu, 25 Apr 2024 19:19:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug Report] PCIe errinject and hot-unplug causes nvme driver
 hang
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>, "axboe@fb.com" <axboe@fb.com>,
        Gregory Joyce <gjoyce@ibm.com>,
        Srimannarayana Murthy Maram <msmurthy@imap.linux.ibm.com>
References: <199be893-5dfa-41e5-b6f2-40ac90ebccc4@linux.ibm.com>
 <579c82da-52a7-4425-81d7-480c676b8cbb@grimberg.me>
 <d33a5681-b195-4258-8eee-e0eae46ade5b@linux.ibm.com>
 <627cdf69-ff60-4596-a7f3-0fdd0af0f601@grimberg.me>
 <ZiZrmSW6s7lY7j98@kbusch-mbp.dhcp.thefacebook.com>
 <ZiZ1mB0pE6lBrJkN@kbusch-mbp.dhcp.thefacebook.com>
 <2e10ca7f-0da8-47e4-9bfb-4a6cbf4abaec@linux.ibm.com>
 <ZilDAv9y3dSzTPKb@kbusch-mbp.dhcp.thefacebook.com>
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <ZilDAv9y3dSzTPKb@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: p9cA-Y0g6lJr8RrA_EdOZD_nJKJFI6Yl
X-Proofpoint-ORIG-GUID: p9cA-Y0g6lJr8RrA_EdOZD_nJKJFI6Yl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_13,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 mlxscore=0 clxscore=1015 impostorscore=0 spamscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404250100
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240425_065000_952207_D1FD3BBF 
X-CRM114-Status: GOOD (  24.21  )
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



On 4/24/24 23:06, Keith Busch wrote:
> On Tue, Apr 23, 2024 at 03:22:46PM +0530, Nilay Shroff wrote:

>> I understand that we don't want to cancel pending IO from the nvme_remove()
>> unconditionally as if the disk is not physically hot-unplug then we still 
>> want to  wait for the in-flight IO to be finished. Also looking through 
>> the above cases, I think that the nvme_timeout() might be the code path 
>> from where we want to cancel in-flight/pending IO if controller is 
>> in the terminal state (i.e. DELETING or DELETING_NOIO). Keeping this idea in
>> mind, I have worked out the below patch:
>>
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index 8e0bb9692685..e45a54d84649 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -1286,6 +1286,9 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
>>         u32 csts = readl(dev->bar + NVME_REG_CSTS);
>>         u8 opcode;
>>  
>> +       if (nvme_state_terminal(&dev->ctrl))
>> +               goto disable;
>> +
>>         /* If PCI error recovery process is happening, we cannot reset or
>>          * the recovery mechanism will surely fail.
>>          */
>> @@ -1390,8 +1393,13 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
>>         return BLK_EH_RESET_TIMER;
>>  
>>  disable:
>> -       if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING))
>> +       if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
>> +               if (nvme_state_terminal(&dev->ctrl)) {
>> +                       nvme_dev_disable(dev, false);
>> +                       nvme_sync_queues(&dev->ctrl);
>> +               }
>>                 return BLK_EH_DONE;
>> +       }
>>  
>>         nvme_dev_disable(dev, false);
>>         if (nvme_try_sched_reset(&dev->ctrl))
>>
>> I have tested the above patch against all possible cases. Please let me know
>> if this looks good or if there are any further comments.
> 
> This looks okay to me. Just a couple things:
> 
> Set nvme_dev_disable's "shutdown" parameter to "true" since we're
> restarting the queues again from this state.
> 
> Remove "nvme_sync_queues()". I think that would deadlock: sync_queues
> waits for the timeout work to complete, but your calling it within the
> timeout work, so this would have it wait for itself.
> 
Thank you for reviewing the patch! And yes I agree with your suggestions.
I will make those changes and send a formal patch in another email.

Thanks,
--Nilay

