Return-Path: <SRS0=mUlG=GL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B49C433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Jan 2021 10:51:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A21AD238E2
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Jan 2021 10:51:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A21AD238E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zurich.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:Message-Id:References:MIME-Version:Date:To:
	From:In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7T0/7FutVDuTQPP056Ol7Yi1ugiMJHaE6iiIkGiXkGs=; b=u4W2fce03pz9LpZbejOp9gFEf
	tTTXlvEKfCJo+U7JsWT3c+x2uWfrd1pG+Qn6DfxFIfIIjvb8w/E1yVCPOeQZODlrzCzO9z9qCVkZi
	/QCQ58lQZCDvEu4lFxqtdsI1udDAAc2TSiUsD/Z3CKRh1L2s+SkeUhQ4hwOikBJC5wUtZmJ+7zl/r
	z2UWHf5We9lS7sxlnE1j4CnFV+3vWnPJyCFhM/mBccCLQtm+PhV12Z6bFMiqI7nZzUdc6UOH5XXTp
	jV3rmRPK6NCatelWzjkbVv3h5VvfPYkZcC0LMbDaWAJBkErSH67Us8dYDBwcvqZKFNIz1H3q09CFB
	ySpiO+m7g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kxpMl-0006zH-3j; Fri, 08 Jan 2021 10:51:35 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kxpMh-0006ux-1J
 for linux-nvme@lists.infradead.org; Fri, 08 Jan 2021 10:51:32 +0000
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 108AVmUA130693
 for <linux-nvme@lists.infradead.org>; Fri, 8 Jan 2021 05:51:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=in-reply-to : from : to
 : cc : date : mime-version : references : content-transfer-encoding :
 content-type : message-id : subject; s=pp1;
 bh=AnTn86ct4P6jYE5sNemxq4rSOcR9qLhTA+nAmJoSdQc=;
 b=ARF/zzhWlnnf9+ZbVJpMAESZEiYGzTmRrzorRWVkW7r0i3A9GDB6QwggOqvRBHb94J/P
 ocztelQU5CFYrb6eCSI0NQ3ohYN0pUe7xmHcNiv0PEwYhiMIU3Jff1vIMW5Plli5vOjj
 Zb7fyC350thGlR1wGVQ/SNVRkrodizHwy5OQ3g9hbZ+eubVeRn/PPfeL6D99Ng6jKSqu
 yih4/LPHTrJ9KNAz6BDHUZhxtpnRjGsps4p3wgZW3JO0euHQCFnJkdxcaXuD/MZ/nhPk
 U60gdRsPUCMK5qvnwWzBGJhy67YUOuP1x/eLvI/JI5l1WbxVPsGNniux61cC6iJK7Lsk Yw== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com
 [192.155.248.67])
 by mx0b-001b2d01.pphosted.com with ESMTP id 35xn26sm8f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Fri, 08 Jan 2021 05:51:28 -0500
Received: from localhost
 by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
 for <linux-nvme@lists.infradead.org> from <BMT@zurich.ibm.com>;
 Fri, 8 Jan 2021 10:51:27 -0000
Received: from us1a3-smtp05.a3.dal06.isc4sb.com (10.146.71.159)
 by smtp.notes.na.collabserv.com (10.106.227.16) with
 smtp.notes.na.collabserv.com ESMTP; Fri, 8 Jan 2021 10:51:24 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
 by us1a3-smtp05.a3.dal06.isc4sb.com
 with ESMTP id 2021010810512342-244263 ;
 Fri, 8 Jan 2021 10:51:23 +0000 
In-Reply-To: <20210107193838.GA921419@nvidia.com>
From: "Bernard Metzler" <BMT@zurich.ibm.com>
To: "Jason Gunthorpe" <jgg@nvidia.com>
Date: Fri, 8 Jan 2021 10:51:23 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20210107193838.GA921419@nvidia.com>,
 <20201216110000.611-1-bmt@zurich.ibm.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP65 April 15, 2020 at 09:48
X-LLNOutbound: False
X-Disclaimed: 55511
X-TNEFEvaluated: 1
x-cbid: 21010810-7279-0000-0000-0000046701B5
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.000072
X-IBM-SpamModules-Versions: BY=3.00014517; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000295; SDB=6.01489919; UDB=6.00803418; IPR=6.01272489; 
 MB=3.00035770; MTD=3.00000008; XFM=3.00000015; UTC=2021-01-08 10:51:25
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2021-01-07 20:44:03 - 6.00012203
x-cbparentid: 21010810-7280-0000-0000-00009B8201AB
Message-Id: <OF12D28384.4EE6A087-ON00258657.003BA30F-00258657.003BA319@notes.na.collabserv.com>
Subject: RE: [PATCH v3] RDMA/siw: Fix handling of zero-sized Read and Receive
 Queues.
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343, 18.0.737
 definitions=2021-01-08_06:2021-01-07,
 2021-01-08 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210108_055131_504971_5716BBA9 
X-CRM114-Status: GOOD (  14.91  )
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
Cc: Yi Zhang <yi.zhang@redhat.com>, kernel test
 robot <lkp@intel.com>, leon@kernel.org, linux-rdma@vger.kernel.org,
 linux-nvme@lists.infradead.org, Kamal Heib <kamalheib1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

-----"Jason Gunthorpe" <jgg@nvidia.com> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>
>From: "Jason Gunthorpe" <jgg@nvidia.com>
>Date: 01/07/2021 08:40PM
>Cc: <linux-rdma@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
><leon@kernel.org>, "Kamal Heib" <kamalheib1@gmail.com>, "Yi Zhang"
><yi.zhang@redhat.com>, "kernel test robot" <lkp@intel.com>
>Subject: [EXTERNAL] Re: [PATCH v3] RDMA/siw: Fix handling of
>zero-sized Read and Receive Queues.
>
>On Wed, Dec 16, 2020 at 12:00:00PM +0100, Bernard Metzler wrote:
>> @@ -933,6 +937,7 @@ int siw_activate_tx(struct siw_qp *qp)
>>  
>>  		goto out;
>>  	}
>> +no_irq:
>>  	sqe = sq_get_next(qp);
>>  	if (sqe) {
>
>Can you please arrange this without the spaghetti goto's? goto is ok
>for error unwind at the tail of the function, but should not be used
>willy nilly. Move some of this into functions, use normal if
>statements, etc.
>
Okay. I tried to minimize changes but I now think
you are right - it's time to cleanup before it
gets too burlesque.

Will send a v4.

Thanks
Bernard.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
