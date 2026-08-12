Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7300C5AD5A
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2026 08:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L8+3JqwvjHyIvsLMJhbV9ntYiMz4wu1Nl1YYXFTJM78=; b=IF0qt1f0r/JMu2VcB3DMS15Vvg
	xIDRjHs3h5SGfDexi5ChUJf3tNsVfydkFw1ysYcjVf4WSjuNZOn/xMkIPcPFONN76ykGW0SqVxJe0
	Sy8pcgBqhrOcTpAtPb3W0PVx41+0oGNtxdIY9enstqAcWoGeWLpEljCdrdbH+z0tJKzOtjmbgm1k2
	x0AqtiBNj60RinAGvdVtmFbsRUmfSD1/f50/HuXLUWJQabhXFpmt8SMYSOIvQsfR98lBaY3z+Gtn+
	/ldBNStXLlGwNrAHGMBS2D/7lXE6KhXeN+gspGwf9prYjkZHro45gHs1pcwXsbPxrLRWwtNEYE1/W
	I5JVzc2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu3zp-0000000FcRF-1aSL;
	Wed, 12 Aug 2026 08:07:33 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu3zm-0000000FcQu-2WsX
	for linux-nvme@lists.infradead.org;
	Wed, 12 Aug 2026 08:07:31 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C637SH2708701;
	Wed, 12 Aug 2026 08:07:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=L8+3Jq
	wvjHyIvsLMJhbV9ntYiMz4wu1Nl1YYXFTJM78=; b=hJxKK3NkvJsMce97z/3ptC
	62yl51LtOQX6b/5xLFudf2fvHl55NF/0fwCrp/yH3KaoKc+iRx+6KcrglxPxdDS4
	ZzNbmNp25Ydi8HvzbTgHO8xedHquDSHeSG9Dv6qgJKmkVc/QP4CuMDlX4vsvxF6W
	7a4LwrkcGLahL03jewHIc+QRIH+3ey9V3cRYSp4YxUGSTS0C+xi8gIzI6hubdWtA
	3SLHN+Yy4o1GCbzNpH0jwDtsmrhK4J4xltAx4wfiidN5b/AfN2OR4mKQIaZqNibA
	cVxVO4ncVtc8yOuTBMumqw7bMVia/Eg4MbGvZg6hoQlwKxM3h7fHgh92NAZWxgPA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnw8pn6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 08:07:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67C7uGKV019538;
	Wed, 12 Aug 2026 08:07:20 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesq59vh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 08:07:20 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67C87Knq21889664
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 08:07:20 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 67D1458062;
	Wed, 12 Aug 2026 08:07:20 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4982A58052;
	Wed, 12 Aug 2026 08:07:16 +0000 (GMT)
Received: from [9.61.0.237] (unknown [9.61.0.237])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 08:07:15 +0000 (GMT)
Message-ID: <f7279860-bdde-404d-bfaa-f41220848088@linux.ibm.com>
Date: Wed, 12 Aug 2026 13:37:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/9] nvme-multipath: introduce latency I/O policy
To: John Garry <john.g.garry@oracle.com>, linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, kanie@linux.alibaba.com, jmeneghi@redhat.com,
        randyj@purestorage.com, martin.petersen@oracle.com,
        gjoyce@linux.ibm.com
References: <20260809100825.2014133-1-nilay@linux.ibm.com>
 <35c99788-ad97-420d-b16d-5ba8f6a28f82@oracle.com>
 <e229a15e-26d1-44e6-8cb6-fa59255d609e@linux.ibm.com>
 <52332d80-95b2-4aae-8dd7-313b6e76f5fc@oracle.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <52332d80-95b2-4aae-8dd7-313b6e76f5fc@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7c29ba cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=NEAV23lmAAAA:8
 a=t34BQtHZ46P9W9PX5DYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: YeD-0_nOeKWGZJaT_c3At7rn4d8P4q44
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA2MyBTYWx0ZWRfX02Jr0VxYqEGQ
 mkTOQGj9nEuqHlMhDH1x0eqj8d4iPBVd+qBSxPIB5wqgSBh5q1atqj1VAWvtInkCEI74OKa0Biy
 APnfVaYF+QFlogGt9FnCQ9spQ2XS+cin0+p0IjPsRFeBqgWVnNdMEWnxNr2S1urXNDQqzk1jIE9
 vvpYnThIxQB1OyGiZalhF7ywijRL/eBTWQDelIQ7sgGLEc2AHjBBJ8R5kZQXlPI4NBq3ZCtT3Sd
 A8hmV3tdGC4+x1XOboejGjetwgzrDWIMAgJOoIgekPpMOh8MTUeEnuEkMLZ+eR1c5NEAEd18V/6
 m9+yGKOIU0bZvTB1CPrKJjPGkDq0HhoO1S46TPnfa2AA1lqgwqC3ZvSV+xs07RDHB2ypTYRxGj7
 aMyDAkAAemDv7z1uuIgAqeJ1Z5l+JZfNaqPsvHhB/7lsR9HDIRM371VEtzP9rmVywBjrUeTuder
 lGMD+3SJahTIzJsUo+w==
X-Proofpoint-ORIG-GUID: KAtZUNnurAtFERdM_4m-jmU4fR8zw1db
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA2MyBTYWx0ZWRfX4xdE5cbLbBRI
 +vlJbX5GOHJCD26V4td9v/XM5sQDTErgNACAQrbKxKm6lb2exy9jK7MXkiiyy2wogsoM91srZhz
 WoJHNfO6vF64xtrwFl2TdQ6P78AP79s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120063
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_010730_816564_5BA14ED0 
X-CRM114-Status: GOOD (  10.17  )
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

On 8/11/26 3:07 PM, John Garry wrote:
> JFYI, on another topic, I did a quick port of this to libmultipath as a PoC:
> 
> https://github.com/johnpgarry/linux/commits/scsi-multipath-v7.2-v7-latency-v7/
> 
> It's really just a direct symbol-for-symbol change.

This is great!

Thanks,
--Nilay

