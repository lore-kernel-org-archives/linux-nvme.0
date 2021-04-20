Return-Path: <SRS0=/SuC=JR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B12C433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 11:10:14 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 074AC61354
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 11:10:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 074AC61354
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=GVRew/NJ6XKtWPyR2RLOJgWY+E2gXIDaU7ELs+x7quU=; b=BqCvZC2QsgK+ktebG8ItVCrUP
	p5RFI+HGkIYvBAH6JUj6ypLFQrt+4dI2yGNpvZPZ8jYXuiaBom+JHTcQOdcoxL/rYMwBMplDlAn05
	SECgvXM7NV+qriYpmrrkd3f3IRiEyP5pVUXW2hA2tpkZmwTepRbiPoUny0G4wXwDAmr/t95hhL8Cs
	GLpbzJgqMrlUTf1t6r/bjjWn6Nuysmi5VcIKvygruX19idKWfFNL8iJc8n3Tfl7o85IEgXgJCzA7a
	afVd5ns/LNy5JyUwdkGmIJnf5FHVrUVkXiSR4/LgIjvoj8BFCznwIUo/Ot85hN/d08aaS7fwd1IMW
	JLBbK2Jiw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYoG1-00BwAh-1z; Tue, 20 Apr 2021 11:09:29 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYoFy-00BwAJ-H3
 for linux-nvme@desiato.infradead.org; Tue, 20 Apr 2021 11:09:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Sender:In-Reply-To:Content-Type:References:
 Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
 bh=ZhWvtftjOrH2GeCDWVLlc2mk4GkaRut3/FuTuUHI3Nc=; b=tPuDTyrU9ElXBtPOj+4BKPXz/
 rWEXH0V47qjuSKFoq7h1RcXIWk1AOhVRd8YAsD6kcOmtET4RzPmQfkTfL/ePoV6tnTLKLiO+y4uv/
 Mc+sBxsViYz6JYmgBKo9qNG6PqJEW/WNR9nfUNZDF75yq6wi7PEqHQ9sjvS2X5VyzeddHW6QpIh6Y
 kXjpNvFkfLCrT+zjsU+FZbW4Me9g8OfR63pqKJo1bSxCjNjbUzc9O3Eebjt1UJyv7quoAqLzvtE2U
 yoGdw2LWAKrIlOK/wcHcVgrp1n/PESVVZ3OPc/F+4OTvhL/DblUTYNYjfcvXVN3wtW+vnaL95Wh7b
 eZ0IndwKg==;
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYoFt-00C3Oo-BW
 for linux-nvme@lists.infradead.org; Tue, 20 Apr 2021 11:09:25 +0000
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 13KB3aO8104884; Tue, 20 Apr 2021 07:09:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to : sender :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ZhWvtftjOrH2GeCDWVLlc2mk4GkaRut3/FuTuUHI3Nc=;
 b=nWAJj74eFZDjS3CjkAO/VEFLcS7IihY+A2kNfHNRsPRJJQ+BcCaLyZmZ4EHYukD825qx
 xwa3jzWnUGtNAsjMQUOE9nS5rgjaFfvBmFaWF72/4NCXV3/f/97SryqtESBwAYU70uAU
 6/xTOwicG/eEYcAZmV0QpLNgbCSSJJeot4DDptzvZscFoCsiihjv9vx4zEg0nbhOvgfC
 LTQW0nYGOVRFVli/spfjekerxnmtt5EkuxOnwkfi71rpHgitRD/D5n6g5D0uFblqrumq
 SwNnEA0IFupVVn2yoPsN4rT0LlA++VVcRoQ8RGHQ2J9Hg0WpmpWPz+lmBopFPWjagmxL 5w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 381vu6244s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Apr 2021 07:09:16 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13KB52oL112340;
 Tue, 20 Apr 2021 07:09:15 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 381vu6241s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Apr 2021 07:09:15 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
 by ppma03fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13KB7r62023998;
 Tue, 20 Apr 2021 11:09:12 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma03fra.de.ibm.com with ESMTP id 37yqa88wk4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Apr 2021 11:09:11 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 13KB8jHr37552580
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Apr 2021 11:08:45 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BEE3211C058;
 Tue, 20 Apr 2021 11:09:08 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC20811C04A;
 Tue, 20 Apr 2021 11:09:08 +0000 (GMT)
