Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2611E81BA6
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Feb 2026 11:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mOOYK3/Jlsquli3Jowz6rlbh4BPb8x5Bt2SgmnbSDsw=; b=FpOIP9cxnv5Nx5rjY+tu9Rk/Ix
	HhGg+q4v5CHrQPfQQHjJk7gw4p6ELRgyrEmrm4JsYE+CzEPTOwr9sWhhngbOX9hQZTseWanw5mlsr
	GyTdOFUBGRpOTGQFgVz1YU1mPGInc/3oFjjCaDJaUfBfPPTJVPR2g2Ot2qTsXy2FUvLJVI0si9up5
	n30pHzQ2SLEfIJy2su4+7GgXwSgGo4QD6ADJrghLM1zGSMDpVECzwuAa5IbN0RzO2ufVM6xHBR247
	avBxJ/mrePTRWHaqiBZGzwUSgYbjhD87mANF2dIMsdRN6C0QgO6JoSEbifzLBCIC+qkdFVEluATSQ
	2UrSEGsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpPku-0000000FK9J-2XCd;
	Mon, 09 Feb 2026 11:48:40 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpPkr-0000000FK8U-3mSR
	for linux-nvme@lists.infradead.org;
	Mon, 09 Feb 2026 11:48:39 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 618LFNXq213941;
	Mon, 9 Feb 2026 11:48:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mOOYK3
	/Jlsquli3Jowz6rlbh4BPb8x5Bt2SgmnbSDsw=; b=kTpxvTqQi3wXoONt8w9HO6
	hEai+XelmwrLNqg1/Lfip60h0hnO8rZjCxHdD7hCRsAEueFEf3MfKv8Iq9/c16df
	Iw8OIUCoIdUUv98XHV/nCPlHYHX5zvPP/7OLHUs+7KFZA0iu3fqUNYVFOE+VO5jT
	DMkW/fz9Dq35+3Ogq5jJNeLgvRZ7QZZfKvZjMNr9gtPkLHu8l22Dj/SrCy31/+0Y
	UdHpKKlYL0aTL+0V/rkheiMjVDsisE7ixXKofbgh4srVpKecoa8Fx9zCKS3UBy1z
	w8RS/nUFT0oIcwar90aSTG/SfRBjeFjXUNUrWBezbQRiEkWafVrx0QRsyUO4lotw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696vxuu2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Feb 2026 11:48:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6198SYj0001408;
	Mon, 9 Feb 2026 11:48:17 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c6gqmvy64-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Feb 2026 11:48:17 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 619BmGjt37749306
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Feb 2026 11:48:16 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7137358054;
	Mon,  9 Feb 2026 11:48:16 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F08735803F;
	Mon,  9 Feb 2026 11:48:10 +0000 (GMT)
Received: from [9.111.86.70] (unknown [9.111.86.70])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Feb 2026 11:48:10 +0000 (GMT)
Message-ID: <d3093117-cf18-4e7c-81fd-f6a71d4df0a7@linux.ibm.com>
Date: Mon, 9 Feb 2026 17:18:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/7] nvme: export command retry count via sysfs
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, hare@suse.de,
        dwagner@suse.de, wenxiong@linux.ibm.com, gjoyce@ibm.com
References: <20260205124810.682559-1-nilay@linux.ibm.com>
 <20260205124810.682559-2-nilay@linux.ibm.com>
 <172079af-d1c6-4f27-8fff-43ff2c7043c9@grimberg.me>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <172079af-d1c6-4f27-8fff-43ff2c7043c9@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=YeCwJgRf c=1 sm=1 tr=0 ts=6989c982 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=BXse_ZEqkTj4_V1LyucA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: IybaqZTs7rJC2KC6G0BmORHzw0E8ZV3u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDA5OSBTYWx0ZWRfX/5bisUFqrDgi
 raVI1uc6djgk/RtuvY/C/sodAFgjVrnSAwzpm9+vgYa4MvFVNVWS9V8zOC/NXTxPhpvrmtCK5oF
 lZ1mR7DXr88Xmr6DQQrlj/pipj+tsFTWavPvE/lHW+BLJ8g3kJUSjPIg1VbBJxthcfz196jZSys
 0ZSaSuIDYfTJpyYej+KKT7HviJbAlNrFQpnae2LuIoOocr7PI6sexeD5uXd6IVHq4YptVwIjrtG
 Bfc1oqf4IjfG5v0kV5FthUthqFAYBx6jxPDYEbfvsdlkLAtbXWyOzVI2BsaqS1clD2vKjtqLibl
 7mhR+iJW60KY+mTKYHmAeZ/tkXcL+cTIMbLE9JLax0nJbZlBAGu7avTGhB55jzV6+E+7FHFi8fk
 hICR2Vf0uAC/2Y08FS8zA18GPpdkQc0MZThmB7NvgUBgCF0MwYckv2JFSHAuYmtRcX3L97M7ON/
 qc8bwTDpgkHZyOPkNyg==
X-Proofpoint-ORIG-GUID: IybaqZTs7rJC2KC6G0BmORHzw0E8ZV3u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602090099
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260209_034837_945749_3E087F40 
X-CRM114-Status: GOOD (  18.06  )
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



On 2/7/26 6:58 PM, Sagi Grimberg wrote:
> 
> 
> On 05/02/2026 14:48, Nilay Shroff wrote:
>> When Advanced Command Retry Enable (ACRE) is configured, a controller
>> may interrupt command execution and return a completion status
>> indicating command interrupted with the DNR bit cleared. In this case,
>> the driver retries the command based on the Command Retry Delay (CRD)
>> value provided in the completion status.
>>
>> Currently, these command retries are handled entirely within the NVMe
>> driver and are not visible to userspace. As a result, there is no
>> observability into retry behavior, which can be a useful diagnostic
>> signal.
>>
>> Expose the command retries count through sysfs to provide visibility
>> into retry activity. This information can help identify controller-side
>> congestion under load and enables comparison across paths in multipath
>> setups (for example, detecting cases where one path experiences
>> significantly more retries than another under identical workloads).
>>
>> This exported metric is intended for diagnostics and monitoring tools
>> such as nvme-top, and does not change command retry behavior.
> 
> This is designed to show an accumulated value of how much retries were
> done on a namespace since boot? I'm wandering if this does not belong in
> debugfs?

Yes, that’s correct — the intent is to expose an accumulated count of command
retries for a namespace since boot.
While debugfs could be used for this type of diagnostic information, it would
not work well for the intended userspace consumption. The retry counter is
expected to be consumed by tools such as nvme-cli (and potentially nvme-top), 
so it needs to be available via sysfs. Relying on debugfs would make this
information unavailable on production systems where debugfs may not be enabled
or mounted. For that reason, exporting the metric through sysfs ensures it is
consistently accessible in production environments

Thanks,
--Nilay

