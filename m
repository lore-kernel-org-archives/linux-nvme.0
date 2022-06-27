Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A15BC43334
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jun 2022 21:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RZYkWPjOA0RV+duUhQ75kSu/V+38SlZGZSqFJyQPwkg=; b=Cq2nWcFBwpGJziuC75MFCYtpUS
	CRbHKZ+QFmjCpTVC4WSqxkqjBKlamn78sdfMxuSu/aiuUkCx2tGo1Zvalj2waWHrbCbDk9PCOu9Gw
	BfoquRKk4iNieVIZz53jqOHyjVaaU4vKfF1+JEwUkQsCoufs6sErU6ReBIjafy/toqCpX3VRpA5Q9
	Pf3bRKXroKEM7OfSQ30bAg1cYCiJGSvuPyCPkAjEu2AlHMd3mpmkr4ASM9r/zWurNG2FmsoE3UOPe
	XNrocYUrgoRn4YGV0kkKQyt6RwfrhJf8uFYt+SFyIGZMNGzVVuZ0jJOUJuL+eCsMDbYbq4rIwnxJm
	YsFi6a5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5wNI-002uYb-JT; Mon, 27 Jun 2022 21:34:28 +0000
Received: from mail-bn7nam10on2068.outbound.protection.outlook.com ([40.107.92.68] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5wNF-002uX4-Er
	for linux-nvme@lists.infradead.org; Mon, 27 Jun 2022 21:34:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uaeoyqq6hHTSGKLvL55DiyHjut7fn43oDxgjy1jre7a+lr+3Shkdz9NJ+bF8wXhVdXg/lrpFGKnGUw01N3n5GlrYE4rkNvRPdeESf5LMkrbBZMi3aAVP64cG7yYe6jyzaqiAm3Um4HeJj+Et/HgAYGRtjf7IVyBBshioOAoAY0ZD/PlOKqWzXbRjbxAYnqbpciDnHdtqOUnLLMl9ek9JnXzGQFutTTxJPTL3WPpzVR7waIAUxANtpgPdhRsUiplQOqDoO6EjT4L6Vvz4RlPyUPpz5COTxRbBu7+07MH1EW+0mKf2dn2xGqtzmNFs1Omo4eXkkmxCKfvN29wRUkZ5Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZYkWPjOA0RV+duUhQ75kSu/V+38SlZGZSqFJyQPwkg=;
 b=dOJJw+CQeSnj1kscRTcJ2bwdFGWDEyWybgwLg75TL0A+VFL0absUj99sNVPN82u2Cz7TbAGqk/HvKD9JRg2XVsJVa5ydQaXzP1Hcm241Q6ZHI75p3RAsCdDeBn1JV4W3nMje1NPK/tPBAw3fSfZ3ZPFtVQfGQr313YSwOcUmIVTxPJKcpgQb/Wd4So7SVLGzgKluajf/7MLCauH/PxFZF4yHhS4aTY3VnnxQHo/wX9ng+7upx5Q6oDc/hCCMId+QZAan2F9V5F99+yr+mPC72Pxv7cB2Vkx8+1RnHEupq3xOxTRg6OZAPAON/aWTN1p924uWgs4QwVdHOgVwqWmzhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZYkWPjOA0RV+duUhQ75kSu/V+38SlZGZSqFJyQPwkg=;
 b=IiUfehKeReseiwNS33Lz7tYT04bel6OBRYMariZXmHo1/Z1LVi886wXBMGS6ypvDcjcM1YqVFguB3VKmuntM8uaypQTLRgLJZbOUOrnKlMyiA9Gqvo6eVj8wkdBE3saluOdKAtM+l6cBaWdaQp/pNdkfYY2KKS9DLSjT2UoaMMO3ycILjN5ud6bVl1ws7mzb9ejqGuB2OSYF5MD0etZY0cDqb7FgwQdOgeVMt9Fxa34JrjZ2agSbGHCFMGvJKHHxVHGB5sfQeNEVTAI06UqtdudHuICQ22UV653eeaC3SUC0+Xdyq8b1KU1Lu6HGQukeL2xdh3UkV6pCgVIwvCWFZw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CH2PR12MB4037.namprd12.prod.outlook.com (2603:10b6:610:7a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Mon, 27 Jun
 2022 21:34:16 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::240b:5f1b:9900:d214]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::240b:5f1b:9900:d214%7]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 21:34:16 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
