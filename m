Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1628C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Nov 2021 10:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=U5eYYK3vTF9yBAkJSjT1IokJmrwKa7uPLwujM6wzPAs=; b=a4dPzpRXYko/9GvMQIjI/paly5
	PFz8OimhPsFaAeYxFp6uLU1hKw+jX+apG8yDVQQyQUEpjJx4o6CJCMHG/m7oxT5p8FVKC7BqIpZs5
	VDFcBkUPj+hA5+FPdRG4mMOBVojqPOOYbAPlrykUlFbbbZStL2xrK2NqsMpnI9RePqSfTedMoD7HS
	Rqj9JSEyYD3614OMu9RbTgg+J9RVeqwtuxAHdHj9NSwvsaGl9bHti9rY3KSgh+pGWSECArCtTqJQf
	OyLJD+sDt5yxq46teqiobN94c/M2ymZLLVa/Ektlwh6l5obUdMhVY4gKmdkt+IwHNr/zz+PKU91Wf
	RAN2ttEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mqYgu-00A40s-CR; Fri, 26 Nov 2021 10:42:52 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mqYgr-00A3zY-Hq
 for linux-nvme@lists.infradead.org; Fri, 26 Nov 2021 10:42:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1637923370; x=1669459370;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=CTWpZZjATZrOk3yeQI8xK5pypLpfa0+4rtZk1vty0fg=;
 b=Dn0SipQtowk4NIWDE3cCkwxPdhmmOIPBDqFzMDwibsh07O+XsxxsnHZ3
 ++6eLetheaODapaiQCDP2sBh/9u3xdIvZN7c06ZddZKUSPYekRQHX5b31
 qk6udB5bHC8kQj02h5NankjIjERk8xfyqbESZ8AaiNzvtXB1LFOjuwSdG
 45ux8o2yMarjgpQqMkYxYtByJ46uVuctDFSxDNKOgh5YhBT1R8wAwepMY
 Z/PjFKQeq2F/YNWdbzO4T84GvO8eCtPBAOBTe/7hAVnrq7uOSkt4uNRko
 mXG+97Jk8z27lwDqPmrh0hISi7zQ9AofdH4Ggj4Pxpy278/HCCbVva6oA A==;
X-IronPort-AV: E=Sophos;i="5.87,265,1631548800"; d="scan'208";a="187737150"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
 by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2021 18:42:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzBn02DCrwCq3WDUf97xtv1pr9W/0PlyfF5GneQUM/1/QWSEjzL70KoYKBwGhl5r2Fg8seau+YfvyaONRnDzn9043svT0k3cQCPrP404QJqDVwKlJffp7zrnyuQ4POc5UITuhaJLIWyeOewH0llHCzJjgqRxCIy6+QIumv7MkiNq7Fn8AVDL1fIKyhSdH24r8YmGMpykBHzDs00nuFRICyhb94SZpYlRZk3j7eUP3I73/hN2MQ1ujB6iPvzh8m0C5dhJjbaYM/C17syX6dAZ8fFbRmyKBlC1FFlFvBQC4wkKnAGl25T4rcaBXsnPBKD9YJbRNYq2DQTU8q2W4nkt7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5eYYK3vTF9yBAkJSjT1IokJmrwKa7uPLwujM6wzPAs=;
 b=ZFB2a9KsWZTCpNWuJst5tg3yF7BZJNULhL+5CLFoLiKlMmXlCWPUK6KwRMlarJnfU4tiWDel4kuBGpbDtr66J0pC7Cngi5vmMXZkwByNrlLfkd0Dff7CsgAKCnWUfVTsU+U6B6zDzRVp0z/UpnjLTPwPyN70rXtmotapZDRZQtzCl+CZvV79hiY+Y2HLbKYDBzYJ7IaR68ASz05hePWhC+vMNFvznZvO4ghPcwLUNSKbsbO5aXFvPmOeFkvy38S4rj2+Rgcz9akAxFq8NoY8DZoq0Qz1Uj5vjwJhSCUm6zzlHEbD0O5G1SZ9Fx+e10I3dH44FsXOQMT9GQRfSVQ5Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5eYYK3vTF9yBAkJSjT1IokJmrwKa7uPLwujM6wzPAs=;
 b=D6N0vC9h3C3MsFY/R8cWgfamCFBn97uLP9OmAjjQIbKssdkjZtRExbMTHTfNbgtm5RBdyzC6JU0WJkT9vmcwS1g1F26duZWg5irvJT+Zi3S8cfdujaRvr4yNIffvPY9OHb7gwixRSqsmQQawc8VmzD5X7nvWkYtWGotDBXrQm+I=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by PH0PR04MB7320.namprd04.prod.outlook.com (2603:10b6:510:18::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Fri, 26 Nov
 2021 10:42:45 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::c504:3d44:5aef:f3ca]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::c504:3d44:5aef:f3ca%4]) with mapi id 15.20.4734.023; Fri, 26 Nov 2021
 10:42:45 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
