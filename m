Return-Path: <SRS0=7k1C=KV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F91C47087
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 01:56:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CBC26128B
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 01:56:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CBC26128B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=sEue6DEdd7PaE6YQCGEf9fVgIDQergPwbxFGpcbRJb4=; b=agYf9ReESjNZ1W
	VZfnYL2o522YBh0YMr2R2P9xjbDNUl5PO9vJSM8auRywvD++1OJguX09Q03LF5Fd2m0D74DgmbFjD
	JNigQ24aymeaDZXmYDZAs7slUV8Xvd2JlNzWZ10CfyuWs1+31nffU+RXYnTTrRCeLpv2KC4F9EPU+
	/bON1xn0bTmkzeIlicww5VoQJ8SlSY/B19clQY4kqGLX4wsNAnpplhCPxjrP+puOxaOk9L7oQEdzx
	2QyMaMkvvBtPeiF8eRLnOaJSjUbpvbCwIVi8AQaSRn2wHNA0aSFT/cDDClCvMqgMzo2rmrtYxdEPZ
	EwghOvdnUGSQqoMuILUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llim0-009wh6-LQ; Wed, 26 May 2021 01:55:52 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llily-009wfu-KG
 for linux-nvme@lists.infradead.org; Wed, 26 May 2021 01:55:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1621994151; x=1653530151;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=tNg1TdTBRHBiGNkwgylSy/gaCnoxp+PbH6/H9rcrKKE=;
 b=QzcEcdcYMnmlug6eKYO8fE2StjAygW0fwWs7Ha6tD2E54LHbAwfZ1hOS
 R413cmRys20Z55vBYph1CCBtXC4cE8smKqNZ1PZaytDdHjszOOLPtiCO2
 vQq1mJaunqWQWkIM6wTVxnAeuBi8JSAJWb+tKSZS9D8CNh8ouv1t6H8NW
 fceVgVg7PvakhArKZNRK08gfYAi3Da4iOs4kWBZutoHbfYtl7PYtlWm0x
 wv5sS4GVQZLzbSI5n/IUhEgRZMErI0/eBNBtrWr9fU107zqPbf5bJN4Hi
 Pk/zvVsay/0tAjwXObtLpZGT0nkuti6cjD4U7MvAy9aXzwQTEZ8+NFnl6 Q==;
IronPort-SDR: W5+v1bHyhlreG+BN6jbJjxpvniQ3/1bOZao0vPRV5DJ7spkq/m9G0ICcMjRYHz8nVoMjQCG6gB
 NLEAPQPmGJueL7tfhP1nRDXfUTyDxqzw+Zw7wd0JMttSnpizO2r3a6TxY8Cy9B9FA3ELNiuGJD
 0GNgkp0Qs//nRYKfVIxtZvFswKgFIsyBFzFuAtv96zPEImPXWkVcjgoP7DqwAzUBaQhWUW1FQa
 7b0tGh6hFdu5qmVY/e2l2HWDuhq3to7CjIAMp6M0tizwpJwN5jn5SX4PAHRVxBMyN4TrjIPLJD
 Wxg=
