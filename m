Return-Path: <SRS0=EAhk=HO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F888C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Feb 2021 07:55:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E08D864E65
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Feb 2021 07:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E08D864E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vJkcZV8OvKK7oXyQk0GZBO4Wlll50lQcRGRNreVfxpE=; b=e3GzqETkeFEMMUg9BNJYFAfZRW
	pjcq2zIlCYxoOZR400AvvFB/F6rgVgF//cXI9HC+XpzuUhBARIjO3BBJ4zukcTXI4y8WEHXFtBUA/
	7ltcVtUImvZba/SRMM/2kJ7Ar6QGiNrn5IhLPWkxhPgab/toY1nwR1yB/ATypOvq9MO1f/p0wEMZC
	PtxVyOiZ1GrTziTJCA6NWtqCYQp5eWjvgjgXjTlVxSlKOFdU8WHMBZzAL/PEo9TFIpcpxs3e930it
	NQgESBFyFos3uKSqRchBhf6JM+yrbMiI+jW8xFCB4HcLSeNxFsb2UU5uQv2Ho3Tn99YVALnD2SCYF
	Di+E6oPQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lATIT-0001Mk-R8; Fri, 12 Feb 2021 07:55:25 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lATIR-0001MD-Ay
 for linux-nvme@lists.infradead.org; Fri, 12 Feb 2021 07:55:24 +0000
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 11C7qYfW011070; Fri, 12 Feb 2021 02:55:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=utTZ8ohDjpa7mgBXxeDN/TRzhlKW9EFBp9aVadidTZI=;
 b=L7vhFiWnkXtMxrdOxVgGeQ2ZSY9e4z0SlNgILJZ8maboIcz6eM0I5TtooYndhH0jOTDo
 Z5Z6jeqQYUqvO/+YwdYXDNVICMAkAlfmAp0hLz4XMfCuzenNcJBPMW7f8O50JqYnem8p
 XJzN/+tgBawoqKsf5+Te0DZ740pWq3DBKbCvPxlR7mIqdvC7t+KvE2AYzeYZAnzBqL4+
 BDZrCVs1mXhnUs1WPRgRAhBPAVjAMk7z/1tU2tlyIkSnCo2JXXsemCLPDlduOWVDtQuh
 OfayzIxkndXhYMDmrxOvOxBM9AH1Ec5p+PC4UiiogjQNVdR7coNjMv3G7DioiqbeS83e kw== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com with ESMTP id 36hq7cbx32-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Feb 2021 02:55:16 -0500
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 11C7jnTI122727; Fri, 12 Feb 2021 02:55:16 -0500
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
 by mx0b-00154901.pphosted.com with ESMTP id 36j9f5eygn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Feb 2021 02:55:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4OxQQh8S3NHvwFVF43plkGyPMwvYU/4OGybB1mAjVHscFWyKKaJLPj2gFUdRzqaVaWXK5eUTlmbmd73urBzpEi2CzujUyIti1BgDHtJu6R8uF4VwATRBotR/aJXuhFuEt1kLQvxD8cKsl8uwVDG7SHCKXQX0+WKgKgNgp9lY0oYbDhRhbffwz1s/6WHdXaRMEZUUW3R93iRIbLLt8sFnbHA8ohCjEGwcdmoq/OqPGNHCeC04Tg/h8luxdtoytnk1VZ8Dkwe9bj7p58vH90O3ZgJUZ7ke5H9zIlQOyprieAcOXD4XmFUbUb9wQi/jucPew+ksSlcliiToQ37hacjzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utTZ8ohDjpa7mgBXxeDN/TRzhlKW9EFBp9aVadidTZI=;
 b=ABKKiBcCZPR7ErWEcpL1zZiRLRhecAuw+C32NBAJZg317UgyEGwHhfgzAXy6IGGUEpHE0DPJ2kngw11L1VqX+MYCNT3PEV8S04BSlZ2fM9nUKV5BVUEFG4in5jmXlFDS2ETlP1PWE2N9In+/qzYMCT0QjeOEPHcZ5tpfT6yVLfyw94YnAIXZn4EqUlejUcOF1E3ha5Ry/Q3czIcYVqywqA2WXolj7pAtXxHla2yo7kRTJqjIJ44/MZyM+L6iRqKwCNyWczV08CJ3ro9aKeOgUxHyX0kIr/VZKhJDdtUXvCl6nxJm4sx5iT2178v7WyeDvFAIzS8pKlM6PzmJztn//A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DM6PR19MB4011.namprd19.prod.outlook.com (2603:10b6:5:22b::15)
 by DM6PR19MB4058.namprd19.prod.outlook.com (2603:10b6:5:24f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26; Fri, 12 Feb
 2021 07:55:14 +0000
Received: from DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::a416:4c53:4922:67d2]) by DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::a416:4c53:4922:67d2%6]) with mapi id 15.20.3846.027; Fri, 12 Feb 2021
 07:55:14 +0000
