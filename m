Return-Path: <SRS0=8pqL=PP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DDEC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Oct 2021 06:50:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B2D361073
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Oct 2021 06:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8B2D361073
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GBAbuQvbM1BpA2HzPXT8wPjQZLzxIg5yq1gqfDNJkQM=; b=n7dMTc1cMIEvJH14D2eap+/8pn
	Q58/rH1k+1FpCQNCMQKqwRYXTke8pjiGQN1nlcOUc8zROG0TsLAR5C2SMP6vM7ywpQmKNQbpJwtyG
	tQInhJr5uxQ7Nwqv0r5ovWOpXaP7Eq9JWj3tOAGADxPoWQRGrqh4piFRAb93Yw7RLESEnTuU1SH8G
	G0Xt4qRwWRj9jVCCnzoEKNou16mD9k02uNr9pydcP4vYScIZCNVsgAUtJQuW54icMqQ/1Onhczlxq
	csQDx3LRjtvK5wrCa7Z69l2i1uUnndx9NyBu707EYGohDu9QsCLKmJMl9Micylb0gySVjA6TXDdx6
	qgCSlU/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mfclp-0043cy-NK; Wed, 27 Oct 2021 06:50:45 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mfcli-0043ay-8w
 for linux-nvme@lists.infradead.org; Wed, 27 Oct 2021 06:50:39 +0000
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19QMFNpe013012; 
 Wed, 27 Oct 2021 02:50:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=GBAbuQvbM1BpA2HzPXT8wPjQZLzxIg5yq1gqfDNJkQM=;
 b=dEL73OswrM9V3F9DDNOMmYMUXSp3uqhZxhIJp/cy5xIga7NLjmyajM6egsAWvP0Cfra0
 w0mXHd43cgjO5t781Sk2MUker3XJdfSEmABVtvjUVtp0sqUkfP7fcZMoxVOUBam+ZapY
 xBHdHSZwitvAdoQ61gpoLXUg/CHkQsML6xpd5RDNvuivlVMJfkK1jrHwoGERLAFRWZ+w
 IX18qqGkJALxS3hdkBnUSjz+SYNPyB2l3rsBQb0FxdweueSpzzANCZw+HGEP2KFJyN/Z
 RnHJUhfiRjUAhVsC9zalr1fEjNaBaPnEC6pWldwiYGrLK5pTiucIDeKwPvLg7UGxNFz3 gQ== 
Received: from mx0b-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com with ESMTP id 3bx4dp6pmv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Oct 2021 02:50:34 -0400
Received: from pps.filterd (m0090350.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 19R6oPq4100110; Wed, 27 Oct 2021 02:50:34 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
 by mx0b-00154901.pphosted.com with ESMTP id 3bx4uyexwt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Oct 2021 02:50:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbOOh66SFQsQpV68B3+XPeeVwknDaV2fjTl+9NUKlSUuViKTDKdN3KY/yJVyP2YDW3sm6mkdKeKMzXWVScQ1/1X+PV3HH9wBoUEkU472f5nDXJc3fI7jQDHa3O1uRVmN6B5pSFzM1D9GawXTsYCQf+N0dMkECpK2W6y8u46ZTSnTPEXQKOVlvpn03UjLVez7Hk6vgmLNNTCXVGqgmC/ffmq/dSVOx2gMC0LyMGWh4ak11oCHZQWTyjoqXcqClWC/PF9sdcqpTmuqHc+Qlbl/F0YJ8WCGnB9Zv2asuD9imaWJBvkP8LPiHzzK4JCec9C1CfLlZXtFhl8MWBbqUNj7fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBAbuQvbM1BpA2HzPXT8wPjQZLzxIg5yq1gqfDNJkQM=;
 b=lHx1/u0M15+Zkcxzq1q4fVKDrC6QBfZ9x0GHZxQJoBJ18W7kwnRUsLriIFNt7Na7vcWbLgYR9a7nqtEPjfOfZIT0V99xIXi/it6PF2R9BZ2jEyH96ZkvalPl5KiY4cbAUujU3S00NKyMekDSYpoO+U135FPU67E2cPMAsl1WMBM6jHkhnQ+7QThqXbcOOtKVXCDh73Ap4UeAfunlJPj6g/6wZ9rXLdIxzM2JLL8kLn1NoaN1hXBY7MX2GLbXZBQ71EnFP/3za3I8i934p/j6SEwWXOqDfGxeKeWDFuGpqoyzVkbzuMBnbmvvp6nsXNPJdQjRMID5h1yNupwBUrETzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from CO1PR19MB4885.namprd19.prod.outlook.com (2603:10b6:303:f5::17)
 by MW2PR1901MB1994.namprd19.prod.outlook.com (2603:10b6:302:f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Wed, 27 Oct
 2021 06:50:32 +0000
Received: from CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::7d75:a751:e366:2bc6]) by CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::7d75:a751:e366:2bc6%8]) with mapi id 15.20.4649.014; Wed, 27 Oct 2021
 06:50:32 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>
