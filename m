Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9FC0C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Apr 2022 20:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pDcdCMqvG6VwM/8F2LM+AShYIu7PoInhBZCwfMmruUA=; b=rWpvczzE9Iyo5YbNHgiYsPbn6v
	p4kjMrLHZYQiGslOZmLl9kFZHlzuAkoKw2OFn4LAh0AGYNp6q51jBc3uRVTHn0SqhJnUxM1kAPw8d
	dviJRJj0MRT8se6GFzAIW/d44uzidX41coly7AHT1L7bJjNuwLohdYdG/g7gJW0T0VahzSGttkNjY
	WgbwC4gZZoI80RvMYohwB/2Pbci4FYZxEht+akau27y00rZ9DBtLaSyM5XNTXMHf3XFeRoUYYB7OV
	ownpreDoShNoq/2g9D+UPxrHLeQ0wYH0khlZD9uV+zcJJ+OYkvPTjJ1oEpcwDTOFR3AOXoX6IfAU1
	nduIhZXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbq9b-002etn-RF; Tue, 05 Apr 2022 20:51:55 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbq9Z-002etD-FP
 for linux-nvme@lists.infradead.org; Tue, 05 Apr 2022 20:51:55 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 235Jc9RL001019; 
 Tue, 5 Apr 2022 20:51:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=pDcdCMqvG6VwM/8F2LM+AShYIu7PoInhBZCwfMmruUA=;
 b=N2dmH8KIDMis7UmhIQVOv9tcJunc+n1Ez8RdLwQQ0CDRU6M3/Woc+xZyQFWkgPZwHBkb
 DgnbbiE1sB4+p9VCo7sKjMImuOgS8oT1aIe6IBiXtgxTmWl23yU/nc4AUUgPXmjm5W23
 UhavlDw+kNeJ0u4W1jpSYwamC6JLD4DPdiY/iI9a6sA2x/0Ex6PIujW6xNXF6RqQ5taz
 kLngDZJxqoLmgWZGE9J9HWXdLjUAdJO8G/ahUWADw2MPH3iYSEPIi3PN+idCheZAmy97
 cfF7ltghzY7XxqMIukRQL3rpyNIx1w1nSmJQLGD8bjpAXnJv4NDBVrE6zqgsPkWfsevC RQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com with ESMTP id 3f6e3sq4ue-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Apr 2022 20:51:43 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 235Kjflb001668; Tue, 5 Apr 2022 20:51:43 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id
 3f6cx42vdr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Apr 2022 20:51:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ybe7T+KLG4eBGhP9CadK72p6HMjpbmEvoXkScLgYjz0Gx8MEQXNuROmFeyLYpedgCBldEb7cdYrSJy3PwsgJjorRxW3tJ50NoPAYdKi70HDpoOsGJ/34NgPjFF/lndqgqW8ZS1i0NSKKTU4j9f5mGRyOh7TUdpBL0G7stUfT92r38Q1qbyzFbSujQHNRX2bwU9DdQayb5b1lf9ng3G4yY1OjCvsXM3GacQlTN/molZ3d5A5dTEDJIrqaDJzNSaiJr8bCYf9x7W8kmHxjvzv0pTl77c/hlLPf62XgZrJmkwJCEQuTrgr3nywmFbaFz4JSSXxuy/ISzq5XdoTsmGW+Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDcdCMqvG6VwM/8F2LM+AShYIu7PoInhBZCwfMmruUA=;
 b=H9H76nsauc6HBHCW3qYRlwdxr3CKwzzHo2pxxn2WbG2WtRET9la1rYELJt6nWNF2j2G1NWL9lLrWR/xUnxzYCSzNg91YMOdXu5T82u/V4n7hzWTewN3mZFVB9SHFvzgCvBQqJydB8Cnmru+FtQXHy8LlZ0PQWbb50Z5KiYlCxnzfhppem1GIketD4mW3QRjKmusGzLtUgtKY0tJZZA3Tx+8f1Dg1xrvEYadS3a+7SkddbRbwE57XCPVXJpxIplU7uP4QMjNZDR3TvJ7rxtyQ9F0uxVKEBQaLB6oLSL0BVtST43VmoiFk0P4TCZsVvr3SwIrS1L0de13DhlYGXyU9vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pDcdCMqvG6VwM/8F2LM+AShYIu7PoInhBZCwfMmruUA=;
 b=fqKji5leJy5roqtfQ4xssQJmuiqYikFrV8TV+DB9N1zLaRfYVV5lwizmpBtMozT+mjpME/LK8jYoGEEuGIcoC0nfERO0+zHFCA0E13aIvLbKzwqMisThlFnlq77yt1XRIjE3+EiVYd+HcdI2gRl8XnBkJN5Y7GrSLhCbLD9hc6o=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by MWHPR10MB1744.namprd10.prod.outlook.com (2603:10b6:301:b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 20:51:41 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::19cf:32fa:454f:7bff]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::19cf:32fa:454f:7bff%8]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 20:51:40 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: Jonathan Derrick <jonathan.derrick@linux.dev>
