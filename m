Return-Path: <SRS0=yNQM=5Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66212C2D0F1
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 16:09:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2667321841
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 16:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fEc3OJk7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UDk5MIwB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="p42arX+7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2667321841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Bmem2azeHLLODnPYycppvvwm6hIwtBa4j+L9AlzEGu8=; b=fEc3OJk75rZ0eC
	8ua7xGfNTHbY4wREXkAXvJ6BpIDReQxj5yehPZqvWBUlJ8VQkfntkbXCWZXROj6Qnhrbnr5NoMxpo
	QOKR3cfTn1SlAqLjVlMHFdiBWD4nsJmY8F6qIKNZwI7nG91ziYXQtoA9AHBh0n1RR03hL6KQWv/7p
	KwAhC4JZ6SN5+COSYPvD3B580BlxWFKYPSkWaScoCKYeaNs52ufLcmfOdLjVDHLHI2DR4SzfuV3R0
	tMMnQsBWmLoRJGgebJbqzUHBUKF1beUUJmZGYdWLUe6wId3JkEG/Ienw/Mivpxjj5hmqQ9oX5Sf42
	YQLrjzuYOHniQmPo2seA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJJS3-0001f1-Ru; Tue, 31 Mar 2020 16:09:19 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJJS0-0001e1-Ij
 for linux-nvme@lists.infradead.org; Tue, 31 Mar 2020 16:09:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1585670956; x=1617206956;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ris5tCb7+CzN4Gm9Xvmh6PUtmVyJN/IGPmvXKY5XeTc=;
 b=UDk5MIwBRoLqoC6xds4J3kHAuaSjLs9aDNFCoP6+m01dgTP55MmlblPE
 xU/gVthd1mUElOoCRCh+MsiVNnH5jm6TWs2ZQ457LPH/4G/QXpyvwspS4
 lmuATYZLde9/wBxrwmtUFtFTywuoV/A3tbCn1qq+Yhx/v3ZiRsLc9sBwe
 vydToJXjWEoNBwBOylkQIavRsqTCZx9BrVpFj5iGstw4yGvTNIkwI76fC
 CGKmWCo/frhRMeJNTtiNT7yPE0bFjAymgV2SngiFq4+tpkA3ChZfvX+Wc
 Wq0EosyniXFqMnSPm1/c7azSjUNXWgfFMaNidPA1lfUgC+51j5hACMaQM A==;
IronPort-SDR: xnTwneYUM7nIbv6RlovKWVxTfqLDpmD0d9W8qjlcUZhLvn3WpbFcu7bYSKXc5aAJMcQNHSK0Gz
 v57Z28DkxHui7HzvZ+F5Z28Iue4Ij5LkxI4W5o83nDnTXEe5YtjixbGRZdoKkYlJktdqP1CS1o
 6rd5If0++S9RmFBTreW75BX/D4liEf4Op/NkRY4urNmEi0pdo4cjKbArf16tUAj76wU+Ryvaks
 fD57f6yx4ueweF2xn4bT4jW8Z5cCK88DWupejLWzLNI5vhZLEpZxKBcaFWMGxO8R9gCxPfGFbh
 /cw=
