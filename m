Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAAF9C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Dec 2021 23:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HrrfxYeIRqDnVEQ/vOPDR5elC9NdV5hNkYnJk7aefTc=; b=IwKS8WFqz/pKqfj3ucxefCkilb
	qO2HZ3QWgeCgSXeQz2e0eDV0rbiY/lYjxYObEW4YfJL6Wk5m2iZdyFt9/Uw/E5OyPGDGf+QAadaAq
	TPLo3XzyHpRF3mrMI8RGib3idfAfn5+kphPpJlXmY36R4Cc8hv27QucFJLQVuZX3gOPUzBXqatEuM
	6fuPZJui3pdCAfu7TBgoHoiTk6laZ/Xo/BWRA4+cbKCPBS/w0rkDhwER07lKyDckfelWjNJyvU+NF
	pyr0lTbVexZiU/hj8kxfuTRjC0/dlPMsceYr7y/EAxQ33zHcDUDGE5vk1Yxwq/tzOmgur6JAF5LfT
	NrZsYYVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mwuJR-00Bu8i-7A; Mon, 13 Dec 2021 23:00:53 +0000
Received: from mail-mw2nam12on2046.outbound.protection.outlook.com
 ([40.107.244.46] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwuEe-00Bsy3-0y
 for linux-nvme@lists.infradead.org; Mon, 13 Dec 2021 22:55:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L58/vFkhcngGjD43WNtbMxY2PjrKRIUHa/lgPOa/9rBnKwk0GSSFcZQlqoZfTr1+j006fz/C5MXysF/vbmINe2QungHl7oXw/hi1TxbHIt+fECR+lXnx+6G7/G45soOAw3CJq0OgCjVCSt66Xz5ke6bpWrlwfB/1wcxqE9eFYTiA/v919ZaxK+fg7Qblfcx+t7WePIrKGd+bMocMn0LbudaILMrNYWhoPmUl/51UX8K0BnQ1YwtPYnMiWBDBjCPwDOIO3F0V13mOO6tVO1fHs80pmJ15aYHJM43MMVSCZLmORl3t4cor8jt63bnds8Svs7qXAdzeVlZkeEOHGYZZUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HrrfxYeIRqDnVEQ/vOPDR5elC9NdV5hNkYnJk7aefTc=;
 b=ey/zJxmzWt6f5fogyLqonS+CQa40lQypqzWeexj1RgP86a8FIy8nSG8jhRgT9yVCN+1JH8DDIgwTgTXtyRcczvXZEz/t7PgvqA6BEBMl/WUy+Dce29vwwFkxH2Qwd81cqHnBuydDw/tLulCceyWKHDCeyHsphxJNzkH1O/ACqH9xEoEOL4yDCPY4rt0uaNniiTR8XUS6kpcb9HGq5+K18+SvT3or2lp6BjXniJ2tewj0hiW8L+KqnpwfwqslMAc5MzDGUzv3m7kEHRyAT5NLT89tz2YWLyF8tsumRO0g50YfcDwfY2xjc2GaAP5RdXfI8ZNYCPxxCJy7btdOypUBaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HrrfxYeIRqDnVEQ/vOPDR5elC9NdV5hNkYnJk7aefTc=;
 b=PK7BUQ6fnQhauYs75zInF6BErjkC8SvmpxYcrsSY6nFqZNjRqwGDKn9L5GIozujOmpv7yVjWm/+qUQdazugVCdlz056Cmf3GJHQQramdzdZVDfQo7G2jdJ40w3JiXXqT+zEQ1aU+5s0orI5PoCLpmHNqcJCJbbxuosiuqtgEljxWfSKV56t8kQ/owZZ8ac3RDNnjDZNuRJJSij1OmQ5u6KAPKqFi+eQ0pVp1ICGAtMoC9fFOvP/qpCq+QQ4/sXUNgIF7j5cjZ1j57bFyA2rsCWL0U3ZEE5JaT+oBAOBHyZmkcnQdO81AQ7UYoAIWjPWSeDZB/YIQ7oiRt1LfK7l0bg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1645.namprd12.prod.outlook.com (2603:10b6:301:b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 22:55:52 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e%7]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 22:55:52 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>, Omar
 Sandoval <osandov@fb.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 06/10] nvme/039: create authenticated connections