From: "Grupi, Elad" <Elad.Grupi@dell.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: RE: [PATCH] nvmet-tcp: fix potential race of tcp socket closing
 accept_work
Thread-Topic: [PATCH] nvmet-tcp: fix potential race of tcp socket closing
 accept_work
Thread-Index: AQHW+/e/dRBHiedMuUyXvtpAN8PgbqpUL6Ow
Date: Fri, 12 Feb 2021 07:55:14 +0000
Message-ID: <DM6PR19MB4011C3BCABE1663D864ECB67EF8B9@DM6PR19MB4011.namprd19.prod.outlook.com>
References: <20210205194725.625035-1-sagi@grimberg.me>
In-Reply-To: <20210205194725.625035-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Elad.Grupi@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-02-12T07:54:09.4701440Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=b44303e3-33c4-4710-beda-dab2eb7b83e4;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=dell.com;
x-originating-ip: [152.62.109.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c68a73b0-57db-4049-9740-08d8cf2b882c
x-ms-traffictypediagnostic: DM6PR19MB4058:
x-microsoft-antispam-prvs: <DM6PR19MB405852E549195142D80AF1E0EF8B9@DM6PR19MB4058.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5ANM0if+xq4BJVT12Pdg1tMy4GNHIrKac/MEiB6uWc6ZS2jbdxdEUZlaNNbvxvmr+bdyxGOzysOiU2i+7QwRmJE32TLfvqEqEN99EA7DmtlNGidvDZWOPkjSpRuk2++Km2uJahoJy/C/w4C6WgOv3v10dSlH7x40nqqi0S7STm2eaTFIDRS/sW1cVlgs49rcvb7reUAe7EbWWSRJ2FpPgYJVqdacOXGvoaEikztw2kztIsUpGKkPQ/PQc/ri/gRPuTNGc+smI3iwug1MkFKmnt5Xknh+1U7VGIZ4rxVR+4cNwyG5QrU+U6fvHqKWS8cffe8fJssFTUQic2U4hB4WmfIRFKMHupSrYZZLrwtbDNxwUrTyTbplsKbnROhOcxEj7loKCC3aKW4CWk1ObG0i7fXq8Q4BQ0KJ5zGH5HxaqiZo2zRVLGi770XzVlJw9Hs10P4e+GL4NNjFLPZVHU8s5vTI90S4JyoTwUatfhH+8kGAAuGaVvz3xYaPav8EL/is1bPxqrLWn1Us5jZ6KlYS6A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR19MB4011.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(366004)(396003)(376002)(316002)(33656002)(786003)(110136005)(5660300002)(26005)(71200400001)(66446008)(86362001)(478600001)(8936002)(66946007)(76116006)(55016002)(186003)(9686003)(83380400001)(52536014)(8676002)(2906002)(53546011)(6506007)(64756008)(66476007)(66556008)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?cExjZ0g3QzlFYzdkRHRsaG1aUVNnek5XMGY4ZitWeGZmckVzYkdiYmhoVTdj?=
 =?utf-8?B?QTdNV2kvbHRLaDY4ZS85T0h3OGVIT2pkMjlGb2xXOTVXS3drdTVqdWxpS0dp?=
 =?utf-8?B?Qi9qOGJMVHRRS1lhWVhMaEliTzE2R3dQd0hCc01MQWR3b2VEVDNsbEpQVkNF?=
 =?utf-8?B?cGlxekRWNDFzdXAyK3dLUS9jWitLTzJOZldVY1pIMHBrSmQwS2RaaCsxbE84?=
 =?utf-8?B?b1JYei9GdHB2RHFManRpVWRKeTVMMytkZXFhLzk5OFpkdDg4cXYyZGcvdmk2?=
 =?utf-8?B?WS9ZOHhvOW9ESXl1ZHd5QlNiemxjVi9EeW9wei95MElsa1ZYbWgxaFNiR0Yx?=
 =?utf-8?B?VDd1TXFDNTh2ZmdOajZDeVVBVjl5c0NzRzdjN2tPSXUva1V1M09iYUtIdkhF?=
 =?utf-8?B?dzF1YU11VUZSWUY3N2c3cjFQYzFqZ1F4S2ttK2tBWUpVcVJwTW1WNjJoNFhZ?=
 =?utf-8?B?cUE4Z2d1Z3pLeDhLV1RuRWpnWlUyRmd4b3RTZDNSMEl5d2krK0FDcXk0bHVL?=
 =?utf-8?B?alZ1VGtvWWJweTQ0aUZPWW5HSnJCbXkySEFnd0FYWno0VUZtVWJXaG0wWmpv?=
 =?utf-8?B?anNEZzNzZURNQy9MZGl3R3NPbjJ6R0h3MFh2aHlSL3FEbERyMExNZEVhTmtN?=
 =?utf-8?B?YmJiM2lhelV2c1R4R0o5RCtJK3N6Q0tZUXRGWjRlQzRHMHQva0M0VTE5L0g2?=
 =?utf-8?B?RWhORmVtNHp6YThoSjdVdUl6c2FQV2E2c0dheVRHMGt6UkRCbGZDUGZMQURD?=
 =?utf-8?B?L2IzTEVub09pLytYTThnOXNyMERiVG5VVGhLekxJbmc5dFNlN09kdDdoK20r?=
 =?utf-8?B?Q0dYNytxdUFiRWtIaVY4R1hqbTNhYkNSZkJWbVZXbGM2ejExMnBPQ3k0TTB1?=
 =?utf-8?B?L243U1o0Q285d0k3OENjS3JvNkdmV1M3SHBDL0RQcHV4YzlOZGMxQVExenRj?=
 =?utf-8?B?SkJGVHloNlo4QUVkdHprOGJiMVJRVEp4ZGVOaklXd2NDOWV5Nzhqd3FONW9X?=
 =?utf-8?B?Snk5MDh2cXplTlFKYXN6aHo1OHEwcW9ZZ1htQzFrcHRBc1ovS3h3S2p1WEtJ?=
 =?utf-8?B?aXFvbEovQWI4K0lPUklibEMxYWpYQTNoZllmNlcra1VQbzdjeUNPYituKzRZ?=
 =?utf-8?B?dE1Tb2RFM3FDdjN1VlNyU3VnNE1GNUtmZ2RoQk9oTXRzTXlJRzZWd1N2Wmpz?=
 =?utf-8?B?bU8wZDlrcFY3RmlpMGJtVDRnOTlKZUJWZi9SRkFreWZsNmkzRjArK2FZK1Fu?=
 =?utf-8?B?WnFuT3hkWjM3Q2oyVUlNaWZwNEQzT2NFa0FGNjlGc0xhd2dIMXNJU3JFMGlY?=
 =?utf-8?B?YmJIenpFanRpUjU3NFY5dk05Y0ZmVHV4VUlPZk0zdE12QlNsdTZQaWVvRkRD?=
 =?utf-8?B?UytpVnhRcU9NaDlZV09veXlxZFJVaGNwRXpZazNBRFZwRWxNTTVlb0xJKzRw?=
 =?utf-8?B?cmphYm1EQm5xbEZnRHBsQVI3UU5LWUlVUFdlSUpYT1YvK1FOVEFtbXExK0dX?=
 =?utf-8?B?NVUrY2lXUjdNam4yRVBxUTEycVovM2c3ZHFCOHkrcVhrcWg4WDhWN2Qxb0lF?=
 =?utf-8?B?QkY2NHc0NE1zd2lIN205Y3lhVDkvSXJGdUtObHZqSkdvRXhIMEVkQ282Y3hk?=
 =?utf-8?B?Yy83TVQ0NmExZjY2eE5DQVhUY0NNMWdHVEVZeEo4bFlzYkFJUkhZdmtDOGFv?=
 =?utf-8?B?Z3JweDNabTFHRHRMOWtGMTZDZVYyeFFzcSthMzJCU0hBd05xM1Z1SCtuUkNG?=
 =?utf-8?Q?DD4h5/uzqlbG/q49Mp5ZVPrrGpqLOPot5umCUvW?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB4011.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c68a73b0-57db-4049-9740-08d8cf2b882c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2021 07:55:14.7375 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qkwxB+Vw2MTHHpbKn5V18pXoVEsDLayGZfEMnPAAAf97/3pafvpsPCUN9WY+uvPx44+ayKFYDMnyZQZ3BDtlpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB4058
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.737
 definitions=2021-02-12_02:2021-02-12,
 2021-02-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0
 phishscore=0 clxscore=1011 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102120057
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102120058
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210212_025523_489493_5DD5E317 
X-CRM114-Status: GOOD (  27.59  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Sagi,

I think there is another race in that solution.

Please consider following flow:

Thread 1 taking sk_callback_lock and goes into the else block (state is TCP_ESTABLISHED), going to line:
	sock->sk->sk_user_data = queue;

at that point, thread 2 invokes sk_state_change, but this is still the original state_change callback because we didn't set yet to nvmet_tcp_state_change.

Thread 1 continues and set the callback to nvmet_tcp_state_change, but the sk_state_change was already called and nvmet_tcp_state_change will be never called.

In that case, there is a leak, and the queue will never be removed.

Elad

-----Original Message-----
From: Sagi Grimberg <sagi@grimberg.me> 
Sent: Friday, 5 February 2021 21:47
To: linux-nvme@lists.infradead.org; Christoph Hellwig; Keith Busch; Chaitanya Kulkarni
Cc: Grupi, Elad
Subject: [PATCH] nvmet-tcp: fix potential race of tcp socket closing accept_work


[EXTERNAL EMAIL] 

When we accept a TCP connection and allocate an nvmet-tcp queue we should make sure not to fully establish it or reference it as the connection may be already closing, which triggers queue release work, which does not fence against queue establishment.

In order to address such a race, we make sure to check the sk_state and contain the queue reference to be done underneath the sk_callback_lock such that the queue release work correctly fences against it.

Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
Reported-by: Elad Grupi <elad.grupi@dell.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/tcp.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c index 577ce7d403ae..8b0485ada315 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1485,17 +1485,27 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 	if (inet->rcv_tos > 0)
 		ip_sock_set_tos(sock->sk, inet->rcv_tos);
 
+	ret = 0;
 	write_lock_bh(&sock->sk->sk_callback_lock);
-	sock->sk->sk_user_data = queue;
-	queue->data_ready = sock->sk->sk_data_ready;
-	sock->sk->sk_data_ready = nvmet_tcp_data_ready;
-	queue->state_change = sock->sk->sk_state_change;
-	sock->sk->sk_state_change = nvmet_tcp_state_change;
-	queue->write_space = sock->sk->sk_write_space;
-	sock->sk->sk_write_space = nvmet_tcp_write_space;
+	if (sock->sk->sk_state != TCP_ESTABLISHED) {
+		/*
+		 * If the socket is already closing, don't even start
+		 * consuming it
+		 */
+		ret = -ENOTCONN;
+	} else {
+		sock->sk->sk_user_data = queue;
+		queue->data_ready = sock->sk->sk_data_ready;
+		sock->sk->sk_data_ready = nvmet_tcp_data_ready;
+		queue->state_change = sock->sk->sk_state_change;
+		sock->sk->sk_state_change = nvmet_tcp_state_change;
+		queue->write_space = sock->sk->sk_write_space;
+		sock->sk->sk_write_space = nvmet_tcp_write_space;
+		queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);
+	}
 	write_unlock_bh(&sock->sk->sk_callback_lock);
 
-	return 0;
+	return ret;
 }
 
 static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port, @@ -1543,8 +1553,6 @@ static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 	if (ret)
 		goto out_destroy_sq;
 
-	queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);
-
 	return 0;
 out_destroy_sq:
 	mutex_lock(&nvmet_tcp_queue_mutex);
--
2.27.0

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
