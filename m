Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F2C5C52D6F
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Aug 2024 20:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qrYjZiE2m5wzOTJFZBs4Tu4EWjPF9pqwbYw6/atXw8Y=; b=Uqmt79iMKt+xeJ2GxFbRQjTThe
	bwLN5f/rPt1BkGiOPweEEfXtP8tPWoHoGsbwGrXv3ZKjfpsmYc1nxV3uDUM4l1/5lDjyg6d1TYOHM
	iVZPNTLb1BcqySt9WYIDYextoeW6mGPg8zNsaE5HvjVBaL8CEfNC0Zg8gK39jxO+MgkyR63ETmp7N
	KJE85QPPD+HBvuNUF2QfdyVS/I9MKjjWQp6KUm3+8joAZHHRfj/IUSZK0uFtI/A3NoTsxS0TGMx8V
	lSZgX1JT1hf0YgohGh1V6kNeroY8OY0Nk/NGSlVQZG9kSdJ3FMxjrxY61THTsNtQKhwPPHnH3SYgS
	2p7B0Pjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbQnx-00000002oLO-3nQU;
	Tue, 06 Aug 2024 20:29:13 +0000
Received: from mail-bn8nam04on2071e.outbound.protection.outlook.com ([2a01:111:f403:2408::71e] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbQmz-00000002nsl-2lfp
	for linux-nvme@lists.infradead.org;
	Tue, 06 Aug 2024 20:28:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KArArw/A3Dr8nFFXOZuDkin7BD8MseRljuFrDKHI2+DYnylf+hOwwMYAdl4KTBVvtUkCUOE4lPNuMEruNdCe6roC4Gjj+eExmjFFXtdiFg3SQpbClXR94sjQGmIr8BpEr+jyzRTG3iseugbUPuVDRgYptvTeyNV2I2mjOMya0R2W9OVuvpTRl2KCMz5g5iOV32+NqCkMxdxsfI9f5YA9/l5NcNVoENHWk6lYK5maivLazPkfF1sIdGcHLuWP3cHZulNGKeHABYMyMQPvN7adf+8m1FC+sZ7YEVzk5q+lFFdZs7VoDjyOs4CkFZsUhKmtQLLn6egMqZrlF6vFbc/4bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qrYjZiE2m5wzOTJFZBs4Tu4EWjPF9pqwbYw6/atXw8Y=;
 b=ADftumClqb+qca63bctLMQRyz5utHIVXperl429WXXeKwnheiPMYMfNdIskNRzid9Vye2t3Kqknzarv4DzkXwLsJdnwG7B9fW5NEAMtXPKMs8BT7iXQ5LdUBePJpcapovMYF1EKbcuO+8aiMdV3jEU+iF1crDlH9IQwnRNrAXSubQf8SoAGoytMKhZFx6otfAbXBRcZrQOgG+uQgjktcKxaWTTFQ5uXL/6y5BJJE1b/firgqefJ1gjTls2vWLHeiI1Fjoxf8r28B1wbMFvG3Qh7I7YKBALEyyNUJHSb5xze+FX4cThJBaDvAdoD6gaCUxUcpACVO/2L7HoX/tFCN5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=psmnv.com; dmarc=pass action=none header.from=psmnv.com;
 dkim=pass header.d=psmnv.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=psmnv.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrYjZiE2m5wzOTJFZBs4Tu4EWjPF9pqwbYw6/atXw8Y=;
 b=fUP9q44rXUIhe4a77TlvlvDwrl578ZAKC6v2yg2eXapOqko+Rs86kG2ayv0lif0YoYAcACw3RRadtB1xNQt4BJqoxKF3mT4ghJN328ky5DLLdD5EWXxlo6DZR9AEPAklkHH18YSF3Rjz0yMND/krxXfBMM4VUoj16F6Iv0rH0qU=
Received: from SJ0PR03MB6501.namprd03.prod.outlook.com (2603:10b6:a03:386::18)
 by PH0PR03MB6690.namprd03.prod.outlook.com (2603:10b6:510:111::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19; Tue, 6 Aug
 2024 20:28:05 +0000
Received: from SJ0PR03MB6501.namprd03.prod.outlook.com
 ([fe80::520:c240:b60c:57b]) by SJ0PR03MB6501.namprd03.prod.outlook.com
 ([fe80::520:c240:b60c:57b%5]) with mapi id 15.20.7807.026; Tue, 6 Aug 2024
 20:28:05 +0000
From: Eric Robinson <eric.robinson@psmnv.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: RE: Disk Says It is Full But There's Nothing on It
Thread-Topic: Disk Says It is Full But There's Nothing on It
Thread-Index: Adrnh75MzNJkXFWcSMupUSjuDERcWgAbfTgAAAMQYXAADoXcAAAAtK2w
Date: Tue, 6 Aug 2024 20:28:05 +0000
Message-ID: <SJ0PR03MB650188563CEBA3B2E6D2130BFABF2@SJ0PR03MB6501.namprd03.prod.outlook.com>
References: <SJ0PR03MB65014AE3AD77A352D0C88855FABE2@SJ0PR03MB6501.namprd03.prod.outlook.com>
 <zsyfgzmoyvjgvywkbkgtxchpfei3pyfcaf2mzu4gltraf34ymx@vocftyxjmedn>
 <SJ0PR03MB65010C717291244293A88CAEFABF2@SJ0PR03MB6501.namprd03.prod.outlook.com>
 <vqbcmbet5jfbhmjfuhr66om2ta5lw2octpynjdzyvk66ok47kd@oj7vhatyai3g>
In-Reply-To: <vqbcmbet5jfbhmjfuhr66om2ta5lw2octpynjdzyvk66ok47kd@oj7vhatyai3g>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=psmnv.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6501:EE_|PH0PR03MB6690:EE_
x-ms-office365-filtering-correlation-id: 506423c6-4950-4f81-6faa-08dcb65646ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?M++WtHmTxtmPobkIomuTcmqiHexq4AGJsvdlxRUaERfdGOLf7siWnRwjoNA5?=
 =?us-ascii?Q?BJiM2ZsKe4nxvvuxl/PE8oKFcfoR8kV6g2sukDXJQi32DkHHyl2kDTszSSFY?=
 =?us-ascii?Q?2xJEb13AUkWI5SYKrZsyEK8qS9hVgPdKIJKH6iKYgLZffO6/e0IK2ceDyFoO?=
 =?us-ascii?Q?2/OMr5ebf6B1xMfwFJgxyMQtZulmu5u7kHGCvtnN4+ItgrVC3CjcfhFRjW5r?=
 =?us-ascii?Q?iN58+5PzBXmSOnBcuhRQuuX+6cClyLh57N4Ng0Reb+68h7Y+cIfqxz/n+2U3?=
 =?us-ascii?Q?DRTLL2rhKpr7molJ9ttaJI9QlalbmSpehcEfJuopyEXY6fQQu+gwhLpdfOnC?=
 =?us-ascii?Q?ZVekpfxvQcGHBQo7GXpn0THm6CHK6q2ojy8VBVNb+5cFzcLsxB4gfRmvjUv7?=
 =?us-ascii?Q?qlwK3VntVrlJmEzSBmmwWxRH0r1X1TfWLZ5kWqTotNisvCkfMU3MhMndOvmk?=
 =?us-ascii?Q?eLi+ES4zqUS1HTZaPAIo9h6WeoZ8NVFio0Y8BRaMFcuCXyUHn5POi7x99i7d?=
 =?us-ascii?Q?GOJYHYMoFxh/KM7babdgi3LGm+2GcIuq7z1GbmZjEYUYdq+TucGTf/uZFCYW?=
 =?us-ascii?Q?vtY00AmYfcTiwLwlLpEaSTsuUhkmlTlahed8S04HtRZMYJ6ErbAOpKFc5mbH?=
 =?us-ascii?Q?4e81n7Q9ox67BN2SvZGr4/GFxVhGE6xInR/2tnmnwKh5UCdUq/+D+3p3zuRb?=
 =?us-ascii?Q?sJJNJ34z38zVo1lR8AzIHNduIyAMZP7P/tpv+Zrme9YvVOEyObBj9cGRnQ/E?=
 =?us-ascii?Q?UB3QiXNhusXCvDrJ7HkT1BiAFJ1kSWMBYrb3nrsMhwfLM1CgyL/b/guyy3He?=
 =?us-ascii?Q?Gn02CF+tAhORU5G4U/XMLBttVkPbS4MKDv+LVc5lqg6LgEjj7BLXvYuTQ3nX?=
 =?us-ascii?Q?ICjTGpoQ2dC5DXBgYVWclfoURYptXXjPFCXlMxr5N7xzJKu3MLHuo0E4acD8?=
 =?us-ascii?Q?3l+oCIHLA/QacXfnCveQuWB1eJKEVQjZsPAMFQP4hkrQ57vFnZ3JY2P2sOJG?=
 =?us-ascii?Q?xhLIUEF+8zFNA+VmQFk2Y+j0q9IVOmSl/SpykC7zEi3RnxlHPjR9BQXiJ99z?=
 =?us-ascii?Q?wdlncG81orOkaJgalCgu3BsxJ3hQjXaabWIYF2WxSVkqUzFOzUqNfmBJwBhM?=
 =?us-ascii?Q?y4b7r7BxZVRzg3ZjI4oJ+QnQ+tEpzrywkoSWFcSVypUtvt4t31XtqgFsbqhe?=
 =?us-ascii?Q?cVBzrhaGUgEO3ZNE1tZmXhFOKM82CSgdNNaR6zeq8TOWqbghZrwXems9eGh5?=
 =?us-ascii?Q?Q7KCqSR8DjPFWZ8P8w0dWsozk0AouPqGYqSIB1FqxdygU1PG5GsAC9XitoHt?=
 =?us-ascii?Q?ev2zAF9+pHthjLnY3HaW0xuLful3KfS8CeORLGovec8+JaYYv7gsAQ0Lj3Zd?=
 =?us-ascii?Q?TWT56cdbhxlWhmNL9BfqsAh6nuYc1NIDvSu03uWlNAlk+aswyA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6501.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Wniy0+NVRmoRmA76gGr5t3/l4Ess5hdeBrCPGet/U4LU8igAzOyrZ1A2sUDr?=
 =?us-ascii?Q?tL5FAqH+uADTby1pvZ05HoFosCWuPDtBvMPSJcG85VQiNLXPei4wNGv5FaCh?=
 =?us-ascii?Q?galxMNaxxTDGHMIS4SoeFnRPhJfbwOROmQ2071FNCETC2XSDgJyxDi+gaBK6?=
 =?us-ascii?Q?p5oSPdUmmOx+MmU+Ie8RNNOGdx+xzGvgSasYObeAdzpwh0Zd8h9xoPwYNYnt?=
 =?us-ascii?Q?9QdslZDAy7SFaRu1NnZg5JmTeRbxXE1gGEtvmLkcisfIIOaUPq+Au6M4v0OW?=
 =?us-ascii?Q?OTyTVhcrvM7CqeXZIwJNCY9NUwRrCN0U9JwTE5TWsj/OjElX21IKMrEPBppg?=
 =?us-ascii?Q?tKW/HX48ES0KTLqfhOWUEot4ZHzYy3J1sl4Er1w6hEu/pjUgK/sEH0U97x6R?=
 =?us-ascii?Q?HqL3M2ytAayt9W3SlQVrh8QrIUv0c8MH/oiCUPfNPxeA7kCEwIGIxGJsu7q7?=
 =?us-ascii?Q?wQmcRcPr2+8bGViDDQWwBD60LWmhRqNU55v3xXA2NyUAtEyNdkTrwgzRLKrg?=
 =?us-ascii?Q?a390uoeu3rZlX55tzshyxpUiCoL431+RmKnIAdtuuMJgxRGsFmOqKSSSNDuu?=
 =?us-ascii?Q?cOadc4w8FLjLQRIA0uRgfUitAJWPdEaiPD23wGZH8Z/S8CGZImGRxCUxUD9P?=
 =?us-ascii?Q?de5eMzhbWbZdXTm0vN6pGA0xsElS62NR3dz3P58KCBc3tS5AGb3KkKFTMe6M?=
 =?us-ascii?Q?5qgvxXYhcAEQ/rXLGB9IGN/mB0a3vAyKdlJgg4DCnu45yh9UUzG8cUMSD/ys?=
 =?us-ascii?Q?0BH8Q6icryG+vBGGp+T2ozDSfKlx50ITwjwsue4ueakGQXuhl/xdRS/kE0hX?=
 =?us-ascii?Q?hI3GZzpmHKFq4SuVGSouQ1z7B2UWY74dP4k1Vprd9L+rl7qiQ4Byri83j+jw?=
 =?us-ascii?Q?66Hw4QMheGF936BJ8UPw/lELIkRjXmOAdaiAAMT0Uo1CVth5TllXNvcbnSXx?=
 =?us-ascii?Q?Mm7zwETwQJ6ywMbNl7+viYGYTdYeYKKuFr2xWmWjjt0A6MEs7C9tyebBrLyP?=
 =?us-ascii?Q?5ow4hggqsUjuF2erTRu/aCat6H8KOFuxQeaL6HPrflFuBvdzm2EFBKpgXCfP?=
 =?us-ascii?Q?YRUncWHQUMdbw+1V/ubil1nXaYmmyeIZi1Frn05iPpj7W7095doagcbbilAG?=
 =?us-ascii?Q?3CtpUGVKcrKjMpQzXJte/bpJ7NEL+TIKpPsorqatk5WaSxapL+EctzAsbeLb?=
 =?us-ascii?Q?2hSsZPZSHNexuKO11EQ56QMke+v59TbTO/lpb44V9+ceqqGk/vqQ10bnIqT1?=
 =?us-ascii?Q?/OJ90k77YIChdzPQNaOsjdUuHB5+lftxKYLC/8KLjPcQvNE82ZYKzey3qjMK?=
 =?us-ascii?Q?w/29D2hQRbVOIbtonP2udxgAZDPECTGw/5dnBniLe5xAaaIMA0pWKqukyO1C?=
 =?us-ascii?Q?r8nbFA+ArAUzyDS+KTZMkxwAtf88M5gNnr6yTfAzMQ2/ZEdv8hDWmOFRpDm+?=
 =?us-ascii?Q?P8BrmsEVFsy6s7nqDrltK9SzrV9+1kYOSzsf7DmaQ36YB7Bo6bgtyqSTV7JZ?=
 =?us-ascii?Q?z8eUs74fF1B3+KZCYcFv0bBdKOnjTNsoa06funJZ2927mlJePsvkiTw//JAw?=
 =?us-ascii?Q?sKzNTehqxjBtm/MboDXznxTSn/q8Rzki2qgpQQZY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: psmnv.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6501.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 506423c6-4950-4f81-6faa-08dcb65646ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2024 20:28:05.2790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 41c01403-a265-4172-8028-7972e133fa87
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R3RRON2j9+VC///iKGJHLGXBrEFtnKCIEz4XSh43YZMBAZVkc+FjLRo0jySbqQoUbcaYG8vxSNr62LSnp4xVaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6690
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240806_132814_059949_6ADAA7D7 
X-CRM114-Status: GOOD (  17.57  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> -----Original Message-----
> From: Daniel Wagner <dwagner@suse.de>
> Sent: Tuesday, August 6, 2024 3:06 PM
> To: Eric Robinson <eric.robinson@psmnv.com>
> Cc: linux-nvme@lists.infradead.org
> Subject: Re: Disk Says It is Full But There's Nothing on It
>
> On Tue, Aug 06, 2024 at 01:11:23PM GMT, Eric Robinson wrote:
>
> > I was on 2.6.5. I upgraded to 2.9.1 but got the same result.
>
> I assume you also update libnvme alongside, because the bug was in libnvm=
e.

Yes, I upgraded to libnvme 1.6.1.

> Anyway, what do you get with:
>
> nvme id-ns /dev/nvme0n1
>
> This should help to figure out if nvme-cli gets it wrong or the device re=
ports
> someting bogus (nsze, ncap, nuse).

[root@store11b zpool0]# nvme id-ns /dev/nvme0n1
NVME Identify Namespace 1:
nsze    : 0x6fc400000
ncap    : 0x6fc400000
nuse    : 0x6fc400000
nsfeat  : 0
nlbaf   : 4
flbas   : 0
mc      : 0x3
dpc     : 0x1f
dps     : 0
nmic    : 0x1
rescap  : 0xff
fpi     : 0x80
dlfeat  : 1
nawun   : 0
nawupf  : 0
nacwu   : 0
nabsn   : 0
nabo    : 0
nabspf  : 0
noiob   : 0
nvmcap  : 15360950534144
mssrl   : 0
mcl     : 0
msrc    : 0
nulbaf  : 0
anagrpid: 0
nsattr  : 0
nvmsetid: 0
endgid  : 0
nguid   : 3647373054a015890025384100000002
eui64   : 0000000000000000
lbaf  0 : ms:0   lbads:9  rp:0x1 (in use)
lbaf  1 : ms:8   lbads:9  rp:0x3
lbaf  2 : ms:0   lbads:12 rp:0
lbaf  3 : ms:8   lbads:12 rp:0x2
lbaf  4 : ms:64  lbads:12 rp:0x3
Disclaimer : This email and any files transmitted with it are confidential =
and intended solely for intended recipients. If you are not the named addre=
ssee you should not disseminate, distribute, copy or alter this email. Any =
views or opinions presented in this email are solely those of the author an=
d might not represent those of Physician Select Management. Warning: Althou=
gh Physician Select Management has taken reasonable precautions to ensure n=
o viruses are present in this email, the company cannot accept responsibili=
ty for any loss or damage arising from the use of this email or attachments=
.