CC: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [bug report]nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2)
 MORE DNR observed during blktests
Thread-Topic: [bug report]nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2)
 MORE DNR observed during blktests
Thread-Index: AQHYR2cuTGHViq1YXkqwVFy/Mk48Dqzf9jCAgAAGqYCAACpjAIAAD4cAgACjS4CAAMsxAIAAKdeA
Date: Tue, 5 Apr 2022 20:51:40 +0000
Message-ID: <E96FBE93-5E9B-4F94-87A8-D7120C423B63@oracle.com>
References: <CAHj4cs_iC+FE8ZAXXZPeia1V3ZX7zRbeASdOP_8c7DLiFozNfA@mail.gmail.com>
 <4A24C337-5EF9-4C3A-A112-BA75934AC78B@oracle.com>
 <Ykskv/gp2s6PWiHp@kbusch-mbp.dhcp.thefacebook.com>
 <4a97859a-9b9c-da39-3dca-76811f67b4a6@linux.dev>
 <YktVVG+WSXzYWjGR@kbusch-mbp.dhcp.thefacebook.com>
 <YkveT9/oBMoykEsy@infradead.org>
 <3e96e81f-8650-800a-ba35-1e89c7e82e43@linux.dev>
In-Reply-To: <3e96e81f-8650-800a-ba35-1e89c7e82e43@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b93fed0-ab17-4088-805a-08da174615f5
x-ms-traffictypediagnostic: MWHPR10MB1744:EE_
x-microsoft-antispam-prvs: <MWHPR10MB17444E7429F7DF8E83ED3D75F4E49@MWHPR10MB1744.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hW+uFcVwIKCUlKB7oThVNcflbXM56l8BC2P++tbx+AHtTYmdiSB9m1J5fQ4UAHHU63FbWJ+8ZF+oB13yKGRFQOezDlpnAsGhCOxSkLbkxWpLxMOen3tyyPYHH80mQBt1etpdbbOpjOmmMyjkUVNs0edbxLnYGQZ9SAnYlppM1Yxe9YgA1qF39mPzwvku+Ue9wrxPQ392jlnBE7HoyDGxd+AdRFVV/uGZ/h0ChdmatIIItQOlfft/nUabRGbp2bldZC/L5o2f+ZgfbcyNa/zTfnOe7D6zZwhKnLsn0+Gi9PUYJYsucVXZLhd6kUOuHScplV28H2Bu+iCMYVzEp51aYoIJfO3G0LwgRcqd5UhZfL5SlIjIAvbACP3qMhuji6AJ6molS42m2n6S9PENcckEdsn1dsx64sYZRfzH/hPb7Ir90tlxnVO2wcd6S/guQr9rY6p5awY1Xq5vQ5o2SX2rDymY+C+LA/v3RXP/DA2euHDCPY85Z9oDub2NdGYSWZxJQ6FRiG7wSwVowY78XlJqtfy3cxKLYEBlZXsS568WBfMVSSB3HGYBdPxGH7WTpZQmwuQqApgJUs+/Un9dT6VbGSaWzDC1Bt15uDlPSV73ENX2bDWShpf4IAUoywgnJBVI34Wb7JFOdh+AV20x0n33kNnZ8xALaWs4ra88+/XM2Bbpwv/DJ2EIuPD+Qlq6+IkkLKjdhPFcq7ZS0t34Emm4mlJr4/q1B0LOqql2oUF9QO86oeK4omI0Q/fESbHPUkm5
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB5550.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(86362001)(66946007)(66556008)(122000001)(44832011)(5660300002)(8936002)(71200400001)(38070700005)(33656002)(508600001)(38100700002)(316002)(6486002)(8676002)(4326008)(54906003)(64756008)(6916009)(66476007)(76116006)(66446008)(186003)(26005)(6512007)(2616005)(83380400001)(53546011)(2906002)(6506007)(36756003)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUxiSG5YKzVKU1Zqeit4REMwTG9uc3IrVGQwMzBoWXYxc0tHQWd6K2R5WFdQ?=
 =?utf-8?B?R0RNcE5OT1VnNjJzRHFBaEgrMFZlSGJrQ0x4NE1KTEpDdU4rVXd4TUFDQmlP?=
 =?utf-8?B?TFZKUlM5Tk41Rm1sdDMwRUlzMkcyTFkzK1BadlFaNE56VDNkVWYrYlYweG1L?=
 =?utf-8?B?SGtNOWNaOU9mLzl5cy82RkQ0bHlaRDgrUGFJMUt5RURDYno2QVRNLzdIOW1Y?=
 =?utf-8?B?RTIyREhOT1ZXZFM2WnRxUm5lUjVER1g3Nzk0QzIyMkk2Vk4yRWgyWWZVbGFC?=
 =?utf-8?B?YlpCZ3ZYQlNjakxLWXczcm5LMWNPR0RGT29QK3dqWDJSTXdWMlJBbGxWaHZ0?=
 =?utf-8?B?ZkFBMmJzWXArUEx2SCtZeUpGNjNZcnZRbEIxbmZTaDlxK050UW8rQWJMS1Jy?=
 =?utf-8?B?NWxjWTlXMjZtRzNEY1gzLzlqbFF2Wi84Z0lxeEVKMmh1K0djOXVhZSttY21r?=
 =?utf-8?B?RUpBeTUzKzBBWHJ1dnZFMVRxYmJwVEVSUVIrN1AvSVZCNTU2TjlFdjUwaEJ3?=
 =?utf-8?B?dFZla0d0WEs1SThhTXpLSHJDWTZRVkFySFpGTTZFMHRHMXkzYkRNQnhGTHFu?=
 =?utf-8?B?RjdkcWdzV3czZDk0ZlpXdTNQK2hqa29yV0paY2FYL0FYOGlhR0czamc2WUNV?=
 =?utf-8?B?THlnVldHWVVsUm1PbnBNOXFjMFdENUt5SXRqcStBN3NzVldHbGoxVnNRVjRx?=
 =?utf-8?B?Y3pDV09qSzV6eTI4WVprRlVtTlRCa05HNXFhUjhqMEZISEE5NFZYNUN2anZT?=
 =?utf-8?B?TktSTE5xUUNFNzBqOG9WdW51dlhzaW50L0hVWWgrTHNmbkRBTTFNMVR6a3Fn?=
 =?utf-8?B?THgvRG1tSnNmVW4rRjRLN1NyQnRmVlBWNEwyc2ppdlhVMXdJSEhUTGZyVFpw?=
 =?utf-8?B?WGQydlNEYkM3QTV4VDdLaEJHNkxuc25DVmNLcFlFQWVxVVBPNytzcnlNdXpE?=
 =?utf-8?B?OU1ETUhib241N3liRGdOV0FQM0dzczBuQ29yM2FBSk93MVlrNEV3NUN2ckpG?=
 =?utf-8?B?Z01zcDlmWitEWFJLY3duNEJxOW43S2NpNlFtbGpkbEV2WUJQSTIwTGdudy95?=
 =?utf-8?B?djhKTktpa0RqUVo5Umo0RHdGenFLUW5qMHBEaGduL2gvVTV1OFhKRURnalp4?=
 =?utf-8?B?K2NMMGVnT3huTDBQdGxFSm5ySnUvZ1RBLy92NndqckJYeFI4a2UyNjE1ZG93?=
 =?utf-8?B?bjMxdlVxbjZ5YlluVHZYRnppWUxwQURoS1lScjN2NW9GMUNIcE1Db2p1d0E1?=
 =?utf-8?B?TUlsUDZQcWVZbHhUZWErN3dtUTlRajdoZk03UUxZM3ZRMkJkaUpZWGVKZitV?=
 =?utf-8?B?cDkyN0FJNU83eVNJR2kvYXI3QXNmL0FnRnpYQzEzQU95anRhTVByVTdKWXRR?=
 =?utf-8?B?RUszZmpwcmJNdW01dXNwaFIyR0NFUFY4allaRDlPMTNLZU56aGxtZWUrWFpN?=
 =?utf-8?B?cE9Fbm1YOHlVSVJxRlRtdTVCS0NRNkY0c3lVaFloWHBaQTlVT2F5elU5NUt5?=
 =?utf-8?B?QzNSTG1TcXRMWlcrQWtZRitna3BsTEowVE1nUzd4amdvSitLYWRkZjlKdzM3?=
 =?utf-8?B?ZU1iYTRQY3lBa3ZCbzl1RmFoYVhua2dvaGk1SklZV0krZ2hnM0tXQkZsWGNQ?=
 =?utf-8?B?WTdaajJsdTExRFNDRjBNT2piSE83eXk3dklrMlNLcEZOTWtqRnk3azJCa0xB?=
 =?utf-8?B?S2tpWkJGcHlCT2V3ZmNsbzI4bU12Yy9keUxQMzFzL1VQRzg4TUpVYUJQZUdy?=
 =?utf-8?B?cGhCcGxwOVpqN2p3OGtQaTBXaVF6R2F6bG8rMGRpVDAxRlNEd1pqM0M5bjZN?=
 =?utf-8?B?NktWY0tVQzNOYW05Slp1ZFhBWnhEQ0hDU0pNZEZBcE9qeCtYekQvYXozN3hr?=
 =?utf-8?B?eXBLNC9YZkoxSmlONjQ2bTl0U24zNllOSDhwTXhZNUVBQ2lmOHV5YkgxNlVW?=
 =?utf-8?B?MDM2eStkKzBEQ1YvOUxMRUFqM0NrMHJudTQyTUVYUDJsQzFwakdQY2R4eUQ3?=
 =?utf-8?B?dXNzS1lUbEliQ0t1cXhVMStJTk5TeUgweEhWdnpaODFUQS80UisxY0JuQlBu?=
 =?utf-8?B?TWZvcDdBUFlacmtnbUI0VlpIdmZrcUFQbmN1OVpkR3dkcXJkM0NiejMvUHM1?=
 =?utf-8?B?c1V3cnRTbU5DQ3JnYUl3ZUJTVDBGME1GcHJRcDgreEswTGd4anlZaCtBeG5V?=
 =?utf-8?B?QWhxT051WTBXMWRjSmNGeTQ2bDJMYlZtbmJINVdzNWEyY0dRQjQ0QWM1Yndh?=
 =?utf-8?B?N0RkR01VYjhZTEVsOGRnL2JvTnVYNmo0d3RDblM1UFl3NlNZOUhYVTkxbU04?=
 =?utf-8?B?RHlxZFRzQlA0bFd2bHdPTDdla3Rha3p2MW9vQ3lMOUhxbFJsNFU2S211T2d3?=
 =?utf-8?Q?PZQfV8JwY8RXsYD4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <23893149B12ED54DA3A646231A6FC1DF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b93fed0-ab17-4088-805a-08da174615f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2022 20:51:40.8969 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qxi8LBGM6v+oEs2mR2QP2zDBUwNx8i4aDifP3n/LkRTung78UtYG19NpLKV/UsDqbzWIR1Wpg2+/xPQotz3nBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1744
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425, 18.0.850
 definitions=2022-04-05_07:2022-04-04,
 2022-04-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204050116
