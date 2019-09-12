Return-Path: <SRS0=lXTb=XH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB6DC49ED9
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2019 05:34:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE03420856
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2019 05:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R+xja8DF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dell.com header.i=@dell.com header.b="vn40iXmp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=emc.com header.i=@emc.com header.b="DRYXpfli"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE03420856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tBL8E3UwLX+dS9eJql7swEX87mkeL0e+VwXlqbN2wDs=; b=R+xja8DF/xHfbb
	4kgc1UutV8ewmCgshF1ZnyvWFXsJnda0z6kHnHJls1RY5pA+m5JugwfqOb3AbsP1r12nLrhX3ewvd
	sMDDDRZfAaVga7Qw0RpAXMj8TtAYVuQ9X9Hm9lYpqcBCHhSKfuX9gfBpJRe5CtmK/fr2kJZVSKVKR
	9fn8h8aQ6xjGQG8cG/lJSXotstEGVJSF2qnEdVMlHcLKiXbK36ZCEXsbtfrVtBmTgfcvPh4FbDf6x
	GJjFaYvg3bEBBlxDc4AlJ/rotdD81oClUFu9rZHkr+SbwKIRmAHscNX62WOtNlJxdzT1agxJ1ZmZK
	d45KH606Dx49c4nihiJA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1i8HkO-0001gg-Ow; Thu, 12 Sep 2019 05:34:24 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i8HkM-0001g4-1x
 for linux-nvme@lists.infradead.org; Thu, 12 Sep 2019 05:34:23 +0000
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 x8C5TcWR008327; Thu, 12 Sep 2019 01:34:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=ad8/cSstel22WFXQF3TwHttUc8v9QUuuOj+55DfJKRM=;
 b=vn40iXmpZLkPZvPrQgxkj1qAG2w3a3bB/YKkgvBzaejWoYvdGAs8K1ZUk/Y+izy7By1m
 6ORmHrs5KLDAVSh5pBQt18ydo94smMyXK8sXrRPUG9REA8CTFIxqBXgWtC97N9MdfWRn
 My9sL1xfb3Xwvl53pR+wJ2YAv3f9Uu1iuFVYjCSOgW5KTxWh2p24nh10eUYAECS8bFqm
 YIY7KgFDoyNX88Fa+fFCK0nUNSVl2TilA93ZwqsgHgKpXyMXd6CadKP+opyEuBQekQZ+
 g6AaYpXic/LXFv1F6niQfeBQVyIkCCyV1DhOwu+H3xExwAoK54Vw6lOIaLa00TCphmeN Hg== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com with ESMTP id 2uv97qyf6w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2019 01:34:09 -0400
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 x8C5XBRD176798; Thu, 12 Sep 2019 01:34:08 -0400
Received: from mailuogwdur.emc.com (mailuogwdur.emc.com [128.221.224.79])
 by mx0b-00154901.pphosted.com with ESMTP id 2ux9uettuj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 12 Sep 2019 01:34:08 -0400
Received: from maildlpprd56.lss.emc.com (maildlpprd56.lss.emc.com
 [10.106.48.160])
 by mailuogwprd54.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with
 ESMTP id x8C5XuuZ017087
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 12 Sep 2019 01:34:07 -0400
X-DKIM: OpenDKIM Filter v2.4.3 mailuogwprd54.lss.emc.com x8C5XuuZ017087
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=emc.com; s=jan2013;
 t=1568266448; bh=6PEf/ukeP8GvzNi346prQAc0Wuo=;
 h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:MIME-Version;
 b=DRYXpflib3eV+bawrOjst0/4oJvC53do0IP32HC0aUcGW2RtkwsZj72HRdbXfff54
 wQAt6NUPBvvuXK01hv5rxpD2RTZbjxz4rjLgeHYBcSaBB4iiTMefqeLEsAWtq5dNM1
 S3xs3ujqkpWyXS7bX/Lli+AOLr8LPqpHAwigpJ84=
