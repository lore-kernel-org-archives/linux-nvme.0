Return-Path: <SRS0=ohfr=AA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE845C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jun 2020 17:07:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D0E720771
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jun 2020 17:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gG0kmu9h";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="k8nD34sD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="eSd3lATU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D0E720771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=W2WvEuEEhTyAt5HP2ufOh9LWJmE1umjeCPFH9ReL26o=; b=gG0kmu9hhivafI
	ClNMYGzaoZcpOlvVv6rwps5VtrtQK6+CXCJu8HsBq8Bscm7Ny5VCd1qGREYbFz816g+gRlmwbXcuu
	CWGSAPHxCT+h6LXCrDhIv09/vDaYN3TYFNJaHJJAzo2AByJnLsYcacqx/9G2suYXBmtmokwNozQi8
	q12+VkFE7MQLypAmfOdD9KfSI++zWFmXj3E+tHmhrvLZjzItY6NlATGrD5TBu3pGZK35bYl2lreAP
	2pMwH78F0iYEy0Mx4v1+8eVQ4CULaNnYbxIGBmpihdbOXkFYg1teORUInsu0+7R+/KJIhBWCtINy6
	gG2XoSRUVWY4SMn/viFQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jmKUd-0007Xm-41; Fri, 19 Jun 2020 17:07:55 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jmKUa-0007XI-U9
 for linux-nvme@lists.infradead.org; Fri, 19 Jun 2020 17:07:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592586472; x=1624122472;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=cVLmqD4Y01CAx3ogM/ykoSBMOT76Qald8lbSXRp2x3Y=;
 b=k8nD34sDz7d1hkFma4TkZtO9UzBskkV/0WeBlF8btBRfzDwTbgnk8RVH
 7fQfn58j2O1QYJ7qz7/MhS3+MZQxMYbXd5+v1fsWzMqC0JiSc/YIkYCCD
 3XMzM8b9LBiURQF6CzDKvKT4+/RY35SQLRTcXt4k3Ss0d54DvNW+ABXUn
 piWBLLNWUFeUsypHmGywpchn5/7xPlLUP//O0zcEOHeRt/iw3vOt9MOql
 s8lOVoVCTtSnUq2dmGSux7B8dbQa5ZJAHxYMoS3RbXKSdaZ1sRcZCS/Ly
 zWsq7iefq2X5wTOiji7/EttYAde2a1tnWY8PpKgmqNvT6VqY5J6JWV3++ Q==;
IronPort-SDR: zI7bkFjM/QzbeGtiPVaNxEVfUZ0lczW7R795ZVVTlSsxghDCMo90j2HpeBYfYD30kg4uuGA5YX
 RLhh1XQiylyAgzGIhOMU68bo71TT3//iqPiublXs7hmujGiMRLvj6g5YCWYj8hrDr2cC3+3Hnx
 QypYpQABvP+3S7cGLikfIQ0ohQJ2lwnJXoM+Kwcjw/QPS1YigTEHacoxmoiH11ItIzGzZEwrIk
 ft/3S2gsubWFmTo4DERToVqbUsbt583qp0s1KeuE2uqoQG2a9EFc4kqmxK5wZ2Wg1ZfGTrgJjS
 Njg=
X-IronPort-AV: E=Sophos;i="5.75,256,1589212800"; d="scan'208";a="140444407"
Received: from mail-bl2nam02lp2058.outbound.protection.outlook.com (HELO
 NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.58])
 by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2020 01:07:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOr6il99xbMBGNO8ZMYBsFFsu+fJCwMxZuUNY+qGdPqaPRc8gEV29Sn8fhGLCqpwQ+8N+d+/J6A/R4W8BP1/zZmUaFK3pQtTVLjjSdMImjG1E0LjR8ei5ba26iSy+pUko2cEW73jju51xM7xV+IteUrpV9VF/lVleSsVbrpVEQ2USMuisIOy6s53H68xB+7ajhvlcaUFDrF0IDUL4NBTTSz6201Wm6UIGSx+If6tusRM5rV5bM00bZTrqNEBjCeIsUSaYe8Vs/UhqKPrhB0FyDJ8fVfzSIZvfdGj2pS4TYRcCnugvbtBj+ss/Z76vhNL+dpSWtSvbkqSvBWSl1+wHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AoNgeSoz6AAFg5SJtT0otZ0VAF8TRB7sFSnaFtdzuK0=;
 b=ZdTYsyqxlb9aIqEItfwaynxOA3+U2H4Zv67aoYdmn8umSeNDx4yF2pZYckf8N26wzQDWxl7IUS1v0Dd1/b6Aad1U6k1X9iB1yCKGHjDM7nSAPaFoYdOk8B/YRw0B2+3IP5MRYMV37vV+iNjwyKwQyq7f0pCWDpBsL1zhZgEBkhH9okUxYAa0Oevd6qejsmHpo/JKh0IK53XIHV0j4+OsRVQlSjnjnL9MhsDdi5RrKK/9AP9xG9Pl7TOr/epjaKBmJsGocEH1zAtd2yDPMBitDf9kuKDStCQvmZhyCH6S74nLfYzsjUWZAVL/aoJoq52KQHUZOGWoG5WGtwyEIPGIYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AoNgeSoz6AAFg5SJtT0otZ0VAF8TRB7sFSnaFtdzuK0=;
 b=eSd3lATUk//MiBBnUJPH/c02z6iWybo/5n3w0S0ln51IoLduy2zCrBtBT3yuV7nm9zHmlDrOj0uMxxGnaOWlV/6TVO3E9tTZ92pardyhTSgXC1GjfYtpVALkNtA0HmcDt6PyCX+Tnv9H4OHeqa5meVh2UIL9fEXC6zhhvFFUzpM=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4039.namprd04.prod.outlook.com (2603:10b6:a02:ab::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 19 Jun
 2020 17:07:45 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3109.023; Fri, 19 Jun 2020
 17:07:45 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Jack Wang <xjtuwjp@gmail.com>
