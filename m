Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45EB4C636CC
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Jan 2023 16:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H88WjK7gxg1OyEzPh9ojkxHD5fCkBvrwhYddAZMTnj8=; b=y5K5nnJbAkQJkUkT8lkX+iSju5
	RS3sJ/cL4QHyGA7B+0Z5q1hpor/alynrPVR5B4YENvMwHFz756LZYD+AeUrf85BG3RQrk6c9ekium
	KbddOZZKJUP7zDDKrtpKM6ehXlpfb3tU9ze38o/fg9g1VeQlIibLjLVT9KOaV7sWU9Nq3I1OuyDsg
	NRRDniTpj8To8tREHzXqHHJAPzxrV1zKxfGyo6sHiy5y3DejvPRC8XQMRpxuXciZ2jRhealOnnH+6
	Vt9OaO23cgSrIn0go9qCT2T031BGqbun5Mi+nbYVfHkltFGMiGGyE2+AtPleB/+jFLVzeBS4F2Awe
	Dp4WVtfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMtAD-008c0C-R7; Tue, 31 Jan 2023 16:07:17 +0000
Received: from mail-dm6nam12on2042.outbound.protection.outlook.com ([40.107.243.42] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMkZL-006VeN-Lo; Tue, 31 Jan 2023 06:56:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lluTx6DpmRToORnLbZqDR8kVqbWqTBB+d5BrB1dkVQBpD9sgjkc31YxDg2Ves/TIiZP6/faqJuboHij6s0NA1KuEAe0x3nWoxuRCi+LErR0janxpkCypRy9Pl640i1nQ95Kq6tnk7mmp/smhCA4KyZmsSi4wk5z5nISiiENV3rquvFD1vcb8TL8F8zbrYLNi4oIEHOHH3Bv1cYBCmo884+4Yj8HuP71lmKbD2azU9numMqBg6l86qyVhG25yg4DBqmo/PKR4XekFCxj4BQsOLQe4ixQvv53XiZ+snpFz7DaK39KDcEHdPGluAwbhM4972Drif10EYTV7FWU/Wi8jLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H88WjK7gxg1OyEzPh9ojkxHD5fCkBvrwhYddAZMTnj8=;
 b=dRmIFSxyKQXRX55IIRVb9iJWHvogehGIH1tjVe5W2zrK9Cy8u+GKXDiaRS31RDXrBLQbGBoTOHdbPpnJimIMm58YtXmQABAvzNfSbb84W8rrX0IBT6LjW3exV5z16JbYLD0RKTkxxKArD8J90FHGAYvHR+Eak1qORPiNNXL8+GQ9NH4+q4K1haSo3ScMv/b0Nx66OSMaTmfmnFi2YB5HF2JWHfoIgZoblL+VzbmFp08hfksAfOc0aFEBl2Npw70MUsX7115afoXHZsElWnyXxffRQH4+j+ei3dSd5e6iMSppb84A40XFbjSXEJOoVGjRrt4qIvHvsnKwngs0OG+GtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H88WjK7gxg1OyEzPh9ojkxHD5fCkBvrwhYddAZMTnj8=;
 b=jdcT0oLHVu67lFcC8ZfSGgEScHxoulA5Ig4i1QKIUnXZgLJ3X9IpkREyLi749xmLyv0FHHtyCE2KXQ6QceAaMipeXjZGukl4VFEGBMS7hD8Ds4CCatS7c5C2tiemEflCQ6YF/m82zRgD67iz9LSXfez4HiY4SVE3zm/rtNQTqOLlZAJTnCeP+SszJf7GsKJtczg5+vrHp3tk6ttHSQFhHoFIb78zuF6vBO0YfasitovbRgKAmK+l+5KjrXfQVZtLtFEAW+Rp/O7VUOJJyXEvsvN14ESz/xz53u1TDKn9VEud8waNUclyA5Eqaq3tmnPzmywiUSQgDmvdz6z+h23VGg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by IA0PR12MB7674.namprd12.prod.outlook.com (2603:10b6:208:434::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 06:56:34 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7%2]) with mapi id 15.20.6043.036; Tue, 31 Jan 2023
 06:56:34 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: Ilya Dryomov <idryomov@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, Minchan Kim <minchan@kernel.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Keith Busch <kbusch@kernel.org>, Sagi
 Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>, David Howells
	<dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, Xiubo Li
	<xiubli@redhat.com>, Steve French <sfrench@samba.org>, Trond Myklebust
	<trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, Mike
 Marshall <hubcap@omnibond.com>, Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Chuck
 Lever <chuck.lever@oracle.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>, "virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "target-devel@vger.kernel.org"
	<target-devel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-afs@lists.infradead.org" <linux-afs@lists.infradead.org>,
	"linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
	"samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"devel@lists.orangefs.org" <devel@lists.orangefs.org>,
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>
Subject: Re: [PATCH 04/23] sd: factor out a sd_set_special_bvec helper
Thread-Topic: [PATCH 04/23] sd: factor out a sd_set_special_bvec helper
Thread-Index: AQHZNIxh2Xat0SsZzEGwHzauderxe664GTWA
Date: Tue, 31 Jan 2023 06:56:34 +0000
Message-ID: <41cc9e00-8637-ff6f-77da-f9090872ccfd@nvidia.com>
References: <20230130092157.1759539-1-hch@lst.de>
 <20230130092157.1759539-5-hch@lst.de>
