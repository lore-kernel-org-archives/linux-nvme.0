Return-Path: <SRS0=KS3B=PB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AE4C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 14:40:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F153610FB
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 14:40:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2F153610FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vGtjGO0r8a9IKVpFM210WKRQB9WiCq78gfJpzz7FbqI=; b=KCRxioWOwROqhBKdqoqwyp9Rsu
	TRzmxpCjoRpegUvq9xnGEUdgUzTCG7MTB2rW+vj7AMKW5Pp2DvzWUZZRozsn6CKAqna8HlsZjvZP9
	V27NaQm8GKNmNgvu59O2wd9FvQOWjUIRcnTJzrYt8r6TMEYRIJOW5PKiOmKP02CkRZdCrisvPcLRQ
	Jy87kXiWOvURhvidTERADSGaTFlqQ/5GYU9QduzVvvcfUutE8cnSGUpv/8HaIpt3S/yOB+r/z03ts
	YjRv4qDDNzq6v/+Ks+5ISyhSNZIUpFjhdx7LJTIGI4EL4SnPpTtHCotdH3gGe193/XV8t5x3sbzJZ
	fRSGokyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mafQQ-00HCEC-Bq; Wed, 13 Oct 2021 14:40:10 +0000
Received: from mailout1.w2.samsung.com ([211.189.100.11])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mafQN-00HCCp-8A
 for linux-nvme@lists.infradead.org; Wed, 13 Oct 2021 14:40:08 +0000
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
 by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id
 20211013144003usoutp014a9fd5ed58f20c164dd1802d6bb8b045~tngmgL5M93238232382usoutp01f;
 Wed, 13 Oct 2021 14:40:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com
 20211013144003usoutp014a9fd5ed58f20c164dd1802d6bb8b045~tngmgL5M93238232382usoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1634136004;
 bh=vGtjGO0r8a9IKVpFM210WKRQB9WiCq78gfJpzz7FbqI=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=Qe8AZ7LVjx4SllamKxQ8kJjdcgLl1NDsp3T6sPyY6yEzv18ZHXRoSAO/u1o/+5MQO
 rJgI3Gr+RWefInxv13RsnmUV5Dkrq/WnwQAFsAhOWNBxzgJs0p8bD70F+iUU5RJdyN
 Ty99fDE7ZK412RyaOUyN4uTtI9eBBeECsEmFE5TI=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
 [203.254.195.111]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
 20211013144003uscas1p2f7b8683f1b087ff8e008b4b44d903bd9~tngmUsHul0298802988uscas1p2y;
 Wed, 13 Oct 2021 14:40:03 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
 ussmges2new.samsung.com (USCPEMTA) with SMTP id 05.05.03480.3CFE6616; Wed,
 13 Oct 2021 10:40:03 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
 [203.254.195.91]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
 20211013144003uscas1p1afa4735aa905ac97a40863b8dfae68c9~tnglr2uFR2793527935uscas1p18;
 Wed, 13 Oct 2021 14:40:03 +0000 (GMT)
X-AuditID: cbfec36f-ec7ff70000010d98-e5-6166efc3c18a
Received: from SSI-EX1.ssi.samsung.com ( [105.128.2.146]) by
 ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id CE.2E.26904.2CFE6616; Wed,
 13 Oct 2021 10:40:02 -0400 (EDT)
Received: from SSI-EX1.ssi.samsung.com (105.128.2.226) by
 SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.2242.4; Wed, 13 Oct 2021 07:40:02 -0700
Received: from SSI-EX1.ssi.samsung.com ([fe80::ed94:2e33:daa5:4d68]) by
 SSI-EX1.ssi.samsung.com ([fe80::ed94:2e33:daa5:4d68%13]) with mapi id
 15.01.2242.008; Wed, 13 Oct 2021 07:40:02 -0700
