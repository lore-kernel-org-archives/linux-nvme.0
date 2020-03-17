Return-Path: <SRS0=JSXe=5C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50285C10F29
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2020 13:17:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 052F120724
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2020 13:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SYmHI+Qa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 052F120724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zurich.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-Id:References:MIME-Version:Date
	:To:From:Subject:In-Reply-To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tR/Fb9Df6VDN1NF1gCwUT3c8388697fbpILlYr0a/gY=; b=SYmHI+QaQwewmt
	aK2yjzB7DN0QFt/OmTsx5oi48WkzqLXr39bTIyKeoveHNAnSexFoVozehTOIw1FAILmGYrbiA4UJ2
	l2+fl700DFNxm0WrgyCOtBR7SpD8/PBl+JO9Hf1trXpko7RGi11APfyxvt/VoFxDlwJB74pEvhNJO
	4G8B/96Nnj5qT70J9l9jMg+N1G6p+1TzMdbbSghHBQoTIuHG/VEbYQnYrzDMjAzSiTkKvN+mdeKbE
	Bw8XR4u/+9MNWzkEE1fZFz1LIepjVrt0Ox0/GzRaKfgoSpS5NMBjAUM812ucywVyXtCH5ZFX1JMYx
	Tq3ckK9kxDJeg/x1y3Cw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jEC5y-0005xg-5O; Tue, 17 Mar 2020 13:17:22 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jEC5v-0005ww-Mi
 for linux-nvme@lists.infradead.org; Tue, 17 Mar 2020 13:17:21 +0000
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02HD2tmc106818
 for <linux-nvme@lists.infradead.org>; Tue, 17 Mar 2020 09:17:16 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com
 [158.85.210.113])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ytakdrbvt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Tue, 17 Mar 2020 09:17:16 -0400
Received: from localhost
 by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
 for <linux-nvme@lists.infradead.org> from <BMT@zurich.ibm.com>;
 Tue, 17 Mar 2020 13:17:16 -0000
Received: from us1b3-smtp04.a3dr.sjc01.isc4sb.com (10.122.203.161)
 by smtp.notes.na.collabserv.com (10.122.47.56) with
 smtp.notes.na.collabserv.com ESMTP; Tue, 17 Mar 2020 13:17:10 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
 by us1b3-smtp04.a3dr.sjc01.isc4sb.com
 with ESMTP id 2020031713170927-504107 ;
 Tue, 17 Mar 2020 13:17:09 +0000 
In-Reply-To: <20200317124533.GB12316@lst.de>
Subject: Re: Re: broken CRCs at NVMeF target with SIW & NVMe/TCP transports
From: "Bernard Metzler" <BMT@zurich.ibm.com>
To: "Christoph Hellwig" <hch@lst.de>
Date: Tue, 17 Mar 2020 13:17:09 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20200317124533.GB12316@lst.de>,
 <20200316162008.GA7001@chelsio.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP62 November 04, 2019 at 09:47
X-KeepSent: ED8F9821:7106FFC4-0025852E:00476D8D;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 34119
X-TNEFEvaluated: 1
x-cbid: 20031713-7691-0000-0000-000001A02844
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.000001
X-IBM-SpamModules-Versions: BY=3.00012764; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000293; SDB=6.01348975; UDB=6.00719454; IPR=6.01131383; 
 MB=3.00031264; MTD=3.00000008; XFM=3.00000015; UTC=2020-03-17 13:17:15
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2020-03-17 10:34:30 - 6.00011129
x-cbparentid: 20031713-7692-0000-0000-000018A22AC9
Message-Id: <OFED8F9821.7106FFC4-ON0025852E.00476D8D-0025852E.0048FB79@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-17_04:2020-03-17,
 2020-03-17 signatures=0
X-Proofpoint-Spam-Reason: safe
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200317_061719_749300_85E30B8A 
X-CRM114-Status: GOOD (  10.24  )
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
Cc: sagi@grimberg.me, linux-rdma@vger.kernel.org,
 Potnuri Bharat Teja <bharat@chelsio.com>, Nirranjan
 Kirubaharan <nirranjan@chelsio.com>, linux-nvme@lists.infradead.org,
 Krishnamraju Eraparaju <krishna2@chelsio.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

-----"Christoph Hellwig" <hch@lst.de> wrote: -----

>To: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
>From: "Christoph Hellwig" <hch@lst.de>
>Date: 03/17/2020 01:45PM
>Cc: "Bernard Metzler" <BMT@zurich.ibm.com>, sagi@grimberg.me,
>hch@lst.de, linux-nvme@lists.infradead.org,
>linux-rdma@vger.kernel.org, "Nirranjan Kirubaharan"
><nirranjan@chelsio.com>, "Potnuri Bharat Teja" <bharat@chelsio.com>
>Subject: [EXTERNAL] Re: broken CRCs at NVMeF target with SIW &
>NVMe/TCP transports
>
>On Mon, Mar 16, 2020 at 09:50:10PM +0530, Krishnamraju Eraparaju
>wrote:
>> 
>> I'm seeing broken CRCs at NVMeF target while running the below
>program
>> at host. Here RDMA transport is SoftiWARP, but I'm also seeing the
>> same issue with NVMe/TCP aswell.
>> 
>> It appears to me that the same buffer is being rewritten by the
>> application/ULP before getting the completion for the previous
>requests.
>> getting the completion for the previous requests. HW based
>> HW based trasports(like iw_cxgb4) are not showing this issue
>because
>> they copy/DMA and then compute the CRC on copied buffer.
>
>For TCP we can set BDI_CAP_STABLE_WRITES.  For RDMA I don't think
>that

Hmm, can you elaborate a little more here? I see that flag being
set for data digest enabled (e.g. nvme/host/core.c:nvme_alloc_ns()).
But enabling that data digest CRC is exactly when the NVMeF/TCP
target detects the issue and drops the frame and disconnects...?

The current situation for NVMeF/TCP is that the data digest is
not enabled per default and buffer changes are not detected then.

Krishna first detected it with using siw against hardware iWarp
target, since the CRC gets negotiated then.

>is a good idea as pretty much all RDMA block drivers rely on the
>DMA behavior above.  The answer is to bounce buffer the data in
>SoftiWARP / SoftRoCE.
>
>
Another extra copy of user data isn't really charming. Can we
somehow let the ULP have its fingers crossed until the buffer
got transferred, as signaled back?

Best,
Bernard.


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
