Return-Path: <SRS0=dgXS=5F=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6529C4332D
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Mar 2020 22:23:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 764052072D
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Mar 2020 22:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FJnvYZVR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="U5ngHfv4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="YoVNEpeD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 764052072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=F2HaWjSVthbgjhFpfkVqRT+cv1vRKw4Crg+58m8jI8Y=; b=FJnvYZVR6sWCqd
	MaobSfzCzdkZrG1gvr0PMwmbTg76d/TnEQZXTnaObpYUe1Moy9+/MXZ4aTiCddJXTs18DK399uljs
	4RAd5DSWUyTiSGmUwhqaSQk5hh7QrZxM9eCdoZPp5rMuwT8BI/0UIcBU9GTyqyG9HtgCxlXYw5B2O
	TQ9ro+6LLhPOhGfkK1iop0oY6zpF29YSo2q06y8WS2lTjO/ViNwzGYIW3t392W2PSg9FJKXWUckJ/
	Qb1OEURn5hp8+XEZC6Pt8QnWm/Sk7wqVO+y2Qo49OimdilKFFBPkIbUw/ybBZwtsoetkUWWfug1VO
	VBklO6dIpZnMDaEr1mAQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jFQ39-0002DF-RO; Fri, 20 Mar 2020 22:23:31 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jFQ36-0002Cj-SX
 for linux-nvme@lists.infradead.org; Fri, 20 Mar 2020 22:23:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1584743026; x=1616279026;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=uaeSSlrAuKPINyZ0ugmuLOUWAlIza8aOsH40ykw95Lo=;
 b=U5ngHfv4ms7ZZiuZgAJgkbmHzNBmUU14B4/x97SdIlrKtRVz6okPFSp+
 uOR3BQomPAqMRDoT8zYeVBiIE9qO8dWF3Nu0qpRIhj5oWFrvnXZEb1j4r
 mW1Qwscs0TFQe0AbTgjF18Pcyoe0eAbbcAsaZfamlP54BHl5y6141LgKa
 hy9VAKQKg3qD98RU4mNgOXYqU8GT6VclV5PccV8DQBE+8s2aayPNv5/U4
 axz4U+j02FnMR1q/spp8ZR/xWfzsdVk4qXEQUuv8QRYKjfsX1VztOROtA
 iUITEWxIZbposLEGpfmtrZxq1nvag/xlXdlpVjdyxOAdHDNJ3BMLSUFR8 g==;
IronPort-SDR: UfU5+tLNTnbfw3o6aTNHHVKSHBTr4wkOVZo0mfRw31ibBMLCulfqC5J182WXFRaH6SSmNo1tt1
 EdaKFYRN0LV8O3qriJGK4g+Bmus3wt/k9TQOP2iKwHeYWlsSpRj+pny1Qij4+LVLhmEfTzfvbn
 k4jC+QTg27Fd7M5IsQmLy6K7TWdBVJWoXTiuLFI12xtktrBLWzhv/jjPH+ChTpBu1775YU99x1
 hahH9t0wsSMX1I1rwyHvwqHFJmGR6EI8uI9ajkRJ9hZL/UpcTKNRUe/q4kkOnru0ryODegI/aR
 nkE=
