Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE61C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Dec 2021 07:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4w/vshR1I5GGOjzDqTjQTQW+8sVauY7cgSlDmyileeE=; b=DgByC/J+zXwbWQ7d2a51CYg6go
	Pa5tyD7p3JCCzCeVm6h3xsRY2VR1KoCB5w8CCr/dfNyfbhBFf72EVU9BE4PV6vmdmJQLeqkWTLchE
	Bh1FXzgKMF8OAHAatCK3yVGSy9HCPbe0g4XZszdMR08bdLJ+qOYwwde5jcArLOAVaVMuaFDC74Kh3
	tQmhmbySwzeGSSTZzTEuE0e3xhUMMpdKuZRsGywHbJqG9+lfZnjOfsHg8He1xeKTcEs0buidjTg9f
	aIb6LC6aeKYJ9+f3D/OBoENQkYgrl2GZ5Suks4d7nUfILxZuhgvkVYaJG/+TKJnJYk6KV+lof66nR
	j/YUUu2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mwftY-00879u-GF; Mon, 13 Dec 2021 07:37:12 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwftV-00877s-14
 for linux-nvme@lists.infradead.org; Mon, 13 Dec 2021 07:37:10 +0000
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BD3mKNv005344;
 Mon, 13 Dec 2021 02:36:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=4w/vshR1I5GGOjzDqTjQTQW+8sVauY7cgSlDmyileeE=;
 b=XskkpjyULKhIZV5O/pORrtCbu5l8Lh7yL5P1CnYpGX/PC+rsrfS99qiY4wRkxq5b+0Dv
 YRRJGvPLvhf0svGIoUHRk/6qzqL/Wo0GduD+0R+rvMkGxywWbSajwviZle1FooMzUY4o
 qCWlJE4JKmeM0Eb9jsmP46bk8cq9R8QXMqzypbjI4MwR98fT1q1i9P4SjlamgpRaF1JP
 nFY7lHusZ2x/Lgr3WLOwtR2pQngLzcL2y1PMDQQ35Uo8cCyrVnBByYKQhEMzVL4/m8KA
 vOVaQqy5+mAVhg7vYfFjdPnpth6nnWQX81qKd1M2YoLvdoQ4pYmG/o5Ty9I6DwEB9z6t sA== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 3cwc0jtckk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Dec 2021 02:36:58 -0500
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 1BD7ZC2O010285; Mon, 13 Dec 2021 02:36:57 -0500
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
 by mx0b-00154901.pphosted.com with ESMTP id 3cx19d8f5g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Dec 2021 02:36:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tml9vBfLOzFhkD98hRlQp1t2fhy7ls4QA9MlVd9Tc+Si3wsXBqJkqJ8aRaK6XrRC0VFWF1zdVYL7gKyxIulB5vvR7VavYC6REmvWKS8k59f/K5u1rhk1fq5dcaEGs5V5i51n+jUOBXTs2tao//Ma9wLkKB06FFgJMwR6b5XCSRPlkkAP1LGeStr8hMJQvsI+Qp/7qWxHDtR9tcxEUUsvAcdiodxbW3J6Xb/yyRGo4CnwCHcwg22+6xl0iuGUvXRiTiUBkWF6GFl/Iqt+ANTtaDp44aYC+DsiGQJMe7IITysWPRy+F6VUIV/1TXNEQSMaiWQSZnmpSuANx4CZ7wkx6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4w/vshR1I5GGOjzDqTjQTQW+8sVauY7cgSlDmyileeE=;
 b=m8/fJG/JHWJk2EWvjldr/QZqoiQNgWyN7Lr5bvYx+xlSN9ViROit+FcpAM5aBMmdtotLQmIv0o4VYbGvBri8WqYEO11owO9zj7nck8nubXgrXGDk7O8AGhdTiTlvJ51lfAa99ck4nW40ZNQOHGtsPq5I6LNRN95toOohQgsM46ZLzsEuRShcH5K7DcIT3Hp1gx8NKdB/lfUcRzo7YP+YneOuxr40BD4GXq4qDdHtCXcwEiYDSlzQ2Ek3ltYP2QGHDvX862aGJZ3pQkPSGWD6kNBJzPimnjkdwia7H0FCp6xzCV+eLH77e7Q02FcdF2UbeBqipsjWAfu7RsRCu+fB/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from CO1PR19MB4885.namprd19.prod.outlook.com (2603:10b6:303:f5::17)
 by CO1PR19MB5062.namprd19.prod.outlook.com (2603:10b6:303:f8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Mon, 13 Dec
 2021 07:36:55 +0000
Received: from CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::5c6:d55a:df66:11de]) by CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::5c6:d55a:df66:11de%7]) with mapi id 15.20.4778.016; Mon, 13 Dec 2021
 07:36:55 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: "Anner, Ran" <Ran.Anner@dell.com>
