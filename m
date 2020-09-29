Return-Path: <SRS0=g+aI=DG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23782C4727C
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 15:46:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AD08206D9
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 15:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZmKl2Trb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dell.com header.i=@dell.com header.b="AivZhcfY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Dell.onmicrosoft.com header.i=@Dell.onmicrosoft.com header.b="EdXCS75r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AD08206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7c6APFZAlBCnnvYyF+/dL80gRxdWcC5kCVyH/Gv0etg=; b=ZmKl2TrbdPfXr5zYQlGrL/ibgE
	Aw4RCLAlPqoOK31JNDnccmN2o5xr3DZs3fmPkWSv7XCGgtO83N1714QFA0FVkbUpS0AMTCDhgzYF5
	kfwH9bm5pBikoAM43Fn4ZSnKQM9mcPjcVlSLt72UHBMlH6z92unuzU+uymIxHFEfTMGqrlKiyMH2m
	kQuit9l9feTFltyAEd7UZZCZUxpv+AKnouJNqMEprgnWmPV6LVdrfOIGbs+0Ra26rFLILKOk9OeuN
	Jxp0ty/URE6/0WCUwHUuC61bmPZVo5UZI2C5DxUQj9si/KlfAtqaej7HAJGIGh7OvYG0JgRG3hjXO
	Ankn0eMw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNHpK-0005Xx-Dd; Tue, 29 Sep 2020 15:46:02 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNHpH-0005Wm-BL
 for linux-nvme@lists.infradead.org; Tue, 29 Sep 2020 15:46:00 +0000
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08TFTCdK027205
 for <linux-nvme@lists.infradead.org>; Tue, 29 Sep 2020 11:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=smtpout1; bh=RjhYuOLFHtilFmz7a05iovaE5lfLVM5etp3eG/p+g6g=;
 b=AivZhcfYF6nUCp5ansJLNFtSuxIGxHGxR68srkgVFJNjCyDEP6YCnNxh3ZuUGuMy6Ifv
 Hd1PBGmYWzcry1jbON29U/rGkJ9GWm1sN7tHlwg4m9E2xVOfegSlPAOWF1l8ytOvvGgo
 cFj1FwhAMIV/3EDPaYIrExXG98MiLd0t5y3y1wtjm0GtKIne+QJ23Di1PyMTavesvWW8
 CY1XOvWDnnM6U8VxNVOYefcUVhbLN8JfmNC0drYCQ9J/y72NxM6psEGbUZ9vs3wi2NIs
 /adgfYinrGVnNS1fW2oMM0sEi0W0KthQUfm0G012zIMfr0A+cwV9pS6Sv9QZgn7RbMeN Fw== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com with ESMTP id 33t1fyhmpc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Tue, 29 Sep 2020 11:45:57 -0400
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08TFXGUM097525
 for <linux-nvme@lists.infradead.org>; Tue, 29 Sep 2020 11:45:56 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
 by mx0b-00154901.pphosted.com with ESMTP id 33v5me2ur9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linux-nvme@lists.infradead.org>; Tue, 29 Sep 2020 11:45:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hu6SqyvLlajz9FKc/9UIAVJ//wnnyBEt6ENj7IOgN36mQScVs7Uv1stLRB4Rg+pmtzWGivcqs4FS3EFByQ/klJ/xcaFNP5nay+wQEI8maMrh79X9yKj54KcqftDySrPbFr9FC4/tTLmHixGAnE9UE9trS6cIWLZm80VQnMqXjeNUTAbjorP/8XymGJ9QwSq4i/RbMrS25Ft/3i50JSPMG3IgBd7ZYvShA7vJTxU97qrMH0MAHbp7fmz++2ug4uOOe4RqBs6mIy7gpdWUcr8eGWgCAlK7rsUZZL6GsAZBgwLdOqWQ+Ol3NCstJX+M5ZytnPW5lHQSwqtqECBYeadiNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjhYuOLFHtilFmz7a05iovaE5lfLVM5etp3eG/p+g6g=;
 b=BuIDQbunCVQVL4NBhuw2QkMv1QUfdtBKdGJa72SJrI9ahDuOlbacTyeDsAdenUMtuZbxagfvnrOLCpsUnGAo0lS5dT2ZIVZE+DKVLhd5klmyvoNM5A+LANTz8ZI7BcvtgqeA7hdy67tCzquVcmNgLl5Ct1b2VfBMtfFfUtsEQ7SRtTmBsmFo/pe+fHpYmsSV1fnN8HFlel+QbyMs5bq9PmmckjafRIMrWeCv3uzQDxPSTDWOwBvWBXEVuxUpsDjRdgCdcriUMC3jkt1hUC6pZGsMp51SjVmasvN8L6nHp2QYNm/e5i7/4okgLFNoIdlx9JRINLc5s2K0ZngqJksJuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com; 
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjhYuOLFHtilFmz7a05iovaE5lfLVM5etp3eG/p+g6g=;
 b=EdXCS75r4JI3ZFmw1hVeGWb/ZHpKT41mSLzY31j6wOCRWsJCkSuSrxyBWCOYRcpgO5ZOC1vagAJ+XaEKlMx/kigcnh54PgdfHbRWM1dcq7GK1XZP5amoIYUteDHESKtSHw1XRxPJxpNYg9HAFVN9lH3Zn15oM1Sa+ZIA9f3VlOk=
