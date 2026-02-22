Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC58C636A0
	for <linux-nvme@archiver.kernel.org>; Sun, 22 Feb 2026 14:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PVmQZ+mtQmLv55fHX/7oNqaj7IuFVN1fSDJ2jIOGnPU=; b=YPL7U5XzlyPgqe26dtTDJd/Nyu
	OQQ93xmcOGODUB4SO3JYPplh2XJbI254HlsEDutbrXj8zZlpfkKKYPUnxeqHJXuaGed6B4mXOL+za
	C6nX2QdwJohfxvHALyLIFW57U5kCKk45y9vBLeTLEhv3ynxGa8a/yYTvuXWLjm3h4h8GYcrkD8W9Y
	4KU+myRa+bBHJxMC2Qc07sfwWGMVttiLUbdzllD5f8/evDN4cJnOHlmXIxgYxMQJI+IwyHLPIvga/
	uPc0N2u+Rcpe/55mJlh+xhUHa58VsKvtyS95SZ5/irpacSqRPO+NY0roF5Idl53tLLFevgObc7ncB
	Te+DPPdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuAAR-0000000GjtO-42QF;
	Sun, 22 Feb 2026 14:10:39 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuAAQ-0000000Gjsz-0TuY
	for linux-nvme@lists.infradead.org;
	Sun, 22 Feb 2026 14:10:39 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61M9oWEw1234657;
	Sun, 22 Feb 2026 14:10:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PVmQZ+
	mtQmLv55fHX/7oNqaj7IuFVN1fSDJ2jIOGnPU=; b=TucBuEd9bxPjghc5CEXJyK
	oDsi+/WbJHE+zPAnau12PfBkeqDId6cIlYWyQAOPPf/ERn00hHm1jro4Vm2Bsylf
	DwIdPYGs8q+R/g89hC7UBfbdLn4ytVsoqPrHeJBc1MWwC4suvDZFzGTHnb5vjey8
	pIU2YlczirFSYcaAzMYi0bDjShUkVVXZpVQJJet+bf2OUtTf6kNEHHsj6JQaeELR
	Tzyb5FODlXZTP7AWkyJDSh8lZvEZ1pTJAc8MwyZuvwl9Ox3mNOrnsPpJygZwVVyr
	rml95Oxqz8LjaJIbwM1Pk44wmBtNavjmD3J9y3Wo2fS1ml+tsvpQgvvpat4lEDZg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4cqm4dn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 22 Feb 2026 14:10:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61MAPCrD027794;
	Sun, 22 Feb 2026 14:10:25 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfsr1ha1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 22 Feb 2026 14:10:25 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61MEA20c21889738
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 22 Feb 2026 14:10:02 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD36458053;
	Sun, 22 Feb 2026 14:10:23 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 448CD58043;
	Sun, 22 Feb 2026 14:10:18 +0000 (GMT)
Received: from [9.111.60.155] (unknown [9.111.60.155])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 22 Feb 2026 14:10:17 +0000 (GMT)
Message-ID: <a5861e66-b1fd-4ef8-815f-d4655880a22e@linux.ibm.com>
Date: Sun, 22 Feb 2026 19:40:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 0/7] nvme: export additional diagnostic counters via
 sysfs
To: Venkat <venkat88@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@kernel.dk,
        hch@lst.de, sagi@grimberg.me, hare@suse.de, dwagner@suse.de,
        wenxiong@linux.ibm.com, gjoyce@ibm.com
References: <20260220175024.292898-1-nilay@linux.ibm.com>
 <37EF3123-DD53-4280-8299-DF49868CFF8E@linux.ibm.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <37EF3123-DD53-4280-8299-DF49868CFF8E@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fFDj3WfDf_pHleqt3aUSfjRD4aPokHoy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIyMDEzNyBTYWx0ZWRfXx3AJy7AY5XTG
 F84Wi/18Bce6FoVdhApdz/8nIta+1e9U1PCCtvlla6el2El/Naiz6eDHpRD37SwE2P3WvxOdsED
 nJRcXuE4+M8Nw2cHz4+U75JHHrJbNSncIcL9LOxQW2f3+QicGp0MxLGe+KShGzhG3mjbAb8QmKm
 D+3HxQVKpsxhLSbo9donKK7M2Nc3q1yeQ8tF6tjkgPr/HkaDogik1dwahPKnOUHHb2r8uIvofpV
 dMijSHw3/TDiw07zJQXpNPp+gb3pXB/7l25XgstbLy2MoYdvOSy3SALTWOd5N2caLMr/34uJQX8
 9dfEe/xzg/DuzouWDBXiIa12/xUzrCOKfHr//sSgPNC6kXu2x6Ac9m36bN5MJre+rozeu0145rL
 QGW6QiI+NOdeTUItGTGIMFRwpGF/96ZIaQNYRWX0RTo49/KnCZTgDlK3ibz62YiDOwxnPv+Wh0j
 H1B25EKyoy9cbTAWb1Q==
X-Proofpoint-GUID: fFDj3WfDf_pHleqt3aUSfjRD4aPokHoy
X-Authority-Analysis: v=2.4 cv=bbBmkePB c=1 sm=1 tr=0 ts=699b0e52 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=cR-Kh_GmupTGr6UrPecA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-22_03,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602220137
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260222_061038_177602_12960B0D 
X-CRM114-Status: UNSURE (   9.92  )
X-CRM114-Notice: Please train this message.
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



On 2/22/26 6:06 PM, Venkat wrote:
> Hello Nilay,
> 
> I tested this patch series and found couple of attributes are missing. 
> 
> Missing diag counters:
> 
> 1. I/O requeue count
> 2. I/O failure count

These counters are exported under head node. So you should be able 
to access it under here: 

# ll /sys/block/nvme3nX

Thanks,
--Nilay

