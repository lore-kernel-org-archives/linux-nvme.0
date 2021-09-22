Return-Path: <SRS0=1D85=OM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E772AC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 01:32:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9838061159
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 01:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9838061159
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QGjNVte7d+BLHIIap7YHqA2qzU4IEoANdosIIuCNBd4=; b=O7Wadw38YsTrzg
	dpVxBDCRop01ylZSN8o3ZDzXqLYq2azcSAOKsafvFfSDZvmRLFsURx8/uJe+0jzQpiOBkGbNV79su
	G5oIKxHb+rCy9N2TZBrXw2FQDbDxEWAimQtWWDTOOd75T7gXgCXbBv6X3CAvVl1OsxiRnQ1w4VOlW
	zkifdm82BVp5vcLim63IWMWY0UX8B4D5lesAs35PaunNeIVBD0ATa5ee0GK04sOZs3vKj/Diz+MYX
	Fvo1bvFjGUA7L/iAi7MoDmtebjCsii/PY2WZNM9lX5RV5Fk2BhklGjc83oKWYQTeB0XHV/QMzIjcD
	fDEqdyuKXpCs15XRuyxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mSr7I-006VuY-UU; Wed, 22 Sep 2021 01:32:09 +0000
Received: from mail-mw2nam08on2088.outbound.protection.outlook.com
 ([40.107.101.88] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSr7F-006Vtm-NB
 for linux-nvme@lists.infradead.org; Wed, 22 Sep 2021 01:32:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvAI+gAtTYszhJtIRelJoTFb1x2orw/JQgGHT5iKseY43z2rMWdaYpRkbXFJ5ZbeIwAa00+kmfVucSgeu5IscbfTTuMB3CiwJxn/a/Ixh8TL/e6Gt8VKvUalPd2GLVSm25zey9BTSqp4QcQQF9bDcbsrYHTRzhUpvKc8itcVrpa5Q4BBZ/p5Ek6qUBcypeshHq7ZlHZK4IvU2FItQ2vswSorRLTI6sDV/vGJOGG1ptFkHBR0K/jGfao2Fyx5jwDc9RiAOee/vUMSQjHPdp5RqAxsBBxeK1ZyTu0wgN6kVsaCbag9zfnHVv6OcqiyzbRcRnJZ7X71DMu+n6RnDWo8rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+//7Q7hS7KUZKqWtwGxjvxtv2EANoOgjx5nFmz2lJAk=;
 b=NlkUQRrxkYHCJ5IoQv1aYEQ/d9ofD8BNJyN+cdCS2+IlpMuhVGi8Ri+YU3dCER0t/pDnNGDOowjdi7vCl7qBMZDFiXJ7h20sC0uJcVBVUfYZ/cgKLebWl3A0Iv4BYPQt4ybGMA29uHR+D9QpaJjimcvir6vdppoXC7xnl6lxwgptayQC9PNdrG2DM6M36VuPHiZg/a1QhZ1CKf2JMbCffEz0dSPs9OzEjLS13t/rN/trpkSWOHZxXj3T8WEmwflk1yOsSrmEx2hc+oLy0NJbFN/Mc8/UcKtV186vTlgYHmG3u5alto/uivMZlznXL09d1aQepsrCgdIeGpJz35D8kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+//7Q7hS7KUZKqWtwGxjvxtv2EANoOgjx5nFmz2lJAk=;
 b=Mpb6UdSftDJ/HezArEyhjhVYqkzxzZ4x5nZPvT7EJn/StTwBp4lHvXdESsBcJZ3cRyDoCWXw57f1OJbd66fpNR0iqXpOlRI28Qyr4avKtf4J2bBsu4FZejXLnDTspLH6ut2sRxkSuTfNlaod/EUUoBMus4ZhrXCA6javLITxeN8SNDmQ/nYsAvhq6bsgmPt62JkN3ngEfTFKw8lc5cHVOqU2pF4H9qI3k/sYn1QBBFPmAkZXDiJMEZoMgIDU23PQpl2NZZDBVDgOxnvr3UrCdbzfPBa5vXXHOmehTUbt1CHxC0YKcgyWvAQ4Oe1CHTwG+lk0n9Uxi8OvNtuTB+gd3Q==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW2PR12MB2571.namprd12.prod.outlook.com (2603:10b6:907:10::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.24; Wed, 22 Sep
 2021 01:32:02 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f%5]) with mapi id 15.20.4523.018; Wed, 22 Sep 2021
 01:32:02 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