Thread-Topic: [PATCH 06/10] nvme/039: create authenticated connections
Thread-Index: AQHX4D/0FW4m5OORG0GJLZetJzuU7KwxKKaA
Date: Mon, 13 Dec 2021 22:55:51 +0000
Message-ID: <33457fa9-e289-7e0d-c12b-1971b5491703@nvidia.com>
References: <20211123074940.113390-1-hare@suse.de>
 <20211123074940.113390-7-hare@suse.de>
In-Reply-To: <20211123074940.113390-7-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1d32978-1185-4d2c-6ce2-08d9be8bb67a
x-ms-traffictypediagnostic: MWHPR12MB1645:EE_
x-microsoft-antispam-prvs: <MWHPR12MB16458BC68013F9D71526474EA3749@MWHPR12MB1645.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xED9aJFLosDVS3zAsNzQLN1gn+hhqEYL8JjDQsCVnH0lC0HJCUmV+mI/HZo7ZBopgxz8JeCJqYNWrb9hUn73itZfsT8795AcocLNMo66HZyzPRXlQFIqRwNJlS6G8LH629HlaA5rHkMjjy8fc6gQqeF0oBgMD9GYGmngfSU+Z0szRiwSnzH1M0PNobgj50drUEviZj15M3tdl51FotU2zgxJb/xAHIhM9kN2NqAEjd9sxnyjcbjRfDoExhqzYKlIiH9pWtx8hoEi0eN5VcSkbk/UVwAaY+In0TkheVPH+a3WARPVdM0Bfs4d7z2cmD50foYsK/sC3YPGg5yOf4GUMxL2ikmOZ+Mb13438dNWLCZdF2Hoz/T/lBSAUC5wjUMfM31bo1HQ1pVxjEzkCyet8AC8p1WZAMDb1u5BVL4g7cI1IQaDPbWbzmYN9NNxbNPGmASn1e6vj44csDaQTjr8omgWvQKEZxs7lLq77wEhwOHB7FKNddjD45wmw21UtBsFfG5ZxMUH3DN5SupZo1I6XByFUfqzIt62cJkOV6JNKdEGhFDtdNEF9svsT6H3QjTPyv0caHZ3SiMSUFmEIxlpX9vDqYx1oHrGkBsgjJjGFrAFpC4amhwvhfgx3bLD8u1PDm3G2unQ4wh/i21RZ+FrP/WFyADnSlBMfTcxqkh5aezufkJwkj/j5o/EH74GH73QsciAtDXQ8IFxe8bma4zQLyAOSnvHHOAX4/mM9nUJIV34mZh89iT9UFFFAoct4ZYAjG/SYgv3/8sa+fw5A2jOFw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(31696002)(36756003)(6486002)(86362001)(54906003)(8936002)(316002)(4326008)(110136005)(186003)(83380400001)(8676002)(66946007)(508600001)(66476007)(2906002)(76116006)(91956017)(6506007)(71200400001)(64756008)(2616005)(66556008)(66446008)(38070700005)(6512007)(38100700002)(122000001)(53546011)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nkp1TW5vSlFENUZpdVhrZHNIOWk0aGtEWDF0K3pnLzRKcE5HNmNjQmNTV1k3?=
 =?utf-8?B?ZHdQNTV4Y203d2VaN0toNHU3NG95Y1ZXa3QrUjdmWmpBZ0ZmbFlnZFBRZFRG?=
 =?utf-8?B?c3ZaajNpZ1RtNkl6RU9lYVBkU2FuSjloUnRHWW4zblBINVFqRG1SODMwSWhv?=
 =?utf-8?B?VURHMldDekhjZmlRLzIwVnlLcEJHNkJ3MEN5U0NabjRRNzFsOXJYTlpuYmdU?=
 =?utf-8?B?K0RQRjNCYVZxNzlKMTZZK2cxNmVjRG93RkVQWlUwNTNGYkI4VDZwU3BaREk3?=
 =?utf-8?B?RWM0bXNHMElLQnlUQzhEQkY5L1RUN1pxVUl0bG9XRWxqUjgvUExvbmZQanpv?=
 =?utf-8?B?MnIvS3BjK0R2OWt0eXozQ21tZ0NkTGhFb2tUTEpBQ3RCRmJxTytPbFlmSW81?=
 =?utf-8?B?dHNvUVNadURybUUrM25GZk53M2N2YWdvT0tyd3cyYU9PdzloZGhyYjQ3aU1H?=
 =?utf-8?B?WUF3SmJudm1hUm90WDVEdEJwNGFScDB3QzNLTnFaNW5JZVlvamgxb3Q4cWJ0?=
 =?utf-8?B?aDR5WUtUMEpHTFNkc0RnMWlJMXQ3Rm9oczR1eDJEQXpzQVY1bmVVS28rZktk?=
 =?utf-8?B?L1I5M1E1SWRqV2NyL1dIYzhlR29ac0cyWE83M0VxRm5jUGhYK2Q2MGVGRXJJ?=
 =?utf-8?B?VlltNDFMVC9sRDNiR293emdDOEs3U251cndFaTUrWHZobVBPTGU0bWZha3BC?=
 =?utf-8?B?R1BGeVhkcnRRNWxIQ0NJQm1vYlZITXBneTNVRVRuNFMrNit6eGM0UE14SURo?=
 =?utf-8?B?SmNLNTdUeElSZlpDMWVEY1NmZWNCSk5mTzhvNUtJckZDbU0rYUc0V2Q2MzN6?=
 =?utf-8?B?UWhmVHdkSFBNSUh5L1A3S0xjZ3ZHMDhyenhGRFRWTzJHam1QeVI5Z1VZbjFv?=
 =?utf-8?B?dGplU0tIYlEySUd0MXF4ZUVtYk02MkFLYlluZG5QcVYyZUJDY3lrQTgxLzYr?=
 =?utf-8?B?ZHVSQm83bmZGa1RqckVGaEptNkFqcmNBSmNWdTRNY1UwVVV4MGF2U3d4WWls?=
 =?utf-8?B?Tkc3TUdidDBoWmhzdDlpSVltSFZZM241dU8wTkdJRzN6emEyd25mMFVzSk5H?=
 =?utf-8?B?QVVZbksxRkR3NTVRbjVFSFkwY1kzQ1Zpdk9iNGJzT082Z2JUT1Z3b3pwNlhE?=
 =?utf-8?B?Wmpad0hCSnV3Zk1Dd2UvdFZUKzdJUE40STBIL3UyYmtMYkZmRSsvRytDTTdt?=
 =?utf-8?B?MTViejhTb3VsNjBXNVVXdTlvK2lJdGNEeUY2bzlTaFBVZWhOUzNjWUpIQmlt?=
 =?utf-8?B?emZwRVNlZ3ZmdVhPTXN6bk9PZ2I5UnVNWDNJa0g5YmxTbjhKbEZHdzZjay9I?=
 =?utf-8?B?WldDazQ1Yk1UZ3JLWXNSNnJzSy81ZDRxNUxWVVQxd2ZqNC9ORFl4b2NuM2JM?=
 =?utf-8?B?VFN3RUhxM1pndGV3djhzUTJUaWN2TXJ5UHNyNVRUcHFGOUFkR3NEYVBGL0xw?=
 =?utf-8?B?VzBoWHlTV1FXa1VjT3g5OGoxS1RFdlU4SzBkQitvcVc0d2dad3BNZVY1OTdy?=
 =?utf-8?B?aUZFaWdjb0dvbnliemRXbG4wa0V4Mmc1RkdkMitrZnJMRzVSa01mUng0NXZv?=
 =?utf-8?B?a2tIWEpuMGdENHkwd1dXaXladDNNRWw0cHp6WVRGeHlrL1BoR2txUnA4SWZN?=
 =?utf-8?B?TXduNThvMlVZY0tGdnMvRGNoOUUzSUNaVzE1SnBLWmtkVnZNSENvM3V1WTV4?=
 =?utf-8?B?VXhMZ1h3bDV2WGxjUnBRWG45L1R1R2FuWW4xMFpvZU5pbzFFL3FvVGhnaEdo?=
 =?utf-8?B?QktaSVlRRHU0cWZ3WjFmUll2K05DTmZuMGFIMkFCNzRaK001MlRPUWVGb3BH?=
 =?utf-8?B?YzVZbnJMUm5hREp6TFVjaDN3VVl2UG1NRWVYVi9mNWRuOEt2c3JHM2U0Z2lR?=
 =?utf-8?B?N2k5YUNvYkpWNm5kLzZ0ME1FWkhNVGNtTW9aM0tRM2JySnR5Sk1TQmNIOURK?=
 =?utf-8?B?R1R1TDFyc2NSemo2ZTFPY2QvcmJVVUYzRXpIcGcwS0NtVjZpVXROT3lpcTd3?=
 =?utf-8?B?UXQ4TnhyYXdnbktNY1lXU3lYNTJlQnkrQnprWEE4ZC9ObFBNMmx5WmgxSlZB?=
 =?utf-8?B?S0NJWk9ucXR3czdqREdJRU5STzByYVRPdVNKaHBpTXhFUEdrTEpjVHJCNmdO?=
 =?utf-8?B?blJBbGNlaGZUajZJOW5xdjdXUDFzdmpYOUV1ZDU4U25MT0pGampNbkNiei8w?=
 =?utf-8?Q?Ji8pJR9bnCQY18U1zdUMobH0BxApD8UJW9nV9ai5QNc3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <55B0AD6C85923F4E804DDED5F3B49D08@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d32978-1185-4d2c-6ce2-08d9be8bb67a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 22:55:51.9994 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y6umiN9FcRLoOd00R+KZvGso4w/FzE4+goVEb0CEqXWedKZbWSiIU+bQSAOaZQfc9nrf5EvBpA32FyHJau1A3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1645
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211213_145556_131655_A174A822 
X-CRM114-Status: GOOD (  17.19  )
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