X-IronPort-AV: E=Sophos;i="5.72,328,1580745600"; d="scan'208";a="134467555"
Received: from mail-mw2nam10lp2103.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.103])
 by ob1.hgst.iphmx.com with ESMTP; 01 Apr 2020 00:09:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmozCaAFoQDkeqYIyr0NyE74hHAoP0G804UtzwCWZra4HbJHVx7IR9WJaRP2IeDTpOgAQd4/HT1ILzLzsg8ImNF/rl9I4UmJQZbPTs6XGnV5kv3blSdTJS0LNLjBZuQF/uQ4HYGGR7+Bi+nzVsV+XUWRHn2ovNSZoQbYjEwkH9EhDHCn4juN6M2X1aJ6UttTTLw0lHRfY+Z9/or8mQYnE/a4yYJMEDQklQHRurDC0vnatyPLkwQQlvzJ3+l7tVmFpRjLlARLCTpogf26T7g7hVHIO/+lJ7/mSZraONur7uyBJIzzmW4P51ru1ZVVVXyK5NkRpfkvTXhw0hD1Pq1+TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6N68Wgkpc46NKEmCEu5dmSNNTSNdECZcRnLZRlDmEE=;
 b=YegvcbvhOMShqDr49/xL7ZBVw9qlLFpWAzsPvIp/IMJGPdhSGD7hsJAdHZLF2IjsQzQuwKse6hLkcqyAH5VbkEqTZz3jgjug0BLm3gYcurxYGI5usJdQpGVJgwM13yKwVaJBnMiIUdBk+ybZ5o0q0LDLFSXUWqmRwpM6JhJFl1lMwakmLtQGwWUsRdZZ6jscxIwclaTEZ3PrENwoPG/DZY7OmUoV2lgTiPzGYG6yZg4XWz/Oiw8aoTd7eD4lf8O5CL8jPZ3AhnBsyWYD8AZQ++YC8w7zntc+xqFev0egmGTlIdesCshESEYN9niRw0MUTawlbOOwfee/h62WPOtkaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6N68Wgkpc46NKEmCEu5dmSNNTSNdECZcRnLZRlDmEE=;
 b=p42arX+7LpOiyXcDBi09UF1RLexDculE9+Sf0Kxo7kT8dGJyXZ8qihTG4M0m+S2JXgpr3CvBjgPR15UOv9aatenKCWA/FVc1GkIDFglGVqPycoAuJiHaWDVULLVql62cehvSYiVwddronMH7viVeBdm9DMM8/u6uk+WQRMBFPI4=
