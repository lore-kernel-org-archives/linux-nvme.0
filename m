Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90697C87FCB
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Aug 2025 05:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MaRfbbDwHf4RRXaVqnvPsAjtzOx4wvcjcFiJg8Cf2I8=; b=xXCMm2+OosEbQnbH8S6vBAO0M/
	zS1OnwxNW0uaL8vrKHldQI2hrkCQwQdxN+LKzpIXAHxvco3+MwxuV19u8rkNECHTkflrv+1fwem1i
	TsxcGlaMmIz/MtePU8ydvHgUK5X/289UMIg3xdw7hVhn2RBsZ+igf4YJEGilRlt8uptViDZ8f5BU9
	eaQmyoyvEb0WoHyL3kOS/5cDMLJ5/puzgIx0ACBumJySDGVbTBWpkXYVDYfOygIYe9aRCDrCHLHbG
	nGn3qm6LSHObwzV+SZhuWEDBKT6xIwyXr0HtfFS727zY2k/Ly9SQVixvBdZpTVyo4kOP+dTOnjyFO
	GkJo5j1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uj9oB-0000000Bn8s-2TKC;
	Tue, 05 Aug 2025 05:01:55 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uj9o7-0000000Bn7l-21Og
	for linux-nvme@lists.infradead.org;
	Tue, 05 Aug 2025 05:01:53 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5754tZXB032572;
	Tue, 5 Aug 2025 05:01:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MaRfbb
	DwHf4RRXaVqnvPsAjtzOx4wvcjcFiJg8Cf2I8=; b=PNZwoJYW7Eb5doRfxMmoez
	NrASbVKjbiNeBotBavglkspU4ZH/5LN+PoFETauTa+7zO5Oy6QlWguQMjNl9c85S
	uXVPGeTRZuegumg5uA9mdyCLHToSBjanYUEMEBhDJPOP8WBbc3APruuHp9g550LH
	vhklEyG77o5mnWsR34WVA4pBgyGLd7NZXZWS8apNrKG9hTrw9vA7N6XsYCY2MSiP
	sKVsmWHM6ZRHkw0xhl99fWuy5uNATKGVbG1epBk6steKOf/SDeMitL1mL9InSjDu
	pO+9viS6rQyvCsIV/T7ogsK0WczeqM7oTAnOWXQg9vEzQrLxCEzmq6I7GU+cPjTQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bbbq00k4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 05:01:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5754T3Pt006823;
	Tue, 5 Aug 2025 05:01:41 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 489xgmgv97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 05:01:40 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57551eNC25428602
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Aug 2025 05:01:40 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CD725805B;
	Tue,  5 Aug 2025 05:01:40 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E9E458058;
	Tue,  5 Aug 2025 05:01:37 +0000 (GMT)
Received: from [9.43.82.116] (unknown [9.43.82.116])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 Aug 2025 05:01:37 +0000 (GMT)
Message-ID: <22bc2185-04d0-4edb-848a-43e5bb99ed25@linux.ibm.com>
Date: Tue, 5 Aug 2025 10:31:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme: extend show-topology command to add support for
 multipath
From: Nilay Shroff <nilay@linux.ibm.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, hare@suse.de, kbusch@kernel.org,
        gjoyce@ibm.com
References: <20250704135001.292763-1-nilay@linux.ibm.com>
 <20250704135001.292763-3-nilay@linux.ibm.com>
 <91e8e0de-70a7-484d-af9f-f06645011ae6@flourine.local>
 <7fb98f70-cbf8-4ae2-bd72-cebf3d4c21f7@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <7fb98f70-cbf8-4ae2-bd72-cebf3d4c21f7@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pp0g04vbF1E2Q7a2iG-nUawUSgWLWHeQ
X-Authority-Analysis: v=2.4 cv=M65NKzws c=1 sm=1 tr=0 ts=68919035 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=2J7IuT7wAAAA:8 a=49_aLvU_3yUXNKGRcJoA:9
 a=QEXdDO2ut3YA:10 a=RtgRkGnnZwJf8nmJIBi8:22