CC: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 6/6] nvme: display correct subsystem NQN
Thread-Topic: [PATCH 6/6] nvme: display correct subsystem NQN
Thread-Index: AQHXrvwfwB2eXq2R7EGKSkC1wGBs0KuvRVEA
Date: Wed, 22 Sep 2021 01:32:02 +0000
Message-ID: <7adc2704-3e42-97e2-5f28-1b19d016aadf@nvidia.com>
References: <20210921151529.29419-1-hare@suse.de>
 <20210921151529.29419-7-hare@suse.de>
In-Reply-To: <20210921151529.29419-7-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15407481-52a4-4fa1-d485-08d97d68c785
x-ms-traffictypediagnostic: MW2PR12MB2571:
x-microsoft-antispam-prvs: <MW2PR12MB2571EF8C9254E207BE33A720A3A29@MW2PR12MB2571.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UDst7QgtRJbr2Hiaf3Pocv5Ede9wQjT2kKMhWvywq3yh2suchTxswpDj6T+YZSU3/EOD7K/xifzQubeRg2SksmmkQFVg3pSCSuXoO26GzsJI+m4WPGkZ5suwFkl3pUnGLtJoDZG1jF28VqjgNBWO0mtX6YQXVCGlkCKLJSPKqvhiKd0dMphACN0mYl0PqnXlb75bsigsB0n/5dB5xXsRh3Jy2oj7mILAsxQnByti6ySqafgBOBbOxJKhrj7iz0dVjPn+Rslj08yK46tlTdi5VoM77pMwyL5aKMdLfVRMFF03eWRuwxYa+Et5hDkq+An9hur+fJ7SV+hvurZqgWg3W/4tySqEkCMZy+UeUhBU361qsjlVI3JqgXVobDppAi94tETdfDkn39iS+NMvhRXQRRI1HyrcTGiTwUllo8iVrDe5eVrES8pWzDn3gE1qLmnckjc9lQvyvrc+ntoYg6SDgwk/j1FUp/zmckm69akoDalG7HnrztYh2qN8gTV++0QW7ssXPOGqkuSVB406oZLufAroa8TQANRqciZW0MEr/6YvetMngzUcrsV19qag4BFK+GEmWbI+Kh4f6/To0QZeYFLIiwSsjQmvdPtS10zaOfy3vkzdJw9lBM3sBcks5w42wD4RFvu2RWBIrp55KFAa6cgP3r8ZGuvJbVK7NbrxOd0+7uhf9yL6y/STfBRFwNfsQn/9AZeSacOjgOp4rLEnd2hxA+VA3tMz2ZkTX3J6AM5ZyV5S1lPPo4RcK/MINwJDpaHJBMW9DJjU+zXa2W0Izw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(64756008)(66476007)(76116006)(71200400001)(66446008)(66556008)(5660300002)(2906002)(8676002)(54906003)(31696002)(26005)(186003)(91956017)(6486002)(4744005)(110136005)(8936002)(53546011)(316002)(122000001)(4326008)(66946007)(38100700002)(6512007)(86362001)(36756003)(2616005)(38070700005)(6506007)(508600001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDNCNk5YVy8rYlhkRUNDaldzMVZlTXVmU1MySEtJVTdjc1A4OTd4T2JGMksr?=
 =?utf-8?B?Wnh2TE9oVm4vYUNTQzBUb3dsLy9TcnUvSTVoL2lGODV4UXZXZ2JEZWZrVEoz?=
 =?utf-8?B?UE45U2dUcGE1a3pQbU9UWWpVdlYyNm04YnhDYWZZK29ONWNpdUlrdFNxbFRR?=
 =?utf-8?B?YStKVmlZN1h3SnIrb08raVVVRkdPcUVBcVdSUm54Sy9Eck44d3BGYXJwQisy?=
 =?utf-8?B?OUk3ektvWnZIZ0MzQ3pzWHBHRnBSVU5weFJWOXVEUmttdkg2dFVNYkl1TXN3?=
 =?utf-8?B?dnA0UnNKSkZrZk5SVkoyNno3d1liNHVoZmtrRFc4K3MwVVF4U2hjYnc5U3lR?=
 =?utf-8?B?WDFkNWoyVWRWbGxlYkFCcVBRMmN2M2oyZmFsdjd5Mi96SUF1YlpDK0k0Uk9D?=
 =?utf-8?B?ODh2a3hxbGpycE55d3BCNitPYVphZlZ1K3F0OHNQbFFZUGZYd1ZiSEU5emZv?=
 =?utf-8?B?VnVIaFJ1ckdHYmVRWkwvSExTY0lYQ3BTUUVEOVBEMkxKSnJhOFluaEVmdFBP?=
 =?utf-8?B?Wkx1VWlteHpGbmpvZTI3Y2hRc0hCd1dZdzBScmVHRjEzd3RLdTE0WGZkT0wv?=
 =?utf-8?B?Wlo1WVlkSFdCeWJNTnlFWm5oQWp4eUdvNUl4c1lJT1l3RE90OTVrMUUyeE5x?=
 =?utf-8?B?TXhWQlowL095OUlaNy9tUjFXbUFkYjk0Tk1VYmJDRlFHNkJRV0xSWXhybXNk?=
 =?utf-8?B?ejVzZHZBRXNPZGtxaWJDblY5Yy92Y1ZEOUV2NGRDdk51eVRucUFFZzBsaWpw?=
 =?utf-8?B?a2xmaVpXck5ocUd5RXVHaXA4WS9nL2plUmZkQVNVQnF5Rk9KM2NkaWtPa2xZ?=
 =?utf-8?B?UTNzUHhGdDJPTTVWYUNRTVJEZWpzM25zb1ZocFVjaEZPelFVamxGblNlWUdW?=
 =?utf-8?B?aXJ0aU5IeGFhNmpVZ0dRblE3aWdwTkxVYi9HMTg5UlRuWFJMeUhES3BLRllk?=
 =?utf-8?B?V0NIeCtJTnZJTjcvNlJDOEd6ZWxvb3ZSTVg4Y3JqNGZIZDhuRmVpa2NkcDlh?=
 =?utf-8?B?UW9XUUFXTmVEaUZmV2pjZnJYOE5MSnNaWlRjWlpWaTNWNS9oV2d5Z3k4TlJO?=
 =?utf-8?B?N3NFNnNFV3lBWDFQU2JIKzZlZXZ0K3hGQkRjeW40dFNacmRJazFnNjFPODZo?=
 =?utf-8?B?dlQvQXpVc2wzK1NNMXE0Q0hOa1Ria0VhSk5sNDgvM2pobzhuVzMvS0lzS0tZ?=
 =?utf-8?B?S2FPSDNDcUVhM043cGVPUi91R2U0QjJ4dVZ6b3pnRXZwakIydHJqVVpDLzJ2?=
 =?utf-8?B?Z3g1UE4vd1QrblhKQyt2WndaK1JIRTQxU0Q2SjRvRVFGcUo2VE02djVOQ3dH?=
 =?utf-8?B?dkxIeWo4bVJkM1lKdUNkZy9IOHFjSHIyWmZwVGljWEFQaTRYVE1Ga3pacXlm?=
 =?utf-8?B?SERhM3dYM1lNMmNPb1pxVHcwYUNBT3E1cUZZOU9uLzRlOWcrUkdaeWtEbG15?=
 =?utf-8?B?SFlVSDlTL1YwUGJjK3daRkwrMzgwRDBVQkhpdTFYUmdpbmhhUDhXSzdIdGJW?=
 =?utf-8?B?Zm44UEtVU1JMOTlBUVR1aVVDcTMrRFM4dXNqQVJOWFhFbCswRGh6WkVxYTJ4?=
 =?utf-8?B?YnNYSkpJTXplaHQxc2N2Y0o3dG1IREJySjlHaTZVeCtMYzNqVVkwSEFCU1U5?=
 =?utf-8?B?QzFKc2pjQ3FUWEtrQXoyYnVuaFZIMFI5b1V5TmRhdjlRazBzQllkSnYyQWxJ?=
 =?utf-8?B?dTA3WWRxNWdWbDZqc09BeEwxOThZRkdtUmY5NFE3bE5md2JxcDdNdnlpN1No?=
 =?utf-8?Q?NK+IjUhvJ7QJ4yZRaY3iButoJTSbrca3Vvw6sba?=
x-ms-exchange-transport-forked: True
Content-ID: <AC81C1D735A2824FB1A4D5E06B20C443@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15407481-52a4-4fa1-d485-08d97d68c785
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 01:32:02.6053 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tiBYxhiUB8j3CE/wUrCsd5LmvETMy8a2wibJbGsyHDR3iwotuiz/D7c22456IaI+kGh+iHFITuxB3VxXWPw/Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2571
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210921_183205_825445_BA12C370 
X-CRM114-Status: GOOD (  11.57  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/21/21 8:15 AM, Hannes Reinecke wrote:
> With discovery controllers supporting unique subsystem NQNs the
> actual subsystem NQN might be different from that one passed in
> via the connect args. So add a helper to display the resulting
> subsystem NQN.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>


Looks good.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