X-IronPort-AV: E=Sophos;i="5.72,286,1580745600"; d="scan'208";a="235267062"
Received: from mail-mw2nam12lp2047.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.47])
 by ob1.hgst.iphmx.com with ESMTP; 21 Mar 2020 06:23:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a7qh3OeoWvWsBIXuwbWwED1HLfledFGWOCUCNSTJkHvYRQnhfkZnBH7v0Rqi8lNgH8yfVUEziZSu20rJdX+IQhMulhoned1r5Wj1TgJM8yxDxFK2yZCSdiusmiuY3veMI+O7XyVk53/4kjcTD5qvNlbgifY9oWgv2gSVCo6BNmnyf14nnKBuZaDq5A3DPKHJ+1zP/1nVGWG9ky7aONyWfkbgzMhUe8WNgrIsYSzQJQfxSfEsc3ECNgTD+g4Gkdg4+NpRblSaPSXPzY/pQyY9dEoJAUyGHUec+Zdimu3rh9EC78+G5xZi+5wRb6DUqX4OFttjrlPhnPZWVF2jkmKyNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TzQYyR5l+RQLVmjcTwUS1dHCwxM2FbSdyZrJONGTt6s=;
 b=fi0aeVPTT9gyu6ac/Mjg5oB9LTTT3RkTrFtm1kvoMDICW9W/aCS3Ktaa5wEODtCDasuj8vR8ceJzl2phLDkcQhGDvOqSZDZXHWBuXu39e5UuRbH5yf0oxGlOlMflFDxI0AUL1DuYiqFOONYprDLQURlm0K5ovrjELKqhi5hLrEC+FKNHJC+Ll36vctcCFgvYFTZZYryjLwuwz+Gb01DIUaKGeXpjaBhg2K8xhYr2KV4lhj0hcl0iOAgxds7IdahXRpD2U/xPtmZYJxpMHHGi/VoFUbfMiC/J+C8F/9UaKD7YaUG7o9B6FKjUvkVtlLc3WOJYZt5VveD6MVcCLJytMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TzQYyR5l+RQLVmjcTwUS1dHCwxM2FbSdyZrJONGTt6s=;
 b=YoVNEpeD+9nROXIGuc/HLXuopLEfvp+oUxjoUiM9bIxZyIqBCitFF7G3vzLcikNKcuuzAYGHEUnzojBru0tJXeKLxMTikeZVYqP3vGZvbBGNPUxcmypGsIqWYbreSm2JRxq1wAnKpLMSENZXWgYkZNsn5bWcluzFyBnA3xhMlA8=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3829.namprd04.prod.outlook.com (2603:10b6:a02:ab::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.22; Fri, 20 Mar
 2020 22:23:25 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733%7]) with mapi id 15.20.2814.021; Fri, 20 Mar 2020
 22:23:25 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "tasleson@redhat.com" <tasleson@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvmet: Kernel oops when doing mkfs on nvme-tcp device
