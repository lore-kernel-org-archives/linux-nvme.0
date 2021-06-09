Return-Path: <SRS0=Wy35=LD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A60CC48BCF
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jun 2021 20:48:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37A2D6054E
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jun 2021 20:48:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37A2D6054E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=8STUJPbeP1IfQfXGnIxN8P8f5ZF5EKoRPsp1xmdK/bg=; b=CISM9JFZ1HTSRU
	GIQMK5jsszHgIYB9CFrbVEQa0tB06pW6OcqTO5U/mghbyvH17J0IgluIWl3QUmCIkNXcQdrnuH7Lt
	NhrsTZrDuLsKrAxu2OV1C5P4Z0aNFoelauTf7T9qs71ttzSigrvlc5oZkuPpF3CvYUY16Ctl5SHAv
	ET2dc/CFsRrILr2cVDi7Hk1fKcBWC9jwPgPs3BhzkZk9cfzq+vobwMAxPxVcPJ2jFR79FaCLSdANG
	KoIRmy/nmBxPxh7XNCPDLNG+h3nff8ODtssdbDFKAg3sLKLLRUI30qPmCa5GERlRJrLYlSAw8T0ZJ
	pNfwjaCEWX95dDg+lhgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lr57e-00Foud-Dm; Wed, 09 Jun 2021 20:48:22 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lr57a-00FosY-1e
 for linux-nvme@lists.infradead.org; Wed, 09 Jun 2021 20:48:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623271698; x=1654807698;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=dvD++xjNVEMDX+XuSlUz7pmy8edO4ORcgdXBfU5Z4rk=;
 b=qklYpTcZDs/hxYO7Ox4Vj6LfFoFaDm6aQC/5xXoOq0JQ1wpMO+KuxfPT
 sE9yHmdWR6WQg+JY3kBdepunoYnKMEE1kbGDst14R3AJmUS2qZqe/VNCL
 d5QsTw/54iMu37AIj//vyzs5PdjbPCuo7uvvc/g+tdu3WN2XyOa5s7eIf
 GJRSwXENPKvzisKdyc21jzKolLd2fL8AxgzXjoyuxI5iyRphmWDtwo0Ba
 bU0As6lC4tnvYbl8CCPxI1ZzKh4XM2AtZ6KQgIud6JnRqptFASangT08T
 RFISKO5q5EtQzB0sSrH4Ned29LsU6q0lZHtnUaPBbJbhsH47H9rQ10zee A==;
IronPort-SDR: n7gVCieyOG6hQZ4XP/sXVu1tn2AOmyzDxWk1HjuxiosdNxK/OYLFW12ttzgHywapM+9bmvJFeS
 zmEMKAdaofTiurGOEa4vU81p26bJqX27ZXquopFineaj/RQqL2Uq8d5GgDQy/MjxyBl1e4wNkk
 kPu5Qf9Y3wnfcdm0FB8MdmCQ2iWNO80n6UbkLS6YVZpLnjXLiehZW828GXGj8vR6QwCz78vtvU
 38D33vxVgvr1KZ7e9O5onkRAPERJ14BZIrggB5b8y4nFad7Vw+jY9fbRVLe7Z74hLB+MUfn2F3
 B/U=
