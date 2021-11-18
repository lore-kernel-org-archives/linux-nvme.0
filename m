Return-Path: <SRS0=aga3=QF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A22C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 01:53:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B68261221
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 01:53:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5B68261221
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=scVgAUbKYasETNEdPCWB7H5mhQ4MLfe8eYs3btiNE4w=; b=ApLf15aBc9/muJhAhv8NoCgoNh
	pLtHdtdAmgN/Y+X1ADJOFqky6t+57mw+fWfNM5YPYN/pwwi1zaIoar5bV8bzEbq2UiWXyQVOtZfSI
	tUCmAhhIBRdMtR3gpaL4dNSTjYrSmYYMHCoD7OOOBDQ9lD7b0VnLDe0E7iL9OshflqN1Z0U5DMANh
	DwrsmRvV8CH7aLG8ZSwjCrLcEgtK5VCYwk9TlRM6GVPAZBXZhAP7uxik4KTYgz+CT5JJ55viJemLu
	WzDp29/LJ9YYpw9UC+2Vp++ZMwm5IOdT7VsHBjjJq6IJhNoMQsLar1yCp4G6WqUpdRDBoJ+UrB3px
	vtStr1iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mnWbp-006hme-C9; Thu, 18 Nov 2021 01:53:05 +0000
Received: from mail-bn8nam11on2046.outbound.protection.outlook.com
 ([40.107.236.46] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mnWbm-006hmB-Dd
 for linux-nvme@lists.infradead.org; Thu, 18 Nov 2021 01:53:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2hJnekJ2lnrzraXh0I7mL7ZQ8+VR44evcOYovHm4as63UeYunHsLp/dOHZwIEzu9s3gNd3KslUb2qF+ASvWp8dSyFtY5cIUgFRTPptYN38pTqj2/a5+fALl+ZcjPGvGdajyPLcQ8VhKWCXC8CAIWQSVGZwf7qrFyfcz/G1wRjkGK62BSjJBTVajI5iQEmqRCncI+iHrfAAKtJHn/rOd7RHHGQXu18xUpkTeUvkIsSjm8Ozo1QFxjc9prXx1DDjVq09lRb+XZoGgdhj9FPhaa+IyC/h3Qev8TCE05WIvFHSuFhD1tTzsNN66k9L/4hGgLUzQpc05FldlqLNsUmP3pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scVgAUbKYasETNEdPCWB7H5mhQ4MLfe8eYs3btiNE4w=;
 b=jkLIQbHKlMCWrIYCtfVbR+VpPhoMDoFMir8eaQumR6GxFaRUJsPt8rLe0mEnnyW0mpKigq/9Qie+DCeZSQqJ93sLLGCTSria9Jsxl6Ci8Z56g6P5jkhKnPCEtzxebeeaziqjgHFffnYcoToipgfJUoO0nBAyrmd2brLvONHuy+LgZaeGolr1wg4PX7xz+5Z5FwpzmhwESjCxExcjSqrKkCme5DmxutE2NZv71BW+mF8wn3tbvL8V8xQ5hHBChNwNU7Gp8px/fF0Jk1BMpv2leKPoLTAfYiYG6dAs9Xt/KGLOdlFMdscnegB3Ws62jnOhiTnFSHibc+oTc2vVUjya6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scVgAUbKYasETNEdPCWB7H5mhQ4MLfe8eYs3btiNE4w=;
 b=VSA/istZfpYaE+zWtpDR6GkT0gw/Gk3Zv4Z+CloY6R8EaOjo6zESgsvfrVCN7dEpwAWNFyt1hcwFBuf+W3ZxLuR184c/zQM39+IoAFaMWEZV8IfELSHQ8Q8fZhmET/q0pIqbc5XkrBpwX1xp2ywM2DBT+X8STwxvVkqQSQJbRbfhkfFrOW/x6RdtVun2gWaICGKduSCqCWgOl9FWTpy3vo/8pY5X8AAKAbXacNt6eSbHFIOTzHsSAsoF8j5Gvv69K0ESPHBZlGhxYQUrUK9RBdbxIKSoENtKMY2qTmNsM8WG3qJVXVZ70IyuLY0tEC6WsU2kvNBUQBoAThhbFqlqqw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW3PR12MB4348.namprd12.prod.outlook.com (2603:10b6:303:5f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Thu, 18 Nov
 2021 01:52:59 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c961:59f1:3120:1798]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c961:59f1:3120:1798%4]) with mapi id 15.20.4690.027; Thu, 18 Nov 2021
 01:52:59 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "wenxiong@linux.ibm.com" <wenxiong@linux.ibm.com>,
 "anaidu.gollu@samsung.com" <anaidu.gollu@samsung.com>
