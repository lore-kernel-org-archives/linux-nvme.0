Return-Path: <SRS0=/AMA=FT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MISSING_HEADERS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41123C4361B
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Dec 2020 12:22:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E227822475
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Dec 2020 12:22:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E227822475
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zurich.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:References:MIME-Version:Date:From:Subject
	:In-Reply-To:Reply-To:To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tqDS+oI0+DG5kzBu+oFcHuXVZnrf5n2z69ILrQprKAY=; b=OT+M0Wim4FGeDKJmM5mUm+gnO
	KZoh64LDOdvKDNALjo6gmF/vkZ64VBgIaXNnD525bv25XO6q4RnVaUnHLAbtuFoVxKNuJ2xyItdjI
	3fI4itrOmu4sYx/fhvd5WLfhk6+qYAgLgHux9WviZOECdGnS74u2hzO/XtOxu8zdpYX2S9opA1uHl
	PbHZfcAvJaC/Xzfu6QWvVqSxCy/gIAJh3XgxrYZqvlHDx0d8iXaQTKv0eygI7EiFEQ6PedO/8b9sM
	KTL5htVBKfKUxUWKE0IUhXECWYSbSmdjvYzP/kuya4F5HMTAk91GRhsR6jFJT7AbUwlP7NtGmr0o2
	2HkFG/+Yg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kp9LG-0003fD-MM; Tue, 15 Dec 2020 12:22:10 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kp9LE-0003eM-Bn
 for linux-nvme@lists.infradead.org; Tue, 15 Dec 2020 12:22:09 +0000
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0BFCD01V075585
 for <linux-nvme@lists.infradead.org>; Tue, 15 Dec 2020 07:22:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=in-reply-to : subject :
 from : cc : date : mime-version : references : content-transfer-encoding :
 content-type : message-id; s=pp1;
 bh=2OVg8XNwdODLadDwrD3q/95wbHKtxEarAkpv7VloZ/E=;
 b=LVehIHyPqKjrFhNimBj+PU+n6/b9jbrJL9shH5PFNd3GxAD/fteBJqh03IDaYG2XFI9g
 L2sv9K/dyHsW8JZtDNS9VxB5U9mUJ55JLaYhBM9iN7nMGB6cdXjq1i/uDnlkRGphl6cf
 8/WHet/q4oNHCRyhxGQ41Aa3Xkuq73UjlNXn3c30Tqin32Vy+RllaIaXSVjBNk6lbQwC
 DoP/ARnRZrUV4223SR26f3/Za2v/OW8PwHztaxWmMBKkkyAh4TflriovP9IxeyLJzUd2
 8WJHTL2+GQQ0y5gxQQYDOh5SEckNPqL4FgmQPTNKakvZVvEz38SjbTmlTgwJ+ADKIbxP VQ== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com
 [158.85.210.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 35evxsr7xk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Tue, 15 Dec 2020 07:22:06 -0500
Received: from localhost
 by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
 for <linux-nvme@lists.infradead.org> from <BMT@zurich.ibm.com>;
 Tue, 15 Dec 2020 12:22:06 -0000
Received: from us1b3-smtp02.a3dr.sjc01.isc4sb.com (10.122.7.175)
 by smtp.notes.na.collabserv.com (10.122.47.39) with
 smtp.notes.na.collabserv.com ESMTP; Tue, 15 Dec 2020 12:22:05 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
 by us1b3-smtp02.a3dr.sjc01.isc4sb.com
 with ESMTP id 2020121512220488-323448 ;
 Tue, 15 Dec 2020 12:22:04 +0000 
In-Reply-To: <20201215121633.3838-1-bmt@zurich.ibm.com>
Subject: Re: [PATCH] RDMA/siw: Fix handling of zero-sized Read and Receive
 Queues.
From: "Bernard Metzler" <BMT@zurich.ibm.com>
Date: Tue, 15 Dec 2020 12:22:04 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20201215121633.3838-1-bmt@zurich.ibm.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP65 April 15, 2020 at 09:48
X-KeepSent: 54C97002:D888D372-0025863F:0043F03C;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 26779
X-TNEFEvaluated: 1
x-cbid: 20121512-6283-0000-0000-000004290DF7
X-IBM-SpamModules-Scores: BY=0.000275; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.001046
X-IBM-SpamModules-Versions: BY=3.00014378; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000295; SDB=6.01478445; UDB=6.00796571; IPR=6.01261051; 
 MB=3.00035507; MTD=3.00000008; XFM=3.00000015; UTC=2020-12-15 12:22:05
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2020-12-14 14:38:41 - 6.00012140
x-cbparentid: 20121512-6284-0000-0000-000003780E4D
Message-Id: <OF54C97002.D888D372-ON0025863F.0043F03C-0025863F.0043F045@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343, 18.0.737
 definitions=2020-12-15_10:2020-12-14,
 2020-12-15 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201215_072208_522480_9E248821 
X-CRM114-Status: GOOD (  12.28  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Bernard Metzler <BMT@zurich.ibm.com>, "yi.zhang" <yi.zhang@redhat.com>,
 kamalheib1 <kamalheib1@gmail.com>, linux-nvme <linux-nvme@lists.infradead.org>,
 jgg <jgg@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

please forget last email. I had wrong target email list.
sorry about that stupidity. will resend.

Bernard.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
