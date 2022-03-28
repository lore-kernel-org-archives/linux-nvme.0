Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 720E8C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Mar 2022 06:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Type:Content-Transfer-Encoding:Date:Message-ID:In-Reply-To:CC:To:From
	:Subject:Mime-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mjft+h3jj9ITa7QOXpW8Qa8EiFiS6oCgpzEjjfKEAfI=; b=dJqDeIIfSxoIPbn1i3Iq1cSZHR
	c3zs1fewmclwqtwofsvfJSW0mz9l9rG2FHABqj5R+b4a2Gi13greXIq6jJaOA/AStYthhSFqoLx5B
	zqLLRz5M4qjExrxbLPFl/7kEYBmXhXvj6k94PAQjThieybM2XAw3j62/W3Yf5iktD3QIjAHBgbkTd
	8bxKEt13diA6CWR1ebn31mYld12cmRqAicn9bddVE4t3wJl7FhF+Z63tpZtqj64qL9IoBqrB/uT7T
	8wSlcwOeQJ+ZwDzyZ+BvNIPxyj/hWRx6lnKyZJmLbLwGbh3lP2R9cT/jwZQ1JTKycvQjXc6niwaug
	trfR2lMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nYiRe-007Ni2-JB; Mon, 28 Mar 2022 06:01:38 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nYiRa-007NgA-8S
 for linux-nvme@lists.infradead.org; Mon, 28 Mar 2022 06:01:36 +0000
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20220328060124epoutp03c455905c8addbee3640d67cc4d1abbba~gdhJNeYD83070230702epoutp03b
 for <linux-nvme@lists.infradead.org>; Mon, 28 Mar 2022 06:01:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20220328060124epoutp03c455905c8addbee3640d67cc4d1abbba~gdhJNeYD83070230702epoutp03b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1648447284;
 bh=Mjft+h3jj9ITa7QOXpW8Qa8EiFiS6oCgpzEjjfKEAfI=;
 h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
 b=W4VhgSERkiY460vSk8xL9fM8/dLZr0y+ftQ19Eaxk+HUHklZw+3YptXNTHCE9quHA
 oV2Z5APOdLiu5ssPVnOJI1T9ZQDwUeB5DGRb6SEZ9tMECmSNl+Ai4Z+FwSkWUhfgdJ
 E7NzPTElFUcMINvTp+kC+Cjx7owmM3Y4IEqMozbQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTP id
 20220328060124epcas2p4d9f3f77df6271f5c1681259bdcf2c3c0~gdhIv5Vee2517825178epcas2p4A;
 Mon, 28 Mar 2022 06:01:24 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.99]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4KRhsG4Z3Yz4x9QM; Mon, 28 Mar
 2022 06:01:22 +0000 (GMT)
X-AuditID: b6c32a45-4fdff700000228cc-b0-62414f31de13
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
 epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 07.20.10444.13F41426; Mon, 28 Mar 2022 15:01:22 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) [PATCH] nvme: allow duplicate NSIDs for the private namespaces
From: Sungup Moon <sungup.moon@samsung.com>
To: Pankaj Raghav <pankydev8@gmail.com>, Christoph Hellwig <hch@lst.de>
CC: "sagi@grimberg.me" <sagi@grimberg.me>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20220328053441.v6kr7gza7nj2ldlj@quentin>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220328060121epcms2p5353c36648e59766c3c4c8cf04e28bc56@epcms2p5>
Date: Mon, 28 Mar 2022 15:01:21 +0900
X-CMS-MailID: 20220328060121epcms2p5353c36648e59766c3c4c8cf04e28bc56
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnk+LIzCtJLcpLzFFi42LZdljTTNfI3zHJYP0iRouVq48yWcz++oXR
 YtKha4wW85c9ZbdYc/Mpi8W61+9ZLN7O289s0b3tD6MDh8fOWXfZPc7f28jisWlVJ5vH5iX1
 HrtvNrB59G1ZxRjAFpVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr
 5OIToOuWmQN0kJJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwLxArzgxt7g0L10v
 L7XEytDAwMgUqDAhO+PJlSmsBROEKw5cO8HewHhUqIuRk0NCwERi2rRZLF2MXBxCAjsYJf4/
 Ps/axcjBwSsgKPF3hzBIjbBAgMTiFTMZQWwhAUWJv8/6GCHiuhJr/k9hBrHZBLQl7p15ywRi
 iwi4S8z9NZsdZCazwExGiev/2tkglvFKzGh/ygJhS0tsX74VbBCngJnEj4/dTBBxDYkfy3qZ
 IWxRiZur37LD2O+PzWeEsEUkWu+dhaoRlHjwczdUXFLi6ckPUPF8ibbfi9hAjpAQ6GCUOP/w
 CNQCc4k/L6+zQzzpK7FpshCIySKgKjF7hihEhYvEyudbwE5mBvpr2cLXzCAlzAKaEut36YOY
 EgLKEkdusUBU8El0HP7LDvPgjnlPoPaoSlyc0MMG8+zKeQ1QR3pIXPmxmmkCo+IsRDjPQrJr
 FsKuBYzMqxjFUguKc9NTi40KDOFRm5yfu4kRnDK1XHcwTn77Qe8QIxMH4yFGCQ5mJRFe2bP2
 SUK8KYmVValF+fFFpTmpxYcYTYGenMgsJZqcD0zaeSXxhiaWBiZmZobmRqYG5krivF4pGxKF
 BNITS1KzU1MLUotg+pg4OKUamBaFxnyW/2Aj9bTwwdZz07OCU5as3PRE6ez62y4bnorYTL5y
 nc/RfGP+a89lr574aj6NOPMjZ2f3mrnT/mb9Oax2eZ9NpK9F1NGMOAnp11YSB/9Wr4lyuXE5
 QaKt7cV9z6CEmY4MtzaZmDx8w+S4cEKXxvcNs1u075U5Fn0K7dikdvuG7czp56ekJNusztzg
 1371O9t2a7kJAjZHHBc1rNLsU+076DebI8AgZOP6QuX9bW/vXilV0Fhg2DyxqOHhz56+ttcr
 L9me6OCKVzrypd23tDJxZQjDJr93JTGSAVOqHQymF0eoOuc257UtffD32eeJ9e+TjJQ3/llu
 1fKayXzbnrcOdxyfW262KIvhY1NiKc5INNRiLipOBABjTKQLIgQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220328053449epcas2p2b44e1d7bcd289544c44080e54fa1bdd4