In-Reply-To: <20230130092157.1759539-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|IA0PR12MB7674:EE_
x-ms-office365-filtering-correlation-id: 97583506-ad17-4074-e96e-08db03584a6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  t/mZyG3u7u+xr9ZkE6HDr880c1MV7JyZoA7g3Fcq+iUymVUR1ZWgeIysrGIxPKSeFKGNwsOg/ofdlzlINmi1unmGMQbQNcMzBPOAiJdON9VGeR95ytN/hbAJVKcY5uhGamDaHTAmssNjZR46b7gy+/bTEYPfh28kk72IUgJLBIZJO6pgrVFc/AYU8xjJdur9Oi2wcAEx2o0rtUSi7wLlFDTxViVoYXnheScUJ83A9M5QlBNeYWP5GZvPYz3rTJd6xkYL0R33bk1VH6tzVf6MMAC20Re5dHcnVk/clMaf50QoQhGhp87bEGOocwoMcX7btaPzGgrXmjqxMftZ17T0UddR+e7f3jQYl2LOI3jtD3KZCM9Y9yQdcXuU3wvRrxjOpW+5rR6nSu0HL7FO4xzcUmjc+GkjCRW3JnKFjRgGtjWWoQ2L5aXETUlKG1ooDVDaPrRHW6lyNaZ0zKzrx+gWdYu40mCPw6iUdfBPuOTQpiNCyOz/wpfyS+AwNXgwJzJ4uKDrPQ/JvZ/NyGk61lz+YxSSHGVzlw9oQ7kQNi2+Q0aR15lCJ05b3q3r6bOkcRmuhiEurJd+VBx2WmJpNIg1v9xtVbmRvvPaeuL+Ml6HgUWD+5AzgGjKHUqjqfir2WGe/GcI9SDr6SQcgyG7DbpywscAfIUWKulA2O4yV6LibNXPRtllGz3o83pNNavF3EmE+CkRNnVhzxo+FWwTO9KP/G7/65y60co0v/ikGKh8llqcB9pHpQ5k/2qdbuxRlVsM
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(136003)(396003)(376002)(366004)(451199018)(4744005)(31686004)(7416002)(7406005)(5660300002)(8936002)(2906002)(41300700001)(2616005)(8676002)(38070700005)(122000001)(54906003)(66476007)(66556008)(66446008)(478600001)(36756003)(316002)(4326008)(38100700002)(6486002)(64756008)(71200400001)(110136005)(86362001)(6512007)(186003)(31696002)(53546011)(6506007)(91956017)(66946007)(76116006)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?N1RvbVE5UktjOUw1TU9iaDd0WnBFbTdFb3RJUkhHOUh6NzFTUWtld1Fqamgw?=
 =?utf-8?B?ZlgzWWR1OHlvRC9pSUluOGVzamdMcjlSOHlpUFQ0Z3dlRTVhZjBMaDh1Vy9p?=
 =?utf-8?B?b2xMWGF0NzBHNWZFVTR1U1JIeXJrdVhtZjVPM1pIdXltZXVuTUZYV1lVdHp3?=
 =?utf-8?B?UmIvQW5hTkRmNWFrSFg0YlY2MGtkYkhsSVlsRE0ySjhFTC9nNHhIVW9oeWhI?=
 =?utf-8?B?VUgzaUFKNzhaRHliUjdYRlM4dmwxR2Rjc2ZXYlUyMFJtamhxdnFhQ0phMy9U?=
 =?utf-8?B?L3RJWEpOV1kvSCtOTFZvbHo4SE5STklmYUdHdDBvNW5nL1JoVytUVFF0QmlS?=
 =?utf-8?B?bXUxREU0bUhtcnNEWGVGQTRJcGs2T1NKRVRXUmF2Y0NRbVoyOHB2eG9GNGxs?=
 =?utf-8?B?azZ4R0lUbGh6U0UwV0hmNjJySVlaZTlOMlVlMUJVcXltTklqWVcyeUpIa1Zi?=
 =?utf-8?B?dGs5aG50Zm53Rms3THNkVTVVdFFjazdnaTg3SHZYTHVyTWpVenJPSWNNcWhU?=
 =?utf-8?B?TnpFY2toaGdiMDlDZUUrT0tnV29JQnpjR1F3NVNnVUx4a2IvYnkzdUQzUXhr?=
 =?utf-8?B?bUFiZDhPWU1zVXEraWcySFl4YnpITmZTRzRUUURYRGFDOCtpWFpnKzZoRThq?=
 =?utf-8?B?RTFIWUhQOWFnR24vUjY0eFNDYW1tL3JMdDI5cFIwVnB0THFOSGZGRlU0QVhH?=
 =?utf-8?B?eTlSUnlRQmNBYTJEYnhwRzFpdFhVdXNnRFpwdUpJbzNmeHJFeTZwbXh0VWUy?=
 =?utf-8?B?T0dEMWxyaFAyUW5WRktBS00wd25EVGhOUWQ1UW9FWHBVU1hLR245WDBtd0pr?=
 =?utf-8?B?UXRkSlE3WEUwTEJqQmdmTzAzSysrL2FPTlJqeUNQQjFIY21BZzFQa3l0bmVY?=
 =?utf-8?B?Wkh3Y0FNWURGaitINURxU1NmZ24xOHJJUlVyd2tHYkVSZDdnOVcrcHNKSVpk?=
 =?utf-8?B?SWhFYW1tRUR1d1ZTT0NqcDl2Y1VvbUtPUlpWMUlBUFZLclhBOUNBOFlyaGNs?=
 =?utf-8?B?SEFtU2F2ZVhEdXlIL0tXNW90R1oyOS9vREZIL3FkWnFHM1hEVXk1YWEzaFZC?=
 =?utf-8?B?T1ZFTmRqK3lGK0pDR1hkUFBmODFrNTNNZmsyMk5yRENzYUZLMy9BVnJVRDI5?=
 =?utf-8?B?TTFkeTdodzQ1VWpJYkIzTjhNQ2tscXJkcU54bGlBVHhWalpQOTFqUXNJamV4?=
 =?utf-8?B?RGlNRGk5NnlHbDJhRWxleVpzR0kvdTRqNXFCdkZFZkpMcnEwVmVmNndVSWp1?=
 =?utf-8?B?c0ZSMEI1bitmdWZwU0VGa3luV0x6Vk9tdDdIalNmcjArZCtzdHBCUHVCOFh1?=
 =?utf-8?B?SEVIWDNvbm4yQ0tCNjVwU0R3WnFsamRHRzgzYnZLbUhwU25PdkVMT00xbjVl?=
 =?utf-8?B?RXFZeHZmU2E4TGxwWTNOaGlxc01OVDVjbWJJYTRza0tpd3RRN2lyZk1hNDJw?=
 =?utf-8?B?ZkFtYUdvWTdENXFPWmZVeU1HeW1wMnFtTmpJZHNZRk1vNWlJK21TUFAvQ1V5?=
 =?utf-8?B?TVRsQWNUYWxKd1BlNGN5aFliTlEwcmN1Z3J1ZS9DNUJSWmNTT2dNRTExakli?=
 =?utf-8?B?UG9XbFFoVWFFNEVyMnFqd2VTVXVYSlBUa3lXK1N6WVdGYmltY0s5TEcvbkZt?=
 =?utf-8?B?VkhqU0k3WVNkRW4zMFRsbXRZcG93TnUrY1lBYmVGVU1vVU1PaTNPYVdvd3FI?=
 =?utf-8?B?amJVM2Y1U0RUeFZDSVNxZTlYdlAweHI3b0Y4VkVFOVQ2SFZlbWFZRnB3ajhQ?=
 =?utf-8?B?UnVqL08zSG5PRGRxb2xxSERyOGZ0anppMzZIdkcwdmVtaFlZR2tDa3owNmI0?=
 =?utf-8?B?SUpvT1dQQ2phRG5uMUc4MWZVNDBzTjI5RFE1eHJ6bFJIR01lZDlBOUp4Z2sw?=
 =?utf-8?B?U0dIZmVHb2lEU2pYM0NJdzVtNGhTdUwyNlNFb1JsK2pnbFhucEN5U3VmODdT?=
 =?utf-8?B?WVIyd251bHJ3RHZPOE1sYUdvM2J3OU81RUhsT3hOSUpRYUFRRkU5VlpaSkVW?=
 =?utf-8?B?a1VWVTFKZGVIcDBmUVZ2SDltdWhpenhMRGxMeS9tZTB5a0VQWkJ3Q2dZMklC?=
 =?utf-8?B?Vi9naURhUFJiOEtheWpTSlVnQ3gremoyRHRIK0RnTFFLY0pKV2JvTGMrSmRL?=
 =?utf-8?B?cGhiOS9RbWVQVzFYZHJqeE9mcTZsVHJqSHUvbnJ2c0NSNW1hMTNTWHBrTE1N?=
 =?utf-8?B?eFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD4CD4D5401E8649A359621DD11EF834@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97583506-ad17-4074-e96e-08db03584a6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 06:56:34.2958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fqzk5xopkzlpZQUNQPwvfAYUeeMTa4LIFQyU2awlc9n4vWvVjS4cVDxtO9rU+YlJofwX3Mbf6GVupouiV5a9Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7674
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230130_225639_753277_FF30E6DE 
X-CRM114-Status: GOOD (  11.31  )
X-Mailman-Approved-At: Tue, 31 Jan 2023 08:07:03 -0800
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

T24gMS8zMC8yMyAwMToyMSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IEFkZCBhIGhlbHBl
ciBmb3Igc2V0dGluZyB1cCB0aGUgc3BlY2lhbF9idmVjIGluc3RlYWQgb2Ygb3BlbiBjb2Rpbmcg
aXQNCj4gaW4gdGhyZWUgcGxhY2UsIGFuZCB1c2UgdGhlIG5ldyBidmVjX3NldF9wYWdlIGhlbHBl
ciB0byBpbml0aWFsaXplDQo+IHNwZWNpYWxfdmVjLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hy
aXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IC0tLQ0KDQpNdWNoIG5lZWRlZCwgbG9va3Mg
Z29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+
DQoNCi1jaw0KDQoNCg==

