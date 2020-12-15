Return-Path: <SRS0=/AMA=FT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B4AC4361B
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Dec 2020 19:35:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B01C22B2D
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Dec 2020 19:35:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B01C22B2D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zurich.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:References:MIME-Version:Date:To:From:
	Subject:In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QZbzfdk6EKKCw3magKrko1ot/JaL47HsPsuCPbMZFfE=; b=MlSpdhHjbYrqMTX0vB+x6wcfn
	TXfkl11vaMGpZ1NBy0HkaEwLgiAVqW+GyVrFBSXhHvYa9/689pkAUTKSK5/nboUTWyVXJ8hUtlaja
	Toe3rBACRrNKfd34QYRzjKJOPiwk8fKHsCF0tOOLif+TlDl3gmuIuKnNKGnMvYiMddNtRls//W3pe
	NhZHEIkARC0C1C4HJeuED1rCFXrcmmy2XQ2AKl/bclME0fkbXY5PdcUuLrgdHrjvad4Uky8KZi73k
	Z5a5im/zbsoIQd2jeYRlY8zCApb4LUATeu83utcUHwcoDNmTZgltsQbKEkyLTkoHqXC9owfTJSph3
	JLU9R9ANg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kpG6r-0003EH-95; Tue, 15 Dec 2020 19:35:45 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kpG6o-0003Dj-1X
 for linux-nvme@lists.infradead.org; Tue, 15 Dec 2020 19:35:43 +0000
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0BFJX1du169026
 for <linux-nvme@lists.infradead.org>; Tue, 15 Dec 2020 14:35:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=in-reply-to : subject :
 from : to : cc : date : mime-version : references :
 content-transfer-encoding : content-type : message-id; s=pp1;
 bh=UKzW9BqnXXwM+6ii7AqIUISXKtJ9gr8ZMMNqd8HV9hQ=;
 b=H9g1RiMaJWI2UdC9yJCq6n4AYC0sHznVnKq645FQckV65lwktKpuw/b/gkGtQwWz/Qrq
 gG9YVayTolaud4RePhO7PWWjRngRDwPVToxsuWan2mR0lOBN3hB8oR9g5f0VE8Do831r
 QlnN3J9JYnlx8rajAB+yMc6buPoKFfovLLSF6ctkxP0MahCY7oDLAB9y6URXXnjwZxeJ
 ykEg7ngV0AkcxLkhhi8Whk/P/gclZ2aAQbY2cuaODOSWqlyqz4uXwjIeAfMCczULTKUo
 iIsaivR+/pPqGDYzb1izv2Hrht1h9n66SUR/1Ed4NcLMAsRXbaP7Jg8yJasgRZFOyKw9 XA== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com
 [158.85.210.119])
 by mx0b-001b2d01.pphosted.com with ESMTP id 35f093rp9u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Tue, 15 Dec 2020 14:35:39 -0500
Received: from localhost
 by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
 for <linux-nvme@lists.infradead.org> from <BMT@zurich.ibm.com>;
 Tue, 15 Dec 2020 19:35:38 -0000
Received: from us1b3-smtp01.a3dr.sjc01.isc4sb.com (10.122.7.174)
 by smtp.notes.na.collabserv.com (10.122.182.123) with
 smtp.notes.na.collabserv.com ESMTP; Tue, 15 Dec 2020 19:35:36 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
 by us1b3-smtp01.a3dr.sjc01.isc4sb.com
 with ESMTP id 2020121519353576-694740 ;
 Tue, 15 Dec 2020 19:35:35 +0000 
In-Reply-To: <20201215174717.GZ552508@nvidia.com>
Subject: Re: Re: [PATCH] RDMA/siw: Fix handling of zero-sized Read and Receive
 Queues.
From: "Bernard Metzler" <BMT@zurich.ibm.com>
To: "Jason Gunthorpe" <jgg@nvidia.com>
Date: Tue, 15 Dec 2020 19:35:35 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20201215174717.GZ552508@nvidia.com>,
 <20201215122306.3886-1-bmt@zurich.ibm.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP65 April 15, 2020 at 09:48
X-KeepSent: 33B51ADA:D0F7149E-0025863F:00628A52;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 11451
X-TNEFEvaluated: 1
x-cbid: 20121519-3975-0000-0000-0000036D5596
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.000684
X-IBM-SpamModules-Versions: BY=3.00014381; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000295; SDB=6.01478589; UDB=6.00796658; IPR=6.01261195; 
 MB=3.00035512; MTD=3.00000008; XFM=3.00000015; UTC=2020-12-15 19:35:37
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2020-12-15 17:42:41 - 6.00012142
x-cbparentid: 20121519-3976-0000-0000-000077248F3A
Message-Id: <OF33B51ADA.D0F7149E-ON0025863F.00628A52-0025863F.006BA0D9@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343, 18.0.737
 definitions=2020-12-15_12:2020-12-15,
 2020-12-15 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201215_143542_411734_7794E626 
X-CRM114-Status: GOOD (  17.05  )
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
Cc: linux-rdma@vger.kernel.org, yi.zhang@redhat.com, kamalheib1@gmail.com,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

-----"Jason Gunthorpe" <jgg@nvidia.com> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>
>From: "Jason Gunthorpe" <jgg@nvidia.com>
>Date: 12/15/2020 06:48PM
>Cc: <linux-rdma@vger.kernel.org>, <kamalheib1@gmail.com>,
><yi.zhang@redhat.com>, <linux-nvme@lists.infradead.org>
>Subject: [EXTERNAL] Re: [PATCH] RDMA/siw: Fix handling of zero-sized
>Read and Receive Queues.
>
>On Tue, Dec 15, 2020 at 01:23:06PM +0100, Bernard Metzler wrote:
>> During connection setup, the application may choose to zero-size
>> inbound and outbound READ queues, as well as the Receive queue.
>> This patch fixes handling of zero-sized queues.
>
>This fixes a crasher? Copy the fixes line and oops from  Kamal?
>
>Jason
>
Yes. it does. Will resend with a small change fixing
an uninitialized variable I just invented with the patch (uuuhh).

I will attach Kamal's oops report, but his fix was
blocking allowed application behavior (setting some queue
sizes to zero). The intention of my patch is to fix siw
to handle that application behavior correctly. So the fixes
lines will be different.
 

Thanks,
Bernard.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