T24gMTEvMjIvMjEgMTE6NDkgUE0sIEhhbm5lcyBSZWluZWNrZSB3cm90ZToNCj4gU2lnbmVkLW9m
Zi1ieTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+DQo+IC0tLQ0KPiAgIHRlc3RzL252
bWUvMDM5ICAgICB8IDgzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysNCj4gICB0ZXN0cy9udm1lLzAzOS5vdXQgfCAgNyArKysrDQo+ICAgMiBmaWxlcyBjaGFu
Z2VkLCA5MCBpbnNlcnRpb25zKCspDQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL252bWUv
MDM5DQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL252bWUvMDM5Lm91dA0KPiANCj4gZGlm
ZiAtLWdpdCBhL3Rlc3RzL252bWUvMDM5IGIvdGVzdHMvbnZtZS8wMzkNCj4gbmV3IGZpbGUgbW9k
ZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMC4uNGZiZTdkZQ0KPiAtLS0gL2Rldi9udWxsDQo+ICsr
KyBiL3Rlc3RzL252bWUvMDM5DQo+IEBAIC0wLDAgKzEsODMgQEANCj4gKyMhL2Jpbi9iYXNoDQo+
ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMy4wKw0KPiArIyBDb3B5cmlnaHQgKEMp
IDIwMjEgSGFubmVzIFJlaW5lY2tlLCBTVVNFIExhYnMNCj4gKyMNCj4gKyMgQ3JlYXRlIGF1dGhl
bnRpY2F0ZWQgY29ubmVjdGlvbnMNCj4gKw0KPiArLiB0ZXN0cy9udm1lL3JjDQo+ICsNCj4gK0RF
U0NSSVBUSU9OPSJDcmVhdGUgYXV0aGVudGljYXRlZCBjb25uZWN0aW9ucyINCj4gK1FVSUNLPTEN
Cj4gKw0KPiArcmVxdWlyZXMoKSB7DQo+ICsJX252bWVfcmVxdWlyZXMNCj4gKwlfaGF2ZV9tb2R1
bGVzIGxvb3ANCj4gKwlfcmVxdWlyZV9udm1lX3RydHlwZV9pc19mYWJyaWNzDQo+ICsJX3JlcXVp
cmVfbnZtZV9jbGlfYXV0aA0KPiArfQ0KPiArDQo+ICsNCj4gK3Rlc3QoKSB7DQo+ICsJbG9jYWwg
cG9ydA0KPiArCWxvY2FsIHN1YnN5cz0iYmxrdGVzdHMtc3Vic3lzdGVtLTEiDQo+ICsJbG9jYWwg
aG9zdGlkPSIkKHV1aWRnZW4pIg0KPiArCWxvY2FsIGhvc3RucW49Im5xbi4yMDE0LTA4Lm9yZy5u
dm1leHByZXNzOnV1aWQ6JHtob3N0aWR9Ig0KPiArCWxvY2FsIHNjcmF0Y2g9Ii90bXAvYmxrdGVz
dC1uczEuaW1nIg0KPiArCWxvY2FsIGhvc3RrZXkNCj4gKwlsb2NhbCBjdHJsZGV2DQo+ICsNCj4g
KwllY2hvICJSdW5uaW5nICR7VEVTVF9OQU1FfSINCj4gKw0KPiArCWhvc3RrZXk9IiQobnZtZSBn
ZW4tZGhjaGFwLWtleSAtbiAke3N1YnN5c30gMj4gL2Rldi9udWxsKSINCj4gKwlpZiBbICQ/IC1u
ZSAwIF0gOyB0aGVuDQo+ICsJCWVjaG8gIm52bWUgZ2VuLWRoY2hhcC1rZXkgY29tbWFuZCBtaXNz
aW5nIg0KPiArCQlyZXR1cm4gMQ0KPiArCWZpDQo+ICsNCg0KV2UgYWRkIGZvbGxvd2luZyBpbiB0
aGUgcGF0Y2ggNCB0aGF0IGlzIGNhbGxlZCBpbiByZXF1aXJlcyBvZiB0aGlzDQp0ZXN0Y2FzZSwg
YnkgYW55IGNoYW5jZSBhYm92ZSBjaGVjayBmb3IgZ2VuLWRoY2FwLWtleSBpcyBkdXBsaWNhdGUg
PyA6LQ0KDQorX3JlcXVpcmVfbnZtZV9jbGlfYXV0aCgpIHsNCisJbG9jYWwgaG9zdGtleQ0KKw0K
Kwlob3N0a2V5PSIkKG52bWUgZ2VuLWRoY2hhcC1rZXkgLW4gbnZtZi10ZXN0LXN1YnN5cyAyPiAv
ZGV2L251bGwpIg0KKwlpZiBbICQ/IC1uZSAwIF0gOyB0aGVuDQorCQlTS0lQX1JFQVNPTj0ibnZt
ZSBnZW4tZGhjaGFwLWtleSBjb21tYW5kIG1pc3NpbmciDQorCQlyZXR1cm4gMQ0KKwlmaQ0KKwly
ZXR1cm4gMA0KK30NCisNCg0K

