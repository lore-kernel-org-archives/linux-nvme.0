Return-Path: <SRS0=aggL=35=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04FEC2BA83
	for <linux-nvme@archiver.kernel.org>; Sun,  9 Feb 2020 23:55:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7981420578
	for <linux-nvme@archiver.kernel.org>; Sun,  9 Feb 2020 23:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tpf829sw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QmNe/zq1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ulbt/6sq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7981420578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=e01AtmvyzlwCqfL6JThhn598GuonGTg4jom1KvgrWJs=; b=tpf829sw/l6NjN
	8KPDXaFixzUlSARHCjxmFTsjlHP8yq1at5Cu0F2fx6jv9u62Tl4A94VG4Awr1A9KuvJvT9zHjpXon
	B5gj/lurRB7gRqdVAKNy65IIZ3X9jvwVPFIGCJkwcsuEgXcMZkoeRqNpT3zetg9rs7T15Ve/bjBjG
	PfnRkuv5shMZzMhHGKPsxyfcWOVou/NtSGBcZfD+/8XAB2AKqVR4Ez5WSdL8DlyxnqzewsVqHfItZ
	80r784C4VbCAog/WlzrG+Ax1ckYXmr7Z2NlveeNIiZhoI7hJqoygXKuIzlAujOfS78hXjP9k0htOl
	N3oD5rU5bLEbLqw2/aew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j0wQT-0003H7-Cm; Sun, 09 Feb 2020 23:55:45 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j0wQO-0003Gc-LU
 for linux-nvme@lists.infradead.org; Sun, 09 Feb 2020 23:55:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1581292540; x=1612828540;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=WfFh5m7xacj8ojGIFA8K+WLYNR+8hdF8YbvAyaBPbxc=;
 b=QmNe/zq1bYIMl6XW5lZ/IyjFTLjsQnslCHAzfJ1xwQxDyTByI5fYHDHO
 91nm4wPmWgRgBfRoeNcGFTa6tbRghVMFItzOL8gigPovYVObDGahLhxZy
 juwK9zp0IVIZ7ULVRDlpQsBvHAUe/MmxRipE8Hd7bWneHrKRW5cTnNSjB
 /ZYhN5SUBhfexT7aZVw4qMUtjCliCBz1seAYFRAv508j2u2dHRMlFz1sY
 3FW8AdPdN9CgmzTvudrObGS44zHKK10+21gHATkySUs9YLOoBDTMVmeak
 K0qBSI3ecnwaoQ9QWFFLIpt0oXskMF7zLVKsuSUl3QDjkBTae+6IteFuP A==;
IronPort-SDR: I0gMY+PRhXFBbIY2Ud6c/4YJrxZfNQrnIO5GFkp0dfNNDf+/i6+4ycDEAs9neFST1atniYwG8u
 2HgcsTNt4erIG0zLYUxixseOgslXz1VM+4CWcFPipefSA4m/OE86qRe78DjsOEnzYKa8CpCXOt
 1rqci88KHarJPs/jEBjC8yPeMETtQsr/E+zv8i6ZDCCV+yxZeaBFeRKB/zQPBX5v/ZUqHdWoXh
 wYZCDEBYk92Pas/MKr3oWTvPU7dWl+gQlyoRanNaTNYAMrOu96tBQP1+nOp8CKWWJDJhxAFzhN
 dJ0=
X-IronPort-AV: E=Sophos;i="5.70,423,1574092800"; d="scan'208";a="130008804"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
 by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2020 07:55:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CnZkwIWqM7qVmdnaJt31a5ZreM2B81b71JxPCDqkx3nO0Ozrh4xgVW0WY7p+uAqyos7ZTx7LAqmXqPa0urrFIc+efD65F67GsWb3vnneKI+fdDS49NTOX5TDNqnpkslMzGWtdQjHh9KAH3qRw059MBR8Ncxf1Sww4CXi/PXONQNR2R3ucE6WCjNaUbc+ki7A/uB3W7aNGmMSBshghMt60Zh+5m5i/UzmV7scKJHEJ6gsAF+jzFfO8PkRAUoFOrwjznjG6RpSO0r0G+o3XjcZMHzTefLv5fjYi35fVSXs4N7tZ/m4MRVK/HT2mW++/KbyZVefuk4YjCPIr7h9oHqEOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfFh5m7xacj8ojGIFA8K+WLYNR+8hdF8YbvAyaBPbxc=;
 b=cZnEgJuISQcv/iXj1K1PVpjBtkw3fvB1nez/3j4yvZNiUAn+y9Aj8bBx1Yen6XQL7Xn1KFJd5Jz5vfgL/u9I0wej54Qx713aNVlBQPi7jK8D7+L40UiM6vY13GyBcRuqq4DvuhEyV7nIAfhXmW9YG82Y+A49rfQKsZv4u6NEF+ZKgWmGuQR2ESEF04o0gldC98MIEpTCjCrpl/cM63yvixo24L4OnHE5KRHnSe06tC272rPbJhRyA2IWLmgKGdAx/6rSX15hehcVD3EBdI6vXuF2+NaztTPDa6dpkQU1bpQDtERlMg29hPKH/ykB3qdnyxwlJa6xM4muus84YHSzWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfFh5m7xacj8ojGIFA8K+WLYNR+8hdF8YbvAyaBPbxc=;
 b=ulbt/6sq0jjmB25j9UOWXZU+JvQ6+ODpAMIikLGdMmhJRm+42F8q5TWetyGDpfsSgSxYpoeIXjX9XPoS6/jviVMVwB5U2oMAYBFGkvPVIMGqkR74V/aSygawmrLELBlfo1INRhtHKx2tzRDndi5eQeDhxMmf8mVRPjXZ33ACHWA=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB5669.namprd04.prod.outlook.com (20.179.58.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Sun, 9 Feb 2020 23:55:30 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f%5]) with mapi id 15.20.2707.028; Sun, 9 Feb 2020
 23:55:29 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>, Christoph
 Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 1/2] nvme: expose hostnqn via sysfs for fabrics
 controllers