Thread-Topic: nvmet: Kernel oops when doing mkfs on nvme-tcp device
Thread-Index: AQHV/v+4UHRulWo1ZkOrantftUuKDQ==
Date: Fri, 20 Mar 2020 22:23:25 +0000
Message-ID: <BYAPR04MB49658A8992A3408F75B7977886F50@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <17c25d8d-0dc2-9dc8-2b65-954034c23646@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3b354514-7238-4b29-efd8-08d7cd1d4eba
x-ms-traffictypediagnostic: BYAPR04MB3829:
x-microsoft-antispam-prvs: <BYAPR04MB3829FC719A76A438B1DA09A286F50@BYAPR04MB3829.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 03484C0ABF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(199004)(110136005)(478600001)(5660300002)(33656002)(6506007)(86362001)(316002)(2906002)(53546011)(81156014)(66446008)(66476007)(64756008)(52536014)(71200400001)(66556008)(8676002)(66946007)(9686003)(26005)(186003)(55016002)(76116006)(81166006)(8936002)(7696005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB3829;
 H:BYAPR04MB4965.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pxD8JsLKnIJtUXXwFNsu02QsoiAy/aUi8V7AwGyaQw3wgL2zhIPy7LVYLu9Wqcl7CTipxuWB+DibaDpc2qgYKIMD49VOA3W4jHp7GR80kYJJ9Bq2jNRWU3KGkWwV9pi9DJzPIPy8hqskoffUgIU0mQ7/0qFTSmj8EurIgVNMujOzKzha6lwX+y5PA8C8Ya2rsumR9hkeayES3eyYWENGIdLnbv2zepEX8txmpvXC8uBs/OfuEEUtbparzF/wWQyejG4ZtupGeR/NbU0BdMA6dZeSrRJZlFqJI7VAAon8aPtb0ICi0wIUT7y4IL5ffQRBbVZc1Fr/tCZLiV2j3GGBJpGucREouS8aEEYel4GIy+C2QXZnH05/bh6Emc2sqkLm2j9nDsMrkU3upgd2VmeYwqZGOWY9v428I529n5dorH3E0EiNKIfPlRlYm0BUbRcF
x-ms-exchange-antispam-messagedata: ei0M2gja69C9/vpAiwsNoarFsHoly/Spu6nifgjyddS9YrTnf+q7PNCoWH5QAyNBlMA4Tt+jYiJNUkWP4T3eDWFgO+F+Vk688ouwFeecYUuVK7h78IGajeTzbzRTNyyVtKvrTUnQsYrUJv7BWCbrFw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b354514-7238-4b29-efd8-08d7cd1d4eba
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2020 22:23:25.3654 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: slbS9cY5RjnNmX2csinGyLzVvnZaRlyvnPSb7kDTpHHKm/0YWL+JmZ+7VJyzs/SCwr9QD6WP7IEzf/PVFlW+u9Tsk3S3/bWqimTDhKTi4Uk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3829
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200320_152329_014065_C6F25C9A 
X-CRM114-Status: GOOD (  10.57  )
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

On 03/20/2020 02:37 PM, Tony Asleson wrote:
> Using two different VMs with nvme-tcp, I tried to create a fs and it
> hung with kernel oops on client VM.
>
> Both client/initiator and server/target are running Fedora 31,
> 5.5.8-200.fc31.x86_64
>
>
> # mkfs.ext4 /dev/nvme0n1
>
> [  125.031254] nvme-fabrics ctl: Failed to read smart log (error -5)

Seems like your controller does not support smart log (just an 
observation, though I wonder we do implement the smart-log for block
device name-space).

> [  125.031509] nvme nvme0: new ctrl: NQN
> "nqn.2014-08.org.nvmexpress.discovery", addr 192.168.2.80:8009
> [  125.034133] nvme nvme0: Removing ctrl: NQN
> "nqn.2014-08.org.nvmexpress.discovery"
> [  125.246827] nvme nvme0: creating 1 I/O queues.
> [  125.249356] nvme nvme0: mapped 1/0/0 default/read/poll queues.
> [  125.250788] nvme nvme0: new ctrl: NQN
> "nqn.2014-08.org.nvmexpress:NVMf:uuid:23d9d3e0-a83e-45d7-a902-3e80679385f8",
> addr 192.168.2.80:8009
> [  125.257115] nvme0n1: detected capacity change from 0 to 34359738368
> [  153.188620] blk_update_request: I/O error, dev nvme0c0n1, sector
> 67108736 op 0x9:(WRITE_ZEROES) flags 0x5000800 phys_seg 0 prio class 0

Seems like it failed to execute write-zeroes request which may be
a part of the mkfs.ext4. (although not sure though)

Is your back-end device (/dev/sdc) supports write-zeroes
(handling of request REQ_OP_WRITE_ZEROES) ? Even if not block layer 
should just emulate write-zeroes, so I wonder if protection is needed
when we report oncs (which Ideally shouldn't).

> [  153.191395] BUG: kernel NULL pointer dereference, address:
> 0000000000000008
> [  153.191440] #PF: supervisor read access in kernel mode
> [  153.191468] #PF: error_code(0x0000) - not-present page
> [  153.191495] PGD 0 P4D 0
> [  153.191513] Oops: 0000 [#1] SMP PTI
> [  153.191534] CPU: 0 PID: 237 Comm: kworker/0:1H Not tainted
> 5.5.9-200.fc31.x86_64 #1
> [  153.191574] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS
> VirtualBox 12/01/2006
> [  153.191619] Workqueue: nvme_tcp_wq nvme_tcp_io_work [nvme_tcp]
> [  153.191660] RIP: 0010:nvme_tcp_io_work+0x303/0x790 [nvme_tcp]
> [  153.191692] Code: ff ff 41 8b 86 98 00 00 00 83 f8 02 0f 85 6d fd ff
> ff 49 8b 46 28 48 89 04 24 49 8b 46 78 49 8b 56 68 41 8b 6e 34 41 2b 6e
> 38 <8b> 58 08 44 8b 60 0c 4c 8b 38 48 29 d3 49 01 d4 48 39 eb 48 0f 47
> [  153.191783] RSP: 0018:ffffbc118020fde8 EFLAGS: 00010206
> [  153.191810] RAX: 0000000000000000 RBX: 00000000579f5801 RCX:



_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
