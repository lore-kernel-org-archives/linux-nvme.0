Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F7F1CCD183
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Oct 2025 11:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ml2jTTpereY0mJz9KMBTL34esrs5hZtfSn+KrKhgwD8=; b=TuklsyTWgTKIBCyhnIORccFEp5
	DrKy0Gew2pu3slKXgJuF+80F7F3BMqMig1HlrEC609E92/MmkrGnRCON5Xt/zIoQ0Immo69H0yZid
	1DoaI7LFB+gZcYVDYp7dUqad9y8vsmbOuEx5/NqF7MqCdsedyBKGLGFN5TMbxlC5ry+fkMtD9Vm7S
	G4yIxaJJH2XKPcwdeQHuPuTyZcHI0odUBtRzbQYT1aac+o6SH82vOjbDNAjDGryhbMgWHxKRn510s
	p8vu2vlr1W1hWtpihsZ/GYxxeqczbmAh+CxUrxobs4/49AP6LghYqCg6O1R1IBej0N/Dw1OwRpIBR
	QuuvpdWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9LmK-00000004WCl-2pue;
	Thu, 16 Oct 2025 11:04:16 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9LmH-00000004WCL-3jBJ
	for linux-nvme@lists.infradead.org;
	Thu, 16 Oct 2025 11:04:15 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59G1kbgA012298;
	Thu, 16 Oct 2025 11:04:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ml2jTT
	pereY0mJz9KMBTL34esrs5hZtfSn+KrKhgwD8=; b=N0WVnkE3vAx+qWyGRUu4Ug
	Rx38RKRUqNx2vQIgVy3sio1p+jE6haqKzLqwAdjNGAIf6dE1iVcKEULO0Cu/kvnl
	PFjSA6lolSI8sOnD12tNLtuxZoD3WpJH8UATvKGUSQflE+JGHW1TDG1CF2xLfSNe
	gA+lbirn4C87QXPo4DuC0sXpr4mvbpRNr7xLdob8LFtDXg85yG0ptSV6mGtbxIzo
	0PW1aYhNK3+AGjaWcRu8ZwHNifMC7QvIwClBpKN+z8hxpEMQL89S9yXNtJz3vmb6
	/C88TpvHJqw+LYdwI/2VwcF5tSXhHaFtKfu/UPTP5WW02yCYaaDJUI0L2bli/HWA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qcnrhadc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 11:04:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59GA9fqJ003603;
	Thu, 16 Oct 2025 11:04:07 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r1xy5ck1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 11:04:07 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59GB3tBX30147266
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 11:03:55 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 849D058144;
	Thu, 16 Oct 2025 11:04:07 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E908B5813E;
	Thu, 16 Oct 2025 11:04:04 +0000 (GMT)
Received: from [9.109.198.148] (unknown [9.109.198.148])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Oct 2025 11:04:04 +0000 (GMT)
Message-ID: <b441f30a-4e12-4452-8060-e47ec9847152@linux.ibm.com>
Date: Thu, 16 Oct 2025 16:34:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv2 4/4] nvme-multipath: add debugfs attribute for
 adaptive I/O policy stat
To: Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
        axboe@kernel.dk, gjoyce@ibm.com
References: <20251009100608.1699550-1-nilay@linux.ibm.com>
 <20251009100608.1699550-5-nilay@linux.ibm.com>
 <359e3d8f-4db7-4430-8520-4fed9de4f48e@suse.de>
 <4faf672b-ad74-41dc-9518-bbb9af557544@linux.ibm.com>
 <d179666e-aed5-476e-a6b6-73b3a80ce925@suse.de>
 <803f429d-60f3-4af7-9535-37a2038e53c1@flourine.local>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <803f429d-60f3-4af7-9535-37a2038e53c1@flourine.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M5ZA6iws c=1 sm=1 tr=0 ts=68f0d128 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=h6zKowGUZeksCTtIWkMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 7RhhJ-j-SNQSB1R-Ssb4R0tp8hr5veF1
X-Proofpoint-ORIG-GUID: 7RhhJ-j-SNQSB1R-Ssb4R0tp8hr5veF1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEwMDE0MCBTYWx0ZWRfX7hyHf1fKoWls
 0uJqTWfk9vTTjMeuofsTj540y73EQ8B/UvGmlaigLifxfoanQxPnEL9tbLQk8R46cO5MSP50dcX
 KgTuOkV/a+vHhlhKCaMoSC1oWLlWRTwTG5mgefqZicsikW2xgZfM0GuGfFKh86z85rMRBID/BqC
 38aCe0QW6JZpf9tJrxD3S2Z0n0kN0T+q30SS8ZoDVehrwt/XqMQufpRazrChM3wqXekTl0IADw9
 8dhfkKi4r01Pd6pkrvegaktzEFySGiHQnRF6GdXq2ul8pQBuOZ9/V6Gwiu8psdox2JrCoyZEo6v
 MPAlP0jeF3u0NI7Nbn7QCizSz7q6kRpC6YKm6uE3/me1/TtIBm9sUja8GiB2qUM5/Jsf5a/Iugx
 OWuZo9+sMQbSvBrcwmuYNh1RBtkbtg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510100140
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251016_040414_049619_66641D95 
X-CRM114-Status: GOOD (  15.58  )
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



On 10/16/25 1:57 PM, Daniel Wagner wrote:
> On Thu, Oct 16, 2025 at 08:14:19AM +0200, Hannes Reinecke wrote:
>>> Currently queue_depth and numa_nodes attributes are created under
>>> sysfs, so do you meant to move those attributes from sysfs to
>>> debugfs?
>>>
>> Yes. sysfs information can be perused by udev rules, and that assumes
>> the information in there will not change without a 'CHANGE' uevent.
>> So it's questionable whether volatile information like the queue depth
>> or the round-robin path selection should be presented there.
>> I'd rather have it moved into debugfs.
>>
>> But that might be personal preference.
> 
> If this moves to debugfs, I think nvme-cli should not show it per
> default. Don't want to get lots of questions why the value is not
> showed or updated.

That’s a fair concern — debugfs isn’t guaranteed to be available in
production systems (it may be disabled or not mounted), so depending
on it from nvme-cli would be unreliable. Given that, I think it’s
safer to keep queue_depth and numa_node in sysfs for now since they’re
already part of the sysfs and used by nvme-cli.

Thanks,
--Nilay

