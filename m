Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56552C6FD1C
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Mar 2023 00:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mABTjSOvwHUaTDqid5yfSLfPPkOPRHSdizsYFycprZU=; b=RAsrMUBuiQ3CQllQjN8SHqY4of
	sZQSjWouO9PUOvAhH8wPS92acyRXKTQ3K/Xl7fBt2UoTlHEI66NY5bgpDylZwvYtv2iXXxIwRVrN3
	seHjo8ZU4wCOQ0tFWhHLrVe4y79TKeJ507e9esryFx6wypbtnmJjuK9lI6TAPFsEUup1KIAGs9mh3
	0dc8flcX9hSlsM6vb3OoyMCfplqFArsgEjJTVNFIXzkUbMvheRZxWbRMwnwgC/ZDHAa/iXz4F/jDW
	Yf0qW9FMehSTGOK4pNVDqQWbo1otPyksPm1zmmYDbFlXwNIwQu0imBdm3b0cSKrZ6pSTvljdbNVyj
	BS978GVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfrqi-005sm9-12;
	Sat, 25 Mar 2023 00:33:36 +0000
Received: from ironeb4.johnshopkins.edu ([162.129.199.140])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfrqc-005slh-2C
	for linux-nvme@lists.infradead.org;
	Sat, 25 Mar 2023 00:33:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=jhu.edu; i=@jhu.edu; q=dns/txt; s=jhuiron;
  t=1679704410; x=1711240410;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=teGnopXF5RgXnfvWVy4O0GQbp5Ub8MwBYpDIsUQeoRo=;
  b=zOzPGvMYC98iYbIwTLWAaV+aRyBCYcf3vV+c0RF8UoCPLTocoMakzPKW
   1nDDoKs67FbKvYCVnEQAaj7cp+htjkAwQeCsuwXY3zUcNA4UXD07SbP0y
   UhKoXIYI0HXZNqy1sICuXHfP7bN5244cQKcO6sPFPq2FSht8LR0NL8SHB
   g=;
IronPort-SDR: 5NzTtWr9bfTdnzV4wnQfyAceAMDkuUi6ZEmDOAc52yDhe1kPpWHaI4KIHy6nbkheHo08Wsylm6
 TEJZV8tw8hGGOP2by9o+ggyxHO6jfrhkw=
X-IPAS-Result: =?us-ascii?q?A2FSBQDKQB5k/4SErQpUBh4BPAwCC4Fkgi5zgVyEU49hA?=
 =?us-ascii?q?QEBAQEBBoEkHgOFZYVzkFCBLIElAxg+BgkBAQEBAQEBAQEIAUQEAQEDBIR+A?=
 =?us-ascii?q?oU7JjQJDgECBAEBAQEDAgMBAQEBAQEDAQEBBQEBAQEBAQYDAQEBAoEmZGqBT?=
 =?us-ascii?q?4F/CwMxDYI3KQF1TTsBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEFAoEITwEBAQMEHCABATcBDwIBCBguECIlAgQOhSwDMbI7CIE2gQGCC?=
 =?us-ascii?q?AEBBgQEnE0YRgEJgWsJCQGBCC+DTI1pQn2BEIEVgnowPoQ0EINWgmmBCY8oJ?=
 =?us-ascii?q?4h0CoE0dYEgDoE9gQQCCQIRa4ESCGtcgR0EQQINZAsOb4FLAoJPNwNEHUADR?=
 =?us-ascii?q?jo+ATUUIQaBL0IkBQMLFSpHBAg5Bho0EQIIDxIPBiZDDkIhFjQTBlwBHA0LD?=
 =?us-ascii?q?hEDUDSBEwQvgVwGASYknRYleIEEgTwfkyywe4QEhFuccINqk1CRcpdqp3ECB?=
 =?us-ascii?q?AIEBQIWgWOCFnITgyJPAQIBAQENAgEBAQMBAgEBAQkBAQEBjlSDO495dTsCB?=
 =?us-ascii?q?wsBAQMJi0MBAQ?=
