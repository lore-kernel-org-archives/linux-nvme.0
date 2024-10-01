Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E113CEACCB
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Oct 2024 14:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aJTFiQgZmy0ylAS+WgHxRbMlgD5JI5ZDEst61Aeu4HU=; b=UsCULKHjKqHiin9mDyZLTwlr5b
	ksDXz61HnkM1ExcR/YPAn480rzzXyhSCWv6QEywXCNBBPT89MtG/ySJv+bztd8MCTJh/z0wMvo3by
	KswXB4tue84Jo01SEZY5DmBgcQhHKZG1Lr584Tehj0C5ngGQtMpSTsWMna9ZYsp0GXhUhIqRsIVxf
	lMZTFvErBWz3Gkuma6beWqQuBRY1NeXYQVbKYkzKpK1HCNKkfIb7uyIohdfTe0Cf2NFmN6lD38SoX
	F7JIHWWdvvn2gXutZNi3Q0Bgbw1phrxkL7I1tb7a6tEYi4TTvhqXgeHmD+0JunVF1rgDDTNmTBT/w
	1a2RJrzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1svdcW-000000035i7-2puh;
	Tue, 01 Oct 2024 14:12:56 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1svdXl-000000034On-2e1l
	for linux-nvme@lists.infradead.org;
	Tue, 01 Oct 2024 14:08:03 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4917K0HP006674;
	Tue, 1 Oct 2024 14:07:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=a
	JTFiQgZmy0ylAS+WgHxRbMlgD5JI5ZDEst61Aeu4HU=; b=pWyw1+l2o9pX8jbY1
	GHNr5CqSh3gl89+1gVe+EIs/MdqMDMmE63PU/es3yTHzJFOlvgGaKAnXCkJCB4to
	RWEnThdzur2VDlB0XoI0+5Y9snk9FqY+Q0ftDqqjcrl+xyGGtA+VoysZhSfw4gDr
	HCKkDzqttf/N3lSqguoqXiQ4pK8i03rpJwR7KT56n6U2lwBwrEiuH7VT3Njts4Op
	qrHRH0sHLMLIABn08+ukDz9UIqBqW+4yRDiHYORMfOm3daMJOGy9tRJOpXwQ7OQH
	wvcZsz6ck8mZ1L2kwcI5/ihsGZpB1F6ZW1P8wx7CBLRqrUJiXAHlS0ZDFSTopOMq
	Beiqg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420ckja3j9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 14:07:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 491D8YOL013073;
	Tue, 1 Oct 2024 14:07:50 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41xxbjchvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 14:07:50 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 491E7nAM39715572
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Oct 2024 14:07:49 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53B2958062;
	Tue,  1 Oct 2024 14:07:49 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE3805805A;
	Tue,  1 Oct 2024 14:07:46 +0000 (GMT)
Received: from [9.109.198.143] (unknown [9.109.198.143])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Oct 2024 14:07:46 +0000 (GMT)
Message-ID: <ab01d3a4-3f23-4c77-9fe7-c59b25041d44@linux.ibm.com>
Date: Tue, 1 Oct 2024 19:37:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] nvmet-passthru: clear EUID/NGUID/UUID while using loop
 target
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Keith Busch <kbusch@kernel.org>
Cc: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@fb.com" <axboe@fb.com>,
        "gjoyce@linux.ibm.com"
 <gjoyce@linux.ibm.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
References: <20240921070547.531991-1-nilay@linux.ibm.com>
 <89d4d73d-daef-441d-beae-e9ba52001911@nvidia.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <89d4d73d-daef-441d-beae-e9ba52001911@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -fn4znafHT_u7ewSffgb_Q6alnRQ28e8
X-Proofpoint-GUID: -fn4znafHT_u7ewSffgb_Q6alnRQ28e8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_10,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2410010087
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241001_070801_735388_F8E3D869 
X-CRM114-Status: GOOD (  16.67  )
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

A gentle ping about this patch. Does this now look good to you? 

Thanks,
--Nilay

On 9/24/24 09:04, Chaitanya Kulkarni wrote:
> On 9/21/2024 12:05 AM, Nilay Shroff wrote:
>> When nvme passthru is configured using loop target, the clear_ids
>> attribute is, by default, set to true. This attribute would ensure that
>> EUID/NGUID/UUID is cleared for the loop passthru target.
>>
>> The newer NVMe disk supporting the NVMe spec 1.3 or higher, typically,
>> implements the support for "Namespace Identification Descriptor list"
>> command. This command when issued from host returns EUID/NGUID/UUID
>> assigned to the inquired namespace. Not clearing these values, while
>> using nvme passthru using loop target, would result in NVMe host driver
>> rejecting the namespace. This check was implemented in the commit
>> 2079f41ec6ff ("nvme: check that EUI/GUID/UUID are globally unique").
>>
>> The fix implemented in this commit ensure that when host issues ns-id
>> descriptor list command, the EUID/NGUID/UUID are cleared by passthru
>> target. In fact, the function nvmet_passthru_override_id_descs() which
>> clears those unique ids already exits, so we just need to ensure that
>> ns-id descriptor list command falls through the corretc code path. And
>> while we're at it, we also combines the three passthru admin command
>> cases together which shares the same code.
>>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>> ---
> 
> Looks good.
> 
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> 
> -ck
> 
> 

