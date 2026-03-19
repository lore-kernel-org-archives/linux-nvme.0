Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D297C109023F
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Mar 2026 15:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Cc:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zCq1zaIgoZXLixw1vskAn5zrM/khFrPmbVTwhoNYktc=; b=AZj2Yb2KJVtrTm2xCRGLTZO8M4
	gTbRlJGtOHT1ccdgNenXgHi0eU2ZKU0AsnFZt17rDxzjWBRZCfZEQFAoB/P6D2tJWM4hIVfOIYuVs
	ieBjwPVgVYATtnPN0v2JSrJqQanyZo8AciNRFAmOQ5yYIZ6w8SNx2gwIH5cWn/xihcEt5ZEvOBOMg
	f55szo6WXHFZYr9IL0WkrODdNiN6Hz8qJR83aPQ3Y0sLZjHvHEp0p/JzN5eM06xBzx6L/aQ8Xjz8+
	glSvTWjFLfx4vnsSETSTs4EaSVLGuwbjUhREE8sh55zmXrTozk3u8MXySjW5iEixg5AuC2ZFeeiTz
	xeof4oiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3FjY-0000000Az9Z-34BW;
	Thu, 19 Mar 2026 15:56:28 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3FjV-0000000Az7f-3v2p
	for linux-nvme@lists.infradead.org;
	Thu, 19 Mar 2026 15:56:27 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62J1ixov1189478;
	Thu, 19 Mar 2026 15:56:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zCq1za
	IgoZXLixw1vskAn5zrM/khFrPmbVTwhoNYktc=; b=AJU+T6Oc3s2E6iP7cPvWDs
	wY32wF1ViC+3vCNEomGRvPQalIlQPuryuNcVU8Mr2HNpqzuY5awslG5NeMQ50Rpu
	EKaAwYK+6YJ6+897ebgaLYz9Dwfp7YE8hI7i9wXPYYiF2+XAOt6s4AMWn7oRmkzP
	r6qrGGMnbh0fvI4TJcRESxsZ49I5z3oQ2UBKWiOZnXUaGOlNglfB0e3alRo3snlj
	kASTyJV3O4TqXWOCYO8jd7qzRiUcUzXzCT/pj4haWCPi5l5OBPwTw+rxCXYLqdV1
	NffbHNBYd2qAQMmvqnqegif3wFEePYzp+S1F4+j8aL1/Lx0Yc+1my4WE2KId5V/A
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cx7vft0h7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 15:56:08 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62JDWupx015735;
	Thu, 19 Mar 2026 15:56:07 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwk0nk2we-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 15:56:07 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62JFu5DL5505550
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 15:56:05 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70F5F58059;
	Thu, 19 Mar 2026 15:56:05 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 926C658043;
	Thu, 19 Mar 2026 15:56:01 +0000 (GMT)
Received: from [9.124.221.182] (unknown [9.124.221.182])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Mar 2026 15:56:01 +0000 (GMT)
Message-ID: <b869b5e5-2bf8-486a-b515-a95432018617@linux.ibm.com>
Date: Thu, 19 Mar 2026 21:25:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 0/7] nvme: export additional diagnostic counters via
 sysfs
To: John Garry <john.g.garry@oracle.com>, linux-nvme@lists.infradead.org
References: <20260220175024.292898-1-nilay@linux.ibm.com>
 <92f27319-649b-4957-9de7-619d76faa1ce@linux.ibm.com>
 <aar6j8S1O-mjqqxN@kbusch-mbp>
 <a1acd62e-3e22-42eb-b634-3e9ab18bc39a@linux.ibm.com>
 <ab4941b7-a722-4495-8bf9-bd1e602a802e@oracle.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Daniel Wagner <dwagner@suse.de>, wenxiong@linux.ibm.com,
        gjoyce@ibm.com, Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ab4941b7-a722-4495-8bf9-bd1e602a802e@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6hs_7JtlpBVaM2k7VCaYv5TFexNoN8eU