Received: from mailusrhubprd04.lss.emc.com (mailusrhubprd04.lss.emc.com
 [10.253.24.22]) by maildlpprd56.lss.emc.com (RSA Interceptor);
 Thu, 12 Sep 2019 01:32:44 -0400
Received: from MXHUB311.corp.emc.com (MXHUB311.corp.emc.com [10.146.3.89])
 by mailusrhubprd04.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with
 ESMTP id x8C5WkaT008828
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=FAIL);
 Thu, 12 Sep 2019 01:32:46 -0400
Received: from MX302CL04.corp.emc.com ([fe80::18ad:6300:21eb:2b39]) by
 MXHUB311.corp.emc.com ([10.146.3.89]) with mapi id 14.03.0439.000; Thu, 12
 Sep 2019 01:32:46 -0400
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@infradead.org>
Subject: RE: [PATCH] nvmet: fix a wrong error status returned in error log page
Thread-Topic: [PATCH] nvmet: fix a wrong error status returned in error log
 page
Thread-Index: AQHVYCzrqpORZZYTjEisFVH6xiRa2KcbyCeA///DvnCAAF8vgP//9MnQgAsK/9CAAEqbgIAAYIAA
Date: Thu, 12 Sep 2019 05:32:45 +0000
Message-ID: <8739B0CD2FC2DC40AF691A1CCBB9896034611FE5@MX302CL04.corp.emc.com>
References: <20190831185006.119748-1-amit.engel@dell.com>
 <20190904131447.GA9892@infradead.org>
 <8739B0CD2FC2DC40AF691A1CCBB9896034610E40@MX302CL04.corp.emc.com>
 <20190904151947.GA11034@infradead.org>
 <8739B0CD2FC2DC40AF691A1CCBB9896034610EBC@MX302CL04.corp.emc.com>
 <8739B0CD2FC2DC40AF691A1CCBB9896034611F97@MX302CL04.corp.emc.com>
 <baa50dcb-f828-b9b9-6869-dc7464dcf7cc@grimberg.me>
In-Reply-To: <baa50dcb-f828-b9b9-6869-dc7464dcf7cc@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Amit.Engel@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-09-12T05:32:43.7982348Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual;
 aiplabel=External Public
x-originating-ip: [10.76.81.146]
MIME-Version: 1.0
X-Sentrion-Hostname: mailusrhubprd04.lss.emc.com
X-RSA-Classifications: public
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-12_01:2019-09-11,2019-09-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 mlxscore=0 adultscore=0 mlxlogscore=932
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909120057
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1909120057
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190911_223422_297010_BE97C724 
X-CRM114-Status: GOOD (  10.95  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SnVzdCByZXNlbnQgdGhhdCwgcGxlYXNlIGxldCBtZSBrbm93IGluIGNhc2UgeW91IGRpZG7igJl0
IGdldCBpdA0KDQpUaGFua3MNCkFtaXQNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZy
b206IFNhZ2kgR3JpbWJlcmcgPHNhZ2lAZ3JpbWJlcmcubWU+IA0KU2VudDogV2VkbmVzZGF5LCBT
ZXB0ZW1iZXIgMTEsIDIwMTkgMTA6NDUgUE0NClRvOiBFbmdlbCwgQW1pdDsgQ2hyaXN0b3BoIEhl
bGx3aWcNCkNjOiBsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcNClN1YmplY3Q6IFJlOiBb
UEFUQ0hdIG52bWV0OiBmaXggYSB3cm9uZyBlcnJvciBzdGF0dXMgcmV0dXJuZWQgaW4gZXJyb3Ig
bG9nIHBhZ2UNCg0KDQpbRVhURVJOQUwgRU1BSUxdIA0KDQpEaWRuJ3Qgc2VlIGEgbmV3IHBhdGNo
IGZyb20geW91IEFtaXQuDQoNCkNhbiB5b3UgcmVzZW5kPw0KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgt
bnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtbnZtZQo=