Received: from BL0PR1901MB2067.namprd19.prod.outlook.com
 (2603:10b6:207:33::32) by BL0PR1901MB2084.namprd19.prod.outlook.com
 (2603:10b6:207:35::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.25; Tue, 29 Sep
 2020 15:45:54 +0000
Received: from BL0PR1901MB2067.namprd19.prod.outlook.com
 ([fe80::14f3:5b26:a46:beb6]) by BL0PR1901MB2067.namprd19.prod.outlook.com
 ([fe80::14f3:5b26:a46:beb6%5]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 15:45:54 +0000
From: "Anner, Ran" <Ran.Anner@dell.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: kernel panic in nvmet_tcp when receiving malformed admin command
Thread-Topic: kernel panic in nvmet_tcp when receiving malformed admin command
Thread-Index: AdaWdvf+7tpUpYyWRD2wZy6V/04JWA==
Date: Tue, 29 Sep 2020 15:45:54 +0000
Message-ID: <BL0PR1901MB2067C827A2D826C0FBFE985591320@BL0PR1901MB2067.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Ran.Anner@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-09-29T15:39:53.7023433Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=cd649fbf-1bd4-4447-95d2-fa6808f2590b;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=dell.com;
x-originating-ip: [152.62.109.203]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cca4c774-f998-400a-f932-08d8648ec00c
x-ms-traffictypediagnostic: BL0PR1901MB2084:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR1901MB208437EF07FB29C9D11648F991320@BL0PR1901MB2084.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y4ZXCpSHK+pFfARuiKEBlTHEI31Ekxa6PhO+h/fwNTWDlti0Wbnt5eDZnrneo7X/yXpwWA828Egoz7Y0wKXy5WjNqY+eMrGjhIVRvoeWB4LAIvCYNRKwXaeweWSB/rwAUZr+FnRngrw0Bcam206N6psKonQ1MH9s7wd+5tCPCCxMWmG9Lt0HCYIkTg1Qs/zs5N6wFLVjI4/xJdw0RsxIXkQiWOVnMCvc4zOPa91iZ+s8DR9tRaob/nD+/WygMZDn9GMYd/RBrFgEJRKKy+YN5WrBHuaTHbNO7zHGg49rZZ+w+KnuAXNdRC0TUxV6qbSsnLz6S4pygXwAzI1pOalKMphJ09cJOrUOrC3FMZdMlvTNVrBoAoBaMgXAYcAVAQDN
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR1901MB2067.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(346002)(39860400002)(366004)(136003)(396003)(8676002)(786003)(478600001)(76116006)(66946007)(6506007)(7696005)(71200400001)(186003)(26005)(9686003)(55016002)(8936002)(33656002)(2906002)(52536014)(4326008)(66476007)(86362001)(316002)(5660300002)(6916009)(64756008)(66446008)(107886003)(54906003)(66556008)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: jDsesW41m0ezgWYdPnCTdBSEFj2KDHJjNgGJFIBfwPN6cJVXgnnuZGwQt/65kgTcGJc9gjjE7GMMihrY3qbY3QUBz5z2N4cgGLBIUjBT3AJVuUHr8wJBVJSQvfiYj4WOgE/XsVsrnulrcZpWNo5tE4qE3zFWSMZz8FgeT8ywBVrIB7OhhcAoYBbf2DP1GCpKFIPOTlcRdWsDDVIFRyrNyUA+HPSuZyMDBeQsEQCwvSOfcKmihv+nmUo8Eq/SNFoz/ugh7nWNti1j/CJvYccfybvrU0GbXvnzCCT2nEoOGd/7SAmS2ewrN9nZkQfE5lJIqohuDH7SnhGoRNxl83eciBaaPDwoD4U65aQjF6D4QHLaufxxvtpySBYqbJlz0yIa6rl22F6uxHAp7jRK8AeKg0mvh3Efl/ewSsXvycvJfyn7i5muVfycSfq0Kv9nACON1l3yL6WZwVFDD2dvtrTcjKJV5r5VPXICyzMxjeTPjspDlBH6VSmZHKfoGefK0ykta7wl5QDB6sxJbbik5MbiQKuxzKX/vIfNjXbIagEz+GWIaQ8UfN6KKn5kpgSWNID97TuIdu3SD4jkEjZPODGJ2a8WjzylmzyzKHKzkWfHoFMl7onzSnEMMbb/ipoBKcQ5QLnj1aoTHZ0A8DYMklOzGA==
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR1901MB2067.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cca4c774-f998-400a-f932-08d8648ec00c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 15:45:54.0735 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lzEbOkS7GGLnZSj+J6mrx7IsBNhnA2udi2QrmM6FWXqL1LRCP3t2yoHQAnxYcmavPv+C4QxXv9YnHZybtmvqYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR1901MB2084
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-29_07:2020-09-29,
 2020-09-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 mlxscore=0 phishscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009290135
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 malwarescore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009290135
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200929_114559_591224_E1A4B073 
X-CRM114-Status: GOOD (  21.21  )
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
Cc: "Zinger, Eldad" <Eldad.Zinger@dell.com>, "Grupi,
 Elad" <Elad.Grupi@dell.com>, "Engel, Amit" <Amit.Engel@Dell.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello all.

We are investigating kernel panic when a malformed admin command with inlin=
e write data is sent from host to target using nvmeof tcp.
Following a code review of nvmet_tcp from latest kernel and adding debug lo=
gs along the way I came up with the following flow: =


nvmet_tcp_try_recv_pdu sends an IO with inline data to nvmet_req_init.
nvmet_req_init send to parse which fails (ex. host sends malformed command).
nvmet_req_init calls __nvmet_req_complete, and in turn calls queue_response.
nvmet_tcp_queue_response add the command to queue response list.
nvmet_req_init return error status and nvmet_tcp_handle_req_failure is call=
ed.
nvmet_tcp_handle_req_failure checks if the command has inline data and will=
 allocate pages and iovs.
nvmet_tcp_handle_req_failure return and nvmet_tcp_done_recv_pdu returns -EA=
GAIN.
nvmet_tcp_try_recv_pdu returns -EAGAIN and in that case nvmet_tcp_try_recv_=
one returns 0.
In case nvmet_tcp_try_recv_one returns 0, nvmet_tcp_try_recv breaks from lo=
op and return zero as well.
In nvmet_tcp_io_work we continue to nvmet_tcp_try_send in case the return v=
alue is zero.
nvmet_tcp_try_send_one will call nvmet_tcp_fetch_cmd which can assign snd_c=
md as the failed command.
nvmet_tcp_need_data_out and nvmet_tcp_need_data_in return false so we call =
nvmet_setup_response_pdu.
nvmet_setup_response_pdu set the cmd state to NVMET_TCP_SEND_RESPONSE and r=
eturn.
Back to nvmet_tcp_try_send_one, cmd->state =3D=3D NVMET_TCP_SEND_RESPONSE s=
o nvmet_try_send_response is called.
After kernel_sendpage we free the cmd iov and sgl.
Eventually nvmet_tcp_try_recv_data will be called but the iov was already r=
emoved and general protection fault is triggered.

I was wondering if this is a knows issue or if someone else encountered thi=
s before.
It seems to me a fix for this would be to not queue the response before rec=
eiving all data in this specific flow.
Added below snippet of the kernel trace.
Alternatively if we do not want to delay the response, free the iov after b=
oth flows are done, maybe using reference counting to do so.
I will be glad to hear your thoughts and comments.

Thank you,
Ran.

[13538.046364] general protection fault: 0000 [#1] SMP NOPTI
[13538.051762] CPU: 10 PID: 603 Comm: kworker/10:1H Kdump: loaded Tainted: =
G=A0=A0=A0=A0=A0=A0 =A0W=A0 OE=A0=A0=A0=A0 4.19.134-coreos-r9999.1600774095=
-1610 #1
[13538.063574] Hardware name: EMC 900-532-002/110-551-910C-01, BIOS 16.35 0=
4/08/2020
[13538.071049] Workqueue: nvmet_tcp_wq nvmet_tcp_io_work [nvmet_tcp]
[13538.077142] RIP: 0010:memcpy_erms+0x6/0x10
[13538.081237] Code: 90 90 90 90 eb 1e 0f 1f 00 48 89 f8 48 89 d1 48 c1 e9 =
03 83 e2 07 f3 48 a5 89 d1 f3 a4 c3 66 0f 1f 44 00 00 48 89 f8 48 89 d1 <f3=
> a4 c3 0f 1f 80 00 00 00 00 48 89 f8 48 83 fa 20 72 7e>
[13538.099981] RSP: 0018:ffffc9000781bc70 EFLAGS: 00010202
[13538.105199] RAX: 31d247ca1958f63f RBX: 0000000000000510 RCX: 00000000000=
00510
[13538.112322] RDX: 0000000000000510 RSI: ffff8886445f60ca RDI: 31d247ca195=
8f63f
[13538.119446] RBP: ffff888308c41920 R08: 0000000000000510 R09: ffff88850b9=
6e2bc
[13538.126570] R10: ffff88850b96de48 R11: ffff8886445f60ca R12: 00000000000=
00510
[13538.133693] R13: 0000000000000510 R14: ffff8886445f65da R15: ffff8886902=
ddd90
[13538.140819] FS:=A0 0000000000000000(0000) GS:ffff8897dfe80000(0000) knlG=
S:0000000000000000
[13538.148906] CS:=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[13538.154650] CR2: 00007f547169beb0 CR3: 000000000220a001 CR4: 00000000007=
606e0
[13538.161772] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[13538.168896] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[13538.176022] PKRU: 55555554
[13538.178726] Call Trace:
[13538.181171]=A0 _copy_to_iter+0x30e/0x3b0
[13538.184925]=A0 ? wake_up_klogd.part.24+0x30/0x40
[13538.189372]=A0 skb_copy_datagram_iter+0x7b/0x260
[13538.193815]=A0 tcp_recvmsg+0x238/0xc80
[13538.197395]=A0 ? nvmet_tcp_io_work+0x400/0xa80 [nvmet_tcp]
[13538.202707]=A0 ? release_sock+0x43/0x90
[13538.206373]=A0 ? tcp_sendpage+0x41/0x50
[13538.210038]=A0 inet_recvmsg+0x5b/0xd0
[13538.213522]=A0 nvmet_tcp_io_work+0xea/0xa80 [nvmet_tcp]
[13538.218570]=A0 process_one_work+0x206/0x400
[13538.222580]=A0 worker_thread+0x2d/0x3e0
[13538.226243]=A0 ? process_one_work+0x400/0x400
[13538.230421]=A0 kthread+0x112/0x130
[13538.233647]=A0 ? kthread_bind+0x20/0x20
[13538.237312]=A0 ret_from_fork+0x1f/0x40

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
