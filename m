Return-Path: <SRS0=CVLn=P6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E61AC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Nov 2021 08:01:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 253366044F
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Nov 2021 08:01:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 253366044F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZLE/iKRASielM2y3jycfrsSvOkFlCYO6wO1KuPqWySI=; b=jI4QNVKcPUP257NwIo3HsA8oxL
	4cbvy0iPX5l9I9rMFNZyCo9Juk0IJgQfX3aF2USjJE0jdsDVfDegi5zhO17Edtn4tqeBGgXFXCwne
	kZMuBBsHMS+Il0mu5JBZtzHp5Q4/G7dM+HtAc4GgteRzWs0tDautjmtqL5CLQSNe98/ZctipACPon
	LcBK7COB8tiFyxlRrQoIw/lgbQGQhypM2Kbb56LnGg2oDPRaomHZRWLezg/qnMkQTPYOOlVKFxTXa
	LspATWvxqz4KjWzej/T8jPeqwmYlUVNS9z42zbVfGTD6OiDOFP8TO104grUf44fkBKpUnN2Zit+6y
	KgmvxAyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ml51T-007S7T-RX; Thu, 11 Nov 2021 08:01:27 +0000
Received: from mail-mw2nam08on2058.outbound.protection.outlook.com
 ([40.107.101.58] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ml51N-007S6z-K8
 for linux-nvme@lists.infradead.org; Thu, 11 Nov 2021 08:01:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alXWCVAzXzyChtoIOeHQX1/uq/BhXEFFNdg81uDjq4RCdHVN9AbWlCk0yGBauFd539M1niSWm+vuBCjRhfjmsvdk8bqeWAk73MDw2EeGn7vbHKyxURbnVeh8j9QTyKpCnpd41jsIFbhg6exMWCgTM4AXLs3KQhjgewXceOXih22qZQYX2xgy/vmTpDPLOPBEH1x0pb8OZIlPEiQkCt0bLF9rP7LI2uQcfrbrTX/mDMS+RgJEt2a+cxr+IlPkiAs20wHHoxL9m34yYs/vb7RXQMmGDMUf6QAh0GrZjF5e0HZsFTOfOnMQ3kaJWg6+ZVj9WhJe2h3cK1xgaBevm4RBSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLE/iKRASielM2y3jycfrsSvOkFlCYO6wO1KuPqWySI=;
 b=c9cEX/uUsuisHVgbxH+sZGyCCh6SXn7mIPKhizdYKMumRY2ynE4HD4uJrJT/tC4kuWtEebtszqiuTx3xNf/yatQK5dUr449BwqtW0YzYaqIiC9/FQtuB0uKNx7yED1ng/IT/bcbj27f61TJhgl6xCZyXL2ZrNMM5F63MKjauWZiXn3vx267G4PZGCkFQ20RtnWHrhlujlhdLC2FK3CHBkko/n2YLUQN38o7xNlsIEjzKeC2ABW9YVxrsdz2EqjPWwBKCbWK/Etwvvw2Laq+j+ICoN1E9iDcYBq7uR6cW8cgIuo2i9GU6tYOuLN8Py2F2J1nDIuPOovN6KRVfUct1tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLE/iKRASielM2y3jycfrsSvOkFlCYO6wO1KuPqWySI=;
 b=FySpAIKoleb73aGvFI8QmyysXWKxP1itGyc55vV3oX7CNLdjOWnJRcUgnqdzu5tka3MzHT9Be7P+/4uo4c9AKwTprpSK2lj1uwmKknZfzIfk3u6+hZEENA+CokGBbDYUNC0yNEXFACEymmO25jWAckOrSNM1URo9bOtg4b0/53ReFqjJCtDOu00V126kMpBpLN1z5JjRH4eVy4GtzKf6XiWmts9uDCpyObSpfqXd+UKfVWg1CXcmn1q9JcI2woGAVYfRPYKNISviFC3u0hcNxEXBIqKgC0I83Fh5BunCGGa/jYSOWzrANGO6eueoYEVs0RVlEXLkh3iHWgwFvu4bRg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1472.namprd12.prod.outlook.com (2603:10b6:301:11::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Thu, 11 Nov
 2021 08:01:07 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c961:59f1:3120:1798]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c961:59f1:3120:1798%4]) with mapi id 15.20.4669.016; Thu, 11 Nov 2021
 08:01:07 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "Darrick J. Wong" <djwong@kernel.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>
