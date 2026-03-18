Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53387FF6E9A
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Mar 2026 00:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=abQJved9+TkKghYgnZnkPOIm8NocmFWXBY6f6nszS0A=; b=SzgURMSrTuyOUb4XBkshVuysCt
	IaRMotWdwGXKCqjlIoYGHTK6fk0DlqvEe9ob58KLtqdqnaHE2Z7gO5fWrgR7ifSbj0Cx2kSTym8CO
	onQpV2q0alyKYjdOBKTXRW9aBYXX9iG3sonK/A+j6ie3EAHyqciFrCL0qwek8xp9x7AOUSw2Q3D1t
	dBBgq2lAs4iPMxqyoCoP1JlUmoCYlOUY4ducMHRM+qb9Xe1rtsfmXbKg0Ibjp0ncJBh7Sb8sYA6zb
	6RUbM60Pcb3yiCmtvT4K+Ho0GAu488m4Rpjn9jiv/I7BY6UMffZILWn2FYO7uAc4wf0MC6HOCnxox
	uiDpR5/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2eiL-00000007VHS-12Rd;
	Wed, 18 Mar 2026 00:24:45 +0000
Received: from mail-centralusazon11011034.outbound.protection.outlook.com ([52.101.62.34] helo=DM5PR21CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2eiI-00000007VGe-2Dkp
	for linux-nvme@lists.infradead.org;
	Wed, 18 Mar 2026 00:24:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qnD0qwnRjTkOOEVRJiI/zpW0JG1+q1x2BGvcD9Fc744Z7cESK9qKw8jiGiOnkLYP3XYsc7PljbvPATjKuRjt+36qRqlgewa1m1GJTnjMLBHOUEbghM7uyWJWC709kIl6D/7GnglzaMy4H4WGnoz5v/RcNb+n2/Df7fe3KbtloCBvf42RtSRCHp6u6oiRrjjVkiLgWz/4/m/Itc9spWUGWvYr9+DZjhMZo8G1rjhuqQ7q6eBE9FxZVAN0Uml4glkm1a3pd0WvLrEXMCpT9JJWoWuu/jznkeuUTDi6MaZeNQJLcu0g7R0/5aMrkgDUNvNUws52Ams5aNEsQ0NOPw+t4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abQJved9+TkKghYgnZnkPOIm8NocmFWXBY6f6nszS0A=;
 b=pi7oldQ7MvMUOvmIQpNawXNsl75ZhfdL9dqDMnkquVuW1T3kIJa9uLZ5gC6yLKtNtw7aOsJQpm8fVKH9iVxkME21SKfarVpRk4V/4OvJ0RixAvMgaSJK491h+Xmb1YzmLrDeTTPXEDyCtXgGEMxNx3+2yxkBsFSComg4+Us3riCU2r/gwStNDrFEX4UUJMNn6Is6oroV/5E6jhqs1Mj46JHL9seu9o8/ahoSedjJowglXEtl69F37SugpH1V+8Vvk11gX505rFHD3eJdKDLlu7kihV7NMWLmgONmyGvTyyWLBIX0Vb15hkegxnMVH5UDS5esbaNiktSgbFjXASFr4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abQJved9+TkKghYgnZnkPOIm8NocmFWXBY6f6nszS0A=;
 b=aQUUilNysfGawUs47ZZqcij96g2FY0SgdwIaG5iJi0ZgTg7PCyKF/0991JBUb7pCayw3Fzyuil9s8jTxC+ndjb37rHe8Sq3xAq1nh6iXKviE/8aQECzyBGYr/yf3AyHgoZiC5Of/NQSyo0VEZSDLr8g37vJMhyubUxMmEND23YyrFvcK7Ndr9dynE6T9Y7/S4ysfaSFkA6VbewwKn7EpCPWBmjGycQex1DqisRNGDdJGeoYpgdVGnjoAGyLlGI/Ve3yQ+oj8LL+dwYQCc7NyXzDVQfj8QDQZ8JyvA4Xb155bUrohdfGBwRPUc71999F4PcYOBJorkvcXIiIteQ84Jg==
Received: from CYXPR12MB9386.namprd12.prod.outlook.com (2603:10b6:930:de::20)
 by DM4PR12MB7622.namprd12.prod.outlook.com (2603:10b6:8:109::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 00:24:36 +0000
Received: from CYXPR12MB9386.namprd12.prod.outlook.com
 ([fe80::edab:eb80:ee7e:e9b7]) by CYXPR12MB9386.namprd12.prod.outlook.com
 ([fe80::edab:eb80:ee7e:e9b7%3]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 00:24:36 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Maurizio Lombardi <mlombard@redhat.com>, "kbusch@kernel.org"
	<kbusch@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"dwagner@suse.de" <dwagner@suse.de>, "yjshin0438@gmail.com"
	<yjshin0438@gmail.com>, "hare@suse.de" <hare@suse.de>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "mlombard@arkamax.eu" <mlombard@arkamax.eu>
Subject: Re: [PATCH V3 0/2] nvmet-tcp: fix receive path error handling and
 state machine
Thread-Topic: [PATCH V3 0/2] nvmet-tcp: fix receive path error handling and
 state machine
Thread-Index: AQHctVLCIo8NrOF6L0GRsVgbS/VrFbWzcI0A
Date: Wed, 18 Mar 2026 00:24:36 +0000
Message-ID: <3a4e57c8-13ba-41b2-90d4-4b0d4a22cab0@nvidia.com>
References: <20260316143936.120999-1-mlombard@redhat.com>
In-Reply-To: <20260316143936.120999-1-mlombard@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYXPR12MB9386:EE_|DM4PR12MB7622:EE_
x-ms-office365-filtering-correlation-id: a7fdd2d8-0470-4351-11f5-08de8484bc69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 3yuMyLZ1xsnomvg3El8QWjGy3Q878Lwhkzw6PxJlVX0fk6nk/Vq33iFx3NDop7vr7hU/4ayHT8Dx5qaCnG8bIZxgnYMSAE6Rlo7WwCm88YbOHPzeg25GGZEQdLUMabURZ0+xVhZLB2gnHLVb3ChjBm/YylGbRsGRmZjwhZ/+Gs1jHEyg21qLm4YfTFM691a1Z73pHXnjEsLGs6mCycpUhvIeo+GwbfmQHTq69E68Qcvn2J2nyhRaPCeXSWIBhtT1OhiHrhJn65hPnBIgcjDh/QcvNeeG5nDV78U8QNwUrXbWtRn35q7R48suL3+cyujvlCEjhQOpkO1MW3aUCuuY87RGaq44tqKzLQ0sroSe3Eb9GQvRq4qtxxM9Mrn9hZfkbP1AqBmPimZgpG4W2Ua7fdQzB1Jt2ZG17SIPJb2VHzTDAexVRb9Ugcm3kxVbpfa+LXOT8TmPYqQGjtp7LPJne2PaJfLUEocnXzcuhsbOcWGzeSIUmaGZMqyV8R+zDjjzaMbcAN1CPhfnA9s+rvzV4/Vs8oxvRquj9nTkzQxS1oSURHH3yErTz79HBaieXnfCNzv7a35N4tR+UXjVUcE7Ri/L1Jq9iycZA1hYfkz2Z+pnJU8zIhj0a/2vxRsOpg65oaWcix8CAlD2vtLvU0kKBdcungrmN8yvOk58NBu5Vg3qhWwHWkX9Qjarx/qHwq2WppWn3vz2A3iTjTfpez+qX+P6jeP4obnUgbUg6779cS0LcNpBo56Ofei+e1KIdk8QCvc2omw53DiAIjO9jReuVKiNobi9KqNq5rkZHv/hsiI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9386.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QzBpYTBacTZkQzgwcnFCU2hESWw1VnZpUmFlcDl0emEvUVZ6ajN1eXJLRmYz?=
 =?utf-8?B?L0ZlcmQ0ejZYdTk0dkkvWVlySHY5QXdqS3VndUlNZkxMSXUvN0FNb0plQ2hI?=
 =?utf-8?B?ZkRHeFdxWVRmZUpvUGUydURYNVBPOFl3YWV0bVB4a2ZZY2RIdVpEUm1ud053?=
 =?utf-8?B?UCtWVCtwWHF1bTYyZTdWMFpTcWdlbUhzM0pYNm5KSmtWN0dTckNlek1OZ0hZ?=
 =?utf-8?B?UEsvV0pBVktMcXJuN1BucjBWSTgvZFJWbWN4TUIyYW95WHVCZDlVT2EzT2JD?=
 =?utf-8?B?VGl2OGNHbWpaM3dTTTgxeWhMZlFSdE55aDU3bVFlVTBCMnZ5akNEM1pXVVl5?=
 =?utf-8?B?T3ZGa1dWSnA4SUI5YjZPd09FeXo1bEhOek9qZHlFRUprU1VTTk1LYnY2eU9B?=
 =?utf-8?B?YVdYaTVvV3lVb3dxU3hGWitWazE2ZGYwNWZDZ2hiNndiU0pUWFhxTXB3M1dp?=
 =?utf-8?B?RCtvNEVWYkxZaHpjTVBYY1BwVkQ4b1FJbmp3MzdDTlJNNHV6RDJQUVhaL0R5?=
 =?utf-8?B?eStaanJqaElEeXdHQjU1Um9XTmtkVjlucGw2SU5zNWVNTzJtZlhKeG54c010?=
 =?utf-8?B?UVlhaHowcGJkNVRlMlVpRm54S1IxYTd5SllpMDZiTU1hbStsUlNMRHhYd2hl?=
 =?utf-8?B?OGdVaVBhUkZ5SGlxRWdEaC9LWGtKVVUwQ3FhOVVhditQeEd3bk9qYm5DN2k0?=
 =?utf-8?B?SSsycGxUcXlSaEVFTTJCWFZlRWZvTG5GVnhsdis0cy9CQXJoR3J2OGdTcDFK?=
 =?utf-8?B?c2hVdlZFVTA0ejl5bzgxY0ZsMWRLa212MkpKLzhPNkUvYVhRSnNiSWZuN1dR?=
 =?utf-8?B?K1NrNnUxalM1bG5sRWdKbytVbjlhY3hBOGkzVkFaZlhjMVdLV2NNSlFockZW?=
 =?utf-8?B?dnZTZjVXbWdBUEZIb3phK0UxZnFRSTVvSjl2azNOMnNXb1F4MythR0l6UWtG?=
 =?utf-8?B?TWlxSW1aam1IZ3ZQL0JGcFNBUWdBUERZLytWQ3BBRTBMR3dPZytxa3lrMG5W?=
 =?utf-8?B?NnZwNnFxbUpWV0IrWmxDa2MwUXB0WTRMQTlTMnk0R2dBWE9EQWtycVE3UkFV?=
 =?utf-8?B?UzhMdjVXL0dmL21jOFE5V0xPbFFPajBvVVo5cDhwUS9HVnd6eDFhcHJSdEk0?=
 =?utf-8?B?TXFIVTYrRmNJOUNqVEZqOUZJU2RFeVptYWV2RHVjN01KVGFBM21jV1BlUEdj?=
 =?utf-8?B?RTJ1bkgwMW1oUXpMSTBlMHJ3eFhxN0ZIUTRTWDJGaXU5WlBPNDJWYVV2S2g5?=
 =?utf-8?B?c0VyYWpEQ3hWUHhwdFBkcFFMWHE1WVo5RUhDb2JBbDJvMkpSVURTMDhNNU5u?=
 =?utf-8?B?TTZpeGJhQU5JSUJDemQ0Nmk4dVVnNmg2cW1jbHNRY1JnZlJBL1ZBV0ZrSys1?=
 =?utf-8?B?bVVLL1piTG9qempwd0FsSGVmRFRyOHJ5MEtaRUpUMGpLUUpKeFhFT2xvL3gw?=
 =?utf-8?B?N202REF4WGtsd3k4L1lOVkRhTFQ1V3UrWHZRQ2JyaVVibkJicXM2MlVTVm5S?=
 =?utf-8?B?ZVp3blc2MGZWVExZLzJpQXNxWjQ0ay9GcTNFbGlhNXBqNjJUa24yeHFETndm?=
 =?utf-8?B?OFlKaHB1RzlSWS8rWDNaYW1nN3RQSHFZcGs5SXNGaFlMTVpZOVNTcWhvRDR0?=
 =?utf-8?B?c0taSWYzV1dqKy8yZWJpQ0dkSkZLR203cUhnaWdmUEt5S2FvSTU2cEpjUFV5?=
 =?utf-8?B?UzV6TjQrT0lJZmVYZ01pcVJvVC81ME1xYkZMVVI1MjNPdGdlUnVZKzg4WGpM?=
 =?utf-8?B?dU9kcUNxSVY3Y1FiWXlCbk85K1pwRHZnb3l1S2dkdGFZWSt5c1ZRUFFOQWNj?=
 =?utf-8?B?VzM1TDd5VGJONSs1UUgzWURLSXBQYUFjMnBiMHdERkNPalhZbmVSZnhjMGUw?=
 =?utf-8?B?cWttV2Q0VTF1dGNUUyt5Ly80UlFaWjdhWi9JSENKa29STlF3MzBIMHBjRFlR?=
 =?utf-8?B?b2NTekV5NDhtUERQM003dW9oU1JmWjVZUENtTkF3eEtHMG1BYlFSSEtRRGNu?=
 =?utf-8?B?SENDTmlOeW02bFdKbzFBVWZvRmhCdk0xVU11QzR1K25iN1k4elNKajBxSW1C?=
 =?utf-8?B?N0NWZFpMMnBueE8zMjZheXlqbUZHM2NEM3F2c1IyaUdFWmJ4Yk9XK2syV1lj?=
 =?utf-8?B?clVnU3BTZEZQdStkZFBsZWVmVEtpUnFhWTVWZkwrRVlaSm9QUStTMjBsRE9x?=
 =?utf-8?B?ZW9CNUR6Qk9GakJCSEVHQXdpOEhmZ1JjS1pERzBIdDBxcnN1YlBkOEFLZk1h?=
 =?utf-8?B?ZGZYSGhlL0tNQlBWZEZXT29mdTVoSGFpU2duenZ4U3cvSTNQMk9MNXcyQ3pu?=
 =?utf-8?B?RDYwS1dkVUtHbXNwampjUEMwYm5ubGpScDhxZ3pIbHpRcmdTNFp1bDIrcmt4?=
 =?utf-8?Q?mBU9rRZlr8lSRDIEUhpYp+lx6W1xaS+nHpW92G8TC+hVT?=
x-ms-exchange-antispam-messagedata-1: q4xZyAqcGLIMaQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <693379B6EAB16C419B0E1DB5A6E504EE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9386.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7fdd2d8-0470-4351-11f5-08de8484bc69
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 00:24:36.4180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z0A8VHl0Qfzl96InRBRG4qn2bTkBLduc/XjVyLMm15/sdTVUkWr8BDZX89UVX6YXUw7YbRUgInG9DcJ9osuHQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7622
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260317_172442_571560_921BD47B 
X-CRM114-Status: GOOD (  14.25  )
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

T24gMy8xNi8yNiAwNzozOSwgTWF1cml6aW8gTG9tYmFyZGkgd3JvdGU6DQo+IFBhdGNoIDEgZml4
ZXMgYSBwb3RlbnRpYWwgaXNzdWUgd2hlcmUgbmV0d29yayBkYXRhIGNvdWxkIGJlIHJlYWQgaW50
byBhbg0KPiB1bmluaXRpYWxpemVkIGl0ZXJhdG9yLiBDdXJyZW50bHksIG52bWV0X3RjcF9idWls
ZF9wZHVfaW92ZWMoKSByZXR1cm5zIHZvaWQsDQo+IG1lYW5pbmcgY2FsbGVycyBhcmUgdW5hd2Fy
ZSBpZiBhbiBvdXQtb2YtYm91bmRzIFBEVSBsZW5ndGggb3Igb2Zmc2V0IHRyaWdnZXJzDQo+IGFu
IGVhcmx5IHJldHVybi4gQ29uc2VxdWVudGx5LCBjYWxsZXJzIGJsaW5kbHkgb3ZlcndyaXRlIHRo
ZSBxdWV1ZSBzdGF0ZSB0bw0KPiBOVk1FVF9UQ1BfUkVDVl9EQVRBLiBUaGlzIHBhdGNoIG1vZGlm
aWVzIHRoZSBmdW5jdGlvbiB0byByZXR1cm4gYW4gZXJyb3IgY29kZSwNCj4gc2hpZnRpbmcgdGhl
IGhhbmRsaW5nIHJlc3BvbnNpYmlsaXR5IHRvIHRoZSBjYWxsZXJzIHRvIGVuc3VyZSBwcm9wZXIg
c29ja2V0DQo+IHRlYXJkb3duLg0KPg0KPiBQYXRjaCAyIGNsZWFucyB1cCByZWR1bmRhbnQsIGxv
Y2FsaXplZCBjYWxscyB0byBudm1ldF90Y3BfZmF0YWxfZXJyb3IoKSBzY2F0dGVyZWQNCj4gYWNy
b3NzIHRoZSByZWNlaXZlIHBhdGguIEl0IGRlbGVnYXRlcyB0aGUgcmVzcG9uc2liaWxpdHkgb2Yg
ZXhlY3V0aW5nIHRoZSBmYXRhbA0KPiBlcnJvciBmdW5jdGlvbiB0byB0aGUgdG9wLWxldmVsIGNh
bGxlciBieSBidWJibGluZyB1cCB0aGUgZXJyb3IgY29kZXMuDQo+DQo+IFYzOiByZW1vdmUgbnZt
ZXRfdGNwX2ZhdGFsX2Vycm9yKCksIGZvbGQgaXQgaW50byBudm1ldF90Y3Bfc29ja2V0X2Vycm9y
KCkNCj4NCj4gVjI6IHNvbWUgY29zbWV0aWMgY2hhbmdlcyB0byBQYXRjaCAxLCBubyBmdW5jdGlv
bmFsIGNoYW5nZXMuDQo+DQo+IE1hdXJpemlvIExvbWJhcmRpICgyKToNCj4gICAgbnZtZXQtdGNw
OiBwcm9wYWdhdGUgbnZtZXRfdGNwX2J1aWxkX3BkdV9pb3ZlYygpIGVycm9ycyB0byBpdHMgY2Fs
bGVycw0KPiAgICBudm1ldC10Y3A6IHJlbW92ZSByZWR1bmRhbnQgY2FsbHMgdG8gbnZtZXRfdGNw
X2ZhdGFsX2Vycm9yKCkNCj4NCj4gICBkcml2ZXJzL252bWUvdGFyZ2V0L3RjcC5jIHwgODggKysr
KysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQs
IDM2IGluc2VydGlvbnMoKyksIDUyIGRlbGV0aW9ucygtKQ0KPg0KQXNzdW1pbmcgdGhhdCB5b3Ug
aGF2ZSByYW4gYmxvY2sgdGVzdCBvbiB0aGlzIHNlcmllcyB3aXRoIG52bWVfdHJ0eXBlPXRjcA0K
YW5kIHRoaXMgc2VyaWVzIGlzIHBhc3Npbmcgd2l0aG91dCBhbnkgcHJvYmxlbS4NCg0KV2l0aCB0
aGF0IDotDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29t
Pg0KDQotY2sNCg0KDQo=

