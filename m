Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94754C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Dec 2021 23:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=agw1MMzK37tdvsrT6+N2L/8kHCXgsZ/PuC3QmRbyDNo=; b=383p6aQeX8THiZBZrvaFl/VYtk
	pPr2RLL1/RQlc2iDVvZvjdhGPAAiMyHPV/UCbYDYfMOINB1yfyb6x5hBYlPZP8+YUb61pHKE3xTk8
	f2TQNqj4zYOxPV88UklaF/xZovc+p9OjNl+yTPF8fv0Cu6ZuvTdNpZVza1IScCKl596SJq6u+36Fj
	w2Uv+4XJ51VaSU1sPsjF9yGDnWMZEhEGgk7eUDZ6sWIu8X12VloQhfZ89MP6eN0mzaR5+nrMb5G/O
	BiIVwPkfiY1cUVFuy1h+vz0ijJNRn+sUA15DmFKjCG7Pq2j82/E9HVs/o9JTbLFS5v7IeHsSKv61B
	cx3cmj1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mwuNG-00Buq3-Jy; Mon, 13 Dec 2021 23:04:50 +0000
Received: from mail-mw2nam12on2067.outbound.protection.outlook.com
 ([40.107.244.67] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwuMD-00Bufd-9b
 for linux-nvme@lists.infradead.org; Mon, 13 Dec 2021 23:03:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWdUEUN8eb82G1RepUldN7ayFLuO24KgenQuGMHfIQxdSElRM1TmJXpDM2ktFC2MkDTp+poIX4uJnMb4MKBS3ZIOLazSstbxuvjRMUisLZCc7K5tWR6qbuYgHOs8O+n0o/f96Nmyk4MsNfcX7Wo6RZYClHpB6tGDYDWTE6Nxw2ZaoySb0Q72pnwqShULNqwpEwaUtp3SxOqLr+JdoHV3G30gL2pSFHbHL1wF7SKkoKakwYc9Ot+Xg1OHJWPjJL9dAEuZsGf8uPCMZruXLlaOpncMMScgjAOCc06Wjlgdl/dTNzvF7fJfUWIDEXkeOtO2ntujGt24mNsnEGah5fBRqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=agw1MMzK37tdvsrT6+N2L/8kHCXgsZ/PuC3QmRbyDNo=;
 b=bMKpssJg/WZHjzUHKj1IWFzL7VqL8ZBq8ABXKY8LgmhyYd+5oepWsfvwNM/BBLuxzErtHzZXcAFKkKVKB9DvY9tDRB1vqNlilSinUUq9drptvrtNg4XWfxzHClNF1zpH15acqatfzai/MPPQfogVt7ymIiR9i0u4W3CffJDUSkLDPitsvTQVe48osONzcC/JDCowRh32x/QH0bbyeyYB+qdL/JLY2BMxbHaj9ZMFCdqPgyyuR/33+ZA/kyMF39L8Z276QcwOcJkDYa7TY7X4yLjwoiYa5bchuBj4Z2G0unku5y7e3ky84oqg0M6cZ18atZc4TAZnOg5UFBo5CyzBqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agw1MMzK37tdvsrT6+N2L/8kHCXgsZ/PuC3QmRbyDNo=;
 b=ZAkjA3J5ML7yJKOPAfkua1+nSOU6b0koJXdQT2421n2sP1JN3EVbJ98dr+wx1fUGFeg7vuy7VjDKj/GXVRGGr7o/X/3OrIubTKuFM1w9YjS1LBaBT/2fbRBBYSOPGoUZ06P5ydLsK3Hr7WGj1v8BS0p3S+8MjpPzyNm9ukTjk26+7ZOeUqOH+PGuZfPvFzQ7StH2zEhPhb06tCz9Dq1/l+fzQFtBkQ8CL4kwD7W8pfustJPonHncsmrcS8w2HXrq+sXQaGsMZbwgnCiSgzNGY1QqFDW32vnmig3Vs/5tg65xyVROScuqR+H9ObynLbpBQp4rOTQzvkNJRtv/G2yk7A==
Received: from DM5PR12MB4663.namprd12.prod.outlook.com (2603:10b6:4:a9::26) by
 DM6PR12MB3548.namprd12.prod.outlook.com (2603:10b6:5:180::30) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.17; Mon, 13 Dec 2021 23:03:40 +0000
Received: from DM5PR12MB4663.namprd12.prod.outlook.com
 ([fe80::6c76:41c3:39fa:6931]) by DM5PR12MB4663.namprd12.prod.outlook.com
 ([fe80::6c76:41c3:39fa:6931%4]) with mapi id 15.20.4778.018; Mon, 13 Dec 2021
 23:03:40 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>, Omar
 Sandoval <osandov@fb.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 06/10] nvme/039: create authenticated connections