CC: "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
 Niklas Cassel <Niklas.Cassel@wdc.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] nvme: report write pointer for a full zone as zone start +
 zone len
Thread-Topic: [PATCH v2] nvme: report write pointer for a full zone as zone
 start + zone len
Thread-Index: AQHX4rJY3tsBd4Y+70+8pYI5zoHXOA==
Date: Fri, 26 Nov 2021 10:42:44 +0000
Message-ID: <20211126104157.227400-1-Niklas.Cassel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.33.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b19c9666-ee50-4370-4a16-08d9b0c97b27
x-ms-traffictypediagnostic: PH0PR04MB7320:
x-microsoft-antispam-prvs: <PH0PR04MB732053634359C4E8EADABEAEF2639@PH0PR04MB7320.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:989;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mKY3aa6rABv+fPQTnTVgNDyI0Fev1Q4AKh2wnNjojeex7rM6eFRa1cgCEW6pw8hbu8wDv3xBNihX3fnI8Udda1bMdz52y1vtFSHc2OquCA0TdmxgcjyatsVnPXTlT/SYUqt1htAysnc7nhHr2hfzYqyE2vps1Y7Cbmp1napXEQ25MnT+9nt3ptlFILGeGZGAhAdEACLwCLQPhBSwcjl+gpt01A/xbd8B0LpEUPkcPQyLvbDhvldwK5BBhvBIR+bBw5p4mZDPwSfLcXf8pXqfXl9iyNFKAOfZDDmdJXUUSZub0y0U8R4LhGbSmHFjphLt2XZifXVFXl8J7I0m2ZgKoB6pVza5XGw0OSGG4CvCEQKPHMS3JPH4ogOIVQGSwUglFOxGOXU5vxvyIDvgI7owT9GCStwFpMP5B/Eao6ky071+Xw9O5qLFP/ASLT4lIgGlDZEmHIcWFRmt93yH4uqhMWi671FPSd7dy67/9GuMlwwkSuJ+o6ejoKP0DDWLoY6mBjwKD32nC0gbc0diaqI23Gg4eewD25PKHiD1IwxwGOZOKBhX+TuJkMTQyVg5SSg+AX5tz6HNFD0MooJdDV5laOqQk0laDfBxGp6KwB335/0Nusp0eC7n0U/WDRn+u/Ta6Hy1ck+3UwDo6u4XJ9PCw/sZdS9eZ9r0SpLhwJ5fVk1dJDD5KMAc61UvXONHwLmu4pz0vnYVufk2QOLWJOHdqw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR04MB7158.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(38100700002)(86362001)(122000001)(83380400001)(66446008)(2616005)(36756003)(6506007)(91956017)(76116006)(6486002)(54906003)(508600001)(186003)(316002)(66556008)(5660300002)(26005)(1076003)(82960400001)(71200400001)(64756008)(6512007)(4326008)(38070700005)(66476007)(8936002)(66946007)(8676002)(110136005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Xjp2jOq/mx0TtoPyHhxjN2w+TMRvuFUx9NLMWU72Y9g0hg1N3RSlONE0Io?=
 =?iso-8859-1?Q?sIIKc+ejnx1XGaC6cIa+ImXmep0ZCXGUcFkBrnESRZeAkx/GbPi6fgy64B?=
 =?iso-8859-1?Q?FXEq4pAJd1QMY/l9oJGo0I2cz1gxvJnsrBhFebLG8JsU6UBbtjkFCyzipw?=
 =?iso-8859-1?Q?/z2PogRf0+t9e/VaV6dchuQP1nJww+TCAp6Mj9u0nYW3YNWLv4yE2ke1Au?=
 =?iso-8859-1?Q?+L5eR+noSWb4itp5Qyuasf0TXy10XWJbN2U85j3D9vpVe6WDOoQG+jclRg?=
 =?iso-8859-1?Q?I8ol/soeW4edYxeBhQr6GRO64rj884H8SVQDP+GQWuJl8m9zGwVr8Li5Oz?=
 =?iso-8859-1?Q?OfDyPDmdfO9doSwtQARVjK5JnJFWrXFFGa/UpomxhMMYCkBMP0JlotdAD4?=
 =?iso-8859-1?Q?tF7M5X7uq1chEz/wC2VUR5fMAkugoaxzKnQ7LAsiXYsHhbMI0xMRj3kxX+?=
 =?iso-8859-1?Q?YokWmB1Cf87UpVq/2U0kInl8J7JTK1fkPCSSgRfHEmq1nO8NLaZKxU69g4?=
 =?iso-8859-1?Q?/79ZZKJ+M/OZ4YK+hxPW+aYiLR4MBJXbUQyswY0dYtw558gKxnmQQUO2Sh?=
 =?iso-8859-1?Q?Q6yzJ2B4v6eFFi/3FwXpgWcITU3afnDIZHnnGZaeBjmeFfpXlronHKobLe?=
 =?iso-8859-1?Q?AND0KpzEZ/owwcVszVrrAOpLCffsxsM3JpsReYclSEml593WzGyYNT7C0x?=
 =?iso-8859-1?Q?zGRwEOX9wYoirw70HBMlFCpJYm6A/IEg8xaqIFAgRxVFRqEzjMyqIP1zyZ?=
 =?iso-8859-1?Q?/4QJVQ7txWuTZ0LaQUkhQbPzOC/DVzFja9A1lwJL0ljMUYiqBkXEZhdZIf?=
 =?iso-8859-1?Q?8FG6vMiR9nM1IAzmEXd6RzrqDwLjC5ywSCdukNrpeQdaaJbiEHiEh2ZUhC?=
 =?iso-8859-1?Q?h4Bdr4ZQQR9MUn/aikASuUBXlBJyc79otfBL8utHJ+RJKL7iOvYNGOgJTz?=
 =?iso-8859-1?Q?HkpLDQWUgx0uBWLb4cAAfCuL3si69IsUAPagWcr8TVMY83X0dMYYC/Os0E?=
 =?iso-8859-1?Q?qUu29r7+9PGxtl9kPxuGySvUPoYHWyiAzZQZBI8rEnaf/acn6GUZMM0ib5?=
 =?iso-8859-1?Q?RBkPx9gzud9/vXdLLrvz2AB/a5vmoVx3KJbg17N/C1rJB2w/LaseqPXiA3?=
 =?iso-8859-1?Q?PzT1i0GQoPWszFpINK4mtDGGiKtN2E6qEg9sBP03fVZYLtpMQe52gUj2t5?=
 =?iso-8859-1?Q?Y4rejzLEFRetE1QwcUickTZcTjlikMQHv8FWGSoRLN4osyNxTKX8MCCAsT?=
 =?iso-8859-1?Q?EsJxQQ0nvHDcwMauaX1qL/LQQ8HwOMJz4Rt6mI3DlAFttcd+y906QkNrfD?=
 =?iso-8859-1?Q?cGCQrE9GWuXDU72m94/CQp+336bv3aylKI6YdjfMqz12HXIBcdZzyC5s6f?=
 =?iso-8859-1?Q?aj3bf19zz9HlbpPNPydPpXGdokWXPbZI0e46TUe3XMCllNYiySohM6EAIT?=
 =?iso-8859-1?Q?Lfe37Adxx6PpJCs1xUJ38yB7bpY4JGylloLQ6s8l2jEinIwBHExQ1rtRL4?=
 =?iso-8859-1?Q?Cmf331AAchM5ue/m8uWASsnSS2PD0yjcSChdM4zKZhCBYcSH5MwjzgBz5z?=
 =?iso-8859-1?Q?K5Mmlxom2Plc6sZvYw6ZNAFSLy0JI/QRoYkWwPQnZHqcI23jbgHpY6vzea?=
 =?iso-8859-1?Q?3SWVnim2IOrTJC5PBz/9F2aymGKE9oWSCORE7RjiCfID5mXL5NTOuVI85c?=
 =?iso-8859-1?Q?dx9ltIXoYaVJXZIVxGgFWT8/QsuBDjqg0/DZRkjD?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b19c9666-ee50-4370-4a16-08d9b0c97b27
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2021 10:42:44.8911 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AD+QvLziG+ZsF/Bne3ylB6lwjUi1qwc92zvE+I7Ai/sYsEyzkbrKPnAs1y9KV//tf67IGuR5u1SM20PdzQqGPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7320
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211126_024249_727197_217FDD63 
X-CRM114-Status: GOOD (  20.13  )
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

From: Niklas Cassel <niklas.cassel@wdc.com>

The write pointer in NVMe ZNS is invalid for a zone in zone state full.
The same also holds true for ZAC/ZBC.

The current behavior for NVMe is to simply propagate the wp reported by
the drive, even for full zones. Since the wp is invalid for a full zone,
the wp reported by the drive may be any value.

The way that the sd_zbc driver handles a full zone is to always report
the wp as zone start + zone len, regardless of what the drive reported.
null_blk also follows this convention.

Do the same for NVMe, so that a BLKREPORTZONE ioctl reports the write
pointer for a full zone in a consistent way, regardless of the interface
of the underlying zoned block device.

blkzone report before patch:
start: 0x000040000, len 0x040000, cap 0x03e000, wptr 0xfffffffffffbfff8
reset:0 non-seq:0, zcond:14(fu) [type: 2(SEQ_WRITE_REQUIRED)]

blkzone report after patch:
start: 0x000040000, len 0x040000, cap 0x03e000, wptr 0x040000 reset:0
non-seq:0, zcond:14(fu) [type: 2(SEQ_WRITE_REQUIRED)]

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
Changes since v1:
- Minor commit message rewording.
- Use if/else instead of setting wp unconditionally and then
  conditionally updating it.

 drivers/nvme/host/zns.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index bfc259e0d7b8..9f81beb4df4e 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -166,7 +166,10 @@ static int nvme_zone_parse_entry(struct nvme_ns *ns,
 	zone.len =3D ns->zsze;
 	zone.capacity =3D nvme_lba_to_sect(ns, le64_to_cpu(entry->zcap));
 	zone.start =3D nvme_lba_to_sect(ns, le64_to_cpu(entry->zslba));
-	zone.wp =3D nvme_lba_to_sect(ns, le64_to_cpu(entry->wp));
+	if (zone.cond =3D=3D BLK_ZONE_COND_FULL)
+		zone.wp =3D zone.start + zone.len;
+	else
+		zone.wp =3D nvme_lba_to_sect(ns, le64_to_cpu(entry->wp));
=20
 	return cb(&zone, idx, data);
 }
--=20
2.33.1

