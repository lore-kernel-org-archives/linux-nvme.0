Return-Path: <SRS0=EcNd=W3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C36AC3A5A6
	for <linux-nvme@archiver.kernel.org>; Sat, 31 Aug 2019 18:53:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F33C21874
	for <linux-nvme@archiver.kernel.org>; Sat, 31 Aug 2019 18:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JLv0U25Y";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dell.com header.i=@dell.com header.b="t2RPf/iv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=emc.com header.i=@emc.com header.b="UswIHPsu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F33C21874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=p9npix2/EevWzZYqF/F5PyftLXRfq7GLPXWE+NHgtCs=; b=JLv0U25Y2ZWzO4
	U8gBZ1PchR3s3sh0q6WEWcpnry47Dnv96Fz/9cY5p41BYwPtrZs7+rCgaB1PXTzLtFTotQ0ejE9TR
	Oc/Ex76xJKTRoolRh/CdR7WKgAz4q+nHJbO7g2BlC7aoMrfl4uP5alCv4hdzmd/rOg37RnGFVhNya
	RCH+pEs4oUiDr7Iif31ma0unnnjwNspEUKWRb8xTGVpxcSH5A5f1JzGW396Ctp5QnDHkLhr0uusxO
	UKYXG2tNfIiEu37fRED1PqHWbpG3Njo48es5JGROKeWCX1ykXz22+WOltonHju2RvhYU1CJmeMmrD
	XaCTNJ4uL5nakcrq3pJw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i48VI-0001zW-2q; Sat, 31 Aug 2019 18:53:40 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i48VF-0001ys-KP
 for linux-nvme@lists.infradead.org; Sat, 31 Aug 2019 18:53:39 +0000
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 x7VIngOq006333; Sat, 31 Aug 2019 14:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=FukuB4t1mI8Ff6k/vqNEdtRHFkP9FEXD7185oVy4rHM=;
 b=t2RPf/ivUgxibAFz6yu0fb8gBtFDBjR3qS+1U84FQ0ScCx4xNjaiYWZS74WyzyZcsGfw
 k0ehB/8+Uiq3G4qwzSfhD2f4Qg3cFzX9F8WYWf0ALQ272DaVxC2UZ598jxDhVR9ITsG3
 VTy3w17KhJDOnYh8LSTPi8f5+ZHcO7TIn5cXsQjiEUvY+7TOIGQEZmQ/tpPrlSXNoNLX
 LxA8Z+sPTcYSC9uBRZLbO8YIi5TunCE7yJoXfVtRZp62mjoB9l3Z47u4+gnSSS6Fg6wI
 kspMZuOkZXdrO3k6mcnaoa1hNcFRUgCc1hOoN91mKHWLoAcn4B6o5H8yT+d139SscCX4 Wg== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com with ESMTP id 2uqm1xh7qe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 31 Aug 2019 14:52:56 -0400
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 x7VIqtlL036554; Sat, 31 Aug 2019 14:52:56 -0400
Received: from mailuogwdur.emc.com (mailuogwdur.emc.com [128.221.224.79])
 by mx0a-00154901.pphosted.com with ESMTP id 2uqn56cgyd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 31 Aug 2019 14:52:56 -0400
Received: from maildlpprd54.lss.emc.com (maildlpprd54.lss.emc.com
 [10.106.48.158])
 by mailuogwprd52.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with
 ESMTP id x7VIqjH3028867
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 31 Aug 2019 14:52:55 -0400
X-DKIM: OpenDKIM Filter v2.4.3 mailuogwprd52.lss.emc.com x7VIqjH3028867
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=emc.com; s=jan2013;
 t=1567277575; bh=gJfUMLrgRdHOlnY3CNViK5Pqo0M=;
 h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:MIME-Version;
 b=UswIHPsuugp0InnZIbzOPpSSrWm8rd0tVroI2Pcc5/VjFsbYGjkNN51wh6sjLFJ0v
 LTjN1T5SX9hGgJzyE0WOo7o+gf7E5W8lHt2Y2K84rsGRVVBD6JioQyPF8uS4Am7e8u
 EkNzePhPYBg2SGwzuei9LnAHZY5yTHqBiGMx+sRA=
Received: from mailusrhubprd52.lss.emc.com (mailusrhubprd52.lss.emc.com
 [10.106.48.25]) by maildlpprd54.lss.emc.com (RSA Interceptor);
 Sat, 31 Aug 2019 14:51:36 -0400
Received: from MXHUB315.corp.emc.com (MXHUB315.corp.emc.com [10.146.3.93])
 by mailusrhubprd52.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with
 ESMTP id x7VIpaQq016635
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=FAIL);
 Sat, 31 Aug 2019 14:51:36 -0400
Received: from MX302CL04.corp.emc.com ([fe80::18ad:6300:21eb:2b39]) by
 MXHUB315.corp.emc.com ([10.146.3.93]) with mapi id 14.03.0439.000; Sat, 31
 Aug 2019 14:51:35 -0400
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@infradead.org>
Subject: RE: [PATCH] nvme/target/admin-cmd.c: Fix a bug in
 'nvmet_execute_get_log_page_error'
Thread-Topic: [PATCH] nvme/target/admin-cmd.c: Fix a bug in
 'nvmet_execute_get_log_page_error'
Thread-Index: AQHVV+rhGH+z1ZJ98kqkpi+ZAD2lWKcGiGKAgAA23nCAAHpT0IAEh6nQgAcHF4CAAuHO0A==
Date: Sat, 31 Aug 2019 18:51:34 +0000
Message-ID: <8739B0CD2FC2DC40AF691A1CCBB989603460A6C1@MX302CL04.corp.emc.com>
References: <20190821063711.1252-1-amit.engel@dell.com>
 <20190821234559.GB27887@infradead.org>
 <8739B0CD2FC2DC40AF691A1CCBB9896034606D14@MX302CL04.corp.emc.com>
 <8739B0CD2FC2DC40AF691A1CCBB9896034606E73@MX302CL04.corp.emc.com>
 <8739B0CD2FC2DC40AF691A1CCBB989603460714F@MX302CL04.corp.emc.com>
 <442e4fd6-0288-8da4-fec4-3e5ae6df5dae@grimberg.me>
In-Reply-To: <442e4fd6-0288-8da4-fec4-3e5ae6df5dae@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Amit.Engel@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-08-31T18:51:32.7084995Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual;
 aiplabel=External Public
x-originating-ip: [10.76.41.142]
MIME-Version: 1.0
X-Sentrion-Hostname: mailusrhubprd52.lss.emc.com
X-RSA-Classifications: public
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-08-31_07:2019-08-29,2019-08-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0
 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 clxscore=1015 mlxlogscore=933 impostorscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1908310218
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 impostorscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1908310217
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190831_115337_830756_E9942A35 
X-CRM114-Status: GOOD (  13.33  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Sagi,

I updated the commit message per you ask.

Thanks!
Amit

-----Original Message-----
From: Sagi Grimberg <sagi@grimberg.me> 
Sent: Thursday, August 29, 2019 9:50 PM
To: Engel, Amit; Christoph Hellwig
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme/target/admin-cmd.c: Fix a bug in 'nvmet_execute_get_log_page_error'


[EXTERNAL EMAIL] 


> Hi, Any update regarding my below fix proposal?

The patch is fine, but can you please update the commit message,

First: the title should be:
nvmet: fix a wrong error status returned in error log page

And the message body needs to be:
When the command data_len cannot hold all the controller errors, we should simply return as much errors as we can fit instead of failing the command.
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
