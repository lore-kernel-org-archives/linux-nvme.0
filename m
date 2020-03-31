Return-Path: <SRS0=yNQM=5Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD24C43331
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 16:24:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D02D12071A
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 16:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JQhHyZuQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bd7bvRIM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="edULNXeF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D02D12071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=StK0fE6ZXAdlOjYiIYZ5bga2m3YUgwlIRR4luSVjJJM=; b=JQhHyZuQ4HWSAr
	eu/a2fUQOp6+f4Kuyh8ZSds9SIHdJkJhBQvQKFakGi/wA04Ok9/rHeziVEBhNQpwjy9uyq20ckgBZ
	UIelguf5Db86P/aeN8Y9XeMP2RIsaOmQfwqGR8vQlnL4iLeTtaPHPyRxJnDDa2HyTlzXBOJmBryNQ
	ei6jqdoqSLHwuAY4tPnqiUFcQ5DhGGLfgBlqC4dBd78RW7JhHlFkbrA9H4d73Ya132zelTOZnKme1
	EFVwKckd4dD56mM8xzJex77Jkx7fke7gf143v2dEwp0J6UDZMpRnfW5wTSbr7CsDtG9Trk7o8DVK8
	exy+smK563ImrePMayvg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJJgb-0003AX-Q5; Tue, 31 Mar 2020 16:24:21 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJJgZ-00038o-7E
 for linux-nvme@lists.infradead.org; Tue, 31 Mar 2020 16:24:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1585671859; x=1617207859;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=OKCO6TX+vQxZxcLORA6Tcp0LEGNQX/MDBmgVPF2gY6c=;
 b=bd7bvRIMX1s7tZAp70/+KwgLXuX1AksN3jnEEKTFbMCC1V4cmoXe5dzx
 MjM0EZlFK3E6m0qDj+5feLghCx3qO/whsYS8VgG5GIhUOC2Gmqb1N2kjx
 b08a3HeARuzXC8+zayJFWouJJF0MirdD02/3QfgERNa5t4L/Pktj1Ut0i
 WBSkbKThUtjCkVpxRHQ8bJLZ8KaQC9P7jnP6zzF+8gSD398gPp8qjb4qd
 sFUvj+hHwpjZhzk91eKOqGgEeSu9K/71BdieUUYGrFVUD6FaT+DpWUyqb
 IVq4yoWJIa2faxuitH2QyPh1ogObHTVSCxv8m3tNs3JEmChYjm+llYC8U w==;
IronPort-SDR: WyxWb+GTP4BE3jMdG2FAUQVzrEPznTLgEEAcxqvfZOaJDCyHKleAGsFouym4/I8pfjTnq9nddF
 3ApLh0UgxzcCQw4fakZ/6giHc//Vte1Ii43egq5ZQdYU3kAnEzIXu6e/oxZgvxn4e2eukJOfFL
 HFpMM9Zer405SSVlgfmkD7n+68b5K+Cmb46ENLIjMyt6fU8tikZG0ndnSJ4PlGb4FJDFLg2q9s
 b2pvwVoAZE6qjawbYPgGk/psG9l5ZTTIg7qqzzmvrAnp5rYQzdz1eff/2p0ubk99zPsIASSddF
 YlA=
X-IronPort-AV: E=Sophos;i="5.72,328,1580745600"; d="scan'208";a="242589722"
Received: from mail-sn1nam04lp2055.outbound.protection.outlook.com (HELO
 NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.55])
 by ob1.hgst.iphmx.com with ESMTP; 31 Mar 2020 22:21:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+QIS0qomuVaLQb1SnVvjxiEy2VBvU78l/wZdbUWrJwY3DAgjcgjbliBj8kfU+CCKVp29mhvy04qqkKUD0B3WMVhW6PVvICzdsvm5nqsobnWttTAxmW0sz8IVnfwbp54DHB1sly4++WK4gup63YzIgMP6ZoE9BOLwZoON7nYZTrNBpo7USAMS43s/lGUPSVWTOghWequajqS6ctIZtsdXGA3FiL4V/nTOEkJbYj/WEcGyg49rpg4GfcM31viNle7xgJrxgE0nR8rvvVVtF8GdMayrk7Re/AdKo8bQYU0ST0rq1GTNukpj9rmJdLi/V29IwUcZFOje4IE25crMEdG7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEhDFcBR27KOordqrAhYB1KKmYJN6Jm/bVfZxU3K3Eg=;
 b=fQCg852dMllX3jNXHEAbaRzcDnfdMTqemhOvVJLGVQLx193Ac6sChmMcUt11YgNZyal2tO/cUpQ+Hr9lpW2NNnvGLu252B1e6ZNuZj/oDx0lXpgINnVwafH5g3rtHMSQqWDrn7HlruIZBvBXoIk36Yq9duDWo2vUJdC+DCDbDpEIE8aQW1OXQ3HfzMyLk5VK6t6GfwXfZ3T4fZdoDgtgBaPtkLzLlEuuWqAovDZ+EnESqkWiZsyc1l7H6hLEEGoXDPgQFdevjaiMDkazOkczqy61JnlT1X3Wn0HiDZRnnK7Dys4UOgY67v65Csj9uUNjDvIIF8fAHPpJLlDzEHRwsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEhDFcBR27KOordqrAhYB1KKmYJN6Jm/bVfZxU3K3Eg=;
 b=edULNXeFwy4xWsaY+iqs9seAt+3gf5uccYVt2QsHlwBcvrn7qz+Z5y3obQ/Ev2m74FCjHenpqEYaqntwsAwYgmPdnCjOKFAB1UHAOT5g865xAF+O/DThvyg/wogW5eMzSel5M3BX/7TUck6SADC10BIWwrNrvBcMvnq3tPeJYuk=
