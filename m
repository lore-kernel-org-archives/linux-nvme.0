Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C24DC83F10
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Aug 2023 14:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IhZo9HTMeYHJ99KUn4xRaNtn0eqI4FRUFoQojNm54bY=; b=dBX5sFSDOY3a02ay5lNoacCd7c
	C2KyHXhUHc3dtxCvaSXjYSR53K572E4YzyotAFqLZmxD4lHzRvI5LQaLIBp/byU5E2Q8CKTfHInxY
	kdviHNBDFBRnlWdzQ2PsJ3CUsrgpp8x91qylAEfDXUjlQz4MnuRHmS9Ec56n4EJqS1iGtAJ7xp++3
	6ES7wZV6qSTKcvjwGunE/BmAJOXXE3+GdJXYGfWL+Ves0rGa9UqjufiyhWJAAkvnjXVd5IGBM63d1
	OP84NV7uuACCiZ/FvN3/cbVdYSbyBjUnJD7RcDnXco0myBvMJF1TYHJWSauJGL0OFwv6fT/nV5YEi
	35I4cJ5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qbiMe-00FPn9-0C;
	Thu, 31 Aug 2023 14:09:40 +0000
Received: from mailout1.w2.samsung.com ([211.189.100.11])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qbiMb-00FPma-0t
	for linux-nvme@lists.infradead.org;
	Thu, 31 Aug 2023 14:09:39 +0000
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
	by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20230831140936usoutp01ef5855e3986a7a5ffd6aec6663e0ae5b~AfRH6ZFvp2674626746usoutp01G;
	Thu, 31 Aug 2023 14:09:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20230831140936usoutp01ef5855e3986a7a5ffd6aec6663e0ae5b~AfRH6ZFvp2674626746usoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1693490976;
	bh=IhZo9HTMeYHJ99KUn4xRaNtn0eqI4FRUFoQojNm54bY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=rQH09SItmFoC2UWth20Gk0meVaThmN557+hxnXiuWOhjTFoik32uYGDeLC9JQeicI
	 JOMPKN6SJvho3lxJqNn4zIDOzURIfDQVZWiSEnbJqotopLFEP7qtWj5rFjc+66GTD0
	 /Hy5nTGYNVxmzsKb0aTTDp5iuWvsklm/JHOhYC5o=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
	[203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20230831140935uscas1p123d5883fa6e0ea16cd09ed2274ebdac3~AfRHtpr563122831228uscas1p1v;
	Thu, 31 Aug 2023 14:09:35 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
	ussmges2new.samsung.com (USCPEMTA) with SMTP id 86.E8.40279.F1F90F46; Thu,
	31 Aug 2023 10:09:35 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
	[203.254.195.92]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20230831140935uscas1p1d7406a58aae26e1ce2adfa5f33770fb9~AfRHXo_BT0339303393uscas1p1e;
	Thu, 31 Aug 2023 14:09:35 +0000 (GMT)
X-AuditID: cbfec36f-4cbfe70000009d57-2e-64f09f1fef61
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.145]) by
	ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id F7.47.31410.F1F90F46; Thu,
	31 Aug 2023 10:09:35 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
	SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2375.24; Thu, 31 Aug 2023 07:09:34 -0700
Received: from SSI-EX3.ssi.samsung.com ([105.128.5.228]) by
	SSI-EX3.ssi.samsung.com ([105.128.5.228]) with mapi id 15.01.2375.024; Thu,
	31 Aug 2023 07:09:34 -0700
From: Vincent Fu <vincent.fu@samsung.com>
To: "joshi.k@samsung.com" <joshi.k@samsung.com>
CC: "ankit.kumar@samsung.com" <ankit.kumar@samsung.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "gost.dev@samsung.com" <gost.dev@samsung.com>,
	"hch@lst.de" <hch@lst.de>, "joshiiitr@gmail.com" <joshiiitr@gmail.com>,
	"kbusch@kernel.org" <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"vincentfu@gmail.com" <vincentfu@gmail.com>, Vincent Fu
	<vincent.fu@samsung.com>
Subject: Re: [PATCH v2 2/2] nvme: avoid memory corruption for sync
 passthrough