Subject: RE: [PATCH] nvmet_tcp: fix header digest verification
Thread-Topic: [PATCH] nvmet_tcp: fix header digest verification
Thread-Index: AQHXxN0a4q6RYcEmW0GV2etyjeOl+avaPSUAgAAm1hCAAcj9AIAHPKyggAIKnwCAAP+lYA==
Date: Wed, 27 Oct 2021 06:50:32 +0000
Message-ID: <CO1PR19MB4885033D193687FD816821ECEE859@CO1PR19MB4885.namprd19.prod.outlook.com>
References: <20211019113307.31852-1-amit.engel@dell.com>
 <2f46c62b-a8c4-5d48-17c4-ac33dec8a318@grimberg.me>
 <CO1PR19MB4885C691C3B1B15AA139A9E0EEBE9@CO1PR19MB4885.namprd19.prod.outlook.com>
 <4a71a194-c715-a38d-6b3e-560eae714451@grimberg.me>
 <CO1PR19MB48856AA2F52E022418DEA773EE839@CO1PR19MB4885.namprd19.prod.outlook.com>
 <f74d1d66-1400-89cf-fb15-782369ad28d2@grimberg.me>
In-Reply-To: <f74d1d66-1400-89cf-fb15-782369ad28d2@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_Enabled=true;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_SetDate=2021-10-27T06:49:51Z; 
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_Method=Privileged;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_Name=Public;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_ActionId=aa19b4e1-e3b7-461e-9c6b-e9bc59e183cc;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_ContentBits=0
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=Dell.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7364def3-5b6c-41d0-5bf2-08d999161254
x-ms-traffictypediagnostic: MW2PR1901MB1994:
x-microsoft-antispam-prvs: <MW2PR1901MB19943563D573B28D05A79E64EE859@MW2PR1901MB1994.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +Qe2fIv3RVl6U3wmLOMueJvqjHb5nJwKXRDr0gt6+xV5uBbEBZwRVv7WBITETQJpXtHa8afus+xU4+yJokaE02ZJgKZ/DJsOORdsESCvMFjW8kmW2w32NlBN9zLSUIxvOWrUsuscLtYkoUOHoJRuAiJJyEsfm6l6sV5thIoJ/dnleQ0yh6L0uvK3jhsfUAy7QizGz9t30aDjAR5Uga5kI/grkgQgQFW80r4T2Da4nio0qK2Q3Um9D6psTCn9UXtXogonoIS5oQ7XFXqgCuunyCmLpQPEtITe2tyLZYb6LX4/D5foMIsPyAtUJ8dsRm0ADkYGGAmqkWvo1cINX7Unw2H8Q7tHcTEnghZ2u6si3eM9o5/2H0gaSna6g3qIz0tFAhf3gXOb0lYoPtPYsGzzKMYd+Vrh6caQoxzhmx1RVji2Oltt7CarVxy1he/I/SLw/nNXBPe55/QljNRvwf6mioUX6rSgbwxSfNwV+hYtnVY2YLDEeEqL4BL0YOUJerBDo8PHoXgpCSaEba9zf0Tb4by0nWyOBUW5RlRWRU85gA0aOIPdi2dW6Qgz4/pPXRfXTgrW6wAjXTTxOl8iibG6B7UixouoWAnVIvPFEpzXMhbM37m+iEfKO9HJbNLuHM9OFNjKDd8OX0YnTGPhnHNl7it/qpr1v4aMgiCfZ4zZREWUqk5alBEpReHc4nAbTzcH8lfBBGO3hUDeMqWQ+HQtJA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR19MB4885.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(122000001)(9686003)(33656002)(76116006)(66476007)(66556008)(66446008)(4744005)(66946007)(64756008)(508600001)(5660300002)(86362001)(83380400001)(8676002)(8936002)(38070700005)(55016002)(52536014)(7696005)(53546011)(6506007)(316002)(786003)(15650500001)(82960400001)(38100700002)(2906002)(71200400001)(26005)(186003)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXR4VEIvMndPQkx3MkV6MDY1d2srNXFPeFpjNVBVSXlOTU1rRXplZ0lacVlP?=
 =?utf-8?B?VVk3N1FzRDgyOG8vYjM5cEd6VHRkN3FFS1cyN0pVb3FaSUtMS3dhT054SDY4?=
 =?utf-8?B?QnJ4QVJ4TzRib205d2Y4RDc2SXZ2b05MbCswSkprRUduSnN5Y0RabU11VUhR?=
 =?utf-8?B?dVJCa3hjdkpoRXdlQm82ZkhySlRlZ1owQkJ2eHV4SEExU1RiS2R1MDduME5F?=
 =?utf-8?B?NXM5ZmF1blJMRHM0TEpaMVhIQzY0bktidmxtUldHRkFmRUtWT09XSUZFc2VT?=
 =?utf-8?B?WFVXWkRwb1ovTUpZUXo1ODBtMXoraU9zRDBsQkp3RDFXeUdPSTBmaHFoQ0Nt?=
 =?utf-8?B?Ukh4UElkMitOSm45TWxYTXNaUTRQWGxSMjh5SHlOdUZJcndPL3JSUWlqM29t?=
 =?utf-8?B?bUY1dmcwMEdZcGZnTjlGVlVYeXk2dUR6Q1RRRU4yeW1MV3RxUmhNWTRlVGY4?=
 =?utf-8?B?UHBqOGhjRmJaY2Z4T1hEQ0NMYmZYK2xCdFFBSWFtYkhFWUVwcVJJVE9iZWdy?=
 =?utf-8?B?NmFOczM1eGVxb3QyZjdxb25tam84TUc5ZmFNVFFuR2FZY1NocjJHcmhZS3JH?=
 =?utf-8?B?a0VaQUJpUllTcTc5dnFWM0ExSEhRdFo4QmJScHU3NWdMMi9JSzVwUGxUQmNz?=
 =?utf-8?B?MmtNUGpwVGNROGk5Wjd3NnFYTUduYUdMMFdhVnYxREV2SDFuRWpmbDAvZlkx?=
 =?utf-8?B?Skh4RFkxTkpONGw1UEdoNjdLUWJudXdNenZVUkVkWFlKZitTZW50TzhzZ1RC?=
 =?utf-8?B?dUFmQ1VDYUJzclJWcUtibE52QzkvaUpvOTNwUFdnczFKUEpsb3BxWmdhZXJz?=
 =?utf-8?B?blY3cE55YWF4RlpKRmNLVmtYQUVEdzhpSlRFSlFxb2FvRWsxOXpZcHo3UkNC?=
 =?utf-8?B?bG8zRkhGTWl1V2R3S2pVOW9BWGppSXhzMGRGMzBndzVnMUN1QlFjTEFFZm9R?=
 =?utf-8?B?OUFsb3lYb0srbzU1dUdQWUpveXlPbWI0cC9TN1pqdjYwWlBYUUNpWDhjTnI0?=
 =?utf-8?B?R1FBZTZkRTN2bzBiU3ovRXB3eWdQMit5TE40SWN5cnhLVlJGUVZHZVdQNmdC?=
 =?utf-8?B?eXU1Q0M0WGNwTHBTRncwcUlkNGxMemRneGlJOE1iKzBiOHVDOHJXUmJUZ3F4?=
 =?utf-8?B?OFdiVUNIK2FUQjZzOVY1RXAwTWtWMTgvejloN0hPeUZ5WWlCbUpWYk9Lajlj?=
 =?utf-8?B?b1QwbFYweWNQK2hUbU1zcVVmZExmMTRxelo4NmhJUUpJU2RWZ2pZakIzWDRz?=
 =?utf-8?B?QXhubHdnakk5QXBsRVZldUlLb0VEMWtmSkxtQ1VrYUViRCs1aG84RlFiMW1k?=
 =?utf-8?B?UWtzVkdYNmRuR2d5Tm5HVUc0SkFjU2drdlBrZ3J5N0FodnJ3dGkzeWVqTnBl?=
 =?utf-8?B?d0ZlNXB4YlF6Q0xsdlM1VHN0OENuNzJXQ3BXVkx3R05TT0ZTN0Q0NWphc00z?=
 =?utf-8?B?L2pVOVhvNGtySUNOTW04bTFPaDB0WDBLWWxCSGNwdnBhZGpEVGd0MEFVeW5L?=
 =?utf-8?B?bkQ3UjhJYTVBOHhVQmF3NGtpOHZ4dFZac0E4QWJMS1JLMmxZY0Vtd1VQZ0Fv?=
 =?utf-8?B?d2xkckEwYW54SXgwanY5OXJ6d2N3NDVpOHhXbVVaZktQR2pVSzNxZmRUUURq?=
 =?utf-8?B?UUdIWXkxcmFobFovWWlEK2xNOHRabXE0NHptdUx2cTZ5TFR5aTJCR1N6VWZh?=
 =?utf-8?B?RXIyZVMyOWlkVWVMc3RvUU5YWHFnSVNpV1J5a2xqZ3lMT0w0VmZHOVZyYlJ4?=
 =?utf-8?B?OGFUVlc0TE0xMFk1TW5LU0FRS00ybjhsWkZ6b2ZyWXFoRXdVMms2Ni9wL2hC?=
 =?utf-8?B?Z2FXN3RMY29xMjgzK3ZnUlo1aDFSNHp5NldoWS9HU1M3T0ZGam52bFlwazV3?=
 =?utf-8?B?NXUreHRtNU53THU4bzBIeXMrOUxpZHlYajV0bTY1NTZvemhVR0ROdFcwSkJt?=
 =?utf-8?B?Sk92YmcrMHdnbEN5RmNhckVNcGNHRml6SjM4R1JmMW4xSmt4S0V6NVd5VVU2?=
 =?utf-8?B?cDdRTVhNRXJOWG5TVVFDOFhjbTN4OHVYcnJVK1hLOFJtNUJOYmxXS0dILy9U?=
 =?utf-8?B?SGE4aGtVMmFadXpFalA1Z0w3WDFhRlJ0dngydjdhYVhOcjNiUThINEpPTDJy?=
 =?utf-8?B?OFNRUzg3dlNSdzRyYXRpM3hkajl2VzlNczl6L2lzZ0thdmZRdFJ6em9FQUli?=
 =?utf-8?Q?505eeVfn9E4MyOY1jx+eMwg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR19MB4885.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7364def3-5b6c-41d0-5bf2-08d999161254
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2021 06:50:32.4020 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I71wHYznmuWY68B+eob3pIatJYJKh955vlD49uOPY12ENMzfNNmH51PHG9tE00+uX/6B/rNe1YcdGBlKdC6wuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR1901MB1994
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425, 18.0.790
 definitions=2021-10-27_02:2021-10-26,
 2021-10-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxlogscore=978 suspectscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 malwarescore=0 impostorscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110270040