X-Proofpoint-ORIG-GUID: H4zi2ty1ItC65GndhcxTwnr7fSN-WMYM
X-Proofpoint-GUID: H4zi2ty1ItC65GndhcxTwnr7fSN-WMYM
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220405_135153_708046_A0FB22E7 
X-CRM114-Status: GOOD (  32.39  )
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

DQoNCj4gT24gQXByIDUsIDIwMjIsIGF0IDExOjIxIEFNLCBKb25hdGhhbiBEZXJyaWNrIDxqb25h
dGhhbi5kZXJyaWNrQGxpbnV4LmRldj4gd3JvdGU6DQo+IA0KPiANCj4gDQo+IE9uIDQvNS8yMDIy
IDEyOjE0IEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4+IE9uIE1vbiwgQXByIDA0LCAy
MDIyIGF0IDAyOjMwOjEyUE0gLTA2MDAsIEtlaXRoIEJ1c2NoIHdyb3RlOg0KPj4+PiBFZywgbnZt
ZTA6IGJsYWggYmxhaCBjb21tYW5kIHNldCBub3Qgc3VwcG9ydGVkDQo+Pj4gDQo+Pj4gVGhlIG5l
dyBwcmludCBpbiB0aGUgY29tcGxldGlvbiBoYW5kbGVyIGlzIHByZXR0eSBnZW5lcmljLiBJIGRv
bid0IHRoaW5rIGl0IGNhbg0KPj4+IHJlYWRpbHkgdGVsbCB0aGUgZGlmZmVyZW5jZSBmcm9tIGEg
aGFybWxlc3MgZXJyb3IuIE1heWJlIHByX2VyciBpcyB0b28gaGlnaD8NCj4+PiANCj4+PiBPciBt
YXliZSBzaW5jZSBlbm91Z2ggcGVvcGxlIGhhdmUgYmVlbiBjb25jZXJuZWQgYWJvdXQgKnRoaXMq
IHNwZWNpZmljDQo+Pj4gaWRlbnRpZnksIG1heWJlIGl0IHNob3VsZCBiZSByZXN0cmljdGVkIHRv
IDIuMCBkZXZpY2VzIHdoZXJlIGl0J3MgbWFuZGF0b3J5LiBJDQo+Pj4gd2FzIHJlbHVjdGFudCB0
byBkbyB0aGF0IGF0IGZpcnN0IHNpbmNlIHRoZSBpbml0aWFsIGRldmljZSBJIHRlc3RlZCB3YXMg
MS40LA0KPj4+IGJ1dCBpdCB3YXMgYSBwcm90b3R5cGUgYW5kIHdlIHNob3VsZCBiZSBmaW5lIHdp
dGhvdXQgdGhlIG5vbi1tZHRzIGxpbWl0cw0KPj4+IGFueXdheS4NCj4+IA0KPj4gV2hhdCBTQ1NJ
IGRvZXMgaXMgdG8gYWRkIFJRRl9RVUlFVCB0byBhbGwgaW50ZXJuYWwgcGFzc3Rocm91Z2ggY29t
bWFuZHMsDQo+PiBhbmQgdGhlbiBza2lwcyBwcmludGluZyB0aGUgU0NTSSBzcGVjaWZpYyBlcnJv
ciBtZXNzYWdlcyBpbiBhZGRpdGlvbg0KPj4gaWYgdGhhdCBmbGFnIGlzIHNldC4NCj4+IA0KPj4g
VGhpcyB3b3VsZCBiZSB0aGUgbnZtZSB2ZXJzaW9uIG9mIHRoYXQ6DQo+PiANCj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMN
Cj4+IGluZGV4IDdlMDdkZDY5MjYyYTcuLjkzNDZjZDRjZjU4MjAgMTAwNjQ0DQo+PiAtLS0gYS9k
cml2ZXJzL252bWUvaG9zdC9jb3JlLmMNCj4+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUu
Yw0KPj4gQEAgLTM2Niw3ICszNjYsOCBAQCBzdGF0aWMgaW5saW5lIHZvaWQgbnZtZV9lbmRfcmVx
KHN0cnVjdCByZXF1ZXN0ICpyZXEpDQo+PiB7DQo+PiAJYmxrX3N0YXR1c190IHN0YXR1cyA9IG52
bWVfZXJyb3Jfc3RhdHVzKG52bWVfcmVxKHJlcSktPnN0YXR1cyk7DQo+PiANCj4+IC0JaWYgKHVu
bGlrZWx5KG52bWVfcmVxKHJlcSktPnN0YXR1cyAhPSBOVk1FX1NDX1NVQ0NFU1MpKQ0KPj4gKwlp
ZiAodW5saWtlbHkobnZtZV9yZXEocmVxKS0+c3RhdHVzICE9IE5WTUVfU0NfU1VDQ0VTUyAmJg0K
Pj4gKwkJICAgICAhKHJlcS0+cnFfZmxhZ3MgJiBSUUZfUVVJRVQpKSkNCj4+IAkJbnZtZV9sb2df
ZXJyb3IocmVxKTsNCj4+IAludm1lX2VuZF9yZXFfem9uZWQocmVxKTsNCj4+IAludm1lX3RyYWNl
X2Jpb19jb21wbGV0ZShyZXEpOw0KPj4gQEAgLTY0OCw2ICs2NDksNyBAQCB2b2lkIG52bWVfaW5p
dF9yZXF1ZXN0KHN0cnVjdCByZXF1ZXN0ICpyZXEsIHN0cnVjdCBudm1lX2NvbW1hbmQgKmNtZCkN
Cj4+IAljbWQtPmNvbW1vbi5mbGFncyAmPSB+TlZNRV9DTURfU0dMX0FMTDsNCj4+IA0KPj4gCXJl
cS0+Y21kX2ZsYWdzIHw9IFJFUV9GQUlMRkFTVF9EUklWRVI7DQo+PiArCXJlcS0+cnFfZmxhZ3Mg
fD0gUlFGX1FVSUVUOw0KPj4gCWlmIChyZXEtPm1xX2hjdHgtPnR5cGUgPT0gSENUWF9UWVBFX1BP
TEwpDQo+PiAJCXJlcS0+Y21kX2ZsYWdzIHw9IFJFUV9QT0xMRUQ7DQo+PiAJbnZtZV9jbGVhcl9u
dm1lX3JlcXVlc3QocmVxKTsNCj4gDQo+IA0KPiBUaGF0J3MgZ29vZCB0b28uDQo+IEhvdyBhYm91
dCB0aGlzIHNvIGl0J3MgbGltaXRlZCB0byBkZWJ1ZyBsb2dsZXZlbHM6DQoNCkkgZG9u4oCZdCB0
aGluayB3ZSB3YW50IHRvIGxpbWl0IGl0IHRvIGRlYnVnIGxvZ2xldmVscy4gIFRoZSBtYWluIHB1
cnBvc2Ugb2YgdGhlIHBhdGNoIHdhcyB0byBhbGxvdyBmb3IgZGVidWdnaW5nIGlzc3VlcyBvZiBs
aXZlIGN1c3RvbWVyIHN5c3RlbXMuDQoNCkFsYW4NCg0KDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9udm1lL2hvc3QvY29yZS5jIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jDQo+IGluZGV4
IGYyMDRjNmY3OGI1Yi4uODcxYWQyNDIxMjg0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL252bWUv
aG9zdC9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jDQo+IEBAIC0zMDMs
OSArMzAzLDEwIEBAIHN0YXRpYyB2b2lkIG52bWVfbG9nX2Vycm9yKHN0cnVjdCByZXF1ZXN0ICpy
ZXEpDQo+IHsNCj4gICAgICAgIHN0cnVjdCBudm1lX25zICpucyA9IHJlcS0+cS0+cXVldWVkYXRh
Ow0KPiAgICAgICAgc3RydWN0IG52bWVfcmVxdWVzdCAqbnIgPSBudm1lX3JlcShyZXEpOw0KPiAr
ICAgICAgIGludCBsZXZlbCA9IHJlcS0+cnFfZmxhZ3MgJiBSUUZfUVVJRVQgPyBLRVJOX0RFQlVH
IDogS0VSTl9FUlI7DQo+IA0KPiAgICAgICAgaWYgKG5zKSB7DQo+IC0gICAgICAgICAgICAgICBw
cl9lcnJfcmF0ZWxpbWl0ZWQoIiVzOiAlcygweCV4KSBAIExCQSAlbGx1LCAlbGx1IGJsb2Nrcywg
JXMgKHNjdCAweCV4IC8gc2MgMHgleCkgJXMlc1xuIiwNCj4gKyAgICAgICAgICAgICAgIHByaW50
a19yYXRlbGltaXRlZChsZXZlbCAiJXM6ICVzKDB4JXgpIEAgTEJBICVsbHUsICVsbHUgYmxvY2tz
LCAlcyAoc2N0IDB4JXggLyBzYyAweCV4KSAlcyVzXG4iLA0KPiAgICAgICAgICAgICAgICAgICAg
ICAgbnMtPmRpc2sgPyBucy0+ZGlzay0+ZGlza19uYW1lIDogIj8iLA0KPiAgICAgICAgICAgICAg
ICAgICAgICAgbnZtZV9nZXRfb3Bjb2RlX3N0cihuci0+Y21kLT5jb21tb24ub3Bjb2RlKSwNCj4g
ICAgICAgICAgICAgICAgICAgICAgIG5yLT5jbWQtPmNvbW1vbi5vcGNvZGUsDQo+IEBAIC0zMTks
NyArMzIwLDcgQEAgc3RhdGljIHZvaWQgbnZtZV9sb2dfZXJyb3Ioc3RydWN0IHJlcXVlc3QgKnJl
cSkNCj4gICAgICAgICAgICAgICAgcmV0dXJuOw0KPiAgICAgICAgfQ0KPiANCj4gLSAgICAgICBw
cl9lcnJfcmF0ZWxpbWl0ZWQoIiVzOiAlcygweCV4KSwgJXMgKHNjdCAweCV4IC8gc2MgMHgleCkg
JXMlc1xuIiwNCj4gKyAgICAgICBwcmludGtfcmF0ZWxpbWl0ZWQobGV2ZWwgIiVzOiAlcygweCV4
KSwgJXMgKHNjdCAweCV4IC8gc2MgMHgleCkgJXMlc1xuIiwNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICBkZXZfbmFtZShuci0+Y3RybC0+ZGV2aWNlKSwNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICBudm1lX2dldF9hZG1pbl9vcGNvZGVfc3RyKG5yLT5jbWQtPmNvbW1vbi5vcGNvZGUp
LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgIG5yLT5jbWQtPmNvbW1vbi5vcGNvZGUsDQo+
IEBAIC02NTEsNiArNjUyLDcgQEAgdm9pZCBudm1lX2luaXRfcmVxdWVzdChzdHJ1Y3QgcmVxdWVz
dCAqcmVxLCBzdHJ1Y3QgbnZtZV9jb21tYW5kICpjbWQpDQo+ICAgICAgICBjbWQtPmNvbW1vbi5m
bGFncyAmPSB+TlZNRV9DTURfU0dMX0FMTDsNCj4gDQo+ICAgICAgICByZXEtPmNtZF9mbGFncyB8
PSBSRVFfRkFJTEZBU1RfRFJJVkVSOw0KPiArICAgICAgIHJlcS0+cnFfZmxhZ3MgfD0gUlFGX1FV
SUVUOw0KPiAgICAgICAgaWYgKHJlcS0+bXFfaGN0eC0+dHlwZSA9PSBIQ1RYX1RZUEVfUE9MTCkN
Cj4gICAgICAgICAgICAgICAgcmVxLT5jbWRfZmxhZ3MgfD0gUkVRX1BPTExFRDsNCj4gICAgICAg
IG52bWVfY2xlYXJfbnZtZV9yZXF1ZXN0KHJlcSk7DQo+IA0KDQo=