From: Adam Manzanares <a.manzanares@samsung.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: Yi Zhang <yi.zhang@redhat.com>, "minwoo.im.dev@gmail.com"
 <minwoo.im.dev@gmail.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [bug report] kmemleak observed with blktests nvme-tcp tests
Thread-Topic: [bug report] kmemleak observed with blktests nvme-tcp tests
Thread-Index: AQHXtcGhQNsZtuBti0+ykcyTuiTmO6u8mgEAgAAFI4CAAAu0AIAALSsAgAAoXICAABJ+AIAArReAgAMM/ACAD2ybgIAA+0IAgAAUhwCAAEDlAA==
Date: Wed, 13 Oct 2021 14:40:02 +0000
Message-ID: <20211013143954.GA277262@bgt-140510-bm01>
In-Reply-To: <a6401bac-cfd0-9a29-ff82-dd548590301a@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0293F0C2F0DAC04181DDF3DAAC28EC2B@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsWy7djXc7qH36clGnxs17J4f/Axq8X8ZU/Z
 LX51cluse/2exeL6uWlsDqweO2fdZfc4f28ji8fmJfUevc3v2Dze77vKFsAaxWWTkpqTWZZa
 pG+XwJVxa2EzW8FypornXeuYGxjvMHYxcnJICJhItE0+xNLFyMUhJLCSUeLW6TWMEE4rk8Tv
 5+3MXYwcYFVPW4Mg4msZJf6uWcQK4XxklLgyYTIbyCghgYOMElMOKoHYbAIGEr+PbwRrFhFQ
 kXjzJheknlngFKPEg8v9YPXCAh4SR1/3s4PYIgKeEj+3roSy6yT2fJ0HZrMIqEoc2/iEEWQO
 r4CpxIojuSAmp4C9xN+7ziAVjAJiEt9PrWECsZkFxCVuPZnPBPGYoMSi2XuYIWwxiX+7HrJB
 2IoS97+/ZIeo15FYsPsTG4RtJ3FvejMjhK0tsWzha7BeXqA5J2c+YYHolZQ4uOIGOLAkBM5w
 SEx8/h9qgYvEtF/7oGxpoNuWMUEUXWOUWP5oDiuEc59RorXnLzTcrSUW/lnPNIFRZRaSy2ch
 uWoWkqtmIblqFpKrFjCyrmIULy0uzk1PLTbKSy3XK07MLS7NS9dLzs/dxAhMRKf/Hc7fwXj9
 1ke9Q4xMHIyHGCU4mJVEeA0zUhOFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8zJFTIwXEkhPLEnN
 Tk0tSC2CyTJxcEo1MHXEV7DtfbOX9f9MlqK+n6ubnrUtOXFn2Z8Z1iWKObW5JR4/FPb/mCsm
 M+X0lwQHy2d3VKM2cjCdfPKkcnP/jyzW8NjHlm1Cbc+mPZA5E74zNL2i7ny1715/5t5LF/kf
 tCSa2+ky19uYnJ3M/rY4JHqrEke+kP0DifjPXJ6l/nv9Hwj+uSiVtfl3H9O94uwHWaoiMzOz
 91ks5ajTM9PItZeTs3k1hXXunMC7l2xW//I7aMJ7J7Hs1ubQiHOe/tJbvLUecO9M4tz1K3RX
 2O+UxjMLjN+WyMySdrfONsj9Ul0sai9/234T+ypupj/MnOozJO8da2rztTq20yj+x0dLtyP2
 C0P/Fr3SntFSVeigxFKckWioxVxUnAgAT6z4wbMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsWS2cA0Sffw+7REg1d6Fu8PPma1mL/sKbvF
 r05ui3Wv37NYXD83jc2B1WPnrLvsHufvbWTx2Lyk3qO3+R2bx/t9V9kCWKO4bFJSczLLUov0
 7RK4Mm4tbGYrWM5U8bxrHXMD4x3GLkYODgkBE4mnrUFdjFwcQgKrGSUeL37ADuF8ZJTob1jC
 BOEcZJSYuWcScxcjJwebgIHE7+MbmUG6RQRUJN68yQWpYRY4xSjx4HI/G0iNsICHxNHX/ewg
 toiAp8TPrSuh7DqJPV/ngdksAqoSxzY+AbuCV8BUYsWRXIhdP1kkbvxbxwIS5xSwl/h71xmk
 nFFATOL7qTVMIDazgLjErSfzwWwJAQGJJXvOM0PYohIvH/9jhbAVJe5/f8kOUa8jsWD3JzYI
 207i3vRmRghbW2LZwtdgvbwCghInZz5hgeiVlDi44gbLBEaJWUjWzUIyahaSUbOQjJqFZNQC
 RtZVjOKlxcW56RXFRnmp5XrFibnFpXnpesn5uZsYgRF8+t/h6B2Mt2991DvEyMTBeIhRgoNZ
 SYTXMCM1UYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvy6iJ8UIC6YklqdmpqQWpRTBZJg5OqQYm
 1s7y+BXGsjFHXvcq/pXJLfOzriqcVn2f5zr/T7t58x8c8us68mmfym6JGxEh1lmORimH2UJC
 JWUXFc+d/KZ3AcuM2Y2fXkTMXeQS4r1BmC27TDVOWVpnV97zkPL0aml9jg2CN06cL3Z20Gr3
 XHskSPLRT1s+i2vlVzrDjjHqMEaW2pi0uYhqcsWLl1lN9FxYmXtX5tQfzcSqtIjKGzZ7721S
 +qfKuPfb0isMnczpjyV3qVUee3Gf+c/297fvPfRfZpDgr7Pd229vyg6r17b/CyefiONbm/pC
 oqaCY51MVEiq31r7zO0bvyyZ/Hh72ZZrKssZXKZ9tcxXCP29PS/yf/MOg2M8HXUhM3emv1Ji
 Kc5INNRiLipOBADjL9yLTwMAAA==
