Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D406EB64D8
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jun 2023 07:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fVPmzlPhQaovvE7J/v6HLe5gE764/uaWqw3qJ4EgzvI=; b=zWx7B9G7IAk9o1shBIlYCow5Vk
	+x+aHS9V/8uLRDi4iQuX+SpmecZgEiTiZYE+vpNdbhGzOKUKv4G5qEgi22gbItR63rpeK3iTLBZn2
	u6sU1QUndFSmfdE3rTESfRGChErmIZ9UdPBVgsEgFBUHV8VuONxVdQxzsiPgWu8rG0bxtA53rfp5l
	IBo58KRCxDkYCeCjNYrmXGoQ2n+7J4AQ/94KCEzybBgTL8Nf9Cw7wTB2JVqyUndBBCar39mceYSbr
	w0mmKrBO5tZYtmhIoMi/Zgzm5VWPuKd7uCe6IkIQlZOYwI4vX4KazUvsl/0l7Ady5VPjxJwbUL8w7
	xK+ADfYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qCFE2-00HLTm-14;
	Thu, 22 Jun 2023 07:59:30 +0000
Received: from mail-co1nam11on20609.outbound.protection.outlook.com ([2a01:111:f400:7eab::609] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qCFE0-00HLSy-0J
	for linux-nvme@lists.infradead.org;
	Thu, 22 Jun 2023 07:59:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YvYXeThQaR7hTX+nOB/z9/PeQsLob/M8OGdVk7b8cbx4C2/U01unnIAfv+fJUl7Jf7t4m47GKQX/NygnxqtrB8CXB0EnhyZiJb4+8SCUqQD/TwoyQgf3nF9XNBVKfP60+Cx1sir3GxwjNQTmAVrgQd5ukVMo+DoXJTWgCIHTIhQ3urf4tvjQNk9Xm6/t4g2ajmTLWzyWm+DllapfcqqPcSk+xxGJQZXyFB3qkcEMLOYZlwT5zuB57tpvmzU0h3Cg/aoV9cdcFva/WfvMN/aKk2cIDCgsATiHaNBNhgns+WdNMkUVLhqEcejX94u4KRWB31RnT+SYenrLB+rE46bj2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVPmzlPhQaovvE7J/v6HLe5gE764/uaWqw3qJ4EgzvI=;
 b=KH/2rXJYIyWahMA4ryd9fTTIVLGe8xG/6GnzRBQlPcpu+wW8GNHrJZEWFclDFTWux5B1AyqcfjEf2qyfX7I/WX0Qf2s54ZIk41BBpg2H32QB3zk5apQK8gBaGZZIF4eKnueabC2L04av84VHzQE27or60eXBaf5sH2Xv/8ihl4qAl/nB8YyIuovn/ltKejHJWpQIMkgnQQnxCxr0/zZ6K49W3nKn/+8xq1XOSzgL8d5wWULKe0RlZVrgExmRYBIandz7PfhbVKerZCQtEzvZgbiB5016blaYcDbML41/otO77w1IVALpDnIn8hPBDOR26Rt2ZBNxtOLrwn+QJ0NUpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVPmzlPhQaovvE7J/v6HLe5gE764/uaWqw3qJ4EgzvI=;
 b=HlRKpQtX5Dd1Dt5H/K/eB1nXDMlkdWOLe3Jk444zElGMquJo8vIkwnVWA+6BqmERXvjeUHVWRk9LJBK7Tiuvx3Oxa/62IoVA3LugihF7YKLB88ng1HQHxTBjapIeJrtwt6dYj38I9VIz1BS+pzWYc/Q87au3JYSwTFu/fzkCwEEtyOsaVk9/sX6t2nrTe/h3/nLI89SfOHvcWAzsH8stp1669Nra+PzkPxwlKQABwaeZC0dgkTCTYpRw/N8MaewVG9X4Lj3CKQ3cBiNj5NEfvY6TVeLqKwyGdOM7T3wTIQ0op2UL3/gDoCZ4xynttgmPrnZkSxoRGjUAitXh66d9Zg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BL1PR12MB5287.namprd12.prod.outlook.com (2603:10b6:208:317::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 07:59:20 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6521.023; Thu, 22 Jun 2023
 07:59:20 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Damien Le Moal <dlemoal@kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: host: fix command name spelling
Thread-Topic: [PATCH] nvme: host: fix command name spelling
Thread-Index: AQHZpN6yA7Ha3nexpEii3+2AfHp7vK+WdSgA
Date: Thu, 22 Jun 2023 07:59:20 +0000
Message-ID: <dbc92de6-ca38-c09f-6d1b-e17bd95a04cd@nvidia.com>
References: <20230622075307.692950-1-dlemoal@kernel.org>
In-Reply-To: <20230622075307.692950-1-dlemoal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BL1PR12MB5287:EE_
x-ms-office365-filtering-correlation-id: faedd611-ce8f-4f1a-c54a-08db72f695d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sDMXe2QEwEnzsI7AI4dS6XxJ973apvOLgveGDpKbrfIB7lTcXVU2QLcNL6R8BAQqqgZm82dhS5MvChcsnGGoRH4+S/460YIfeV9RYk0YcBIuaJ9+gdTVEyOdRx348/JUgtRYfdbk3oKOjjpLub0Bj/Q/mMZRZgPeXj2EDaciswoWEPL0jrgBvyCL3zzIVRTmuIuUkAEOsollSaA9DEmoov9uM3nzUxuJB/cKybhAeFrDBajd/L9F7522utnxbOGC5sBJ5cBKS13E5yr9Rw/1qGiVgyUnOFAiqJju8AYCtnz6A89k82BJK6XQ+3fG0r3E8bK2AE+gXpUEmr8/TMRoLUGbEBYQMOuLy9nOqosgOOveELymWwsY2MpRvpfIeqclcet35mYhuH3dZio1mgvpVmdOfOyLqD/TQInwOo1iE0GhFhCgdpWUmSMOiPMdYAhyS1KPbXrn4x6mgywGdnnTVZuz8c2ND65y4XW48ulb7O3tR8p5H85yJQMGY9xIWR/Fm/sZi827DIWmtXU7A9dcf3n5HtLJk3CEtY5rAFqJh7W6uVDYmQ8HZU6VEC4HS2HfxVMYHoP6e15t2Pvabx4xUrQbsa+daWklSZTtIX3u+EOHyHT+R4Jjcjs6B1+B0/rN0ospciKwybT3m6iiwtA3R9P2HBjMY+aPKxIVipJulYfmUYrQ/HxvPUT9E06pR9yr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(451199021)(316002)(41300700001)(8676002)(66946007)(8936002)(66446008)(66556008)(66476007)(76116006)(64756008)(2906002)(4744005)(5660300002)(186003)(6486002)(478600001)(36756003)(71200400001)(2616005)(6512007)(6506007)(53546011)(83380400001)(91956017)(86362001)(31696002)(31686004)(122000001)(38100700002)(38070700005)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?blhwRktXdDNhZkp1VjNpWnN5ckNaeTl2RHh4WXBEUUpxVDZoVGw2L0lwOVNC?=
 =?utf-8?B?bHp5SnBIVUtndHJXUjFHaXlpQkRpTXd4RUI0TVZuS3hEZC85c29sMEFtWlZC?=
 =?utf-8?B?UHo5Nm9aNmVxWUVOVEJvUndhYU5jdzVISmRCbFNUaHpieTlac0k0V1FQVjEx?=
 =?utf-8?B?VGNoU3d5MlFZeEdobUZxbjNEblpNVG1SU09HbVpRUDlvVVZCWEFKZHVIcnVm?=
 =?utf-8?B?WVZ4bjgreXVmNlhIOVRxWHhvMlUyUzRQajFJd291MnBva0dNT1A0bnJmYkNC?=
 =?utf-8?B?RHd5UGxJNGFkdWxHZ3ZLSjUwUk53YUtiM016WisrcFZ4dThBSmowNFg1N0dF?=
 =?utf-8?B?QnlEZ2R3dFF1SFZtY2FZMkVqODlBYUlUdmY5eTVPL0hrb2FQSzArWm0rbFRq?=
 =?utf-8?B?RE4yclZ3M09WRndDTHoya09hYXNIY2VPOTRwc3lnSW8ycWExQ20zMW1GYlpv?=
 =?utf-8?B?Yml2WmszRnRDYWxvYUlBcHdZQUpWNFNnRmRzSDJvNVBKbUJZcWI5Q1h6RDdE?=
 =?utf-8?B?VzJobjgveG1iNlczMXpnVElGSjV5bVBoQUNsTEhQRisyd1pwbHBWS3FZbTZm?=
 =?utf-8?B?M0lqNjlZWGFzYlIyWC9JQkRvL0VFYzAwWEFnRmdnaFhYSmRUUUhsZ2NjcnJk?=
 =?utf-8?B?TldmcE9tTTJ4Z2J1aUptYXJ4RDJMeSs4MDEwVFhucWtRRHZobWRYMDY0eWdU?=
 =?utf-8?B?bllGdm43ZWNZSlRnWEt1SzFCdTNOM0hFT2kxQ3p4bEIweHBpQXJ6enEvbnN6?=
 =?utf-8?B?T2FQV0sxd3F4UmlwRTBrbzVOTzF4ZVA4eVJKMTNuOWRScmM0YkZVWWhIM0o1?=
 =?utf-8?B?S3VCcUVYdXlaZlJUV2s1RnUwdkVSd0xKeEgwYktVVExIclNOZ1dTMkVaMzBD?=
 =?utf-8?B?SEVTT0tDaTVMZVdRenhnbFo0TE1TazhaTktyTFR1Q1U0NFp6enZqWWRzcHFH?=
 =?utf-8?B?blRyWDlMM1ppTEc3V1pydzNkdHptSnNLby96ek9PV3BTT0xmZlljeGtOcWhy?=
 =?utf-8?B?SzBNTHZWTVBpWVVJZTVhSUpxTTRoTVgwQzVJc2MzVUlmMjgzMEV5cyttaTZY?=
 =?utf-8?B?TFhuK25FZzY1YjcxRzQ1MWV1QnRlYlg5YzN0UUtyYjNqenFkTStGMmh3RWxi?=
 =?utf-8?B?bnovVzljc1I1QWVZd0lnOUVja3F4b1JCRHFzZTYzRDlVWVBBNE1qUEVvTXZG?=
 =?utf-8?B?TzVFWlVYN3gvQ3FXYVExOXdzOU5wclNBeGNGcTdhZlg0RVY5Y1pKQldxQ0ZX?=
 =?utf-8?B?ZnkwVXVpZlRrUHZjTEdCR2dNZDVPRXJzUEY0TWlXK3hUM3dEcytJL1B0eTJi?=
 =?utf-8?B?RlNoeStOQjVoaVk2NEZnYjJMK3FvZFltaWFORjlUOVM0VFhJNmJKT1A4SVZQ?=
 =?utf-8?B?SXpVQXBpY1JxQWl3SlFrS09tdW9Nb1l3WVE2R0twWEZzbU9LaFJ2R3NvREl6?=
 =?utf-8?B?VW9DdmhkTTJOVWswRkRLcHdKV2RYUGM5c3E3dEM2QmZ4eGpkcjd6YWRPNWZY?=
 =?utf-8?B?WTlVSFZIcEl6TFRUbFVBL3lhUVZSbjFLaTdmZHM3b0pBclNZSm9tdUVqTUJm?=
 =?utf-8?B?bzdzNDlKaVJSUDRXNGhhbXBwSnQyWTNySGF6ajc0elhiZGQ0QWpDNDQ2VW9I?=
 =?utf-8?B?dHRGMlZSMHI0MFdYamt6b1N3NEFjcTgxcE5CbXpkRitUcHNicUJrdlpQa2VK?=
 =?utf-8?B?RWFnMnlMdVhXTk9IQ3VOKzhwVjB6dHZoTWM1RVg5RFdnQ05KUkJxZXBCSlpk?=
 =?utf-8?B?QWlFYmJkVlprSFZvTmN3aS9qbUsreUFtT1dvMDBnL2ZRZkRtUytEYjhjZTlZ?=
 =?utf-8?B?K203TTJjV0VTbGs3YWtlM1RBSjRpdHNVYUNnOHBYY3cwWElEbDVJb1BsUlFM?=
 =?utf-8?B?S29yUzM5RVBySEphdGhxNHlUNjRKTUZOOUtjK2RUK1FlbEJId2UvWXlpRFhi?=
 =?utf-8?B?QzE3OTZBbUpxSUFnMGFwSnp5MzEwdlpyZGRtNW5jakZPSm54cWk1UlNHTmh5?=
 =?utf-8?B?S1NYNGdKcTNYSk55dlc1Nm82RW1VK0dIZ0ZDRFZIRzl1M3R3R1VsRVZYRXpr?=
 =?utf-8?B?blJIemxOSVNhU0lVZllyTC9rM1hlbS9GWkZFT3hML01XbWFyTGZqN21zeWVZ?=
 =?utf-8?B?dHdyUithcXNkSFlDaTJZd1RGUjR0d1FMWjh4MFJCTHdNWFNneU5YSDZGeXJZ?=
 =?utf-8?Q?GITfchOV1r8efF5jdFAFcV9yJCp5YjWVCE46pwgT4dP5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <346CF09C3BDE5047BC9E39426A2B4006@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faedd611-ce8f-4f1a-c54a-08db72f695d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 07:59:20.3729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ntpdoG97ns8k7CzAptt5mCRPTyLdWGJ7XnM3K/yVM7DOPKYolNwjWKKUSuUil3dk8kCkU4u5LlWKTQKDgbsISA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5287
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230622_005928_195259_5071C366 
X-CRM114-Status: GOOD (  13.68  )
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

T24gNi8yMi8yMDIzIDEyOjUzIEFNLCBEYW1pZW4gTGUgTW9hbCB3cm90ZToNCj4gQ29ycmVjdGx5
IHNwZWxsICJaZXJvZXMiIGluIG52bWVfY21kX3dyaXRlX3plcm9lcyBjb21tYW5kIG5hbWUuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBEYW1pZW4gTGUgTW9hbCA8ZGxlbW9hbEBrZXJuZWwub3JnPg0K
PiAtLS0NCj4gICBkcml2ZXJzL252bWUvaG9zdC9jb25zdGFudHMuYyB8IDIgKy0NCj4gICAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb25zdGFudHMuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2Nv
bnN0YW50cy5jDQo+IGluZGV4IDVlNGY4ODQ4ZGNlMC4uMjBmNDZjMjMwODg1IDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL252bWUvaG9zdC9jb25zdGFudHMuYw0KPiArKysgYi9kcml2ZXJzL252bWUv
aG9zdC9jb25zdGFudHMuYw0KPiBAQCAtMTIsNyArMTIsNyBAQCBzdGF0aWMgY29uc3QgY2hhciAq
IGNvbnN0IG52bWVfb3BzW10gPSB7DQo+ICAgCVtudm1lX2NtZF9yZWFkXSA9ICJSZWFkIiwNCj4g
ICAJW252bWVfY21kX3dyaXRlX3VuY29yXSA9ICJXcml0ZSBVbmNvcnJlY3RhYmxlIiwNCj4gICAJ
W252bWVfY21kX2NvbXBhcmVdID0gIkNvbXBhcmUiLA0KPiAtCVtudm1lX2NtZF93cml0ZV96ZXJv
ZXNdID0gIldyaXRlIFplcm9zIiwNCj4gKwlbbnZtZV9jbWRfd3JpdGVfemVyb2VzXSA9ICJXcml0
ZSBaZXJvZXMiLA0KPiAgIAlbbnZtZV9jbWRfZHNtXSA9ICJEYXRhc2V0IE1hbmFnZW1lbnQiLA0K
PiAgIAlbbnZtZV9jbWRfdmVyaWZ5XSA9ICJWZXJpZnkiLA0KPiAgIAlbbnZtZV9jbWRfcmVzdl9y
ZWdpc3Rlcl0gPSAiUmVzZXJ2YXRpb24gUmVnaXN0ZXIiLA0KDQpSZXZpZXdlZC1ieTogQ2hhaXRh
bnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K

