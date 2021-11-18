Return-Path: <SRS0=aga3=QF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2386C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 01:50:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 954A061B54
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 01:50:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 954A061B54
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jzrAeDI+wMOJ0P7RuC6EiMAgMAkpQEXxTtwj9hHjchU=; b=TVlHu06hYGyvJbJSK1SJB5fwot
	79tYqhtkyTpReRyWLw4i29hdNCue3wMi8xpDx2UValATSyV26XpCB+YWxQI7RmpqHwpprf0oGOB5x
	HqP0ccFTStPj10wUfACTgOtRs6mg3lD2L1f0dX9HxcW4QGYWWqOtg51aw/v4PVks++rtdlF0CHnBF
	Mr76o3SToA+LBCLG7x8ZRn5uHTeLCetN5wBrc9SfIeQbinI+EH7EXGkAo48ALIEp6Zx39d9p3bVa0
	Iwrn1T5NGMjhQJHL1mAxOY2Cg7dRF1IIfbjkww8JVYbaz2MLOT8KJSeYSkmsnXTe8nxmJk6P12nZs
	EBhYENhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mnWYo-006hXl-2a; Thu, 18 Nov 2021 01:49:58 +0000
Received: from mail-bn7nam10on2060.outbound.protection.outlook.com
 ([40.107.92.60] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mnWYk-006hXF-W3
 for linux-nvme@lists.infradead.org; Thu, 18 Nov 2021 01:49:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWdTjpeOcseBx4FAbTgcHPti99dWexAHuHYJr5iGwMdUGHrEwaf8rLQzdw8vTlI6pI1FvJnRL1+wWotZud3sjIQUMs4a2zynmhKJwZS6nPDOx5+5sPN2r2H33IWkwzCyHd65/F1A4xdFM3OJ50/8QZXajJJrpl3QlZLbq/Kvd90PMxWHR4oGM7BupjNQZMWB0oc9eBppXlrT0ZeBJb9WQpFyBcZ6XztKkuYP1XHQJvlOWz/dWWfmdyzKRMOxDMtr1WDXskSOxDfORGIYCAZxMsH6AEuWHAZ1OQZ1N1JN1l3P4iDCEzpyAPXEnTgjEW9MRprX5EfSL2cAN4P0b374cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzrAeDI+wMOJ0P7RuC6EiMAgMAkpQEXxTtwj9hHjchU=;
 b=hZrgoX1t0IRZHdgdRqS0DMPDLwDWoCOly6+2rKOHDcQFoWTiXFy23IyLzryPRMzXqhbCH9Re4TH53C8TQQcZV2ao2K+F9tGaq6s7h2hohIi7/J8jpFiXZ8NAgd2t/+rlH81p6NIoG1XZncRqakukC/Ouhc4vfxPHt9TXhYLT2XebTFSjay7VeYu9MIH3ugLsBxVi8M0RNbWTUJfFSv1ePiXSZuVLGGA7sH22J2Kbl0CMmeQMokE68TWUfXEZrxiWN0iYgJAGE1Hx6S/ctnEeO2Hb+mXaGmvjE0uIXYnE2Ge8wjtH7Pae/FiJHvv3VX4ukxv2iprlN86Lz0DKKGYE7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzrAeDI+wMOJ0P7RuC6EiMAgMAkpQEXxTtwj9hHjchU=;
 b=nhrYBuRAhNVuG1uVwdJn/gn/KKa0wkdMqeGhGxf9motaxSNzZEU5qJPmqixJyDoJd4T4XtMPZ+TPP+QUTSy18Ga71cskorKLobY9Vk7aV5xhPYXN8/29bfgjf+FuORLFmKPU8GvYz9suXBrxl+5oKEgIGozhJ3GrVnmcpPqwkvwacSqC1jh0SnT7aVAfL/L71czT5QnM0Hq7GjpkyxBoK6j8wOAOPmQSw8o2teWnNuF2bqltVnEBzRqpRWcckHVWxENY+uya3lsZyCt+bkA55ZBWX9dfvQ4Pof72axxZgv7m6fR/bp4BYW9hvikNh6jqMjklufHeGsSWGQnswoi75A==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW3PR12MB4348.namprd12.prod.outlook.com (2603:10b6:303:5f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Thu, 18 Nov
 2021 01:49:52 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c961:59f1:3120:1798]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c961:59f1:3120:1798%4]) with mapi id 15.20.4690.027; Thu, 18 Nov 2021
 01:49:52 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "wenxiong@linux.ibm.com" <wenxiong@linux.ibm.com>,
 "anaidu.gollu@samsung.com" <anaidu.gollu@samsung.com>
