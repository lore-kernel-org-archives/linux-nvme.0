Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47FD3C636CC
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Feb 2023 14:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3CuYy7O6FasRXzvhIgTSnG/tf73vAuOTSrOQryoOQbc=; b=ecZRGejB7zfdqf9POUajQXBUqU
	wDNgTFtXful+Aa6XubEqn//o4Y5y/JBxNXg0kzbx5LL6AAZvoxfn7Rq1QvV742JknX7t8MbWaYWnO
	j2dXcLO+9ccDgQZGg+IfgZESxL1yp8LlDWklYRk5Ugi17LwxbZYYOYwVrRMle7ImKg94zm8Xf/NeG
	qyKVOHuhe9yg5rreL+02d7bDnwGfVbuiT0MUQC1+7TGnUZHpehAxsCedH0k5hL4Evyuk7GzrIeu3S
	rK0cMW1ckGBtGzs5QmWp9j3vHBjwNCkTrU6z4BwXpRacc+hyCQ5UYB0FlfpVPrwIJiDS3buKdygGF
	/E40Xwbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRZOs-00EtfV-Vv; Mon, 13 Feb 2023 14:01:47 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRZOq-00Etdb-Vf
	for linux-nvme@lists.infradead.org; Mon, 13 Feb 2023 14:01:46 +0000
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DDv4tQ006811;
	Mon, 13 Feb 2023 14:01:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=3CuYy7O6FasRXzvhIgTSnG/tf73vAuOTSrOQryoOQbc=;
 b=IyKdXgYpKokYZ/WNaL6++P5ob4VE6wbfe0W6Hf6VzWCjQjK9CyJaftzDtp3NkdQK6WHl
 TjeXlLNktbvUFteesXb4iG/X4nkkAr4aY1WFReUV3VgFj0HvmzdP+xCMoUnARa88iJHg
 1h8QveThUhQ697B9H9uBgR0sN61CX2omO7EE4vl9v/wPe/4+QIb6ADiF4ZszHCKlNWTU
 OWk1RqZRTZmc1GDtGaoN/K7tDobScZ7lJPqrpNv9sdZGEzPFnG9ZQAMPOkRgdVPopIzQ
 bZNejx5M6Why1en+89MGCHuFLPCm0MJasQpL68LunF7AFt8wbAtRYqTs2VT0/Y2B5Bxa +Q== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nqphng31x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Feb 2023 14:01:32 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
	by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31DCY9Nj017758;
	Mon, 13 Feb 2023 14:01:30 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3np2n6jqfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Feb 2023 14:01:29 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31DE1RvY43581888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Feb 2023 14:01:27 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9BF0F20040;
	Mon, 13 Feb 2023 14:01:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 491022004B;
	Mon, 13 Feb 2023 14:01:27 +0000 (GMT)
Received: from [9.171.1.49] (unknown [9.171.1.49])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Feb 2023 14:01:27 +0000 (GMT)
Message-ID: <dae83fe07efc8fa227ea3bba5f419488df392eaa.camel@linux.ibm.com>
Subject: Re: [PATCH 1/2] nvme-pci: fix freeing single sgl
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org, hch@lst.de
Cc: Keith Busch <kbusch@kernel.org>
Date: Mon, 13 Feb 2023 15:01:26 +0100
In-Reply-To: <20230210180347.3613573-1-kbusch@meta.com>
References: <20230210180347.3613573-1-kbusch@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: plqHMyrgcib3-LmcwRwXrtBxLnGrQc4z
X-Proofpoint-GUID: plqHMyrgcib3-LmcwRwXrtBxLnGrQc4z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_09,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130126
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230213_060145_055669_3DB3185C 
X-CRM114-Status: GOOD (  27.98  )
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

On Fri, 2023-02-10 at 10:03 -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
>=20
> There may only be a single DMA mapped entry from multiple physical
> segments, which means we don't allocate a separte SGL list. Check the
> number of allocations prior to know if we need to free something.
>=20
> Freeing a single list allocation is the same for both PRP and SGL
> usages, so we don't need to check the use_sgl flag anymore.
>=20
> Fixes: 01df742d8c5c0 ("nvme-pci: remove SGL segment descriptors")
> Reported-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> Niklas,
> This is a little different than the one you tested, so I didn't include
> your "Tested-by". I'm confident this is patch still fixes the issue,
> though.
>=20
>  drivers/nvme/host/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index a331fbfa9a667..47d6b0023e3a8 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -556,7 +556,7 @@ static void nvme_unmap_data(struct nvme_dev *dev, str=
uct request *req)
>  	if (iod->nr_allocations =3D=3D 0)
>  		dma_pool_free(dev->prp_small_pool, iod->list[0].sg_list,
>  			      iod->first_dma);
> -	else if (iod->use_sgl)
> +	else if (iod->nr_allocations =3D=3D 1)
>  		dma_pool_free(dev->prp_page_pool, iod->list[0].sg_list,
>  			      iod->first_dma);
>  	else


Ah nice that makes it look cleaner and you got rid of the use_sgl flag.
I gave the two new patches a quick test on top of today's linux-next
and they work fine too. In fact while I don't have hard numbers and my
environment is quite noisy and there is of course other changes at play
too but linux-next does seem to get a bit more IOPS than v6.2-rc8 in my
FIO 4k random read test.

Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>

