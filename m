Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF7C1CCD195
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Oct 2025 08:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JaT9jxZT/9ruCmREcADITaJmRyS6QidJB9VhDwpSzkM=; b=V3V9OPQvYDIfgU8ho01vXXqltH
	sOHlVlBclD36NGxjFOF6ncQk/0M0TELIUKADP9XDre9+/jw/gBIMcPX7aEaPEd+LZYF4kJqTGmf4W
	HeH8c3nsIfoLrlkdIGrs64BqfEPlQfWEnKoizy1OI4Tw1Cetslob+vaWi1cvRzo9f9l5r53AxIlmy
	iqQz8SrvJ/JHpnQCgyi6/C4R6H8vWscVrdEX9SwmlxyLcumzU1X4cyDisUD0cHb947cRWMzNzBJ1R
	iix4Ah/kHl+EmpqjJYAbSVC72WtIHBN1iU3CsAKX+watOrY5IovG8UnbDFLSSExIvtHSWs1nfhdXF
	8/M1iVUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBU6k-000000024Aw-3aZG;
	Wed, 22 Oct 2025 08:22:10 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBU6i-0000000249H-1YmL
	for linux-nvme@lists.infradead.org;
	Wed, 22 Oct 2025 08:22:09 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LL0U16013397;
	Wed, 22 Oct 2025 08:22:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JaT9jx
	ZT/9ruCmREcADITaJmRyS6QidJB9VhDwpSzkM=; b=Vg5IX46qWkhQ0d9fYw4/pE
	jrcHcgJvVHlTKTirSfZfbZy46bCRSx+HFjk37AgnN2jkxOvzgXKbGksj6O3SYaw7
	Rii3/NUW2ZRzdt1Kz7OA4mVz2fY9U2lPBbF2T4vRbC/Qu/Ca9TBBzraWGGbl4VDD
	KMzMboQnE6kMqv9Y7wyE0c1WOIx30rV3JZb693KNCU69iF4sJTbTv5g/AqwfyZ69
	9cO8luitH+leMs9JYkLSd4SVZleqwrKprnvWTPxgZLh0GQRFn3SoGy1GZBiv2OGE
	3P22+EXWGkXYswJTesXrfS9jTTj/nCG4J3DhTS2aiH/lFJ/P/c9KdYlyab+EA+8A
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31ca88s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 08:22:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59M7KevZ024940;
	Wed, 22 Oct 2025 08:22:00 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vpqjy7he-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 08:22:00 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59M8LwRl62914986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 08:21:58 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9505520043;
	Wed, 22 Oct 2025 08:21:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B2862004B;
	Wed, 22 Oct 2025 08:21:58 +0000 (GMT)
Received: from [9.87.134.81] (unknown [9.87.134.81])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Oct 2025 08:21:58 +0000 (GMT)
Message-ID: <80f16787fc36b079b15d3a6bd77084edcbc79554.camel@linux.ibm.com>
Subject: Re: [PATCH 2/2] nvme-pci: Add debug message on fail to read CSTS
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sagi
 Grimberg <sagi@grimberg.me>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Wed, 22 Oct 2025 10:21:58 +0200
In-Reply-To: <20251022062727.GB4790@lst.de>
References: <20251020-nvme_probefail-v1-0-a420046d98f0@linux.ibm.com>
	 <20251020-nvme_probefail-v1-2-a420046d98f0@linux.ibm.com>
	 <20251022062727.GB4790@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: g-7jIpN0YmrFmMJaAhZt3Qgz2aH1bQQ8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX0ODoohXl3QD1
 maYD5UlITsBD66lNLpP3zNqYMiMM0VpZYaJnvNbOMyyTExJua8HzoSBBcJ9lTqkbmNmOX6SKD5l
 ggchH4ovoo0FsAU7sEC6Dkmxe1uuJaZXguWCdJbfL0OKrQgkdJX3VyC9d7wr4WWEhhTHIy3QDeb
 5cgq6c3L9U34x019z6Ajh+8ObjpIlJOxDhoDnUS6wCKLJXC+Xkwt5UQ0Whh22L7m8QKM/nMQ6LG
 VQMlHB2njKfPtTq0hmFDjnPJgpmLHYTFkCP5NW7BffkSKBpC6UpsufT4tAMjVF4kSWj7Sb0eOky
 N3KaOe7kpsvJYPKCp0O+4YkP2J9dWdIsYcaBbhQrwq8OLbaQFJawmXlP7FzfFYy5i+8kNesVTc4
 vuYToX/WuPtAJj+2rjTqYvoPv8V0Ig==
X-Proofpoint-GUID: g-7jIpN0YmrFmMJaAhZt3Qgz2aH1bQQ8
X-Authority-Analysis: v=2.4 cv=SKNPlevH c=1 sm=1 tr=0 ts=68f89429 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=xcU7Nz8ZHRE_mIG00AMA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251022_012208_538235_D8F56039 
X-CRM114-Status: GOOD (  18.26  )
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

On Wed, 2025-10-22 at 08:27 +0200, Christoph Hellwig wrote:
> On Mon, Oct 20, 2025 at 05:29:08PM +0200, Gerd Bayer wrote:
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index 7544c4bac2c4a230d32cf729abb9e94bf93a921f..c3b0a9d56ac1f32f67ce089=
0becd6425eb80ebad 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -2906,6 +2906,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
> >  	pci_set_master(pdev);
> > =20
> >  	if (readl(dev->bar + NVME_REG_CSTS) =3D=3D -1) {
> > +		dev_dbg(dev->ctrl.device, "Read CSTS register failed");
>=20
> Should this say "reading" instead of "read"?  Also most (but not
> all) nvme errors don't start with capitalized words, like most drivers
> as far as I can tell.

I'll change that in a v2.

Thanks,
Gerd

