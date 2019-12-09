Return-Path: <SRS0=+L2C=Z7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB7BC43603
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Dec 2019 13:22:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08D2520726
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Dec 2019 13:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="knZxGVxC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dell.com header.i=@dell.com header.b="xI/M/HkV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Dell.onmicrosoft.com header.i=@Dell.onmicrosoft.com header.b="MlV/wPfo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D2520726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0WC/ydtpIx6aR2I4N/mX7NAYTv9ElM57YaFJR6EWbHk=; b=knZxGVxCGK02ye
	dmFaAzzA0ypalUxNDE72VUFM6Jw98drwa1pFz9KSHL8tOVwve6dEEgM1EXAAVVUiM6tV0WXx+qmwx
	XCkjLIofmWohhzRrDlwKjjJqmpbRBNUxEY/0Ha6kRnodNxP/uREL+CvCRkuy9GlZO7Ahoc/o/joDH
	ltwNtkCLAWx6994x+FHdUoXBG7nRg8Kg3sYHbOQnld4ZCJ9xm4N7ZtfYSjbHOsubJjRW4GkYp+/NB
	hh40zqHHVr4vWIpvtBmGCZiz/jH6bgLKY6grWp6AigI4ga3PytLpNn2QCqZk+rv/PMeAsd77GD3XV
	t1/LoWUR8o4JHAx8tzrQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ieIz6-0003BR-1P; Mon, 09 Dec 2019 13:21:56 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ieIz0-0003Ab-Am
 for linux-nvme@lists.infradead.org; Mon, 09 Dec 2019 13:21:53 +0000
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xB9DKWgB001644; Mon, 9 Dec 2019 08:21:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=oUTlVgKazHI+CDPH1+ajgQU9D6j7vX7nxGK9vI/horY=;
 b=xI/M/HkV7k+qalSylp34KEWrh3YBRKSKc94HFWWcSs5VuXjAqwlJKctoZQeu/sOiIhy/
 bIMYYikPcgyHu4Lq+ymuD56LvZZc8TuiAzs9tfx1hw4txkeibSmBIFy2ijeLUk8+fx85
 dlmm8TJS1CuGUcJeMzUOGUsbGU9zD4EprY6RHd1ba4AwKtudSrqv3841P4MDydwdfyC/
 ddhnQRyMZIqPcljbT/lN5DTyd9Nw7XnTmuTqR6DHxeF+BVTdoq6Eg3TBqunC2ewF3Dws
 WVRTJNuH13/9wh/gjJ4Q8QGZF68VTQ8V1kH/nMFZE7k8uEwKY3TLHgxeAB3i3+A81JWA xQ== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com with ESMTP id 2wr8yppwmq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Dec 2019 08:21:34 -0500
Received: from pps.filterd (m0134318.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xB9DIdL2039908; Mon, 9 Dec 2019 08:21:33 -0500
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2056.outbound.protection.outlook.com [104.47.36.56])
 by mx0a-00154901.pphosted.com with ESMTP id 2wr7khejyk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 09 Dec 2019 08:21:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PY/GQEUQp8c9X7rDyLjTPb1m0JJKf0coKcZexQPMuNaO00O2viys+9BbDSw1G9HgHTpwpFH3mQbstUH0beUXUVvxstgXmu4IAPu43z8Jide1lmsMTv4HwpdhiXZXoWY3FqaSJiebt4ddWu9T6q+fRfa2H95l1IX4rE7WK6D603b+slk7A+QZBz32x1AVj057SaC+P5n7+MP9BBLkKqi9C4aMKda73pYCWRk2foYvAfmvcKQtkJYO/q9SyBWxU6Oxowk/KnrJxPNen9mH1rFZODny1RlUGPnsxOU76Ncqb9ipKb3piNPM/SYSOjJuD56EuYNpKNXDfQH9S0hRucYA/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oUTlVgKazHI+CDPH1+ajgQU9D6j7vX7nxGK9vI/horY=;
 b=UYJOijJ/7dmAuPjsG88S/CCc4vhCsP5tRnMB2zLg7PET/Lxv4hm6Lcd0n5x5YXZQjECZiveQ9jdN/AT9XK1/ZbTzHslghYIGbJrM5ldVuNHqQMIDRnPkvND7WB7GgojYlh8fKmZQwunEcFTzdSTtt0NaSx1SM9vc2ZjSdvoS3exvSnp0/ACW4enOxT2lsRcTWRL6CxMKl7bgfzniXPtred97jcJUVc4wsSDPiWRF9NGZgdfrd2F575XZXgFt0ofLqbp1B+FdkGb23YB2kn615v0yIDqRWsSPbby2j1LhYTM1j8UYCkrzR1ULopZw72DK7G0JnrgvvluwvyJGQlGIOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com; 
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oUTlVgKazHI+CDPH1+ajgQU9D6j7vX7nxGK9vI/horY=;
 b=MlV/wPfoeCuJX3KJLGxpbhku/xZs2iolJAPmZ2A6bBqzYB4ovBoa5aTJmuhHsnEcptc4JmoPtNsjLCajfzfgpjMsEYkZjGotwl5pSkiNURDegAen1IWP9+x9YP166MHUZHQ5tOX+F7pYd079TRbNMxpPZxW+5vcfGbM5j8NjGdQ=