Thread-Topic: [PATCH 06/10] nvme/039: create authenticated connections
Thread-Index: AQHX4D/0FW4m5OORG0GJLZetJzuU7KwxKtUA
Date: Mon, 13 Dec 2021 23:03:40 +0000
Message-ID: <5a088bf6-9d13-9d40-0382-3f802e1dda7b@nvidia.com>
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
x-ms-office365-filtering-correlation-id: abb2361a-48fd-4e4a-ed25-08d9be8ccdd6
x-ms-traffictypediagnostic: DM6PR12MB3548:EE_
x-microsoft-antispam-prvs: <DM6PR12MB3548800669B5824739100B72A3749@DM6PR12MB3548.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h7w4mUGdk6gxAos4iGiQ3EDmBn9XKFmbcPH1BFmr6HRFMtQIyNuzg15Zq6XQXjuPtrcVvqaHWX0061bVv3nY+e2P/BuvXLRw+lyTq3E/qQQB1DOtBV8q9dqAzsZNXFKHRgeJvheBAlwqcgY3PBppsbtRvEeQkNF30TPdIjpmJb6EOSuZ5CdGHTPwUL5TbnSpYjCbJoFUc1zKosC1A0xo2hPn62+5bFXK4RdxQn6pBl7jcDQ66SzrEskIC69baBQut9nT0CFTXOSE0rb4LRIGhtJQ1sfdgVS10N61kYJLn7U8rdrId/8aQ7e0HEqIcxZU2lEIiUgTXSShC/LHf06WdsPgT2i+Ikwf6WFEhDfCafz/sL3fIP5A42BURj9bEz6QnZW+ncIdmOsO3w4ZXuCtKj0kAb3HNgvo2KFHQOSVdF/nHx1TrAHUZvkD329S+pBGPx8KePOAoi3oAbj/wWmZ8udC8wYoEPpk13DCpXr9LOMkovz1cM+9jN6fFH8lUf56rACLxn6uY4fhWonluAAabC0D+Jf1bkcx1/DBH7eBQPG/0lBJANCk4HKVxemlFSOUFd4QnVKSzarIjU8ILq/ZmEjThLS/gYgmkMdjAAl4txB15wPBkT/dhn8/MIwcTaCcT4/XauYFUtkxbmrxBktDlwDeYP7k5y+XOw57rUy+a7eVPx1LJMqu6spdAlYMyBlvNC1rDUx27QY1mqJJsdibd4Cn2deU4wC+5LJjnd6Zqi/siF5Dwd2AbJoSpzjk4swPDGJlVxt5lynUTKWw10yivw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB4663.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(71200400001)(66556008)(64756008)(66946007)(91956017)(66476007)(66446008)(6506007)(38070700005)(36756003)(86362001)(54906003)(508600001)(4326008)(2616005)(186003)(316002)(110136005)(76116006)(31696002)(6512007)(6486002)(31686004)(2906002)(5660300002)(122000001)(8676002)(8936002)(4744005)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d2ZWd2NtYmNXZHRhYUpOdmZTSHpmaWl0ZUR1ako2VXUwOUtQZTR5VkU0QWEw?=
 =?utf-8?B?clkyQzVxeWxlK0c4QjIxV1piaGgwblFDUDNIU216QWV6T1FZWjJCdXljenpk?=
 =?utf-8?B?VFJuQ2tJYjZNQy9RU1I0QmxFaFpyL2xPVHdqTUF4eWUwQlYvaG1kdURFK056?=
 =?utf-8?B?czVOUWs5ald6dGFpZ3V5NGVsUzA3YUpuODVaTUpZT3cwakI0clFtb0tvT1dl?=
 =?utf-8?B?SjFrUGdKRUdJWks5OWs0Q0lCWUpMZWJGeW5KVHZCUjM4eTNQQ2h3S3FId1Fj?=
 =?utf-8?B?RVAvQnAzVng2VitQMlptM2RaQ0MrS05zYTFqenZTcEFXckMwSlVZb3BrRzhK?=
 =?utf-8?B?WnE5OEwxSzAwWm1KUDhsY1ZFZzR2OUFhTFFIbHpCbCtza2k0cWNLMXc0ZGs3?=
 =?utf-8?B?WE42TEt0L25ZS1c5cWFPbk5yVXJFNE1RTTU5bGxhNWV6N2hKOXZtdCtTb2JQ?=
 =?utf-8?B?Ykd4NERrS0FJMWFtaFlObytFTmVxMmNpbVJHMHpYMGdKNWZmcG0xdUlrU2dU?=
 =?utf-8?B?eW9zWjN2NEl6VmxPcHk1bi9WT3Bta2VON2FzcUdNMGtvYnAyK05CUUUvKzUy?=
 =?utf-8?B?bnJaMW8xMlRCakF1clVaYUg5N2RtenVSSE1OTlRzMENpbDNRZ1kwRGNFVTFJ?=
 =?utf-8?B?R1ZoU2laVUIwbnpEekU4QjlocUd2WVkyWng0Y3MvL1ZoWHlYeVFRRTFLQTVK?=
 =?utf-8?B?bTQ0OUpiUGNtRTk3Rk9wVDdodUdQNHlOQ2xnTEMzeHhRVEF5YnBsMFZzWjdq?=
 =?utf-8?B?NUNSdG9lb2dCS1JmZVJ4dVlTQmFLUjBERVk2SmxZS0k3dHdFY1R1UFNmcXhX?=
 =?utf-8?B?NHFlUFBoZWVneWdsTlhmRDhSa29VZFg1T1crcUVSN3VvblVXQ0QvY1NKVHRr?=
 =?utf-8?B?Z3k2WUMwWGJyTUpxV2srNVA0Tm9keFYrTG9QQ3JzNTNwdWdZUjJxVGRKVUZ1?=
 =?utf-8?B?VWlvMjd1dmlaNFM0Wmd6VTlQMXEvTDNieHhDZmRRcENDSGZmdm1DVVBoeVZm?=
 =?utf-8?B?R1NaRWl0dXRXMXFlVys2SXlNb2sxdEZNN2RuODFYL3gwbHJ5ZWIvSWJ2cFBU?=
 =?utf-8?B?M2M2UVBkYUFhZEkvdDZhNWR1Y2paa1dsNmlkdlBTMWwrTlNoeWhGdW5aejJN?=
 =?utf-8?B?RnNORTB4bnA3UVFDWGdrME5URm1YUDNPRkZYcWhnZytyYXlxdEtYaWZSdG8x?=
 =?utf-8?B?dUdZaDBFcnBJQUIyQWVFNG9hUWpHS3d1TXJ4ZHc0c2xmN00xUzVSYlZEV2Zi?=
 =?utf-8?B?K25IRXNQOThxd25yQmNtZ0owSWZMSlhpUFc3dytKM29wLzh4RXRlc3dqY0N2?=
 =?utf-8?B?VGVzdGxQWjIrSVdCczJKQWpZTllYTW44aWRNck92K2ZzWWRMeGFMWHhXZUlv?=
 =?utf-8?B?b3NpSDJyVkk1UGo2cHc2SkNQeVBBb0wrQ0djZTlUbGFsSkNwdUk1M0JHOUtV?=
 =?utf-8?B?WjEvRThyR0lIcjN2ZWRFdWt0M3pqRFNRajVBL21USStGNUhCKy82OGFFWWtB?=
 =?utf-8?B?UVR2YWF1SVFoSDRkV3RCOXFhT2xjbnBmVEFxdnJiS2UxbzZjc0w1eHdlWmhV?=
 =?utf-8?B?YjZ2eitYc0V3ZVJuR2F4L3UyWUFuYVk3d29DeXhIczgvdUYrLzl1b0hLbEcv?=
 =?utf-8?B?MEJrejVmQllqM1U4dTBTVjFOWVEvaXRNRDJxb1lSL2xpdW1WY0lNWHIwbUs3?=
 =?utf-8?B?U3Zjd1NXZU5YeFcwQ3NPWWJUa3EyRGJlQXdneEg4ZncwRHd1YkpEYUIzS3cw?=
 =?utf-8?B?b2FkMURmRERtNlAwNVJPYjc4aUNIdExhZHBaMHBlQ1gvZGZDN283S1NIY25V?=
 =?utf-8?B?NUc2RGRaZHlQemRramtiZkNYYkszbk0wNzNHWmYrY2dXTlJJK1d6MUlOcERp?=
 =?utf-8?B?VzJZemhXRVRoblU0QWEvbmdpK3lGNExWTHFDOERNY0lFT0lScjkydHdCRDdD?=
 =?utf-8?B?NzVHVVRNMXhlclNYNC85WGQ1RWFaTzhTQzFYWWM2Q28rZnNtczFSL29oL2lt?=
 =?utf-8?B?YklJb0Y0WnFjQVVQV3pNS0NQQjN0ZUk3MDF6SEc3Y1JMOVlPamhNb3ZMaTFM?=
 =?utf-8?B?am1Fa1I4NjRKcUI2QWpEbG1ZSGJqaHYvbWtVVW0vZDNRdzN0cDZrUnl4QnVq?=
 =?utf-8?B?Nk9vc3hmTUpLU3VSa2gxd0l0Rnd5US9mci9uLzgwVHJ0OHFJeVFRWk5mTGpN?=
 =?utf-8?Q?HXCmA5pjgddEVXulSG9k5Wcc9qYHXXRVQtgPPyKYbrEn?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5E3EBAC4BB369468B5AF5D654E8CF7E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB4663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abb2361a-48fd-4e4a-ed25-08d9be8ccdd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 23:03:40.6879 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ImUIyRNNsolCa61P5nVtwbzBXMSU/pLGb/xOFU8GsXuxwVCCHr28Hb5O14oHefKzUx6qhZFCaNxCT00K4RA2xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3548
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211213_150345_384274_610347CA 
X-CRM114-Status: UNSURE (   8.36  )
X-CRM114-Notice: Please train this message.
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

