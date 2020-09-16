Return-Path: <SRS0=FbzM=CZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A258BC43461
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 21:01:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F29A206BE
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 21:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="zv0odKhx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YxyN5Dz9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="qBeibdo3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F29A206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=gyyMYdikOcOjzuNIByj0Cd8mIxPFJIp9x2mfBINA6aY=; b=zv0odKhxHmhe48aQfYuU6PHiA
	BeGY3rtEasELbpcesDhBfAfS+SwMcDdvRAJr+uRrdvedQ2AHgXVLeyMnB7CffUKHVSEfQeHtSy4DC
	AYW30l194mvvTPlCVBQ51epnmzBfpp2uWFQVD99I5UAGxg/vESklgXRzPTti1+DPwQDtQIGsOyb/5
	/oGvSKW9lfalSaAPtphWvRv0ijwb42Y83LwClOjgCcVPy6RjX/fLWs4N67mBr7INqLdY4JVBMWd7M
	QQTNPTPg6mzdk+PrYnp11vg101dBijZrUdu+juC3U+Btjd8GZuRfAbJYj/M8b5XLoUwG6Ahc/ykk/
	KyQ3Y8eKQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIeYl-00015D-G7; Wed, 16 Sep 2020 21:01:47 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIeYg-00013B-O8
 for linux-nvme@lists.infradead.org; Wed, 16 Sep 2020 21:01:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600290102; x=1631826102;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=S6TRujfoXXl1ZeQLjyabwMI4iSDOBvumc2Rf/bZU6nQ=;
 b=YxyN5Dz9e6ZUxo8JB1RnLSqLJGssV5xq5FL+4QLexNI4yT2+jS6dWWzF
 O2ESN1pLeRp2PKbftD+PzrYJKWUm14K+yFOBigJMGvBoghV0ax5JNKidJ
 RPUcJjqR33djxWo20WGXNLiUovVSagrApGKn3//tDvwWNl0Vj+VopHwZC
 0aZ0Wyvmqise41V1UEhQEhFvXFb2X0n1PoV9JpRWh+ALfCZuEkKe3BDOp
 +QE6SKuV1zFkQgeKp0NHu7HgGD6MSwc6piVTqJOPh3Xieb9/408qKstTB
 2gVy4qQOaP5eVxuF678aff11jp7idJIQitN0at7bwpvmg6jLANXhKgFJ9 w==;
IronPort-SDR: kRMeZXysyZjhkK6e5HR9SUM9KdX1ZNc8RqeWFnE39u9WzHzG3CGzpIOup9i56KtinBbCujj28e
 /gCK2W8MaCOjiTFwtq6BY0I7uu3xdL3Z+NYCDf/EwNWVgxS9x1YT+owLt3bPeIYEYXAfnMDTKG
 O8QhOBC9uzTjm151P/ejYXH7sMpDrKha8XTOI7V8IenwYrx2k2vIzJlcSCpMa5P5/tGj9oC8Oe
 oJM6JZ85a3uxbkNHfvTIkDkfy4nz2s18wihfO2ht4Bq+PMad+dbHLb4WQhMI2tkyW+uW2RrHZu
 yzY=
X-IronPort-AV: E=Sophos;i="5.76,434,1592841600"; d="scan'208";a="147480747"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
 by ob1.hgst.iphmx.com with ESMTP; 17 Sep 2020 05:01:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmPOkX/lmSp6wj3ytHfAVCiytFT+Bkxe0HmGvCSVWrs9QT9StxvqYfuqx3XrpS/gnvN1r8DjAd4hV20gKLI+tE8VZHpYUagRTb2b44/VOJve1Cmv89C7UD1pa043o8di6a5xWyJ7PKyTuBKBkzj9uhAjqHu9txqgWN8EPLJ+a1njoExKsAB0FDgl3NbOmF4HdH9qMbIxMUP182AC5LdFVaf+aoQ2Njd/Z2qMr5VgZa+ll/8K9LMNfu2oEH0brVSqf1VriwsvfhQgX06qh+ZVdoHlqTPWBDEJR543h+ewnn3Gkq0hlm/jQU4zVfIY3LmaHDqxV1/IbU6To0gh7KIN6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4j/uM3BjwN28s3NjvQZPlSPVN8p4qATfdW/ZTYFBlno=;
 b=MsCZiPc0CTHJG9X9YfWponH8ANll9GALRnZuWDzTYIiUlYr4iRKYQWQqwpVP3678FlWHpnc5yqzDlxrIL9Yyw+0t0+TvVNKpR/YlZQ+SLODLdIfhM6Irz8lFANIJ9XPqzHmc5GMRSR91/9HAxnMnkxQWuY2uxLeTkaIEw9s7fegIOqagUTHMCxTEYLJOamsvEE6/nLfKiUSdGFRwgbdZKYd8V94ngxNuCHw/5f7vYiCzECixQ5WrLlCHdrAvsSXJGwlF9+t/6uW1EAOnXVyy+0XZkY6wvLDtnWkzVEhG1gdVTAHxw8MLTTYyStMCrO31zwdzrY6dsKMzn4xVfuvKzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4j/uM3BjwN28s3NjvQZPlSPVN8p4qATfdW/ZTYFBlno=;
 b=qBeibdo3LYr4S9FoYT5bt+f8zpP6RxO7biKYk0sxQH1wHpvf0rpqzFdq8YgzFrDJ7yypSD78fAsmZq4WUv1namXd/3yAB1eolNz7MnBtqzbKqrmIEg6pv6Akg1EQOFa8CnkoltOzx6y1LxAdrqDG4NpCB4HnzEJ+qsmv7hvMfNw=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB7122.namprd04.prod.outlook.com (2603:10b6:a03:222::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Wed, 16 Sep
 2020 21:01:40 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f%5]) with mapi id 15.20.3370.019; Wed, 16 Sep 2020
 21:01:39 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V3 4/7] nvmet: set default timeout for passthru requests
