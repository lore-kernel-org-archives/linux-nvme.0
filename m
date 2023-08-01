Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 312CDEB64DD
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Aug 2023 03:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DDAP9DYZa8D/dWuF8lVhDOjHDM2JaMdvA3DVca1eIpo=; b=jg6sDGDSE/ZeSK4FBdgBvo3XxK
	3BMJjR5yagJ8+NyvZAt1alZkpdUeGJg+rY9ORDxCsorXE2HVeDOEjCysnLg2vNxzv4MK+WUGBXECU
	6nr4QdZaqhJkozonPBS7rTk+rGoHcK9c+ffiC4eb4n9TL2LblgbKmPhJ4tBitHjS6liWMsmsE1XYu
	5JqoryUcR5QhRpK6NHV5y63jmKbgxhvj84FTIaMO+tPTaJ+qJKKPbFeG++W+ADDx8vdbPcs+v566L
	qYOtjQVlPSceqYJ+zsZvQvcrFD7TT8gQb1/sB+lcWwFJjZwQPermz+QyVmVwT8xFGP6ERNHUBTwUG
	nQEFAbbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQg4w-000HHX-0n;
	Tue, 01 Aug 2023 03:29:46 +0000
Received: from mail-bn8nam11on20600.outbound.protection.outlook.com ([2a01:111:f400:7eae::600] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQg4t-000HGv-1b
	for linux-nvme@lists.infradead.org;
	Tue, 01 Aug 2023 03:29:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBt3r4xfz/scKg5sij1PU1YsvQQ79JC8vbiDz61E0zO9FoyGS3xtcL1QRXOvgEOLFMJSyP9btYfKPefwvcpNDPNBjE7EgUOMv0rzSM7WwTSxVL0noC7l7AA8JOnwMe7Yh+3AAlgqFeyz/h/4zNbf/bl0np4NkmmltZ7a9B7/Vf776mxZ8vbl6wBwrVXvAZQyqo360D3ZrhUc8PQv8IeHMRWQ938hNof9fZlkcpCiugn+roe6EE5TZnOuuBS+o4p6OdweY8dlXTJ9u0JqVvOMG+bOtxwbLV5kxYIBWKvdBP850BQEeuRcYLDjNNyEQDoVtwh1cwbFo1zA7XMPh2w+RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDAP9DYZa8D/dWuF8lVhDOjHDM2JaMdvA3DVca1eIpo=;
 b=gFaXDCFe2zNACrHp7BAyGQt8D4ov63x8pB5ExhEntLH/SFePtn1O1iN9xmPsqZylL6h57eXwRgo2Ig9jP9i30up0OGckdw3RppA9jgwxbHQjdU6MYz/z5hBPaoYoRs4ukYItoEJpVj9SXgg5ONoq82W7KCDzR3tsfMtfK3tAJesZWqqRJu8Yt3nC85nVehfuiBz9aovGsVssW5Vnse3u1/L2p8hOLvIqwvCg8rQwY70zc+afw1DWgVLJKBIw0UEXFvvFZXlP9YoAVN5X9r2dOUjK4CJxuO1Z6NYAEuBaTV3iZ9DUaN3Mjpt8saCdWnSGrau45jAHTAL+tDpO6LQm/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDAP9DYZa8D/dWuF8lVhDOjHDM2JaMdvA3DVca1eIpo=;
 b=qIpj7I2GKfdXwkxwcKxJMkoF/1OaFdaJV2g0klAOe1et/5yNPVYfO3hzEOhbIUGqyIQSQanLtnrDWkHJasjeQMgRoUbtuz9jaRe7C23IJQYwhJtA4q7hMVXh7Ov9tpC+t9hZWoWIEBlPNc/aS6dTUOsQGTtxdvv9vTTnS36Nk0btx8GwSg2uxKW9tvF0wLF7zJwcSWrpg8QvpFWlD25DSRSg0+vsIT8D/PcBYA1ziF0yyMRgXiCoVt1QuPIbryRei/AudZQznpfRmXDjgQV0j/kX9vjQGbe0vCPwq7J42uNcAXTM3Sw1ppygJDIe6TiT1Nm0cde6mlAXkTphA+zDlg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SN7PR12MB6932.namprd12.prod.outlook.com (2603:10b6:806:260::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Tue, 1 Aug
 2023 03:29:25 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c3cf:2236:234b:b664]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c3cf:2236:234b:b664%4]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 03:29:25 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "sagi@grimberg.me" <sagi@grimberg.me>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