CC: "keith.busch@wdc.com" <keith.busch@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hare@suse.de" <hare@suse.de>, "wenxiong@us.ibm.com" <wenxiong@us.ibm.com>
Subject: Re: [PATCH 1/5] nvme-cli: Decode "Supported Events Bitmap" in PEL
 header
Thread-Topic: [PATCH 1/5] nvme-cli: Decode "Supported Events Bitmap" in PEL
 header
Thread-Index: AQHX29nGTjRhyJBXSkitKAPTR8iniawIhXQA
Date: Thu, 18 Nov 2021 01:49:52 +0000
Message-ID: <dd50ba34-5d0b-937d-8e4f-c4cf5a58424b@nvidia.com>
References: <1637165088-17007-1-git-send-email-wenxiong@linux.ibm.com>
In-Reply-To: <1637165088-17007-1-git-send-email-wenxiong@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e489ed48-70aa-4749-a6aa-08d9aa35b6c5
x-ms-traffictypediagnostic: MW3PR12MB4348:
x-microsoft-antispam-prvs: <MW3PR12MB4348CAF63948B4E73682A7C1A39B9@MW3PR12MB4348.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:150;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m2OJ1K3ol1nltGbWQurN3vTuBSJWGo1MCID6uoBcP5X0Hk8HsnX0trujmrS9a5D9h0zNxncaVansl2y5csxheI+vNprV20y0K4Bx6tAWbcwSfWw96DaU06VNV0HwvkeuzYrhu6OmVqdD36iuVk6ZBitzrWnn6jGBvR3EM6D1gnRLtAnj0nLjYXKpGiXm0iqvVqcjgcPjub4qDXCsSCdBRXPObizY2L1fqZsjXRo+IcWr6DBSaZufEFqKmuW2ikJgRePqdt43Rnma1sC69MKsYoT0oK9D93pQV+a6wqVx/6y4gFGvXReCKrleuawPQqitioR6RBTuYMlOc3J7dn1awNm3TX+CWyIJFtylecZCZpPf3vQ8RW8OEu7TXqdU8LNiZcOZsIdKlfhS3nisNCZKty4YKCQ+nbIVBq6GiD9XZzXZ0vj3T1rhHhnxfpJpoh8zLlMD/Rg8VYXvTH6WpE0fRT5CezD9yOZrK/jGkjWXuwbLpGuVFjKcvN7IJ5WRqEBHMeAQH7rYaP/zIESvDBnQU819/QOCnl+PCfUpsJugR6lKXQhqidbD9mYBDFSMklziC7kt7og6iR97+bRDIPR6adA1QTK6OXHEuAfHxkF7KNi0touigc0djCR1jnAkzbn/6Nm0TWnA9ZmSftdnANgf2eHxWXBwRKZbMiOJ6fgygIbMqXxh3NukLfARABkxcrwuktds02eAa3iLXD7D7SwHARdv+IvtoQfziptCkgEGadUlPSeRGsWow7oE6KECU/xNWgBS/WEIDjcXI+fvLaoHcw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(76116006)(31696002)(91956017)(66556008)(66946007)(26005)(2906002)(6486002)(8936002)(6506007)(122000001)(53546011)(4326008)(186003)(316002)(110136005)(64756008)(66476007)(66446008)(38070700005)(54906003)(86362001)(71200400001)(2616005)(8676002)(31686004)(6512007)(5660300002)(83380400001)(36756003)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QitXUHRhSERXR0FnSlBzMFlhb291MlBtV1gySzJjVmtYc20rSVNGVXdGbmNU?=
 =?utf-8?B?dlFua0V0c1pUVTMzazArSEY0SmhWaFRrZkl2UFA2UE51ZnB2eGdWVlhuc3Ez?=
 =?utf-8?B?TE1MdTNvdStFSys3bG11Y2phdkpUenZBclgvWnhTSlJ4eEJZczlnb2hxK2lm?=
 =?utf-8?B?S1hoT0dNeEdYQXo1QjdiYXpHditLM0I1aE9iOXl1Z0k2VTU5SHRlQXcrdHVT?=
 =?utf-8?B?RXl1bTUra1hVNFRvM3dyeEx3KzVLbUsxMnhPMmVHejBURzdPM0M0VDhoMFdX?=
 =?utf-8?B?ck14Z2ZpY0NIS3ZQeGtaVmVaVzRKU1I1RFRPczFoQ0VYL0JNN3Z1RWUzWnps?=
 =?utf-8?B?cUVYa2Z4U25JYmZOVkVOZTczSEQ1aUx6SjZCRzFhRkJtWGlZOWg5OFVFYUZj?=
 =?utf-8?B?aFV4Z3F0NEFRTG9uNGRRYlY4cFJIRks3TjQvU2x4VkNLNDEzTXZ1YWFzUjho?=
 =?utf-8?B?QU1kNFRBUG0zMmlVVlNrazhVaUVBRjY5elphQU1pZiszMFJROUFyUnhmREwy?=
 =?utf-8?B?MU91aFhqSjVEakFaVVRWeW11VVBvLzJ6LzJWUVJZQ1k3SUQ1cCtwYm5yYTRt?=
 =?utf-8?B?U3JoZXM0YmROMnZweWN4bmVmUk5xY0kvQ1BjdjczdUNyOHJ4MGwwMFhjaHdu?=
 =?utf-8?B?bDhsWXlqT0dSa1Bycjd6ZzNNYWZCcWFjMlBaSHZFMXVMRndVd3NVSUNJb0Fr?=
 =?utf-8?B?aWNqZlJjNnMzZ1ZtVitGZG54L3RPNHpscVVRc1ZsNjRsZFVncTVXTmZvTkR5?=
 =?utf-8?B?SDZDMVZaWWdESUdEZk1oaVlSQ3A1R01IQ0lOekIwYVJiMllJMXNaaEhCc2sw?=
 =?utf-8?B?S0gwdFl4RXFMSmdVV2lreDV6cFBTb0FGakp3anVTcWQxY1VGTFZ2K1Bha3A3?=
 =?utf-8?B?ck1xQWl6NmVUMXZ2NnlIWDIxSkVESHMzc2Fpc0FOSzhZNGFOY1Bpamlid0s2?=
 =?utf-8?B?OW1tTVhxVlp5Rnc1QkIrY3NoQXAwNUI5S1pJVkJmWk1FVlhqUEh1cWY3SmZK?=
 =?utf-8?B?UUJ5bkQyZUpDVjZoSERjZWJIWjB4SFZJLzAxeDZDNnFPVElIUGJNSFY5bUFs?=
 =?utf-8?B?NnduNUZkTVZQT284cHk4Tmt3em1ML2dzQnlaTEFDT28wNmx6YVlkbUgvd0tU?=
 =?utf-8?B?M0YvZG5CQlhub01IK1gwUXdYWk1nVHlsaXg0d0hkNkd3ZkcrbnkrTnE2WjRQ?=
 =?utf-8?B?cTgyWE9La0EvTmRvS0JDdUp0UzN1dWZWa0ltalFyOUp5Qk5iRkVYK1BsRDMx?=
 =?utf-8?B?NWQyZGNHTlhjOVR6b1pQK2ViaGRvRmhRQWx1UmJsY2NkdUgvNSthV2xJWTRK?=
 =?utf-8?B?N0ljeWVZNVdHQ1U2Nk1ocFQwWXI1TGQ2NXhiNVQ1ZWZOTlJlMVprZC9CUjhN?=
 =?utf-8?B?VHREb2UyYmlZcWw3Zkd6bXVjL05hekZDMWRoR0pFbDd0OG93SXkwTDZmZjdj?=
 =?utf-8?B?Q0wxazMvUjJTUWFmdktQZFhOaWR6d2MrYWcrNjVRbEFmRk5sT1pBa09Ia2gv?=
 =?utf-8?B?cTh2cTcrMUZMYmlZVmp4OU5jeGpZMi9wcmdrb0xxak9EdExqaC9IWFBDTWEr?=
 =?utf-8?B?RERuM1p1WjdwVXNGZnhEZFoxeWtJUHJTOVpFVkxKTWRiZnZ2enZrUFR3clN3?=
 =?utf-8?B?WkRhbHlmQlJXTzBXeFBxbUg1NVFOaGhKMmx0bkRCTDdMM0dCNFAwcEZERzF3?=
 =?utf-8?B?UE8yems4b0tIVVA1bVg4Vm5QRjNybnlidDJLQ2dwTHV0dG9ocHNFMnJSZUNx?=
 =?utf-8?B?UFpLMjVTbnB4WjBQemliSS9rKzRqbWljRFJLTlRmV01QVVJrWktvYUJPeS9a?=
 =?utf-8?B?K2NuQi93SWVtb2pNd2dzdlFEUlpJUGFHQ2RWekRGTHRaMUx1QmJaUnJINFkr?=
 =?utf-8?B?Yk1YS0VrOTlhTW82NmZwaU8xYzZ1bm5IZHZ2eTdMTGpmQ0k5VklBYWdhUXQ4?=
 =?utf-8?B?ZHVtMjZkdXBscmZvZW9BUUdGeEllR3I4QWUwUmlybUZxbTcyaHZDellueFky?=
 =?utf-8?B?UEsvV0YzQTBBbmRzTUdiV1M4QlJsdGI3dlhKMGJZVjkvOG1NQ01EYW5pdGpl?=
 =?utf-8?B?T1YvNlBDVmMycmN3a2NBZEVrMWRPd0ZxVGN0dWIrODU2ekVCWHZ3eXl3Ykgr?=
 =?utf-8?B?bHZ5bkcrU2lBbENZVWlzVHM0N0dodEIyWXl6dUdBTTd0TUo5N2xVZlhGOXlZ?=
 =?utf-8?B?eXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD287B0E34EE964A84E9A8792276ECF9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e489ed48-70aa-4749-a6aa-08d9aa35b6c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2021 01:49:52.4591 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZoRhzOj7iJvONQ4b0kPL0h125od8gJ+ADM2DD0iJj4iGuBQ4QZ8b9XDnZ/PcGPSv/k0S9KpxClg9Xj+962Mm3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4348
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211117_174955_193957_12C20ECD 
X-CRM114-Status: GOOD (  22.27  )
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

