Return-Path: <SRS0=hCdm=2C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C68C2D0C9
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2019 09:40:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 171CD2173E
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2019 09:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ib7XPKnx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dell.com header.i=@dell.com header.b="phPcJH6O";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Dell.onmicrosoft.com header.i=@Dell.onmicrosoft.com header.b="kbHQ1DdJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 171CD2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3UJ6a+k+d3foIOWOX+PxFkfXhC7QVA+BdQLfVDjGgPg=; b=ib7XPKnxwvgEgv
	C9NKx5ySjs/hNq6WD01T/wSURvA3fMH8OhZUSA4Uqga9Q4asYeWecAQ/zVDYiRKHvlYUtGZZGiB4p
	DZQ9kwtQvUNNRRthokogTBjTt/qDN+L8a1qMgggvMQTvxH0ht53HqeZIRKj1UB2nfgytD9LWpH46k
	zFXvDK2XKrymvytGnsi78+11NxD5zZWkoTDZwblAXgLU2aGD2mC6Fy98Ta2ZMraOeBBdtHrxswyp6
	z2yCz/Ev52kQy5qorLVGujNiGwjmnA/Ir3G52hqIp41Lhzu3etctu/WHb53F23b3eGWU6PqX+f88Y
	GMFwLSdH6+cBsmoyM3gA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ifKxg-0001y8-1L; Thu, 12 Dec 2019 09:40:44 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ifKxd-0001xX-Pc
 for linux-nvme@lists.infradead.org; Thu, 12 Dec 2019 09:40:43 +0000
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBC9ZL5l023267; Thu, 12 Dec 2019 04:40:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=wZ9CDI6ToaURShrsgnqCOoLX46ux/IW10gMS75uTgLA=;
 b=phPcJH6OYqcizgu/rET7mgCmRgqSXiRVBX6tatWKKuJhCywswju+iEblCGG9me/8pSG4
 27LTKkI83cVAtST7aSuwbAQefFjbHWUPihstruM5S0up1F1Hp+4GKqhs4RiabsK2RnHB
 7nYaQQKdDLBmEXBwFjwV9GZgMM6pEeGpmVKrkqNtDOtpbZvH0Vb0lWk6RwebxGWhxwPA
 e+8JewOrkPV4xvpcK+f9XgFuR0v8eOAS/adH9ErrlOHq+PiP3DaSO9SQjVfEtEUX3MMp
 wyG1IwOD8C002yTMOtLYR5ZK/LischyrfswkUTyB/7xOBpmOTGoZZzna+HWm9JTN0+1f Dg== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com with ESMTP id 2wtwsdd13k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Dec 2019 04:40:41 -0500
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBC9bmvd110842; Thu, 12 Dec 2019 04:40:40 -0500
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
 by mx0b-00154901.pphosted.com with ESMTP id 2wt4mqewsj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Dec 2019 04:40:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtHZEJuAgjWa+ksyNBYMEDkIjh5BlnNwxmo7je+ipBxy7aVyUKOO/dcJBU6lMgijSbYSDr6sdGy4WW6JQ3kNJGboSvxJftA5oOPLyObgpfh0P63mq7AozDFDDL38so4I4raFu8PigqTkqkmQhZMGF+Aeikc+REtm/K/rx79Cpx3Jb1x8Mue+sup73m4hd0YdWtp2CshVTQinjaO+MwaiIbG1ivpsR5eAh0mEKxCJwtw7K2hdGe9k+3LQtPnJImpBH64grcDVHYGfYD8ZJ4GgOJ3NC8Z8Vciw5JYBbyvGdpAsJXGpGOwgv3oKX/SRoD+42tCMRhqLWeYkMIguU8VBTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZ9CDI6ToaURShrsgnqCOoLX46ux/IW10gMS75uTgLA=;
 b=ZASpWv5YkFoqAVjK1qXPRtshrbLfpoEWuVzHUNEnzAJq4432xUP/8LjsGxIsBaWn7q9DYs34/wJ5DZ3wJzYb93FgKgJf73ocA9sZvoRA0TYeUUkGWtLwB4Ms2CV57eezb90sTKmDULgabAP4aa2x5xh9xc8S9a/TOemp/dSrRf1EM/r4RIjnwMr8SKBwMkWWbjEck+E4CmNPTXhn4P77PJUIbpKJbZvad33GYok0Qep2cBK4iGevrfteCgg/qI2sUqzLi6/n5vyACuvz74ectRoRZN2vVkXM4+Xffg3R45q78jnsN5bLJk/asQ6Y4usSVpYVh7UDgm2OmuCCWMKJoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com; 
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZ9CDI6ToaURShrsgnqCOoLX46ux/IW10gMS75uTgLA=;
 b=kbHQ1DdJd9pEDwWxNrVrlTBeu7lNdJK3fpbPuurdWETFeJzZ0uVxrZiq3/db/OsQpVRU1ODeeNu+fuTnY8k+OiysPAYaOGmJ7mQGuINg3PRHJCROpideH8dnRyBAP0cby2EsD5pKhVzzypppfbN84H1JaDgBtB2+1hX/J5I76mM=
