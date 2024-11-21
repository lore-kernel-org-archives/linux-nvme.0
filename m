Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC5F1D6ED04
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Nov 2024 11:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SgV3krh1/K41wlTlwxxWUhVbH1zCGgFhTbiYKQWdxCA=; b=GR5BdN9EREhTHbVB+JEFcCIpR2
	OuLOEYdQxEnxvjdVIqTvCPQ7LlN0DGSp+mAPGaqf3RPJz+xddbnqwGINw/g4gAcqvIHEQ6mBEaLlF
	URako1aOxQDjGhntWmwprKQ+48wcRuh11n869FqJvI30UCzqNQjBpMvgONg7ejbs49+kl3P6/T6AD
	yq+z9wUscwzIXfF3BCw7o07eZpTomUw/2saLZF325Fi7dVrJcT4e8oEo6VOZX1QTzPdWVULruqqpI
	yFLaTD6wdjuQReKZj3MHaZG4/AhRpOAn/WwzqjA0Ob2Q1Lj8uPeYUwl4fmgTdAb1+TFthxRaK6kn0
	SPPgUrEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tE55F-0000000HQo3-1jyx;
	Thu, 21 Nov 2024 11:10:49 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tE55C-0000000HQnb-1KRc
	for linux-nvme@lists.infradead.org;
	Thu, 21 Nov 2024 11:10:47 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALA9cl9013500;
	Thu, 21 Nov 2024 11:10:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SgV3kr
	h1/K41wlTlwxxWUhVbH1zCGgFhTbiYKQWdxCA=; b=dPbVCiiv6NUfjxNbc0pzSj
	jFGxHui6keynqEWCIFZe0hcVmCfdV7WaHXIIFoJqDD7sxDxG8IhH8z0qYeUqnSeB
	b779tokOlU5IwtDBLxM+7SdMEQm2/Uv1XsUHwP78oKGiGW4YusU81F6FMNLoNuAO
	EdPdmapaaeEgqXu5P/T0Vr7dlOkRuVvfE+on+p1KE19Ah8qUBUPY43Xs6VY7JYwG
	LSc4Cyju2+Bxi0HvNyF6TNzTlza/CiuuIufxBTfUfP88SzxURL/2yxaHdr9rw4Qc
	6N2vPHJMJmN3LFDS4x+xAqCY2zyQfaCJ2vWGh6qgUSl0GkyAFmqJAMbjsf15PQog
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xk21a2qj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 11:10:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL7PqOw025906;
	Thu, 21 Nov 2024 11:10:34 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42y8e1gfmk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 11:10:34 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4ALBAXB552822484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 11:10:33 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 60E3058052;
	Thu, 21 Nov 2024 11:10:33 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B10EB58056;
	Thu, 21 Nov 2024 11:10:31 +0000 (GMT)
Received: from [9.171.4.248] (unknown [9.171.4.248])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 Nov 2024 11:10:31 +0000 (GMT)
Message-ID: <9ea5ac64-283c-40e6-a70d-285b81c55c06@linux.ibm.com>
Date: Thu, 21 Nov 2024 16:40:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report][regression] blktests nvme/029 failed on latest
 linux-block/for-next
To: Yi Zhang <yi.zhang@redhat.com>
Cc: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <CAHj4cs8OVyxmn4XTvA=y4uQ3qWpdw-x3M3FSUYr-KpE-nhaFEA@mail.gmail.com>
 <7f35cbe9-9e12-498b-b46a-be1f570772fc@linux.ibm.com>
 <CAHj4cs91daKS2Sexvs3y_m=r=+a+gJdk9=Z+76TdsE6=0nNcYg@mail.gmail.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <CAHj4cs91daKS2Sexvs3y_m=r=+a+gJdk9=Z+76TdsE6=0nNcYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yciA4e5_tKqpHbS9qaUhfTt9tmXkahLh
X-Proofpoint-GUID: yciA4e5_tKqpHbS9qaUhfTt9tmXkahLh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1015 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411210086
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241121_031046_478334_95947652 
X-CRM114-Status: GOOD (  21.70  )
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



On 11/21/24 08:28, Yi Zhang wrote:
> On Wed, Nov 20, 2024 at 10:07 PM Nilay Shroff <nilay@linux.ibm.com> wrote:
>>
>>
>>
>> On 11/19/24 16:34, Yi Zhang wrote:
>>> Hello
>>>
>>> CKI recently reported the blktests nvme/029 failed[1] on the
>>> linux-block/for-next, and bisect shows it was introduced from [2],
>>> please help check it and let me know if you need any info/test for it, thanks.
>>>
>>> [1]
>>> nvme/029 (tr=loop) (test userspace IO via nvme-cli read/write
>>> interface) [failed]
>>>     runtime    ...  1.568s
>>>     --- tests/nvme/029.out 2024-11-19 08:13:41.379272231 +0000
>>>     +++ /root/blktests/results/nodev_tr_loop/nvme/029.out.bad
>>> 2024-11-19 10:55:13.615939542 +0000
>>>     @@ -1,2 +1,8 @@
>>>      Running nvme/029
>>>     +FAIL
>>>     +FAIL
>>>     +FAIL
>>>     +FAIL
>>>     +FAIL
>>>     +FAIL
>>>     ...
>>>     (Run 'diff -u tests/nvme/029.out
>>> /root/blktests/results/nodev_tr_loop/nvme/029.out.bad' to see the
>>> entire diff)
>>> [2]
>>> 64a51080eaba (HEAD) nvmet: implement id ns for nvm command set
>>>
>>>
>>> --
>>> Best Regards,
>>>   Yi Zhang
>>>
>>>
>> I couldn't reproduce it even after running nvme/029 in a loop
>> for multiple times. Are you following any specific steps to
>> recreate it?
> 
> From the reproduced data[1], seems it only reproduced on x86_64 and
> aarch64, and from the 029.full[2], we can see the failure comes from
> the "nvme write" cmd.
> [1]
> https://datawarehouse.cki-project.org/issue/3263
> [2]
> # cat results/nodev_tr_loop/nvme/029.full
> Reference tag larger than allowed by PIF
> NQN:blktests-subsystem-1 disconnected 1 controller(s)
> disconnected 1 controller(s)
> 
> I also attached the kernel config file in case you want to try it, thanks.
> 
Thanks for the additional information!
Now I could understand the issue and have a probable fix. If possible, can you try 
the below patch and check if it help resolve this issue?

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 934b401fbc2f..7a8256ae3085 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -901,12 +901,14 @@ static void nvmet_execute_identify_ctrl_nvm(struct nvmet_req *req)
 static void nvme_execute_identify_ns_nvm(struct nvmet_req *req)
 {
        u16 status;
+       void *zero_buf;
 
        status = nvmet_req_find_ns(req);
        if (status)
                goto out;
 
-       status = nvmet_copy_to_sgl(req, 0, ZERO_PAGE(0),
+       zero_buf = __va(page_to_pfn(ZERO_PAGE(0)) << PAGE_SHIFT);
+       status = nvmet_copy_to_sgl(req, 0, zero_buf,
                                   NVME_IDENTIFY_DATA_SIZE);
 out:
        nvmet_req_complete(req, status);

Thanks,
--Nilay