CC: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCHv18 00/11] nvme: In-band authentication support
Thread-Topic: [PATCHv18 00/11] nvme: In-band authentication support
Thread-Index: AQHYigvvTfKbwtQlBUe6Ol6RHoA6yK1jxzSA
Date: Mon, 27 Jun 2022 21:34:16 +0000
Message-ID: <b08b8df2-b278-21dc-aff0-b126a70363f5@nvidia.com>
References: <20220627095207.105201-1-hare@suse.de>
In-Reply-To: <20220627095207.105201-1-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e052b42-1dbf-47f7-2f38-08da5884c938
x-ms-traffictypediagnostic: CH2PR12MB4037:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  G/Wf8KHdUezuH/nMQUCr689QaIFht2NcwCLkrzVput3VLscP5StWAqU8UJ+mSiRpr2MxU8jZWBs+KiFqZ9pBO9EOXKpxEKF2dW3ibg+O6slatGxGvMkit6jo5cdmIDrTp+kjJlphv721i0sHzfaPssd0Gmu9LvyJ8CH3V6fheSVuyuStwsudkghRHAzhsK2Glaw4BdsX0BYVcgYOx+gL/1vjLFffixXnII+dvsVU9jsBFLrpCzLQ+7+wIQpqk9ouQlGzm+HijMBjnrBIrSYn2FWLer9vXYPM4Cc4bwjgK4CeDD6sbwMZ2G36p3SO8OWSxgbjEvdV5F5oAo1W02J0rDLbjC9/5Ck02FANNI72TqeXth7m8Bk8vDAQaJZ+OcBLO2VsB4/hFnxu3NfmREio9SBXkpxXpsPl491o9eCfRzG5FIRxSdwpsT7/v5DZBozHbkFJrd2C+GN9vXFQ86929zkxlQN36OTm063nbcrZKe9/qu2z6Adh5Kz4lvAhtoQguRXWrygYio32nMSUDpchpAIGV1HHXIqgW6umcYPdYY3xb2haW26lgIS5RbeTNFAqE+IWBxySvZaMQ4rydzVjVUUt9od5WOCZSdpV9+5dzD5+dVaPKSnig0q9ZDt/uo3r4+PJooy1NLCu9VvKMed5lOToSyihn8QUFfKkGQtZoA3CnlE8lLCgBy5lXKfLFUDryXUNleB28Uv/EdFJ+AHVWtyL1TUp7esFtVrvJqmebPramkis53Z2C20RvWOSM17a1bzv7h8v50+yEb6T5T4WzWckpgdKpFFv3cC5fGBw56A9j1+1ZDPMNgR1ZoQrObkid1ut5nZr4Z8kJYCJyrY2U5vfv57UL4bYHBbiijEYQC0=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(396003)(376002)(39860400002)(366004)(31686004)(66476007)(64756008)(83380400001)(66446008)(41300700001)(66556008)(38100700002)(31696002)(316002)(6506007)(36756003)(8936002)(186003)(91956017)(478600001)(4326008)(2906002)(76116006)(6486002)(2616005)(71200400001)(122000001)(66946007)(110136005)(86362001)(53546011)(54906003)(6512007)(5660300002)(38070700005)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?WVBhdzhJWEZFVkx3aUdieFVRY2hERFFqd0Q4Vnd5T3N3RlMzSzFrSlFWWkda?=
 =?utf-8?B?a2E1WHNHOVhnZmtJcHRKaVROWWoxR2w5cjRmZkRiQTRGZWxUR01ockNtT0w2?=
 =?utf-8?B?ZEFXeFdYRjRrN1FOd2JmODlJaUtWQTNCU2FoSUtXU0JPcys5ek1rNHBpSS8v?=
 =?utf-8?B?NnhuclowUVZ0MWtNSEM4VkRheWF4Z01YdU0vTndrR2syOXQ3V0pILzNoWnhD?=
 =?utf-8?B?Y0cvRlJMN2dIemJYdHg4TGc1ZmdHQ3BzcG9qcmYxaU9QTFd3Qm5jL3pZaEQ0?=
 =?utf-8?B?RXhkbFFQK3Bsc255YktQK0FWTzRiektBRzVkMUdQQ0FmN1VaUUp1V1ZkdzJM?=
 =?utf-8?B?VGE3aFYzcGhrS3A0b1FJQ3NxSm1RcWhkT2g5RkFXaUU3ZjU1TG5uZTlHUFJu?=
 =?utf-8?B?V0NpdkRYZGxiVVFCVCtVVU56VDZTZUcxdy9Ud2VQUWdJeWhXRVJ1N1Jnb2Z2?=
 =?utf-8?B?ckVvUm9zN2N0VUZlNUNaYU8vbE1nYjJsZnJMMDBHVW1ydWRxSjBhTkZzUzB0?=
 =?utf-8?B?WHZRWThSejgzTzNSemY4bFNLOHo4WEFOUFVuMC9QcEVTQnpFaHF1V1MxdUxM?=
 =?utf-8?B?c1c1Rkd1UmVTd2ozWFE0SXBCU2VyUkFpMWtsREpzTUU2b3RGeEJBL1ZySU5G?=
 =?utf-8?B?aTRQeW1QMTYzMTc4aTRQYnpaSW5COUR1MGZVM0R0M1poMm55TFZBQ3dBcmJH?=
 =?utf-8?B?anUyK1I2WUk2am1lbHRsTEVzcFRMZndZQThTRDRwUTlORThvM3prbUdEeUhX?=
 =?utf-8?B?SzRSY2ZhSGdaZU5nQXJ3STRtLzdJOEZ2RmxFWStzdEYvc1dqcEplbERRRG9a?=
 =?utf-8?B?Q0VzNVpXUllyb3MrU2tPVGJrd1ppVnFHK3JybWs2aDhTdXhMSG1wL3VrdzNW?=
 =?utf-8?B?ZmQwQVB2cUs4M3hxQWVXbXpFVlZ6T0k5M1liemVwUEN0aGxabUdyOG9vN0FR?=
 =?utf-8?B?TGNlZ0k0YnFlbGtpNlg5U2crWElGbjc3WEd6bHZuT1JJYjMwZjl3TS9qTzBt?=
 =?utf-8?B?cm5vZjUwdWU2RHNaQVIzOSs0cUw5K1V6YUZnb1A2VzFaSVBaWUdNczNHUEpJ?=
 =?utf-8?B?UnhYWW1hKzdIdkFRQUxoblkvSHJRbWpqdkFqdWNZU3paV1hQcUhOV0pLUGxS?=
 =?utf-8?B?Qkt4bTF6VVNsK3V1K2NiSVpHa25XamZzSVRiU2tFbitBenZGZ1d4MGNGZlls?=
 =?utf-8?B?SHZnTWtHa1QwUTl6a0NHamxrOS9zQWhXaDBLRGw1SEVvb1NTUURHSkdzRTla?=
 =?utf-8?B?R0JWTXRLOU5lVklsK0VzcHpiV2IzUU84MHBCaVBSNFh0cUlWZW9qK1I1YTh2?=
 =?utf-8?B?eWp0YTFQZGNGekdpMmVIOGRvWXpTSVl3eFBLNytjdEtuUWU2dDl0K0dEcEQw?=
 =?utf-8?B?TGZFR3I0MTk0L1lsNm9UdjRNQzNTY3dLVGUyVVQ4VmNCME9QUFAzTk5JQU83?=
 =?utf-8?B?eVVSYzFhRmlnQklnL0ZMZlB4MjB6N1JEbTJrOUozZk5HNjUvcmh5MEl0MHlB?=
 =?utf-8?B?N3NrNjJSZVpPb1dvWldZbFNxc0ZFZ0UyUnA0cGl2QTBJSEVFYmw4dk1LVmY3?=
 =?utf-8?B?ZnkwejhzY1JPVWVVQXJDTVNiTzdVb1ZCNjJoTlEzdGR0RGZTcmhmQWVwTXAx?=
 =?utf-8?B?dUhScWVLMkk4b09DS1ZhYVd6eExmb0hZRTlrb3N2cXNXMjdRQTIzTGFWdW5y?=
 =?utf-8?B?ZCtoY2FXcmVYZ0t5Ny82VXhKZ2NBN1F3RVhZZThGc1l0MVpaWFZYVnV5cGJl?=
 =?utf-8?B?RWhUU2pianloTmE2eDVyeUlTUk05QkJFRUpJWkN4cm5jV0VnMlZOc01uYjNy?=
 =?utf-8?B?a0ZwdjVUc2pZaFFsRHBXdWo1MEJuNytpZVVDajlzakpyQm1uN3NjbTUxS1N1?=
 =?utf-8?B?OG5iMlVZc3VDOVhGbzlZS1FEMzJSbjhtL0NjOVRORkNEVCs1R3k0VkE5RW5p?=
 =?utf-8?B?YmNkeGlwOUZ2a0lIaStDc0V6bW4zcDVFbmlTRDV3dkZ0UW1NSThiTUtaUkRD?=
 =?utf-8?B?aXBPRjlOT25xOWlwdTI2UGo5Zmhlalp1MjA2cWVKbEVnYlFUN0RXQzF2VHM5?=
 =?utf-8?B?MEdKaHBTQ1NweXl5Y09EVHZ3aW9VYmErQnJGUmRueTVEUEhnRHJGY09oMHJO?=
 =?utf-8?B?OVBhTlVxOThNT3pqTHY3cnZVMDhZWTVLZWZkaGs5MUtTdzJkenNKL1MrYkR5?=
 =?utf-8?Q?NtxWjthuhiWOyd7PjpBVv2pjFa80JZY92LrU0qjpr0PH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F5A51AE50656844BD725B4A0BEA2022@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e052b42-1dbf-47f7-2f38-08da5884c938
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2022 21:34:16.0551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wKV42Goi1zCehd9wtO1j22+Zm0/GLHFd8rTtT26t8aYkbvXil3YLTp1crcXJ7GMLgSSlZSsuaGrq7TphzCOHJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4037
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220627_143425_833509_A54E61EE 
X-CRM114-Status: GOOD (  20.66  )
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

