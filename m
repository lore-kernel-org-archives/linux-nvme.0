Return-Path: <SRS0=isN7=4S=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F85AC3F2D1
	for <linux-nvme@archiver.kernel.org>; Sun,  1 Mar 2020 04:47:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB41D21744
	for <linux-nvme@archiver.kernel.org>; Sun,  1 Mar 2020 04:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GV2Pn3Iy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dell.com header.i=@dell.com header.b="h/ZxHwkY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Dell.onmicrosoft.com header.i=@Dell.onmicrosoft.com header.b="DGvdgnEh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB41D21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vfQICkAlw1rnlofZwNJ2FwDHi+AntBYkQWGa934ts7Q=; b=GV2Pn3Iy/njb6r
	kl+8BpfkDKWTPbj2pV/TeDmZu8p3Ib/AgjjWQU+N/9VW7KAVv1/QmhB7nsFw0lmxwYbgPe5kxiIeF
	qn8xDxI3mxPSiad9CsQpXXUgeFKzlMFwDdQn5ZOqEGtq6pej4QCKHX8jTYniDvZe8DwC/UTedcsRo
	D3SU+9Nwu2C2dHYT3S0UKx2zzqpo5FtEgK0iJHj+YMpUgz72d01H1snXkGTelr5bLQfubn8Vl6jjp
	b/ZorGQZBbUyL2fo3EbMFcbg00HM3wf19fX3SO+sN95QRSN57bR/WgaPFvsTMv6932xbUYgHDoCto
	Vr7m4kEnf1qnFxNDIAsQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j8GW3-0002R0-RY; Sun, 01 Mar 2020 04:47:47 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j8GW0-0002QV-GT
 for linux-nvme@lists.infradead.org; Sun, 01 Mar 2020 04:47:46 +0000
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0214fb4m006398; Sat, 29 Feb 2020 23:47:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=D2vErFER4OF535mNxjT7MqO5yd4kPdo/vXm6dDgAOK4=;
 b=h/ZxHwkYMETE8nfTtOn+fqYO42K+FVGYUHVQxa+q0oM9T7292c4tJYav+o+Dek0d58VS
 haE6PcCyZIzOLB+tAgufquk76ObQQt+wWe9YUtHYbj7EHdbi4U7KLDzL5I0s8drStyNW
 DxH6FNg05/fft+al/KNiMthRrdL10IKEoBU+t9OxI50pwGII+tzn7yHV3g/iEzLJNCgh
 coTdd/fHC97nP2QCymfUpVW2CnYPQaJyKlQhlQdGkPpDSpKc1G1TRYpDuEVMEaXmimwF
 UbvMNit7TNtVkA4sVKWacHnCoJqH6RcQSSSNeMFLoZew7rtv25sQ/IqjhnpOn50JFQlt /w== 
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com with ESMTP id 2yfngw1jt8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 29 Feb 2020 23:47:29 -0500
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0214iirR082996; Sat, 29 Feb 2020 23:47:28 -0500
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
 by mx0b-00154901.pphosted.com with ESMTP id 2yfn9fqmfg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 29 Feb 2020 23:47:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXXlntz4rsIpQQhDxEqEl8Yl0CWKn7uN1lxqDW6E14YkXt3Q9YWh7U7C0ocjguGvkOSOHcVmLlMqI6aJZ6uoQ0s7XlZLR3H1CuAbah0VBzw0BwE9mduNSS12Kc8kF7LDFNnbV4CNvfSJiICJPe77XC4DwBMqIN52NKkXNZ7jG4avWKiG/1ldVXa+1oDYk77GElqxUO6/YElQNZVRgGrVmTanXzR8SjgtZD4W+X/uk7AkCfrkd2L1IQ09JxSeLjebfTZixYJTfYzhT0QT7rrdWKLmb3B+fp7cP8VhljSZxlqqnjagfe++ODLr6PBrUWi43hMXKl7U7X69TZBxX/51Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2vErFER4OF535mNxjT7MqO5yd4kPdo/vXm6dDgAOK4=;
 b=VLdiGNH5gGT2ktoDqRaQagqLYIH/OdOUN/Dh/mZdtunz+KWCi5uS1IS2mvAitxJyipuLT0nzDsSOPAAWMmzbNYiwcLuaysv8DIpozB4NtIU+3T7xB/YVoxtmdH9d74cBd6EgGyzdYqXysLan25az6HdwuCLxj76jFdf4tAE0frCLCR8wAHUG0fF9geAkjIPwz5FXkXRRzTaqjAqQv1dMgGr0yAnPejILSypA4jjVD0oT3vhiAa83g8d1gIi+sKCidZcEWCx4tJ3p3We51SENSOvO7e2CJYbWZp8B8LdtyxSw+/dLUV7EkmpshkUAD8YRXgK8kyvazgsX3Fq2mKWVQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com; 
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2vErFER4OF535mNxjT7MqO5yd4kPdo/vXm6dDgAOK4=;
 b=DGvdgnEh191VUblEUpIq7f9WAZMXF3osYVyXODHPT+AzlyTmz8wRzieXeD2S11B9uFlAbCGQk64mwhFU3mYINrMxp3Vr0HZOHGP5/qDjYbiN3TGUF5WawVYiHCHeB80GlXo/egEEzajCdannboqd9TXSKFTYD64v1QBPxNtV8hw=