Subject: RE: nvme-tcp host potential bugs
Thread-Topic: nvme-tcp host potential bugs
Thread-Index: AdfrbBcS1P3+CjK7Tc++v2dp09EesQAu0j6AAPMmLTA=
Date: Mon, 13 Dec 2021 07:36:55 +0000
Message-ID: <CO1PR19MB488518C215ACFF0B53812FC0EE749@CO1PR19MB4885.namprd19.prod.outlook.com>
References: <PH0PR19MB4889C321978DC541DD83A939EE6E9@PH0PR19MB4889.namprd19.prod.outlook.com>
 <9f6e47bd-e604-790e-b6a1-13ed8fd111b1@grimberg.me>
In-Reply-To: <9f6e47bd-e604-790e-b6a1-13ed8fd111b1@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_Enabled=true;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_SetDate=2021-12-13T07:35:19Z; 
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_Method=Privileged;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_Name=Public;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_ActionId=f4fc74d1-4311-472b-96b2-2bf6c914b1a1;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_ContentBits=0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae95e445-c396-44a5-64cf-08d9be0b56bf
x-ms-traffictypediagnostic: CO1PR19MB5062:EE_
x-microsoft-antispam-prvs: <CO1PR19MB5062BF2DF742687A68CFF444EE749@CO1PR19MB5062.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PD1Jst+CJxTPP17/s/ljNwMT9L/fIS/npiFSV0NNK2jsylFSugQ8nuXT45UDe3SXaYILRXNXcCp9U+6eQOofCpYX73RgQ45I9X6hwokD6uNLg+gcYtpbcHsfuRNuy+s4KvTXrxvGDwWQO0fDnnglmvYJ77vp1Wp9Y+kxAqJKH15sajbRf4yPcMRKZxWGZ2EkaGOh9HakEkQnzEBKMxdYuP5UFwWcxeMJRSrUEXWs/PXBnqm5HM43ukO9OyFR+KRYLbLJkKg0+aQRy2rC7Wi22MPO5jEEQH9PqXMILxwYwE+x5EMQGPINJelchUaU0F1wIV1wJ463gPWRaiMVAKw5uOlEbjISLY9rR07jRARD9edKW/Oi/9i9R71Vm92h38VXHkWJc5NdxYHUPs33iQvJy+DvEMugJSaHd8/bIMuVaLa6xewxRAuKWF8VdqAbeTX5D0DFJbcwQc4naRk3/XS+WPQtZfhRaDHGAMpAXr1J8tvgrwe8ZvQnv/JpOzxnntp66jq5tWPXE9g6G8UcrSYUs9uDvHrNl/LkPodhZV2EDXPRbIiUoa9mGf2PgjCwZ3t0IMcMnLokO9LPIe5Mye9kfk8vz2fbw/Ur8v3/BwCX1ELjKFTj+PuAlDhSp02inoF2jfNB15EILbK75bIqNzgquA55S7PVBDihQorYMIou4sWO4UsWk5+mXrwriCCJErylGGGjf3e94ehAkDKdyV2ETg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR19MB4885.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(2906002)(110136005)(38070700005)(5660300002)(508600001)(8936002)(82960400001)(122000001)(786003)(38100700002)(4326008)(33656002)(3480700007)(316002)(6506007)(71200400001)(7696005)(64756008)(66946007)(66476007)(8676002)(26005)(9686003)(53546011)(107886003)(66446008)(76116006)(186003)(52536014)(66556008)(55016003)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Rh5VYQpj0dU6PBHLZDclvlEqI+NU+uMI6g14Fu423quC9lu07Ae0DTlaKqem?=
 =?us-ascii?Q?q4A+rNXeTewSGKqH4DDfrC41RObynD6b287pi96ml3hmpvS/BWWH7XQSoQUj?=
 =?us-ascii?Q?cEISP5xCRwrIO1LJmsTG7adWcnYHb/d5D8eG7xYL6VO2lF/cSJwhtU3IeiHJ?=
 =?us-ascii?Q?OA0Z0YUPCOTJYF8g7WWUpxphyp+md32E6beMbX/A+TEUG64PzLoL5r7G/geu?=
 =?us-ascii?Q?2tdJSJkTUdX5Va6x6k7vZYaaAqTe2gF/vvSOvhDKK09Yj/ZQIfa/8o52r10g?=
 =?us-ascii?Q?Ib5GsVm1K/YjIVecCVapX50ankf7GgCaMokrfQpEH1OI3LoXkemGj83Iy7II?=
 =?us-ascii?Q?harB6rscWP6VOsDLjOuTv9rWJ7deoKi0HVR6WligtV4ccqb2Zgrx3VVMvcu7?=
 =?us-ascii?Q?TQ3EX3XCCldoqo5Ph4pG9tm4dpVE2hfDTu/Zncyi0kGVhHUWsZ58hvqe95IL?=
 =?us-ascii?Q?M+B5ATiBDXSDWptrSfkHKPTNWADkBAx84ywEkpQ1ykmxL5LrvgI/w39qF9me?=
 =?us-ascii?Q?H5c93tTifHDJZP0TfAqMpWJX7CQGYSRCsjvH0Q42KRB9hyN9FnIb3S1em8gS?=
 =?us-ascii?Q?EFumh/s1Zxjhw+nxjRW5Md52MDlcStAG3xV7pTTm+qdM2+9El804XyCxTk94?=
 =?us-ascii?Q?gKkkmKerrj6LhvAoCretbqFateYFMXChmZmiHYBPqdvzicVKspQnSzI14y0r?=
 =?us-ascii?Q?+qTV/A3u1bHq9ZJrHJfaVUBlRaG00YCUj6SCcuxoNQf1xgF8ygEaPHZ2WpWK?=
 =?us-ascii?Q?fD1rz+kIKK7GZ7tMI8TrlCDKaiNwAtynJnWQfnCf6PuCI9Q3WmkIjw77kNbw?=
 =?us-ascii?Q?467obEoHIIyGXiMmUXb9qFxZnfrZqdldw2g4ZoVGuM6pCBdJn1qngKppc+Ft?=
 =?us-ascii?Q?iWILt9OUJg7gEdz7Ai7s0wCVrpqRlmSv5wpygrwpWjvwy6YVqreujMJ+If9c?=
 =?us-ascii?Q?kEUyS1oISwzHkLg71QRwYnDMJaXfBDMKCyrf2EXivDbiSI15EcWkVsDIgikY?=
 =?us-ascii?Q?674QwMrw/8d/pbEkYUXnstcXJvi4iENBzE2qTm2tZGSutD06HBZYDbvDDMoy?=
 =?us-ascii?Q?ZKUWWX7Ufz4wzVgVppz695d0p+bkJ+kn3ppN4Ci0JRYTKOv/YGX1d24z7ZRZ?=
 =?us-ascii?Q?olhQYkdAlkTQrOyruPGKEaTZHqOgC9pUg4NKsy3FmZY1NS58h56eS9VoTWZh?=
 =?us-ascii?Q?As/uMNRvNViA827hqBfRzk7vQyotRr61CfHng/Xyh0q57FIMMsiPEzbaxsnL?=
 =?us-ascii?Q?FcdlY/2zvX1OAo/Ncu/yk+vaAx/vU52aUU/p8U690DmKLM8yEY2pFzz/1J5v?=
 =?us-ascii?Q?752b7nulr5Dphr9DLkhkO2X1MHIbtpiMGzf7drmvmVseAh8vEUy+rwSqaief?=
 =?us-ascii?Q?syhzvjMFDvGPgz5qctWT/k+9jfwQd4sA9rf7YUqGTZ1QKYjxy8vzCQeuhM68?=
 =?us-ascii?Q?UjM0PGfaezIOi2Ai4GZD3N3yRJRSRoWYZNaLfAqlCDOLoRm3bBgJJcAirJ3V?=
 =?us-ascii?Q?emfoOciYrhCh1qS6WHwRGbTIiPlCgNCuzv/+tGhxeSRg+3iYGTwvn0fcdqNZ?=
 =?us-ascii?Q?BnrT8os87Hvj2LjDVphbXuviSkbid+rQPUsByRJCWHXbVxnb0vIFconiwuvt?=
 =?us-ascii?Q?cQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR19MB4885.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae95e445-c396-44a5-64cf-08d9be0b56bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 07:36:55.8312 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Tb43ns++8aWr8hjhcVf+yORJGFFntM55L5TFq6IkX5cWhtvpcU7LdpALQYRoIZu4KwjYENmb8aJHpP9Oi83Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR19MB5062
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425, 18.0.790
 definitions=2021-12-13_02:2021-12-09,
 2021-12-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112130048