T24gNi8yNy8yMiAwMjo1MSwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOg0KPiBIaSBhbGwsDQo+IA0K
PiByZWNlbnQgdXBkYXRlcyB0byB0aGUgTlZNZSBzcGVjIGhhdmUgYWRkZWQgZGVmaW5pdGlvbnMg
Zm9yIGluLWJhbmQNCj4gYXV0aGVudGljYXRpb24sIGFuZCBzZWVpbmcgdGhhdCBpdCBwcm92aWRl
cyBzb21lIHJlYWwgYmVuZWZpdA0KPiBlc3BlY2lhbGx5IGZvciBOVk1lLVRDUCBoZXJlJ3MgYW4g
YXR0ZW1wdCB0byBpbXBsZW1lbnQgaXQuDQo+IA0KPiBUaGFua3MgdG8gTmljb2xhaSBTdGFuZ2Ug
dGhlIGNyeXB0byBESCBmcmFtZXdvcmsgaGFzIGJlZW4gdXBncmFkZWQNCj4gdG8gcHJvdmlkZSB1
cyB3aXRoIGEgRkZESEUgaW1wbGVtZW50YXRpb247IEkndmUgdXBkYXRlZCB0aGUgcGF0Y2hzZXQN
Cj4gdG8gdXNlIHRoZSBlcGhlbWVyYWwga2V5IGdlbmVyYXRpb24gcHJvdmlkZWQgdGhlcmUuDQo+
IA0KPiBOb3RlIHRoYXQgdGhpcyBpcyBqdXN0IGZvciBpbi1iYW5kIGF1dGhlbnRpY2F0aW9uLiBT
ZWN1cmUNCj4gY29uY2F0ZW5hdGlvbiAoaWUgc3RhcnRpbmcgVExTIHdpdGggdGhlIG5lZ290aWF0
ZWQgcGFyYW1ldGVycykNCj4gcmVxdWlyZXMgYSBUTFMgaGFuZHNoYWtlLCB3aGljaCB0aGUgaW4t
a2VybmVsIFRMUyBpbXBsZW1lbnRhdGlvbg0KPiBkb2VzIG5vdCBwcm92aWRlLiBUaGlzIGlzIGJl
aW5nIHdvcmtlZCBvbiB3aXRoIGEgZGlmZmVyZW50IHBhdGNoc2V0DQo+IHdoaWNoIGlzIHN0aWxs
IFdJUC4NCj4gDQo+IFRoZSBudm1lLWNsaSBzdXBwb3J0IGhhcyBhbHJlYWR5IGJlZW4gbWVyZ2Vk
OyBwbGVhc2UgdXNlIHRoZSBsYXRlc3QNCj4gbnZtZS1jbGkgZ2l0IHJlcG9zaXRvcnkgdG8gYnVp
bGQgdGhlIG1vc3QgcmVjZW50IHZlcnNpb24uDQo+IA0KPiBBIGNvcHkgb2YgdGhpcyBwYXRjaHNl
dCBjYW4gYmUgZm91bmQgYXQNCj4gZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9r
ZXJuZWwvZ2l0L2hhcmUvc2NzaS1kZXZlbA0KPiBicmFuY2ggYXV0aC52MTcNCj4gDQo+IFRoZSBw
YXRjaHNldCBpcyBiZWluZyBjdXQgYWdhaW5zdCBudm1lLTUuMjAuDQo+IA0KDQpJIHdhcyBhYmxl
IHRvIHJ1biB0aGUgVjUgb2YgYmxrdGV0cyBvbiB0aGlzIHZlcnNpb24gc2VlIGxvZyBiZWxvdy4N
Cg0KSSBhbSBzZWVpbmcgZmV3IGVycm9yIG1lc3NhZ2VzIHdoZW4gSSBydW4gd2l0aCB0Y3AgYW5k
IGxvb3AsDQpwbGVhc2UgaGF2ZSBhIGxvb2sgdG8gbWFrZSBzdXJlIHRoZXkgYXJlIHRoZSBleHBl
Y3RlZCBvbmVzLg0KDQpJbiBjYXNlIHRoZXkgYXJlIGV4cGVjdGVkIG9uZXMgbGV0cyBmaWx0ZXIg
dGhlbSBvdXQgc2luY2UgaXQgd2lsbA0KY3JlYXRlIGNvbmZ1c2lvbiBhbmQgcGVvcGxlIHdpbGwg
c3RhcnQgcmVwb3J0aW5nIHRoZXNlIGlzc3Vlcy4NCg0KLWNrDQoNCi0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpSdW5uaWcgIHRlc3RjYXNlIDQwDQoN
Cg0KKyBudm1lX3RydHlwZT1sb29wDQorIC4vY2hlY2sgdGVzdHMvbnZtZS8wNDANCm52bWUvMDQw
IChDcmVhdGUgYXV0aGVudGljYXRlZCBjb25uZWN0aW9ucykgICAgICAgICAgICAgICAgICBbcGFz
c2VkXQ0KICAgICBydW50aW1lICAwLjM3M3MgIC4uLiAgMC42NDdzDQorIHNldCAreA0KWyAxMDM3
LjAyNzQ2OF0gbnZtZSBudm1lMTogcWlkIDA6IGF1dGhlbnRpY2F0aW9uIHNldHVwIGZhaWxlZA0K
DQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpS
dW5uaWcgIHRlc3RjYXNlIDQxDQoNCg0KKyBudm1lX3RydHlwZT1sb29wDQorIC4vY2hlY2sgdGVz
dHMvbnZtZS8wNDENCm52bWUvMDQxIChUZXN0IGRoY2hhcCBrZXkgdHlwZXMgZm9yIGF1dGhlbnRp
Y2F0ZWQgY29ubmVjdGlvbnMpIFtwYXNzZWRdDQogICAgIHJ1bnRpbWUgIDIuMjUycyAgLi4uICA0
LjI4NXMNCisgc2V0ICt4DQoNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0NClJ1bm5pZyAgdGVzdGNhc2UgNDINCg0KDQorIG52bWVfdHJ0eXBlPWxv
b3ANCisgLi9jaGVjayB0ZXN0cy9udm1lLzA0Mg0KbnZtZS8wNDIgKFRlc3QgaGFzaCBhbmQgREgg
Z3JvdXAgdmFyaWF0aW9ucyBmb3IgYXV0aGVudGljYXRlZCANCmNvbm5lY3Rpb25zKSBbcGFzc2Vk
XQ0KICAgICBydW50aW1lICAwLjY3OXMgIC4uLiAgMy4wMzlzDQorIHNldCAreA0KDQoNCi0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpSdW5uaWcgIHRl
c3RjYXNlIDQzDQoNCg0KKyBudm1lX3RydHlwZT1sb29wDQorIC4vY2hlY2sgdGVzdHMvbnZtZS8w
NDMNCm52bWUvMDQzIChUZXN0IGJpLWRpcmVjdGlvbmFsIGF1dGhlbnRpY2F0aW9uKSAgICAgICAg
ICAgICAgICBbcGFzc2VkXQ0KICAgICBydW50aW1lICAxLjMwMXMgIC4uLiAgMS45MDRzDQorIHNl
dCAreA0KWyAxMDQ2LjMyNTQwNF0gbnZtZSBudm1lMTogcWlkIDA6IGNvbnRyb2xsZXIgYXV0aGVu
dGljYXRpb24gZmFpbGVkDQpbIDEwNDYuMzI1NDE2XSBudm1ldDogY3RybCAxIGZhdGFsIGVycm9y
IG9jY3VycmVkIQ0KWyAxMDQ2LjMyNTQzOF0gbnZtZSBudm1lMTogcWlkIDA6IGF1dGhlbnRpY2F0
aW9uIGZhaWxlZA0KDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tDQpSdW5uaWcgIHRlc3RjYXNlIDQ0DQoNCg0KKyBudm1lX3RydHlwZT1sb29wDQor
IC4vY2hlY2sgdGVzdHMvbnZtZS8wNDQNCm52bWUvMDQ0IChUZXN0IHJlLWF1dGhlbnRpY2F0aW9u
KSAgICAgICAgICAgICAgICAgICAgICAgICAgICBbcGFzc2VkXQ0KICAgICBydW50aW1lICAzLjcx
MHMgIC4uLiAgMy45MDRzDQorIHNldCAreA0KDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpSdW5uaWcgIHRlc3RjYXNlIDQwDQoNCg0KKyBudm1l
X3RydHlwZT10Y3ANCisgLi9jaGVjayB0ZXN0cy9udm1lLzA0MA0KbnZtZS8wNDAgKENyZWF0ZSBh
dXRoZW50aWNhdGVkIGNvbm5lY3Rpb25zKSAgICAgICAgICAgICAgICAgIFtwYXNzZWRdDQogICAg
IHJ1bnRpbWUgIDAuNjQ3cyAgLi4uICAwLjM0OHMNCisgc2V0ICt4DQpbIDEwNTEuNDY0OTM5XSBu
dm1lIG52bWUxOiBxaWQgMDogYXV0aGVudGljYXRpb24gc2V0dXAgZmFpbGVkDQpbIDEwNTEuNDY0
OTYxXSBudm1lIG52bWUxOiBmYWlsZWQgdG8gY29ubmVjdCBxdWV1ZTogMCByZXQ9NDAxDQoNCg0K
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NClJ1bm5p
ZyAgdGVzdGNhc2UgNDENCg0KDQorIG52bWVfdHJ0eXBlPXRjcA0KKyAuL2NoZWNrIHRlc3RzL252
bWUvMDQxDQpudm1lLzA0MSAoVGVzdCBkaGNoYXAga2V5IHR5cGVzIGZvciBhdXRoZW50aWNhdGVk
IGNvbm5lY3Rpb25zKSBbcGFzc2VkXQ0KICAgICBydW50aW1lICA0LjI4NXMgIC4uLiAgMi4yNjJz
DQorIHNldCAreA0KDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tDQpSdW5uaWcgIHRlc3RjYXNlIDQyDQoNCg0KKyBudm1lX3RydHlwZT10Y3ANCisg
Li9jaGVjayB0ZXN0cy9udm1lLzA0Mg0KbnZtZS8wNDIgKFRlc3QgaGFzaCBhbmQgREggZ3JvdXAg
dmFyaWF0aW9ucyBmb3IgYXV0aGVudGljYXRlZCANCmNvbm5lY3Rpb25zKSBbcGFzc2VkXQ0KICAg
ICBydW50aW1lICAzLjAzOXMgIC4uLiAgMC42NTVzDQorIHNldCAreA0KDQoNCi0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpSdW5uaWcgIHRlc3RjYXNl
IDQzDQoNCg0KKyBudm1lX3RydHlwZT10Y3ANCisgLi9jaGVjayB0ZXN0cy9udm1lLzA0Mw0KbnZt
ZS8wNDMgKFRlc3QgYmktZGlyZWN0aW9uYWwgYXV0aGVudGljYXRpb24pICAgICAgICAgICAgICAg
IFtwYXNzZWRdDQogICAgIHJ1bnRpbWUgIDEuOTA0cyAgLi4uICAxLjI5OXMNCisgc2V0ICt4DQpb
IDEwNTUuNzg0MjA2XSBudm1lIG52bWUxOiBxaWQgMDogY29udHJvbGxlciBhdXRoZW50aWNhdGlv
biBmYWlsZWQNClsgMTA1NS43ODQyNTddIG52bWV0OiBjdHJsIDIgZmF0YWwgZXJyb3Igb2NjdXJy
ZWQhDQpbIDEwNTUuNzg0Mjc0XSBudm1lIG52bWUxOiBxaWQgMDogYXV0aGVudGljYXRpb24gZmFp
bGVkDQpbIDEwNTUuNzg0MzI3XSBudm1lIG52bWUxOiBmYWlsZWQgdG8gY29ubmVjdCBxdWV1ZTog
MCByZXQ9NDAxDQoNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0NClJ1bm5pZyAgdGVzdGNhc2UgNDQNCg0KDQorIG52bWVfdHJ0eXBlPXRjcA0KKyAu
L2NoZWNrIHRlc3RzL252bWUvMDQ0DQpudm1lLzA0NCAoVGVzdCByZS1hdXRoZW50aWNhdGlvbikg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgW3Bhc3NlZF0NCiAgICAgcnVudGltZSAgMy45MDRz
ICAuLi4gIDMuNjg5cw0KKyBzZXQgK3gNCg0KDQoNCg==