X-IronPort-AV: E=Sophos;i="5.82,330,1613404800"; d="scan'208";a="169972331"
Received: from mail-bn8nam11lp2171.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.171])
 by ob1.hgst.iphmx.com with ESMTP; 26 May 2021 09:55:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4qdN7wRT69NZZ+63+A7DBmlNlu6XK1HF0MqKgjLtu0wP5z0GLYejM6449mg1owEJ52wM8pk7U2N5ePhMiPTB/APusflEWb3CJoYFYfrMD2rTo2nYZw48y5smBOisahF9Djj5cavMfs6mw7M8gQwa2FAGrHJO2/+g1+Ybi5ALhte51yzn1h6CeasRBMc6X34cGZCzSGvKM00PQpR7aEIiEG9ucZ0mxvQgn9e3Zx5klCPPTnSaxUJRru0OpD1Lrxkzhh35TAofz74riUGB5Fr/LpK4le4m5AkZXt7I6uHkUSVlDPBMWR+tZXV3N47kO0zS8Awwf4AeUC6WVgAJ5Mh5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awLdxt0GopgX5lz4jBxpSuyYto9GPWi/i3GFqo9SCCY=;
 b=QLwx2GSojTx1V5wZmx8ObyBGWJtrc3EO5E/S9p7cKV/vf5Wv5KCZYqGcfk2/2PNduSke3oJrQOnfj6CUDOYiwBuovc0sn3bg31CgoZNPdl5XrZr85AO10ko00SnQwJZpAgvqgikoFyQdK8WIuYXJQHAHuv+5Xq/h0Jy4mMQwuEGo1yx/rK8Xa/cOThnB8EYAjx8IkjWlTmbZoKKvvLBLCRKFINAe3QOd+tczKeN1Z4xvBeslo7zAK6A4II4141XKbIIWrCVG+zbzJzVQ4cL61e3tcGWUGE+ZgEwnZ3imkqqXcyCJB+TQBMfSMGb769TeuFYxsGiQS3Qf6XQ3oGD5Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awLdxt0GopgX5lz4jBxpSuyYto9GPWi/i3GFqo9SCCY=;
 b=vtJ2L0HsdQPCSaaL+dbs1Ouhe/JiZ80S1GWbsrsIEMaonr4kOUt7mHWz5T65aPEHK49lxS8qT11EhGaRvq8Bej7KBAejJxFkJCe2S3FGArc4Cp43JLG4JY9ZF3ZOucQjT9UIYKD65+B6yaIrdGffbI/jRwkmjF7FIZZi9+DgvOo=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (52.135.233.89) by
 BY5PR04MB6642.namprd04.prod.outlook.com (10.141.249.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20; Wed, 26 May 2021 01:55:47 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 01:55:47 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>, Keith Busch
 <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvmet: fix false keep-alive timeout when a controller is
 torn down
Thread-Topic: [PATCH] nvmet: fix false keep-alive timeout when a controller is
 torn down
Thread-Index: AQHXUYRZXXhydzeiAUqy/kJG9h9OvA==
Date: Wed, 26 May 2021 01:55:47 +0000
Message-ID: <BYAPR04MB4965990761EDD49B0AAFB0EC86249@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210525154905.2245888-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 746e60ee-a2fa-42b0-587d-08d91fe96186
x-ms-traffictypediagnostic: BY5PR04MB6642:
x-microsoft-antispam-prvs: <BY5PR04MB6642C4356E8908553E6CF7FE86249@BY5PR04MB6642.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:506;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: txINftIx+CZKU/BNihjuuB6mTRgJdOv0MLRg+seij+y6Pk5OgTSFRn/AocnW8TiD5WAZxBTEYSvk0AmXAVICzeOt5IT49Ult4WLPntPe7ozue4CRE3qeG5stN3tYqOIG/eJAd61WTi3AVkx06DsTzt23geAk6pLwvDHeIkU6oJ76F5LqTMXhGbw7liKYFlbTNWdJtfFn8z/P9nsLwT8MefUYflnptyo0iooIJd9MdVU21b9wDlf4rjySS5gc5VDuQW6szmyGsjvxBuuhJaEgLVvpYyLxZ66AHEC/oFwO3xg32whLA7HTTXLpSye7zR2Gve/CbmWV/BeYgNklzauUbcZhGCAbzF7nqYDcUrl2lEvO5sNSaXpmcTuoBC1vxHmdn8GfUwy1Yu8tJCOjni7NsoVsJ6pnFjOQsMu3ykc5sdJwdTaaMJ+F7FmVoBoOoW6Bwnrq8p/DIzS8ADZlBbkJR91Npbsso4uHReD+OLuQ0ooKEDB5aleJ7wjs4Vsl0tdGqcvxXLWzBp+/qWeYs6jrVJ9XhprnSpQ5Nx6HUO772+ZGS8HB8C0qmM5vzbU+SytoZ/LsxcAV4i6RXAnRiEPoEyaqtV3jsKS3ETEn/17r01U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(53546011)(86362001)(110136005)(2906002)(6506007)(83380400001)(66446008)(52536014)(122000001)(5660300002)(38100700002)(7696005)(33656002)(4744005)(316002)(71200400001)(8676002)(76116006)(66946007)(478600001)(186003)(26005)(66476007)(9686003)(66556008)(64756008)(8936002)(55016002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?dPBGKgvMDT/AntIh0HQwOyN/yPbKaiPnmCi7IQ62LrYzHpjmxT//EQECS6Ts?=
 =?us-ascii?Q?+SQ+2/e9hhyPpWq6P5QKrIJ0USoylCZZ3b0AT6voeqYsLMYiiBkB8veQcb/J?=
 =?us-ascii?Q?5wHVZZ82kM7N93HZJPjEQ5JLZRwenu9Y9QYFiVlk0fBolfOMSpxjEGFg2YK/?=
 =?us-ascii?Q?lXYt38/zyitiSeOmjd1VbXu3P+GMneeOFj6zvFmDuPrAQC3nZ5K3/myhJSEy?=
 =?us-ascii?Q?N7IIs/+4+pl8QvZy8xE96RDbcXktYru4SJlmMFMEv+H+PsKZovIbo2nbk2Tl?=
 =?us-ascii?Q?I1WLlgeOuftP3Mw1LSs2cM4IxgFZcDEgAU5u0nIWegro49ydpz8cvEDBBXIH?=
 =?us-ascii?Q?tFAniFzpXze1pEhRZ2y+9zRcvYOphW+4ITYC/KBEwdqXvlPManevHV4iLhMy?=
 =?us-ascii?Q?bAeYNNvAN/PauJi984Gu+OQOmWeJwTgHvs6G3418T29TXEvK7tkIQmIOh7FK?=
 =?us-ascii?Q?Fs3CBkdDU1GWfd553k/kJhXR2ef90o124ZGQ9AN52q2QpwCl2VJnxnabjlLN?=
 =?us-ascii?Q?YpgkEM4gkGI3Q+HXhd3v+RPGsSiuthwdjfPFqjp1YNKYV6r3DJNVAkIByOtM?=
 =?us-ascii?Q?ORiztpagTmqNqxnVYu2M2MDvhmt4bHwI+ZFqR0DhN6d0rOhTQMRdapJ+2wjy?=
 =?us-ascii?Q?r3o86zc7XerwNWOIIxYoPF8v4KJSer1Kod1O7ruG5T0fNuh4dit479qNna6J?=
 =?us-ascii?Q?noIV1bBsAjBbpgd/gOxFuA2w8SfCMevHP5bmjuxJJgibiqMVSytIPeA8pWTw?=
 =?us-ascii?Q?HBpGynBhb3Ku568O72gbOWY3EssFK8jofxzaOSqdXNlMe8SlGTUE9PbNASH6?=
 =?us-ascii?Q?PehHyns0/4QIehfK7s5uUpX12AWFX7M2kmCAPMaN+LoQ6uJd+096VqxYr6e0?=
 =?us-ascii?Q?vq2x+r0mTi+f71ft0lKOE5hxhR6iB9FUHh50etP0CzJfN92hCw2h7Cz2N1Qc?=
 =?us-ascii?Q?LsGciue0l97WIGVdejr45sMyhP8yUtxCtpfYWL2z2O6495boSeKfbep+Voal?=
 =?us-ascii?Q?Jcutp2An6M9WoJN45qGZSf8IdM50w7T1wSBRbp3Fto88vN+yfhy5yKZxi9B2?=
 =?us-ascii?Q?K0hVWvmdDehu55uKrHrhR+C59JTB5CovdVvr89pVZ7W4j0FyKNJedlrHOntK?=
 =?us-ascii?Q?YRFDaedpoTA8eSl/oi0kvuNkSg+RQ6WwtyzRpK9fIm2i+G+DDoYU7Bl/8+QX?=
 =?us-ascii?Q?qmgAUoZd6g6InGs30n0D4nXVLVphYEMPKHGZBiYRYAEaIHfD67TRWPvEzJNO?=
 =?us-ascii?Q?bZ0YKiB1EAJzrqvXfmccYu+HW+VTRFxwTSkBeR9BD0eKJ/ppcbCUg5GoiSCh?=
 =?us-ascii?Q?ac9A8FpI0Mwt7v3NGVtv+/c+?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 746e60ee-a2fa-42b0-587d-08d91fe96186
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2021 01:55:47.1472 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rO8SR9arui8IW1Xtb0tkNxNlVrISqKroeSpuAGaUoFGL3xrv8cyme5SC4Im3V0XWtBvc7xzSoyyfGw55TIE3mTEsK74cRoaJC9N5SB8p0zY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6642
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210525_185550_767641_BEDA8DA9 
X-CRM114-Status: GOOD (  15.66  )
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

On 5/25/21 09:38, Sagi Grimberg wrote:
> @@ -804,6 +804,14 @@ void nvmet_sq_destroy(struct nvmet_sq *sq)
>  	percpu_ref_exit(&sq->ref);
>  
>  	if (ctrl) {
> +		/*
> +		 * teardown flow may take some time, and the host
> +		 * may not send us keep-alive during this period,
> +		 * hence reset the traffic based keep-alive timer
> +		 * so we don't trigger a controller teardown as
> +		 * a result of a keep-alive expiration.
> +		 */
> +		ctrl->reset_tbkas = true;
>  		nvmet_ctrl_put(ctrl);
>  		sq->ctrl = NULL; /* allows reusing the queue later */
>  	}

The above comment could be :-

+               /*
+                * Teardown flow may take some time, and the host may
not send
+                * us keep-alive during this period, hence reset the traffic
+                * based keep-alive timer so we don't trigger a controller
+                * teardown as a result of a keep-alive expiration.
+                */



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