IronPort-PHdr: A9a23:O8Yk2RW9DUBmSI2S/TXN4PHcoXbV8Kw/UjF92vMcY1JmTK2v8tzYM
 VDF4r011RmVB9idsa4bwLCP+4nbGkU+or+5+EgYd5JNUxJXwe43pCcHRPC/NEvgMfTxZDY7F
 skRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQviPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCS9bL9oM
 hm7ogfcusYIjYd/N6081gbHrnxUdutZwm9lOUidlAvm6Meq+55j/SVQu/Y/+MNFTK73Yac2Q
 6FGATo/K2w669HluhfFTQuU+3sTSX4WnQZSAwjE9x71QJH8uTbnu+Vn2SmaOcr2Ta0oWTmn8
 qxmRgPkhDsBOjUk62zclNB+g7xHrxKgvxx/wpDbYIeJNPplY6jRecoWSXddUspNUiBMBJ63Y
 YkSAOobJetWr5fzqkUToxuiCweiB+3vxT1UiXH50qI3yPghERjc0QA8A94CrHXZodPoP6kSS
 +C1y6zIwC3fYvNSxzj855LHchY8rv6SR7J7bNffyUkyFwPAlFqQqovlPy2U1uQRr2eb7/drW
 OW0i24ntgFxuDmvxsQ3h4nLhoIV10rI+jtkz4YoPNC1TlNwbtG4HpVKrS6aK5d2Td04Q2Fuo
 Cs217MLt567cSQU1Zkr2gLTZv+DfoWU4B/vSOafLCl5iXxler+yhBK//VWkx+HgWMe5zEtGo
 ytZntTOqn0AyhPe586aQfV+5keswSuD2xzJ5u1ZI005m7DXJ4Mvz7IujJYfrErOEjHulEnoj
 aKaaksp9+215+j7ebrrp5qROJVohgzwN6kih9awDv89PwULQWSW+OKx36D580LjWrVFlPg2n
 7HcsJDdOMsUuLa0AxRQ0oY/8xa/CCqm0MgAkXkHMl1FfBWHgpDmNV/TIf72CumxjFSjnjhq2
 vzLP6TtD5vTInTZnrbhfLB951RGxwUu19xf5ZJUCqwbLP3tR0DxqcTUDh4/MwOq3+bqEMhx2
 p8EVW6SAKKUPrnevUKG6+4xOeWAeYEYtCjlJ/gg/fHujHs5mVEHfamu2JsacGu4HvR7I0WDY
 HrsgcwMEWUKvgojVuDllkCNUSNLa3a0RK0z/is7B56+DYffWoCth6SM0DmjEp1Mem9GEkyME
 Wvvd4icRvgDcieSIs5/nTwCT7ShT5Eu1RSptADgz7pqNe3U+jUGupLlz9h14PDTlQsu+jNqF
 cic3XyCQH1ukmwUQD822bhzoVZhxVebzah4n/tYGMRX5/NIVAc6KJHdw/V8C9DsXwLOYMyES
 FKnQtW9HTExVcg9w94IY0ZzAdWtlA3M0DSwDLAIjbCLA4Y08q2Pl0T2cup0znfL0uEFghEDR
 cJLfTmqj6t++g6VA4PMlEydv6GyeKIH2zPX/2rF0maF+kpfVVgjf7/CWCU2YkbGpNL161mKd
 L+zDL0kNRVA1cWCYv9RasDzjFZuRvf+ftnSfjTiyC+LGR+Uy+bUP8LRcGIH0XCYURBc++hb1
 XqFNA1rACCnriqeCTF1Dlvgbgvq9vU2s3K0SEI4jmToJ01s3ra44FgZ0PqbTf5A0rcNoix0r
 TJyER601M7XDNzVoQ1nce1cbNox7U0B23jesll/PoHmIqx/1TYj