Received: from BYAPR04MB5656.namprd04.prod.outlook.com (2603:10b6:a03:10b::31)
 by BYAPR04MB4472.namprd04.prod.outlook.com (2603:10b6:a03:10::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Tue, 31 Mar
 2020 16:09:12 +0000
Received: from BYAPR04MB5656.namprd04.prod.outlook.com
 ([fe80::dfd:bb3a:30b1:be04]) by BYAPR04MB5656.namprd04.prod.outlook.com
 ([fe80::dfd:bb3a:30b1:be04%6]) with mapi id 15.20.2856.019; Tue, 31 Mar 2020
 16:09:12 +0000
From: Jeffrey Lien <Jeff.Lien@wdc.com>
To: Keith Busch <kbusch@kernel.org>
Subject: RE: NVMe-CLI issue on Ubuntu 18.04 Kernel
Thread-Topic: NVMe-CLI issue on Ubuntu 18.04 Kernel
Thread-Index: AdYHZiVJNwMmTR1dRkSmMO/JwA4CogAAxOEAAAMy7mA=
Date: Tue, 31 Mar 2020 16:09:10 +0000
Message-ID: <BYAPR04MB5656A704F3836756F70D8C77EAC80@BYAPR04MB5656.namprd04.prod.outlook.com>
References: <BYAPR04MB5656BC5528D84371D1DECB3FEAC80@BYAPR04MB5656.namprd04.prod.outlook.com>
 <20200331143236.GA30875@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20200331143236.GA30875@redsun51.ssa.fujisawa.hgst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jeff.Lien@wdc.com; 
x-originating-ip: [71.37.219.233]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b7236826-a3c2-4876-1eb4-08d7d58dda62
x-ms-traffictypediagnostic: BYAPR04MB4472:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB4472D67B213BAC64F94A0A8DEAC80@BYAPR04MB4472.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0359162B6D
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB5656.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(346002)(366004)(396003)(376002)(39860400002)(136003)(5660300002)(71200400001)(66946007)(9686003)(26005)(66556008)(8936002)(55016002)(33656002)(54906003)(186003)(81156014)(316002)(52536014)(2906002)(81166006)(8676002)(478600001)(53546011)(6916009)(7696005)(66476007)(64756008)(86362001)(66446008)(6506007)(4326008)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d4G1AmwXugqj4YwiBL2TAe+NjdJdTFgeUSgiPH0U/ydw7zQP8Z17RAbk24aQmudBIF7j5UzJiTLthQuuGwyk+ksq5LNKPIIPeY8HBPONvCRkYTC0J0617+of2WjM/I/V7TO9FejKf30C+1jA9rmoBM64aQKeTcQz6+EdsMnUVadazYI89ykjrH5cENNkMYeBYzX0DY6quJ6sGo66XqcnuIeXt9orUQF5BpF62hNITNe7RWUezVMUdQRljjvVS/4XuhMnLrjc5KhA297aijp60+Lr1dpS/iu7rG/pe8IxmNT/TH4htooBJlZVwFfqcuwZN3sdpQKLWJ+WbKCLAf2zYR9kZGeq4Vlocbnx+WZ713+kyD1h6BXbJS5IFRGvqI4QAofiYqHOiHC7JbPGFnfieVDgIEpsYM6CY3W8lrOIJb7k2AH3tv+rkXYvhFyTiA7Q
x-ms-exchange-antispam-messagedata: MVoU0PTtyFc5d5ad8/vYZmptM61dr+l98S9sUf9SrU4kkHaGztk7R30G1zFeY9PNltdi3kGdgH9gAV6BrY8HeBfsPP2yG5EAf7m8J2SWu8JH50FGamNmD+M83S/rkF/Qu8abP7yMP5m878jDLPpKoQ==
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7236826-a3c2-4876-1eb4-08d7d58dda62
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2020 16:09:10.9663 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Upb9ecu9hM+Vl7fz41eR9fOjlKpqBg+JYc50IGEZkLUbRQcRFD1xKBBkT1A9anZ/Fh0pZg202TZtG9J5lYMufw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4472
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200331_090916_650798_4BEF4166 
X-CRM114-Status: GOOD (  16.97  )
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
Cc: Kenneth Burgener <Kenneth.Burgener@wdc.com>,
 Randy Bates <randall.bates@wdc.com>,
 linux-nvme <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Sounds good Keith.   We'll make the change to the nvme cli code and submit a pull req.  


Jeff Lien

-----Original Message-----
From: Keith Busch <kbusch@kernel.org> 
Sent: Tuesday, March 31, 2020 9:33 AM
To: Jeffrey Lien <Jeff.Lien@wdc.com>
Cc: linux-nvme <linux-nvme@lists.infradead.org>; Randy Bates <randall.bates@wdc.com>; Kenneth Burgener <Kenneth.Burgener@wdc.com>
Subject: Re: NVMe-CLI issue on Ubuntu 18.04 Kernel

CAUTION: This email originated from outside of Western Digital. Do not click on links or open attachments unless you recognize the sender and know that the content is safe.


On Tue, Mar 31, 2020 at 02:21:01PM +0000, Jeffrey Lien wrote:
> We are seeing the following error message when executing the "nvme list" command on Ubuntu 18.04 with the 4.15.0 kernel:
> root@lmt-store-17:~/.src/nvme-cli-old# nvme list Failed to open 
> /sys/class/nvme-subsystem/nvme-subsys0/nvme0/address: No such file or 
> directory
>
> It does not seem to effect the completion of the command; it's just extra noise back from the command.  I'm not sure why the address is not present with the 4.15.0 kernel, but also not sure what it's used for by the nvme cli code.  It's referenced in the scan_ctrl function in nvme-topology.c part but I don't think it's used by any other functions.   Is it ok to just remove the reference to the address attribute in the the nvme cli code?  Or is there a better fix for this issue?

I think we should suppress the output in this case. We don't need the 'address' attribute, though it's nice to have.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
