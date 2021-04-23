Return-Path: <SRS0=/503=JU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A40C433ED
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Apr 2021 10:15:45 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECD1661425
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Apr 2021 10:15:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD1661425
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XC72haun+e9FrVImfoxEUfbUJgVLvdUxWTDjxKrhhpc=; b=a2sInTBDO4G00kLJgZkoj+4SL
	5I0SBBUFL67OhP0CwqYtJn1dSu1DAwlrst14i7LdGhwz6hJa15I9t+Zc/kLqoZ4RrMJVQWYQaQUX1
	J8p+kuTIscaVAEss/jz/PwmZa0YBa4q7/swbwCEz7YZY273hYqReiLw1+KKrDCwOQZBq0ZXoNH/lB
	Is3bLYEnY2e8kkoRLprGNh/ZTTK2ajaqquv0MZZ/yxZgd9hiz7X7NZ9xYefOBSGRj7xDKSlETDWO1
	4F8OMEiI27xNbBRHRM0JG13thb/7CNH+0zO7q8FbN23PyVRetEnWSr+yyCaXmC5hkI/cydFPphqek
	QTaVNu8LA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lZsqB-001Hgt-Pz; Fri, 23 Apr 2021 10:15:16 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZsq6-001Hfe-HC
 for linux-nvme@desiato.infradead.org; Fri, 23 Apr 2021 10:15:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Sender:In-Reply-To:Content-Type:References:
 Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
 bh=T0j/8O4XLMHdOYTmJIQ8i1HYCFtd826CSqst3JWiqUo=; b=2gYg82fCSvx+qz0s9g1CDyzA6
 2GzwHVM7uUfl+ElAClMjrpNtRC38VVaOhqrLf0gUuqVTQyzrzUmJ3c1yUFVPnK0tvkpHMdqASr9cx
 /CC82Ps+g8r+Tt60YgY0tAtQZM7dYX2XR9Qx9F5iyiu8B5pJOUcz9TBie6GqtrRvSzcSjHeBObxEc
 3yNU5ExcwBRvGCz2v7Muyq+FBPAP62W2HDET1LsIHCtyebrAeqpdoTKnk9Za+s6gH5IuAh66/uN3o
 MOwIS4KaGrcBmyiPcBcmkmDPeiIlE+yHnuNm0XZ/Zo3jBF+9JsfKgaaMcXXh1qK+b1GStr2+0+GaX
 mIO44LBXQ==;
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZsq1-00EJuH-Ri
 for linux-nvme@lists.infradead.org; Fri, 23 Apr 2021 10:15:07 +0000
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 13NA4Qs2100953; Fri, 23 Apr 2021 06:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to : sender :
 content-transfer-encoding : mime-version; s=pp1;
 bh=T0j/8O4XLMHdOYTmJIQ8i1HYCFtd826CSqst3JWiqUo=;
 b=kEmB0UqX70S65sspScFGkdnCtEdgkq/mByilOD489qw6PHLdsN43H468l6ztWFSe4XBR
 N4xhEaio3QykHb1FdEKyUdGyHkrnW9C3D6gcdu5LACNk4CFV1Cx88NuFRehLuK1VSo+E
 DGkxF863AiiRZXJGnfLZmsveroFlT0XThwBEqi9+EPVTwQZgXwjxQFY4t36LD3zB3Dlu
 se/Lfbyrs1OrOUALCeL9jwWcW6HAEoV6DapRkKWOIX3dl5ofwHxAg03841e0vPalkut/
 Z+j1x+pHUIUIoImkTdXf+HulcY7qBpug3IIo+EL6NWoDNZUqzsvfx1Zgm/JMqHn3YhhE FQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3837fsfp1v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Apr 2021 06:15:00 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13NA6YIx107933;
 Fri, 23 Apr 2021 06:14:59 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3837fsfp1d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Apr 2021 06:14:59 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13NA8Hkj030820;
 Fri, 23 Apr 2021 10:14:57 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma06ams.nl.ibm.com with ESMTP id 37yt2ru8ur-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Apr 2021 10:14:57 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 13NAEUB236700510
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Apr 2021 10:14:30 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 18B584C044;
 Fri, 23 Apr 2021 10:14:54 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 024644C040;
 Fri, 23 Apr 2021 10:14:54 +0000 (GMT)
Received: from t480-pf1aa2c2.fritz.box (unknown [9.145.12.22])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Fri, 23 Apr 2021 10:14:53 +0000 (GMT)
Received: from bblock by t480-pf1aa2c2.fritz.box with local (Exim 4.94)
 (envelope-from <bblock@linux.ibm.com>)
 id 1lZspp-003mXD-Dj; Fri, 23 Apr 2021 12:14:53 +0200
