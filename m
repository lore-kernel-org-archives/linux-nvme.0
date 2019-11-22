Return-Path: <SRS0=ia7R=ZO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CB1C432C0
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Nov 2019 14:05:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5808320718
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Nov 2019 14:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aAsiMB4b";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ni14wlqF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="B/H+kcxa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5808320718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CfSrhf7EgOFSJEgT86BxAN98fmO4/5Hj4pLf/P8cHcc=; b=aAsiMB4bFv+aB+
	bTCPS5r5KIh7r8MlBYKsPvRm0syTNcEjdWCg9NxRLNXkVOCSC+XWe6SVqDn05DsfXNH3SEyB1opn3
	2kUGXtv9qOfG5wMzZFNlyZl6ZAtdIPyXEQUjTrUQvXALVJOskq5pyhCbSjoWPz1ah2erGQIsJ8YKJ
	VSWzNzkA6UTunncAUOhu9MU0rjv552MMrFhZBLg3y6LlvmJFmG1dFPjCsrQYBmQ6R0hm2R/6eLahh
	2whu/kPwGJiJawZll674T6C+pWI3rh+yu0vzLtP9Sd3MtFzQC0Ih6gCp4rDPSbkERJEVtXTUJDOpP
	5v5J+pXa1ibFZxAwH3Gg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iY9Yc-0005r7-E4; Fri, 22 Nov 2019 14:05:10 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iY9YZ-0005A4-J5
 for linux-nvme@lists.infradead.org; Fri, 22 Nov 2019 14:05:09 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAME4D09013485; Fri, 22 Nov 2019 06:04:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=hsCntSsIQml5cOFvcFsPuNPK7vw2Y7c7I1m8/b/Yb0E=;
 b=ni14wlqFakeUS5YV4FNyVFipuufhBIk4UGxcgU9rpm1fTLspgjCWbPUBjV4Q47eg0Hd6
 E4ysjKzftIdLvdMh5fbSA0Lh0BQ5NuOK/b+yYeyC5JQOHkcQvg4PvdEVVvWkTW8XPcT2
 gtBHfvvST0mJzT1AMV0GECKAPJ3MwC1COVE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
 by mx0a-00082601.pphosted.com with ESMTP id 2wea1rhk0x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Fri, 22 Nov 2019 06:04:55 -0800
Received: from ash-exhub201.TheFacebook.com (2620:10d:c0a8:83::7) by
 ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 22 Nov 2019 06:04:54 -0800
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP
 Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 22 Nov 2019 06:04:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGzkkoCdZWEYs4hkhDKvjqW5LFLnRcdPf1RfB4gNrWMoKYZxBcNUVSe6KwlPdgohCBDoclIuqzANLO7qGumX8H6Tfeg+LP5Xi2/Z3uZm2HBpcMlFgkbox7CX8hLMcm6FL/2HpLJ+4rp01CbdQzUAlrnp47CYfebHvMYW/qCjgVRssWmIKdzNv2zUEPq83pXwyU4FpmHNPK0QKe2yX20LOuJ1oY4lZhnn6HaXZ9em8UDHyAmh1+eqRVOh4x+12LPrRkbf97YIbIY8DHG+HWoBNCKLId7n9hWhXlvCIczl21qYNF8EQSkZtZnYVHujaupLMUALPDG9XQMUQ2syyN/q/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsCntSsIQml5cOFvcFsPuNPK7vw2Y7c7I1m8/b/Yb0E=;
 b=Coa05W4w7jjdq9WX0yE+D6xE3oNh34nvcjDMDwc86A0hRr94BGECiDAvWos99CHiyKllerOUWATGMzO4cD7njmlrSvyfIi4b3OEehLMnfAAFvs4jxrtveMiT/CmsNkwizIEzThsG9QSp9ewxfAFIWwxINIcR5fg53e700t4EV2RVj2M1C4TF3xPxlOgzBRTpSAPKhyPoyxZh49uCpsmvK+te9JMS6Xel5/hJ7lo06elCfvav7h9oC/A4WaXfXHwPWYd5XZxJF4Hq4setq2oNtrwwbj60iBwe+G7bs20hEE0hIk9kTPeYQShHobyOQDes6ZebRvdfraBasWCVryIByw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsCntSsIQml5cOFvcFsPuNPK7vw2Y7c7I1m8/b/Yb0E=;
 b=B/H+kcxavGefvdiPaXhQQzjk8VzbD0xXGb7JnxwjPbLwwP8XN2kP32rXSfT020QKnuNx10zFiIAk1YJ1lysLrynydvQ08TvbqdjQ001kJbXsiIe0OHotjawqkDQQvd8jebDuAxCNMc4oc0jxaKrSqLs7KmUHKbZrQcYcp3ych6A=