Received: from MWHPR19MB1487.namprd19.prod.outlook.com (10.175.2.8) by
 MWHPR19MB0143.namprd19.prod.outlook.com (10.164.206.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Mon, 9 Dec 2019 13:21:31 +0000
Received: from MWHPR19MB1487.namprd19.prod.outlook.com
 ([fe80::885f:1a1e:735e:2848]) by MWHPR19MB1487.namprd19.prod.outlook.com
 ([fe80::885f:1a1e:735e:2848%7]) with mapi id 15.20.2516.018; Mon, 9 Dec 2019
 13:21:31 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: RE: [PATCH] nvmet: Fix req->data_len size in case of
 nvme_admin_get_features cmd, fid 0x81
Thread-Topic: [PATCH] nvmet: Fix req->data_len size in case of
 nvme_admin_get_features cmd, fid 0x81
Thread-Index: AQHVq0SSKymplKMKN0aeBJFB2LvYNqerNsmAgABUG6CABkWEkA==
Date: Mon, 9 Dec 2019 13:21:31 +0000
Message-ID: <MWHPR19MB1487371362F731AE4A6FD768EE580@MWHPR19MB1487.namprd19.prod.outlook.com>
References: <20191205081541.55962-1-amit.engel@emc.com>
 <20191205083325.GA855@infradead.org>
 <MWHPR19MB1487C34E6A3487475B480C88EE5C0@MWHPR19MB1487.namprd19.prod.outlook.com>
In-Reply-To: <MWHPR19MB1487C34E6A3487475B480C88EE5C0@MWHPR19MB1487.namprd19.prod.outlook.com>
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
x-originating-ip: [152.62.109.209]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b694de3e-d868-4063-e023-08d77caab4cb
x-ms-traffictypediagnostic: MWHPR19MB0143:
x-microsoft-antispam-prvs: <MWHPR19MB01436E318A13000CF543D8DEEE580@MWHPR19MB0143.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02462830BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(376002)(396003)(366004)(346002)(136003)(13464003)(189003)(199004)(7502003)(8676002)(81166006)(305945005)(81156014)(86362001)(4326008)(5660300002)(229853002)(8936002)(6916009)(54906003)(2906002)(71200400001)(71190400001)(52536014)(186003)(26005)(53546011)(6506007)(9686003)(76116006)(478600001)(66476007)(7696005)(66946007)(64756008)(66446008)(55016002)(33656002)(66556008)(316002)(786003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR19MB0143;
 H:MWHPR19MB1487.namprd19.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: Dell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lZo+N9VXbpxmZuE4uuHdQFOfwXPhUMAk68EnzMNJgSvplDH1VhY6uywktywaA6SLypXd/XMLaNSUtJQqhV39PHtYEQZsbBz7gIuQNpDSTOh0/lTd6AOiz7AIr9xJXpsIGpZ4AS6qljXzZCh4tS7U1PnWMn2aExFobnpToEXpuNOsfiqX60pfEyeecKOJ+cNqmu2sk4rw4JdpzMiJYTXPXuQkX40bUy7CqpVSSnKxTUShet8wP69r5whzd+OH5MnJ4svC5Ldwxx2nTCcxXMN7QJwIEUUVnwXcR8YeE8pzZhydje4LOl9VfEPCaHtebI2ZWiRBwSx3XHyk9FYR5sABoXrigK/5E8ULLvArsBgzJ4I4PejCG43X8EyYSXxo/TRKHLn0SobZlgYrrSXHb2G9LbNuU2Rj4gjUr0vb+q/nLytkkSsfRkB/vn3epOMNerzcgJUvjUeAO2bUERYyDUOta1NYrrBKYRAEB/LYyvml3tNk2pwEnM5JRYpSGgy6cUepTWDA4r/E7jUq3wLGLYzWyg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b694de3e-d868-4063-e023-08d77caab4cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2019 13:21:31.4589 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bfgWYdz3QiQLXNID/RlWRTvUpSVgUGKtzB57NIaragQvSGEWu7ls/UQBz8TWD0TY0bNqoDYeSzbDnX2XSDKFHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR19MB0143
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-09_04:2019-12-09,2019-12-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 adultscore=0 bulkscore=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 impostorscore=0 mlxlogscore=885 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912090115
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=896
 impostorscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015
 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912090116
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191209_052150_377035_43B4216D 
X-CRM114-Status: GOOD (  14.57  )
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

Hi, 

Did you receive my latest patch fix for the below bug?

Thanks
Amit

-----Original Message-----
From: Engel, Amit 
Sent: Thursday, December 5, 2019 3:36 PM
To: Christoph Hellwig
Cc: sagi@grimberg.me; linux-nvme@lists.infradead.org
Subject: RE: [PATCH] nvmet: Fix req->data_len size in case of nvme_admin_get_features cmd, fid 0x81

Ok, please ignore my previous patches from earlier today.
I just sent a new patch based on nvme-5.5 "Add helper function 'nvmet_feature_data_len' to calculate the required data_len"

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
