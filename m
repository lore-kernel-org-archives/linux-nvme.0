Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4DB1E81BA4
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Feb 2026 12:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A+gfA25eMHfA0Ec15swNANM4+fiadJ3rCHe2DP6cRvg=; b=otan8VwfKUCZe7o9nrIdn5oOp8
	O2eeRR73MIbEt0Ohz25Nlvzzi9O9ZxDKdy8aGWUwFuNeVNMY951YAfcz44yxUEhh+l2aGejEbFbuk
	eoSZVgrnorxd4l167bIHgpCQF6pa4z6A5mSCE94d69IefXCkEjpM2hWz8h04gPbmYIR6Kg4YCNmr9
	+s7UfOouYzE54/qd7szLjZw7vdEDdzw79s2XLKSCtNAodvHZZ8eAl7n3qI2zDYT3+8UY5jNWBblF1
	9bHEhfMSnJqFFj9sN34VzVW8+crH7/s6S7d2XWX03fls+R8C4NWu0QSNR098l44EK0y+ZJF1PfyHU
	zgn9osbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpPwP-0000000FL3T-2XBv;
	Mon, 09 Feb 2026 12:00:33 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpPwN-0000000FL32-1b9y
	for linux-nvme@lists.infradead.org;
	Mon, 09 Feb 2026 12:00:32 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 618LFhGq198637;
	Mon, 9 Feb 2026 12:00:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=A+gfA2
	5eMHfA0Ec15swNANM4+fiadJ3rCHe2DP6cRvg=; b=gAsxAz3CzJUA0pYXfUxtNc
	LddV4DESWfLjxQnWKoTPtjYVreplh7/E0Ly3kNQHmJosXVGO0SC3H1IxUVj8Owdt
	4EgCrO0cFoN7zQirtj4uuf3c4ughtXWejjk3Imtpg2Q38J/yKzuEGWbFJl/CQjX+
	jJa0+9Yvi5c+u3KzfP26VcmbeEv+GVzNpSaxNOjMO1vNjwcc6KDozCH/r+W5+PtC
	6wJ964czApxXzsNjvCl/VuuF/hFVFOda8GA7aHRrqxHBvGjPUEIbsrKlUcwu10Bb
	qL9QJ4zuL2MnSVzvbEUoAVhrnmRva0dsI0QNgmF87ST+JI5QsoB9S7wV17m81Evg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696u6wcf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Feb 2026 12:00:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6198nfIL012623;
	Mon, 9 Feb 2026 12:00:16 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c6h7k4vse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Feb 2026 12:00:15 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 619C0EaC11731490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Feb 2026 12:00:14 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B09AE58056;
	Mon,  9 Feb 2026 12:00:14 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 665EF5803F;
	Mon,  9 Feb 2026 12:00:10 +0000 (GMT)
Received: from [9.111.86.70] (unknown [9.111.86.70])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Feb 2026 12:00:09 +0000 (GMT)
Message-ID: <28e54c89-d7d8-4d3e-9eec-3b95a6100ef2@linux.ibm.com>
Date: Mon, 9 Feb 2026 17:30:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 7/7] nvme: export controller reconnect event count via
 sysfs
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, hare@suse.de,
        dwagner@suse.de, wenxiong@linux.ibm.com, gjoyce@ibm.com
References: <20260205124810.682559-1-nilay@linux.ibm.com>
 <20260205124810.682559-8-nilay@linux.ibm.com>
 <48d9c8a1-3fb4-40ec-8bd1-67a82a3c2652@grimberg.me>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <48d9c8a1-3fb4-40ec-8bd1-67a82a3c2652@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KZnfcAYD c=1 sm=1 tr=0 ts=6989cc51 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=I12hwqHY1Al8NnEqJ1AA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDA5OSBTYWx0ZWRfX4ok/UGs93VjS
 2ocs2isKp2NNQNyieUWfSO1jecGCWL6Tve7nofcJQJx1tHrLrhrWohtvfcpKkhgyftKgejPPiZi
 9s7+j+u2iPncJuMZ05aA9770m/06rxS588stunnof69ExtvrT3bCc9Tmf5yThs4/f+m/q85JvpT
 TCCqsFcE6MoDlhDC31iL6t8NZy4QvVePqvrIV+Z3b+j7973yTZsk8/pXPGGsRDfhEJbCFcjJyvP
 NbE5s0SqNDdcjq4GbvYmsP5VVhwxNXD/k9/Gxrk1ganrDWviqE+f6ibJIb6b3jQ6YJSFCBCXbyO
 wH3kdMEb8MfCP70wWMpsemj6XLEWxacksMED0y7crjM992bkoPdHdKZQYEnNtG4Tw0y7VHiQ1v3
 5cuSWjQzZPPXLKL04qr/jrxMs+FHRPLiWcee3RHfZgmppP8iPrnZLuMKB0skUarsFqqCCe7OfBP
 cWK905gAhUatQWFH9VQ==
X-Proofpoint-ORIG-GUID: y7PlUCd2BqQoBuO6sz8v98YY6HBI93Pm
X-Proofpoint-GUID: y7PlUCd2BqQoBuO6sz8v98YY6HBI93Pm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602090099
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260209_040031_423472_DEAE5EA9 
X-CRM114-Status: GOOD (  15.17  )
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



On 2/7/26 7:07 PM, Sagi Grimberg wrote:
> 
> 
> On 05/02/2026 14:48, Nilay Shroff wrote:
>> When an NVMe-oF link goes down, the driver attempts to recover the
>> connection by repeatedly reconnecting to the remote controller at
>> configured intervals. A maximum number of reconnect attempts is also
>> configured, after which recovery stops and the controller is removed
>> if the connection cannot be re-established.
>>
>> The driver maintains a counter, nr_reconnects, which is incremented on
>> each reconnect attempt. Currently, this counter is only reported via
>> kernel log messages and is not exposed to userspace. Since dmesg is a
>> circular buffer, this information may be lost over time.
>>
>> Expose the nr_reconnects counter via a new sysfs attribute, reconnect_
>> events, to provide persistent visibility into the number of reconnect
>> attempts made by the host. This information can help users diagnose
>> unstable links or connectivity issues.
> 
> This unlike the other is zeroed once the controller successfully reconnects.
> I think it is better to have consistency across these sysfs entries.

Yes, that’s correct. The current patch simply exposes an existing counter via
sysfs, and that counter is reset to zero once a reconnect attempt succeeds. 
However, agreed, for consistency with the other sysfs entries, it would make
sense for this value to behave as an accumulator rather than a transient counter.

We can introduce a new counter that accumulates the total number of reconnect
attempts over time and export that through sysfs instead. 

Thanks,
--Nilay