Subject: Re: [RFC PATCH 1/8] block: add support for REQ_OP_VERIFY
Thread-Topic: [RFC PATCH 1/8] block: add support for REQ_OP_VERIFY
Thread-Index: AQHX0UfScAsEJ1qSlk22dasx+1xeTqvzn38AgApiggA=
Date: Thu, 11 Nov 2021 08:01:07 +0000
Message-ID: <3875c1ba-e70e-baf4-bc3e-d0a7e22a7fc4@nvidia.com>
References: <20211104064634.4481-1-chaitanyak@nvidia.com>
 <20211104064634.4481-2-chaitanyak@nvidia.com>
 <20211104172558.GH2237511@magnolia>
In-Reply-To: <20211104172558.GH2237511@magnolia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8487657-f9d1-4c7a-f094-08d9a4e96ab3
x-ms-traffictypediagnostic: MWHPR12MB1472:
x-microsoft-antispam-prvs: <MWHPR12MB1472D59426598AF8DFA2B686A3949@MWHPR12MB1472.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IwEnRA7+ZNX3jXoMpZF6urOroJjGQEcgv5jK6Eqg1f5w2AJNQ+NJCq4GL9j7gn7B3oRbnBJPqsq1cBF9ucowUqgYLF42nGjhpDRNdhpnlnRDFmOaAId+R8eeLPr++dF8h1Qt7Qsjm52UrseUiEmzvoJlEG/thnGiF05MHIIzeeoS1XH7kJKHO7UT9R9iAWjXYH7VcYNAQbhfT3lBs+/WBDqtNlURoAQOquRQEzVMMejkARbU0PcYQeWkiwFZtx/wODmMUzenLBH8oPEzHyzAHqY1RlAxD01Cm2jm1AF3k5K31ROKnHJvLHw+OaGURGUtsz+xnxwRtkqiT4TlbvZ3injA2B1GV98kM1vUuHTUfM+aGw6d2hVtA9TH1anH6LeV/SP397J6y2ho3cOCT9gexAmiyq7sOliJ4Z1+Q5sABEehZrqSv0kykX4PijJT73byvrZ73pQASyPrMUiK7GTB3yGTdhIyrInXEkCnHR8ND/fCyGqBbpDGq5+j9HtIGTfaoIR0j4rUEc5EI8dW/NPr8FfsmhA0Hr4ejbFKWJB2Hu5jyrHhQctMuexbPZnnDibfAC865mYwMskjo4lSbVCZL5ZaDGVc2O/MadJgHrEFv4T75e1Nr4IEr0NBZzmF14e74/CxFpqPUxT52LwkQjmogyDfzq3gk3hQ2bhibw+7gpDR5b0O/Zm2DSG/U+W4ZuYnfbaWPtTD7tn+60kWqBc0QGUnqAgacL0HWdvU5GeyNULCCGJAAyRFvY7rkTYrDOtElqpuxeqe9jxuJDcRiNOmRA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(316002)(31686004)(5660300002)(66476007)(36756003)(8676002)(6512007)(8936002)(54906003)(2906002)(66556008)(31696002)(64756008)(4326008)(66446008)(76116006)(38070700005)(66946007)(38100700002)(122000001)(6916009)(71200400001)(2616005)(6486002)(6506007)(83380400001)(508600001)(53546011)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXFpeHhYYXByeXIzY2JHbVJJSmRqMTlueTkwWlVOSE5PQkRIakFlVVNPaHhw?=
 =?utf-8?B?dUVSbm9RRTBwYXhhdVZ3aFBnSnBFQlNFS0NtWjRQUklwbnd2K1Y0a3JsVDZN?=
 =?utf-8?B?OEZkZVZVcXlpemhsdlgwVGJ1L2llQzVGK1BvWGZMbDJuUDF0OThIdWxUem5E?=
 =?utf-8?B?eDVNeGlmU0hZbjRQOGp5enN0OU4xSWRFNHd3ZlMrUjB5eWJ3YkMrNFBuSmZ2?=
 =?utf-8?B?aldyYWg5T2locWNpdVk0TDFicldEZUhnOEZORVB5WVZacGZvTVgwdys5Mndl?=
 =?utf-8?B?SG9XSzJXb25yTE1qZGRLYU0zdkkzTjVjcHIvakxvdG5hN2Z1Ymo1c2hjOUFT?=
 =?utf-8?B?OHNLVmFBWVErL3Zoemk5MUZpVkFwN0IrM29uNklVZWtJdmExT0x6amtQUzhP?=
 =?utf-8?B?SW9Lc0YwbDlTKzE0MXIvNS9ubkVsVEdYWE10N3NBN002TXRDWThQWXROK1Ir?=
 =?utf-8?B?T1Jlc1FHQU45TGpyNmwvejc4NURJN2RGTjFBODB3Z1dkSlVSeUI5WE1RZ3pK?=
 =?utf-8?B?MnhkRFJLbVNrRS9pVHZCQ2sySGw3OHFqOHNRdkFDT2ZlbGFkMGlIOW42c1JP?=
 =?utf-8?B?RGQzM0xJVXhnc0JDWjFYeDBPd3lQaE1xa3VvYWpmTkVLZ1JIcnZkeGpHdFhY?=
 =?utf-8?B?bWpoVGVRbEdRcWNmdFdMK21xdVNYQ0ZXRmR1VGh1UkNYdWh1U25ZaEJCRnZW?=
 =?utf-8?B?RU9QcGNnQ1J2ZXRCT0JCc00xbU9OVEpvYm5QcHBqYW53RnhVOWRybW8yZGZs?=
 =?utf-8?B?MmxkWmRORUcyVTN2WXF6SWhUNXdDUkZVaFpVVUJia3drTno0YVRYQjFQbENp?=
 =?utf-8?B?U0ZSMDB6ZTYyaGVKWHNOTVZoMUVWL0d6cStDMGMzVmt1L3Ewa1BDUHZScnZq?=
 =?utf-8?B?QThDbDBOSHlyQXY3d1dOZjUvSDVEcXYwZE9uSzZUeWdhclc3Tk5hMnQwRk1I?=
 =?utf-8?B?dC9kNEY0MWNNVW16VG5YZHV6VGY2dWdXc1ZUODBjcHdrVVpqOVljRll1WWdl?=
 =?utf-8?B?cmp0a0dxK2pqR0wzT2oySm04bEN2NThndU9vUDNvWTQ1bFRNRHg4WDg1Y0Ns?=
 =?utf-8?B?dTN1ZVlhM2RYZnJoMExEZUJwbkc4RjQxNjVsSHVBb0wvUVFlWHNRRVBtT0Y3?=
 =?utf-8?B?NFVhMkF4eXQ4cUhWcmdwZVQzbGJvRVBHbFFQK3FZeCtVcVN1cWxxSFJjY0Qw?=
 =?utf-8?B?NTJ0aW1zZ1Rlb0NBb3dWbkdUMnUvWlN3UE5uR1ZDQlRYdmhta3RqOVFaeFhp?=
 =?utf-8?B?SDRLWDZZU2VjNUlydDdxd1NTT1ZrTXIveWN4S290clNxQjg4TVdHZFVuNm54?=
 =?utf-8?B?R1EzU2VydnhwN1dNY3JCQVdwR3lRVVVzdVROUis5aFdUUUFOdWlQYTg3bklM?=
 =?utf-8?B?WnROMTAvUnBudHcwVnpBWnoyUnJkS1VCU0l1b2JvNS84cjF2ZFFmZ1ZmNVhJ?=
 =?utf-8?B?ZXV3ZlNnK21sZHZpcTZGY256cGM4SVo4VVNPbFE0TGF6RFVhVEwrUEplQytF?=
 =?utf-8?B?WDhOWjk1TU40S3lNanROcVBDWlpRU1IvQjIySkZUTmZYWXVWZWFMaFR2YTNJ?=
 =?utf-8?B?L1JiaU5RRWlXU1ZidTVJT0t1Uzk0cm5iL0hNa3BFU0JieXhENTczVVA2Yk4r?=
 =?utf-8?B?VnBUWit0RlNSSmdtVnVsNFlBOGRpbUQ5ZHg1d0dha2ljRDJHS1d6NXJab3Ur?=
 =?utf-8?B?aW5yM29MeFB5WXJwOEt2QlFkbjdiMDJqblgrbUdhK3pJSXQyMXNZdEtxaHpD?=
 =?utf-8?B?a1JKa1d4MEMzWDVkTmNiaXA1ZWZ0WmVZSXhHNkJ6UElhQmdJcVV1SUlQUkdE?=
 =?utf-8?B?R2RCR2hRQ0czNXRsc2VqbnBnRW9ZdzhENHQ3bXJZbVpBaTJENGIzU1ovODRV?=
 =?utf-8?B?WFE3YmxsSHE5WkhvZDRJME9FT0JPM0ZZMVhXaFE4ZnAvVXdPazg1T0x2UGYv?=
 =?utf-8?B?OGpNb2tjNXFiNFdrTTNnbjgvUGp6MUVQNVhHc0RCMGZUeDA5cUE5aVJkZUFq?=
 =?utf-8?B?S1cxWlUxTGJUbGhVNFR3dWdtdWJ6RGxsUFAvMHRYMlBrMjFEamRFSVZnbGQw?=
 =?utf-8?B?QW4xMkY5c0Jkd3kxblFMdjJjaWk2amFnZmVaUlp3NEhSNzBhUFAxSWJNWHg0?=
 =?utf-8?B?ZXJtSFdpUTlxdCtieHRnOXRRNmJkOEZZS1NiV3Bicy9HYnpsRkxVdS95RjlZ?=
 =?utf-8?B?WmkxbHpoVWMxblJJdERNUlAyWjFoTGNIMG8vd3VGMlZ1NzBIWHkzektQK3V4?=
 =?utf-8?Q?/pbE97HVhQyB2xVV7OfGtyg6M2imvFGmDE8jrlUqII=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <38916031B5D5694FB0A19625758BC852@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8487657-f9d1-4c7a-f094-08d9a4e96ab3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2021 08:01:07.2799 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kpcaHjr7f2KnubCgqcs7Y28sqPN/EQ4AHrWpXdHzakdHCz9rkSD0zfynxpjiREwVpUPRVwzCu7vYQjo0D18NWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1472
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211111_000121_696345_11A87B00 
X-CRM114-Status: GOOD (  25.35  )
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