PiArDQo+ICsJX252bWVfZGlzY29ubmVjdF9zdWJzeXMgIiR7c3Vic3lzfSINCj4gKw0KPiArCV9y
ZW1vdmVfbnZtZXRfc3Vic3lzdGVtX2Zyb21fcG9ydCAiJHtwb3J0fSIgIiR7c3Vic3lzfSINCj4g
KwlfcmVtb3ZlX252bWV0X3N1YnN5c3RlbSAiJHtzdWJzeXN9Ig0KPiArDQo+ICsJX3JlbW92ZV9u
dm1ldF9wb3J0ICIke3BvcnR9Ig0KPiArDQo+ICsJX3JlbW92ZV9udm1ldF9ob3N0ICIke2hvc3Ru
cW59Ig0KPiArDQo+ICsJcm0gJHtzY3JhdGNofQ0KPiArDQoNClRoZSBhYm92ZSBzZXF1ZW5jZSBp
cyBhbHNvIHdvcnRoIG1vdmluZyB0byBoZWxwZXIgaW4gbnZtZS9yYw0KdG8gYXZvaWQgdGhlIGNv
ZGUgZHVwbGljYXRpb24gaW4gYWxsIHRoZSBleGlzdGluZyBhbmQgZnV0dXJlDQp0ZXN0Y2FzZXMu
DQoNCg==

