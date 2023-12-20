Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB95C3DA6E
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Dec 2023 17:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kRDPnmFgWbHgPYTerUj5FgTamZUM8roBYgQfYQe3c/g=; b=GSa/cM1bwvs288h0tM1/3GNhqI
	Hs6Z61YBLM7MftS5Csn57WQgSohZMWOafIF4H7cWLc7c/a0yPR+o2chr8pYDy72od+idPzdXtf9S1
	ssuxGTcgHN6OuyZWBISGzDE/671uTAeuTkKcS80/SvyranRo7uo9/pO7zylMmX2wavdtVc08BxyAM
	C7VcrL5og2LY8moevGZW8JNryY6MvgXtafK7Th6U3rZdjcf7M+tsfSfnvXL7GL23+6hN4CtmFHxz7
	O6Pf68xv/LEULZTBHKu5H6VwbQ0Yd0JN1LWlbJWQVqVrgMDtfzRXgzAg5rUuYEmuBMYL1ThrPlI0s
	tIqngY0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rG0ml-000drx-37;
	Wed, 20 Dec 2023 17:55:11 +0000
Received: from us-smtp-delivery-120.mimecast.com ([170.10.133.120])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rG0mj-000drY-16
	for linux-nvme@lists.infradead.org;
	Wed, 20 Dec 2023 17:55:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parallelwireless.com;
	s=mimecast20180910; t=1703094906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kRDPnmFgWbHgPYTerUj5FgTamZUM8roBYgQfYQe3c/g=;
	b=lr7vlfu9wuih8S6+1LXvB0CKmsG16x7WMV+r1R9FYR7kwcJxmIW8gSlbhTAJmBHp0FKvB5
	jrsbU9z76jtUFUay8Wu8yYv/me9Y2ztpxwrFvnzixnWd9eouTBNakk8ytCrGxEMej0oKsB
	dXT90HFB4IULUzeSVeC5afgM0Tl9LOc=
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-HcbRhoLPOKSQTGvGN2VA3w-1; Wed, 20 Dec 2023 12:53:19 -0500
X-MC-Unique: HcbRhoLPOKSQTGvGN2VA3w-1
Received: from SJ1PR19MB6257.namprd19.prod.outlook.com (2603:10b6:a03:45c::10)
 by SA3PR19MB7371.namprd19.prod.outlook.com (2603:10b6:806:313::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 17:53:17 +0000
Received: from SJ1PR19MB6257.namprd19.prod.outlook.com
 ([fe80::7319:5d0e:d827:ef39]) by SJ1PR19MB6257.namprd19.prod.outlook.com
 ([fe80::7319:5d0e:d827:ef39%5]) with mapi id 15.20.7091.034; Wed, 20 Dec 2023
 17:53:16 +0000
From: Sridhar Balaraman <sbalaraman@parallelwireless.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: [PATCH] configurable NVME IO queue count
Thread-Topic: [PATCH] configurable NVME IO queue count
Thread-Index: AdozbORtu98wW+LFQOGvoOwIqJcflw==
Date: Wed, 20 Dec 2023 17:53:16 +0000
Message-ID: <SJ1PR19MB6257DF963B8EC038DBA9111CB296A@SJ1PR19MB6257.namprd19.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR19MB6257:EE_|SA3PR19MB7371:EE_
x-ms-office365-filtering-correlation-id: 7b78f196-e871-417c-02bd-08dc01848b88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: AID2GepvtyIOY5eert7QOX+ElAIOG5Wlo8fb9iRt8sAoTpunUx9lOBwJW50rhINfQ5iQUPkuQVH8A8IyjFcTuCCss/LdlCHSShX1CD0+odIES4fNTgVmjIrcHk/43cwISk5izrKhV+RaPw+kdiX70Rs0wL9DomM3lTE8tRSThWd5X5nmIt/YD01yXb85Ov69yIwYtCMj7tKxH+fB0hF0sDopAaQc20m1gK16q8zgOcRJ8kSbaz68Fl5ZddkXKkA/TstVSldZms6ndh0897jYGhjLu16H5fK4iYw/Eu+vk+Dtz6y+fc2GTIzJk90zTBqD2hggHLnX31+PmkQIvE9JSaDJ2wqpo6w5ywfXqjOh+pVeSU+Jyw+g21ibtNFfIeacv5Ox00du/4QEo+WDEiTHg/n0X3ZkZUDWw9tIFOh6S5LnIda8FhthKGrpYG27MkuFcOe3Y6pg0L9PsxegTelbD8gAd1pjM8yLHNXZJ3qJccFr/TLySmHBXj/3qxwiAdheAhJBDqSlXHCCgN44YxoO8tkWIae6GCmdZxJ6vmS00DNXIJno+NyBGw82w9pU1Y8u2D79R+zyNBqpQ58sXq7ZDQ/PT+Llvc3ggHDNca1SFOVJYYk3Gw0pFFwC91DkWZnD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR19MB6257.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(396003)(376002)(346002)(136003)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(8936002)(5660300002)(8676002)(41300700001)(52536014)(6506007)(86362001)(2906002)(64756008)(6916009)(66556008)(66446008)(316002)(66946007)(76116006)(33656002)(38100700002)(122000001)(55016003)(66476007)(83380400001)(38070700009)(26005)(9686003)(7696005)(71200400001)(478600001);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eXxl8FjLQGmoDHmKaP7vRLkpIzROBBN+OpqMb354T4b3lqbPshwgxj5hJXTy?=
 =?us-ascii?Q?5KHVi0oBXxdnvv+SH3Qj4zVGe6JLcvM7zem8dLYa52hg7kUu7MMvSQXFBASE?=
 =?us-ascii?Q?JcrOQuNreWm3+3m7UBHJww87HKe29wI5aYKLqTyJy9ydTlBbcLYUU1Ip3ENJ?=
 =?us-ascii?Q?VTdmNMqlrkGC5qiFmELSf99+4eFr3mKBevxjTO94spf9R+7LzemYzfurbw4Z?=
 =?us-ascii?Q?QFmc9LmVhhq9txxsLMg230V2dCb2rmuxrr9kG4CDo5eixBVIHUNunb3xX1CN?=
 =?us-ascii?Q?3gHCuVFJF00AC8z7yrCoHd3rmAZHjS4hs90Nb5r3AEvYX1/A2N/lSHMej+1Z?=
 =?us-ascii?Q?+cWj2qt+fWdIYKZKCI9GmDRwKDRl2hnrGzMTZ3DAJG6BhDiLh3DdjiCSeaJU?=
 =?us-ascii?Q?7TVTML/PUTEaHF8cdkP59d2SFKp2+k57C8H7APyRag6fuvQIanE2gSD3Xuun?=
 =?us-ascii?Q?y8Y+Crj0dELRHqQZ/uHxKKa0shYqG5354CEVxne1IEaJPY4eDPhL3JbZwRlQ?=
 =?us-ascii?Q?vekLMWib8Ll3TJ7JnJTLaKKRecP6sK8BJpQQSW2VUTuVse1qS5CL6rQrdd9h?=
 =?us-ascii?Q?HXd/NGWwxDrR+XV6i6YDaRuBkV/K1mlgakCFuE7YiWsJyeXDFEP7wGvvjDdN?=
 =?us-ascii?Q?jIsy9URAvwbv4mklItBnZwKK2coSwMCN1PUijhK8De5LWdBOnDvuEP1pwUYg?=
 =?us-ascii?Q?dh31tB71mi88P44YTvJN0bS6VM0CCFN+uHFpHsPYBV7hcSWePGdDJYif1E3h?=
 =?us-ascii?Q?RG7SLKn67DjhiqDluT4SqzlfGx1mhLmz1jkHh0N6PTzqmUioi7ZOts8B+cnR?=
 =?us-ascii?Q?5v9vNE2i5TprW/SRZ4U7EUTpkuR7gyi1GnHTP6R3JmqeaBRUL6JVgCvY4kQd?=
 =?us-ascii?Q?gOpY/gKCzY+E355XDSP8+a9X3ru3ESnqtjwOTkcyKi7Yma7omUcGlaWVhBwQ?=
 =?us-ascii?Q?I1qfIkBqrfQ387u/LoZgjAnMDYECTXNJc8y7YLpQ4MdTWyV7C3R08Qis3SsJ?=
 =?us-ascii?Q?f4hLmKxVj6XI3QDPSn3vv5IsUqBQqOyWiNoCMPrf68X6CBt9EGSzqLZbQv1c?=
 =?us-ascii?Q?2Z03P1foxzLd5xASfEnwAVTWwy4IlFOBzMNtcWlSutS9zW6+8urw7/Hwg2ur?=
 =?us-ascii?Q?RESfosZ5wyyjA4NfTH87la3uhSyU7pn0LEa8MqtaWK4qALjPFB7osfeTK0ev?=
 =?us-ascii?Q?gvcjNe6gYoeGIB6UvFlpmWXJ6ydEvdTH7hU0K68Kuuc8OZUS+di/rGkx1zBX?=
 =?us-ascii?Q?RcYR+OXQWcL5crSoEAU99Oehmr6iYN8DeSYWsxK/eaX+EEHpAks08Hon0vmJ?=
 =?us-ascii?Q?yOyaci5nvycjduW7TxaWvix5xb4ft/jLtlgt9jKNjXnIJvZherHbn5x2eqVw?=
 =?us-ascii?Q?JVcCwyXPIBDDeM5IsZVx4Jt5psYPDW2AYAMKN/cFYN2wWyFS2l9jg8Kp/b+2?=
 =?us-ascii?Q?p1yXhSschARxhN1FFynzVhG5gJmJpAqikilOO9N4jb5fmFoaEdcQEg5nGCbt?=
 =?us-ascii?Q?7o/sWy5cgXqbDMThaWbKqcEIwVZ/PP3HNsER/sxWUgdsmpifUEh0Ty13RU2Z?=
 =?us-ascii?Q?++qD6Tv7QQ4y9NTyCBG/HZ7TqiJc+1F2on0meBm84KggDNFQR4bvvhHZpa6o?=
 =?us-ascii?Q?GQ=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: parallelwireless.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR19MB6257.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b78f196-e871-417c-02bd-08dc01848b88
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2023 17:53:16.7787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 991bd471-bf03-47c4-af97-0c3362264c70
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: slTo7pXk+PUcbEihqLstaoDlUWGM3K3ufT+NbTxpVoqDs7vyHMU/dBNRs288ppc/XE9UJ+EeiJi51SBjZZ8cXHdFojusnmVBZX86wvYAbxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR19MB7371
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: parallelwireless.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231220_095509_479228_7C7BE34A 
X-CRM114-Status: GOOD (  13.56  )
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

Some NVME products are providing more number of IO queues,
so driver is allocating queue based on number of CPU or
maximum number of queues by device, whichever is least.
At the same time, corresponding queues would be mapped to IRQs.
But in case of RT Linux, where we need isolated CPU and free from IRQ.
Unfortunately NVME IRQ couldn't be reduced due to more number of CPUs.
After making IO queues as configurable parameters,
we can reduce number of IO queues which inturn reduces number of IRQs.

Before configuring queue count:
[    4.384566] nvme nvme0: pci function 0000:05:00.0
[    4.450307] nvme nvme0: 32/0/0 default/read/poll queues
[    4.457427]  nvme0n1: p1 p2

After configuring queue count to 2:
[    5.920776] nvme nvme0: pci function 0000:05:00.0
[    5.939455] nvme nvme0: 2/0/0 default/read/poll queues
[    5.941487]  nvme0n1: p1 p2

Signed-off-by: Sridhar Balaraman <sbalaraman@parallelwireless.com>
---
 drivers/nvme/host/pci.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3622c5c9515f..051d99e0264d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -86,6 +86,10 @@ static const struct kernel_param_ops io_queue_count_ops =
=3D {
        .get =3D param_get_uint,
 };

+static unsigned int total_io_queues;
+module_param_cb(total_io_queues, &io_queue_count_ops, &total_io_queues, 06=
44);
+MODULE_PARM_DESC(total_io_queues, "Restrict total number of queues to use =
for IO.");
+
 static unsigned int write_queues;
 module_param_cb(write_queues, &io_queue_count_ops, &write_queues, 0644);
 MODULE_PARM_DESC(write_queues,
@@ -2171,7 +2175,10 @@ static int nvme_setup_io_queues(struct nvme_dev *dev=
)
         * If tags are shared with admin queue (Apple bug), then
         * make sure we only use one IO queue.
         */
-       if (dev->ctrl.quirks & NVME_QUIRK_SHARED_TAGS)
+
+       if (total_io_queues)
+               nr_io_queues =3D total_io_queues;
+       else if (dev->ctrl.quirks & NVME_QUIRK_SHARED_TAGS)
                nr_io_queues =3D 1;
        else
                nr_io_queues =3D min(nvme_max_io_queues(dev),
--
2.25.1