T24gMTEvNC8yMDIxIDEwOjI1IEFNLCBEYXJyaWNrIEouIFdvbmcgd3JvdGU6DQo+IEV4dGVybmFs
IGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiAN
Cj4gT24gV2VkLCBOb3YgMDMsIDIwMjEgYXQgMTE6NDY6MjdQTSAtMDcwMCwgQ2hhaXRhbnlhIEt1
bGthcm5pIHdyb3RlOg0KPj4gRnJvbTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNv
bT4NCj4+DQo+PiBUaGlzIGFkZHMgYSBuZXcgYmxvY2sgbGF5ZXIgb3BlcmF0aW9uIHRvIG9mZmxv
YWQgdmVyaWZ5aW5nIGEgcmFuZ2Ugb2YNCj4+IExCQXMuIFRoaXMgc3VwcG9ydCBpcyBuZWVkZWQg
aW4gb3JkZXIgdG8gcHJvdmlkZSBmaWxlIHN5c3RlbXMgYW5kDQo+PiBmYWJyaWNzLCBrZXJuZWwg
Y29tcG9uZW50cyB0byBvZmZsb2FkIExCQSB2ZXJpZmljYXRpb24gd2hlbiBpdCBpcw0KPj4gc3Vw
cG9ydGVkIGJ5IHRoZSBoYXJkd2FyZSBjb250cm9sbGVyLiBJbiBjYXNlIGhhcmR3YXJlIG9mZmxv
YWRpbmcgaXMNCj4+IG5vdCBzdXBwb3J0ZWQgdGhlbiB3ZSBwcm92aWRlIEFQSXMgdG8gZW11bGF0
ZSB0aGUgc2FtZS4gVGhlIHByb21pbmVudA0KPj4gZXhhbXBsZSBvZiB0aGF0IGlzIE5WTWUgVmVy
aWZ5IGNvbW1hbmQuIFdlIGFsc28gcHJvdmlkZSBhbiBlbXVsYXRpb24gb2YNCj4+IHRoZSBzYW1l
IG9wZXJhdGlvbiB3aGljaCBjYW4gYmUgdXNlZCBpbiBjYXNlIEgvVyBkb2VzIG5vdCBzdXBwb3J0
DQo+PiB2ZXJpZnkuIFRoaXMgaXMgc3RpbGwgdXNlZnVsIHdoZW4gYmxvY2sgZGV2aWNlIGlzIHJl
bW90ZWx5IGF0dGFjaGVkIGUuZy4NCj4+IHVzaW5nIE5WTWVPRi4NCj4+DQo+PiBTaWduZWQtb2Zm
LWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KPj4gLS0tDQo+PiAgIERv
Y3VtZW50YXRpb24vQUJJL3Rlc3Rpbmcvc3lzZnMtYmxvY2sgfCAgMTQgKysNCj4+ICAgYmxvY2sv
YmxrLWNvcmUuYyAgICAgICAgICAgICAgICAgICAgICB8ICAgNSArDQo+PiAgIGJsb2NrL2Jsay1s
aWIuYyAgICAgICAgICAgICAgICAgICAgICAgfCAxOTIgKysrKysrKysrKysrKysrKysrKysrKysr
KysNCj4+ICAgYmxvY2svYmxrLW1lcmdlLmMgICAgICAgICAgICAgICAgICAgICB8ICAxOSArKysN
Cj4+ICAgYmxvY2svYmxrLXNldHRpbmdzLmMgICAgICAgICAgICAgICAgICB8ICAxNyArKysNCj4+
ICAgYmxvY2svYmxrLXN5c2ZzLmMgICAgICAgICAgICAgICAgICAgICB8ICAgOCArKw0KPj4gICBi
bG9jay9ibGstem9uZWQuYyAgICAgICAgICAgICAgICAgICAgIHwgICAxICsNCj4+ICAgYmxvY2sv
Ym91bmNlLmMgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+PiAgIGJsb2NrL2lvY3Rs
LmMgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMzUgKysrKysNCj4+ICAgaW5jbHVkZS9saW51
eC9iaW8uaCAgICAgICAgICAgICAgICAgICB8ICAxMCArLQ0KPj4gICBpbmNsdWRlL2xpbnV4L2Js
a190eXBlcy5oICAgICAgICAgICAgIHwgICAyICsNCj4+ICAgaW5jbHVkZS9saW51eC9ibGtkZXYu
aCAgICAgICAgICAgICAgICB8ICAzMSArKysrKw0KPj4gICBpbmNsdWRlL3VhcGkvbGludXgvZnMu
aCAgICAgICAgICAgICAgIHwgICAxICsNCj4+ICAgMTMgZmlsZXMgY2hhbmdlZCwgMzMyIGluc2Vy
dGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+Pg0KPiANCj4gKHNraXBwaW5nIHRvIHRoZSBpb2N0
bCBwYXJ0OyBJIGRpZG4ndCBzZWUgYW55dGhpbmcgb2J2aW91c2x5IHdlaXJkIGluDQo+IHRoZSBi
bG9jay8gY2hhbmdlcykNCj4gDQoNClllcyBpdCBpcyBwcmV0dHkgc3RyYWlnaHQgZm9yd2FyZC4N
Cg0KPj4gZGlmZiAtLWdpdCBhL2Jsb2NrL2lvY3RsLmMgYi9ibG9jay9pb2N0bC5jDQo+PiBpbmRl
eCBkNjFkNjUyMDc4ZjQuLjVlMWIzYzQ2NjBiZiAxMDA2NDQNCj4+IC0tLSBhL2Jsb2NrL2lvY3Rs
LmMNCj4+ICsrKyBiL2Jsb2NrL2lvY3RsLmMNCj4+IEBAIC0xNjgsNiArMTY4LDM5IEBAIHN0YXRp
YyBpbnQgYmxrX2lvY3RsX3plcm9vdXQoc3RydWN0IGJsb2NrX2RldmljZSAqYmRldiwgZm1vZGVf
dCBtb2RlLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICBCTEtERVZfWkVST19OT1VOTUFQKTsN
Cj4+ICAgfQ0KPj4NCj4+ICtzdGF0aWMgaW50IGJsa19pb2N0bF92ZXJpZnkoc3RydWN0IGJsb2Nr
X2RldmljZSAqYmRldiwgZm1vZGVfdCBtb2RlLA0KPj4gKyAgICAgICAgICAgICB1bnNpZ25lZCBs
b25nIGFyZykNCj4+ICt7DQo+PiArICAgICB1aW50NjRfdCByYW5nZVsyXTsNCj4+ICsgICAgIHN0
cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5nOw0KPj4gKyAgICAgdWludDY0X3Qgc3RhcnQsIGVu
ZCwgbGVuOw0KPj4gKw0KPj4gKyAgICAgaWYgKCEobW9kZSAmIEZNT0RFX1dSSVRFKSkNCj4+ICsg
ICAgICAgICAgICAgcmV0dXJuIC1FQkFERjsNCj4gDQo+IFdoeSBkb2VzIHRoZSBmZCBoYXZlIHRv
IGJlIG9wZW5lZCB3cml0YWJsZT8gIElzbid0IHRoaXMgYSByZWFkIHRlc3Q/DQo+IA0KDQpZZXMg
dGhpcyBuZWVkcyB0byBiZSByZW1vdmVkLCB3aWxsIGZpeCBpdCBpbiB0aGUgVjEuDQoNCj4+ICsN
Cj4+ICsgICAgIGlmIChjb3B5X2Zyb21fdXNlcihyYW5nZSwgKHZvaWQgX191c2VyICopYXJnLCBz
aXplb2YocmFuZ2UpKSkNCj4+ICsgICAgICAgICAgICAgcmV0dXJuIC1FRkFVTFQ7DQo+PiArDQo+
PiArICAgICBzdGFydCA9IHJhbmdlWzBdOw0KPj4gKyAgICAgbGVuID0gcmFuZ2VbMV07DQo+PiAr
ICAgICBlbmQgPSBzdGFydCArIGxlbiAtIDE7DQo+PiArDQo+PiArICAgICBpZiAoc3RhcnQgJiA1
MTEpDQo+PiArICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPj4gKyAgICAgaWYgKGxlbiAm
IDUxMSkNCj4+ICsgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+PiArICAgICBpZiAoZW5k
ID49ICh1aW50NjRfdClpX3NpemVfcmVhZChiZGV2LT5iZF9pbm9kZSkpDQo+PiArICAgICAgICAg
ICAgIHJldHVybiAtRUlOVkFMOw0KPj4gKyAgICAgaWYgKGVuZCA8IHN0YXJ0KQ0KPj4gKyAgICAg
ICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4+ICsNCj4+ICsgICAgIC8qIEludmFsaWRhdGUgdGhl
IHBhZ2UgY2FjaGUsIGluY2x1ZGluZyBkaXJ0eSBwYWdlcyAqLw0KPj4gKyAgICAgbWFwcGluZyA9
IGJkZXYtPmJkX2lub2RlLT5pX21hcHBpbmc7DQo+PiArICAgICB0cnVuY2F0ZV9pbm9kZV9wYWdl
c19yYW5nZShtYXBwaW5nLCBzdGFydCwgZW5kKTsNCj4gDQo+IFdoeSBkbyB3ZSBuZWVkIHRvIGlu
dmFsaWRhdGUgdGhlIHBhZ2UgY2FjaGUgdG8gdmVyaWZ5IG1lZGlhPyAgV29uJ3QgdGhhdA0KPiBj
YXVzZSBkYXRhIGxvc3MgaWYgdGhvc2UgcGFnZXMgd2VyZSBkaXJ0eSBhbmQgYWJvdXQgdG8gYmUg
Zmx1c2hlZD8NCj4gDQo+IC0tRA0KPiANCg0KWWVzLCB3aWxsIGZpeCBpdCBpbiB0aGUgdjEuDQoN
Cj4+ICsNCj4+ICsgICAgIHJldHVybiBibGtkZXZfaXNzdWVfdmVyaWZ5KGJkZXYsIHN0YXJ0ID4+
IDksIGxlbiA+PiA5LCBHRlBfS0VSTkVMKTsNCj4+ICt9DQo+PiArDQoNClRoYW5rcyBhIGxvdCBE
ZXJyaWsgZm9yIHlvdXIgY29tbWVudHMsIEknbGwgYWRkIGZpeGVzIHRvIFYxLg0KDQoNCg0KDQo=

