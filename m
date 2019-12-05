Return-Path: <SRS0=qSen=Z3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94833C43603
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Dec 2019 13:36:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5848520659
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Dec 2019 13:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NQN7jnzf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dell.com header.i=@dell.com header.b="aR8r0kOB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Dell.onmicrosoft.com header.i=@Dell.onmicrosoft.com header.b="i8sK+fX6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5848520659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QpcI5hYef0L5FTbREO2HmsJNPxu6OnEG0qvtVXhCC9g=; b=NQN7jnzfOpJ+w6
	GM9ZIiDFzLqGKUdgOfpKRBYkaoQKikfu9a2ktFub+7bv4G+ZrGx5DHEYXjSrqB4ieNik0NOhTqNUg
	gajN63pIP6EJP0R2aoElj1cfKEB2tgPZgwqU4SLg0xnAflvR0hv62Fkmzs3Y1J2Z8jT7iRcgIzunW
	Zu0pW7Zt59wVjZklgMGW52OHYbSQXMtw6iY51wFpLd3QKQTDkcxcZ+RWBzy9ErsntVtbwcLmpPJ4+
	LRHi+JIfA6AjObe7lQwaGep6k0PMSU2on0EeGRnkT7UNHJU8Y9oUfnJWV3xv4v5VuCLmddQIDmKTC
	4YxVx0/BENM5oN7Kv/hw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1icrIm-00004s-KE; Thu, 05 Dec 2019 13:36:16 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1icrIj-0008Vu-Qg
 for linux-nvme@lists.infradead.org; Thu, 05 Dec 2019 13:36:15 +0000
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xB5DZ4oV017731; Thu, 5 Dec 2019 08:36:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=JX7VskB0dcJBvdMuRAfpOPzbbRf7iISY9J+IK+c0EG4=;
 b=aR8r0kOBjtGmDabZx82Vr7yY+dqI/oXAMlvLIcWRsL2EhtBWH8dekVPY0zhgxM/dQM9G
 Bt9piyeTzIl30lm7yfIFjl4Q/IISCGqipmX4hJLR9orj7lyrPbS3CQaFf4Oaj3Xg9kaL
 MTpNAbL7Im85nOD4YFgKL6p579K/EXsnkcY2ga9KZDqutt4kDXlcKoRRnO2En31jEK7M
 1chOwdqcRaFEv1c9LDrWp35AshGRNsjdLYbmIHDBK4xyV/tRv8Z02pso2AxYnM6HSb37
 C5n+Xz0QfLGdV5N8asMNfwrJg2/ZpHJlubi/41rOpIR/w8Ct7aPR4uRZAVAeVm/Q4U3o IQ== 
