Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41DBBC3ABBE
	for <linux-nvme@archiver.kernel.org>; Thu,  8 May 2025 16:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IZ55HkvmN9HZlggukNbVUqRxOXe4Oz2CtfSBXcS3rEg=; b=wYidA4WUMM4oRaEaHY9eqlmgRy
	rZZZbZErLnwjlQvaxJZnUXANjznZk6jzCwLh0aGyVxHdhW/3IuAtYmFJu8tK7jtLsBYs41vgFQD3j
	iCkKgxHQyisv8l4DmVKOVB2+v2Khz/FjBncQ4tEeBGK4FamgLyNfs2QswJMDSwJbUT+7hqtIfiCym
	tzYewzs7mNz9RDvmSZkYgX6GDpmee8kAuXdjWCpA9NxUZU5tMN4YGDmAr9kB1ryRIKKl/sJ3slFwo
	jWIah6/yPpKo6n2/S1gn96wIo7goCdEMPJ7+dvjqDt4B1E+Pa8Nw+yp3QJdDBCHYuGf3sjhjO6xep
	jZ5kO/2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD3zU-00000001Gcp-19F4;
	Thu, 08 May 2025 16:20:56 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD2ua-0000000150M-1GIx
	for linux-nvme@lists.infradead.org;
	Thu, 08 May 2025 15:11:50 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548Af0jP012155;
	Thu, 8 May 2025 15:11:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IZ55Hk
	vmN9HZlggukNbVUqRxOXe4Oz2CtfSBXcS3rEg=; b=RZVL/wmijKBoWV/LetVOx/
	TlSHpb1QCAhhNqkghPD+PsArjCzgJjVrpbzV7vm+GXJU9CekX5/MaYhEZfaUvOuN
	SN3k/ygKkPr6OonbNeYHs69uQeUQiL9Zff4eEjE0ZlAPw4VExto7BRbBnSTNSLvt
	KcIb00Z3HLQdXwyxu+02C6YPxRpjZZtsf+NUy0SPsoQlx0wqeVd4Qxl3quuJ8VAV
	t0kYQXe8GhNlY9roCkuy/dRIGLNbgg62V8Oy7B7e2aAWeiTTVyBKz2MW4urRi0DH
	Ejq3HFz3Qqc2ImelQwsjS4ESryaej1GbzwNmFFLVXyfaSuQnr9rlavNEU1cTAP8A
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46gu2t1ap8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 15:11:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 548EdipD014112;
	Thu, 8 May 2025 15:11:25 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46dypkx3y3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 15:11:25 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 548FBOcv20316796
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 May 2025 15:11:25 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A56C95805A;
	Thu,  8 May 2025 15:11:24 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CCAB58052;
	Thu,  8 May 2025 15:11:21 +0000 (GMT)
Received: from [9.67.52.193] (unknown [9.67.52.193])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 May 2025 15:11:21 +0000 (GMT)
Message-ID: <346f2e71-e406-4ac4-b15d-3b19dafa6561@linux.ibm.com>
Date: Thu, 8 May 2025 20:41:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv3 1/3] nvme-multipath: introduce delayed removal of
 the multipath head node
To: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
        kbusch@kernel.org, sagi@grimberg.me, jmeneghi@redhat.com,
        axboe@kernel.dk, martin.petersen@oracle.com, gjoyce@ibm.com
References: <20250504175051.2208162-1-nilay@linux.ibm.com>
 <20250504175051.2208162-2-nilay@linux.ibm.com>
 <dd7330a2-6499-4af7-af3a-489ab86d2b5f@suse.de>
 <20250507065050.GA31543@lst.de>
 <6fa58716-8995-43b9-b01e-3bbcf2cc6b2f@linux.ibm.com>
 <20250508053303.GA27661@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250508053303.GA27661@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=NLnV+16g c=1 sm=1 tr=0 ts=681cc99e cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=MffHSR8OajMSlqoAl5IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: BAqoVvH7DvUK8fW3h0LNsLoyr8ZO-CFU
X-Proofpoint-GUID: BAqoVvH7DvUK8fW3h0LNsLoyr8ZO-CFU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDEzMCBTYWx0ZWRfX44j6Dy1KqrpN Dfg2eNAViaW8l6qh1rMb3tP0xLHECv4hs7Zar02k8BSr2TgiYZPnANkdLhVlSedM1OSDogcBIHI T0nh/qatyE844dWDGMpOrVXqzrctlZ3dL29s1Dd3oQZ2hDVgTACZMfAXWdL2QWET2FCw7r/xIA4
 GiPZDY+rraF/2hQXn4BIUcMgd+1DPBfWeUEnQThZY7IqyLcsmTXqgBxlvFQ4FsqbZFyavmHOWSA L3IcV6CphHoHjzypD6k4n7y/dPxS25eRm6r/kU2mkJNBGuXHbivUg04ITjdIn98PstTIL1Nb6N0 B/s4U8pBDGIl+Jd2YmfojlDricfZ7wbcQeSHDfFPKBI1Wg+f//lQ/3Ri6z+2W8ex0EgdIfNmM5s
 Bt88LIZWHyQKvKi8wpUWS43xUfSfK8Yh7oc+m2AsnlzVklxgBhI4lInciRjnaXthlKEvBppz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_05,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 mlxlogscore=838 phishscore=0 mlxscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505080130
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250508_081148_462423_01B4BD28 
X-CRM114-Status: GOOD (  14.93  )
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



On 5/8/25 11:03 AM, Christoph Hellwig wrote:
> On Thu, May 08, 2025 at 01:26:16AM +0530, Nilay Shroff wrote:
>> That's a possible approach; however, the challenge arises when the head node
>> points to multiple namespace paths, each associated with different fabric 
>> controllers.
> 
> That's generally a good point.  Especially PCIe vs fabrics will be
> fun to test.  We really need a PCI loop device for nvmet to be able
> to test it.
> 
>> As we know, max_reconnects is a per-controller attribute. So, if only one of
>> the fabric controllers has max_reconnects set to a non-zero value, but others
>> do not, how do we decide whether to implicitly disable head->delayed_removal_secs?
> 
> Well, as soon as something in the subsystems can't reconnect we want to
> delay the removal, right?
> 
Hmm, okay I agree (as you earlier suggested) lets not make any difference
between pcie vs fabric setup and unify both. If PCIe/fabric link fails to
reconnect and we lost all paths to a namespace then we'd start the head 
node's delayed_removal_secs timer. This way we'd not further complicate 
the logic and we also don't need to learn whether head node points to 
a fabric setup. I will spin a new patchset with this change and send 
upstream.

Thanks,
--Nilay




