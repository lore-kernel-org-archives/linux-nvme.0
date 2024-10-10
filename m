Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B29B3CFC5E4
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2024 16:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xgsHVTofpSWZ3r2M60aR0NbzMWdI4JZ3BKY2e4AhSu0=; b=aj9EUQj83ChWDrbX5hbq+Uk20/
	tF1YNbZ0I+5Tla9xm7V3hCYWVFB32geVexNrzrQmmg4vLjDJEKjFOal2ky/np+aQpnCRebFanNyIv
	s4I7Bme8IJP+JGIV/AaTIsNKM/y+smIqkva9Ls0o+zqbm2wZt0QNoo0G8mzrbQyiBg4ZnJnq4IelP
	Bstk9aHmRYmNu7uqtsmjF068Tffg/Dt9yLuKP7zxTXUkbnjMJZpmXYUmbWlnoh+RlotnD69XUVbtO
	CNAkHA15NuR7lJRVDFzPI1iSSPjb1UQ0pdzqcL3t5+HrYgS0hWTN7GLQ17X4WsridCbmDXNA5eN6B
	sb0LP33g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syw7s-0000000DXkf-22Ti;
	Thu, 10 Oct 2024 16:34:56 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syvlk-0000000DTlS-0WwC
	for linux-nvme@lists.infradead.org;
	Thu, 10 Oct 2024 16:12:05 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49AEciVt016011;
	Thu, 10 Oct 2024 16:11:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:reply-to:to:cc:date:in-reply-to
	:references:content-type:content-transfer-encoding:mime-version;
	 s=pp1; bh=xgsHVTofpSWZ3r2M60aR0NbzMWdI4JZ3BKY2e4AhSu0=; b=d49w9
	GwHrqgZOtFAFocHOwGWDoNCVdvLh5FIy+oBthCIMcj/oIIP+p56Tv5gmi284VuUG
	vx50hX8CbPWZDoWC4vBC1/0BXN4FS9CnppjJTlCL60xNi75ga7hXU44EQdqpG3kJ
	C4umwe6BWxRTqLiEKtZ5+HSHXjHzk5rfAzLBC7qQ4JUN/lTnq4LkO2lGJ+gGnj45
	cVcR6/f8U0Jigm0NPrbUp3LdUuTqxW66vv5l2g1G25cBYN5E/MkKoPuTVRQ9H3ug
	/YxI32ipVQOyKwpJasy6Vnv+KUZ/HJJWs4fJWkOSb7rxMF+2IkmFz+U/O5Jjxevl
	WD2cJhxF87XeyQabA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 426gv3rg1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 16:11:45 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49AGBjLW023673;
	Thu, 10 Oct 2024 16:11:45 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 426gv3rg1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 16:11:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49AD7jgq022671;
	Thu, 10 Oct 2024 16:11:44 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 423h9k8my2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 16:11:44 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49AGBirV29033016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Oct 2024 16:11:44 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2156258059;
	Thu, 10 Oct 2024 16:11:44 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A39205804B;
	Thu, 10 Oct 2024 16:11:43 +0000 (GMT)
Received: from rhel-laptop.ibm.com (unknown [9.61.149.22])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Oct 2024 16:11:43 +0000 (GMT)
Message-ID: <d82996a73ba89098bbf2b61733849633612c090a.camel@linux.ibm.com>
Subject: Re: [PATCH v2 1/1] nvme: disable CC.CRIME (NVME_CC_CRIME)
From: Greg Joyce <gjoyce@linux.ibm.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        hare@suse.de, dwagner@suse.de, msuchanek@suse.de,
        jonathan.derrick@linux.dev, okozina@redhat.com, nilay@linux.ibm.com
Date: Thu, 10 Oct 2024 11:11:43 -0500
In-Reply-To: <Zwb98YIioIGRAQBe@kbusch-mbp>
References: <20241007193324.5846-1-gjoyce@linux.ibm.com>
	 <20241007193324.5846-2-gjoyce@linux.ibm.com> <Zwb98YIioIGRAQBe@kbusch-mbp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40app2) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tkgO7J8I0lcEBPBL-FQ2-HUPD2GIseAR
X-Proofpoint-GUID: jOhWQFUmZb90vVTzVeKU-nnOWDsUnpuV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_11,2024-10-10_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 mlxlogscore=548
 spamscore=0 bulkscore=0 phishscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410100106
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241010_091204_304465_798AD4A4 
X-CRM114-Status: GOOD (  17.99  )
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
Reply-To: gjoyce@linux.ibm.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, 2024-10-09 at 16:04 -0600, Keith Busch wrote:
> On Mon, Oct 07, 2024 at 02:33:24PM -0500, gjoyce@linux.ibm.com=C2=A0wrote=
:
> > +	/*
> > +	 * Setting CRIME results in CSTS.RDY before the media is
> > ready. This
> > +	 * make it possible for media related commands to return
> > the error
> > +	 * NVME_SC_ADMIN_COMMAND_MEDIA_NOT_READY. Until the driver
> > is
> > +	 * restructurade to handle retries, disable CC.CRIME.
> > +	 */
> > +	ctrl->ctrl_config &=3D ~NVME_CC_CRIME;
>=20
> We could just delete this section entirely. Nothing else sets CRIME,
> so
> no need to explicitly clear it here. I guess it serves to provide a
> place for the explanation, I think we can remove the flag setting
> anyway.

I went back on forth on that. What I do like is that explicitly shows
that CRIME is not being set and why. But you're right, it's really more
of an elaborate comment.=20

I have no problems with removing it. Would you like me to send a new
patch?

Greg