Received: from BYAPR15MB2790.namprd15.prod.outlook.com (20.179.158.31) by
 BYAPR15MB3285.namprd15.prod.outlook.com (20.179.56.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Fri, 22 Nov 2019 14:04:53 +0000
Received: from BYAPR15MB2790.namprd15.prod.outlook.com
 ([fe80::1d32:6ae1:9e5d:d82a]) by BYAPR15MB2790.namprd15.prod.outlook.com
 ([fe80::1d32:6ae1:9e5d:d82a%6]) with mapi id 15.20.2474.018; Fri, 22 Nov 2019
 14:04:53 +0000
From: Jens Axboe <axboe@fb.com>
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 0/2] nvme-pci: check CQ after batch submission for
 Microsoft device
Thread-Topic: [PATCH V3 0/2] nvme-pci: check CQ after batch submission for
 Microsoft device
Thread-Index: AQHVoRmOhHg+q4871ESK9S5CES20IqeW9F2AgAAHtICAAD1WgA==
Date: Fri, 22 Nov 2019 14:04:52 +0000
Message-ID: <b5148303-f05d-71c8-787a-597958c1909c@fb.com>
References: <20191114025917.24634-1-ming.lei@redhat.com>
 <20191121031154.GJ24548@ming.t460p> <20191121061431.GA22886@lst.de>
 <20191121074643.GB4755@ming.t460p>
 <20191121154531.GB17852@redsun51.ssa.fujisawa.hgst.com>
 <20191122094457.GA23632@ming.t460p> <20191122095743.GA21087@lst.de>
 <20191122102517.GA30001@ming.t460p>
In-Reply-To: <20191122102517.GA30001@ming.t460p>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CH2PR05CA0023.namprd05.prod.outlook.com (2603:10b6:610::36)
 To BYAPR15MB2790.namprd15.prod.outlook.com
 (2603:10b6:a03:15a::31)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [65.144.74.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13931931-7be8-4359-66bf-08d76f54f226
x-ms-traffictypediagnostic: BYAPR15MB3285:
x-microsoft-antispam-prvs: <BYAPR15MB328598DCC92507C6E019E200C0490@BYAPR15MB3285.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 02296943FF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(39860400002)(346002)(136003)(366004)(376002)(47530400004)(189003)(199004)(478600001)(66066001)(64756008)(86362001)(14454004)(6116002)(8676002)(25786009)(81166006)(8936002)(3846002)(36756003)(66446008)(31696002)(81156014)(5660300002)(66476007)(4744005)(66556008)(7736002)(45080400002)(305945005)(316002)(2906002)(6436002)(76176011)(6486002)(2616005)(6512007)(229853002)(6506007)(66946007)(53546011)(186003)(102836004)(26005)(31686004)(71200400001)(71190400001)(52230400001)(14444005)(99286004)(4326008)(110136005)(54906003)(386003)(256004)(446003)(6246003)(11346002)(52116002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR15MB3285;
 H:BYAPR15MB2790.namprd15.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9xVF+Cc7FEoDGqCSIEcuO/B5NMQooMm4yM2Il/j3vzSBRuXw7QmvRV7Fze1xgBS9Ykx+/3VPdGiXnSv5B/Ws8kj+pY1/iRRM+VSpL+pwhAgb/5JTtX9x41akrsBDjSPvRqMEYjhsEkXTwXbO7vUmkEmFLMisN8HpMXqE/xDReYfNktG29v7+H5Qqs+240xYDcp/Y6NZM2AsxrFobGDNwLW0exlN81Ctctp5kfMqQMG0twlaPOpjkBut6yCHuGw9QdFKrMU5SYLTbQY+4PoJM83gM5aefUta3aVc4RCm9hoeHjnYWvoOgZB6X0ZaSlQexeee9VqiPdKMRjWuUgdCK0IBsASwleuk9/QWamYnMBpLYOh/HjTHFPxTx4JoYP4/hByymjUgkWZFDdLGXusXlBJBpky3s5ZaOp40ijy0zj5YGr6KbLNleTkG1ueZn9N9z
x-ms-exchange-transport-forked: True
Content-ID: <EB07F55349F48B4692F10258D282650F@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 13931931-7be8-4359-66bf-08d76f54f226
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2019 14:04:52.9541 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bprjm4KIxLi+/MLZqzp4A1CRostEJAbCda62gKA3Rm1/jrwl4xlVIOnPu6uxzQ0p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3285
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-22_02:2019-11-21,2019-11-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0
 clxscore=1011
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=807 lowpriorityscore=0 spamscore=0 mlxscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911220126
X-FB-Internal: deliver
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191122_060507_808952_66F22470 
X-CRM114-Status: GOOD (  13.84  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Long Li <longli@microsoft.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Nadolski
 Edmund <edmund.nadolski@intel.com>, Keith Busch <kbusch@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/22/19 3:25 AM, Ming Lei wrote:
>> as that will still overload the one cpu that the interrupt handler was
>> assigned to.  A dumb fix would be a cpu mask for the threaded interrupt
> 
> Actually one CPU is fast enough to handle several drive's interrupt handling.
> Also there is per-queue depth limit, and the interrupt flood issue in network
> can't be serious on storage.

This is true today, but it won't be true in the future. Lets aim for a
solution that's a little more future proof than just "enough today", if
we're going to make changes in this area.

-- 
Jens Axboe

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
