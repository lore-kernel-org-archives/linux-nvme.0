Return-Path: <SRS0=Tecl=W7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A621FC3A5A8
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 18:46:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BC042077B
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 18:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l2ufPtoy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dell.com header.i=@dell.com header.b="RPSbgGiZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=emc.com header.i=@emc.com header.b="nEkoetbZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BC042077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JSEr693SSGqiy4RYSrqM1ckEtmOyPgUDgTkawvXTMaU=; b=l2ufPtoy10e2qR
	q9zZawQj2t5n8SCO8MA3jnbpx3YkMkqe80sDrn1kWBnXkU0wj6V1y6UM6HrmSmJT2HJ9wLSr8titY
	1HrvXh5nHBGBqmEReomQwLyqWmEqn7EO6kyfy5l8YrvxFIZRnyOVFPW2on2GUeMMFTp0cyIjOzuhJ
	reToby/UUYPByaUCqu1uTGqC8ezrwzGwSV0nnz1H/2WFNDxttDTkkIEJPKTwOVefKzcbVYGd+k6Vd
	3RMDX72fzglGrrqz6/H9kTI5K6ZQeJbNHOundwL0UG8P83lU4bOVbs16U1qJp+UaIU3WEA9HGPlj5
	N+NcVttCGoxdLuga7FNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5aIh-0004Xp-9O; Wed, 04 Sep 2019 18:46:39 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5aIe-0004XS-70
 for linux-nvme@lists.infradead.org; Wed, 04 Sep 2019 18:46:37 +0000
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 x84IdoTt012582; Wed, 4 Sep 2019 14:41:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=NKDSZe2156zjFSvTl5bVhu6O1iVs2sWQlEgl+txyIXQ=;
 b=RPSbgGiZgFATq99h+HqVG+VEWGBDV7GGw988+Rlg68utYT6gx7N1EOjX33Wvz0vk/4m1
 uPeHMvFHNmTdyFgY+vPePl1UDlfmlQoyYhuj4PSX2SWjGETQRLRMfmv3w3vg7KTatUv2
 JSwY5nRpy9TYXtYbhiM5WiCut8l1gzyEG9AAQ66WTOOXiY8xcB+SxmZxzOU2p0+gppqJ
 Zwyyvdu0R/Q8K6xE4ioahQuvvEk3F1Vjjsczt1RVt7dNlroq6v6C6171DUDvopWRGuLN
 n1BszP9c6EXxCHDudCL4H4w02FbT9RGzEmQJwoGWky0zIEYvqdAZvJBCikmxEdteMhl2 7Q== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com with ESMTP id 2uqnjpgrf4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Sep 2019 14:41:10 -0400
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 x84IbxD8055193; Wed, 4 Sep 2019 14:41:09 -0400
Received: from mailuogwhop.emc.com (mailuogwhop.emc.com [168.159.213.141])
 by mx0a-00154901.pphosted.com with ESMTP id 2ut6tvcf1y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 04 Sep 2019 14:41:09 -0400
Received: from maildlpprd05.lss.emc.com (maildlpprd05.lss.emc.com
 [10.253.24.37])
 by mailuogwprd03.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with
 ESMTP id x84Ierd0010658
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 4 Sep 2019 14:41:08 -0400
X-DKIM: OpenDKIM Filter v2.4.3 mailuogwprd03.lss.emc.com x84Ierd0010658
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=emc.com; s=jan2013;
 t=1567622468; bh=56AZNaZNod3aYQZ48CbIzwAH8As=;
 h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:MIME-Version;
 b=nEkoetbZPrquJun7X+YOL1Nt5YDDnG51iAOLm6ISVgLO/Y+PxY9IGvKcqnCmW4wwg
 ors+39mwQDt6TALDOddFoXI3JaO22w93DWIhygnNUYuZ7jUz8grV8zm5e9WJKhhbXl
 CpSkWkpqGU6PplJw5PzMqm8UC/DlEPjpkuHEne58=
Received: from mailusrhubprd01.lss.emc.com (mailusrhubprd01.lss.emc.com
 [10.253.24.19]) by maildlpprd05.lss.emc.com (RSA Interceptor);
 Wed, 4 Sep 2019 14:40:34 -0400
Received: from MXHUB302.corp.emc.com (MXHUB302.corp.emc.com [10.146.3.28])
 by mailusrhubprd01.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with
 ESMTP id x84IecSt011668
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=FAIL);
 Wed, 4 Sep 2019 14:40:39 -0400
Received: from MX302CL04.corp.emc.com ([fe80::18ad:6300:21eb:2b39]) by
 MXHUB302.corp.emc.com ([10.146.3.28]) with mapi id 14.03.0439.000; Wed, 4 Sep
 2019 14:40:38 -0400
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: RE: [PATCH] nvmet: fix a wrong error status returned in error log page
Thread-Topic: [PATCH] nvmet: fix a wrong error status returned in error log
 page
Thread-Index: AQHVYCzrqpORZZYTjEisFVH6xiRa2KcbyCeA///DvnCAAF8vgP//9MnQ
Date: Wed, 4 Sep 2019 18:40:38 +0000
Message-ID: <8739B0CD2FC2DC40AF691A1CCBB9896034610EBC@MX302CL04.corp.emc.com>
References: <20190831185006.119748-1-amit.engel@dell.com>
 <20190904131447.GA9892@infradead.org>
 <8739B0CD2FC2DC40AF691A1CCBB9896034610E40@MX302CL04.corp.emc.com>
 <20190904151947.GA11034@infradead.org>
In-Reply-To: <20190904151947.GA11034@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Amit.Engel@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-09-04T18:40:35.5467522Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual;
 aiplabel=External Public
x-originating-ip: [10.200.57.93]
MIME-Version: 1.0
X-Sentrion-Hostname: mailusrhubprd01.lss.emc.com
X-RSA-Classifications: public
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-04_05:2019-09-04,2019-09-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 phishscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909040186
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909040186
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190904_114636_380300_230B00D2 
X-CRM114-Status: GOOD (  11.37  )
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
Cc: "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ok, Done

Thanks
Amit

-----Original Message-----
From: Christoph Hellwig <hch@infradead.org> 
Sent: Wednesday, September 4, 2019 6:20 PM
To: Engel, Amit
Cc: Christoph Hellwig; sagi@grimberg.me; linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet: fix a wrong error status returned in error log page


[EXTERNAL EMAIL] 

On Wed, Sep 04, 2019 at 02:05:16PM +0000, Engel, Amit wrote:
> Should I provide a patch according to your suggestion?

Yes, please do.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