Received: from mx0b-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com with ESMTP id 2wpqsca9sb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Dec 2019 08:36:02 -0500
Received: from pps.filterd (m0090350.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xB5DS02I113741; Thu, 5 Dec 2019 08:36:01 -0500
Received: from nam04-bn3-obe.outbound.protection.outlook.com
 (mail-bn3nam04lp2050.outbound.protection.outlook.com [104.47.46.50])
 by mx0b-00154901.pphosted.com with ESMTP id 2wnvj0qfvj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 05 Dec 2019 08:36:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kouot72wpL/nk97u47k5ikDtLCr/YUeM/Jc2A+IKhxPpGuWlKny5yvWrLGisYuGNT6ncn4FZkXbDZ/L3wB1Ty0Zr3DL97PS5izlgTo1XdsN6UzG8BJTg87HLXvW0veckKKvZuYk79dc25LJKHqBKdRe+UpzQkpSJePbFeYl9qciq6/6C1xKLXoy8mJaNiFHGg3uowpRzmeXyzTDoZnlYL+MihSmkgIyjPJu3x06E4SdzlKhEDw+hk026JST/SAvU2N6FQ5rnK1KMVJO2KiQVT+KzyfCtGcxRv7yJvKhID2KMRikOlkCpAIeDQnBl5vVpavfZ8s8hYJbH0ZBh37LPaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JX7VskB0dcJBvdMuRAfpOPzbbRf7iISY9J+IK+c0EG4=;
 b=WJTdjFKRPfgUyU+vuuQmLk7pQdWOKPTldz00EvGSRG8FwY+6dM1S1qo+c1d7GqadVsShsO0PJf+0xJ+WGwZFketDLyL8SETH/aGRvc49U15d5rmrq+DWisp8tIrN5AizfLnaBxt7jZZk/0PgajZnXepuvAuc3jpHSFPxMXkGot+sWFXPkyoApisQ2uZzuk8Xd4dyhP2ZKQqg6QYJuZXoErq3P9eLi7PJD1VS7lkSbbqWlVtVJ/ht8SHBk9Mv8/lZoHKpx+SF+MqhqYJQ9wDeGnieTR2GMLbVB2Ush2WsYw5GNNZUAVtg1o2s97ACgUI4erW3NJfQ4xyZxjs3fbtLKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com; 
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JX7VskB0dcJBvdMuRAfpOPzbbRf7iISY9J+IK+c0EG4=;
 b=i8sK+fX6eLVqThhVUs2QTmRIVppEKCf59f6ijxuJMPeG9aa0ZMnp0kViSOz//J13U/AzwIOQtUh1xigW1i9tBnqeiuoY/FfFZTZLM9yLFvpLh+B1Ti5oVdcO1CnohGQHDop1juZLisV8cVmLGmVCEetNOwIBmrMJDN9BnDx4s28=
Received: from MWHPR19MB1487.namprd19.prod.outlook.com (10.175.2.8) by
 MWHPR19MB1421.namprd19.prod.outlook.com (10.173.239.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Thu, 5 Dec 2019 13:35:59 +0000
Received: from MWHPR19MB1487.namprd19.prod.outlook.com
 ([fe80::885f:1a1e:735e:2848]) by MWHPR19MB1487.namprd19.prod.outlook.com
 ([fe80::885f:1a1e:735e:2848%7]) with mapi id 15.20.2516.003; Thu, 5 Dec 2019
 13:35:59 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: RE: [PATCH] nvmet: Fix req->data_len size in case of
 nvme_admin_get_features cmd, fid 0x81
Thread-Topic: [PATCH] nvmet: Fix req->data_len size in case of
 nvme_admin_get_features cmd, fid 0x81
Thread-Index: AQHVq0SSKymplKMKN0aeBJFB2LvYNqerNsmAgABUG6A=
Date: Thu, 5 Dec 2019 13:35:58 +0000
Message-ID: <MWHPR19MB1487C34E6A3487475B480C88EE5C0@MWHPR19MB1487.namprd19.prod.outlook.com>
References: <20191205081541.55962-1-amit.engel@emc.com>
 <20191205083325.GA855@infradead.org>
In-Reply-To: <20191205083325.GA855@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Amit.Engel@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-12-05T13:35:55.6354196Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual;
 aiplabel=External Public
x-originating-ip: [152.62.109.215]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c16b4d22-2766-481e-a4da-08d779881035
x-ms-traffictypediagnostic: MWHPR19MB1421:
x-microsoft-antispam-prvs: <MWHPR19MB14218DFA9931907D24E317C3EE5C0@MWHPR19MB1421.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(366004)(39860400002)(376002)(396003)(346002)(189003)(199004)(7502003)(13464003)(11346002)(86362001)(8936002)(54906003)(229853002)(478600001)(102836004)(7696005)(66556008)(99286004)(4744005)(76176011)(71200400001)(26005)(4326008)(25786009)(6506007)(6916009)(53546011)(55016002)(66476007)(9686003)(316002)(2906002)(305945005)(33656002)(66446008)(186003)(64756008)(786003)(5660300002)(14454004)(8676002)(71190400001)(81156014)(81166006)(76116006)(52536014)(66946007)(74316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR19MB1421;
 H:MWHPR19MB1487.namprd19.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: Dell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Umd9r1PD2QotZp80y99kh4pGxBAZCa9+ILzApKitwMeR5lAQhbTqVNubL2SetkP7Zq4Wo5MNgAVPVLLnzgwf6GK5zUMzrVlVH5wcCZpYOz0w3mbzKxaoMJ4xP+pCbeaw+RMmBsjpB0GAjufVtFDheQaakNqi6RgNFDROJz5ZX7EvpOk61s3J5954eA2cbsDIvTVB5BaubO+9XmN3rv63xKg7GWLqflJujUsBrzTEbotN3XtgwCcdR4jzYTlnhxsdhyucWWQZcQ90SriiIgcVvzi70Eo8d0k2xZ8We/iklZppekDJPIC5SH4UNDvgdvCgCrmdHMNbc1e0j4vZdFQMP6o+WP76GMuOGQVqNQVgSQkogvEdaNw6cq/J+nnj0XyADFZ8iQF8dUHw1HRF9A+v1Q1ClFdw3UdH7rdU5Bp7ZVRHS1OCt/E18eT9YgnFkp7TVYDfTLvgW0vQksx5IZjG/EBKOWUM7XA8KO8ty1xrMzEBuUzOJJ3mp3Rhx96BFgWIM0cEz65RZMwFvHprvVyhpQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c16b4d22-2766-481e-a4da-08d779881035
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 13:35:58.8889 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2tb2NNIuJSoXTEjUDKR93mKj+yEAIqKUwlwQ+gCRAN9w56qhgf6s+o00QOCjJjC/dL2ke9Oz9tOZP+nzpjrdvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR19MB1421
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-05_03:2019-12-04,2019-12-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0
 mlxlogscore=912 suspectscore=0 clxscore=1011 mlxscore=0 spamscore=0
 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912050114
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 priorityscore=1501
 impostorscore=0 mlxscore=0 clxscore=1015 adultscore=0 malwarescore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=923 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912050115
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191205_053614_416440_804DC5B6 
X-CRM114-Status: GOOD (  14.26  )
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
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ok, please ignore my previous patches from earlier today.
I just sent a new patch based on nvme-5.5 
"Add helper function 'nvmet_feature_data_len' to calculate the required data_len"

Please let me know what you think

Thanks
Amit Engel

-----Original Message-----
From: Christoph Hellwig <hch@infradead.org> 
Sent: Thursday, December 5, 2019 10:33 AM
To: Engel, Amit
Cc: sagi@grimberg.me; linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet: Fix req->data_len size in case of nvme_admin_get_features cmd, fid 0x81


[EXTERNAL EMAIL] 

->data_len is gone in latest mainline, instead
nvmet_execute_get_features check the transfer_len.  But your general scheme should apply there.  I think a little nvmet_feature_data_len helper to calculate the required length would be nice, similar to what we do for read/write commands or log pages.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