X-Proofpoint-GUID: g3-5HYJnOGIR52ZQymdhMflxf42oDMrh
X-Proofpoint-ORIG-GUID: g3-5HYJnOGIR52ZQymdhMflxf42oDMrh
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112130048
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211212_233709_157621_58A811BA 
X-CRM114-Status: GOOD (  28.63  )
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

Hi Sagi,

Regarding the first issue, you are right.
we missed that ctrl->queues array allocation is capped by opts->nr_io_queue=
s,

However, we do believe that the second issue does exist:
As part of create_ctrl
queue_count =3D=3D nr_io_queues + 1 =3D=3D 49 (in our example 48 =3D num_on=
line_cpus())

As part of nvme_tcp_setup_ctrl,
alloc_io_queues calls set_queue_count where nr_io_queues is set to 8 (in ou=
r case, target ctrl supports up to 8 io queues)
ctrl->queue_count =3D=3D 8 + 1

Timeout occurs and reconnect:
After reconnect, target ctrl is able to support up to 128 queues.
alloc_io_queues set nr_io_queues to 48  and ctrl->queue_count =3D=3D 49

after 8 iterations, start_io_queues  calls nvme_tcp_start_queue with qid 9
nvmf_connect_io_queue is being called with qid 9
__nvme_submit_sync_cmd is calling the block layer (blk_mq_alloc_request_hct=
x) with qid 9 which returns with an error

