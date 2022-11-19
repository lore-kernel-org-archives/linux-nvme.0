Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19387C4332F
	for <linux-nvme@archiver.kernel.org>; Sat, 19 Nov 2022 00:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T3HoByuUEq/Udj2GoX7mBV24tUb1R2SYv29kpdiUpvQ=; b=aSaqUlnYiA/+8ql87ZA+2NRKE7
	ioZaz6NPjcizMdNeVoRt8WHAxucF9vkycQ7Fbn7jrZ1p1lb6mRoUBm1DAdNZUJ1IPwP+JsRVsjpPq
	nBsWlIu54dih0rlhWGgkGWs65Y0xVBg5QAUhVTG/ImrvsV4cDbkct9e9DoWZdvonLkuOV4yksoh2U
	xDUtSxqBvtyGESVstr6nt4llxp8l7CItt+N3Mxs/o/cqn+bm0wefQ1HtLELdMvB135Twr9C24DXqr
	8iMSu7ze4ueP8AK2Rr9qKNdAyNTElqo6VFZT2TVI02Ev0Akf9zDQBeuR1kq3pAFvZAM9mjEuimdaR
	g8eoA26A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1owBLq-009VlI-Bn; Sat, 19 Nov 2022 00:04:54 +0000
Received: from mail-bn1nam02on20602.outbound.protection.outlook.com ([2a01:111:f400:7eb2::602] helo=NAM02-BN1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1owBLn-009VkQ-Fy
	for linux-nvme@lists.infradead.org; Sat, 19 Nov 2022 00:04:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/RF208suJYcxeItZKUIoSpUSNk/B2Fat7NIS6AZHhOp9tCN5PNy5AjydoTuZEhrhfI/Y70YQTyKULuBjNVXAw92TY6Tc3U8gKNlb+nRH2a1shby8vh1X5xBgTW4ILKEZfYjUCvL20NRUWWzDf16CdbA//3+pWYcSLJsRS5f/TVG9qLh9UEE+7HsZz+AcrpRqf7C4s1Ezkpb9C8Xl2VGOQLS67E0lSvZJee1lPne8LrybnkCKXIhgjbPSATy+kCz6vG1K5ucoZiiwlVmaV3/x1kkYYDQzVCWqZpw7sgUM+zXriRk4qDW5MROkr8Ac8+Ol0iIreGu0mqLHNyxthJuVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3HoByuUEq/Udj2GoX7mBV24tUb1R2SYv29kpdiUpvQ=;
 b=WHpaZtWYWCxHe+atYXR2l7sPc+CGGm3yoEuXRzfcuhYMWaw1kA55wq9mRNdgOPRqWJ2wQhmld/AoxQQnLR8T5ZQ9blguXbNT3HbYNM2eNIhRTJIGic2XzQK8dkdRVxGAoS+j94J9ScZEflLZXdEZ9QmO/c4dXJR/WeJxoJTbFo1I6pMttEmU8pEBDHiPMIHhpHfStWZHAX1e8UqsTsEAUibIitewZdx8wAkl/Gfh+l2iUTxkKPuUJV9r+vCvYUzxCH+ZjzwXQyqX+KaK5iZpcY/ymEhUOQ4Red4JalkmtFvbQV39unmNzx21AjXp9puObkuGKJKhp6y8PczH2pYiyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3HoByuUEq/Udj2GoX7mBV24tUb1R2SYv29kpdiUpvQ=;
 b=fzDbt3qCCoVquXMJHc/JPtcHR3HZjblvc+YXRueX594JNNZ5qcjhIPwED/cBLdqzwZBuf271ZRuIKmi+LoGT6Mlumbe01jTPq8jgTbNgp72VHNXxp3l/FiU5uQKu3HY6uY+v8NoFj+N63CxAqkcXs9w5E6rsQ2DKi1seCoyF43h1Faux0yvFgw6Fxulifzpdsad2ib0pbO77w4o+ueUSvTFidE7zYDscOuDVxjOsHxV6iJ3zJLJG1TpzAcxSr4bq69HzM0B2wYOArev9KxkyNxzw/WgBCPOCO5cfAuVqKAyWMwtZP0QLSURad2a0W/mHT8Xz8hrMIjkUv4a9Y9QxlQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by IA1PR12MB7662.namprd12.prod.outlook.com (2603:10b6:208:425::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Sat, 19 Nov
 2022 00:04:44 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5834.009; Sat, 19 Nov 2022
 00:04:43 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>, Joel Granados <j.granados@samsung.com>
CC: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [PATCH v3 1/1] nvme : Add ioctl to query nvme attributes
Thread-Topic: [PATCH v3 1/1] nvme : Add ioctl to query nvme attributes
Thread-Index: AQHY+o9PblnQORIe5Uu8xeLinr6Z9q5FRuGAgAAZDYA=
Date: Sat, 19 Nov 2022 00:04:43 +0000
Message-ID: <150ffa65-3798-3f8c-8594-e8b29f7511be@nvidia.com>
References: <20221117141337.3719372-1-j.granados@samsung.com>
 <CGME20221117141718eucas1p11d0b9f10ff4c0ca6ba865251af775fc8@eucas1p1.samsung.com>
 <20221117141337.3719372-2-j.granados@samsung.com>
 <Y3gIl1d8tVsx/+NG@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <Y3gIl1d8tVsx/+NG@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|IA1PR12MB7662:EE_
x-ms-office365-filtering-correlation-id: 2e566f44-7dd3-44e9-14d0-08dac9c1a979
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  bQkokNUM9SlNOxYAVk+bkKlHZJCRcpZkIlaBW2pQ44ryNITPp5bacyy208GL85009Mxf88SfoL9RJY9moRdBYwte3gIsS50K+VjbkXrwj3CstoaStli0XgFSioR8iJ7G1IjVdfIl8j4/9mNEsiOYul7UnjMglhexslYdfouX0+AjRTyP2G6odMlDqlMc5eJcPZQQcqDzQjNl0i+Rsc+haqObD96PGvawUdw2ity/5cNggbAOIONoJTwzN+aHuJ8sOiiX+oceFiIF7FAYlDXfx+FPOvQeQDSDY76hKvXh+PBWCdyCNof+uG2JJv4ZecdYvpaIyoVeybOYmLO+okRac2WZXUBnJ+u0YTHidjLtoubA2ECavbIskMLi3m9I5bcGIJlo0BviEWzYAj+TMOVluMxM8cp1Unos8QNYlBMxSptGpNvqw00croGWwj3ToXB0Pp9whZbMLvYcaPICobYgyjxQUXJq8BM+NtDnmcA0hDVU0U0BJ+vdU2AJqUynFVJwH7H0FyPCSzDtw8Y+xhJsiA/dO1w11tBX7tgmlxIXH+10u5+gDaLFRpmdt3WgCHJ9t0Wfp/1ZLhOL4EL9PuvNVlAP0AnSLrKI0iQCwowu0bY6XqxWizOddQ+X2N3elseD7aof2j706lOm0QOFZH2pjXEwQ8ziBia000F4kuyAEha6rwf0yAEH9oXnzzI20DJB8FO6+OY6K58R6WYEVFIa4fu+RdhuBA2opl9xataJj191E2VawL47F7Re2pWfvHY7UTdKD1gGL+C6zmeWKxCz8g==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(451199015)(2906002)(31686004)(66556008)(2616005)(8676002)(66946007)(64756008)(66476007)(41300700001)(36756003)(76116006)(31696002)(86362001)(6506007)(38070700005)(38100700002)(91956017)(66446008)(83380400001)(110136005)(71200400001)(316002)(186003)(4744005)(53546011)(5660300002)(6512007)(122000001)(8936002)(4326008)(478600001)(54906003)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?WDR3dkpRNllxN2ROYmlhd2hDWXEzVTFsei9vOEM0WXprRE5mVXl5WWJZSFJZ?=
 =?utf-8?B?ekplZEl6aWtqODZNNWc1dGVuMFBEK29adk5PVk9HNGlFbjNGUkJPcE5TKzBp?=
 =?utf-8?B?UXJDSGFsczR6eG1rV2ZDNGhGdG1Kd1hVZnZjRiswaGVPSEJpSlE2bzVRSmxY?=
 =?utf-8?B?eHhnTTB5aWFhelpRQ0RhRkY4RFoxdUFQWVN4dTFzdkZNU0lXcm5PQjQwd0c5?=
 =?utf-8?B?QzZMa2VLWTkvbnJOVk93MFBraUNseDI5NXFtN2h4QngzbjhuWWtDaWl2TTc5?=
 =?utf-8?B?aXo4QmQ5TFJZWkZjZFg3TEZabWhOY21oVWZ0V24rY0ZOSzVjOHNsUHc5QVk3?=
 =?utf-8?B?b2h4UXNBRFc0cG12ZWNNeGpkZy9oN3Frcmd4dW05WnQxNDZ1U3JQRkJsejB4?=
 =?utf-8?B?K1kvejE0WFJ1Mi9KUkdpSjd5SGRKUEJ6Y0hEYll2M0d5SVpYUXk1M0I2c1Bx?=
 =?utf-8?B?NTBCWXZFdVZkN2ZoempVc2VNVnJrRzZTWU1pRWhtbEpYTU1NMFg3L1ZWM0pt?=
 =?utf-8?B?M0xBcWpFR25ySlViaDJ2TlNFVTdtQXJIS21rZjZhVFIrYkVGQUdEZ3dKTGRw?=
 =?utf-8?B?aWZhKzlNRm1qaFJtNUFPZi9QdmpKWGFXbFdPUGN5T3dSR1pETUVDa04rK1Y2?=
 =?utf-8?B?UUhtbWNaMTd4VVgwMUtVaWptTzBWZE5xcnRyeGh1Z2dCbzgwSjQwOVA0NHp6?=
 =?utf-8?B?bEc2ZklCbURwbDZaRE1UUlcxWVllQUFEZ2FGcDZOVWdNaDdhREVWM1RpTFhO?=
 =?utf-8?B?cjU4cm9HSUEyZElnS2VrVGR0STVrN1hEUXV1d3RnSCtWempWMHZWZWg3Lyt2?=
 =?utf-8?B?UkNFemM0WEx1QXlGYVVoVzFSTWtsNGt5cmZqV2pZN2NWWExjbXdFSHdMY0VH?=
 =?utf-8?B?akwwRk9YQ0N6Wmg1QThrSHBMbi85YVh6S2Y2QUVEdUtSWFJraXB3UmN3ZVd6?=
 =?utf-8?B?c1dpV203cHgzS0ZvVUhSTlU5Mm8rbjh5QXM0a3BhdllTUkZCNmtEa1d6OWxm?=
 =?utf-8?B?RUU3YWFQck9hV3cxMXhNdk1talhNeU1qSTdsTFZhNGl0WDdrajNsbXg0WmRN?=
 =?utf-8?B?ejAwODNaaDU0UTdwcDB2WlZLdVZuMVAwWVFjekwvMnA3VzErU3YvanZxR1J4?=
 =?utf-8?B?Z2c5UXMxMkZXOGFmaDBmMDl2VUZ0b1BHVHR5Nm50SDB1ZmhPd3R1M3h5dElO?=
 =?utf-8?B?SGhYaTRqdzJNQVNsUkVrcjhSczYvMnVTRWpjLzUxckFIR0FGQ2xXV0tjWjJX?=
 =?utf-8?B?R3hZUUgyRWM3SUh6bms5TW9hRGxQblpLZk5NMW43VXErR0V2WXMwc3ZQL1VM?=
 =?utf-8?B?cWZiZ0h3UXh6V1VsYVRvWmtCU05UUTZqa0x4TVUvRDQ5eDhoQWJpUmI4NGY2?=
 =?utf-8?B?djk3c1AybGMyRklIV3MrSzMrRUlDa2x6ejIxYjlDZFJVcXNlVWxTSHYwN1E3?=
 =?utf-8?B?am1EM2dlc1NGZTRudGhpakFKVVU3b3VqeEpJbHpCK3RxTWRHdFlNQWNsaHY2?=
 =?utf-8?B?RWlBb3EwUGhRVURpaFNLT21qQ3g2UXJQRTBKaUMvNTRuTWluSWJiZkpEM09k?=
 =?utf-8?B?YzRGV3VraWdOMEMzcjVmWU9OZEovNDZnaUs0WDVtcEVESnAzMzdDUy91KzhD?=
 =?utf-8?B?SWFqbGF4SzFwR0lZcHJCZ0JuRFgxMnROZGFQajNtOHowaDYvVjRrbThDeGg0?=
 =?utf-8?B?WHQxNGNneEp4TXZsYnBKaTZTTmZEY09sMFNOZTQ5Y3RFR0Fkc1kvUWxLeU1k?=
 =?utf-8?B?L2hvd2ZtdEhwa0pkZWZuRyttN3BGQWdEVys1MjErblJOeXZ6bjJublJybC94?=
 =?utf-8?B?bitCdzU3dTU5dklFQTBUZnVoVmpBbXFPQy9GNmE4YUlBdXZFVjJ6OGlXLy9J?=
 =?utf-8?B?cGwzazVaZkxvZGNUYmV5UlliWFdhZlVQRDhzaW1DTW0relNNNlpsZUN6RHli?=
 =?utf-8?B?bTQwZWxxcFlHN3FSNUJCRU5mTjdTVlF4OUE4c0ZOZW1tN3dFcEdFdS9DYm9Z?=
 =?utf-8?B?WGJsVG1sR1dXWXdneGE2b3Y5NEhha201ZXRBSW1iSHpkRm5BczREN1Z2N2lD?=
 =?utf-8?B?UUN3ZmpkUXRmN0drbjRUc3R2dVluclpicDYxQU9MMytwb3I4R2JjcHRvTWRM?=
 =?utf-8?B?QzVzOExucFM0QnFHa2xIb2J2c29tT3lGZEtVa2hnUXlkOEJGZnEwYlJVd1V0?=
 =?utf-8?B?V0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <144984A1137EC344AF6369DBF69AFF88@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e566f44-7dd3-44e9-14d0-08dac9c1a979
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2022 00:04:43.4877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J26QDxXglOZAhbm6eS4/iwZimhe3O5Kg8TBJVpmKCc71IMwrQg1XMJzO5KkSxbs6vMjnfii0eYjYv5GIQlF5MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7662
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221118_160451_780883_ABE621EA 
X-CRM114-Status: GOOD (  13.57  )
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

T24gMTEvMTgvMjIgMTQ6MzUsIEtlaXRoIEJ1c2NoIHdyb3RlOg0KPiBPbiBUaHUsIE5vdiAxNywg
MjAyMiBhdCAwMzoxMzozN1BNICswMTAwLCBKb2VsIEdyYW5hZG9zIHdyb3RlOg0KPj4gKyNkZWZp
bmUgTlZNRV9JT0NUTF9HRVRfQVRUUglfSU9XUignTicsIDB4NTAsIHN0cnVjdCBudm1lX2dldF9h
dHRyKQ0KPiANCj4gSXNuJ3QgdGhlIGlvY3RsJ3MgbnVtYmVyIGRlcml2ZWQgZnJvbSB0aGUgc2l6
ZW9mIHRoZSBwYXJhbWV0ZXI/IElPVywgaWYNCj4geW91IGFkZCBuZXcgZmllbGRzIHRvIHRoZSBz
dHJ1Y3QgaW4gdGhlIGZ1dHVyZSwgdGhlIGlvY3RsIG51bWJlciB3aWxsDQo+IGNoYW5nZSwgYnJl
YWtpbmcgb2xkZXIgYXBwbGljYXRpb25zIHRoYXQgd2VyZSB1c2luZyBpdC4gSSBkb24ndCB0aGlu
ayB3ZQ0KPiB3YW50IHRvIGtlZXAgYWRkaW5nIG5ldyBpb2N0bCdzIHRvIHN1cHBvcnQgbGVnYWN5
IHVzZXJzLCBzbyBwcm9iYWJseQ0KPiBwYWRkaW5nIHRoYXQgc3RydWN0IHdpdGggcGxlbnR5IG9m
IHJlc2VydmVkIHNwYWNlIGlzIHRoZSB3YXkgdG8gZ28uDQoNClRoaXMgaXMgZXhhY3RseSBJJ3Zl
IGFza2VkIGV4cGxpY2l0bHkgdG8gbWFrZSB0aGUgc2l6ZSBvZiB0aGUgc3RydWN0dXJlDQpjbG9z
ZSB0byBudm1lIGNvbW1hbmQgc2l6ZSAob3IgZXZlbiBiZXR0ZXIgdG8gbnZtZSBpZGVudGlmeSBj
b250cm9sbGVyDQpkYXRhIHN0cnVjdHVyZSBzaXplKSBzbyBpdCB3aWxsIGJlIGZ1dHVyZSBwcm9v
ZiBhbmQgd2UgY2FuIGFkZCBuZXcNCnBhcmFtZXRlcnMuDQoNCkluc3RlYWQgdGhlIHJzdmQgZmll
bGQgc2VlbXMgdG8gYmUgcmVtb3ZlZCBpbiB0aGlzIHBhdGNoLg0KDQotY2sNCg0K