IronPort-Data: A9a23:LoVfpaKbeBlfcOLiFE+RLJUlxSXFcZb7ZxGr2PjKsXjdYENS0GcDz
 WceCm6BOP2JZjbwc41zaITj9E0G7ZWGx95mQVZorCE8RH9jl5HIVI+TRqvS04F+DeWYFR46s
 J9OAjXkBJppJpMJjk71atANlZT4vE2xbuKU5NTsY0idfic5DnZx4f5fs7Rh2NUw2oLlW1jlV
 e7a+qUzBnf0i1aYDUpJs8pvmDs31BglkGpF1rCWTakjUG72zxH5PrpGTU2CByKQrr1vIwKPb
 72rIIeRpTqFokh3WrtJpZ6gGqECaua60QFjERO6UYD66vRJjnRaPqrWqJPwwKqY4tmEt4kZ9
 TlDiXC/YRl1G47VgvshbztnTC16NIN396TsI2fq5KR/z2WeG5ft69hVI2QKAqAoo7gyWjsI6
 v0ebjkBKBKDmqS7zK/TputE35xldZawetpE4Dc5lmux4fUOGPgvR43R5cJC3TQYhMBTW/vSe
 qL1bBI2NkydPUURYj/7DrpurOuBo0K8KQFSjw6NhYsx0TjW9D1Ihe2F3N39P4biqd9utkqRo
 2PL+SL9DxQdPdi3ziKI9Gmrm/XEkGXkVIlUH7q9ntZugVuO1ikVFhgbfV+6uuWizE+4VchWJ
 0Ed9mwpt6dayaCwZtTmUBikv3OU50BZAIAWDOw8rgiBjKjU/kCUCnVsoiN9VeHKffQeHVQCv
 mJlVfu1bdC2mLHKG3+b6JmOqja+ZXocIWMYPHNWVgsY+djgiIMzk1TCQss6SPy5idj8GDfRx
 TGWrXFg2OpK1JRXj/q2rQLdnjahhpnVVQpktAzYU1Ws4h59eIP4NZej7kLW7KgcIYvAFguBs
 XEIltKw9ucLCZ3RxiWBTP9UQOOy5+ufMT70g15yWZQt6m31qXKkeIlR5hB4JVtoa5hbJmawO
 hOL5g4Ivc1dJnqna6NzcrmdMcVywPiyD8nhW9DVcsFKM8p4ewKw9S1zYVKdgjL2m082nKBhZ
 ZqWfJr+DXseDqg7njO6S/1Hge0G/Q8b+Vz+dcmlik/9l6WfYjicRfEHMEbIY+wktfvWrALQ+
 tdZFs2L1xQGDrKhO3CNrdZMIABYN2U/CLD3t9dTJ7yKLQdREW08D+PcnOE6cIt/kqULyurFo
 iOnVklDxAatjHHLM1/aOH14Z7bzQptv9Cx+ZnZqIleunXEvJ4Sv8eESe4ZuJesr8+lqzPhVS
 fgZepzeXasWE26bo2sQPcvnsYhvVBW3ngbfbSOqbQ82c4NkWwGUqMTveRHi9XdSAye63SfkT
 2ZMCu8GrUI/ejlf
IronPort-HdrOrdr: A9a23:2At/a6vUXjIdGzOR4v+nfOFb7skCx4Mji2hC6mlwRA09TyXGra
 +TdaUguSMc1gx9ZJh5o6H8BEGBKUmskKKceeEqTPqftXrdyReVxeZZnMffKlzbamfDH4tmu5
 uIHJIOceEYYWIK7voSpTPIaerIo+P3v5xA592ut0uFJDsCA8oLjmdE40SgYzZLrWF9dMME/f
 Gnl656Tk+bCBIqh7OAdx44tob41r/2vaOjRSRDKw8s6QGIgz/twqX9CQKk0hAXVC4K6as+8E
 De+jaJqJmLgrWe8FvxxmXT55NZlJ/K0d1YHvGBjcATN3HFlhuoXoJ8QLeP1QpF4d1HqWxa0O
 UkkS1Qffib2EmhO11dZiGdnzUI5QxeqEMKD2XoxkcL7/aJAg7SQPAx+r6xOiGplXbI+usMiJ
 6jlljpxqZ/HFfOmj/w6MPPUAwvnk2ooWA6mepWlHBHV5ACAYUh5LD30XklZ6voJhiKnrwPAa
 1rFoXR9fxWeVSVYzTQuXRu2sWlWjA2Eg2dSkYPt8SJ23wO9UoJhHcw1YgahDMN5Zg9Q55L66
 DNNblpjqhHSosTYbhmDOkMTMOrAijGQA7KMmiVPVP7fZt3c07lutry+vE49euqcJsHwN87n4
 nASkpRsSood0fnGaS1rel2G9D2MRCAtBjWu7NjDsJCy83BrZLQQF6+dGw=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,289,1673931600"; 
   d="scan'208";a="12056060"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-MessageIPDirection: Outgoing
Received: from esgmtwex16-32.win.ad.jhu.edu ([10.173.132.132])
  by IronEB4.johnshopkins.edu with ESMTP/TLS/AES256-GCM-SHA384; 24 Mar 2023 20:33:27 -0400