Thanks,
Amit

-----Original Message-----
From: Sagi Grimberg <sagi@grimberg.me>=20
Sent: Wednesday, December 8, 2021 1:33 PM
To: Engel, Amit; linux-nvme@lists.infradead.org
Cc: Anner, Ran
Subject: Re: nvme-tcp host potential bugs


[EXTERNAL EMAIL]=20


> Hello Sagi,
>=20
> We would like to share and hear your inputs regarding 2 host nvme-tcp=20
> issues that we have encountered in kernel version=20
> 4.18.0-348.2.1.el8_5.x86_64
>=20
> First issue:
> As part of nvme_tcp_create_ctrl, ctrl->queues is being allocated per=20
> ctrl in size of queue_count Ctrl queue_count is being set as part of=20
> nvme_tcp_alloc_io_queues per nr_io_queues

ctrl->queues array is being allocated just once, in create_ctrl, and is
capped by opts->nr_io_queues, and should never exceed this size.

>=20
> We see a potential issue in the following scenario:
> A connection is being established with x I/O queues and ctrl->queues=20
> is allocated to be of size x + 1

This means that opts->nr_io_queues =3D=3D x

> Assuming there is a reconnection (due to a timeout or any other=20
> reason) The new connection is being established with y I/O queues=20
> (where y > x)

