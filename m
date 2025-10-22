Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F85CCD195
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Oct 2025 11:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t2boCFR7C/oAdKw6eO4grEERwlNfhetkURuijkwtMfI=; b=Hn8A1wrI1JaPm/KFdIdaBoT8oL
	qhUeJQ5ZHlUy6hQahkEZHD1Rqmp8e5CRziZLOCK+SONK6qkzVoY2QLM/ITSTt7Z2NEzZnXS0MdlJh
	ICgRJQhQw314NUw8aXNfs07I33viBQFP6YQEm81+zmEQnoUWTd2asmmuIB58GdsHKT6JArlxWooSs
	Ik05J6xXu9BFzSjqbtcazSh8k7EJCe4uiw/LLFQ/wr/F3+WWhSmBtK6auOGPB9JRL21/cA4gLuxML
	vkAVjBzW818PGjBcXDG41I5SC7fhzYdHghp6n7LBqbbjtsC0wTeuzXGW1QeVTWn/VoTKK94W/Q70s
	oiwwel8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBWjW-00000002agI-0ueT;
	Wed, 22 Oct 2025 11:10:22 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBWjS-00000002afa-3cuG
	for linux-nvme@lists.infradead.org;
	Wed, 22 Oct 2025 11:10:20 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M6sNrA021232;
	Wed, 22 Oct 2025 11:10:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=t2boCF
	R7C/oAdKw6eO4grEERwlNfhetkURuijkwtMfI=; b=Km4qErSbjtJ+NBQIUR3oER
	U0xAsMwcGJRJdSWK7L5WQs37oGWCxY8QSkMYH8NCDG/a8xJXd/OOa+RdcJyYv6LW
	pM0maU0Rmvip+8a4FpZsANLt2sXpciQK/GtlzqiMoB8x8OJSnHOWG6DnGW+ffTJr
	L5GcqhOs4bz/yYEqXrEq0u+J6n+kwJ1krCCG7PDFwhPZIg3AeTY9SbFXvrNKMLMQ
	fG7WIIbQpOvmCndDtKvi08EqHxu9JSZ3eLsdcuuXtX+oKL1run90QoUCiQ+mRU2J
	oMhvdv6u81CKQSkxRskbdstilqVzBrqzAnYaeLqok4WMiec/0nzs85MVBjOWMTuQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31caxq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 11:10:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59M82HX0011053;
	Wed, 22 Oct 2025 11:10:07 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqx17m31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 11:10:07 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59MBA1LH40305018
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 11:10:01 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 22F97200A7;
	Wed, 22 Oct 2025 10:53:53 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A04FF200A6;
	Wed, 22 Oct 2025 10:53:52 +0000 (GMT)
Received: from [9.87.134.81] (unknown [9.87.134.81])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Oct 2025 10:53:52 +0000 (GMT)
Message-ID: <db8fce479c6a682d7ca1c37f7427ad30673fc34e.camel@linux.ibm.com>
Subject: Re: [PATCH v2 1/2] nvme-pci: Print error message on failure in
 nvme_probe
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
        Greg Kroah-Hartman	
 <gregkh@linuxfoundation.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Wilfred
 Mallawa <wilfred.mallawa@wdc.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Wed, 22 Oct 2025 12:53:52 +0200
In-Reply-To: <20251022-nvme_probefail-v2-1-26bbdf94280e@linux.ibm.com>
References: <20251022-nvme_probefail-v2-0-26bbdf94280e@linux.ibm.com>
	 <20251022-nvme_probefail-v2-1-26bbdf94280e@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JbMCHma0NNtYrJkd24Qgl8MdsDQ5-Eem
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX0pREBYWkk+8e
 TVUkY7E0MItQSpHJh7sp+T854CAF7tM89U3FOpLSXM47nGSooRE5aNZ70uf6JJUmVf6byR82wZO
 FN4qNTpkFGmS4Tz4cXnpHu6F5wfG7RQDTjbcA0hFumh1tb/GnOcCFXxGGGVo4q61PfE3NW+zlIf
 wB8LQ1Z9pByUQzs4NbJJcUxxWyAJe3OuTNiavPegUzy1AC0quYIfIF+O6KRbRfSQmFCyefxZO0D
 s56CJXMrTd2d8FZ0Zx6vg27+JKjhpBUv74hTwAWkGeQzrl23LdpBBVmhY/1j59W4WTutuKrtXR0
 V18SBmT/R1gKS2W4t3h8k+7aaXXWPBdaZAX0LJ4qfUqXsv55kz9mc56nJLDHOqV4zMbqCc4p6g8
 DwwJCl7yDsZssp9zeeCu/3zlR7oZew==
X-Proofpoint-GUID: JbMCHma0NNtYrJkd24Qgl8MdsDQ5-Eem
X-Authority-Analysis: v=2.4 cv=SKNPlevH c=1 sm=1 tr=0 ts=68f8bb90 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=WF68Xd0AlUmpovsNYtMA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251022_041019_388738_4F243D6B 
X-CRM114-Status: GOOD (  19.43  )
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

On Wed, 2025-10-22 at 12:33 +0200, Gerd Bayer wrote:
> Add a new error message that makes failures to probe visible in the
> kernel log, like:
> nvme 0008:00:00.0: error -ENODEV: probe failed
>=20
> This highlights issues with a particular device right away instead of
> leaving users to search for missing drives.
>=20
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> ---
>  drivers/nvme/host/pci.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index c916176bd9f058b49e6e6768675711df52b15765..8c624960c9f67e0cc8409023d=
e5e532d6ed9b3ac 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3522,6 +3522,7 @@ static int nvme_probe(struct pci_dev *pdev, const s=
truct pci_device_id *id)
>  	nvme_uninit_ctrl(&dev->ctrl);
>  out_put_ctrl:
>  	nvme_put_ctrl(&dev->ctrl);
> +	dev_err_probe(&pdev->dev, result, "probe failed\n");
>  	return result;
>  }

This one failed to reach Chaitanya due to a typo in the email address
on my side. Sorry!

