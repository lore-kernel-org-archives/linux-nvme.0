Return-Path: <SRS0=Qd0E=EY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E344BC5519F
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2020 20:09:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA9542100A
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2020 20:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NwdRLCO+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=netapp.onmicrosoft.com header.i=@netapp.onmicrosoft.com header.b="SveWvhyM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA9542100A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netapp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6C+AUehNlW1dtRVIpVDOWvsodKVlImsbBEfVR00OZ7Q=; b=NwdRLCO+N8U5u65jw3jTseRRs
	8bHMoYfisosUotO/zm3yMbrUvvPZIWNzsX6xjDzRsfmte4HwZuGoZYJm5q96YRGYG/UdvKtwbRHK+
	qdn4QENHTlOK1MtnDqtao+DBtKgtU9eJHL0+Ruuk4FfVd37uYq3MqClfxRTmDIIEjsblam8QEkfjf
	lMvxfAxvywGn+sbVShKQfaeHMKwSyKO+JOapaP5EWF0fTJqyQerzbicwr4BObvv+fDl//ZsBKMGl0
	OPtr2Wk3/YGPBOtBcm9Cdki3t1PH9yrL3s5lJxsIPuipFjcRd/RoSTcr+KHNoe4/D9I8xBSN4EBvO
	Sd6CjmJeQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kfTm2-0002yc-3f; Wed, 18 Nov 2020 20:09:50 +0000