Received: from BYAPR04MB5656.namprd04.prod.outlook.com (2603:10b6:a03:10b::31)
 by BYAPR04MB4565.namprd04.prod.outlook.com (2603:10b6:a03:5a::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Tue, 31 Mar
 2020 14:21:01 +0000
Received: from BYAPR04MB5656.namprd04.prod.outlook.com
 ([fe80::dfd:bb3a:30b1:be04]) by BYAPR04MB5656.namprd04.prod.outlook.com
 ([fe80::dfd:bb3a:30b1:be04%6]) with mapi id 15.20.2856.019; Tue, 31 Mar 2020
 14:21:01 +0000
From: Jeffrey Lien <Jeff.Lien@wdc.com>
To: linux-nvme <linux-nvme@lists.infradead.org>, Keith Busch
 <kbusch@kernel.org>
Subject: NVMe-CLI issue on Ubuntu 18.04 Kernel
Thread-Topic: NVMe-CLI issue on Ubuntu 18.04 Kernel
Thread-Index: AdYHZiVJNwMmTR1dRkSmMO/JwA4Cog==
Date: Tue, 31 Mar 2020 14:21:01 +0000
Message-ID: <BYAPR04MB5656BC5528D84371D1DECB3FEAC80@BYAPR04MB5656.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jeff.Lien@wdc.com; 
x-originating-ip: [71.37.219.233]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 17dc0c46-6ae2-48cb-5e2a-08d7d57ebd6b
x-ms-traffictypediagnostic: BYAPR04MB4565:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB45652C8FF5B143E8C840D0DDEAC80@BYAPR04MB4565.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0359162B6D
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB5656.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(366004)(136003)(39860400002)(376002)(346002)(396003)(8936002)(52536014)(26005)(186003)(71200400001)(4326008)(110136005)(86362001)(4744005)(54906003)(316002)(5660300002)(9686003)(2906002)(55016002)(81166006)(81156014)(8676002)(33656002)(76116006)(66946007)(66476007)(66556008)(64756008)(66446008)(478600001)(6506007)(7696005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pKizovbCbGYNuHoEzXsQeeE2xc5Kc0oD1M0qvMF0R5iukP4SBY1DIduaZBRd6LtndQlnxt15V9Ks+Q14e+ySxOA8CJObCSerT/dh/V0X/bh5dh68N3OcBJKWqSFQpFEPjZueAIB8rRzZiBbXkgEAjAaifRB7lTsCSWsL5DHpix5Nh7Cz9i+hVHnJMEKEFFIziy9u7bIt3HSPX5OlJd7W5VZAvt19NWwrImimJP3b76iXU+lgD6aq8bm3DCgzda5+Z0bdL2hzIvzihRyzMworSPyvoBhICafmuDGy4CgINv8cjrig5Y+BBuWKp0mAsmNzu00A9pnfPGfD0nNEEf/+PwJPLcvY5Klg7Q3BqW2Vo8ojdH+U6ChUtyUHz8Q3ShG/tg6oAklY3AgtmW4+Wq5DrftpkgDg1YMZ7aydFMTnJiPQzsjA0rAL4BNQv/4fHf/L
x-ms-exchange-antispam-messagedata: lBwBgDe5DzgMRdeRnXxd2fskThxWOkEfr2LpFm+yZXu/t5aH6bD50lGZQ2j4WvrRtsd1H2288jD6VPpjtIYZi34Jt+VEnvJAZGyHmGKeIlW9y1MNPlDL2ACAPkVL7Uq7ZGuIbMnQbXgGM/KMxkSpUQ==
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17dc0c46-6ae2-48cb-5e2a-08d7d57ebd6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2020 14:21:01.5381 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UIFSSXP2S88Gfj9dFRePa7UqcN9ELs1ga4t+BmT6u8nVy4YCjsmqWjOcTY7ajmX2fvgoNtX8qiRHfY7P0zkRxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4565
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200331_092419_288170_809B2F6A 
X-CRM114-Status: GOOD (  12.54  )
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
 Randy Bates <randall.bates@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

We are seeing the following error message when executing the "nvme list" command on Ubuntu 18.04 with the 4.15.0 kernel:
root@lmt-store-17:~/.src/nvme-cli-old# nvme list
Failed to open /sys/class/nvme-subsystem/nvme-subsys0/nvme0/address: No such file or directory

It does not seem to effect the completion of the command; it's just extra noise back from the command.  I'm not sure why the address is not present with the 4.15.0 kernel, but also not sure what it's used for by the nvme cli code.  It's referenced in the scan_ctrl function in nvme-topology.c part but I don't think it's used by any other functions.   Is it ok to just remove the reference to the address attribute in the the nvme cli code?  Or is there a better fix for this issue?

Jeff Lien
Linux Device Driver Development
Device Host Apps and Drivers
jeff.lien@wdc.com
o: 507-322-2416 (ext. 23-2416)
m: 507-273-9124







_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