CC: "alan.adamson@oracle.com" <alan.adamson@oracle.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH V6 0/1] nvme: allow passthru cmd error logging
Thread-Topic: [PATCH V6 0/1] nvme: allow passthru cmd error logging
Thread-Index: AQHZqid/xZ0mKHsgc02APD230NBf3a/U/G0A
Date: Tue, 1 Aug 2023 03:29:24 +0000
Message-ID: <b7adad45-d70b-01a6-f667-2a4033d9cd55@nvidia.com>
References: <20230629011713.28554-1-kch@nvidia.com>
In-Reply-To: <20230629011713.28554-1-kch@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SN7PR12MB6932:EE_
x-ms-office365-filtering-correlation-id: dca69ed9-00b0-4716-b4be-08db923f811e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8zOGQNgPF0pTJTv9tMIqqq9nAMxBpfNNJPxQRpInn01chQ+55nttE13PAnRw9IVN/fq0SjLJRYTn924WLLvjfpetCRJofYjmTtwI2PfruGTVa9vMS0KG+xXrXiv3t9izsIYmDyIx0ujH0vlwzPkpP+BpwQEft9yl3yljzxJGEBCRmA5XNk/J13I+V1a5Zd9Ulg4k9qw8gRf2CBczyiK2sJOesxD92sRXsJjjNAWo9yqa73yp8KXm/mUCm4dX7dfR3Q8Db+ya3Yj24VM6WV8uymbZuADOBZf1MaVlHaBfeEz9Kg/L/ZEo+uLfcAjnc+DjmiQ2lBQwNaatq8bnqN1gFvdRXSxqHmoohXCey+a85xwwQ4xwkRqDXJaGJS9cSQTLCletBX+XS+vGTpEn1hAKvLC1BohZ0Wbp+oFrhh1+abW8O/awCaUokGIY8a5/+pQJ23ikJJKAtBANXXQ1Z6dyCs2mEkzyVBoUIvrThFq7O15BTxQ/T/Fn1EXp61Pi02vYdJF8RI9dDNtLdhjCELzqzxUgx7wuFZ0V85EiuhbvIW/qLujr04Tkh70QT+K52EtzanXQ+Ykpr8XgflTJEX8KPifWsQbQNF87q36rD8H3sDIN/lXtSaKx2UB2cjYnl/9NjEQs7L1stAFy9MSc8QwbEjjaquy9BMUYhqIGueCdom0wlBb8o58GabwT+Tb8Mdlk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199021)(83380400001)(2616005)(2906002)(76116006)(6512007)(91956017)(66556008)(66476007)(478600001)(64756008)(4326008)(6486002)(66446008)(6506007)(8936002)(110136005)(71200400001)(8676002)(41300700001)(5660300002)(26005)(53546011)(186003)(316002)(54906003)(66946007)(107886003)(38070700005)(36756003)(38100700002)(31696002)(86362001)(31686004)(122000001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qm5sVVBFYk1sUXIzalE2QUlHdWhWaHpFem1BYjRwUE4zRXBxUHJOODFobjJ4?=
 =?utf-8?B?anNST2JmRFBWSGFVTmdNMkNWc2xoRWhOMFpoRE9RZXdFWHRLcUw4L2hBNURN?=
 =?utf-8?B?b0Jpak9TTkMzekw1Zm1XdTQwNFpFdjdCZjJhZy9jT0hMSGhBVy8xSTlpVUcv?=
 =?utf-8?B?TmlERFBjQ3p1TTE0MTF3VytpSjFiMlZqcmdweXV4amdBamRidDUxV1ZtYSs3?=
 =?utf-8?B?TGwzd1RobUJKNnZNanMzRzJtdjE0eE1Qc2RpQ3J2S2hINTJMMC9GWVhTS0lp?=
 =?utf-8?B?dm43d3A1L1dCVk5wNU1LZUFYYzE0ZlhLbHliMWhDcWo3MU9QK3RTSkFUbjlE?=
 =?utf-8?B?eDZnMG5OcWVIZkdIQ2w2eWtTcE5QaXlWc3ZOcjd4aEpMSWtWajhEcVlaMFhU?=
 =?utf-8?B?SzV3cmszQnZnLzJjb3gvaUZVbHIwOVcrNFUzWUh5MEtXR3dNSlRtOVhnQkVX?=
 =?utf-8?B?TmFqU2V0MHBocHNqM2ZGbDl0RjhsSVlJalZrYlFaSDlaNVR6ak0ySXRUZFFH?=
 =?utf-8?B?bTVyWk16R2dlVDRYZVk1UVpud3NZR1FFRmlmeUl1QjBGdk9uMUNvRmFMOVB5?=
 =?utf-8?B?VnRCa1kxYXVaNHkwYTJ3QzJSdDhsVnVwTnZhdGRwT3QvMUJqaUFiQm5lQlZ2?=
 =?utf-8?B?eXdCejF0azhBQ1Z5amU1ZGxkRlhza0hkTWIySGlGRng2V3VtQ3Bwc0UrdTFX?=
 =?utf-8?B?SkJiNHlDT1VUOThOUGRWQzJ6ditmakhZenBEYU10WEVUSkZyYXl1dndvaTdK?=
 =?utf-8?B?MUtVNE5IaTFicXBWakh3S1UzcExPaVRTRDVvVjc5UXgyVC90djdzWGpGY1dM?=
 =?utf-8?B?VGhtYXJIVjFwd0s4M3FTKzg2ZncrN2ZGa2RqV203TXk0dXBMSzlEWmhhMTA5?=
 =?utf-8?B?ei9sRHV5RnNBalZYMk5nb3cyczlWd3dzSThpaXRRb3Uza1RkdWdiZ0hHOXRu?=
 =?utf-8?B?c1FDd3ZxQWJNMXRJeFV1VzN5Z0c0M1VJcGp1MFMxUWlVYUxtTmhQZ3NxdnQv?=
 =?utf-8?B?d1hJTmQ4YUdvN3Nyb0N0RG1GWTlHSytDK2RpaDRpdFZKN0hKbzZ1a2U1Y2hw?=
 =?utf-8?B?aUhKTXdsSU9EdER1SS8vemFwa0xwaUFwSllMVUsvQmN1MEhxSnFqQjJZRHBZ?=
 =?utf-8?B?clg4TFhoeEdhQ3ZTMGlmODRvcFpGdU1oL1hPcGlRdTNmSk9BU0g1UWJLT2cr?=
 =?utf-8?B?NFhyaG1Zck1hL28vMVA3UzIraHlnUEczTlV6M1pQakpWc1ZLR2gxMUpKcmEz?=
 =?utf-8?B?d1VTTGp4NFYxZ1lCTTR6bXlRbVB2VGZSL21VQ0YrQzJkT1U2RUxHNkpLUEJJ?=
 =?utf-8?B?bVpUQ0ZjN3pQOVpJVjRYdHlsWThEQ0FndzNpeHRlVmhQT3JsQVA2anBSZm4z?=
 =?utf-8?B?VFpxK09MMk15eGpWOGZtL3ZLUW5rNWpSNVhjajlzVjlPZS9rTWlJRlBvK3ph?=
 =?utf-8?B?WWlXaTJ3N05mUU1yOUw5Z2lLUHV4bUpQZmhVODFiRUk1N09JZ21oK1p6eDk4?=
 =?utf-8?B?cXVZaVdYY1g2UHM3ZmZOM1B0c29aYndVNXpiNjJBb3krVmtLbjdZZFF3Z0tL?=
 =?utf-8?B?U0dhZ2ZNRFdxdTZkc3EvUmJNOElyOEEwT3BISGJ6OXZKcXlTL21MRzNYd3kx?=
 =?utf-8?B?QVpuY0ljUnBpeGpraVEyY0J1OEFwcjluRzExdW5EQVE4TGxyUnNhWDY0am5o?=
 =?utf-8?B?S1k5aUk0U09JZXFjeVZnRzFLRmJEaUlHRU5kSk5nd1lLTEptTnNzL2xNdWNS?=
 =?utf-8?B?ZElNTE1ER0RpSjl3MFk0ZWtFdGNaVVZZWnk3T3JxRVRQQU5qRGhQdzhNN0ly?=
 =?utf-8?B?SE1sMjdUTEhqMDN0cGV1VWt3ZWswNmNKZzRjOFFra0VWUjdiMnh2WngvdnFz?=
 =?utf-8?B?SjNXS0lrWHM1N2xmakxjZm5MMElrUzF2QlBrTk84K2lESnZZa1ozTDllZHBq?=
 =?utf-8?B?V1N4dTNOKzZzWDh4MkNpS3Mxdjd2SEZzNi9MT2VSNXEvelBDTTZnWk9ZWDZL?=
 =?utf-8?B?d0JVdHprTzdKRUp1QkZ6WDIwTG5xaVhvOGZqMTREdSs1UE1ORURKemlLcHpU?=
 =?utf-8?B?a1FiTWJxOTBvY0JjVkxzZlF5MzBEdWRhanVMZWYrMEc2eHExMCs2UEtWdXNZ?=
 =?utf-8?Q?93mzBt8+Lj+HfxiU40hMnoB4o?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D421FB558F8D0845B31115CF335E9F0C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dca69ed9-00b0-4716-b4be-08db923f811e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 03:29:24.9757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N9VUhJa2CAMmeV8YA3Cmr2oPns6hc+XkcduD6lrayiT322vsr9b7iVCz8YbcJBGDzM7Nu9/YsojmOCxKbDuCmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6932
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_202943_689255_1E189359 
X-CRM114-Status: GOOD (  23.31  )
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

T24gNi8yOC8yMyAxODoxNywgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPiBIaSwNCj4NCj4g
SW4gbnZtZV9lbmRfcmVxKCkgd2Ugb25seSBsb2cgZXJyb3JzIHdoaWNoIGFyZSBmb3Igbm9uLXBh
c3N0aHJ1DQo+IGNvbW1hbmRzLiBBZGQgYSBoZWxwZXIgZnVuY3Rpb24gbnZtZV9sb2dfZXJyX3Bh
c3N0aHJ1KCkgdGhhdCBhbGxvd3MgdXMNCj4gdG8gbG9nIGVycm9yIGZvciBwYXNzdGhydSBjb21t
YW5kcyBieSBkZWNvZGluZyBjZHcxMC1jZHcxNSB2YWx1ZXMgb2YNCj4gbnZtZSBjb21tYW5kLg0K
Pg0KPiBCZWxvdyBpcyBzaG9ydCB0ZXN0bG9nIDotDQo+DQo+ICogQWRtaW4gUGFzc3N0aHJ1IGVy
cm9yIGxvZyBvZmYsIG5vIGVycm9ycyBhcmUgcHJpbnRlZA0KPiAqIEFkbWluIFBhc3NzdGhydSBl
cnJvciBsb2cgb24sIGVycm9ycyBhcmUgcHJpbnRlZA0KPiAqIElPIFBhc3NzdGhydSBlcnJvciBs
b2cgb2ZmLCBlcnJvcnMgYXJlIHByaW50ZWQNCj4gKiBJTyBQYXNzc3RocnUgZXJyb3IgbG9nIG9u
LCBlcnJvcnMgYXJlIHByaW50ZWQNCj4NCj4gLWNrDQoNClNhZ2ksIENocmlzdG9waCwgS2VpdGgs
DQoNCkNhbiB5b3UgZ3V5cyBwbGVhc2UgaGF2ZSBhIGxvb2sgaW50byB0aGlzID8NCg0KLWNrDQoN
Cj4gQ2hhaXRhbnlhIEt1bGthcm5pICgxKToNCj4gICAgbnZtZTogYWxsb3cgcGFzc3RocnUgY21k
IGVycm9yIGxvZ2dpbmcNCj4NCj4gdjY6DQo+IC0gUmVhYnNlLCBldGVzdCBudm1lLTYuNSBhbmQg
YWRkIHRlc3QgbG9nIGZvciBhZG1pbiBhbmQgSS9PDQo+ICAgIHBhc3N0aHJ1IGVycm9yIGxvZy4N
Cj4NCj4gdjU6DQo+IC0gVHJpbSBkb3duIGNvZGUgaW4gdGhlIG52bWVfbG9nX2Vycm9yX3Bhc3N0
aHJvdWdoKCkuDQo+ICAgIFVzZSBmb2xsb3dpbmcgdG8gZ2V0IHRoZSBkaXNrIG5hbWUgYXMgYW4g
YXJnIHRvDQo+ICAgICBwcl9lcnJfcmF0ZWxpbWl0ZWQoKSA6LQ0KPiAJbnMgPyBucy0+ZGlzay0+
ZGlza19uYW1lIDogZGV2X25hbWUobnItPmN0cmwtPmRldmljZSksDQo+ICAgIFVzZSBmb2xsb3dp
bmcgdG8gZ2V0IHRoZSBhZG1pbiB2cyBJL08gb3Bjb2RlIHN0cmluZyBhcyBhbiBhcmcgdG8NCj4g
ICAgcHJfZXJyX3JhdGVsaW1pdGVkKCkgOi0NCj4gICAgICAgICAJbnMgPyBudm1lX2dldF9vcGNv
ZGVfc3RyKG5yLT5jbWQtPmNvbW1vbi5vcGNvZGUpIDoNCj4gICAgICAgICAJICAgICBudm1lX2dl
dF9hZG1pbl9vcGNvZGVfc3RyKG5yLT5jbWQtPmNvbW1vbi5vcGNvZGUpLA0KPiAtIFJlbmFtZSBu
dm1lX2xvZ19lcnJvcl9wYXNzdGhyb3VnaCgpIC0+IG52bWVfbG9nX2Vycl9wYXNzdGhydSgpLg0K
PiAtIFJlbW92ZSBlbHNlIGFuZCByZXR1cm4gZGlyZWN0bHkgaW4gbnZtZV9wYXNzdGhydV9lcnJf
bG9nX3Nob3coKS4NCj4gLSBHZW5lcmF0ZSBlcnJvciBvbiBpbnZhbGlkIHZhbHVlcyBvZiB0aGUg
cGFzc3RocnVfZW5hYmxlIHZhcmlhYmxlDQo+ICAgIGluIG52bWVfcGFzc3RocnVfbG9nX3N0b3Jl
KCkuDQo+IC0gUmVuYW1lIHBhc3N0aHJvdWdoIC0+IHBhc3N0aHJ1Lg0KPiAtIFJlbmFtZSBzeXNm
cyBhdHRyIGZyb20gcGFzc3RocnVfYWRtaW5fZXJyX2xvZ2dpbmcgLT4gcGFzc3RocnVfbG9nX2Vy
ci4NCj4NCj4gdjQ6DQo+IC0gQ2hhbmdlIHN5c2ZzIGF0dHJpYnV0ZSB0byBwYXNzdGhydV9hZG1p
bl9lcnJfbG9nZ2luZw0KPiAtIE9ubHkgbG9nIHBhc3N0aHJvdWdoIGFkbWluIGNvbW1hbmRzLiAg
SU8gcGFzc3Rocm91Z2ggY29tbWFuZHMgd2lsbA0KPiAgICBhbHdheXMgYmUgbG9nZ2VkLg0KPg0K
PiB2MzoNCj4gLSBMb2cgYSBwYXNzdGhyb3VnaCBzcGVjaWZpYyBtZXNzYWdlIHRoYXQgZHVtcHMg
Q0RXKiBjb250ZW50cy4NCj4gLSBFbmFibGUvZGlzYWJsZSB2aXMgc3lzZnMgcmF0aGVyIHRoYW4g
ZGVidWdmcy4NCj4NCj4gdjI6DQo+IC0gSW5jbHVkZWQgUGFua2FqIFJhZ2hhdidzIHBhdGNoICdu
dm1lOiBpZ25vcmUgc3RhcnRpbmcgc2VjdG9yIHdoaWxlDQo+ICAgIGVycm9yIGxvZ2dpbmcgZm9y
IHBhc3N0aHJvdWdoIHJlcXVlc3RzJw0KPiAgICB3aXRoIGEgY291cGxlIGNoYW5nZXMuDQo+IC0g
TW92ZWQgZXJyb3JfbG9nZ2luZyBmbGFnIHRvIG52bWVfY3RybCBzdHJ1Y3R1cmUNCj4gLSBUaGUg
ZW50aXJlIG52bWUtZGVidWdmcy5jIGRvZXMgbm90IG5lZWQgdG8gYmUgZ3VhcmRlZCBieQ0KPiAg
ICAjaWZkZWYgQ09ORklHX0ZBVUxUX0lOSkVDVElPTl9ERUJVR19GUy4NCj4gLSBVc2UgSVNfRU5B
QkxFRCgoQ09ORklHX05WTUVfRVJST1JfTE9HR0lOR19ERUJVR19GUykpIHRvIGRldGVybWluZSBp
Zg0KPiAgICBlcnJvciBsb2dnaW5nIHNob3VsZCBiZSBpbml0aWFsaXplZC4NCj4gLSBWYXJpb3Vz
IG90aGVyIG5pdHMuDQo+DQo+ICAgZHJpdmVycy9udm1lL2hvc3QvY29yZS5jICB8IDQzICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLQ0KPiAgIGRyaXZlcnMvbnZtZS9ob3N0
L252bWUuaCAgfCAgMSArDQo+ICAgZHJpdmVycy9udm1lL2hvc3Qvc3lzZnMuYyB8IDM5ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAgMyBmaWxlcyBjaGFuZ2VkLCA3OCBp
bnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPg0KPiAqIEFkbWluIFBhc3NzdGhydSBlcnJv
ciBsb2cgb2ZmLCBubyBlcnJvcnMgYXJlIHByaW50ZWQgOi0NCj4NCj4gbnZtZSAobnZtZS02LjUp
ICMNCj4gbnZtZSAobnZtZS02LjUpICMgZWNobyAwID4gL3N5cy9jbGFzcy9udm1lL252bWUwL3Bh
c3N0aHJ1X2Vycl9sb2cNCj4gbnZtZSAobnZtZS02LjUpICMgbnZtZSB0ZWxlbWV0cnktbG9nIC1v
IC90bXAvdGVzdCAvZGV2L252bWUwDQo+IE5WTWUgc3RhdHVzOiBJbnZhbGlkIEZpZWxkIGluIENv
bW1hbmQ6IEEgcmVzZXJ2ZWQgY29kZWQgdmFsdWUgb3IgYW4gdW5zdXBwb3J0ZWQgdmFsdWUgaW4g
YSBkZWZpbmVkIGZpZWxkKDB4NDAwMikNCj4gRmFpbGVkIHRvIGFjcXVpcmUgdGVsZW1ldHJ5IGxv
ZyAxNjM4NiENCj4gbnZtZSAobnZtZS02LjUpICMgY2QgLQ0KPiAvc3lzL2tlcm5lbC9kZWJ1Zy90
cmFjaW5nL2V2ZW50cy9udm1lDQo+IG52bWUgIyBjZCAtDQo+IC9tbnQvZGF0YS9udm1lDQo+IG52
bWUgKG52bWUtNi41KSAjIGRtZXNnICAtYw0KPg0KPiAqIEFkbWluIFBhc3NzdGhydSBlcnJvciBs
b2cgb24sIGVycm9ycyBhcmUgcHJpbnRlZCA6LQ0KPg0KPiBudm1lIChudm1lLTYuNSkgIyBlY2hv
IDEgPiAvc3lzL2NsYXNzL252bWUvbnZtZTAvcGFzc3RocnVfZXJyX2xvZw0KPiBudm1lIChudm1l
LTYuNSkgIyBudm1lIHRlbGVtZXRyeS1sb2cgLW8gL3RtcC90ZXN0IC9kZXYvbnZtZTANCj4gTlZN
ZSBzdGF0dXM6IEludmFsaWQgRmllbGQgaW4gQ29tbWFuZDogQSByZXNlcnZlZCBjb2RlZCB2YWx1
ZSBvciBhbiB1bnN1cHBvcnRlZCB2YWx1ZSBpbiBhIGRlZmluZWQgZmllbGQoMHg0MDAyKQ0KPiBG
YWlsZWQgdG8gYWNxdWlyZSB0ZWxlbWV0cnkgbG9nIDE2Mzg2IQ0KPiBudm1lIChudm1lLTYuNSkg
IyBkbWVzZyAgLWMNCj4gWyAgODYwLjAxMzEwNV0gbnZtZTA6IEdldCBMb2cgUGFnZSgweDIpLCBJ
bnZhbGlkIEZpZWxkIGluIENvbW1hbmQgKHNjdCAweDAgLyBzYyAweDIpIEROUiBjZHcxMD0weDdm
MDEwNyBjZHcxMT0weDAgY2R3MTI9MHgwIGNkdzEzPTB4MCBjZHcxND0weDAgY2R3MTU9MHgwDQo+
IG52bWUgKG52bWUtNi41KSAjDQo+IG52bWUgKG52bWUtNi41KSAjDQo+DQo+ICogSU8gUGFzc3N0
aHJ1IGVycm9yIGxvZyBvZmYsIGVycm9ycyBhcmUgcHJpbnRlZCA6LQ0KPg0KPiBudm1lIChudm1l
LTYuNSkgIyAgZWNobyAwID4gL3N5cy9jbGFzcy9udm1lL252bWUwL3Bhc3N0aHJ1X2Vycl9sb2cN
Cj4gbnZtZSAobnZtZS02LjUpICMgbnZtZSB3cml0ZS16ZXJvZXMgLW4gMSAtcyAweDIwMDAwMCAt
YyAxMCAvZGV2L252bWUwDQo+IE5WTWUgc3RhdHVzOiBMQkEgT3V0IG9mIFJhbmdlOiBUaGUgY29t
bWFuZCByZWZlcmVuY2VzIGFuIExCQSB0aGF0IGV4Y2VlZHMgdGhlIHNpemUgb2YgdGhlIG5hbWVz
cGFjZSgweDQwODApDQo+IG52bWUgKG52bWUtNi41KSAjIGRtZXNnIC1jDQo+IFs3MzY3NS43Njkx
NjJdIG52bWUgbnZtZTA6IHVzaW5nIGRlcHJlY2F0ZWQgTlZNRV9JT0NUTF9JT19DTUQgaW9jdGwg
b24gdGhlIGNoYXIgZGV2aWNlIQ0KPiBbNzM2NzUuNzY5MjMzXSBudm1lMG4xOiBXcml0ZSBaZXJv
ZXMoMHg4KSwgTEJBIE91dCBvZiBSYW5nZSAoc2N0IDB4MCAvIHNjIDB4ODApIEROUiBjZHcxMD0w
eDIwMDAwMCBjZHcxMT0weDAgY2R3MTI9MHhhIGNkdzEzPTB4MCBjZHcxND0weDAgY2R3MTU9MHgw
DQo+DQo+ICogSU8gUGFzc3N0aHJ1IGVycm9yIGxvZyBvbiwgZXJyb3JzIGFyZSBwcmludGVkIDot
DQo+DQo+IG52bWUgKG52bWUtNi41KSAjICBlY2hvIDEgPiAvc3lzL2NsYXNzL252bWUvbnZtZTAv
cGFzc3RocnVfZXJyX2xvZw0KPiBudm1lIChudm1lLTYuNSkgIyBudm1lIHdyaXRlLXplcm9lcyAt
biAxIC1zIDB4MjAwMDAwIC1jIDEwIC9kZXYvbnZtZTANCj4gTlZNZSBzdGF0dXM6IExCQSBPdXQg
b2YgUmFuZ2U6IFRoZSBjb21tYW5kIHJlZmVyZW5jZXMgYW4gTEJBIHRoYXQgZXhjZWVkcyB0aGUg
c2l6ZSBvZiB0aGUgbmFtZXNwYWNlKDB4NDA4MCkNCj4gbnZtZSAobnZtZS02LjUpICMgZG1lc2cg
LWMNCj4gWzczNjg0LjIwODI0MV0gbnZtZSBudm1lMDogdXNpbmcgZGVwcmVjYXRlZCBOVk1FX0lP
Q1RMX0lPX0NNRCBpb2N0bCBvbiB0aGUgY2hhciBkZXZpY2UhDQo+IFs3MzY4NC4yMDg0MTldIG52
bWUwbjE6IFdyaXRlIFplcm9lcygweDgpLCBMQkEgT3V0IG9mIFJhbmdlIChzY3QgMHgwIC8gc2Mg
MHg4MCkgRE5SIGNkdzEwPTB4MjAwMDAwIGNkdzExPTB4MCBjZHcxMj0weGEgY2R3MTM9MHgwIGNk
dzE0PTB4MCBjZHcxNT0weDANCj4gbnZtZSAobnZtZS02LjUpICMNCj4NCg0K