Thread-Topic: [PATCH V3 4/7] nvmet: set default timeout for passthru requests
Thread-Index: AQHWi6pwXxxBa6UufUmDxRctnEtTSQ==
Date: Wed, 16 Sep 2020 21:01:39 +0000
Message-ID: <BYAPR04MB496575E4044ADA46CE80EECC86210@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200915215118.3934-1-chaitanya.kulkarni@wdc.com>
 <20200915215118.3934-5-chaitanya.kulkarni@wdc.com>
 <20200916205710.GA3676296@dhcp-10-100-145-180.wdl.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 76d79095-aa31-4dd5-48bc-08d85a83b520
x-ms-traffictypediagnostic: BY5PR04MB7122:
x-microsoft-antispam-prvs: <BY5PR04MB7122CA1CA53C6ECA8B02049B86210@BY5PR04MB7122.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CorO/+RqSONcNfN+7ybT0S63TLmhw/judb+edPpO6CWijY688dj2EQKDF4ogh1/sGqsRDeiwbm0Sc8Rf3iAaKNooTviz6oXSQVYbvjp/ESI1YNqKDm5uNu9Yb/ArwsLoGmcaRvAzeiX2rULZRcdWCTFCwxIvC5Jo7Mqto0FVDAVVoGmtbkqO8ZPEcYHoPVKw+uqLGIuceOhKO1jmPMr0UUTrhkpceBs5MMOxaRqeruGY27vOJ+Yej4Fk+vBcxtThs4OBgJzVhAFr+NrW9rJutsSBbIaWcH9v67qXuWwwRIU7HJM7ARgWQDGOvntrHAIkdrFWJqTKu81COi5kELz7kht2lK4GnYVxM63NRvVxL01219JMRq7DSe6mIydxgml6
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(55016002)(8936002)(6506007)(478600001)(53546011)(83380400001)(2906002)(26005)(33656002)(186003)(9686003)(76116006)(52536014)(5660300002)(6916009)(316002)(86362001)(4744005)(8676002)(4326008)(71200400001)(64756008)(66476007)(66556008)(66446008)(66946007)(54906003)(7696005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: oLCzEWCNPEOUWNERZJXEwKtPg31xxO1RsPBR6k6E5CpW2fWnS6dyzgodRrVicgWUzYEsOtvdQbMG34FR1imUCxzq1UxU0NaZKRvv7twqPAhS/TGkWVVeLFFw6JNIm4wOTOztuEfMb5DIPDmQYzcuB6U5HL9qFUE+AU2pDwJRvoXQBIZDwWzpRs9MoCeqtrz56fAd98AQt5chs+qvFtls2Bhqxr2SfkJ9XN7gSWlSmwupHSPM4MGL4JcjDrClUvXjK2q94xfHygFwTwoTMsNHtb4AGNmuiqtzhKqMts0Aq1mrC2MJxc0CEb1194veSqd314XsP0smm7X+b1EL1/1rWgzob8K+19gI6NxoZz+woI424hsK1axONIHLNoMDk/fDWQSHeYkGTk0KDTnzEzvk4dJRzdVWT0MO4dLf0Hyqqn6IqRSohVb0h12U+dqexOMPOdsVfU4iIshNc6siZUiz7wlUzQllMl20pDi2BNjLN5tOBL1wzJ2MQu9RgqKDR8cu+2gR5JFmY3mIs2EqG83CZsqdYvnXfkCeiiqp7raVgu54SnG3CSXXJuxI+3P+qK7k2dgKsvDrH9cCv4TOOaTvzKc6s37ma4HyIJ530GNx2rtekLMJMvlB7OVQEbIWgPR6w3LYBU5BWWchkx720ZxRgQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76d79095-aa31-4dd5-48bc-08d85a83b520
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2020 21:01:39.6484 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TQS991blz3gBIqiFqQTGQ0t2PnxmcBcYA7OFiMF5gUCrv2By7oDeyakb3JzbJEGWPq+0IWgBItD6Qa2Mxr/x9iV7GOTKbfNTo1awmEEvbQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7122
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200916_170142_998203_52572ADA 
X-CRM114-Status: GOOD (  11.76  )
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
Cc: "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/16/20 13:57, Keith Busch wrote:
> On Tue, Sep 15, 2020 at 02:51:15PM -0700, Chaitanya Kulkarni wrote:
>> @@ -242,6 +242,8 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
>>   		goto out_put_ns;
>>   	}
>>   
>> +	rq->timeout = q->queuedata ? NVME_IO_TIMEOUT : ADMIN_TIMEOUT;
>> +
> Any reason you didn't use your new nvme_default_timeout() for this
> assignment?
> 
Yes, since it is being modified in next patches and easy to review that
way.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
