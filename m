Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E06F7CCD1BC
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Oct 2025 14:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0Ijk92v3UleMJeGlfJh3mKVrQNqT4yRsuqbi4j9lFwI=; b=OMCRnD7CRG31RSOKhAEIBaC07u
	8U6H6SOxm4nQWzV7aBCSzcdFkHHMA9WwsIBKgOEiijR8wvCRuTH7btj3NQeYATVZYNz2D0QZWXZ8p
	UHf9fIHa5uIWx+x0iwa0UHIqnH8n2x3P2hDuluziQ+POPVll1nQ5eNQAoOnVqQx0H0O0/OGl6CX9F
	WJQpMFNN5sp42oG4HphpwPXUa4K4ejNaGl33NMt/lEmdzxlWgkXaZBTDa1vfuL67twbGRTNB6Y7xL
	0Xbs9AiCAajy4pdCa+d/e8Fr4olcyHi7Ihap+ZSMEiR6NXwsP5zWdCI3cn7vLvaCttxLW4cuH5kgp
	F+wD2fAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBw8Y-00000006Ycw-37nV;
	Thu, 23 Oct 2025 14:17:54 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBw8W-00000006Ybk-0qLA
	for linux-nvme@lists.infradead.org;
	Thu, 23 Oct 2025 14:17:53 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N5BHcH007423;
	Thu, 23 Oct 2025 14:17:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0Ijk92
	v3UleMJeGlfJh3mKVrQNqT4yRsuqbi4j9lFwI=; b=BQ/4GNlRah+vkqeTU0+a5/
	ELSLr21HsUBNdtbH3IpJTSEiUBj/EBgfILL2NESGWuD3bcjixQfFXWj07G3OFKsO
	leR+CFo7rSIZPt1kMn+Oip9mvWKCg1T0zClSfml9No+bRVAS5ZAp3uhpUTNvIEhl
	udcNqtCIOiFqY19AhRNbPmqj3VcSoEEVKFihBNcGcvnYvY5lZEkqRIWRxKuI1Amr
	Y86Vfd+g2CMAbvw3mN6Gu8DbF0OetDLG4a8UbHaWpn8lqZLj/LAbp5bILE/fR6wV
	PG5LDMvXZgAAW7ilKLG28U/SwVh8NiL3UAm7FoOGuwAimAWs5i+qcfyTW6cf0EZg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v32hs3bs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 14:17:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59NAlnfR002381;
	Thu, 23 Oct 2025 14:17:34 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqejnxmw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 14:17:34 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59NEHWnS37945854
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 14:17:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9B5E2004B;
	Thu, 23 Oct 2025 14:17:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3545520040;
	Thu, 23 Oct 2025 14:17:32 +0000 (GMT)
Received: from [9.111.26.224] (unknown [9.111.26.224])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Oct 2025 14:17:32 +0000 (GMT)
Message-ID: <96c1a4e2bcf93d85b6ff33a30a045ebe7b29fb46.camel@linux.ibm.com>
Subject: Re: [PATCH v2 2/2] nvme-pci: Add debug message on fail to read CSTS
From: Gerd Bayer <gbayer@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg
 <sagi@grimberg.me>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
        Greg Kroah-Hartman	
 <gregkh@linuxfoundation.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Wilfred
 Mallawa <wilfred.mallawa@wdc.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chaitanya Kulkarni	 <kch@nvidia.com>
Date: Thu, 23 Oct 2025 16:17:31 +0200
In-Reply-To: <8d1d9153-810e-4e2b-804a-760bb3523e97@oracle.com>
References: <20251022-nvme_probefail-v2-0-26bbdf94280e@linux.ibm.com>
	 <20251022-nvme_probefail-v2-2-26bbdf94280e@linux.ibm.com>
	 <8d1d9153-810e-4e2b-804a-760bb3523e97@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX2m+fdD43HBfa
 uetp5jvTl69jCQ59dGF7AalWBrsnGOfxK47lC6HZ/BnNhJrSaG85VP/NcEENIr9ygnx6ge2871r
 wcsaUfymAPkPdqmgxi+VmyiKf7cTjj/ZL4AiIzZm5es0LrMOW7AsBGvU/GBGLG0YhNKciX4Kyq2
 l1zZ3EapSiYdoTAg1trUJpa/Ys9mPXO3eUZWTviJRqvW2iU+D1soxvGETxG5s4atCWRVJbXxKOa
 +e10TZGOcy+Iu3NbLZsxLzlwC4Iwy5APEZD/7Xx0W0IS0AhDGAeK/DILufhjsMz8VUo7HQCVDqn
 87xWmrvdL+OfD91bOk69CQdxCPpvFD2sX1KmpUZXsVju+b2feNKYLPgfkCBI9cpOz5cUycEMleD
 i9O6sn4CGBHpbHlbR06hcIzAXM5JtA==
X-Authority-Analysis: v=2.4 cv=OrVCCi/t c=1 sm=1 tr=0 ts=68fa38ff cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=JF9118EUAAAA:8 a=Ikd4Dj_1AAAA:8 a=VnNF1IyMAAAA:8 a=JxuxwCFfafn34pmvjSUA:9
 a=QEXdDO2ut3YA:10 a=xVlTc564ipvMDusKsbsT:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: HixIiVUpRBMaAH7EFMirO-ywnkBK8tNM
X-Proofpoint-ORIG-GUID: HixIiVUpRBMaAH7EFMirO-ywnkBK8tNM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 clxscore=1011 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251023_071752_351259_9C691370 
X-CRM114-Status: GOOD (  20.51  )
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

On Thu, 2025-10-23 at 11:55 +0100, John Garry wrote:
> On 22/10/2025 11:33, Gerd Bayer wrote:
> > Add a debug log spelling out that reading the CSTS register failed - to
> > distinguish this from other reasons for ENODEV.
> >=20
> > Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> > Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> > Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> > ---
> >   drivers/nvme/host/pci.c | 1 +
> >   1 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index 8c624960c9f67e0cc8409023de5e532d6ed9b3ac..ce563e93d29443a25e9236d=
0b6d8152ee85796d7 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -2906,6 +2906,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
> >   	pci_set_master(pdev);
> >  =20
> >   	if (readl(dev->bar + NVME_REG_CSTS) =3D=3D -1) {
> > +		dev_dbg(dev->ctrl.device, "reading CSTS register failed");
>=20
> we should add "\n" as a good practice, no?

that's a very valid point. Sheesh - how much can go wrong...

Thanks,
Gerd

>=20
> >   		result =3D -ENODEV;
> >   		goto disable;
> >   	}
> >=20