CC: "keith.busch@wdc.com" <keith.busch@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hare@suse.de" <hare@suse.de>, "wenxiong@us.ibm.com" <wenxiong@us.ibm.com>
Subject: Re: [PATCH 2/5] nvme-cli: Adds event number in persistent event
 entries
Thread-Topic: [PATCH 2/5] nvme-cli: Adds event number in persistent event
 entries
Thread-Index: AQHX29nQzn3Tp6zJCUGaGvImdVdqs6wIhlOA
Date: Thu, 18 Nov 2021 01:52:59 +0000
Message-ID: <26be0e78-c45b-f129-6b43-4763550912b9@nvidia.com>
References: <1637165088-17007-1-git-send-email-wenxiong@linux.ibm.com>
 <1637165088-17007-2-git-send-email-wenxiong@linux.ibm.com>
In-Reply-To: <1637165088-17007-2-git-send-email-wenxiong@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4e0bfdd-1896-41f7-04df-08d9aa362631
x-ms-traffictypediagnostic: MW3PR12MB4348:
x-microsoft-antispam-prvs: <MW3PR12MB43482EB6CFB3795B3F9F4808A39B9@MW3PR12MB4348.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:15;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xS/5FcoM2vT/fXqnTgCjZG+imEElRVrIB0IqP2Hqn7osPyosxQ5zMekEkBkkRXSJD2DCZmoMvEX8EaSl9vGac1mAIWS9XJslWr6uhCY4HWJq5bMnaC53OWPxT+4K+ouhHwbb3P/2/uwPTNRWJ3Jd7JUuRoVWRF/q4rXTlNhOudilHpHwfZBuQRGcvD+5eIvmBLFyadI3oCv0cRgJsRLI14Qqen4/oGCE9fUsB98IIs3rdpXz2uhYxTtVgeBn/+gzLnhfEFrqAJSzcUxTCs6WfENBT0hknMOgBrf+8G1b9C9Y1Re4kaEP13PR1y8QKYUxUMoBJv6Tq4wmW9nibG7q4xtTswlDeJ8ArPjAhDZMHodwX0oaGdF6i5RdDzU1kPphlkCIXFHjVDr4QwP3YRUAQoSogHU92y5PfodHr/vtHIzq1dCWMNQpAU6mIbFqLx4ACch8TBmz+xb++pd+8RPt469YUrsj/W5KjXO3TRKYnCueYQWJUlJaSYepg9ysJLSOXvWNyvMjrxATm1Nm4CIJ9nLewGlon6QGFJn9+uiSi1Rv6os92Vj6gg69V15Wirlg/rS9insGlgK77mUgpKR1p86AeUaJGg+e1djOwMBUk1ma1bqhknXZtHF/WxUNWcGizfKyFLuFFBi0E1raip8CBo/k/14j1WL+fpe0kFtFW2GJCarC6Gs1J7jKyupfC9n9g578ALTmfwkl7obCa3z79aHrBvB/+TWpludCr98427ojOp4Y7amzF039RGtTXDd/vYO+QIHD5HwA+6KDT8sH2w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(71200400001)(2616005)(38100700002)(36756003)(31686004)(6512007)(8676002)(5660300002)(8936002)(26005)(6486002)(6506007)(122000001)(76116006)(31696002)(91956017)(508600001)(66556008)(66946007)(2906002)(64756008)(66476007)(66446008)(316002)(110136005)(54906003)(38070700005)(186003)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1BsVEUya2hYMTUyS21ydDVINEpNanFvdnlqUVRYVGdPYU5HbTErU2JrUXdW?=
 =?utf-8?B?amFnQ0tYdGdtN1U2UHNWTVovYlZYTnhVVDNnQWRvcUVwYllsZHpSdGliVkth?=
 =?utf-8?B?a05UWjdxS3JaeVpCeGJtck00UDFmVkNDRVBaWnYrdTZlTFRrbVRyVVlhMGtU?=
 =?utf-8?B?TG9FZ3Nzb1R0aGpPTEJJVTRXbmVvdnpBT0pxd3VmSVlpN3pjaWV1OG1RaFk4?=
 =?utf-8?B?VG5zOXVGU1hUQm8zbTFDaDlvWmt4N29lK0dXUEcvay9BdUdpT01hSUhlR1Bq?=
 =?utf-8?B?V0pmbFhVUyt1dnJmRngyNE9FeCtPOHRaYkhlRVZhdVV1ZjVVcThDV2VDTFBn?=
 =?utf-8?B?SU9wYjJibVlsUDhEWUduU0ZUSC9WMFFiWFhqdFBVdjg5MzBKTkFJdmlwbmt3?=
 =?utf-8?B?VU1hRXJFK3hmcnJ0UU1MNUJERERVY2hobVdleVJ1L0k2RkpMeCt5RWl2cG84?=
 =?utf-8?B?ajNoUXozSm9hQ2o4aG82QWtaT3RmdTlvODltaWN5bEVueHJzUVExU2p1ZXQ5?=
 =?utf-8?B?ZEp1YzQ1a1VIMlhWMDZ6cmp4ZFVnT3BPZkxtYUpHSTUrV0NINUx5Wml3MFZI?=
 =?utf-8?B?c0gvMHFNYkg1dTVSQXVNdkROS1gxRXJMNVBVL21mUkt1NU50V1RqUkpSMlNM?=
 =?utf-8?B?R1hvU2R0NGpKNXlUNnlPcVRtUVNjRDVYREZqTUtQVWVWZ3RXVnpjTEpZQ2ty?=
 =?utf-8?B?MHpWbHpWRUtNeXI3OU5Sa0hxZzJTM3Zsa2VXZVR0WEpwUkcwR1VycmNBQTg1?=
 =?utf-8?B?RG1VZ0VoU3R4dnNueXhReVFaRTNxU0Yvc3NuUzlKTmFxQXNoUE5jUEo0M3dC?=
 =?utf-8?B?YVVWSXdZMVE3QTY2aUtpQmNaRnFsQ0lqZ2NQSkl0SjBoZHY5MVJoSjJGVFdh?=
 =?utf-8?B?ajg1OUNKbXdGRTlhK3QxMkQrKzU1MTA4ei8rYy9MWkREdnJwekdQS29lVy80?=
 =?utf-8?B?cG5vRGdDaWZLUGtwSW55NHNkT1Z2VGdDQTNkaUpTMWNHb3U4SWQreVZKbUto?=
 =?utf-8?B?S3ZZNDhUbm8rN3VkSDJOVEY4ajgzaG00aHJta1BQaDB5d3RKZUZqRnNPS2Mr?=
 =?utf-8?B?SlhIdGJpZlN0d1pVdGEzc2J0MGJCQjc4b2xuVUpYM0hHdWJmQm9QSnZZZWZu?=
 =?utf-8?B?ZDZWL3pxR2MxM253ZFFkSnlPeGxkNmREcWJCQW5TVVNsSTVxQWxRMStxRTRV?=
 =?utf-8?B?UGxTVVB5NDVNOTdmUERkb2c1SlI5aVBOUm9UdDRaY0M2am9iem9QT2YrRzQw?=
 =?utf-8?B?cE1McnF6bWRQZUpDbFBZVHN1ZnBlSytCZ0ZOY0hjNy9YTVMrV3Bqb0MvamVs?=
 =?utf-8?B?bDdEdDdKNzFlbFVnR29tRkxNMURyU2xjNHBJWjJTSVRRbktkNGFVUnk3QUt1?=
 =?utf-8?B?WmFMS1JHWFlPdE5Bckp1QUx4S0FFOVg1VFkwRlB2eGVTcytienpTM3NoUUFD?=
 =?utf-8?B?Ny9QQ1VtcnEvb1NLQnJsTjVKRmhGcVl5NXphUVVBVE03Y1liL0VsWVBIeGFB?=
 =?utf-8?B?UG8vZElRNHlPMnhVL2k5RE9IbVR5elFPVENHTWZBa2k0amYrTkFwNWtGQWhG?=
 =?utf-8?B?d083aUVXVHMyMTVwWHVNRHBQT0wyZlkzNnRJeE8zRk41cTg1eWhyd0Fua2NI?=
 =?utf-8?B?QjAyMDlwOXk0S2o4a2FNek54YTNqZGtwVFFVR2NtNk13Y0k2cE5FTzVIOEdt?=
 =?utf-8?B?VDZrOERkTU1DRDd1bEtRbGQ0S2pSYnJrdzAwb2xsVGN0VlRNU08vVmdhTFJy?=
 =?utf-8?B?YnNrQXBjbDY1RENNNjMraEZ5YjJ0bloyVDFCOUxDT0U1WjNpakRieGRsK2ha?=
 =?utf-8?B?NW5SQ3RYZXpwTDhCNytHTExkeWVaem9kUEcvUDkzT091M29lZVgvVXY2SUNY?=
 =?utf-8?B?WSs4NU8zYVFuRVdEREZmVG5VTVFUVDlLa1R2Qk96Wlpzc1YrYUVaUUZOUDNX?=
 =?utf-8?B?MkVMN1UrSEV6c3MyaVhVY1lYaytoUjBYQ3pSS2ZaWFFySG1ramtUNmw0bDNN?=
 =?utf-8?B?K09SMVh6dHF5SmJ1U2RGeG9BSDRhVEEyRnBzY05EZTg2SStYWHl3VW1qdGJR?=
 =?utf-8?B?RXZpOEdzZ1lZbTFJZDc4ZHBHeHZiYnpMTGF0RElZK2hJWjMrUXQrbXBmeXVQ?=
 =?utf-8?B?cFNlSDYzT3JmUXhJWGxoNmZkenZEQkV6Qy9RUERIc092SzJXY3ZnWGhlNXpp?=
 =?utf-8?B?Z1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2DEE525A272A6D4EAD755E2DC620D7C3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4e0bfdd-1896-41f7-04df-08d9aa362631
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2021 01:52:59.3769 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6MMpaf37SOJfKNshyNrvJ4Y8s8JxOgxxQ5rAStcy4z4npRbcVVPFR8rBRFAHV0WpvSlhOyvzhc/aSNSXX3WGyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4348
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211117_175302_553798_8915696A 
X-CRM114-Status: GOOD (  10.32  )
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

