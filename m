Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D85CCD1AB
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Oct 2025 08:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RoDsqRQtDPGVBi9bAGRBayt7QtkpTEmGZZUOBqsfBxg=; b=ziVeqoNYMeuHCok3HRTB1GbWaZ
	hX3IBj/gvv3+e6Oiq929vYRQRwRZ/2o1+muxsfE2jjQjeyoQFvhrPBy/WC2eRgyHtnHW2b8jyvg0S
	cXVMdhzCeRIbafHc0v1StzyeTbLyUfoPeGoN8ESVhAKTEc0e76PeXyvev3rkrhtc8905r3i8njs+2
	6D6mqLvTOE6sddDHNObxp/XxDNPtaf3sl9f2ftmmJ9MmPkkrGan0orrifiivtwq7TTTNSMaKtjOCb
	hkUlvZah8DrvpvjelHE86zItmbh5JbSiJL+tlUk3Wpyd0vFjbpqrOP5y2JxRrEnEX2m4IAAOZQtUS
	tt9LOgMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBU5i-000000023ql-3Kct;
	Wed, 22 Oct 2025 08:21:06 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBU5d-000000023oV-1uLC
	for linux-nvme@lists.infradead.org;
	Wed, 22 Oct 2025 08:21:05 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M0Z1N2022111;
	Wed, 22 Oct 2025 08:20:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RoDsqR
	QtDPGVBi9bAGRBayt7QtkpTEmGZZUOBqsfBxg=; b=qFVaMxuXwGdx+CQoSMutyp
	FR/W9M0GEmxzm4AwkgVB9ILioqcguHXGhXutB/JRBTqCk/WzUMasoLC1u6ASm/9Z
	C7i2wwlIj1Uy7JYau6EBe2SFxR/RMNP6GpyFwrmuf7QiPM335VXRGuqqT9HpoyQy
	tpnoCom0KrM/+nZxmiwmmdXVhKvg27VehMrDM90LxxQqmud3/JfFR8gyCQzdymta
	ZEbtlKkug2Q7bKTBZDYVqV3Jz+j7OPbh/ojK4KeT4TIASDp3ux3iwAN4T9a0aETm
	FIActcaU3d9pA2lXl3VdMicOCiaUsp95gV1S4yTDCIM6gaVoz4iQQ39Fprv/8Iew
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30vt5md-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 08:20:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59M6DIwB014848;
	Wed, 22 Oct 2025 08:20:43 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vn7s7gb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 08:20:43 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59M8KgIi25166090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 08:20:42 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 18EEB20040;
	Wed, 22 Oct 2025 08:20:42 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 834EC20049;
	Wed, 22 Oct 2025 08:20:41 +0000 (GMT)
Received: from [9.87.134.81] (unknown [9.87.134.81])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Oct 2025 08:20:41 +0000 (GMT)
Message-ID: <42d3a98ec468c14f21a8e37a53df9ee93010f571.camel@linux.ibm.com>
Subject: Re: [PATCH 1/2] nvme-pci: Print error message on failure in
 nvme_probe
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig
	 <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sagi
 Grimberg <sagi@grimberg.me>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Wed, 22 Oct 2025 10:20:41 +0200
In-Reply-To: <2025102230-omega-octopus-3cf1@gregkh>
References: <20251020-nvme_probefail-v1-0-a420046d98f0@linux.ibm.com>
	 <20251020-nvme_probefail-v1-1-a420046d98f0@linux.ibm.com>
	 <20251022062634.GA4790@lst.de> <2025102230-omega-octopus-3cf1@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9FD8qQeOnQDRobCdl1e3zFhscAzSD0QZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX7cE3NVRtZuVx
 GvlY13LoI73Z/gXSf9QAkvkyIo0S+MNjop9vLf4BKpralvAiLRKjv6SpjmpzExvEKlW/nimHqC2
 4fMMteNjFzEIhpFtFINWfegELd/YWfusfgSIdlyi5eFgYz7ByTHDfkvITRyczFOLGHwpqT6xG5I
 XgjtIpIEgJzHKyFa7O16CseioCcK6imfLkPRI6rwwieJcJlMBIU3j6AzhCdk8ztha8/TNh/LjFa
 dA0cGDn269vpR298gNNM/jPfKh3WUjvOZ3k7dybnEL9um58go+2UrhXbLscCPkJ4Gd+J9shzY53
 mtzo9/jC/r6gcjPi2u1ofXv4ayr5vhpAb98MscvpqvPXulgSOAqwTRodYmSc/LYGtUfeKzsnbW1
 Hy6gqYw6psHNaxOCNuGDP6bhHwuzIQ==
X-Authority-Analysis: v=2.4 cv=MIJtWcZl c=1 sm=1 tr=0 ts=68f893dc cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=nr0wtmjnT5oQp51ULx0A:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 9FD8qQeOnQDRobCdl1e3zFhscAzSD0QZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1011 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251022_012101_622940_2AB094C4 
X-CRM114-Status: GOOD (  22.71  )
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

On Wed, 2025-10-22 at 09:48 +0200, Greg Kroah-Hartman wrote:
> On Wed, Oct 22, 2025 at 08:26:34AM +0200, Christoph Hellwig wrote:
> > On Mon, Oct 20, 2025 at 05:29:07PM +0200, Gerd Bayer wrote:
> > > Add a new error message like
> > > nvme nvme0: probe failed on 2004:00:00.0 (result: -19)
> > > that makes failures to probe visible in the kernel log.
> >=20
> > Is that really a thing drivers are expected to do?  If it is generally
> > usefull I'd expect it to be in the driver core.
>=20
> We have that already, dev_err_probe(), no need to create
> yet-another-version of that.

So I take this as an implict answer to the question, if drivers are
expected to do this or the driver core: Drivers.


Before learning about dev_err_probe() I was sampling a few drivers'
probe functions and got inconclusive results regarding their verbosity
regarding logging errors in probe. Interestingly, none of my samples
used dev_err_probe()...

While for most drivers it may be obvious that in most sytem
configurations it will not go unnoticed that e.g. the graphics
controller failed to probe - there may be other
components/configurations and a centralized error reporting e.g. in
local_pci_probe() would have its benefits. But then with so many
drivers already using dev_err_probe(), we don't want to report this
twice, now.

Thus, I'm going to convert my patch over for a v2.

Thanks,
Gerd