X-IronPort-AV: E=Sophos;i="5.83,261,1616428800"; d="scan'208";a="282785183"
Received: from mail-bn8nam11lp2171.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.171])
 by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2021 04:48:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WrKI4TPmeVBr3qiOOG73jOZP8KTuf3w/9zBZ9gROnj8GPxK3WqNONJJOLhPiDzUfqj7cXjWwPcyESTq2TAF7G2VcjgJYlcMuYnuxuf79/WBrXtblKMEVVJL4oU2hjT3S41CclvRLu2Sw7/V0JG2mt/70+ln951f4m6EfNLqQ/+prBfw3GGO65xzMQSn9qMbb50a7XaSmlo0xPNfN01QM1KVHkF8gl33ssfNfXQ/2/mZDsUblb1wTyKrFWcTB0VmPMR6sE60Ut9DVEEcGaJpTQwYYhtYD2DStPJKyWQk5YZHwMeIzshIfxuGCdahQ51jwvhszwLnzCWlTTUZ0rIz2aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqEKPl+7pcAak625+gz2OVPs8XRdoqvk9YTgZDMgcu8=;
 b=Kidh/4MwU27tt+lvZ2cEzpVTBh9gvw7nD2nRcsZjDHavcSKy8UfSqhBlydDkz3Mp7IIQrnFTW8xeOaJs2wHNbEL/AEGLjtHAbr6oeLch6DaoEYXb3mFQ846Td7VW0RzUqeaLyMvMYZEqAvgvUeeCU3OLoO8bA1YCijLL1XxNHbGile6ubudxAcePS6BnKDM0GqQrq0o3u2orRCCZLIEQo+rnuXAn6r3aXJSG2Y9RET4kowyCBphnFM/Mi96dTWnV/3J4cXZiXm+22lJnnQ2eVzGZ8rYbSFWM165kgEJ6iSYRtkLG659q3USGtO5qMx5IuqunKRNEWIDZo4onQl0MCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqEKPl+7pcAak625+gz2OVPs8XRdoqvk9YTgZDMgcu8=;
 b=xIrCt3jn5uQiI6jaCUUuUsQWH/IQWtDLxPeFp1sKRwvmz0d7vK9TE6JwqHZIu3WaB5Lw0aPxHSQdxRGB4FtbzclnzfrWtlySOdV24pkd1rQhcn+n7Dch2a29iPwnfipgbsuNyL0b5w//e1k0S/L3tNNkQ61z6tp/O68g8Bt0Z8I=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6021.namprd04.prod.outlook.com (2603:10b6:a03:e6::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Wed, 9 Jun
 2021 20:48:11 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4219.021; Wed, 9 Jun 2021
 20:48:11 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
 "james.smart@broadcom.com" <james.smart@broadcom.com>
Subject: Re: [PATCH V6] nvme-core: use xarray for ctrl ns tracking
Thread-Topic: [PATCH V6] nvme-core: use xarray for ctrl ns tracking
Thread-Index: AQHXXBAB1eC95a4h5kiXNQoT2WTT3g==
Date: Wed, 9 Jun 2021 20:48:10 +0000
Message-ID: <BYAPR04MB49657620DF9C7EA9158DB60686369@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210608024247.35286-1-chaitanya.kulkarni@wdc.com>
 <dbab5916-a6de-5cd0-4bb5-b06d0349df0b@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a91836c4-cd6f-4980-8c5b-08d92b87e4ef
