Return-Path: <SRS0=IJIS=Z2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF82C43603
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Dec 2019 18:33:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0804C20656
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Dec 2019 18:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uDIKaJEu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=netapp.onmicrosoft.com header.i=@netapp.onmicrosoft.com header.b="x/ScTp+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0804C20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netapp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=loUNVHdF1s2YXxg/TulbnaLbqFHOXSRmrAjhtgKrr7k=; b=uDIKaJEu20Prg4
	jA5syLbSbqLJDJ1Kr6XOPZA4DOBmqtN8xaECetatiim1NA5S28N525Et3Fk0rF/RG4braHmhfZS6t
	xvCoXnlwxt37487Kdq5X/jfCMYzKp15dO2NdHWVcvA9lklMLSYetKKAD53NTsi6dK/MawR2/fp7Qi
	A2hk5EsLQIf2yhDtLO+f1n6u1VZMyy50FPfw3CpQH4SBgxPoMWaSj9yJDu3ZAfj7ydIGtkXCS7sDg
	x0QFA9Wc13y96wOxC7fI7PC5+/IAdHK5Lpn1qcWsz7//25YC1X33/cWEKQfr5DCxuozgr8BMSxlmF
	vw4bNl/G5D+9egALmw6Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1icZSw-0001HS-T5; Wed, 04 Dec 2019 18:33:34 +0000