X-Authority-Analysis: v=2.4 cv=KajfcAYD c=1 sm=1 tr=0 ts=69bc1c98 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=dHPYOZdJIAKcMSbv7sMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDEyNSBTYWx0ZWRfXyt5rw9TcHcXS
 rOAyIBCPiLA6noAVEBgaO/zICWqLQfkl2aQijNnSwJE2yhqzL+vTvlPB5Yqc5EZQ2aJH0hDsrBw
 5ZruRaofCcoOySr62/kXnbPBviDY+MS8rFa5pjy/aCOP5d+6brXXV9+Xmd44fmefwOp0jTab/wC
 ZF8lEQSN+EC5CJwnd8/0dtpcHcmHD5UE5ubKeZbc0IoYiCsZ8ICafaOS/DkLCmfLfNi+5hcyauu
 qoTAm2L9lboycUXwMBrbEO+Bxe8HxOfi2HlchfOTMl85hPjaf0+DjaX66Wc6A5/EibItTCfm1XQ
 0f4jHmku2/4WYUsmbM3eGN/L/gQs5tDX9+2bcj6p7pRmOJonDJRAortr2UKCYPQf1ot1XPX4iOY
 sFQDFWsP9vPGGdsypLAtCtH9yBWeKayb8H3p8WfutxEtm7JknGM+IpkKZ1oeR+8ExwxXv8FEjZa
 OSK8N65cnZmKL2et2ug==
X-Proofpoint-GUID: 6hs_7JtlpBVaM2k7VCaYv5TFexNoN8eU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_02,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603190125
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260319_085625_987450_F5FF431F 
X-CRM114-Status: GOOD (  25.30  )
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

Hi John,

Sorry I missed to reply earlier as I see you sent your reply (probably by mistake)
only to the list; so I just saw your message. I am adding back all recipients.

On 3/9/26 9:02 PM, John Garry wrote:
> On 08/03/2026 18:55, Nilay Shroff wrote:
>>> Last thought, as you are probably aware, John Garry is proposing to
>>> lift the nvme multipath into a generic library, which suggests many of
>>> these events would also need to be generic. Should some of these, like
>>> error and retry counts, be appended to the generic disk stats instead?
>>
> 
> Thanks for the mention
> 
>> Yes I am aware about libmultipath work.
>> I agree that retry and error counters might conceptually fit into
>> generic disk statistics. However the intent of these diagnostic counters
>> is to capture all relevant events, including passthrough commands.
>>
>> Passthrough requests are typically not accounted for in generic disk
>> statistics, which makes that interface unsuitable for these counters.
>> Additionally some counters are reported at the controller level, and
>> controllers do not have an associated gendisk or block device.
>>
>> For these reasons exporting them through the dedicated sysfs interfaces
>> appears to be the most appropriate approach.
> 
>  From the current list of proposed counters, my thoughts per counter are WRT SCSI:
> "nvme: export command retry count"
> The ACRE which this is based on is not relevant (to SCSI), and I would be reluctant to add such a counter for scsi_devices
> 
> "nvme: export multipath failover "
> I think that this could be added for scsi_mpath_device class
Ack
> 
> "nvme: export command error counters "
> Similar as "nvme: export command retry count"
> 
> "nvme: export I/O requeue count when no path is available "
> I think that this could be added for scsi_mpath_device class
I think this one should be added under mpath_head; this counter
represents the num of I/Os which has to re-queued (i.e.
mpath_head->requeue_list) due to none of the path is currently
available

> 
> "nvme: export I/O failure"
> Not really relevant to SCSI, or more relevant to SCSI low-level drivers (which I would not want to expose as an ABI for SCSI multipath)
> 
I think this one as well could be added under mpath_head; this
counter represents num of I/Os which are forced to fail maybe
because all paths (reachable via head node) were either deleted
or not usable at all.

> "nvme: export controller reset event count "
> Same as "nvme: export I/O failure"
> 
> "nvme: export controller reconnect "
> Again, same as "nvme: export I/O failure"
> 
> BTW, I think that the counters should be atomic - otherwise we are not getting accurate results. And, as is mentioned, none seem to be in the fastpath (so I don't know why not have them as atomic).
> 
Yes I will be making counters atomic as Keith suggested earlier.

> Finally, some of these counters seem to me to be more suitable for a debugfs (and not sysfs).
> 
You are correct but then this counters would be consumed by nvme-cli
(and mostly by nvme-top) and you know the debugfs may not be always
available or mounted in production system. For that reason, exporting
the metric through sysfs ensures it is consistently accessible in
production environments.

Thanks,
--Nilay

