Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D5DBCCD184
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Oct 2025 08:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Js7+x7cG021sE+K0OqINhKd3ibHiPQE47jcGn0OPCS8=; b=YuwbspDJToGqBFtqhwlLiUNtTj
	XqqO5quIUEiMK3SvW9gMMC0dvxD5RqJo588IGEtsmWPks1ukoqluwZH+35GyZPDg58SU/vR1kVmlk
	3Il+L2HX94QVZ7Sfug49eeiFWCYH+56YYcfNQZ1ckGLPR79BVQ5kEVnutTTVHO0pGNKaD/WRx1qqQ
	0fJ3H7z9YUsstwcbhOxg/Rd1DEhMc6+kaJe3FVGbGtv18ENrTvcvRdPe+k/nbdCrDPNn+CNdzqp0m
	/EID54lkOdtOF9Q697TfPMmQuMpUw1ebNUKymy+6iBcic3ZEeRmEEdSrCT8SnrlBUiVwEiVR3SBP1
	x2pc5IiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vB7Ue-0000000GEnj-31oe;
	Tue, 21 Oct 2025 08:13:20 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vB7Uc-0000000GEn4-2cKs
	for linux-nvme@lists.infradead.org;
	Tue, 21 Oct 2025 08:13:19 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KILr5b027075;
	Tue, 21 Oct 2025 08:13:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Js7+x7
	cG021sE+K0OqINhKd3ibHiPQE47jcGn0OPCS8=; b=Zgqp4pBzEkTgEh5yAifNr6
	ckB74EU2CGSEcKbd4VHOjWn1p/dFHub0jDy91l/Tqsww2Nn4i8woKX36tTx3vHYh
	eyz+eLuM0LLCUwcThV6YQbeHcFZqrU3KkpFwg0I6IBdWONrzMzwv4D/rAKsvYuwB
	HtjurWojAdbBMQv7YsJjIm5yrNjVM03Gful5v7tH1cgNACnIyR0AgjFUS1OkM/2G
	MSsEOYKbALb5txSiE7s7R7E46gKTSDfvyFPNkiCZSwMVTVjdVHfLJf3ut/S6w/+A
	eRSD6Ae8BICY3wLCdVsrPAFRT2+8h4bO9qUami2wqaQNJKfLaelTm5WlVpSCxNkA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31rwuh4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 08:13:17 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59L7nwnS032166;
	Tue, 21 Oct 2025 08:13:16 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vp7msqqe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 08:13:16 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59L8DDGd28574050
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 08:13:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E77A72006C;
	Tue, 21 Oct 2025 08:13:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE8292006A;
	Tue, 21 Oct 2025 08:13:12 +0000 (GMT)
Received: from [9.155.208.229] (unknown [9.155.208.229])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Oct 2025 08:13:12 +0000 (GMT)
Message-ID: <d043050a539b547617dd2e477283d9074c538580.camel@linux.ibm.com>
Subject: Re: [PATCH 1/2] nvme-pci: Print error message on failure in
 nvme_probe
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-nvme@lists.infradead.org"
	 <linux-nvme@lists.infradead.org>
Cc: Gerd Bayer <gbayer@linux.ibm.com>
Date: Tue, 21 Oct 2025 10:13:12 +0200
In-Reply-To: <ac6a2d21-2070-49e7-8254-5fe7d5b70bb0@nvidia.com>
References: <20251020-nvme_probefail-v1-0-a420046d98f0@linux.ibm.com>
	 <20251020-nvme_probefail-v1-1-a420046d98f0@linux.ibm.com>
	 <ac6a2d21-2070-49e7-8254-5fe7d5b70bb0@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sYFCK0zRqOs-8kSeKn44Cb37ABuMPgyp
X-Proofpoint-GUID: sYFCK0zRqOs-8kSeKn44Cb37ABuMPgyp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXz1voJM1ioMK6
 wWBU3X+HTZBDwT5WviWhc6GQsxTAf4b3voIkFmgsVeqqyCxYZAdukJEIl75S2Y7CkSckfM+PCbc
 glQcvoWwK1FGml4+KXlV6+bAB6NVDWuhhlkcFuENyOFuNmkCEYGUK27J6r9HamPG24GYG99qTlL
 R1FLevnzV1c2vi7Hjy+Q/CNl0tMuNSoWanBKzFxJ/Ww1gb7NBtHOojjz1QSP2kl4vYERo4g+9tU
 sOKeiIeu52GZ38qG0pnpi1gN31iEj7pBsjac+LZxGlu/NUnt4MWA51mKfslxGWJVYlsB5LA/vcb
 pKxgF3jr77Dz/5oYic4lXhFjaiYg/z+aH/JovQo3+KBbna018jmpYaPSODrEfydv8t0dbDZOiBy
 ln7ROtD3JQRXROOFFcHvX3EI/1WFlQ==
X-Authority-Analysis: v=2.4 cv=IJYPywvG c=1 sm=1 tr=0 ts=68f7409e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=46a_qQKXW0f_kL5dsLsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1011 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251021_011318_666542_F2637D36 
X-CRM114-Status: GOOD (  19.37  )
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

On Mon, 2025-10-20 at 23:35 +0000, Chaitanya Kulkarni wrote:
> On 10/20/25 08:29, Gerd Bayer wrote:
> > Add a new error message like
> > nvme nvme0: probe failed on 2004:00:00.0 (result: -19)
> > that makes failures to probe visible in the kernel log.
> >=20
> > Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> > ---
> > =C2=A0 drivers/nvme/host/pci.c | 2 ++
> > =C2=A0 1 file changed, 2 insertions(+)
> >=20
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index
> > c916176bd9f058b49e6e6768675711df52b15765..7544c4bac2c4a230d32cf729a
> > bb9e94bf93a921f 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -3519,6 +3519,8 @@ static int nvme_probe(struct pci_dev *pdev,
> > const struct pci_device_id *id)
> > =C2=A0 out_dev_unmap:
> > =C2=A0=C2=A0	nvme_dev_unmap(dev);
> > =C2=A0 out_uninit_ctrl:
> > +	dev_err(dev->ctrl.device, "probe failed on %s (result:
> > %d)\n",
> > +		dev_name(&pdev->dev), result);
>=20
> is it really have to be dev_err ? or dev_dbg would work ?

I've almost overlooked this question, since I'm not subscribed to the
list - found it on lore.

dev_dbg is too weak IMHO. I assmume most installations don't log debug-
level and would require a repro with dynamic_debug turned on. My intent
was to highlight the abnormal behavior even in default kernel configs.
I was following the example in mlx5_core that produces error-level
messages when probe fails.

Thanks,
Gerd

>=20
>=20
> > =C2=A0=C2=A0	nvme_uninit_ctrl(&dev->ctrl);
> > =C2=A0 out_put_ctrl:
> > =C2=A0=C2=A0	nvme_put_ctrl(&dev->ctrl);
> >=20
>=20
> -ck
>=20