Received: from mail-dm6nam12on2087.outbound.protection.outlook.com
 ([40.107.243.87] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kfTly-0002xg-Mb
 for linux-nvme@lists.infradead.org; Wed, 18 Nov 2020 20:09:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OkSgo3PVl72Sb7Glgr1tWsZg6M3j11PoLYjpSk5LjbfKOrED8mn927sQmDaAh6gZ6o5DBeIjQH3XzDK9tttEvdNkORoLJw/M8L1yjjXZRGaHYq1ITnLDuGf+/Dyf+c/Y+fBPFBjn3BU3YVlE7ile0mNdIRshiKGi76lw5cgH+0zWnaeJ3hz+B83HtXItiayt9KcsNr5RSdm/MJgKOU6rCHoracaPmHRCY6PFKp/6c/AYUW3hSxI1Ww6vCX2j9tZkX0QsJCMz/As4+itIATq5vP0hAVvKKxZNYcvySzciWHz3V8ic9MAzPxlxs15ixY1aGAO909zoSuCcUW+3RMYtag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oj8cSeVpcUMCoswFbqpoi0/v8Z2dLIDo1sJilbm2pcg=;
 b=Z4sibJsY0IBwMDOUrMh4oVm4co/AsSdkaWKX30p0x43JSosAfsBzhzlGlkV3mD47eJJA6quCVn046ysrkx4MqB0sfJgwkHQqpHnA1sz0WUaHyV28bzYTraQvG9azW6HmCzeKtG2oR53kvXN66MTfWWUUm+1bT7Iwtd3Hj2Q2kdsyNUj0GjrhuKXNxnaa9/YmCisf10wiZn1119SkGdnqSYsFx2tJM8w21U/z57ghWbgsbab76Cv4EHm9T/NVWWBpevyOwsreTkoHbprkdFNeWc9vjIyI2zmP8C3X15jv1c5DY+9Ck04kkPQ9Cwz/+52nql6qZnU0CQ016e+XgXfiAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oj8cSeVpcUMCoswFbqpoi0/v8Z2dLIDo1sJilbm2pcg=;
 b=SveWvhyMX8l0bZGB1Wr7YWPqXo8s6E+ksaLvVP++K6fAjATOIEn4HDdLTCQD6Mv+uIfKYidwl6PpZq/7E6D/L7UGpuL+lmD5kvUHYiLDaID33yGTtJCPbOU3Xz/NRp/aTkKHgX75Zpv6X189LdXyHpzClyhuMPwvzC2eXNTuZVg=
Received: from DM6PR06MB4634.namprd06.prod.outlook.com (2603:10b6:5:ff::25) by
 DM6PR06MB4587.namprd06.prod.outlook.com (2603:10b6:5:19::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.20; Wed, 18 Nov 2020 20:09:43 +0000
Received: from DM6PR06MB4634.namprd06.prod.outlook.com
 ([fe80::e84b:922e:adff:146a]) by DM6PR06MB4634.namprd06.prod.outlook.com
 ([fe80::e84b:922e:adff:146a%7]) with mapi id 15.20.3541.028; Wed, 18 Nov 2020
 20:09:43 +0000
From: "George, Martin" <Martin.George@netapp.com>
To: "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
Thread-Topic: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
Thread-Index: AQHWvaDZ4On1YeAvk0yKbnb0IwXxeqnOE0GAgAA+/IA=
Date: Wed, 18 Nov 2020 20:09:43 +0000
Message-ID: <7fd0b51f3b7bc73abf7132aaa5ee7c493a93aef0.camel@netapp.com>
References: <20201118114859.7985-1-marting@netapp.com>
 <20201118162415.GA16753@lst.de>
In-Reply-To: <20201118162415.GA16753@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.4-0ubuntu1 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=netapp.com;
x-originating-ip: [202.3.121.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c49102d-29cb-4cb2-e276-08d88bfde3d9
x-ms-traffictypediagnostic: DM6PR06MB4587:
x-microsoft-antispam-prvs: <DM6PR06MB45872E6727013DD468BBD6DF95E10@DM6PR06MB4587.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wtiez1cOuEhf7f7/YP92IyM0CR99u5Zf3z6TiXFtPaoUvKwMf0orHu2CHW8ovuIUsnfWchk/BhkrX/BLkyPt0NiRx07uampku5WAw01z6XL9M2fCF8v5vsuPaTCXq06Rxs4YDHKH7+iQ4dqmc9foU3ndhcjCVGg6Vkqt0lbJnm32zJtj9U6FGya27kotjYHWQzwophn59FlTtSU7EebEOgiFp4AKZADg3Aqn7mdI3twIcsMkco/CJS6aM9dXOTpG5UGzTRrEQheExupq0CisovZpgdmJBDxoNTjmbsCIc6DQV7sztrEoszvwYaEpXiLBHzYRxGf/FThhMdQkjHgvEA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR06MB4634.namprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(366004)(376002)(136003)(478600001)(15650500001)(6916009)(2906002)(71200400001)(64756008)(76116006)(186003)(5660300002)(66476007)(91956017)(86362001)(66446008)(66556008)(6486002)(6512007)(26005)(66946007)(6506007)(54906003)(316002)(2616005)(36756003)(8936002)(4001150100001)(8676002)(4326008)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: G5JaL7peRcJI0NyOWtN3SRNX6w4LDPRYxuiOt5HXykYnl+LCuVZ7WxL4hUUln1hwEQHou7MTlfsWjX/0DQos23+KKQWTGXqnckgNv/mvT374Z48WiTBf9VDlNj7aJQHtWfPHLRRay0tBHqeAT/2PHWD+skm3HeiVK9FGwARhl1/4wta16DAY9EbrrJnwNXpXwukvwiIAbVRfn1PeOWghoySyR58Qbti1uWjVrbt/D4IfCyD9yTCyWiAJ7wGGtLje5ZK9p96iaKTMvvbVJMI1PJmQteBFMnX4M+m6FRfwhvmRMJJFF9L98WZIRzJRsoLcO/gLQp3DEcPkB3o7ZjIbI4lcV2TFKsqFD2nPpvu2k5WNcSaRTLUGTumwJ82OSoJXof/7MsNKD6uIZInPrF2WpSPGuDmzS+Of+nQQyl2AwnLQPk3gCE7EhMj74eL0qCKnSkCjOcbX0l+sx60T309aIXfDG2DbZJlrcBptsS3CjvwH8kfn13vozwc12pUPeuMGfxV84egbpOb8q7Vf1Jy0h9BqVQRiqEIRfD7x1EaBJB35INXD0VDYGiXd0yDS+oIj3TKfJcrzQ78PxoR0yaEh5J4xC33YOndQTn0CdmYS0Or9Io6UIb+sPq+rnoDANVfOeXcuR5eXcAJyJuSnredIoQ==
x-ms-exchange-transport-forked: True
Content-ID: <73DF047A303FE24F9DE029136F01F6E4@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR06MB4634.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c49102d-29cb-4cb2-e276-08d88bfde3d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2020 20:09:43.8129 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wLb4SrxR9vBNiCSMOX4aXhyUbF15Uo0IwsZfo+xp+C7GHr86zulwpB/pzwwmJXttK/1Xijq435aVBPfJVQDewQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB4587
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201118_150946_863194_A0D037CF 
X-CRM114-Status: GOOD (  17.79  )
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
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, 2020-11-18 at 17:24 +0100, Christoph Hellwig wrote:
> On Wed, Nov 18, 2020 at 05:18:59PM +0530, Martin George wrote:
> > From: Martin George <marting@netapp.com>
> > 
> > The current nvme rescan triggered in response to a NS Attr Changed
> > AEN, fails to add a namespace if belonging to a new ANA group. This
> > is because ana_log_buf->ngrps is not updated in
> > nvme_parse_ana_log(),
> > due to which it is unable to locate the new ANA group's descriptor,
> > eventually resulting in the failure to add the namespace during the
> > rescan. Fix this by reading the ANA log page as part of ana_work so
> > that ngrps gets updated, prior to invoking nvme_queue_scan().
> 
> How can the namespace reference an ANA group that we haven't been
> notified about using the NVME_AEN_CFG_ANA_CHANGE AEN before?

Well, I think that could be possible for a newly created namespace,
which happens to belong to a new ANA group. To quote the 1.4 spec in
context of Asymmetric Namespace Access Change under the Asynchronous
Event Information - Notice (Figure 147):

"A controller shall not send this event if:
a) the change is due to the creation of a namespace (refer to section
5.20); or
b) the change is due to the deletion of a namespace (refer to section
5.20),
as the Namespace Attribute Changed event is sent for these changes."

So it looks the NVME_AEN_CFG_ANA_CHANGE AEN is not required here for
such cases, but instead the NVME_AEN_CFG_NS_ATTR AEN would do.

-Martin
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