Subject: Re: [PATCH] nvme-core: use rcu in instead rw_sem
Thread-Topic: [PATCH] nvme-core: use rcu in instead rw_sem
Thread-Index: AQHWReqxAucGVgoOxUeCw5URjZqxLg==
Date: Fri, 19 Jun 2020 17:07:44 +0000
Message-ID: <BYAPR04MB4965E2E7F0C9D26CE64D55B686980@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200619033531.27819-1-chaitanya.kulkarni@wdc.com>
 <CAD+HZHX8-LV=Zt8wqXHCvduyf4AQP3T55APk=n9XmgVPG7U8Mw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 629d50ec-d357-4e2c-7678-08d8147348fc
x-ms-traffictypediagnostic: BYAPR04MB4039:
x-microsoft-antispam-prvs: <BYAPR04MB40394C7DD8028CD67242AEE586980@BYAPR04MB4039.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0439571D1D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RD21OHx3rjs1iAssCtM8pw8F7HZEIuxtyGhkIyOrEN5jmlyhg0oSlSH6UZ21lv8VySF5eCRLZs5vgVa3f4biN67A1wtE3va6x2orqx+G7AYWuWetFhjTRoK0QtUiGDGb0X/Nhmkbts9GoJmP8YQnHaGzeLP/UrjqIBfdRSx2r2lTVcE91i8LVKhrYmKJ6atB6TUQYoayfdYmkB9G1IP9cWNEUd479KzHyygWlVFopxRm40yeyzGJME8yBO1N8bpOfh1G4ng4c7T2H5n92j1WFJynsHaiehmKdUiPacuTTj3aX0yoBZqCQAdgfPwHzQMf
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(55016002)(53546011)(4326008)(6506007)(54906003)(186003)(7696005)(4744005)(8936002)(2906002)(316002)(33656002)(5660300002)(26005)(66476007)(64756008)(66946007)(66556008)(66446008)(71200400001)(8676002)(83380400001)(6916009)(9686003)(478600001)(86362001)(52536014)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 16laS0WPHX9hAE14WYwTtGj1ULyfAnzP9U509sW9xua0sfz533w82V1oCuMO5sagLJ/xg0g7dc2jHCsvd+XriziB/UcpJYwJtLeBRWR0/ogIW95P9JWBAr0TY2IOv+uU9UqavBw1bmxMl35ktZIP5wCFSldQjzDacw2tQ9eFGrn5x/oEdG3nJKa9JJuG8sxts4IBL14TQ2iucXtfIV82ZTFPaAiDre32XzYQuHmqZ9EQwsbJOGVC26pzOWKQnCnZvDTScYtzCQO0/aZQwYX13kKk91PfU6/TOl7psEDLoMfk92EhY4r7cGMo7bYcek2FCw/XwZK4cm1oahKAlQMxYEk4WUWGEyT58xCLIlI6jTFzy9ZHnPOlFu76Km7yh5ASorq9DVaezigiAdfAT3FC6Tpe7myZDpEJc/iHsdUtb95arhZXYR1yLAcoi1SVhpcbAetNkvLSVEij31sE/oPVw7d1JtaChgD6CeUXl/Ho5d8=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 629d50ec-d357-4e2c-7678-08d8147348fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2020 17:07:44.9765 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jFADHRBhjWnrlykxyxPW5riJMrhUW/MJO1zMATabiGN5dBj9SXEDTr+Yb5/kN9QSBDvILN41bBEDppF10DuFEZ+TQNfGJm7kv68mYXhKP9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4039
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200619_100753_129523_62327881 
X-CRM114-Status: UNSURE (   9.61  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 6/18/20 11:27 PM, Jack Wang wrote:
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 9491dbcfe81a..23f853d6163d 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -1376,11 +1376,11 @@ static void nvme_update_formats(struct nvme_ctrl *ctrl)
>>   {
>>          struct nvme_ns *ns;
>>
>> -       down_read(&ctrl->namespaces_rwsem);
>> +       rcu_read_lock();
>>          list_for_each_entry(ns, &ctrl->namespaces, list)
> you forgot to change this one to _rcu version, the there are a few more
Thanks alot for pointing that out, I'll add it to V2.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
