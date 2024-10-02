Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 556D4CF6D3D
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Oct 2024 16:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EDwrtAKjNyiAQ7gtBpzerMG9RgaK6oOXXdksyiOAh1U=; b=VWomQpx15PoB9R2wJEULwvs4//
	ptC+NwIuLJK3BSV6Ibs9QCsp8URmy41hxpOQZ5IcS4AmZ8UYg9NRguxmO9wL5GoZpAXouDhrSiwh8
	DMtYk1th5r9w1Z2XAzSJJTK+2hGh6wJehQGvDYYrePCmcijonLbIV3za2aV57grN9Q+t5QUS54aQ4
	ooIRxNlqpnX+XRsV0Cw+hn6hc893ZkHhBxFXFxwkUU7pmrmzkPQD0+7RK1eVGiOOTVYBS9Qpoi/1s
	KTh4f6jeF9X2VqTKXsE2WYGtHGfb3Uz4bNyKDzp6bZ0jJyPvTfcDNEOOh+/BMSuNvx028KiwBwu0Y
	9CfRQ5wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sw2aR-00000006yQ8-2cWt;
	Wed, 02 Oct 2024 16:52:27 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sw2aP-00000006yPT-2IFI
	for linux-nvme@lists.infradead.org;
	Wed, 02 Oct 2024 16:52:26 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492GlqjP009011;
	Wed, 2 Oct 2024 16:51:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:reply-to:to:cc:date:in-reply-to
	:references:content-type:content-transfer-encoding:mime-version;
	 s=pp1; bh=EDwrtAKjNyiAQ7gtBpzerMG9RgaK6oOXXdksyiOAh1U=; b=Ln/Zk
	6YcCxwEnFchQCIs92DzIBKxQgPz9yHTsvzsVhakj2qu0rZQjz8pSYcjRIe1+VEoL
	u22cG/CiOI1jxmINOUSpjOpDaRtpShnFlGxy8uP+RboOkQMj4e2SX2SEREGnpvvZ
	oTtjobBnKWYKmvKShhgXWtt0NfBb1yy53sebu91WbQWDVdXAxL3ZJ5WsPwdl7PZK
	hU6xYxDbarESaoQFu+hNLiXuIwASCtMHYPwFNQ684xguccHMr7LhiBuscYq33+w4
	6Hdr4rkU02cYM9kFkOz5A2DEiIZRtk5wQk7Jog89JgmBjK5x5DOhSPxY+9+9d8JJ
	eHucrJTrNhkAqyj1Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 421a0u80en-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Oct 2024 16:51:59 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 492GpwXl017475;
	Wed, 2 Oct 2024 16:51:58 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 421a0u80eh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Oct 2024 16:51:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 492EQB8P002346;
	Wed, 2 Oct 2024 16:51:57 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41xxu1b22n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Oct 2024 16:51:57 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 492GpvjM38601024
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Oct 2024 16:51:57 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B1E15805C;
	Wed,  2 Oct 2024 16:51:57 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0138758051;
	Wed,  2 Oct 2024 16:51:57 +0000 (GMT)
Received: from rhel-laptop.ibm.com (unknown [9.61.147.165])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Oct 2024 16:51:56 +0000 (GMT)
Message-ID: <dbfd87e4900bea3a28ac46f5abcfb39ef2c13fc1.camel@linux.ibm.com>
Subject: Re: [PATCH 1/1] nvme: retry security commands if media not ready
From: Greg Joyce <gjoyce@linux.ibm.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@fb.com,
        sagi@grimberg.me, hare@suse.de, dwagner@suse.de, msuchanek@suse.de,
        jonathan.derrick@linux.dev, okozina@redhat.com, nilay@linux.ibm.com
Date: Wed, 02 Oct 2024 11:51:56 -0500
In-Reply-To: <20241002081633.GA22436@lst.de>
References: <20240930164845.8406-1-gjoyce@linux.ibm.com>
	 <20240930164845.8406-2-gjoyce@linux.ibm.com>
	 <20241002081633.GA22436@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40app2) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4hbwdT-EQKr5UpubOjFRhyLQpQVwifgS
X-Proofpoint-ORIG-GUID: nycLxBV0YFD3hPiDfyL4Em4FLkHNKi-K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_17,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410020120
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241002_095225_618007_867DF73A 
X-CRM114-Status: GOOD (  32.38  )
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

