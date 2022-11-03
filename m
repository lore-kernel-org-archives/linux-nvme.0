Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 086C4C4332F
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Nov 2022 17:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eFmD0FUPhFLFL6y9ZzKtZB9zzUodmXXAw7Wtv9GSSK0=; b=1WrgqFdhJO5CMVq9rbxY0vy9D+
	sZlnpmfwob7Pyu0FSBN08/QmM6sJsiZyKQc5HVP4/lmoQ4wgTkfjY0W6v5uLC0pyOYhmvj+RjVXfc
	ARZK2Z4B6ihlMTPM7fF+AMlhK8uF6TcSlrpX2W88OgI68BKZr2Qs3a4XUlsYfmvET1I848xHDf9wL
	9RX+b7NpdGyY4d4hDk16XXahGpKEdevFxPnhX6VXewN3ekDbn/D6wSfz/E2esO28uDKepTFcRPJlh
	reP9xSzc/k7MCo2ILaBzjoTO7VmMOOi5dVyzmZEqVfPF78CqCs42EcgbJJ6zQEXBk6ztaXKkDiToq
	yk1TpOoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqdld-000ygB-Fz; Thu, 03 Nov 2022 17:12:37 +0000
Received: from mail-dm6nam10on2069.outbound.protection.outlook.com ([40.107.93.69] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqdW0-000rxm-Eg
	for linux-nvme@lists.infradead.org; Thu, 03 Nov 2022 16:56:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GyimZm9/htcsb7HUS9V/kJa3hSjLzpM7K92+u0+OIITXwMJI1b4pQA/s9AA5qYQCVrM5tUj5KUOTgvG5jd4L5p008g/dJXlRpnwiQGkEarotiTh7I5dwZqTaFEX7skHq8oRhkrYvXgr6BaUL8qD+OlMLequ4UA/Y+a+qYjjp98rMG2xnk/w3p6UgYyyxDFcWh/UzvYbccwYGsRqbU+czSkiL/CW+R15MEhhQkw2p9OmQwOyb6PbSiXagBgIVEM/LvLUXEIkn8lXgLQMXmQ/R5fX2+vjIZG9wSzo/kSuP2KP19gTrvgkLF78sBC93VorBmjXg8hTay8+TvSmQplg7gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eFmD0FUPhFLFL6y9ZzKtZB9zzUodmXXAw7Wtv9GSSK0=;
 b=AgAn8JmkDpOl7asgCZnOWEUsekEK4mhWYjJmzQAKEhATvuHvQ7WfymXq51Z/+zSzcAqwhJ9p0RdRamAOkraYyE0fVA8yQtqDzDr6d5mWFkxqARfrQwSNsa29ZNnlXBcmozLfhfYKhfVz3tB2vxuYIUd7ULTtyVUUWQvJRrJqzOVrHA7976USOsoPEE/3WunbOZ3UGfUciDCGJjY0QFwO+qazSg/OwL0q2eMXBebx0kjyV/9hhhJ7MK1aCMYNT2tJdzyql3McKK6n/0O918GtHFdqhHDTtEJEYDwu6PDTTPy3qeOaUFbztnGuKzaqZlh4kN4W/IRAVSsxBMBlukPtqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFmD0FUPhFLFL6y9ZzKtZB9zzUodmXXAw7Wtv9GSSK0=;
 b=h0hkgkOyK9g6zxdIbNpNjXWflXYNMmtyWFNuGl3AMwtnk6IKOa5jEEAWxWnyrDH8Il3ljukScHI7bWP37+LHclSEw/l/hU2hOvjCAd1uH/3rDQIQNU++6uiJfqHrt9KCsJF8+kYzM7V3BVXyvmUE1z6K4M4wI0I+KqB29B8+QvbciJ/mKyg97Fb6j9HxVLuGwSIHZL7rhOMD9t4El3Q6jmpWF2q2vY7gPXHeq84p2e55JjXq8EgrnHA8r6wfZODNiX/EnovTlUtLkb1i9lxWH/GENDcVBKLVjDArGbes1hjMk+iwo3wnOr2txz53YJnTvmIbQz+Rc3LvEFeF9Z2TGQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SJ2PR12MB7797.namprd12.prod.outlook.com (2603:10b6:a03:4c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 3 Nov
 2022 16:56:21 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5769.021; Thu, 3 Nov 2022
 16:56:21 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Joel Granados <j.granados@samsung.com>
CC: "gost.dev@samsung.com" <gost.dev@samsung.com>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de"
	<hch@lst.de>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/1] nvme : Add ioctl to query nvme attributes
Thread-Topic: [PATCH 1/1] nvme : Add ioctl to query nvme attributes
Thread-Index: AQHY74BkyASf7wI5l0OQ3/2FrzeTcq4ta2MA
Date: Thu, 3 Nov 2022 16:56:21 +0000
Message-ID: <9a55bbf8-1c38-3302-97be-376a3f2ec180@nvidia.com>
References: <20221103122746.3599480-1-j.granados@samsung.com>
 <CGME20221103123121eucas1p1b1919ee3bc9a86d6af56e5e5694e07f2@eucas1p1.samsung.com>
 <20221103122746.3599480-2-j.granados@samsung.com>
In-Reply-To: <20221103122746.3599480-2-j.granados@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SJ2PR12MB7797:EE_
x-ms-office365-filtering-correlation-id: fe234ace-1a7b-463a-9118-08dabdbc558f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  THsMjpl1lV3qHj6YwG1kEuMN/4CqZLvLZIzqFWmEQ9n5Tn0Xipy5YV04oC3bjFJLQdbSJYALCqZORF4bi/7IBflCCJZJlUM2SXbK0J+Qfjy3/Ci9vKuR/vEuLnaeQWNgOxPtlQDR8tHfVH1tJp0KmZMO0i56Tnt8R8QM/5hCkevF1GOR/QXiljd8wHTSa/AQFt5iqIERFjh7squsCN7VSy+kUonXVMzHFeHeKRYZTAml52r+Mqv8jsZdGGbtbe+SSjUBMlQ+Hb8JmNvWwRb9QbtCneoUJAyrITauzaLm0YWO9LLKaHweDrnQKkrhsOV7JKdCPA7cBn3rCPKkrdmDmWaniO4fyRGy1WcOfW4YxfdpEEvUll0qILec0vOUv1lTUa9iFEGfQowkMEsN4K1HlB1zFXh+otlVZKX7yhUISmZWvoXKRJHpfrAEveCmzrRnYJ4Rfbp4GZzOER7af/WO9rMotIzQfvM4nMjk3Odw8HDprr0Zbx/yQYsnilf2O3tsoI0ukZYU+sWOz+THN+XB3NrYyn0TPOs0tUMOuLhvOisSpnGt6poEh0mcJcqBX9LhfZlavfVur134cGSBB5fQfphfsRhK+aClOfOKpKIzPM2gtoSL2pARKYhQpDiZAep7PJgwVRy4qgNd8T1Os9eCYG/hZYRWjvZYhkbPZwvlCe2uZejL3YJpyWsIGILNLTz19NRPZlgquUBqoEAEAp0J95Xrj/VmEZabjBjPb26o7yYRd+FPCrLAHSywoUu2AFonZF6QR9h2CKWBt/qUDvbaGR1SJytwXiGYqP2l7qU/jzk9WbsqmpHGAVjBw5z+aXdOsTwk+bhrKqY+LwX2htTLDg==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(451199015)(36756003)(31686004)(122000001)(38100700002)(83380400001)(38070700005)(2906002)(5660300002)(31696002)(86362001)(4326008)(6512007)(316002)(54906003)(186003)(2616005)(478600001)(6916009)(91956017)(71200400001)(6486002)(8676002)(8936002)(76116006)(41300700001)(66476007)(66446008)(64756008)(66556008)(66946007)(53546011)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?dURvZGkzU08zei9qQ1l2bU9DV0RVZHNiTUZ3R1V2NUdTVzhYTzNFTkx6eUkr?=
 =?utf-8?B?KzNPcDYvcU1jenZJQ01rZVFxUXFteHFHaXI5bXFNY2g0U1ova0VWYUZ4bzJF?=
 =?utf-8?B?VFQ5ekxwUEpaZ1NIWFYwd3ZPbCtJRnVBMnMzemdScWZNNWVYU08yVzl4ejQ3?=
 =?utf-8?B?blB4MENPckgzM1RPNmxEc1V4SVdDTVpsYllGeTNtWFl4dXNML2FMTVUyYjZM?=
 =?utf-8?B?ZWkvektFUzdVcWMwZ2NJa21ta2tzclY0Mm9KRjk0Z0VTR0hjUHpISlFEbllG?=
 =?utf-8?B?bkZVTTRBK2txV1Q2eDVtU09jbEU4VUFtcWdqNnZnaXJJK1M2S3hqWm9wYXA2?=
 =?utf-8?B?ck9Pc296dnAzL1V6bzBwK2h6a3BHSGMzR2VzUUpVZTI3ODdvUllXK2pwN29j?=
 =?utf-8?B?aFhwTXQ5Wm5sNm8yN2h4NHdHZlJZUzFVbFhUekdaR2lVT01rRklDbW5GRHU1?=
 =?utf-8?B?aHB6SjdXekNLRkJ1V1l6N3JvMFpiWjlnL3FhRnI3b3BzaTZDWGtFdXh2QWsw?=
 =?utf-8?B?MlRoZ3VOWnFFU0xHdVNWU2tVRkhZb1JxQnBraS9rcEkxYzlsclhYQXkvVytm?=
 =?utf-8?B?THN4ZjVSUUtDMUp6MzBxMjlzbmJNVW1taVpUcFpSQ2hPUGE1V0tKa1pkVjEr?=
 =?utf-8?B?eWlDMm1XVVh4WWdZRDM2YTNqdGFyL3E0WWY2eFEvUHBybUMyKzZmc3B5NTdh?=
 =?utf-8?B?YXBYK2traytxUENoU3VaUWJROEhVWm12S2pCcnZiTmlMeTgzTFdxRlQ4UjNC?=
 =?utf-8?B?a1U4WFI4Tk9WekFhOHZmNzVIQThGYkJxNDUxN09CSDBkaTFFYUFsQnE1V29D?=
 =?utf-8?B?QW0yTkVGN3pNZFdsb3crcVB1WlNoV0JoSWR3R2xSejMrMHhxQzhRYXBDaG5W?=
 =?utf-8?B?ZU83cU5yQlJUc21zWGQ2MzE2cmcrSGlqMkFzN3FTOW94WEUydzViYlN5Kzln?=
 =?utf-8?B?V2lRbDV0QUtZbDNiQ0wrQ1I1TUsyc1J2bnVtTC9QK2UwSjRhbXJNUEVKSGRL?=
 =?utf-8?B?L3hKcW1jdHkyRjV5OXBpTnhnSkdDWW9rSE0zZHFpN2RZKzM0RUo3ZTlSMWd0?=
 =?utf-8?B?bWZtc0l5aC9ScHpCTHY5MkFwMWNKM2ZDajhSenBqTWtyOHE1UTZsNnVWTXhS?=
 =?utf-8?B?VTIzcmQyZnlBRlpoMkJaQlJPVkw0T0tGdyttUDBUVEk4OXhERmlmZGtacmFQ?=
 =?utf-8?B?ZDU4VWdnWVgyalJrRWlrZmx6TitsL2dZTlpPSnJOR0hXMkQ0c3h5VUs2MWEr?=
 =?utf-8?B?L3VFY004TGVlSk1nYlVYd1ZuanpobUt5dUZhNlZ6Q3ZSeTUyVTdodUJMbUg0?=
 =?utf-8?B?NWptWTVzU1JRNERuSmZmMGtGNW1HWXNVcC9hT1o1eTRGbHlTazV3RVAvdGd3?=
 =?utf-8?B?MlJmcDRYVzZObGFCQVhGQmt3OGtyNWFadE11eFNwY2RqRWl5TlF2cVJUazZK?=
 =?utf-8?B?WTBac2ZiU2wvMndFWS9mTUtrNnpHWGZ5bCtQeU9TUWR5RTlxa1d5MFAxa2Ru?=
 =?utf-8?B?a1JoNm9LMUh0dmdQekxYVnNyMjhhUFFsUUtucXNBbkdlTE9Rd0J0eERKSGlJ?=
 =?utf-8?B?MDF4M00vME91Z0RyQmVPZjR3VW1WaDVQMzdUdUxFMjQzUy81a3VtMnhtOUtt?=
 =?utf-8?B?bVM3cmxPbUs5dzlNclpyU1VyRnlpMTRhMlc0TWJCSHphTVpxcUZOZDRFUUlX?=
 =?utf-8?B?Z0I5V0Q1VjFLL05YdWVrMUhnRW9ybitTcHpIZytheVBNSzFITGFpOUV5YlJQ?=
 =?utf-8?B?QnF4R25GdDJ0YlVHV2F1TjFiaDc5cXVEN2JlYnFtdXpCWWhmWXJpb1YvbEdt?=
 =?utf-8?B?R0R2QlJ3QUYxWnkxQi82MGtIU0pIQ0dOVjRzaHViQWxFVU1Tcjl1dWVTdEF3?=
 =?utf-8?B?SjQ4WWV5VWRPMXkzbTZPbjJwbHVkSm9Jb1g1VjFZdGxhallOWWZnQlQ3QzJB?=
 =?utf-8?B?Zkhad1NvdDFVSFEyMWhDdVBHZTc2NlA4WnRSNEUzaExEUllET2RwVDN4anM1?=
 =?utf-8?B?QU9lblJINldwTjMwN3Y3Q1RTUFlIaDRqR3N3Y3RLa2RFYTdSMnlwMVlNSDhl?=
 =?utf-8?B?MExqWWVld3BDRGpURFVLeGQ2VXMvMXFabHhIVGVTWkhVZm5RWXdMZDNDeVNo?=
 =?utf-8?B?SGNBaGtPdXl0OUpCckx2RXkyRGdVc1BGMTMvWnA5VmRoWC82aXhKaFlDYytm?=
 =?utf-8?B?R3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FEAA2354C26F124CB9CD4385559F0680@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe234ace-1a7b-463a-9118-08dabdbc558f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 16:56:21.3007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cdkO4GpEJlcp/OINzHhJVi9VCDnO1cM9M+7LDlQuuCzxmTUVekXUqKhYqIsdg2GCXAwye21gh7PCm1Tmgijjmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7797
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221103_095628_778081_21A540F7 
X-CRM114-Status: GOOD (  25.59  )
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

T24gMTEvMy8yMiAwNToyNywgSm9lbCBHcmFuYWRvcyB3cm90ZToNCj4gQW4gaW9jdGwgKE5WTUVf
SU9DVExfR0VUX0FUVFIpIGlzIGFkZGVkIHRvIHF1ZXJ5IG52bWUgY29udHJvbGxlcg0KPiBhdHRy
aWJ1dGVzIG5lZWRlZCB0byBlZmZlY3RpdmVseSB3cml0ZSB0byB0aGUgY2hhciBkZXZpY2Ugd2l0
aG91dCBuZWVkaW5nDQo+IHRvIGJlIGEgcHJpdmlsZWdlZCB1c2VyLiAgVGhleSBhcmUgYWxzbyBw
cm92aWRlZCBvbiBibG9jayBkZXZpY2VzIGZvcg0KPiBjb252ZW5pZW5jZS4gVGhlIGF0dHJpYnV0
ZXMgaGVyZSBhcmUgbWVhbnQgdG8gY29tcGxlbWVudCB3aGF0IHlvdSBjYW4NCj4gYWxyZWFkeSBn
ZXQgd2l0aCB0aGUgYWxsb3dlZCBpZGVudGlmeSBjb21tYW5kcy4NCj4gDQo+IE5ldyBtZW1iZXJz
IGFyZSBhZGRlZCB0byB0aGUgbnZtZV9jdHJsIHN0cnVjdDogZG1zbCwgdnNsIGFuZCB3dXNsIGZy
b20NCj4gdGhlIEkvTyBDb21tYW5kIFNldCBTcGVjaWZpYyBJZGVudGlmeSBDb250cm9sbGVyIERh
dGEgU3RydWN0dXJlIGluIHRoZSBudm1lDQo+IHNwZWMuDQo+IA0KPiBXZSBhZGQgTlZNRV9JT0NU
TF9HRVRfQVRUUl97VjBTWixDVVJaU30gaW4gb3JkZXIgdG8gbWFrZSB0aGUgaW9jdGwNCj4gZXh0
ZW5zaWJsZS4gVGhlc2Ugc2VydmUgYXMgYm90aCBzaXplIGFuZCB2ZXJzaW9uLiBUaGUgY2FsbGVy
IGlzIGV4cGVjdGVkIHRvDQo+IHBhc3MgdGhlIHN0cnVjdHVyZSBzaXplIGFzIHRoZSBmaXJzdCBt
ZW1iZXIgb2YgdGhlIHN0cnVjdC4gRm9yIGV4YW1wbGU6DQo+IA0KPiAJey4uLg0KPiAJc3RydWN0
IG52bWVfZ2V0X2F0dHIgbnZtZV9nZXRfYXR0ciA9IHswfTsNCj4gCW52bWVfZ2V0X2F0dHIuYXJn
c3ogPSBzaXplb2Yoc3RydWN0IG52bWVfZ2V0X2F0dHIpOw0KPiAJLi4ufQ0KPiANCj4gU2lnbmVk
LW9mZi1ieTogSm9lbCBHcmFuYWRvcyA8ai5ncmFuYWRvc0BzYW1zdW5nLmNvbT4NCj4gLS0tDQo+
ICAgZHJpdmVycy9udm1lL2hvc3QvY29yZS5jICAgICAgICB8ICA1ICsrLQ0KPiAgIGRyaXZlcnMv
bnZtZS9ob3N0L2lvY3RsLmMgICAgICAgfCA1NyArKysrKysrKysrKysrKysrKysrKysrKysrDQo+
ICAgZHJpdmVycy9udm1lL2hvc3QvbnZtZS5oICAgICAgICB8IDExICsrKysrDQo+ICAgaW5jbHVk
ZS91YXBpL2xpbnV4L252bWVfaW9jdGwuaCB8IDc0ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKw0KPiAgIDQgZmlsZXMgY2hhbmdlZCwgMTQ2IGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9kcml2
ZXJzL252bWUvaG9zdC9jb3JlLmMNCj4gaW5kZXggMDA5MGRjMGIzYWU2Li4yNjdmMjg1OTJiOWQg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYw0KPiArKysgYi9kcml2ZXJz
L252bWUvaG9zdC9jb3JlLmMNCj4gQEAgLTMwNjIsOSArMzA2MiwxMiBAQCBzdGF0aWMgaW50IG52
bWVfaW5pdF9ub25fbWR0c19saW1pdHMoc3RydWN0IG52bWVfY3RybCAqY3RybCkNCj4gICANCj4g
ICAJaWYgKGlkLT5kbXJsKQ0KPiAgIAkJY3RybC0+bWF4X2Rpc2NhcmRfc2VnbWVudHMgPSBpZC0+
ZG1ybDsNCj4gLQljdHJsLT5kbXJzbCA9IGxlMzJfdG9fY3B1KGlkLT5kbXJzbCk7DQo+ICAgCWlm
IChpZC0+d3pzbCkNCj4gICAJCWN0cmwtPm1heF96ZXJvZXNfc2VjdG9ycyA9IG52bWVfbXBzX3Rv
X3NlY3RvcnMoY3RybCwgaWQtPnd6c2wpOw0KPiArCWN0cmwtPmRtcnNsID0gbGUzMl90b19jcHUo
aWQtPmRtcnNsKTsNCj4gKwljdHJsLT5kbXNsID0gbGU2NF90b19jcHUoaWQtPmRtc2wpOw0KPiAr
CWN0cmwtPnZzbCA9IGlkLT52c2w7DQo+ICsJY3RybC0+d3VzbCA9IGlkLT53dXNsOw0KPiAgIA0K
PiAgIGZyZWVfZGF0YToNCj4gICAJa2ZyZWUoaWQpOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9u
dm1lL2hvc3QvaW9jdGwuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2lvY3RsLmMNCj4gaW5kZXggOTI3
M2RiMTQ3ODcyLi4yMTk3YTJiN2FiNTYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0
L2lvY3RsLmMNCj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvaW9jdGwuYw0KPiBAQCAtNTMsNiAr
NTMsNTcgQEAgc3RhdGljIHZvaWQgX191c2VyICpudm1lX3RvX3VzZXJfcHRyKHVpbnRwdHJfdCBw
dHJ2YWwpDQo+ICAgCXJldHVybiAodm9pZCBfX3VzZXIgKilwdHJ2YWw7DQo+ICAgfQ0KPiAgIA0K
PiArc3RhdGljIGlubGluZSB1MzIgbnZtZV9zZWN0b3JzX3RvX21wcyhzdHJ1Y3QgbnZtZV9jdHJs
ICpjdHJsLCB1MzIgdW5pdCkNCj4gK3sNCj4gKwlyZXR1cm4gaWxvZzIodW5pdCkgKyA5IC0gMTIg
LSBOVk1FX0NBUF9NUFNNSU4oY3RybC0+Y2FwKTsNCj4gK30NCj4gKw0KPiArc3RhdGljIGludCBu
dm1lX2N0cmxfZXhwb3J0X2F0dHJzKHN0cnVjdCBudm1lX2N0cmwgKmN0cmwsDQo+ICsJCQkJICBz
dHJ1Y3QgbnZtZV9nZXRfYXR0ciBfX3VzZXIgKmFyZykNCj4gK3sNCj4gKwlzdHJ1Y3QgbnZtZV9n
ZXRfYXR0ciBudm1lX2dldF9hdHRyID0gezB9Ow0KPiArCV9fdTMyIHVzaXplLCByZXRzaXplOw0K
PiArCWludCByZXQ7DQo+ICsNCj4gKwlCVUlMRF9CVUdfT04oc2l6ZW9mKHN0cnVjdCBudm1lX2dl
dF9hdHRyKSA8IE5WTUVfSU9DVExfR0VUX0FUVFJfVjBTWik7DQo+ICsJQlVJTERfQlVHX09OKHNp
emVvZihzdHJ1Y3QgbnZtZV9nZXRfYXR0cikgIT0gTlZNRV9JT0NUTF9HRVRfQVRUUl9DVVJTWik7
DQo+ICsNCg0KSXMgdGhlcmUgYSBjb21tb24gaGVscGVyIGZ1bmN0aW9uIHdoZXJlIGFsIHRoZSBz
aXplcyB2YWxpZGF0ZWQgPw0KaWYgc28gcGxlYXNlIG1vdmUgaXQgdGhlcmUgLi4uLg0KDQo+ICsJ
aWYgKGNvcHlfZnJvbV91c2VyKCZudm1lX2dldF9hdHRyLCBhcmcsIDIgKiBzaXplb2YoX191MzIp
KSkNCj4gKwkJcmV0dXJuIC1FRkFVTFQ7DQo+ICsNCj4gKwlpZiAobnZtZV9nZXRfYXR0ci5mbGFn
cyAhPSAwKQ0KPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gKw0KPiArCWlmIChudm1lX2dldF9hdHRy
LmFyZ3N6IDwgTlZNRV9JT0NUTF9HRVRfQVRUUl9WMFNaKQ0KPiArCQlyZXR1cm4gLUVJTlZBTDsN
Cj4gKwl1c2l6ZSA9IG52bWVfZ2V0X2F0dHIuYXJnc3o7DQo+ICsNCj4gKwkvLyBFbmZvcmNlIGJh
Y2t3YXJkcyBjb21wYXRpYmlsaXR5DQoNCi8qKi8gc3R5bGUgY29tbWVudHMgb25seSAuLi4NCg0K
PiArCXJldCA9IGNvcHlfc3RydWN0X2Zyb21fdXNlcigmbnZtZV9nZXRfYXR0ciwgTlZNRV9JT0NU
TF9HRVRfQVRUUl9DVVJTWiwgYXJnLCB1c2l6ZSk7DQoNCm92ZXJseSBsb25nIGxpbmUgPw0KDQo+
ICsJaWYgKHJldCkNCj4gKwkJcmV0dXJuIHJldDsNCj4gKw0KPiArCW52bWVfZ2V0X2F0dHIuYXJn
c3ogPSBOVk1FX0lPQ1RMX0dFVF9BVFRSX0NVUlNaOw0KPiArCW52bWVfZ2V0X2F0dHIubXBzbWlu
ID0gTlZNRV9DQVBfTVBTTUlOKGN0cmwtPmNhcCk7DQo+ICsJbnZtZV9nZXRfYXR0ci52c2wgPSBj
dHJsLT52c2w7DQo+ICsJbnZtZV9nZXRfYXR0ci53dXNsID0gY3RybC0+d3VzbDsNCj4gKwludm1l
X2dldF9hdHRyLmRtcmwgPSBjdHJsLT5tYXhfZGlzY2FyZF9zZWdtZW50czsNCj4gKwludm1lX2dl
dF9hdHRyLmRtc2wgPSBjdHJsLT5kbXNsOw0KPiArCW52bWVfZ2V0X2F0dHIuZG1yc2wgPSBjdHJs
LT5kbXJzbDsNCj4gKwludm1lX2dldF9hdHRyLm9uY3MgPSBjdHJsLT5vbmNzOw0KPiArCWlmIChj
dHJsLT5tYXhfemVyb2VzX3NlY3RvcnMgPiAwKQ0KPiArCQludm1lX2dldF9hdHRyLnd6c2wgPSBu
dm1lX3NlY3RvcnNfdG9fbXBzKGN0cmwsIGN0cmwtPm1heF96ZXJvZXNfc2VjdG9ycyk7DQo+ICsJ
aWYgKGN0cmwtPm1heF9od19zZWN0b3JzID4gMCkNCj4gKwkJbnZtZV9nZXRfYXR0ci5tZHRzID0g
bnZtZV9zZWN0b3JzX3RvX21wcyhjdHJsLCBjdHJsLT5tYXhfaHdfc2VjdG9ycyk7DQo+ICsNCj4g
KwlyZXRzaXplID0gbWluKHVzaXplLCBOVk1FX0lPQ1RMX0dFVF9BVFRSX0NVUlNaKTsNCj4gKwlp
ZiAoY29weV90b191c2VyKChzdHJ1Y3QgbnZtZV9nZXRfYXR0ciBfX3VzZXIgKilhcmcsICZudm1l
X2dldF9hdHRyLA0KPiArCQkJIHJldHNpemUpKQ0KDQpub3JtYWwgZnVuY3Rpb24gc3R5bGUgaXMN
Cg0KcmV0ID0gZnVuY3Rpb25fY2FsbCgpOw0KaWYocmV0KQ0KCXJldHVybiByZXQ7DQoNCg0KPiAr
CQlyZXR1cm4gLUVGQVVMVDsNCj4gKw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArDQoNCi1jaw0K
DQoNCg==