X-Proofpoint-ORIG-GUID: 18j5FKYoeL2E6EnB3KutiY6iXJ4CemsB
X-Proofpoint-GUID: 18j5FKYoeL2E6EnB3KutiY6iXJ4CemsB
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2110270040
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211026_235038_363157_E41FD70C 
X-CRM114-Status: GOOD (  18.66  )
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

VGhhbmsgeW91IFNhZ2kuIEkganVzdCBzZW50IHRoZSBwYXRjaA0KDQpBbWl0DQoNCi0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJnLm1l
PiANClNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMjYsIDIwMjEgNjozNSBQTQ0KVG86IEVuZ2VsLCBB
bWl0OyBsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmc7IGhjaEBsc3QuZGUNClN1YmplY3Q6
IFJlOiBbUEFUQ0hdIG52bWV0X3RjcDogZml4IGhlYWRlciBkaWdlc3QgdmVyaWZpY2F0aW9uDQoN
Cg0KW0VYVEVSTkFMIEVNQUlMXSANCg0KDQo+IEluIG52bWV0X3RjcF90cnlfcmVjdl9wZHU6DQo+
IDEuIEFmdGVyIGtlcm5lbF9yZWN2bXNnLCAncXVldWUtPm9mZnNldCcgaXMgZXF1YWwgdG8gJ3Np
emVvZihzdHJ1Y3QgbnZtZV90Y3BfaGRyKScNCj4gDQo+IDIuIHVwZGF0ZSBxdWV1ZS0+bGVmdCA9
IGhkci0+aGxlbiAtIHF1ZXVlLT5vZmZzZXQgKyBoZGdzdCBhbmQgJ2dvdG8gcmVjdicNCj4gDQo+
IDMuIGFmdGVyIHJlY3Ztc2cgLCB0aGUgb2Zmc2V0IGlzIGdyZWF0ZXIgdGhhbiB0aGUgZGlnZXN0
Lg0KPiANCj4gU28gLCBJbiB0aGlzIGNhc2Ugb2Zmc2V0ICE9IGhkci0+aGxlbg0KPiANCj4gVGhp
cyB3aWxsIGxlYWQgdG8gbnZtZXRfdGNwX3ZlcmlmeV9oZGdzdCB0byBhbHdheXMgcGFzcywgd2hp
Y2gNCg0KSSBzZWUsIHNvIHRoZSBwYXRjaCBzaG91bGQgbW9kaWZ5IHRoZSBjYWxsLXNpdGUgdG8g
bnZtZXRfdGNwX3ZlcmlmeV9oZGdzdCB0byBwYXNzIGluIGhkci0+aGxlbi4NCg0KPiANCj4gVGhh
bmtzDQo+IEFtaXQNCj4gDQo+IA0KPiBJbnRlcm5hbCBVc2UgLSBDb25maWRlbnRpYWwNCg0KWW91
IHNob3VsZCByZW1vdmUgdGhpcyBmb290ZXIgZnJvbSB5b3VyIGVtYWlscyB0byB0aGUgcHVibGlj
IG1haWxpbmcgbGlzdC4uLg0K