Thread-Topic: [PATCH v2 2/2] nvme: avoid memory corruption for sync
	passthrough
Thread-Index: AQHZzn3HbbHWMYP4VUyCJVIZ+ut3NbAFAdSA
Date: Thu, 31 Aug 2023 14:09:34 +0000
Message-ID: <20230831140918.85341-1-vincent.fu@samsung.com>
In-Reply-To: <20230814070213.161033-3-joshi.k@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsWy7djX87ry8z+kGHS81rNYfbefzWLl6qNM
	FuffHmaymHToGqPF/GVP2S3WvX7PYrGhTdCB3WPnrLvsHufvbWTxuHy21GPTqk42j81L6j12
	32xgC2CL4rJJSc3JLEst0rdL4Mro3/iVtWAaX8WKO/+ZGhgncnUxcnJICJhIbNh9iqWLkYtD
	SGAlo0T/z6PsEE4rk8Sl958ZYapWfN3ADJFYyyjxcPJaVgjnE6PE/+f7gVo4gJxljBJzOEFM
	NgFNibf7C0B6RQT0JfqbL4JtYBY4wixx4uRUFpCEsECAxJ7Wfywg9SICgRJv+jwh6o0kftx7
	xgxiswioShz/up4NxOYVsJZouvaSDaScU8BKYsv0UpAwo4CYxPdTa5hAbGYBcYlbT+YzQZws
	KLFo9h5mCFtM4t+uh2wQtqLE/e8v2SHq9SRuTJ3CBmFrSyxb+JoZYpWgxMmZT1gg6iUlDq64
	AXa+hMAVDome3qdQQ10kPh25Aw0faYnpay6DvSIhkC/xri8GIlwh8evHLagSa4mFf9ZD3ckn
	8ffXI8YJjMqzkJw9C8lJs5CcNAvJSQsYWVYxipcWF+empxYb5aWW6xUn5haX5qXrJefnbmIE
	pqHT/w7n72C8fuuj3iFGJg7GQ4wSHMxKIryxZu9ShHhTEiurUovy44tKc1KLDzFKc7AoifMa
	2p5MFhJITyxJzU5NLUgtgskycXBKNTDNYAjIymJIZtt0Odvy9LTtJywUlSa51uxcPnGDpwXv
	pcRnrwUiM4pX1BecT9dMmPPrf61WBzOncw2P5jH59mdrIjlau6051r1rfXDhoUaTn/rM+J+2
	67o2H62+mz1basqta5Ntl8xLN3d6p5IpbDSRZWF2nOM+170bmk2656RFLSpW/KyzLXfHPVeV
	UPlLKpIJZxO2b/jA+UPfZ65Qq0OKde7umU9srn/M3ZG2ojRpiXzAMdvUrxmf5y6qnhuy+mWT
	2oGN/Z+mmSZwqPv+Cd2WvlSdza/3hvvj87ynp4d2ZG0tMP5oo9W5dHL4pgN9MqcK9K5P+zxv
	l86UdRN/rp8kqP19488KQ5avYT93qVkosRRnJBpqMRcVJwIAqGVZS7IDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsWS2cA0UVd+/ocUg0ufRCxW3+1ns1i5+iiT
	xfm3h5ksJh26xmgxf9lTdot1r9+zWGxoE3Rg99g56y67x/l7G1k8Lp8t9di0qpPNY/OSeo/d
	NxvYAtiiuGxSUnMyy1KL9O0SuDL6N35lLZjGV7Hizn+mBsaJXF2MnBwSAiYSK75uYO5i5OIQ
	EljNKHHpSgc7hPOJUeLzmeVMEM4yRolf358DORwcbAKaEm/3F4B0iwjoS/Q3X2QBqWEWOMIs
	ceLkVBaQhLCAn8Spg5fZIYoCJXqW/2SEsI0kftx7xgxiswioShz/up4NxOYVsJZouvYSzBYS
	sJRY9/YtI8guTgEriS3TS0HCjAJiEt9PrWECsZkFxCVuPZnPBPGBgMSSPeeZIWxRiZeP/7FC
	2IoS97+/ZIeo15O4MXUKG4StLbFs4WtmiLWCEidnPmGBqJeUOLjiBssERvFZSFbMQtI+C0n7
	LCTtCxhZVjGKlxYX56ZXFBvnpZbrFSfmFpfmpesl5+duYgRG7Ol/h2N2MN679VHvECMTB+Mh
	RgkOZiUR3lizdylCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeXdMuZgiJJCeWJKanZpakFoEk2Xi
	4JRqYLrg+KujJPdMw70/uUVNt7Y+Drq+9nrJT81rwvXfvdmYHOe/vfftUPztZZuS+Cc/nN1R
	tb/Uc3rE79P18eFbepx6bynYyVo4aBt+jNhz9PX820kun1NjlqiV/AxisNqe9a79Z/ecfV3B
	Ch/CiteUBps9qVyy5ez6oor1tmvtt03kK64x2dnoeXT3lPfl3eknTpatWn/klHti7CK91UUX
	oht6glXyV01JZyw7uGTSg5c3mMwTddVWBpy9yezUmft7zepzHh6alYvmKMw+pnJmbUeyzte4
	/R+kq1pLT2i+jJfeUffw/7WXuzT+d79YsTNkl9/F16mfzqa8WnJ1z6KFP7i/vk25PsnXquoE
	S53y9tVVSizFGYmGWsxFxYkAt3qJGUcDAAA=