Received: from t480-pf1aa2c2.fritz.box (unknown [9.145.82.95])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Tue, 20 Apr 2021 11:09:08 +0000 (GMT)
Received: from bblock by t480-pf1aa2c2.fritz.box with local (Exim 4.94)
 (envelope-from <bblock@linux.ibm.com>)
 id 1lYoFg-003KHD-4o; Tue, 20 Apr 2021 13:09:08 +0200
Date: Tue, 20 Apr 2021 13:09:08 +0200
From: Benjamin Block <bblock@linux.ibm.com>
To: Muneendra Kumar M <muneendra.kumar@broadcom.com>
Cc: Benjamin Block <lkml@mageta.org>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, tj@kernel.org,
 linux-nvme@lists.infradead.org, hare@suse.de, jsmart2021@gmail.com,
 emilne@redhat.com, mkumar@redhat.com, Steffen Maier <maier@linux.ibm.com>
Subject: Re: [PATCH v9 03/13] nvme: Added a newsysfs attribute appid_store
Message-ID: <YH62VB+SVfnG+GoI@t480-pf1aa2c2.linux.ibm.com>
References: <1617750397-26466-1-git-send-email-muneendra.kumar@broadcom.com>
 <1617750397-26466-4-git-send-email-muneendra.kumar@broadcom.com>
 <YHxRK33kf7OSVlxf@chlorum.ategam.org>
 <a6497bd924795a5a9279b893b0d83baf@mail.gmail.com>
Content-Disposition: inline
In-Reply-To: <a6497bd924795a5a9279b893b0d83baf@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zcptgf3ihHXFLAETO78_af4mW8pN6rea
X-Proofpoint-GUID: 8hHrwkPl_tvoHfnwBMJtC7wYNo-cY0e1
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-04-20_02:2021-04-19,
 2021-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 clxscore=1011 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104200085
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210420_040921_428835_AD258E66 
X-CRM114-Status: GOOD (  25.09  )
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

On Tue, Apr 20, 2021 at 12:24:41PM +0530, Muneendra Kumar M wrote:
> Hi Benjamin,
> =

> >> ---
> >>  drivers/nvme/host/fc.c | 73
> >> +++++++++++++++++++++++++++++++++++++++++-
> >>  1 file changed, 72 insertions(+), 1 deletion(-)
> =

> > Hmm, I wonder why only NVMe-FC? Or is this just for the moment? We also
> > have the FC transport class for SCSI; I assume this could feed the same
> > IDs into the LLDs.
>
> At present it supports only for SCSI-FC .

It does? By adding it to the implementation under `drivers/nvme/host/`?
I am confused.

I see it adds the sysfs-attribute to `nvme_fc_attrs`, how would that be
added to a FC Host that does not have a NVMe 'personality'? I was
assuming this only ever appears under `/sys/class/fc` if the LLDD
registers itself with the NVMe subsystem (presumably via
`nvme_fc_register_localport()`).

zFCP, for example, does not do that, but we do implement the SCSI FC
transport class in `drivers/scsi/scsi_transport_fc.c`.

> In future we are adding the support for NVMe-FC
> But to make it generic and avoid duplication we added this under
> /sys/class/fc .
> =

> Ewan was mentioning that at some point there is a plan  to decouple
> the FC transport somewhat so that there is a layer that represents the
> FC stuff regardless of the FC4 type (SCSI, NVMe). When we have this
> layer we can move the things accordingly.
> =


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