References: <20220328053441.v6kr7gza7nj2ldlj@quentin>
 <20220324154314.1571239-1-hch@lst.de>
 <CGME20220328053449epcas2p2b44e1d7bcd289544c44080e54fa1bdd4@epcms2p5>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220327_230135_571457_F6C81D50 
X-CRM114-Status: GOOD (  12.49  )
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
Reply-To: sungup.moon@samsung.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

That was a typing error. unique is ok.

Thankyou=21
=C2=A0=0D=0A=C2=A0=0D=0A---------=20Original=20Message=20---------=0D=0ASen=
der=20:=20Pankaj=20Raghav=C2=A0<pankydev8=40gmail.com>=0D=0ADate=20:=202022=
-03-28=2014:34=20(GMT+9)=0D=0ATitle=20:=20Re:=20=5BPATCH=5D=20nvme:=20allow=
=20duplicate=20NSIDs=20for=20the=20private=20namespaces=0D=0A=C2=A0=0D=0AOn=
=C2=A0Thu,=C2=A0Mar=C2=A024,=C2=A02022=C2=A0at=C2=A004:43:14PM=C2=A0+0100,=
=C2=A0Christoph=C2=A0Hellwig=C2=A0wrote:=0D=0A>=C2=A0From:=C2=A0Sungup=C2=
=A0Moon=C2=A0<sungup.moon=40samsung.com>=0D=0A>=C2=A0=0D=0A>=C2=A0+=0D=0A>=
=C2=A0+/*=0D=0A>=C2=A0+=C2=A0*=C2=A0NSID=C2=A0shall=C2=A0be=C2=A0unique=C2=
=A0for=C2=A0all=C2=A0shared=C2=A0namespaces,=C2=A0or=C2=A0if=C2=A0at=C2=A0l=
east=C2=A0one=C2=A0of=C2=A0the=0D=0A>=C2=A0+=C2=A0*=C2=A0following=C2=A0con=
ditions=C2=A0is=C2=A0met:=0D=0A>=C2=A0+=C2=A0*=C2=A0=C2=A0=C2=A01.=C2=A0Nam=
espace=C2=A0Management=C2=A0is=C2=A0supported=C2=A0by=C2=A0the=C2=A0control=
ler=0D=0A>=C2=A0+=C2=A0*=C2=A0=C2=A0=C2=A02.=C2=A0ANA=C2=A0is=C2=A0supporte=
d=C2=A0by=C2=A0the=C2=A0controller=0D=0A>=C2=A0+=C2=A0*=C2=A0=C2=A0=C2=A03.=
=C2=A0NVM=C2=A0Set=C2=A0are=C2=A0supported=C2=A0by=C2=A0the=C2=A0controller=
=0D=0A>=C2=A0+=C2=A0*=0D=0A>=C2=A0+=C2=A0*=C2=A0In=C2=A0other=C2=A0case,=C2=
=A0private=C2=A0namespace=C2=A0are=C2=A0not=C2=A0required=C2=A0to=C2=A0repo=
rt=C2=A0a=C2=A0unique=C2=A0NSID.=0D=0A>=C2=A0+=C2=A0*/=0D=0A>=C2=A0+static=
=C2=A0inline=C2=A0bool=C2=A0nvme_is_uniqueue_nsid(struct=C2=A0nvme_ctrl=C2=
=A0*ctrl,=0D=0A>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct=C2=A0nvme_ns_head=C2=A0=
*head)=0D=0AIs=C2=A0it=C2=A0s/uniqueue/unique/=C2=A0?=0D=0A>=C2=A0+=7B=0D=
=0A>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=C2=A0head=
->shared=C2=A0=7C=7C=0D=0A>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(ctrl->oacs=C2=A0&=
=C2=A0NVME_CTRL_OACS_NS_MNGT_SUPP)=C2=A0=7C=7C=0D=0A>=C2=A0+=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0(ctrl->subsys->cmic=C2=A0&=C2=A0NVME_CTRL_CMIC_ANA)=C2=A0=7C=7C=0D=0A=
>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(ctrl->ctratt=C2=A0&=C2=A0NVME_CTRL_CTRATT_NV=
M_SETS);=0D=0A>=C2=A0+=7D=0D=0A>=C2=A0+=0D=0A>=C2=A0=0D=0A=C2=A0

