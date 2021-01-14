Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7FFC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 17:55:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91EC123A57
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 17:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91EC123A57
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZRJoDu/xql4Rx83MLuiRw8/RIk/WP5+0CidK/fV3nVg=; b=YkBVMicCb95ELdl5K6s+SlWHa
	N9b6AGo65T5VJJVMrksCzU3NpHAi+rZaxvRuZuIUjU0Bo+w3VXi/Tv+cMPi5IeUeGjPrUdLxqvMlN
	OSDK6F6M3bkwQPz0EUdUbuA14eCLAA19pfq8tNtMjkdF6ArBRGP9RvhGYE9rYOC2Zv7mx7FPLhkJg
	im4E0IQ8H9LMLeiACJ0u1jirhmymvhtz+Rn6dmyMbuoynfN069vwX+ZM+aSm/1ysNlQ8x9uxQIkh6
	6nx214fBM+wLP3St0vlVMbEulV5+3XSGwJ9OoTeUuiTwkpZAywkuux10PkPnv8pSxBjwstMdGBB/s
	ZNxYmPyxg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l06q6-0005vX-S7; Thu, 14 Jan 2021 17:55:18 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l06q4-0005tJ-D5; Thu, 14 Jan 2021 17:55:17 +0000
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 10EHqfw1005427; Thu, 14 Jan 2021 12:55:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=d9s7S6uUVCW+Q5MOaDLb1EtLzY0/ya46S9nSGYcRanA=;
 b=gEp+8NBmPxb82+oqhMdwoP8aC8d1sGYoY25OYofXw5IayUlOyV1BvB9aLu17aOGY334m
 vkGs6dptUfW041nbknmvnM98m0VUWLS846lvUuCEeAsnINIlg0/JmWHS//YgFM/dYq8Y
 f3MbRbTFyMkUcT1ch2hwBNmPNQ0iJWpuGA1phwKZr62/Y1/tYovMFCUaiuYS+ojDmH1Z
 jVfcQhi7Tda358ghJ225Nrg3ijzX5Qrn3TqiWAkr3YGO5KGK69LgWp0Z4/gX7jZz+3nA
 J3XjlVDsnTvjCGhswOjL6vJ3fiJk0GMi4MglQztmrBg/75Qd4S0R0cw6Cfu+BHYZIx25 zQ== 