That should not be possible. It can be that the controller refused to accep=
t all the queues that the host asked for, which means that user wants z que=
ues, controller accepted the first go x queues and in the second go y queue=
s where z <=3D y < x (according to your example).

ctrl->queues size is z
first round the host connected x of these queues, and in the second round t=
he host connected y of the queues.

>=20
> In this case, ctrl->queues was previously allocated with queue_count x=20
> + 1 But now queue_count is being updated to y + 1 As part of=20
> nvme_tcp_alloc_queue, we have struct nvme_tcp_queue *queue =3D=20
> &ctrl->queues[qid]; which might lead to access an out of range memory=20
> location (When qid > x + 1]) again, ctrl->queues was allocated with=20
> queue_count =3D=3D x + 1 and not y
>=20
> To prove the above theory, we added some debug prints when using x =3D=3D=
 8 and y =3D=3D 48:
>=20
> #creating 8 I/O queues, queue_count =3D=3D 9, queues points to=20
> 00000000fd0a0f0f

Yes, but what is the array size?

> Nov 30 14:02:25 nc9127122.drm.lab.emc.com kernel: nvme nvme15:=20
> creating 8 I/O queues. queues 00000000fd0a0f0f queue_count 9 Nov 30 14:02=
:25 nc9127122.drm.lab.emc.com kernel: nvme nvme15: mapped 8/0/0 default/rea=
d/poll queues.
> Nov 30 14:02:25 nc9127122.drm.lab.emc.com kernel: nvme nvme15:=20
> Successfully reconnected (1 attempt)
>=20
> #Timeout occurs that leads to reconnecting:
> Nov 30 14:02:42 nc9127122.drm.lab.emc.com kernel: nvme nvme15: queue=20
> 0: timeout request 0x0 type 4 Nov 30 14:02:42=20
> nc9127122.drm.lab.emc.com kernel: nvme nvme15: starting error recovery=20
> Nov 30 14:02:42 nc9127122.drm.lab.emc.com kernel: nvme nvme15: failed nvm=
e_keep_alive_end_io error=3D10 Nov 30 14:02:42 nc9127122.drm.lab.emc.com ke=
rnel: nvme nvme15: Reconnecting in 10 seconds...
>=20
> #Creating 48 I/O queues, queue_count =3D=3D 49, queues points again to=20
> 00000000fd0a0f0f

again, what is the array size?

> Nov 30 14:02:52 nc9127122.drm.lab.emc.com kernel: nvme nvme15:=20
> creating 48 I/O queues. queues 00000000fd0a0f0f queue_count 49
>=20
> Second issue:
> With the same above example , where x <  y As part of the reconnection=20
> process, nvme_tcp_configure_io_queues is being called In this=20
> function, nvme_tcp_start_io_queues is being called with the new (y)=20
> queue_count Which will lead to an error (when sending the IO connect=20
> command to the block layer)

But the host won't connect x queues, it will only connect y queues.
Maybe I'm missing something?

>=20
> Thanks,
> Amit
>=20
>=20
> Internal Use - Confidential

I'm assuming that this is not confidential as you are posting this to Linux=
-nvme, so please drop this notice from your upstream mails.