T24gMTEvMTcvMjEgMDg6MDQsIHdlbnhpb25nQGxpbnV4LmlibS5jb20gd3JvdGU6DQo+IEZyb206
IFdlbiBYaW9uZyA8d2VueGlvbmdAbGludXguaWJtLmNvbT4NCj4gDQo+ICJTdXBwb3J0ZWQgRXZl
bnRzIEJpdG1hcCIgaW4gUEVMIGhlYWRlciBzaG93cyB3aGF0IGV2ZW50cw0KPiBhcmUgc3VwcG9y
dGVkIGluIGN1cnJlbnQgbnZtZSBkZXZpY2VzLg0KPiANCj4gUGVyc2lzdGVudCBFdmVudCBMb2cg
Zm9yIGRldmljZTogbnZtZTBuMQ0KPiBBY3Rpb24gZm9yIFBlcnNpc3RlbnQgRXZlbnQgTG9nOiAw
DQo+IC4uDQo+IC4uDQo+IC4uDQo+IFN1cHBvcnRlZCBFdmVudHMgQml0bWFwOg0KPiAgICAgICAg
ICBTdXBwb3J0IFNNQVJUL0hlYWx0aCBMb2cgU25hcHNob3QgRXZlbnQoMHgxKQ0KPiAgICAgICAg
ICBTdXBwb3J0IEZpcm13YXJlIENvbW1pdCBFdmVudCgweDIpDQo+ICAgICAgICAgIFN1cHBvcnQg
VGltZXN0YW1wIENoYW5nZSBFdmVudCgweDMpDQo+ICAgICAgICAgIFN1cHBvcnQgUG93ZXItb24g
b3IgUmVzZXQgRXZlbnQoMHg0KQ0KPiAgICAgICAgICBTdXBwb3J0IE5WTSBTdWJzeXN0ZW0gSGFy
ZHdhcmUgRXJyb3IgRXZlbnQoMHg1KQ0KPiAgICAgICAgICBTdXBwb3J0IENoYW5nZSBOYW1lc3Bh
Y2UgRXZlbnQoMHg2KQ0KPiAgICAgICAgICBTdXBwb3J0IEZvcm1hdCBOVk0gU3RhcnQgRXZlbnQo
MHg3KQ0KPiAgICAgICAgICBTdXBwb3J0IEZvcm1hdCBOVk0gQ29tcGxldGlvbiBFdmVudCgweDgp
DQo+ICAgICAgICAgIFN1cHBvcnQgU2FuaXRpemUgU3RhcnQgRXZlbnQoMHg5KQ0KPiAgICAgICAg
ICBTdXBwb3J0IFNhbml0aXplIENvbXBsZXRpb24gRXZlbnQoMHhhKQ0KPiAgICAgICAgICBTdXBw
b3J0IFNldCBGZWF0dXJlIEV2ZW50KDB4YikNCj4gICAgICAgICAgU3VwcG9ydCBTZXQgVGVsZW1l
dHJ5IENSVCAgRXZlbnQoMHhjKQ0KPiAgICAgICAgICBTdXBwb3J0IFRoZXJtYWwgRXhjdXJzaW9u
IEV2ZW50KDB4ZCkNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFdlbiBYaW9uZyA8d2VueGlvbmdAbGlu
dXguaWJtLmNvbT4NCg0KWW91IG5lZWQgdG8gcHJvdmlkZSBhIGNvdmVyLWxldHRlciBmb3Igc2Vy
aWVzIGxpa2UgdGhpcy4uLg0KDQo+IC0tLQ0KPiAgIG52bWUtcHJpbnQuYyB8IDQ0ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tDQo+ICAgbnZtZS5jICAgICAgIHwg
IDQgKystLQ0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgNDAgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9udm1lLXByaW50LmMgYi9udm1lLXByaW50LmMNCj4g
aW5kZXggMTU1NmI1Mi4uMTZmZDU2OSAxMDA2NDQNCj4gLS0tIGEvbnZtZS1wcmludC5jDQo+ICsr
KyBiL252bWUtcHJpbnQuYw0KPiBAQCAtMTA1Myw2ICsxMDUzLDI2IEBAIHZvaWQgbnZtZV9zaG93
X3ByZWRpY3RhYmxlX2xhdGVuY3lfZXZlbnRfYWdnX2xvZygNCj4gICAJfQ0KPiAgIH0NCj4gICAN
Cj4gK2NvbnN0IGNoYXIgKm52bWVfcGVsX2V2ZW50X3RvX3N0cmluZyhpbnQgdHlwZSkNCj4gK3sN
Cj4gKwlzd2l0Y2ggKHR5cGUpIHsNCj4gKwljYXNlIE5WTUVfUEVMX1NNQVJUX0hFQUxUSF9FVkVO
VDoJcmV0dXJuICJTTUFSVC9IZWFsdGggTG9nIFNuYXBzaG90IEV2ZW50KDB4MSkiOw0KPiArCWNh
c2UgTlZNRV9QRUxfRldfQ09NTUlUX0VWRU5UOglyZXR1cm4gIkZpcm13YXJlIENvbW1pdCBFdmVu
dCgweDIpIjsNCj4gKwljYXNlIE5WTUVfUEVMX1RJTUVTVEFNUF9FVkVOVDoJcmV0dXJuICJUaW1l
c3RhbXAgQ2hhbmdlIEV2ZW50KDB4MykiOw0KPiArCWNhc2UgTlZNRV9QRUxfUE9XRVJfT05fUkVT
RVRfRVZFTlQ6CXJldHVybiAiUG93ZXItb24gb3IgUmVzZXQgRXZlbnQoMHg0KSI7DQo+ICsJY2Fz
ZSBOVk1FX1BFTF9OU1NfSFdfRVJST1JfRVZFTlQ6CXJldHVybiAiTlZNIFN1YnN5c3RlbSBIYXJk
d2FyZSBFcnJvciBFdmVudCgweDUpIjsNCj4gKwljYXNlIE5WTUVfUEVMX0NIQU5HRV9OU19FVkVO
VDoJcmV0dXJuICJDaGFuZ2UgTmFtZXNwYWNlIEV2ZW50KDB4NikiOw0KPiArCWNhc2UgTlZNRV9Q
RUxfRk9STUFUX1NUQVJUX0VWRU5UOglyZXR1cm4gIkZvcm1hdCBOVk0gU3RhcnQgRXZlbnQoMHg3
KSI7DQo+ICsJY2FzZSBOVk1FX1BFTF9GT1JNQVRfQ09NUExFVElPTl9FVkVOVDoJcmV0dXJuICJG
b3JtYXQgTlZNIENvbXBsZXRpb24gRXZlbnQoMHg4KSI7DQo+ICsJY2FzZSBOVk1FX1BFTF9TQU5J
VElaRV9TVEFSVF9FVkVOVDoJcmV0dXJuICJTYW5pdGl6ZSBTdGFydCBFdmVudCgweDkpIjsNCj4g
KwljYXNlIE5WTUVfUEVMX1NBTklUSVpFX0NPTVBMRVRJT05fRVZFTlQ6CXJldHVybiAiU2FuaXRp
emUgQ29tcGxldGlvbiBFdmVudCgweGEpIjsNCj4gKwljYXNlIE5WTUVfUEVMX1NFVF9GRUFUVVJF
X0VWRU5UOglyZXR1cm4gIlNldCBGZWF0dXJlIEV2ZW50KDB4YikiOw0KPiArCWNhc2UgTlZNRV9Q
RUxfVEVMRU1FVFJZX0NSVDoJCXJldHVybiAiU2V0IFRlbGVtZXRyeSBDUlQgIEV2ZW50KDB4Yyki
Ow0KPiArCWNhc2UgTlZNRV9QRUxfVEhFUk1BTF9FWENVUlNJT05fRVZFTlQ6CXJldHVybiAiVGhl
cm1hbCBFeGN1cnNpb24gRXZlbnQoMHhkKSI7DQo+ICsJZGVmYXVsdDoJCQlyZXR1cm4gTlVMTDsN
Cj4gKwl9DQo+ICt9DQo+ICsNCj4gICBzdGF0aWMgY29uc3QgY2hhciAqbnZtZV9zaG93X25zc19o
d19lcnJvcihfX3UxNiBlcnJvcl9jb2RlKQ0KPiAgIHsNCj4gICAJc3dpdGNoIChlcnJvcl9jb2Rl
KSB7DQo+IEBAIC0xMDg5LDYgKzExMDksNyBAQCB2b2lkIGpzb25fcGVyc2lzdGVudF9ldmVudF9s
b2codm9pZCAqcGV2ZW50X2xvZ19pbmZvLCBfX3UzMiBzaXplKQ0KPiAgIAlfX3UzMiBvZmZzZXQs
IHBvcl9pbmZvX2xlbiwgcG9yX2luZm9fbGlzdDsNCj4gICAJX191NjQgKmZ3X3JldjsNCj4gICAJ
Y2hhciBrZXlbMTI4XTsNCj4gKwljaGFyIGV2dF9zdHJbNTBdOw0KPiAgIA0KPiAgIAlzdHJ1Y3Qg
bnZtZV9zbWFydF9sb2cgKnNtYXJ0X2V2ZW50Ow0KPiAgIAlzdHJ1Y3QgbnZtZV9md19jb21taXRf
ZXZlbnQgKmZ3X2NvbW1pdF9ldmVudDsNCj4gQEAgLTExNTEsOSArMTE3MiwxNiBAQCB2b2lkIGpz
b25fcGVyc2lzdGVudF9ldmVudF9sb2codm9pZCAqcGV2ZW50X2xvZ19pbmZvLCBfX3UzMiBzaXpl
KQ0KPiAgIAkJZm9yIChpbnQgaSA9IDA7IGkgPCAzMjsgaSsrKSB7DQo+ICAgCQkJaWYgKHBldmVu
dF9sb2dfaGVhZC0+c2ViW2ldID09IDApDQo+ICAgCQkJCWNvbnRpbnVlOw0KPiAtCQkJc3ByaW50
ZihrZXksICJiaXRtYXBfJWQiLCBpKTsNCj4gLQkJCWpzb25fb2JqZWN0X2FkZF92YWx1ZV91aW50
KHJvb3QsIGtleSwNCj4gLQkJCQlwZXZlbnRfbG9nX2hlYWQtPnNlYltpXSk7DQo+ICsJCQlmb3Ig
KGludCBiaXQgPSAwOyBiaXQgPCA4OyBiaXQrKykgew0KPiArCQkJCWlmIChudm1lX3BlbF9ldmVu
dF90b19zdHJpbmcoYml0ICsgaSAqIDgpKSB7DQo+ICsJCQkJCXNwcmludGYoa2V5LCAiYml0bWFw
XyV4IiwgKGJpdCArIGkgKiA4KSk7DQo+ICsJCQkJCWlmICgocGV2ZW50X2xvZ19oZWFkLT5zZWJb
aV0gPj4gYml0KSAmIDB4MSkNCj4gKwkJCQkJCXNucHJpbnRmKGV2dF9zdHIsIHNpemVvZihldnRf
c3RyKSwgIlN1cHBvcnQgJXMiLA0KPiArCQkJCQkJCW52bWVfcGVsX2V2ZW50X3RvX3N0cmluZyhi
aXQgKyBpICogOCkpOw0KPiArCQkJCQlqc29uX29iamVjdF9hZGRfdmFsdWVfc3RyaW5nKHJvb3Qs
IGtleSwgZXZ0X3N0cik7DQo+ICsJCQkJfQ0KPiArCQkJfQ0KPiArDQoNCnBsZWFzZSBjcmVhdGUg
YSBoZWxwZXIgZm9yIGFib3ZlIGh1bmssIHRvbyBtdWNoIG5lc3RpbmcgLi4NCg0KPiAgIAkJfQ0K
PiAgIAl9IGVsc2Ugew0KPiAgIAkJcHJpbnRmKCJObyBsb2cgZGF0YSBjYW4gYmUgc2hvd24gd2l0
aCB0aGlzIGxvZyBsZW4gYXQgbGVhc3QgIiBcDQo+IEBAIC0xNDc5LDEyICsxNTA3LDE2IEBAIHZv
aWQgbnZtZV9zaG93X3BlcnNpc3RlbnRfZXZlbnRfbG9nKHZvaWQgKnBldmVudF9sb2dfaW5mbywN
Cj4gICAJCQlsZTMyX3RvX2NwdShwZXZlbnRfbG9nX2hlYWQtPnJjaSkpOw0KPiAgIAkJaWYgKGh1
bWFuKQ0KPiAgIAkJCW52bWVfc2hvd19wZXJzaXN0ZW50X2V2ZW50X2xvZ19yY2kocGV2ZW50X2xv
Z19oZWFkLT5yY2kpOw0KPiAtCQlwcmludGYoIlN1cHBvcnRlZCBFdmVudHMgQml0bWFwOiAiKTsN
Cj4gKwkJcHJpbnRmKCJTdXBwb3J0ZWQgRXZlbnRzIEJpdG1hcDogXG4iKTsNCj4gICAJCWZvciAo
aW50IGkgPSAwOyBpIDwgMzI7IGkrKykgew0KPiAgIAkJCWlmIChwZXZlbnRfbG9nX2hlYWQtPnNl
YltpXSA9PSAwKQ0KPiAgIAkJCQljb250aW51ZTsNCj4gLQkJCXByaW50ZigiICBCaXRNYXBbJWRd
IGlzIDB4JXhcbiIsIGksDQo+IC0JCQkJcGV2ZW50X2xvZ19oZWFkLT5zZWJbaV0pOw0KPiArCQkJ
Zm9yIChpbnQgYml0ID0gMDsgYml0IDwgODsgYml0KyspIHsNCj4gKwkJCQlpZiAobnZtZV9wZWxf
ZXZlbnRfdG9fc3RyaW5nKGJpdCArIGkgKiA4KSkNCj4gKwkJCQkJaWYgKChwZXZlbnRfbG9nX2hl
YWQtPnNlYltpXSA+PiBiaXQpICYgMHgxKQ0KPiArCQkJCQkJcHJpbnRmKCIJU3VwcG9ydCAlc1xu
IiwNCj4gKwkJCQkJCQludm1lX3BlbF9ldmVudF90b19zdHJpbmcoYml0ICsgaSAqIDgpKTsNCj4g
KwkJCX0NCg0Kc2FtZSBoZXJlIGFzIGFib3ZlDQoNCj4gICAJCX0NCj4gICAJfSBlbHNlIHsNCj4g
ICAJCXByaW50ZigiTm8gbG9nIGRhdGEgY2FuIGJlIHNob3duIHdpdGggdGhpcyBsb2cgbGVuIGF0
IGxlYXN0ICIgXA0KPiBkaWZmIC0tZ2l0IGEvbnZtZS5jIGIvbnZtZS5jDQo+IGluZGV4IDMwMzMx
NWMuLjdmODk4MDEgMTAwNjQ0DQo+IC0tLSBhL252bWUuYw0KPiArKysgYi9udm1lLmMNCj4gQEAg
LTQ5MDAsNyArNDkwMCw3IEBAIHN0YXRpYyBpbnQgZHNtKGludCBhcmdjLCBjaGFyICoqYXJndiwg
c3RydWN0IGNvbW1hbmQgKmNtZCwgc3RydWN0IHBsdWdpbiAqcGx1Z2luDQo+ICAgDQo+ICAgCW5j
ID0gYXJnY29uZmlnX3BhcnNlX2NvbW1hX3NlcF9hcnJheShjZmcuY3R4X2F0dHJzLCAoaW50ICop
Y3R4X2F0dHJzLCBBUlJBWV9TSVpFKGN0eF9hdHRycykpOw0KPiAgIAluYiA9IGFyZ2NvbmZpZ19w
YXJzZV9jb21tYV9zZXBfYXJyYXkoY2ZnLmJsb2NrcywgKGludCAqKW5sYnMsIEFSUkFZX1NJWkUo
bmxicykpOw0KPiAtCW5zID0gYXJnY29uZmlnX3BhcnNlX2NvbW1hX3NlcF9hcnJheV9sb25nKGNm
Zy5zbGJhcywgc2xiYXMsIEFSUkFZX1NJWkUoc2xiYXMpKTsNCj4gKwlucyA9IGFyZ2NvbmZpZ19w
YXJzZV9jb21tYV9zZXBfYXJyYXlfbG9uZyhjZmcuc2xiYXMsIChsb25nIGxvbmcgdW5zaWduZWQg
aW50ICopc2xiYXMsIEFSUkFZX1NJWkUoc2xiYXMpKTsNCj4gICAJbnIgPSBtYXgobmMsIG1heChu
YiwgbnMpKTsNCj4gICAJaWYgKCFuciB8fCBuciA+IDI1Nikgew0KPiAgIAkJZnByaW50ZihzdGRl
cnIsICJObyByYW5nZSBkZWZpbml0aW9uIHByb3ZpZGVkXG4iKTsNCj4gQEAgLTUwNDQsNyArNTA0
NCw3IEBAIHN0YXRpYyBpbnQgY29weShpbnQgYXJnYywgY2hhciAqKmFyZ3YsIHN0cnVjdCBjb21t
YW5kICpjbWQsIHN0cnVjdCBwbHVnaW4gKnBsdWdpDQo+ICAgCQl9DQo+ICAgCX0NCj4gICANCj4g
LQludm1lX2luaXRfY29weV9yYW5nZShjb3B5LCBubGJzLCBzbGJhcywgZWlsYnJ0cywgZWxiYXRt
cywgZWxiYXRzLCBucik7DQo+ICsJbnZtZV9pbml0X2NvcHlfcmFuZ2UoY29weSwgbmxicywgKF9f
dTY0ICopc2xiYXMsIGVpbGJydHMsIGVsYmF0bXMsIGVsYmF0cywgbnIpOw0KPiAgIA0KPiAgIAll
cnIgPSBudm1lX2NvcHkoZmQsIGNmZy5uYW1lc3BhY2VfaWQsIGNvcHksIGNmZy5zZGxiYSwgbnIs
IGNmZy5wcmluZm9yLA0KPiAgIAkJCWNmZy5wcmluZm93LCBjZmcuZHR5cGUsIGNmZy5kc3BlYywg
Y2ZnLmZvcm1hdCwgY2ZnLmxyLA0KPiANCg==