x-ms-traffictypediagnostic: BYAPR04MB6021:
x-microsoft-antispam-prvs: <BYAPR04MB60213E400382FF851DB58CC686369@BYAPR04MB6021.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lUA4KDQ5TQj+XV1t64P4qVnHfUtI4ThB3cf0XnP9XerBnvmv6dOdkh4CbErmVQ+Auekj62Hueaupgg42enzog/2GV2VAGO2D8SxdYkoHs2wUPW8GGd+MCf9leCpqHe68NBtOJhBnyuCoDhTcy1YT2TY8JYdb3pBCCinjqErbb79z4zeejW4RRYKoaPg2EXPxSp/Iekqh7Y4mLAH8G1mAwkjUR0RcQ0OlzKsg+prlCdthTwLX8TLDYfFtpuUppN4iHlk7aqauGYZ/yJHhfmUHKPBy3PysHOj9Ce29WECF6uJksx/SXr0fKbdoy8JsQsO1ygw6qn/nnY2QMG4W/nVY+KM6g61QayDESwmDVg6arUJQyAhgPuvWFMXAiODQGVsUyFfTN6JI1uqxPV+ByR6AAia2TIIC+9TdJGst+QJgjlrPnjDobALko4GEWsyExhDzn5w/GAeQR4fIdQXshg40F7OJAaegFwTC5K8ZwD7TDHoZ4nkQQA7oKjVy0R/bo8co1MAvyYg7oHsSWkw9MStlciGTxP8ZeG9ljrIJKiY7x3jOe+YO2ykprq0EGgOgJ3tTSopBAHlfBvIH50F0Mxc7YvZlCkeT6wYuh+LrNP7kiUTYgULSpsoV67rwDVPLpDlY7FfQZT0sTpCikcPDkUnoctraxE7D6FEk7tIGC7ISz9eYqDS8SX5y6mblwskeE5ertqQmgrCIpLBEps1JW2nrPAhCWPcdtDT3VlUEU4ASDRQYTBicALy8A2cGJCkyoENKEMfyyfH1J6/8Aek6w37C4Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(39850400004)(136003)(366004)(54906003)(86362001)(55016002)(2906002)(71200400001)(9686003)(7696005)(52536014)(122000001)(66556008)(33656002)(966005)(478600001)(66446008)(8676002)(4326008)(6506007)(5660300002)(66946007)(76116006)(8936002)(26005)(316002)(38100700002)(53546011)(6916009)(186003)(83380400001)(64756008)(66476007)(533714002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yvPWo4rtHDFrQC9yTOXXCV4EVOqxREjMSD8dyOPs9ZzhcZxE1hjEvL7Ap3xx?=
 =?us-ascii?Q?ohxA2n1KROLg1XbVkVNudbsuj28KF3yhPNCAjZSjgJw0Ac/IVsOG0+7wK9DX?=
 =?us-ascii?Q?hTvfClBQVfwEjiSSdSBDAR6Q4FZQYvdorN/8icrEM3r6jntHPsFgzoVWqlTL?=
 =?us-ascii?Q?nb3KTdkrw1eXou2Ittg/LsI4ctNU/AwK5TPiwgdBO0kUzHfXjxlepauQFPQa?=
 =?us-ascii?Q?yg/l8v4I4yNUfJmfDnLHGrf3aHfCfK0P0tzx5Fvx1Lu7Au+p0Lh5mrbvNqoO?=
 =?us-ascii?Q?fVGaJjuaEjhmpcaz1aigYqIQoT4uIf111aJygT1/PWZfKKzMjz+u481O/BCA?=
 =?us-ascii?Q?cFfzEqt+2pIGLRgtcq3Bmw55PLqFtw80rLswedGrkB9bOgwpJ3bl7IkOLrlk?=
 =?us-ascii?Q?ub4xyqFL/Q7hKRxFv8zt/ZXkTdmeBkozGKMX/xPl+J6Ry6nBRk2Y9J5WscXh?=
 =?us-ascii?Q?ZZCDOaWU5OAluGfGSlXUAbhaVOGP1ce5PP80Vlg0WR9iMtznOeuQwcg6F7/T?=
 =?us-ascii?Q?MZE7DgdqbrslN/lPjRSzq3BNiXZoi0pYzrGUXl/P2/1hU3Es0+xZ2OtkLKI9?=
 =?us-ascii?Q?Z/kh/dxvRT1wvR1KTj9BFUmWu19/nPEWheHjT9mgk2QnrF16mzBeBTbk1q+K?=
 =?us-ascii?Q?uOEoEPZCNbWCH6GQhov0S/e3zlHPyC/HRyrkpcZw8JVrz01UbfgC8DRlX54R?=
 =?us-ascii?Q?V5R8970D0HvTSjOWS9WEaLZkfBqbJ7uWMbEpv99C1aMC00oajYXCjauGlAi5?=
 =?us-ascii?Q?vTY7wLUNTstJ26oy8whCLFhf9LGcCsHYMqF4QWXrnI1az29WblLYkMRd+v3f?=
 =?us-ascii?Q?jeiT5v3nauKDsYwncYRm+h8ojB8o4XFDHg84G5MQLJsbGLvoanKQ5e+lownp?=
 =?us-ascii?Q?/bIePjaZpPjZqAOtAEyVMAP26efpYWslVz/KnKddSc5sHN+op89Iw0ATICIS?=
 =?us-ascii?Q?9xrVQ4DVSgnj9i0Zsk1GF/OwV8Nlh7//+GGUfQW8iuJCRU6GziNcOPOeYjXH?=
 =?us-ascii?Q?ejR7p7KDIio80f3+8PnfGlE1trVbpfoA0q7ish12FJCyCePJfF377r+WcAzC?=
 =?us-ascii?Q?eSezl6eca+pahEF3cSgJP+af1aOatWdZjAQc4y/spOrtQG5V1Na2SjzswaL6?=
 =?us-ascii?Q?ZLUxtEXifTFkQDYWT7bvAhfzmIashA3ApFzbNhpTaIncJhJlzluXxtp5naJY?=
 =?us-ascii?Q?lF4gTzfRQnLgi5P2at3z42JM313L2fFQ+M06JSvexOQP39kqNQqbjdybIcFc?=
 =?us-ascii?Q?QPEzqGX3wPQceTOD6y7uG7Wmm3cxG71OOUEnPI3k3qQ+sa7xFPoURjIwqvqo?=
 =?us-ascii?Q?IihpgFtYunf6jNwVt/lSyInh?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a91836c4-cd6f-4980-8c5b-08d92b87e4ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2021 20:48:10.8990 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: szAuCr4DsqaYtmxh7EyY4W7aD1nmCpu+8WQP6/CeHiRdn4MxAfRa+fsfE6IYLIA1p3W2MLL8wmdf8FItpN8QAGl1MMlctJJ/+laHjyhqrfk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6021
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210609_134818_223788_E758D35A 
X-CRM114-Status: GOOD (  15.94  )
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

Sagi,

On 6/8/21 16:25, Sagi Grimberg wrote:
>
> On 6/7/21 7:42 PM, Chaitanya Kulkarni wrote:
>> This patch replaces the ctrl->namespaces tracking from linked list to
>> xarray for better ns-mgmt on the host side. For host side
>> nvme_find_get_ns() falls into the fast path for NVMeOF passthru target.
>> This allows us to have better performance for NVMeOF passthru backend
>> since XArray has shows better performance numbers over having
>> a combination of read-write semapore read + linked list in the
>> nvme_find_get_ns() to find namespace in I/O patch from nsid specified
>> in the nvme_rw_cmd.
>>
[...]
>> @@ -3839,6 +3829,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>>   	list_del_rcu(&ns->siblings);
>>   	mutex_unlock(&ns->ctrl->subsys->lock);
>>   
>> +	xa_erase(&ns->ctrl->namespaces, ns->head->ns_id);
>>   	synchronize_rcu(); /* guarantee not available in head->list */
>>   	nvme_mpath_clear_current_path(ns);
>>   	synchronize_srcu(&ns->head->srcu); /* wait for concurrent submissions */
>> @@ -3852,10 +3843,6 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>>   			blk_integrity_unregister(ns->disk);
>>   	}
>>   
>> -	down_write(&ns->ctrl->namespaces_rwsem);
>> -	list_del_init(&ns->list);
>> -	up_write(&ns->ctrl->namespaces_rwsem);
>> -
> Why did this change position? this sort of magic makes me scared
> of this patch...

This is to void the another call to the synchronize_rcu(),

I'll add a second call to synchronize_rcu() and keep the original
position.

>
>>   	nvme_mpath_check_last_path(ns);
>>   	nvme_put_ns(ns);
>>   }
[...]
>>   
>>   static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
>> @@ -4068,10 +4051,6 @@ static void nvme_scan_work(struct work_struct *work)
>>   	if (nvme_scan_ns_list(ctrl) != 0)
>>   		nvme_scan_ns_sequential(ctrl);
>>   	mutex_unlock(&ctrl->scan_lock);
>> -
>> -	down_write(&ctrl->namespaces_rwsem);
>> -	list_sort(NULL, &ctrl->namespaces, ns_cmp);
>> -	up_write(&ctrl->namespaces_rwsem);
> Is xarray sorted by nsid? ana updates rely on ctrl->namespaces to be
> sorted. Where is nvme_update_ana_state change anyway? you tested this
> without CONFIG_NVME_MULTIPATH?
>

Looks like CONFIG_NVME_MULTIPATH disabled in my tree currently.

I've missed the multipath.c in this version that was there in
previous version [1].

Let send out a new version.

[1] https://lists.infradead.org/pipermail/linux-nvme/2020-July/018242.html

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