Date: Fri, 23 Apr 2021 12:14:53 +0200
From: Benjamin Block <bblock@linux.ibm.com>
To: James Smart <jsmart2021@gmail.com>
Cc: Muneendra Kumar M <muneendra.kumar@broadcom.com>,
 Benjamin Block <lkml@mageta.org>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, tj@kernel.org,
 linux-nvme@lists.infradead.org, hare@suse.de, emilne@redhat.com,
 mkumar@redhat.com, Steffen Maier <maier@linux.ibm.com>
Subject: Re: [PATCH v9 03/13] nvme: Added a newsysfs attribute appid_store
Message-ID: <YIKeHaCpbWwJT6Lh@t480-pf1aa2c2.linux.ibm.com>
References: <1617750397-26466-1-git-send-email-muneendra.kumar@broadcom.com>
 <1617750397-26466-4-git-send-email-muneendra.kumar@broadcom.com>
 <YHxRK33kf7OSVlxf@chlorum.ategam.org>
 <a6497bd924795a5a9279b893b0d83baf@mail.gmail.com>
 <YH62VB+SVfnG+GoI@t480-pf1aa2c2.linux.ibm.com>
 <2eec720b-401a-32b4-80e6-900e136939b3@gmail.com>
Content-Disposition: inline
In-Reply-To: <2eec720b-401a-32b4-80e6-900e136939b3@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FO7eqQttv71Aw5OYgSl3W1FIYevepe1P
X-Proofpoint-GUID: yFfvZg9kXtk3PpT38l9WXK9ZLvW5OBLP
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-04-23_03:2021-04-23,
 2021-04-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104230062
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210423_031506_030972_8DE1DCA7 
X-CRM114-Status: GOOD (  38.98  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Apr 22, 2021 at 04:29:10PM -0700, James Smart wrote:
> On 4/20/2021 4:09 AM, Benjamin Block wrote:
> > On Tue, Apr 20, 2021 at 12:24:41PM +0530, Muneendra Kumar M wrote:
> > > Hi Benjamin,
> > > =

> > > > > ---
> > > > >   drivers/nvme/host/fc.c | 73
> > > > > +++++++++++++++++++++++++++++++++++++++++-
> > > > >   1 file changed, 72 insertions(+), 1 deletion(-)
> > > =

> > > > Hmm, I wonder why only NVMe-FC? Or is this just for the moment? We =
also
> > > > have the FC transport class for SCSI; I assume this could feed the =
same
> > > > IDs into the LLDs.
> > > =

> > > At present it supports only for SCSI-FC .
> > =

> > It does? By adding it to the implementation under `drivers/nvme/host/`?
> > I am confused.
> =

> Yeah, this is a little odd.
> =

> This history is: we know we need to merge the scsi fc transport and the n=
vme
> fc transport as the two independent things are creating difficulties and
> duplications (devloss is an example). But it's a bit of work to change th=
is
> as it will move where the objects are in the topology tree.
> =

> As we tried to figure out how to do the interaction with cgroups, we want=
ed
> to support SCSI and nvme. If you look at how this new attribute sets the
> vmid, it's somewhat generic - it just sets the fc appid field on a cgrp i=
d.
> There's really nothing that says the cgrp is on a block device that is sc=
si
> or is nvme.  It should work on devices regardless of their underlying
> protocol type. Which then left the question - where to place such an
> attribute.
> =

> Given this is an "fc service" and as we knew the transport will be merged
> eventually we picked to put it under /sys/class/fc point which is where we
> expect to root the common transport. =


Ah ok, I think I confused it with the already existing
`/sys/class/fc_host`/`/sys/class/fc_transport/`/..., but thats something
different. Yeah, having some common ancestor makes sense, if the HBA
offers multiple ULPs.

> This class point happens to be owned/created by the nvme fc host code
> for requesting nve-fc rediscovery events. It is odd that it creates a
> requirement to load the nvme-fc transport in order to set values for
> scsi fc devices, but we deemed it acceptable.

Well, I mean, right now I don't have a immediate need for zfcp in this
regard, so I don't want to blow this out of proportions. But like I
said, we (zfcp) don't have a NVMe personality, so we never hook into
NVMe-FC.

> Guess we need to get going on that merged transport...

Feel free to reach out, if there is anything coming up.


-- =

Best Regards, Benjamin Block  / Linux on IBM Z Kernel Development / IBM Sys=
tems
IBM Deutschland Research & Development GmbH    /    https://www.ibm.com/pri=
vacy
Vorsitz. AufsR.: Gregor Pillen         /        Gesch=E4ftsf=FChrung: Dirk =
Wittkopp
Sitz der Gesellschaft: B=F6blingen / Registergericht: AmtsG Stuttgart, HRB =
243294

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