Received: from ESGMTWEX16-23.win.ad.jhu.edu (10.173.132.123) by
 ESGMTWEX16-32.win.ad.jhu.edu (10.173.132.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 24 Mar 2023 20:33:21 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (128.220.36.253)
 by ESGMTWEX16-23.win.ad.jhu.edu (10.173.132.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 24 Mar 2023 20:33:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGo5licFZhjyv6d0acv2u97vw61raF5uA1Mlb+8EB8H2k/YYz2eRB62Pe0rWzfl6UqwqjHrggj52JgF36FUbXw3m9BeXZUAFSn41buV8DKd3RJ1yseniWJkxtSF6xvY00RX3Lsmvesmps5gS0nuO+ro2Ke6kvxdiRth0iQuJv99yWTLhstX+9RiNiAsacQkc0evh7GfoqCAySv/bVIu57w6Wycki2KudNI/T262n1Yh37r/E+qyudRw36Kt5UtJbgsEUtjXJsaZ94+SNk0ZKSFo1uhOeZI4a8Pp9na8Tt/UZj7Ra4WGdc7KqgglzlivXH1ODHiixRlF8WXwZDQwDUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mABTjSOvwHUaTDqid5yfSLfPPkOPRHSdizsYFycprZU=;
 b=DCioPvZao3sdMgcoiRKR3vxnGM5GzkwZ8pogepJiGGh+7hddfLbO+4hKzLHDyRG/6/0rjwR1//pnZwrozvFFQKA9CZy3OAvu4VCf/JNK4TgzxE0DlTyPsn9Snj25blKROHogPPQIJxMZQDlw93itQuHCkbgO5gnUIcAln7cWOzF2p5bt2kcviXAnIWv9Y7Z7Uqgjq0VjzN6f77Sw51KIRwjHXwuokzjy8aZtCnVsFBYcjQC4+ex+BGme2R4sU3TX4gMSTuhH1Pa7cxaWgDUsRMboplfaPLONDOANDT4gGmstGjvqahZYzOkeneHqTV4VqBswelJNBy6mzioo+S4F+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jhu.edu; dmarc=pass action=none header.from=jhu.edu; dkim=pass
 header.d=jhu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=livejohnshopkins.onmicrosoft.com;
 s=selector2-livejohnshopkins-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mABTjSOvwHUaTDqid5yfSLfPPkOPRHSdizsYFycprZU=;
 b=YQ2V34Np4tFhg1wJB+hphES0jTvVk3fby4Kha2nFGntSf7/q2avW9WFbT4tRIdRqGvk2fRPt7RQ5VVFk9m7JVARrogi0qjHwvFneZOORDioEKgYEVYakMrh4taO9I6/ECbe0cQIqXxEMErnaeWuibImG7PnJ2HFvtFXNYO6bE5s=
Received: from BY5PR01MB6100.prod.exchangelabs.com (2603:10b6:a03:1ab::26) by
 CY4PR01MB2503.prod.exchangelabs.com (2603:10b6:903:6c::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.8; Sat, 25 Mar 2023 00:33:14 +0000
Received: from BY5PR01MB6100.prod.exchangelabs.com
 ([fe80::b47d:4bdd:536:2dd1]) by BY5PR01MB6100.prod.exchangelabs.com
 ([fe80::b47d:4bdd:536:2dd1%4]) with mapi id 15.20.6222.008; Sat, 25 Mar 2023
 00:33:14 +0000
From: Alexander Shumakovitch <shurik@jhu.edu>
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: Read speed for a PCIe NVMe SSD is ridiculously slow on a
 multi-socket machine.
Thread-Topic: Read speed for a PCIe NVMe SSD is ridiculously slow on a
 multi-socket machine.
Thread-Index: AQHZXh2z2NkXUzjTO0KKexGZO2Rp268JnT0AgAEJSgA=
Date: Sat, 25 Mar 2023 00:33:14 +0000
Message-ID: <ZB5BSJgeqaOkiXFF@hornet>
References: <ZB1JgJ2DxyTMVUHB@hornet>
 <e2df2f18-aaf9-89d5-6fed-aa1fb663f69c@opensource.wdc.com>
In-Reply-To: <e2df2f18-aaf9-89d5-6fed-aa1fb663f69c@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jhu.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR01MB6100:EE_|CY4PR01MB2503:EE_
x-ms-office365-filtering-correlation-id: f4d64847-9b86-4774-5ddb-08db2cc8853b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RtfMJff+rmo0PfX8qXlVeh4AeMp4Nkdo/ZLPGzrsGzRbFp0P4HsylEeRzJTbCTdJQHze/CAC0sy/V2Ro7p637ajIzcBhrqT5sJWUZNICyQfTuft3BEWfpjYo60H93m0IySjYttHm45IidFGGW74b4P0rZtpG1+LE8jwj50bCmoAI4Kdngw8MfqRcHRmUdC/hakXzfdOFrO8laOVqcPqvUy+seUeBPSsxGPetmqavH0RMrBKrfIn0CBVKuKUaKpUJXOBw4kBM3qW7FWGzV+u6yUloG7hGlXGu9Srx/QufgzfTO74vg+411T+ziEBE+O3oJD2BeB0AMgYzwWlXzyq5g14U9PxzwQz1svTQIAhCGReOCy/WQ8sQAq6nmIHsXa/BW/7p6Wprj7dzwh8Qx3pUNwxBsJ6gxD9f4v2qsnsxZdJ0dftFC46xzawP3xO9/PaG4Nlx5UfBa1KcSdrtTK9O+8kDhnjqZOrsKrvnNrb0zTTNiIq1aOCRlaS5GmQYOcGtxsCH+6lEs+4knW2hex+mhT3ORpVahrHHnImRAGOv8YgkZibMveLb0LEbNyrtaug/30QVZrUapObVaEwD33LGQEuwf1Xao1H81yCeUFEVvfFpuSe3wP6UWANSIrentcLRBtMAVhkirZgJdNzGrsknwh6q9ZthN4QQHOKcCA1W8sfSFn1dTvb/cWv6PN6HxXO7vUI5o7R5B6VKTrxvvSl5Qw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR01MB6100.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(451199021)(41320700001)(786003)(26005)(6486002)(6506007)(83380400001)(186003)(122000001)(38070700005)(6916009)(66556008)(33716001)(2906002)(66446008)(76116006)(66476007)(9686003)(316002)(64756008)(71200400001)(478600001)(66946007)(75432002)(6512007)(5660300002)(8676002)(4326008)(91956017)(41300700001)(8936002)(38100700002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?koi8-r?Q?BLiW0aGu4RCrL4dsyabClIovjuedASVWktZZNj1kXFTTf+e4uW9Sx6sTJGw2Hc?=
 =?koi8-r?Q?yMaVOKEH5aWlvkJ0Ac5uALcKoWKEV8FDqTrELbzVomCzdXytc+6ce8VHbKFCOc?=
 =?koi8-r?Q?Ph02+JjLoNgGJbojt9S9Ud4Esty3KJz1bRqBQ4PGbf2ce/q7M0p89qGRq49ZY9?=
 =?koi8-r?Q?Zilj5OGcchEl2cw5a7eW7F8Tav00aVpfPlqS1iYSoz3KL2luXqjvJyUwHyDEic?=
 =?koi8-r?Q?7bt2wA53+h5G2jS7AqR5HwBjvMu9OnsJIUoGf1QOAOVbaW7k7YeD1e9f2/rV1h?=
 =?koi8-r?Q?CISVBs6UEesLkU0MJuxT4lqryq4W3kqBIItY8YDYvCYht5Ge3P3a0Eh64xDo5J?=
 =?koi8-r?Q?+mvBAvAu6mx0Cnwrwq8VVNWmQUWcVyTRyNKXJQrLqT9x7gOH/WT8FpPU9rTN4m?=
 =?koi8-r?Q?nezn3GHCm3HH8dC/FXosLiaaEH+bV51y6aQMM0lhctllf4Rv/Cl9NlS2zklTxh?=
 =?koi8-r?Q?0HPH5d+s5mOa2MavxIAZalxeHAJ9q+q+b9xMcnr4tfiMW+awE2cQWT/fVjLI2l?=
 =?koi8-r?Q?66pP8KXxysD8SwnJhr30ipHYdgG105nnQEPsKTxXQ1ShlqxgByTxWee+v9nyLB?=
 =?koi8-r?Q?Uxr14dd2NH9nDOyOOrPPjuDRMIy0RGTvgvErKqlPmKSlEBXEdKru4JHvWfM3Zr?=
 =?koi8-r?Q?R9mH7BTP4YJRNOaNheA4bI2YMsg+FKj7m/vpk1PI8S2cFO7yRssu4KmoYwYCHx?=
 =?koi8-r?Q?59Rt+6fTAbjWHxq2fq0qjAGNm9OnsNvYR5yu+bNjxYM+Sh3XqW9b/kNKsc+BRz?=
 =?koi8-r?Q?s4BEMCmHST0n23ppTVuqVH/tQE0Gik949wCLvvusV9Ldvy+UzTR6ncvZOydlNb?=
 =?koi8-r?Q?7Vix8WzguEak0XR1BYBHwzyPhdr7JWZUTSvIQllbSaVINxnUd6JR/woP0CHDyc?=
 =?koi8-r?Q?nbNJcSew8rhp+btIxy8kS0iJKI0BLGb38Jvwu2zdX1s1UDdxz8kU5tryuj+3Zh?=
 =?koi8-r?Q?3ePgZweUtEXf0ISaCo5GExfLXQBSEHv9prmTuYcYQ6YekKEul1BWUieDAK3YOh?=
 =?koi8-r?Q?HpCSBRdSK+pUkfzsFT0qz1y6yhvHP59LGcU4pOjPc3AlZ+RkZ5AvloJaDiv4Je?=
 =?koi8-r?Q?sCAqYnAQhX0lMbk1Lg98DKtK950YTwUgVmDPndZ3+Dma+JFhhRh14WaNPFie65?=
 =?koi8-r?Q?E5y/HDrr80msvkh+WCqTFf8Qx9a5TSlOIk6LEt8VSWFxytIkep+c2QAA1kHRzW?=
 =?koi8-r?Q?5HaGOmvp52qcEaQCKlf8UCoe+hrLC/oDmfyiGqFF3LWqWc7Ztwnjjord2uuzmk?=
 =?koi8-r?Q?j+3wiApSsdD/NeqWUeTeYzDx8hB2tTyl0LQaLyE9gl4Zll3VHgrfO25atwJHKP?=
 =?koi8-r?Q?jQTeb3WWG4VqR1qpr5ciHrAzJedYm6tmA9e7fafkUjUIOFdkHmOPxmmsY4cfug?=
 =?koi8-r?Q?Zj9k/o4VKNL2WPi5juesgiHx/Y2+nSIfc6FA/r1JSqU+qpHVXZTZfXBEUbjL0d?=
 =?koi8-r?Q?lmCiUG+r15SsinR8+zPv1nARVnkj0CRU1FgC+OQEnqqbL1KJfXETWcw1SfDdxo?=
 =?koi8-r?Q?Qvhl8KDk1r/LfDXJmZIM0wxNQIvu5C0vWdvPE5ggIlyCjXnEgu?=
Content-Type: text/plain; charset="koi8-r"
Content-ID: <888C14AD98D1484BB94215CDF4946162@prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR01MB6100.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d64847-9b86-4774-5ddb-08db2cc8853b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2023 00:33:14.2780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9fa4f438-b1e6-473b-803f-86f8aedf0dec
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aVL7B6HcfVqWF42EcQM4xvqoYegi+ggeylhfm13u+UP0dvXSCfOWvDvMpfLxMFI6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR01MB2503
X-OriginatorOrg: jhu.edu
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230324_173331_278274_6A86A3C4 
X-CRM114-Status: GOOD (  15.85  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Damien,

Just to add to my previous message, I've run the same set of tests on a
small SATA SSD boot drive (Kingston A400) attached to the same system, and
it turned out to be more or less node and I/O mode agnostic, producing
consistent reading speeds of about 450MB/sec in the direct I/O mode and
about 480MB/sec in the cached I/O mode. In particular, the cashed mode on
a "wrong" NUMA node was significantly faster for this SATA SSD drive than
for a NVMe one at about 170MB/sec (both drives are connected to CPU #0).

So my question becomes: why is the NVMe driver susceptible to (very) slow
cached reads, while the AHCI one is not? Are there some fundamental
differences in how AHCI and NVMe block devices handle page cache?

Thank you,

  --- Alex.

On Fri, Mar 24, 2023 at 05:43:42PM +0900, Damien Le Moal wrote:
> It is very unusual to use hdparm, a tool designed mainly for ATA devices,=
 to
> benchmark an nvme device. At the very least, if you really want to measur=
e the
> drive performance, you should add the --direct option (see man hdparm).
>=20
> But a better way to test would be to use fio with io_uring or libaio IO e=
ngine
> doing multi-job & high QD --direct=3D1 IOs. That will give you the maximu=
m
> performance of your device. Then remove the --direct=3D1 option to do buf=
fered
> IOs, which will expose potential issues with your system memory bandwidth=
.
> =

