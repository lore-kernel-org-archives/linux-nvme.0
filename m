Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1E7C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Mar 2022 23:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i9/zlo7VqsEj2XST6Qq0Of6FVxggt8VfgQoZFzD9VT0=; b=yNtJQs8EFnx4rxuix93NlpJgxC
	gXGGHMXjVBzQwRDpjWox16EqQ5xN0WCRzUenPEdJxdkAjBhASPRb2oAode4hLITr48PLBRXufeW+V
	5YlDBqwXFejKBuZAmtWmVyX6in69eBWTWzPm1G5TiI6BxXWky+4PEzMmhNEYpsNlNQ1WIqoXEruEk
	nPN6N8xCp8dy6SfXws9acLv9g6C39qF2AMaVoRU21yLV3VTs/mTMevfs9zSzVZ+h5oeP0798iKETV
	b0GfyhfSWlHsxYSePxZdZF+W+IJyk2yttLPh6V+6PmzVE1KrxxiIizq3WZdiM9FhZRRKBXQ8vmrNo
	f1sxEQZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTtkr-0078N1-TP; Mon, 14 Mar 2022 23:05:33 +0000
Received: from mail-mw2nam12on20630.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::630]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTtko-0078M3-QB
 for linux-nvme@lists.infradead.org; Mon, 14 Mar 2022 23:05:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZR26mboaP7fRC6yFa+6Hrabv8bvkygCL5/EmaYNK0hvq9fPsW1gG079PgAQx+hSAC73NL3mrO/FRg8q//Zl08nUA2txSbZ+StTFrhAEHmZq9WAKbgUp4LNPIMhb4xSBhFz+prrGB9bsjtyJJpfy0UVYmLKAjnBdFkG3OVRJjwomsleAxc7jnljNevt+8SjJ0+7Dvhz/k+z17iBh3AoGD2akxVqBL5Cx9vI80LH8vUeYfT9kyen/sEudnyka3NxAoryqsnLKhSK2ngQOVXpiRb/PnUNo65ar+03rFf16eY/R4Dfzq4+2VsBToGJaKFMwZfAT+DH2pl6pbXGFL48cIgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9/zlo7VqsEj2XST6Qq0Of6FVxggt8VfgQoZFzD9VT0=;
 b=lK3PITYywFR+N3IA5cqzp0bX7EVZClG/J5maAXXHyph3n+u1E1M2jF8l6ZzFhx5bUoJTiCViNFQntDlwGJNNlfF1F1bW8zs4PJUovHO/0d+yGV6mi5ThspVz5MM6f5If/zPE4xsPTId7eMyrXZwnI8/CTRUR7nc/o8z24VeFD3gXc03oOpHKYaOjFVsPh6muH6k848O5nrm2MsjApQfNwvpRULeJTNhGlZuZuYw2FFkcmZTiKYy9p7OJddm/8DbRaLB9+mfw2mnA7Me/NQZM+YDi3TcmdMK1VQ2TH2MsDUq0WmNeWodjZO1GtJy8jA3DWMo0HJND2zbZbY+1QhV0hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9/zlo7VqsEj2XST6Qq0Of6FVxggt8VfgQoZFzD9VT0=;
 b=SGI5KQvjatpuRADmqyJWcLWrvn9w4xCVxcFYXm7Ab7OrVYxU3I5L/7BK01ehIY2ahRcWrFrWxwvjplpp0DdmErsV2YJF+YvVDrmwuYI34sUEYq6XcQkJuqM5jB8pV55GtfYEBZUTlB9oXXPrITN6RLKqrNOe1P30TYWsJmvHWmJB4gs7UAHCykMbUOMhdwJ+PZ7vhWfkJNSKr3/zYVOCYj3kZQMQ6uTeY7sVW+SMBfvviqZhA9kc7SkpJRTd1a6stQxAzZWO47PH/0SgOqpa8J7XBkXX4Aod0A0d24bRH+dzwATzdveqH8s5bvKr9hi4Dskp/AGauG4cvd5Lm4idrw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CO6PR12MB5443.namprd12.prod.outlook.com (2603:10b6:303:13a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Mon, 14 Mar
 2022 23:05:27 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.5061.026; Mon, 14 Mar 2022
 23:05:27 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 0/2] nvmet: nvme_excute_get_feat() cleanup
Thread-Topic: [PATCH 0/2] nvmet: nvme_excute_get_feat() cleanup
Thread-Index: AQHYM90vQR12UPwzW0yWETd0inPfoKy+hnqAgAEBxwA=
Date: Mon, 14 Mar 2022 23:05:26 +0000
Message-ID: <865da5a9-3f5d-95eb-5365-ded0320fa597@nvidia.com>
References: <20220309174308.41832-1-kch@nvidia.com>
 <20220314074249.GB4570@lst.de>