X-Proofpoint-ORIG-GUID: pp0g04vbF1E2Q7a2iG-nUawUSgWLWHeQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDAzMyBTYWx0ZWRfX2zotCDP+ZLWZ
 a1Rh8MQvdCLNZdFpZLgt8Te2czxMALN3ftujw7RfT2UyVabifTKH3IVmT+eu8IhErFLnRwWihHh
 B39QfyYiYYf7P6Cq8jLoAVdHgURiUvFjCLa6xwmvUTVzlbiVAJC4mkh6wxcnTLVydrKgLD2EbKn
 Qkg9syaFSzD7NA7oHDxA5qrH9WktGlSfEJgmG7BxPQZ1HnwVu0WRfVNEPHWOO+bzHwbEQ+yBuGp
 658PVW31B7/bIAuB+osMKrwS5sUaYLqPC/4KAr4dPD5huIhBQmvmy8IoQfu7YtiS5sXJdspRH4E
 efIh1TjhZtlZXjdBH9HJo33QomtSS/F+YWqVY073IofYDFBI4LcST2enz4HUWooJ5mmsvsS3nZd
 qDEvjk1753smKcQZ66LZ7amgyoKO7D5fZ+hBzD7Tf9rJLJQ34Raum6fKfXdzDmqFDHY/oFeG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_01,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508050033
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250804_220151_820475_616FAC1C 
X-CRM114-Status: GOOD (  22.67  )
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

Hi Daniel,

A gentle ping about this patchset... Do you have any further recommendation as I suggested below?

Thanks,
--Nilay

On 7/10/25 7:16 PM, Nilay Shroff wrote:
> 
> 
> On 7/9/25 2:58 PM, Daniel Wagner wrote:
>> Hi Nilay,
>>
>> On Fri, Jul 04, 2025 at 07:19:54PM +0530, Nilay Shroff wrote:
>>> $ nvme show-topology -r multipath
>>>
>>> nvme-subsys2 - NQN=nvmet_subsystem
>>>                hostnqn=nqn.2014-08.org.nvmexpress:uuid:12b49f6e-0276-4746-b10c-56815b7e6dc2
>>>                iopolicy=numa
>>>
>>>           _ _ _<head-node>
>>>          /              _ _ _ <ana-state>
>>>         /              /      _ _ _ <numa-node-list>
>>>        /              /      /  _ _ _<queue-depth>
>>>       |              /      /  /
>>>  +- nvme2n1 (ns 1)  /      /  /
>>>  \                 |      |  |
>>>   +- nvme2c2n1 optimized 1,2 0 nvme2 tcp traddr=127.0.0.2,trsvcid=4460,src_addr=127.0.0.1 live
>>>   +- nvme2c3n1 optimized 3,4 0 nvme3 tcp traddr=127.0.0.3,trsvcid=4460,src_addr=127.0.0.1 live
>>>
>>> Please note that the headers shown above (e.g., <numa-node-list>,
>>> <ana-state>, <hed-node>, and <queue-depth>) are included for clarity
>>> only and are not part of the actual output.
>>
>> I do like the annotation what the numbers mean. Could you also add those
>> annotation to the output?
>>
> 
> Yes, I agree that the annotations explaining the numbers are helpful. 
> However, if there are multiple subsystems on a host, including such
> annotations inline might make the output look cluttered.
> 
> Instead, I propose using the following tabular format, which is more 
> readable and scalable. We can display this enhanced format only when
> the user specifies a --verbose option. Without the --verbose flag, we
> can continue using the current tree-style format.
> 
> Example verbose output:
> 
> $ nvme show-topology --verbose -r multipath
> 
> nvme-subsys2 - NQN=nvmet_subsystem
>                hostnqn=nqn.2014-08.org.nvmexpress:uuid:12b49f6e-0276-4746-b10c-56815b7e6dc2
>                iopolicy=numa
>                model=Linux
>                serial=d5dc1170f62100d47204
>                firmware=6.16.0-r
>                type=nvm
> 
> <head-node> <namespace>   <path>    <ana-state>  <numa-list>  <queue-depth>   <ctrl>  <state>  <transport>    <address>                  
>     |          |             |           |           |            |              |       |          |             |
> nvme2n1        1          nvme2c2n1   optimized     1,2           0            nvme2   live        tcp        traddr=127.0.0.2,trsvcid=4460,src_addr=127.0.0.1 
> nvme2n1        1          nvme2c3n1   optimized     3,4           0            nvme3   live        tcp        traddr=127.0.0.3,trsvcid=4460,src_addr=127.0.0.1
> 
> What do you think?
> 
> Thanks,
> --Nilay
> 