X-CMS-MailID: 20211013144003uscas1p1afa4735aa905ac97a40863b8dfae68c9
CMS-TYPE: 301P
X-CMS-RootMailID: 20211002230919uscas1p1bc872acda3a68abc1438443d78ac921b
References: <0a8810e0-4c42-4275-acd6-475fd42485fe@grimberg.me>
 <CAHj4cs_icpHAf7wN3LFt7avcPcrhjOYiSnU8SnCLQN1ObkRV1Q@mail.gmail.com>
 <CAHj4cs9QBFXca-rnP05ZmWBKDJv4aviiDQ=q2_JihMQuESE7OA@mail.gmail.com>
 <1b992460-26a6-cff6-bee4-b81ac28e93f5@grimberg.me>
 <CAHj4cs8Vff_C8FnFciHtYdnifoOHBrNtaGN1Fvpg5m2gV8JpZw@mail.gmail.com>
 <CGME20211002230919uscas1p1bc872acda3a68abc1438443d78ac921b@uscas1p1.samsung.com>
 <05d2844e-81fb-0180-03cc-423cedfd7ac7@grimberg.me>
 <20211012183446.GA264712@bgt-140510-bm01>
 <CAHj4cs94Ts7iLBjw+1Dn3FM9sjj7sTx7j=30ytshH9YTA2jdDg@mail.gmail.com>
 <a6401bac-cfd0-9a29-ff82-dd548590301a@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211013_074007_517351_CEF166B6 
X-CRM114-Status: GOOD (  13.80  )
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

On Wed, Oct 13, 2021 at 01:47:42PM +0300, Sagi Grimberg wrote:
>=20
> > > Hello all,
> > >=20
> > > Does the following patch fix the issue for you.
> > >=20
> >=20
> > Yes, the kmemleak was fixed by this patch.
>=20
> Great, Adam care to send a proper patch?

I'll send a patch out.