Thread-Topic: [PATCH v2 1/2] nvme: expose hostnqn via sysfs for fabrics
 controllers
Thread-Index: AQHV3h0TQu8+BCoAh06RfLYfBFAEAQ==
Date: Sun, 9 Feb 2020 23:55:29 +0000
Message-ID: <BYAPR04MB57495E68EFDB67327CB1F4DA861E0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200208011354.20889-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1c089771-7d62-4f58-506c-08d7adbb8aee
x-ms-traffictypediagnostic: BYAPR04MB5669:
x-microsoft-antispam-prvs: <BYAPR04MB566907DFB95841AF716CEE80861E0@BYAPR04MB5669.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0308EE423E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(376002)(136003)(346002)(396003)(39850400004)(199004)(189003)(86362001)(110136005)(52536014)(81156014)(186003)(7696005)(9686003)(26005)(53546011)(6506007)(55016002)(33656002)(316002)(8676002)(81166006)(8936002)(2906002)(71200400001)(478600001)(4744005)(66946007)(76116006)(5660300002)(66556008)(66446008)(64756008)(66476007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5669;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iU9BK7zJMjj9e+6kd4KAas+Mxe0yi6KOE377/MiDcmcQ9+01RrvIOxDOkAX59yQ93V9l7CEt2pKcBswss8nrBaz5ZBy6+8WB98EXSIM1sPXIVKeSHY4HwHxoxGBkd7DrCqaNuMJAMPL/NQvz4TJ6KKtQCOCNcC9PbGrQGtXXEUzV8+qSSfpU5jnV6tMvCDulyPog4C+S5rkPdeZ6+UfnQqjA0aNV3R8cbAKB7A1i6z/HSOFHYkt7QuEO657IMxP0BZ5c2UEzCJEfqeB5VhkHYWBhwfQhMLSlwqpYsyfELweA5Z7QF3dSxGrbKXdEXOoG8Yx7ZLVk5M9ssw42am9lYsXb3srvceQR/99wHhq9cPCLgMwnrKhaHB5Nc8d6ILe78S415EV+ZaELr99M37YQ7Wki6GAfUjiGsc1aYgN827EFoVYpInWz9T9KUzSofoI6
x-ms-exchange-antispam-messagedata: 7Ca/Qipzbd03aKDk/7K2gSLmBLChN3XRQeGNz7HnQquLJQ5m/zUf05VQJSdyuGCch+Ve0RSZx5qgQMXx6n0m7XDWcYSYeUuLBt+kq4uo/IARphqc7ox1boql+igfxPocSEsBMA7nOqgnhCMwvAhYhw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c089771-7d62-4f58-506c-08d7adbb8aee
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2020 23:55:29.5189 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VJLN23E1hoM5s0cGOFI8HT4ffYOYvD0jb2/AmPGCfLT/fm9FOaKy54nfTrMpYwYClS39hDs6d9otjAqMTCeul03BTPWn+mpNglf8ADXtlbg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5669
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200209_155540_877961_B7F8F6F7 
X-CRM114-Status: UNSURE (   9.73  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 02/07/2020 05:14 PM, Sagi Grimberg wrote:
> We allow userspace to connect with a custom hostnqn which
> is useful for certain use-cases. however there is is no way
nit :- can be done when applying patch.
's/however/However/'
> to tell what is the hostnqn used to connect to a given controller.
>
> Expose this so userspace can correlate controllers based on hostnqn.
>
> Signed-off-by: Sagi Grimberg<sagi@grimberg.me>

With small comment.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
