Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8532FCF34AD
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Oct 2024 13:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cQV4siYK5vlbjvKR/jWpK2+XIbeiAvP+IUzKBaor8QI=; b=nPCAzvubSCJ9J5WJa+S3jlaWOD
	c9Z2YEebHDxhGigFL6Ztg9vY7QEbtqmP/6fAJcV/IaEX9uv6xZXA5ho7cUYJQE2gH3qMD1fGjSrrO
	GnfOvKD0nFxUnpzj1EHO12jqMdLCE1NfaV0zsKm3zUxC45tNy2hGNsrQMedk0k0Yi/V4lsP/Iw3Mp
	dN2rqw/jrJ2OG1BkFJeIAF1G7BRNmBSJA5DS4HaLuYjkjFNGkwYfgg+CWNd+YOYDcL2GbLKMRSDao
	Q52mlfh1fY1TN3IbKGlYi57sPyt47R5WEHMYNdL4l+jlpfmeYrIujIrRtbiAkls2P0SXmOf3jRXr8
	LN1zaGhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1swLuu-00000009CE0-3RhP;
	Thu, 03 Oct 2024 13:30:52 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1swLup-00000009CAE-26qT
	for linux-nvme@lists.infradead.org;
	Thu, 03 Oct 2024 13:30:49 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 493DLJjb013652;
	Thu, 3 Oct 2024 13:30:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:reply-to:to:cc:date:in-reply-to
	:references:content-type:content-transfer-encoding:mime-version;
	 s=pp1; bh=cQV4siYK5vlbjvKR/jWpK2+XIbeiAvP+IUzKBaor8QI=; b=dG7vm
	XBEHgHZL98O/EA+UFvNe9AohmlIUBDHkJKEydkkqlUb6RaSNsrbOhusn0BYEeroZ
	wUJweHMDUYiYn/QpKdx9LoUPBOVRE2SGx2Vn5WnazzEI3+uu2BXl36sfYMq8rDw3
	EUr36JlxOWpnforqXtPDxKxDbsFd1gws9QjuroxJ9RDz5E81oD4thj97IG1VkQt/
	rb2sicXBmOv6liFMrd7JsEJojuNdYjG8RNDlC0tEn+0Gpy3WVjPuD17BsBENpKVe
	EdPJ/9qCGpNWy1QMrhuuqhyTJ2ZCjsPwxTaOmWRkUOA0qacQP2FLifgwSsJDP4au
	WU9OzfOj5yNu2+yBQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 421v2mg1up-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Oct 2024 13:30:23 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 493DUNo8006487;
	Thu, 3 Oct 2024 13:30:23 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 421v2mg1uh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Oct 2024 13:30:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 493BjvTU008050;
	Thu, 3 Oct 2024 13:30:22 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xvgy85de-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Oct 2024 13:30:22 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 493DULcf14811680
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Oct 2024 13:30:22 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C15605805F;
	Thu,  3 Oct 2024 13:30:21 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A8AB5805A;
	Thu,  3 Oct 2024 13:30:21 +0000 (GMT)
Received: from rhel-laptop.ibm.com (unknown [9.61.147.165])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Oct 2024 13:30:21 +0000 (GMT)
Message-ID: <3876a795bbaa8cef46ed0cb84f8eeccc5462f075.camel@linux.ibm.com>
Subject: Re: [PATCH 1/1] nvme: retry security commands if media not ready
From: Greg Joyce <gjoyce@linux.ibm.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@fb.com,
        sagi@grimberg.me, hare@suse.de, dwagner@suse.de, msuchanek@suse.de,
        jonathan.derrick@linux.dev, okozina@redhat.com, nilay@linux.ibm.com
Date: Thu, 03 Oct 2024 08:30:21 -0500
In-Reply-To: <20241003124345.GA16754@lst.de>
References: <20240930164845.8406-1-gjoyce@linux.ibm.com>
	 <20240930164845.8406-2-gjoyce@linux.ibm.com>
	 <20241002081633.GA22436@lst.de>
	 <dbfd87e4900bea3a28ac46f5abcfb39ef2c13fc1.camel@linux.ibm.com>
	 <20241003124345.GA16754@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40app2) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: R5BiJMbWlJqzRp6ihC0FeuTDFqyn_W8f
X-Proofpoint-GUID: qJ59G5S5_HSAIOB3GqDcaqNycyriDueG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-03_06,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410030097
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241003_063047_937606_F4240DD2 
X-CRM114-Status: GOOD (  32.26  )
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

On Thu, 2024-10-03 at 14:43 +0200, Christoph Hellwig wrote:
> On Wed, Oct 02, 2024 at 11:51:56AM -0500, Greg Joyce wrote:
> > If we cache the timeout value(s) in nvme_ctrl then it may be
> > possible
> > to just eliminate nvme_get_timeout() entirely. Is this the approach
> > that you were thinking?
>=20
> Yes.
>=20
> > I'm a little confused about what you're saying about the timeout.
> > nvme_enable_ctrl() does determine the correct timeout value and
> > passes
> > it to nvme_wait_ready() but NVME_CSTS_RDY is set well before the
> > media
> > is ready (if CC.CRIME is set). Unfortunately there doesn't seem to
> > be
> > any controller status that indicates when the media is ready. I
> > thought
> > about having nvme_wait_ready() wait the whole timeout if CC.CRIME
> > is
> > set, but I think that is contrary to intent of CC.CRIME. And on the
> > SSD
> > that I'm looking at the timeout is 15 seconds which would be a
> > pretty
> > big hit to boot time.
>=20
> What I mean is to simply set a timer for the controller ready
> timeout,
> fire it when we set CC.EN and then the time sets a new media ready
> flag in ctrl->flags.=C2=A0 Then only retry when this flag is not set.
>=20

Thanks. I think that leads me to ask a larger question. If we always
wait until media ready, does the driver really need to set
NVME_CC_CRIME? Currently it only gets set if both the
NVME_CAP_CRMS_CRWMS and NVME_CAP_CRMS_CRIMS are set. So the
NVME_CC_CRIME config option is only set based on drive capabilities and
not any user configuration.

If NVME_CC_CRIME is not set, then the controller doesn't assert ready
until the media is ready and this issue does not occur.

So the question is, should the fix be to just remove the NVMe driver
code that sets NVME_CC_CRIME?

-Greg