X-CMS-MailID: 20230831140935uscas1p1d7406a58aae26e1ce2adfa5f33770fb9
CMS-TYPE: 301P
X-CMS-RootMailID: 20230831140935uscas1p1d7406a58aae26e1ce2adfa5f33770fb9
References: <20230814070213.161033-3-joshi.k@samsung.com>
	<CGME20230831140935uscas1p1d7406a58aae26e1ce2adfa5f33770fb9@uscas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230831_070937_443428_7A9EE1C6 
X-CRM114-Status: GOOD (  14.79  )
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

I tested this patch on a QEMU NVMe device.

I formatted the device with a 512+16 lbaf with a separate buffer for metada=
ta:

nvme format /dev/ng0n1 -m 0 -i 1 -p 0 --lbaf 2 --force

Using the latest fio I wrote some data to it:

./fio --name=3Ddifdix --ioengine=3Dio_uring_cmd --cmd_type=3Dnvme \
  --filename=3D/dev/ng0n1 --rw=3Dwrite --bs=3D512 --md_per_io_size=3D16 --p=
i_act=3D1 \
  --pi_chk=3DAPPTAG --apptag=3D0x8888 --apptag_mask=3D0xFFFF --number_ios=
=3D128

Then I built nvme-cli with the following patch:

diff --git a/nvme.c b/nvme.c
index b5b05857..807a6643 100644
--- a/nvme.c
+++ b/nvme.c
@@ -7581,12 +7581,7 @@ static int submit_io(int opcode, char *command, cons=
t char *desc, int argc, char
                        pif =3D (nvm_ns.elbaf[lba_index] & NVME_NVM_ELBAF_P=
IF_MASK) >> 7;
                }

-               mbuffer_size =3D ((unsigned long long)cfg.block_count + 1) =
* ms;
-               if (ms && cfg.metadata_size < mbuffer_size)
-                       nvme_show_error("Rounding metadata size to fit bloc=
k count (%lld bytes)",
-                                       mbuffer_size);
-               else
-                       mbuffer_size =3D cfg.metadata_size;
+               mbuffer_size =3D cfg.metadata_size;

                mbuffer =3D malloc(mbuffer_size);
                if (!mbuffer) {

Using the patched nvme-cli I ran commands like this:

./nvme read /dev/ng0n1 -n 1 -s 0 -z 0 -c 255 -z 131072 -y 8 -r 0 -m 0 -d ou=
t -M out-md

It reads 128k of data which should require 4k of metadata but provides a bu=
ffer
of only 8 bytes.

Without the patch there are no error messages but with the patch the read
request fails and I see error messages in the kernel log.

Tested-by: Vincent Fu <vincent.fu@samsung.com>

