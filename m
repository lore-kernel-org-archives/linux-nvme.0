Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B2A3C05027
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Feb 2023 16:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3Ih0wyCTjSqpJywgjKzegG9fyoZsR7gZig164eKv6qA=; b=KokOUQ9T4yC3n71b6k9Bf8VWbE
	1/aoDEwl0aJFjtr6Zl2zPTQsU2i+QUDMKzjJVHsgfxMekDWs5FiPz05rWPC7R4fyQ+4vxOJv4ZD7L
	ORPvgNpE2alg+mf7TeYGfRvWbKNbi9FKQE3spqrKPl8yKVaVc6mECxnGAU9B43rGU24F/sk8dJ+8X
	fv9PHMYIQomX+DerrAzvUN5pt7sfrt2M27eFRYj2/7dfa/aeDTeBgxNIUApAAksJpMUUxwmamA8jY
	JczoVaUwZ+sRPYZTMykP0SC0NivOA35inG1EkclhPZ0zRPpdgIYDPUaDtB12r8UMashMoRKB/pO9q
	NeRZkmAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQWHY-006WhQ-Si; Fri, 10 Feb 2023 16:29:52 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5] helo=mx0a-001b2d01.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQWHV-006Wfb-LO
	for linux-nvme@lists.infradead.org; Fri, 10 Feb 2023 16:29:51 +0000
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31AGNd9Z013224;
	Fri, 10 Feb 2023 16:29:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=3Ih0wyCTjSqpJywgjKzegG9fyoZsR7gZig164eKv6qA=;
 b=fh8TctpwexMmXztmBCvIHmDVEIbDpL8s7h57pmbEI7DAa5CRSOQPr4mcHztTXfUPpmyU
 QMcQJUarp6wytDjfd0Sw7fZicJNvt1avWITjb3qf1DFWWPCnebEs8NeGVZcNZP6Hr9cg
 taHNk7II8OBMOBIfLNJgfoeLLFBpVe4izD7oGQPb7y/KoCME+ECVv7Mj5UrLNjgV+Jzb
 4chQYxAFhJuDElH7DIqLlcIPFk4+x7BP2ijs3y2mz0jVk+8wj2+SD4vjfkixyxjAb6tM
 67e5HOULA0dHmzQLfazjwaICJQGtXfZIrvhumhcxJQJY1XJiVUTJCdHMmGG8v8NTttqv YA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nnsddg4ev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Feb 2023 16:29:36 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
	by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31A6degt023803;
	Fri, 10 Feb 2023 16:29:34 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3nhf06yrup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Feb 2023 16:29:34 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31AGTWni22806918
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Feb 2023 16:29:32 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C85420049;
	Fri, 10 Feb 2023 16:29:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB66B20040;
	Fri, 10 Feb 2023 16:29:31 +0000 (GMT)
Received: from [9.171.67.142] (unknown [9.171.67.142])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Feb 2023 16:29:31 +0000 (GMT)
Message-ID: <128ea5592001c2a11fbd18c6c2726f35978dfa54.camel@linux.ibm.com>
Subject: Re: [PATCH 0/4] nvme patches for 6.3
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, kbusch@meta.com, linux-nvme@lists.infradead.org,
        sagi@grimberg.me
Date: Fri, 10 Feb 2023 17:29:31 +0100
In-Reply-To: <Y+Zkn3bj80lR4bZo@kbusch-mbp.dhcp.thefacebook.com>
References: <20230108182219.GD25544@lst.de>
	 <fb65a843ba3da23dbb5b7423a2d413c0f263604d.camel@linux.ibm.com>
	 <Y+Zhvn1KwbMVmpGx@kbusch-mbp.dhcp.thefacebook.com>
	 <Y+Zkn3bj80lR4bZo@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nBayU5gohFUfOdecRckN8oJShbjIUS6u
X-Proofpoint-ORIG-GUID: nBayU5gohFUfOdecRckN8oJShbjIUS6u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_11,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 suspectscore=0 impostorscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302100134
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230210_082950_052357_ED7212DD 
X-CRM114-Status: GOOD (  40.83  )
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

On Fri, 2023-02-10 at 08:37 -0700, Keith Busch wrote:
> On Fri, Feb 10, 2023 at 08:24:46AM -0700, Keith Busch wrote:
> > On Fri, Feb 10, 2023 at 03:34:09PM +0100, Niklas Schnelle wrote:
> > > Hi Christoph, Hi Keith,
> > >=20
> > > It looks like this series causes crashes on s390x.
> > > With current linux-next-20230210 and a Samsung PM173X I get the
> > > below[0] crash. Reverting patches 1-3 makes the NVMe work again. I
> > > tried reverting just patch 3 and 2/3 but this results in crashes as
> > > well and as far as I can see patches 2/3 depend on each other. Not
> > > entirely sure what's going on but patch 3 mentions padding to the cac=
he
> > > line size and our 256 byte cache lines are definitely unusual. I didn=
't
> > > see any obvious place where this would break things though. I did deb=
ug
> > > that in the crashing nvme_unmap_data() iod->nr_allocations is -1 and
> > > iod->use_sgl is true which is weird since it looks to me like iod-
> > > > nr_allocations should only be -1 if sg_list couldn't be allocated f=
rom
> > > the pool.
> >=20
> > Thanks for the notice.
> >=20
> > I think the driver must have received a request with multiple physical
> > segments, but the dma mapping collapsed it to 1. In that case, the driv=
er won't
> > use the "simple" sgl, but we don't allocate a descriptor either, so we =
need to
> > account for that. I'll send a fix shortly.
>=20
> This should fix it:
>=20
> ---
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index a331fbfa9a667..6e8fcbf9306d2 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -553,14 +553,16 @@ static void nvme_unmap_data(struct nvme_dev *dev, s=
truct request *req)
> =20
>  	dma_unmap_sgtable(dev->dev, &iod->sgt, rq_dma_dir(req), 0);
> =20
> -	if (iod->nr_allocations =3D=3D 0)
> +	if (iod->nr_allocations =3D=3D 0) {
>  		dma_pool_free(dev->prp_small_pool, iod->list[0].sg_list,
>  			      iod->first_dma);
> -	else if (iod->use_sgl)
> -		dma_pool_free(dev->prp_page_pool, iod->list[0].sg_list,
> -			      iod->first_dma);
> -	else
> -		nvme_free_prps(dev, req);
> +	} else if (iod->nr_allocations > 0) {
> +		if (iod->use_sgl)
> +			dma_pool_free(dev->prp_page_pool, iod->list[0].sg_list,
> +				      iod->first_dma);
> +		else
> +			nvme_free_prps(dev, req);
> +	}
>  	mempool_free(iod->sgt.sgl, dev->iod_mempool);
>  }
> =20
> --

Thanks, yes that seems to have been it and with the above patch applied
on top of linux-next-20230210 the crash disappears and my standard fio
script runs fine too.

So if I understand things correctly possibly thanks to "nvme-pci: use
mapped entries for sgl decision" a collapsed DMA mapping lands us in
the entries =3D=3D 1 case in nvme_pci_setup_sgls() so no extra mapping is
needed and thus the dma_unmap_sgtable() is the only unmapping we need
in nvme_unmap_data()? Does that mean that previously this case might
have used prps and thus now needs fewer mapping operations?

Either way, feel free to add my:

Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>