On Wed, 2024-10-02 at 10:16 +0200, Christoph Hellwig wrote:
> On Mon, Sep 30, 2024 at 11:48:43AM -0500, gjoyce@linux.ibm.com=C2=A0wrote=
:
> > +static u32 nvme_get_timeout(struct nvme_ctrl *ctrl)
>=20
> get_timeout feels a bit too generic for this specific
> controller/media
> ready=C2=A0 timeout.

Agreed. I'll change the name to something more specific.

>=20
> > +	timeout =3D NVME_CAP_TIMEOUT(ctrl->cap);
> > +	if (ctrl->cap & NVME_CAP_CRMS_CRWMS) {
> > +		u32 crto, ready_timeout;
> > +
> > +		ret =3D ctrl->ops->reg_read32(ctrl, NVME_REG_CRTO,
> > &crto);
> > +		if (ret) {
> > +			dev_err(ctrl->device, "Reading CRTO failed
> > (%d)\n",
> > +				ret);
> > +			return ret;
> > +		}
>=20
> And we really should be caching these values instead of reading the
> register for every security command.

If we cache the timeout value(s) in nvme_ctrl then it may be possible
to just eliminate nvme_get_timeout() entirely. Is this the approach
that you were thinking?

>=20
> > +	u32 timeout;
> > +	unsigned long timeout_jiffies;
> > +	int ret;
> > +
> > +	timeout =3D nvme_get_timeout(ctrl);
> > +	timeout_jiffies =3D jiffies + timeout * HZ;
> > =C2=A0
> > =C2=A0	if (send)
> > =C2=A0		cmd.common.opcode =3D nvme_admin_security_send;
> > @@ -2335,8 +2376,19 @@ static int nvme_sec_submit(void *data, u16
> > spsp, u8 secp, void *buffer, size_t l
> > =C2=A0	cmd.common.cdw10 =3D cpu_to_le32(((u32)secp) << 24 |
> > ((u32)spsp) << 8);
> > =C2=A0	cmd.common.cdw11 =3D cpu_to_le32(len);
> > =C2=A0
> > -	return __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, NULL,
> > buffer, len,
> > +	ret =3D __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, NULL,
> > buffer, len,
> > =C2=A0			NVME_QID_ANY, NVME_SUBMIT_AT_HEAD);
> > +	while (ret =3D=3D NVME_SC_ADMIN_COMMAND_MEDIA_NOT_READY) {
> > +		if (time_after(jiffies, timeout_jiffies)) {
> > +			dev_err(ctrl->device,
> > +				"Device media not ready;
> > aborting\n");
> > +			return -ENODEV;
> > +		}
> > +		ssleep(1);
> > +		ret =3D=C2=A0 __nvme_submit_sync_cmd(ctrl->admin_q, &cmd,
> > NULL, buffer,
> > +				len, NVME_QID_ANY,
> > NVME_SUBMIT_AT_HEAD);
> > +	}
>=20
> And this also feels a bit odd in that it doesn't catch
> NVME_SC_ADMIN_COMMAND_MEDIA_NOT_READY when it should be ready.
> I think just marking when the controller is past the timeout and
> only doing the retry until then might be the better approach.=C2=A0 And
> maybe we should have it in the __nvme_submit_sync_cmd helper for
> admin command as Security Send/Receive aren't the only commands with
> this issue.
>=20

I'll look at the spec some more but you're probably correct that when
the status code transitions from NVME_SC_ADMIN_COMMAND_MEDIA_NOT_READY
to success, then NVME_SC_ADMIN_COMMAND_MEDIA_NOT_READY should not be
returned again.

I'm a little confused about what you're saying about the timeout.
nvme_enable_ctrl() does determine the correct timeout value and passes
it to nvme_wait_ready() but NVME_CSTS_RDY is set well before the media
is ready (if CC.CRIME is set). Unfortunately there doesn't seem to be
any controller status that indicates when the media is ready. I thought
about having nvme_wait_ready() wait the whole timeout if CC.CRIME is
set, but I think that is contrary to intent of CC.CRIME. And on the SSD
that I'm looking at the timeout is 15 seconds which would be a pretty
big hit to boot time.

I was looking to solve the specific case of the security commands but
certainly any of the commands in Figure 103 could have the same issue.
The heart of the problem is that CC.CRIME support is not complete. I'll
see if I can address that in a more comprehensive manner.

-Greg