Received: from MN2PR19MB3005.namprd19.prod.outlook.com (2603:10b6:208:109::21)
 by MN2PR19MB3054.namprd19.prod.outlook.com (2603:10b6:208:10a::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Sun, 1 Mar
 2020 04:47:27 +0000
Received: from MN2PR19MB3005.namprd19.prod.outlook.com
 ([fe80::d23:2a41:b2d:8d0d]) by MN2PR19MB3005.namprd19.prod.outlook.com
 ([fe80::d23:2a41:b2d:8d0d%6]) with mapi id 15.20.2772.018; Sun, 1 Mar 2020
 04:47:27 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, Sagi Grimberg
 <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: RE: [PATCH] nvmet: return Invalid Field error on set features cmd fid
 07h
Thread-Topic: [PATCH] nvmet: return Invalid Field error on set features cmd
 fid 07h
Thread-Index: AQHV7jYu9hHtmmwPV0u08Dbpj70rj6gzLI1g
Date: Sun, 1 Mar 2020 04:47:26 +0000
Message-ID: <MN2PR19MB30058A102F30C99029F1FC38EEE60@MN2PR19MB3005.namprd19.prod.outlook.com>
References: <20200228125214.100729-1-amit.engel@dell.com>
 <6653e6ab-0fb4-7cb9-e759-eecaef4eddbd@grimberg.me>
 <BYAPR04MB57499DC82E126AEAD6682B3C86E60@BYAPR04MB5749.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB57499DC82E126AEAD6682B3C86E60@BYAPR04MB5749.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Amit.Engel@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-03-01T04:47:25.3082464Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual;
 aiplabel=External Public
x-originating-ip: [80.246.141.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd31b4e9-8c80-4cba-f30a-08d7bd9ba454
x-ms-traffictypediagnostic: MN2PR19MB3054:
x-microsoft-antispam-prvs: <MN2PR19MB30541C408E0201CCB56755BCEEE60@MN2PR19MB3054.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-forefront-prvs: 0329B15C8A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(189003)(199004)(5660300002)(8676002)(9686003)(478600001)(55016002)(53546011)(26005)(81156014)(81166006)(71200400001)(52536014)(8936002)(186003)(86362001)(6506007)(66476007)(66556008)(2906002)(316002)(66946007)(64756008)(110136005)(786003)(4744005)(7696005)(66446008)(33656002)(76116006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR19MB3054;
 H:MN2PR19MB3005.namprd19.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: Dell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rbtsqwItrej4Y8a3YxCwUPRuq2eCyCg3x2rJWyJ2vsIfW+RKC9XshZBycTldZLZxkxq2T14chi8ESqkeFVhDcAsygiwWIc5/1PovqAJXhziDeyhNoBZOnk9Y3g6hQVEAyIrIvXTqU0jp4KBGjbN0MkUWdUsPQcHkAAkXnjz06ux5Oso2QE2EbDwbCiTT4/HTrzh/r/J1RTr3YnejpHxCbXO5xSDO1Dk+HtKOwwq0zR3GJcBOrTe+v+0Hzpf1//syV72FHqdBelXZpRja9rFnn1O0GPgJFhoCYRi/R8uNAg1m5v0ES50H+SreL5CNISzUpD1IR2iHxFsSanD5am0l3JDT+YqdqLLIh2SpTiDDe2apdN/hcRNo3DFO229J0bDd/ZvZhXJUd7MwVdR35p82To9k7KFrI/LyPO9zOQ2QbgxKnPy/deFYZqVID8OSLhV4
x-ms-exchange-antispam-messagedata: EVxpuHLV0OiyaXlzEte7JduyUHhh/CnN43rHL6UmgV+Fr+P14wjWUGnlf8ygwGl2zsBW9quglQ9+j/gf4+jXFvdQp7WCjb6dDS6/r9hOWx1M+mZKVW7kXYXbeQP+RV5N+UD9oLBGGEfb7BPWCYFi0w==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd31b4e9-8c80-4cba-f30a-08d7bd9ba454
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2020 04:47:26.8537 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BwkjHcHTqGeBDp2S9u3WN+p++g6ERMu5tMGmoUfvDsROMnaBuSCYu81I3V9xa5Uqvp2iSw+UoZ5m+UfRh9t4Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB3054
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-29_09:2020-02-28,
 2020-02-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 lowpriorityscore=0 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003010037
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 adultscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003010036
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200229_204744_769334_3BD95B2A 
X-CRM114-Status: GOOD (  12.40  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thank you

-----Original Message-----
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com> 
Sent: Sunday, March 1, 2020 2:30 AM
To: Sagi Grimberg; Engel, Amit; linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet: return Invalid Field error on set features cmd fid 07h


[EXTERNAL EMAIL] 

Sent out a patch with following comments and appropriate history.

On 02/28/2020 12:33 PM, Sagi Grimberg wrote:
> I meant that here we only declare, assignment should go to where these 
> are used.


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