Received: from mail-dm6nam10on2088.outbound.protection.outlook.com
 ([40.107.93.88] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1icZSs-000147-Vl
 for linux-nvme@lists.infradead.org; Wed, 04 Dec 2019 18:33:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H2LpLhNrcxSACrl41kAck0QMjUBN3QzYNlbEUXsqwLDdy4EI5SHNaJ/BssRrJXj/EkH5bWz2y58Igrrg0FxiGiAHAFslTmwLqGKWGl0tpkd3FQkO1rVsV88Tzc7QB3YTUbfmAgbVMAubaqCmMThEO2SpNw8Xhq3+W45jIF8taFmhhCfq97q73QNQkGlwv1VeRC5aC7TMFauhTF3N6xl7getd+c8kBbVJaWgAyEf/whNikgMP80fv61i8MYD13uKcfMflHuxy2ikbaT5id5/riWrXomyHqGmuw9cwuzuaWg+B5KQVlC80ub3pUnCywOceLt4Z+iKzCWyo3w35Mi9/7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2HDcy1/UWCnKhn2Dmz/XU5cGDHkVLds+HcmdmML0BM=;
 b=QDOaIwgrkTRWYqnRt1bgsMjlUW7RWpcVUqbWEEbsj84hP4bK89xIRkKDdLJftvmciFAvoCXh8nhVR9LbguiQVFS0zs20kISEJLqaJ1BP6HjxwK6V668nIwRv5KXcB/V1SG8KoMyBsxkKxZzHoseskOj0V+JXAs+9Arzf/e+zw+15pJOeUi9hnzjSWFf8rfAKbya95Yp0/da6nZRH7XGX9SWPNb/4QpQ+uy2ON5b1MGfTMOvtyYsupR1mGkkHuucNT8uBAljtcWXXHK5stoZauHtXSx0UldfUPhpEcZpDlUH7QClnxLLq4E/hvC4c7YXgIP5Pfqsy4Yh7bes46iXHZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2HDcy1/UWCnKhn2Dmz/XU5cGDHkVLds+HcmdmML0BM=;
 b=x/ScTp+ELuWN+VnnCfSuw8YPQ26ouneekL4W6FbkyEb52ZoF0OCLzAOEDWKtr3uxKvyl7rjagfg69/pks25aIjZdgi4nTvBboK6IbNdc0vmin+YzdiocVoLWDBqJUwhHzIBoUC5ODLf/HaitRGkHRkIT8KQtzH0DlCN4dD7ZB1A=
Received: from BN8PR06MB6115.namprd06.prod.outlook.com (20.178.216.139) by
 BN8PR06MB5394.namprd06.prod.outlook.com (20.178.210.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Wed, 4 Dec 2019 18:33:26 +0000
Received: from BN8PR06MB6115.namprd06.prod.outlook.com
 ([fe80::2ce7:cdc1:b974:dce1]) by BN8PR06MB6115.namprd06.prod.outlook.com
 ([fe80::2ce7:cdc1:b974:dce1%7]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 18:33:26 +0000
From: "Meneghini, John" <John.Meneghini@netapp.com>
To: Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V2] nvme: Add support for ACRE Command Interrupted status
Thread-Topic: [PATCH V2] nvme: Add support for ACRE Command Interrupted status
Thread-Index: AQHVpVats5+vHBHUUEmIVsgThSKMw6eoYlUAgACMT4CAARNyAIAALSCA///U64A=
Date: Wed, 4 Dec 2019 18:33:25 +0000
Message-ID: <79C46A7F-246A-4161-A7E4-ECACDCEC4A8A@netapp.com>
References: <8D7B5AD6-F195-4E80-8F24-9B42DE68F664@netapp.com>
 <24E2530B-B88E-43E7-AFA2-4FDA417B6C1E@netapp.com>
 <20191203210015.GA2691@redsun51.ssa.fujisawa.hgst.com>
 <04835a2e-1769-36c9-63b8-173f247c862b@suse.de>
 <20191204160737.GA1791@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20191204160737.GA1791@redsun51.ssa.fujisawa.hgst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.1e.0.191013
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Meneghini@netapp.com; 
x-originating-ip: [216.240.30.25]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 288ec1cd-52a2-4575-e393-08d778e8737b
x-ms-traffictypediagnostic: BN8PR06MB5394:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR06MB539466CCF30AB8DC899E3B99E45D0@BN8PR06MB5394.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(199004)(189003)(6246003)(8936002)(81166006)(86362001)(81156014)(33656002)(14444005)(8676002)(107886003)(25786009)(4326008)(3846002)(71190400001)(2906002)(71200400001)(6116002)(229853002)(6306002)(6512007)(6436002)(36756003)(6486002)(54906003)(316002)(14454004)(2616005)(66446008)(64756008)(66946007)(305945005)(7736002)(66556008)(76116006)(966005)(478600001)(66476007)(99286004)(102836004)(5660300002)(91956017)(4744005)(11346002)(186003)(76176011)(53546011)(58126008)(110136005)(6506007)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR06MB5394;
 H:BN8PR06MB6115.namprd06.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g2yACDwrEmN0m/1PVNDjFcGxP+eV2oO2O+3I0mutE8ObHYVsYEr1SKsUO6QeMz2S2xl1cU43QNLrw/epzI5JYDwfaV/a53PkY5sfQ6hSXlWsG9D4701i6a/KtTX/v0kDQftYDKbrLpKPLKfrYZRqdbFnE1+jGc3Ob89x22yfJm/GArh+vGfqSZqDkTZqtIE+D3qsB5A9O1LiYP5R/Sn2myJm4c7V9uX++jxiPNsHBTcluwxj4qRGn9rc/EAQOmkJVFZe5gG0+8K8rZTogVYhhMGwrKG1/36dS2W7YQcbMsn1wYYTCdolP7h+1/zHjrh4YqfIKsTQU8hgfzEFvcjO3HZ8igrPMNx8miG5zgzNEUv5F9+0oZofFKIsNZuCMFEQWn8+6TzB9V1QgnR+0C0l6npwk3oe9chGcg7DnHtWYXwedhsLh/j2mZBKFeFy/builHygq3V4lNDOgp/PSJgTJ0iOnfNZdiIO+6OhYffanZ4=
Content-ID: <134EF97F4D50FF4A91D4D2F9FF8EC1F8@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 288ec1cd-52a2-4575-e393-08d778e8737b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 18:33:26.0140 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8mwtPK0p4BmWyMdJC0JZuVrR/ylQciEnEXP/cc+0Z0ggWBc7s4/cA/xGK2L//c4eadKt0eOQ9ilX43jPjjD5zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR06MB5394
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191204_103331_097351_C483E19E 
X-CRM114-Status: UNSURE (   9.37  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "Meneghini, John" <John.Meneghini@netapp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 12/4/19, 11:12 AM, "linux-nvme on behalf of Keith Busch" <linux-nvme-bounces@lists.infradead.org on behalf of kbusch@kernel.org> wrote:
    
    I just don't understand this follow-up from John that I cropped it out
    of my original reply:
    
    > The alternative is to stop incrementing nvme_req(req)->retries in nvme_retry_req() when CRD is set.
    >
    >  @@ -258,8 +258,8 @@ static void nvme_retry_req(struct request *req)
    >        crd = (nvme_req(req)->status & NVME_SC_CRD) >> 11;
    >        if (ns && crd)
    >                delay = ns->ctrl->crdt[crd - 1] * 100;
    >-
    >-       nvme_req(req)->retries++;
    >+       else
    >+               nvme_req(req)->retries++;

Sorry for the confusion Keith.  This was not a part of my patch.
Just a diff to illustrate what would need to be done to handle
NVME_SC_CMD_INTERRUPTED internally in the nvme layer...
so that it never returned an error to the block layer.

I agree this is not the right thing to do.

/John  
 
    _______________________________________________
    linux-nvme mailing list
    linux-nvme@lists.infradead.org
    http://lists.infradead.org/mailman/listinfo/linux-nvme
    

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