DQo+IEBAIC0xNTUyLDEyICsxNTUzLDEyIEBAIHZvaWQgbnZtZV9zaG93X3BlcnNpc3RlbnRfZXZl
bnRfbG9nKHZvaWQgKnBldmVudF9sb2dfaW5mbywNCj4gICAJCXN3aXRjaCAocGV2ZW50X2VudHJ5
X2hlYWQtPmV0eXBlKSB7DQo+ICAgCQljYXNlIE5WTUVfUEVMX1NNQVJUX0hFQUxUSF9FVkVOVDoN
Cj4gICAJCQlzbWFydF9ldmVudCA9IHBldmVudF9sb2dfaW5mbyArIG9mZnNldDsNCj4gLQkJCXBy
aW50ZigiU21hcnQgSGVhbHRoIEV2ZW50OiBcbiIpOw0KPiArCQkJcHJpbnRmKCJTbWFydCBIZWFs
dGggRXZlbnQgRW50cnk6IFxuIik7DQoNCm9yaWdpbmFsIHN0cmluZyBpcyBmaW5lLCB3aHkgZG8g
d2UgbmVlZCB0byBjaGFuZ2UgaXQgPw0KDQo+ICAgCQkJbnZtZV9zaG93X3NtYXJ0X2xvZyhzbWFy
dF9ldmVudCwgTlZNRV9OU0lEX0FMTCwgZGV2bmFtZSwgZmxhZ3MpOw0KPiAgIAkJCWJyZWFrOw0K
PiAgIAkJY2FzZSBOVk1FX1BFTF9GV19DT01NSVRfRVZFTlQ6DQo+ICAgCQkJZndfY29tbWl0X2V2
ZW50ID0gcGV2ZW50X2xvZ19pbmZvICsgb2Zmc2V0Ow0KPiAtCQkJcHJpbnRmKCJGVyBDb21taXQg
RXZlbnQ6IFxuIik7DQo+ICsJCQlwcmludGYoIkZXIENvbW1pdCBFdmVudCBFbnRyeTogXG4iKTsN
Cj4gICAJCQlwcmludGYoIk9sZCBGaXJtd2FyZSBSZXZpc2lvbjogJSJQUkl1NjQiXG4iLA0KPiAg
IAkJCQlsZTY0X3RvX2NwdShmd19jb21taXRfZXZlbnQtPm9sZF9md19yZXYpKTsNCj4gICAJCQlw
cmludGYoIk5ldyBGaXJtd2FyZSBSZXZpc2lvbjogJSJQUkl1NjQiXG4iLA0KPiBAQCAtMTU3NCw3
ICsxNTc1LDcgQEAgdm9pZCBudm1lX3Nob3dfcGVyc2lzdGVudF9ldmVudF9sb2codm9pZCAqcGV2
ZW50X2xvZ19pbmZvLA0KPiAgIAkJCWJyZWFrOw0KPiAgIAkJY2FzZSBOVk1FX1BFTF9USU1FU1RB
TVBfRVZFTlQ6DQo+ICAgCQkJdHNfY2hhbmdlX2V2ZW50ID0gcGV2ZW50X2xvZ19pbmZvICsgb2Zm
c2V0Ow0KPiAtCQkJcHJpbnRmKCJUaW1lIFN0YW1wIENoYW5nZSBFdmVudDogXG4iKTsNCj4gKwkJ
CXByaW50ZigiVGltZSBTdGFtcCBDaGFuZ2UgRXZlbnQgRW50cnk6IFxuIik7DQoNCnNhbWUgY29t
bWVudCBhcyBhYm92ZQ0KDQo+ICAgCQkJcHJpbnRmKCJQcmV2aW91cyBUaW1lc3RhbXA6ICUiUFJJ
dTY0IlxuIiwNCj4gICAJCQkJbGU2NF90b19jcHUodHNfY2hhbmdlX2V2ZW50LT5wcmV2aW91c190
aW1lc3RhbXApKTsNCj4gICAJCQlwcmludGYoIk1pbGxpc2Vjb25kcyBTaW5jZSBSZXNldDogJSJQ
Ukl1NjQiXG4iLA0KPiBAQCAtMTU4Niw3ICsxNTg3LDcgQEAgdm9pZCBudm1lX3Nob3dfcGVyc2lz
dGVudF9ldmVudF9sb2codm9pZCAqcGV2ZW50X2xvZ19pbmZvLA0KPiAgIA0KPiAgIAkJCXBvcl9p
bmZvX2xpc3QgPSBwb3JfaW5mb19sZW4gLyBzaXplb2YoKnBvcl9ldmVudCk7DQo+ICAgDQo+IC0J
CQlwcmludGYoIlBvd2VyIE9uIFJlc2V0IEV2ZW50OiBcbiIpOw0KPiArCQkJcHJpbnRmKCJQb3dl
ciBPbiBSZXNldCBFdmVudCBFbnRyeTogXG4iKTsNCg0Kc2FtZSBjb21tZW50IGFzIGFib3ZlDQoN
Cj4gICAJCQlmd19yZXYgPSBwZXZlbnRfbG9nX2luZm8gKyBvZmZzZXQ7DQo+ICAgCQkJcHJpbnRm
KCJGaXJtd2FyZSBSZXZpc2lvbjogJSJQUkl1NjQiXG4iLCBsZTY0X3RvX2NwdSgqZndfcmV2KSk7
DQo+ICAgCQkJcHJpbnRmKCJSZXNldCBJbmZvcm1hdGlvbiBMaXN0OiBcbiIpOw0KPiBAQCAtMTYw
OSwxMyArMTYxMCwxMyBAQCB2b2lkIG52bWVfc2hvd19wZXJzaXN0ZW50X2V2ZW50X2xvZyh2b2lk
ICpwZXZlbnRfbG9nX2luZm8sDQo+ICAgCQkJYnJlYWs7DQo+ICAgCQljYXNlIE5WTUVfUEVMX05T
U19IV19FUlJPUl9FVkVOVDoNCj4gICAJCQluc3NfaHdfZXJyX2V2ZW50ID0gcGV2ZW50X2xvZ19p
bmZvICsgb2Zmc2V0Ow0KPiAtCQkJcHJpbnRmKCJOVk0gU3Vic3lzdGVtIEhhcmR3YXJlIEVycm9y
IEV2ZW50IENvZGU6ICV1LCAlc1xuIiwNCj4gKwkJCXByaW50ZigiTlZNIFN1YnN5c3RlbSBIYXJk
d2FyZSBFcnJvciBFdmVudCBDb2RlIEVudHJ5OiAldSwgJXNcbiIsDQoNCnNhbWUgY29tbWVudCBh
cyBhYm92ZQ0KDQo+ICAgCQkJCWxlMTZfdG9fY3B1KG5zc19od19lcnJfZXZlbnQtPm5zc19od19l
cnJfZXZlbnRfY29kZSksDQo+ICAgCQkJCW52bWVfc2hvd19uc3NfaHdfZXJyb3IobnNzX2h3X2Vy
cl9ldmVudC0+bnNzX2h3X2Vycl9ldmVudF9jb2RlKSk7DQo+ICAgCQkJYnJlYWs7DQo+ICAgCQlj
YXNlIE5WTUVfUEVMX0NIQU5HRV9OU19FVkVOVDoNCj4gICAJCQluc19ldmVudCA9IHBldmVudF9s
b2dfaW5mbyArIG9mZnNldDsNCj4gLQkJCXByaW50ZigiQ2hhbmdlIE5hbWVzcGFjZSBFdmVudDog
XG4iKTsNCj4gKwkJCXByaW50ZigiQ2hhbmdlIE5hbWVzcGFjZSBFdmVudCBFbnRyeTogXG4iKTsN
Cg0Kc2FtZSBjb21tZW50IGFzIGFib3ZlDQoNCj4gICAJCQlwcmludGYoIk5hbWVzcGFjZSBNYW5h
Z2VtZW50IENEVzEwOiAldVxuIiwNCj4gICAJCQkJbGUzMl90b19jcHUobnNfZXZlbnQtPm5zbWd0
X2NkdzEwKSk7DQo+ICAgCQkJcHJpbnRmKCJOYW1lc3BhY2UgU2l6ZTogJSJQUkl1NjQiXG4iLA0K
PiBAQCAtMTYzNCw3ICsxNjM1LDcgQEAgdm9pZCBudm1lX3Nob3dfcGVyc2lzdGVudF9ldmVudF9s
b2codm9pZCAqcGV2ZW50X2xvZ19pbmZvLA0KPiAgIAkJCWJyZWFrOw0KPiAgIAkJY2FzZSBOVk1F
X1BFTF9GT1JNQVRfU1RBUlRfRVZFTlQ6DQo+ICAgCQkJZm9ybWF0X3N0YXJ0X2V2ZW50ID0gcGV2
ZW50X2xvZ19pbmZvICsgb2Zmc2V0Ow0KPiAtCQkJcHJpbnRmKCJGb3JtYXQgTlZNIFN0YXJ0IEV2
ZW50OiBcbiIpOw0KPiArCQkJcHJpbnRmKCJGb3JtYXQgTlZNIFN0YXJ0IEV2ZW50IEVudHJ5OiBc
biIpOw0KDQpzYW1lIGNvbW1lbnQgYXMgYWJvdmUNCg0KPiAgIAkJCXByaW50ZigiTmFtZXNwYWNl
IElkZW50aWZpZXI6ICV1XG4iLA0KPiAgIAkJCQlsZTMyX3RvX2NwdShmb3JtYXRfc3RhcnRfZXZl
bnQtPm5zaWQpKTsNCj4gICAJCQlwcmludGYoIkZvcm1hdCBOVk0gQXR0cmlidXRlczogJXVcbiIs
DQo+IEBAIC0xNjQ0LDcgKzE2NDUsNyBAQCB2b2lkIG52bWVfc2hvd19wZXJzaXN0ZW50X2V2ZW50
X2xvZyh2b2lkICpwZXZlbnRfbG9nX2luZm8sDQo+ICAgCQkJYnJlYWs7DQo+ICAgCQljYXNlIE5W
TUVfUEVMX0ZPUk1BVF9DT01QTEVUSU9OX0VWRU5UOg0KPiAgIAkJCWZvcm1hdF9jbXBsbl9ldmVu
dCA9IHBldmVudF9sb2dfaW5mbyArIG9mZnNldDsNCj4gLQkJCXByaW50ZigiRm9ybWF0IE5WTSBD
b21wbGV0aW9uIEV2ZW50OiBcbiIpOw0KPiArCQkJcHJpbnRmKCJGb3JtYXQgTlZNIENvbXBsZXRp
b24gRXZlbnQgRW50cnk6IFxuIik7DQo+ICAgCQkJcHJpbnRmKCJOYW1lc3BhY2UgSWRlbnRpZmll
cjogJXVcbiIsDQo+ICAgCQkJCWxlMzJfdG9fY3B1KGZvcm1hdF9jbXBsbl9ldmVudC0+bnNpZCkp
Ow0KPiAgIAkJCXByaW50ZigiU21hbGxlc3QgRm9ybWF0IFByb2dyZXNzIEluZGljYXRvcjogJXVc
biIsDQo+IEBAIC0xNjU4LDcgKzE2NTksNyBAQCB2b2lkIG52bWVfc2hvd19wZXJzaXN0ZW50X2V2
ZW50X2xvZyh2b2lkICpwZXZlbnRfbG9nX2luZm8sDQo+ICAgCQkJYnJlYWs7DQo+ICAgCQljYXNl
IE5WTUVfUEVMX1NBTklUSVpFX1NUQVJUX0VWRU5UOg0KPiAgIAkJCXNhbml0aXplX3N0YXJ0X2V2
ZW50ID0gcGV2ZW50X2xvZ19pbmZvICsgb2Zmc2V0Ow0KPiAtCQkJcHJpbnRmKCJTYW5pdGl6ZSBT
dGFydCBFdmVudDogXG4iKTsNCj4gKwkJCXByaW50ZigiU2FuaXRpemUgU3RhcnQgRXZlbnQgRW50
cnk6IFxuIik7DQo+ICAgCQkJcHJpbnRmKCJTQU5JQ0FQOiAldVxuIiwgc2FuaXRpemVfc3RhcnRf
ZXZlbnQtPnNhbmlfY2FwKTsNCj4gICAJCQlwcmludGYoIlNhbml0aXplIENEVzEwOiAldVxuIiwN
Cj4gICAJCQkJbGUzMl90b19jcHUoc2FuaXRpemVfc3RhcnRfZXZlbnQtPnNhbmlfY2R3MTApKTsN
Cj4gQEAgLTE2NjcsNyArMTY2OCw3IEBAIHZvaWQgbnZtZV9zaG93X3BlcnNpc3RlbnRfZXZlbnRf
bG9nKHZvaWQgKnBldmVudF9sb2dfaW5mbywNCj4gICAJCQlicmVhazsNCj4gICAJCWNhc2UgTlZN
RV9QRUxfU0FOSVRJWkVfQ09NUExFVElPTl9FVkVOVDoNCj4gICAJCQlzYW5pdGl6ZV9jbXBsbl9l
dmVudCA9IHBldmVudF9sb2dfaW5mbyArIG9mZnNldDsNCj4gLQkJCXByaW50ZigiU2FuaXRpemUg
Q29tcGxldGlvbiBFdmVudDogXG4iKTsNCj4gKwkJCXByaW50ZigiU2FuaXRpemUgQ29tcGxldGlv
biBFdmVudCBFbnRyeTogXG4iKTsNCj4gICAJCQlwcmludGYoIlNhbml0aXplIFByb2dyZXNzOiAl
dVxuIiwNCj4gICAJCQkJbGUxNl90b19jcHUoc2FuaXRpemVfY21wbG5fZXZlbnQtPnNhbmlfcHJv
ZykpOw0KPiAgIAkJCXByaW50ZigiU2FuaXRpemUgU3RhdHVzOiAldVxuIiwNCj4gQEAgLTE2Nzcs
NyArMTY3OCw3IEBAIHZvaWQgbnZtZV9zaG93X3BlcnNpc3RlbnRfZXZlbnRfbG9nKHZvaWQgKnBl
dmVudF9sb2dfaW5mbywNCj4gICAJCQlicmVhazsNCj4gICAJCWNhc2UgTlZNRV9QRUxfVEhFUk1B
TF9FWENVUlNJT05fRVZFTlQ6DQo+ICAgCQkJdGhlcm1hbF9leGNfZXZlbnQgPSBwZXZlbnRfbG9n
X2luZm8gKyBvZmZzZXQ7DQo+IC0JCQlwcmludGYoIlRoZXJtYWwgRXhjdXJzaW9uIEV2ZW50OiBc
biIpOw0KPiArCQkJcHJpbnRmKCJUaGVybWFsIEV4Y3Vyc2lvbiBFdmVudCBFbnRyeTogXG4iKTsN
Cj4gICAJCQlwcmludGYoIk92ZXIgVGVtcGVyYXR1cmU6ICV1XG4iLCB0aGVybWFsX2V4Y19ldmVu
dC0+b3Zlcl90ZW1wKTsNCj4gICAJCQlwcmludGYoIlRocmVzaG9sZDogJXVcbiIsIHRoZXJtYWxf
ZXhjX2V2ZW50LT50aHJlc2hvbGQpOw0KPiAgIAkJCWJyZWFrOw0KPiANCg==