Received: from MWHPR19MB1487.namprd19.prod.outlook.com (10.175.2.8) by
 MWHPR19MB1309.namprd19.prod.outlook.com (10.175.2.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Thu, 12 Dec 2019 09:40:38 +0000
Received: from MWHPR19MB1487.namprd19.prod.outlook.com
 ([fe80::885f:1a1e:735e:2848]) by MWHPR19MB1487.namprd19.prod.outlook.com
 ([fe80::885f:1a1e:735e:2848%7]) with mapi id 15.20.2516.018; Thu, 12 Dec 2019
 09:40:38 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: Christoph Hellwig <hch@lst.de>
Subject: RE: [PATCH] nvmet: fix per feat data len for get_feature
Thread-Topic: [PATCH] nvmet: fix per feat data len for get_feature
Thread-Index: AQHVryqPEbFoF0GqL0C0cLNSgLqskae2OMWAgAABwUCAAAc7gIAAADqA
Date: Thu, 12 Dec 2019 09:40:38 +0000
Message-ID: <MWHPR19MB1487CC35002824911B4C8CA8EE550@MWHPR19MB1487.namprd19.prod.outlook.com>
References: <20191210072201.9631-1-chaitanya.kulkarni@wdc.com>
 <20191212090717.GA2399@lst.de>
 <MWHPR19MB14877764B733AF1DBA135A96EE550@MWHPR19MB1487.namprd19.prod.outlook.com>
 <20191212093927.GA3388@lst.de>
In-Reply-To: <20191212093927.GA3388@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Amit.Engel@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-12-12T09:40:36.5672922Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual;
 aiplabel=External Public
x-originating-ip: [152.62.109.209]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33be137a-5e9b-43b5-79be-08d77ee7587c
x-ms-traffictypediagnostic: MWHPR19MB1309:
x-microsoft-antispam-prvs: <MWHPR19MB1309F66EAE1997972684C78FEE550@MWHPR19MB1309.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(366004)(396003)(376002)(136003)(39860400002)(189003)(199004)(7502003)(13464003)(71200400001)(81156014)(53546011)(66946007)(33656002)(26005)(76116006)(4326008)(81166006)(8936002)(8676002)(54906003)(55016002)(52536014)(9686003)(316002)(66446008)(86362001)(478600001)(5660300002)(66476007)(4744005)(6916009)(6506007)(786003)(7696005)(66556008)(186003)(64756008)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR19MB1309;
 H:MWHPR19MB1487.namprd19.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: Dell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n7Z06EysUkEapysvGe3N2P2C2f5N+txuXkuJTV9+c1nrvXGEi7N1g8Wgu0+87FhlXkHTOX03WFSSC6vKTRAEXrqE73AhVZM6c3J9cnZI/WfHvksPpvrkJfYh77yaNdX081OLbRK2fPvAb5nU3Z0MOIP2PEkpTho7Y8XngIkIxmmcBnc63HqEQk8BAdG1GOEAkurIVh0QfX234dgiPwHX7w59xe1ciXQLNc9FIIpOIUI+9EZe2NNCrxpQ8SAk+9inOWVhGgaBB+d01eCBuLDHdPJx8MPkxmOpLI49cw181hyqtObJRBf8xuGHbcsRj7ygB3kmfVsw15VhbpCok+vvJR4k7JFnfwSsD4uSLcGIVw1fP7FVEuAMANBhWvxGHycOyKADorXPq0m0XoAPjtD3O5AXzUC7AE0rZiiuIffogsWqKjGHcIBwaFhQVbjtk13l48BsU/hzCHHEl9cs3Wm96c+GXn+UdexgFGFaJUq3gzdPb3Pg1SGSot0SktHevnsEqPzzoh9ZMQPSbmeXjF9u6Q==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33be137a-5e9b-43b5-79be-08d77ee7587c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 09:40:38.1403 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CWUn3TV12uRnyLeZTg3ZRAg3KQ3gf8K8j4PLYuw1xWTlUR1q7DBbTbfEMLS0GVTUqJ/e6IaXAEF32bue+RQzrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR19MB1309
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_02:2019-12-12,2019-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=906 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912120069
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=919 lowpriorityscore=0 adultscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 spamscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912120069
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191212_014041_885579_A0CACDAA 
X-CRM114-Status: GOOD (  13.43  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Sure, thank you

-----Original Message-----
From: Christoph Hellwig <hch@lst.de> 
Sent: Thursday, December 12, 2019 11:39 AM
To: Engel, Amit
Cc: Christoph Hellwig; Chaitanya Kulkarni; linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet: fix per feat data len for get_feature


[EXTERNAL EMAIL] 

On Thu, Dec 12, 2019 at 09:14:15AM +0000, Engel, Amit wrote:
> Chaitanya, do you fix the double author line? Do you want me to do it?

We usually handle such minor nitpicks when applying the patch, no need to resend.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