Received: from mx0b-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com with ESMTP id 361fyarbjg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Jan 2021 12:55:09 -0500
Received: from pps.filterd (m0090350.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 10EHp8hV060505; Thu, 14 Jan 2021 12:55:08 -0500
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
 by mx0b-00154901.pphosted.com with ESMTP id 362nthww2m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Jan 2021 12:55:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+hg++TVvCgsPjuMbcCYK6CEd2KZHozuUyDHhaD6nXBh9yuJ1mdNuCeLRxW17wh4wziqdAOwbRS4p0SwgnbUB+rfAOXztCcVllpyLe1wL7akRyhNqzBWOhaEq8se1sGHVL9Uh98R0d7Rzb7NuRij0RBNF3//CvT9hvolr8uMXaZIl9B5w5KLadkMmUuB37nTKXV4VsqdGKFd4AjGG5Sa0K2+9A2F0mSMGBdFVoeYJTbepDWgUZEDHWUb+uAQlx/3LNfqOufTHfdXWzjCfn4rJTVKxJZrav5uah/1K2k4vVSa9o/+i8XODJ58yhofwEuy8BwbvjN8XoT97adPBMj9Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9s7S6uUVCW+Q5MOaDLb1EtLzY0/ya46S9nSGYcRanA=;
 b=Bhoq06YoxIE47BH11haa36XhKlKCfyXMzIFjo81U2KXaIOXIQA9ZZPx0wLo/KEdloDMj7rsB4Mkdo12Px2DnLZ1l/pRPhxnqYsi/nGIGZ6UtQ32LMwyzGtGJIoFushORC7O7BI0Jyj83Cjhp10TYqJ/aAWPbUaKDZ0JIqU+R40lTv6bdDrnO5i35B4KhgIG22fxkuy9ZxJZCRM1IsI7Lo15um7BSZXDrrVDQLyHDCZHf0bpJWYlEd8E+GlRGpOX+oxy0y3FiyT2ZhGw0UuGZA3/7hRIhNuzLkbh6sehrBM1pEe4SzpIuotT5fxwnCZqZBOIXi7E7HhGYvpHciGGyFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com; 
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9s7S6uUVCW+Q5MOaDLb1EtLzY0/ya46S9nSGYcRanA=;
 b=Gzs/aVqox9CLYGOD/XzXaey5xdQA/FeWVvhcZYDYxWMi1hfSgOs7v/TWcy8ub82JDVWYajE06TrTD0jnZrD/p4C7VAY2/emWbisNjxAeD7S3I51vdzyxAzvQzA0+WsnxzdZPR6bHwQj0T9e2FF3qgWY/zz0ExUPaihL8+TPp5+Y=
Received: from SN6PR1901MB2029.namprd19.prod.outlook.com (2603:10b6:805:9::16)
 by SA1PR19MB4878.namprd19.prod.outlook.com (2603:10b6:806:189::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Thu, 14 Jan
 2021 17:45:05 +0000
Received: from SN6PR1901MB2029.namprd19.prod.outlook.com
 ([fe80::6c90:e16f:4aae:c2eb]) by SN6PR1901MB2029.namprd19.prod.outlook.com
 ([fe80::6c90:e16f:4aae:c2eb%3]) with mapi id 15.20.3763.010; Thu, 14 Jan 2021
 17:45:05 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: Christoph Hellwig <hch@infradead.org>, Sagi Grimberg <sagi@grimberg.me>
Subject: RE: fabrics connect cmd with a non-zero reserved value
Thread-Topic: fabrics connect cmd with a non-zero reserved value
Thread-Index: AdbkF7/Xkvzn5zv5R8uAVpaUguhsNgF9VISAAAE7A4AAImyyAAAAMl/Q
Date: Thu, 14 Jan 2021 17:45:05 +0000
Message-ID: <SN6PR1901MB202982AC06FA1A12157B9837EEA80@SN6PR1901MB2029.namprd19.prod.outlook.com>
References: <SN6PR1901MB202957C808A7D493E252D873EED00@SN6PR1901MB2029.namprd19.prod.outlook.com>
 <6e271be1-088b-5a23-0eec-23578f707c28@grimberg.me>
 <69465d48-5a63-5c49-50aa-39c4f921ed4a@grimberg.me>
 <20210114173546.GA1872345@infradead.org>
In-Reply-To: <20210114173546.GA1872345@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Amit.Engel@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-01-14T17:44:59.8249904Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=777a6fad-ffd3-44eb-8b2b-9ed8e93e4eb8;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [152.62.109.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 449f93ad-1457-4c8e-250d-08d8b8b420a0
x-ms-traffictypediagnostic: SA1PR19MB4878:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA1PR19MB4878FE1CDC4EE9C936AA393CEEA80@SA1PR19MB4878.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KqWTS1ZRYU5WMw/w6G9o7kzCypnOZV3N7T5DFAahgXD4cVyzChJavynUNXt9HKNP6iO3qeUYf43Cvxn5NxrU9VsslffIFkLS0Rsz2YS+qUFCIr1ol2hx0PA2/Sh/DC7Cq0OYZJbzVDzsigguxJqDUEqAUaWD8PVoZlM0F7d5ewg+u3GyH1bSW/SvBQrXQBUNpYuaTEDN0RnaTi31HXv4UIc/blGmmbseGsD1QtSOMNTe7h5GDSOEzghCxI74+3rtn0jOx1Y0kvWEO1ISmbSo5lHFFYYON4vRko90YLKYBhBE6XHsEYK/TskaI4ZY8XXgbA5cNlOZYCtK9vB00qnUinNftEBTI8Texg2D7FmADwbNUrSZYK1RyqQsuNJZG+EeQmDpp3TqT0JEBzKGjf5Sdw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR1901MB2029.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(7696005)(786003)(316002)(86362001)(71200400001)(4326008)(110136005)(5660300002)(66946007)(8676002)(52536014)(64756008)(8936002)(76116006)(33656002)(4744005)(66476007)(54906003)(478600001)(66556008)(66446008)(53546011)(55016002)(26005)(186003)(9686003)(6506007)(83380400001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?gyCKgW+/aJOmFAFcBqJ+T3ATwke/VtRH0jqzly7kEtqq+2Ntn1g2CJoWvgH7?=
 =?us-ascii?Q?n7RDdbB/mRWsCLDIjzRkyDEiLNAzebMa77jIeQa9HxfvFbOXDfWLzWPp9kgR?=
 =?us-ascii?Q?7t2i6Me8zvHZ3kvg66VIemTmVN71UH7cJNgOhK9wHPEh+WAPW7Sh97SzauLX?=
 =?us-ascii?Q?BkE0yxYcC+zF5D2PYytLCnD6M/1aFG+t99D8CEoj99f/vsWg6HB91OSK8O5o?=
 =?us-ascii?Q?cuxhnYExUDX5pT2jF1vF3JsDIH788UD7iGNJZ3rpiRPipcWaCFW0hkMh6pDA?=
 =?us-ascii?Q?YxzxrFLkSXHgLFP5vFcDSpCzp3HfyRLHscNPHM1ssNtIUPxY1WrrfXskB3cm?=
 =?us-ascii?Q?nQmpWI9xHE1gHH9nuaZ32uDgAalquRDwsl/6g+swOkWpjo8Z8HbmRsT2RY6I?=
 =?us-ascii?Q?fIMpnXDb34RIu+rNsFLiHpix0V6eZkXNpVHzj7MD9qf/yzBuQYa+lALbcRUm?=
 =?us-ascii?Q?r/zMN8QsoYumDkACxon+MhCxGUHQ8HJ91lKa/Bo+4fs2Xwoyaibpp20bq3hf?=
 =?us-ascii?Q?bQ4HYoW48cDPOikWyco47KQhTXRvJQdZG77qUy9IA3trgMws6kgW7IXs5GvC?=
 =?us-ascii?Q?sPd8CDnRKfNTXjeDQKe5HN0sbDviGCZyvs5GPVLcPiAamUwg8lhllQ+OzJKt?=
 =?us-ascii?Q?ETRhIkweSyNkfTeFAj5p0XQNOMjoB68GWc9ZSl4NZwC1nGnDq+yPgfAbDqLm?=
 =?us-ascii?Q?8UsVNipnxs0fg366Z6kJJCDMKzzemgtw0NWBGeq/BJW3Yj7JqrYgwYehhU3Z?=
 =?us-ascii?Q?tdMrY+BlOhV3MgkgqA+gQ29GtGQXlRbJZ+ov/d3YhZRM+vTbFqfSRfd+2Wu7?=
 =?us-ascii?Q?RbQZcYXH/jxsOR8P8xFo6agEb012ZhBdX8avnN+aZodzyr1dezhzQKw+trOi?=
 =?us-ascii?Q?QMQJ7qelRB8VpOF/z2rlFTSJ28yFzEZI3wJL00WfAW2rW45R42+b4DKh01zF?=
 =?us-ascii?Q?lTHStLhzmFzZ+OyzGP8ltPMxhZMnrWyGxpFTIVdKMsY=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1901MB2029.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 449f93ad-1457-4c8e-250d-08d8b8b420a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2021 17:45:05.3335 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JK9Wbz2yJKf8NGGx10Wy0XhR90x8JEh0K6YhKDYiNUJgR6vAGmkXx6w7WQUZt3W/dsesdxK23kBemhgQQbibcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB4878
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343, 18.0.737
 definitions=2021-01-14_06:2021-01-14,
 2021-01-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 adultscore=0 mlxscore=0 mlxlogscore=732 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101140104
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 bulkscore=0
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=852 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101140104
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210114_125516_699751_FAA07ED7 
X-CRM114-Status: GOOD (  16.14  )
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
Cc: "Anner, Ran" <Ran.Anner@dell.com>,
 "Frederick.Knight@netapp.com" <Frederick.Knight@netapp.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Since the data is coming in the form of an sgl, the reserved bits that the spec defines are not really reserved.
I would expect that the spec will not mark the second byte of connect cmd as reserved
(These reserved bits are not cleared to 0h)

-----Original Message-----
From: Christoph Hellwig <hch@infradead.org> 
Sent: Thursday, January 14, 2021 7:36 PM
To: Sagi Grimberg
Cc: Engel, Amit; linux-nvme@lists.infradead.org; Anner, Ran; Frederick.Knight@netapp.com; Grupi, Elad
Subject: Re: fabrics connect cmd with a non-zero reserved value


[EXTERNAL EMAIL] 

On Wed, Jan 13, 2021 at 05:10:05PM -0800, Sagi Grimberg wrote:
> OK, now I see the issue.
> 
> This appears to me this would be an issue with the spec. As the 
> connect data (like any command payload) is coming in the form of an sgl.

Reserved fields in host to controller data structure may be checked, but may also not.  So we can verify anyting we think is to bogus to pass, but there is not requirement for the controller to check every reserved field or bit.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