In-Reply-To: <20220314074249.GB4570@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 133c82c3-a960-4524-500d-08da060f20c6
x-ms-traffictypediagnostic: CO6PR12MB5443:EE_
x-microsoft-antispam-prvs: <CO6PR12MB5443F945BE97BBA4DA66A58AA30F9@CO6PR12MB5443.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L56+eajbokUVGcCSx04xQM4BeUpJ9TI3I6nEQWUjbrgHqN8OJusU50HVSa8CqggEWx8mK9K5d5WQcugC9QrN+xUbMs1kGGeBm7ouJuuzBlj5OXFfJACtuKLVsUdmqUQGqpO+6aqgNB6hF9T3mFtXjP9oQHYi2XNoBJa8S++rC+OI88X8RbZ3AHXrw3dDM0LCcCmkV6NiXrbSh3SJLIQrOXQpj2sZMboL2t25h/7d8SMlgsEkZdwRzt+GoABifMhXZLkiW56Wfh/bFDdLpAf/rAsXxyAJr75uylwtTEEudFIIrrXZMNxnLyJfHzKS7qj5vedBSTfrcPSqKFig9T5Y4KUnTUAuouOO7LV2zhee+/ctJlMfa9Ny45FuxuAnMBiRfExew/D3eRYoqPvp6IIzVjHAyIE/Fb7BscPi1d4of+p3k6Q2daw01YMY59ceyIQt5cfCxkupws7vEtkpfSOqhxCdwDm/coDREu4PUXEkog9xDr1dIsm7GINeKNEaGyKKW+fjXSO6GTC3pnvfotgGYtIQvOiHIIY1sJojcAj+NV2Ht3lr6R9NtYVytlFoO+voUdYTpSz6lP58/mlTzocmOEB8pxQeTtiHmzW/zQcW0H7I7VFI0IdSb/PzVhWJiiOox4H63CtLgL218lFbQvkF1/l0kzoBduLLU4dxbxkj2sTz4qqTBgMi0QoGeK9HMT1KGNegaiCFljbHObb2XtaftHfJRYHBv+i6aLJTNbzZTBVCC4WbT8BYZ+HWVF/LPNQhdAoam4CI4KK4ivI0a/H21Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6486002)(66446008)(38070700005)(6916009)(8936002)(71200400001)(5660300002)(54906003)(76116006)(316002)(26005)(91956017)(64756008)(4326008)(66556008)(86362001)(66946007)(31696002)(66476007)(8676002)(186003)(2616005)(6506007)(122000001)(53546011)(2906002)(31686004)(36756003)(6512007)(558084003)(38100700002)(508600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVY0Y1Y3QThzazNZYkFBaS9xWWgxSkNydWZwanZDTHZvRHdtL0FwVTZJbFl2?=
 =?utf-8?B?RHNwT0JWb2VTTGc3MFBWMVl0bE1PZXh6bW9KNFNWeVpacGtIWUNzQzRlZ2hP?=
 =?utf-8?B?VU5vTStRd2o1cVZZLy9YN1hVZG5JZ01xOXozcDcrY0I1VmNXSU5iVVgwTHBL?=
 =?utf-8?B?QmJWTjZwaVloQ0lYTk10LzJSaWxRVlBYcEwzT2xQNlZMY1IybDI5UnVsQlJU?=
 =?utf-8?B?eDBrUE5ST21xL3JsVWtCb09MWFh1V01nWUxuaXhRaUprN3MwMjg2UmluTUlR?=
 =?utf-8?B?STlRQWpDMXJza2wvdERzVmRMOHVORVQ5bUlySTBBUlZzK2JSVDVsN1RPczBU?=
 =?utf-8?B?SkJDYjE2djlkd2w3My9aK0Nxbk1CTHhMNlRnd1QzZ1pXdEJ0MkZiR1JlZ2ZI?=
 =?utf-8?B?Ni9tYjF5OUl1SXFxcUxXV2RVL2IwdDNhT05aUVROOXdYQUJoMlYxN1pFYW8z?=
 =?utf-8?B?QzhtTUpxV1FORWVadkZtK3R4Z0dFbktaemlCQXdmeWhQUzE3T0hZNzg5M2oy?=
 =?utf-8?B?Y0FmV3c0U0ZDTjdTWUh1bU0wQUIxazlVNElleUZuZGxNZkxPM1NKV0FGVXVi?=
 =?utf-8?B?R2RLbTFoSnp1NVFGTVN1WG1JZENEdnBHT2laTHhtV1lhTlcwaTlXckxmMElD?=
 =?utf-8?B?aDZVdmlSYndXTXFPUVNPS21kcytoaHBZdExWY3FrdnlXeVZxQnFrTEE2MEsz?=
 =?utf-8?B?YWNuZjRTaU0ybmNCM2RTb2xrNlRqZVJRWHRVWXcyc21qeWhCTkd0c2Z2aVdQ?=
 =?utf-8?B?NEVpQU9DUHRkWVRZMVJ6K3B4Nnhhc21lUDRxMFRla0lEVi9JSjA2M3NoV0Nl?=
 =?utf-8?B?dlZURUhKZ1ZBd2Z0UlB0WVkvODRhNnFNTE82ZjE2MnE0RlFUZ3FRcFJhN2JF?=
 =?utf-8?B?d1h6OGxnRVJueXZWMzUzbGFqU3FIdy9iT3J0cUFnUjI1WnphSDJJZkJ3THlt?=
 =?utf-8?B?V1BGVVVaWGQ1bFdLeHNtcjNLQ3UzSyt2dEtBVURWWWsvRzh3Q3dpNVQ5RFRB?=
 =?utf-8?B?TDZ4cVlxcXdHU2VXVnhzRlFzSE90cXFFOWtTWk5UQnVUZTR3dXA3Vm1qSkp0?=
 =?utf-8?B?ZXJFZTFGVnN4K3BhbUFsM0EyanJRNTNVSklvdi9KVjdmdTlRWitTK3YxcUl0?=
 =?utf-8?B?L3Y0QkFBeEdYSDMrQnhXNkZqWGVnajUwZEVpeHoyeDdYY2tSTnc0R25LUEc5?=
 =?utf-8?B?MkxDZngvTTdUMTJGY2M5RkRaRUNIMXA2cTJ5TmlYNnJkTUo2dmVLeGFzcFdJ?=
 =?utf-8?B?bEN1RDc4OEs3dGl4OFVuVnk3d29wajFubDMxQ2toQ1ZwMnRHMXlDRkk4YzVq?=
 =?utf-8?B?bVFJU2lXQ0YzQkFzbUFIalI0RlpKWE1JazJ6SmFZTnpKUlE5VVRBRjlmZ1Yx?=
 =?utf-8?B?Z2psQTNvUEJVRVRsVmNwWkNWV2gydjdtQUQ4MTJQZ2Raempaa3NPcjdVRjZU?=
 =?utf-8?B?bG5kSXdudnMvZlB6T0xXeFduVXF3ODl0Yk5aQk1VKyt0d0UwY1pzd2w4djlt?=
 =?utf-8?B?Uy80WGJqSnp3V2MvQXVYOE1xdjhZRXgxcElFWGdWYytiVDlXQURqRTcwMGxL?=
 =?utf-8?B?OWtvMlpYR2QvYkNUT0piVG5KcTJaQzJtTlV4eWpuT0l0aTZTMjNjNVNRUXhW?=
 =?utf-8?B?TldiNGJvRG5jblhqd2EvaW5JbmlLVFQ4WUpndVBiWmdxcCtLSWwvd2FCS3ls?=
 =?utf-8?B?YWVTMkRNRFU4Rm5JZFNSaUY4cWQxcExOS0FmcWhlY2dheEU5UlhwYWI3ZGRz?=
 =?utf-8?B?VlRwaDRxVkNWd0g5dHFLYXVzcm4wRjhYT2tTSDUzcUZiaGh4WVlPcnlIVE5M?=
 =?utf-8?B?ZHlJYlY2Q0FaWldjcFZXSlBtdkRjbTVFZ1RzR29la2xhVUtDZ1hvdzNvVzB2?=
 =?utf-8?B?N3VYK3F2dHAzWXhlMDkvalkrSWVmTjR0Z1R6RStJQzJFWmFaNjNsV3puWUc5?=
 =?utf-8?Q?3UJub7tCHmlLw5761Ntu6u2GzgJHze1D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <22538DE9FBF9D54DB2E60846F9394354@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 133c82c3-a960-4524-500d-08da060f20c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2022 23:05:26.9865 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gXHsFEnbn+bAzcrE+6xOIAVrqrNhyvJSkLk5HK9RV0z6rS4OxyLzdnaRW/4HtDWLtObZClmNngmFTMzvzKp8AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5443
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220314_160530_892534_AB0CC65B 
X-CRM114-Status: GOOD (  10.20  )
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

Q2hyaXN0b3BoLA0KDQpPbiAzLzE0LzIyIDAwOjQyLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToN
Cj4gVGhhbmtzLA0KPiANCj4gYXBwbGllZCB0byBudm1lLTUuMTguDQo+IA0KDQpQbGVhc2UgcmV2
ZXJ0IHRoaXMgc2VyaWVzIEkndmUgbWFkZSBhIG1pc3Rha2Ugd2hlbiBzZW5kaW5nIHRoaXMgc2Vy
aWVzDQp0aGF0IGlzIGJyZWFraW5nIHRoZSBidWlsZCwgd2lsbCBzZW5kIG91dCBhIHJpZ2h0IG9u
ZSBsYXRlci4NCg0KU29ycnkgZm9yIHRoZSBpbmNvbnZlbmllbmNlLg0KDQotY2sNCg0KDQo=

