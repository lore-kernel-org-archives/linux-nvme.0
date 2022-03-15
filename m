Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 712B3C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 10:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Type:Content-Transfer-Encoding:Date:Message-ID:In-Reply-To:CC:To:From
	:Subject:Mime-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FsfyjBB7q0DvWz2A7F3Mgvw46I0WUKQTNbFMUprKeZk=; b=AU1dWEhZNfWMA9FS8Y8gW5Kefm
	9HhK54G6KRevIQ5ax6KAjqwW5dVpKuBxasHbrtNLM6NRGR+EUrxpctx7zH6BYNrjOV4LleJbgPTXU
	CEs7xx2acAKM8B4B5VMJDSQIjd/mlAfiW9zPXsFtgQYfZQIrCdp+t0goJKvCl0qUyvb2rsz8nye9s
	FGJTHKRxEBcKb94WTk90+uga8TKuskh56AAZh22xx1752rDL3l/aTxNGLyY3/SnusEMaBRdjSW9Ee
	GfltIloMNVOLYaR0JjtSff4r6+9TtCQHBEpE55JsOnFB+au+2VWDmMtx3VHMEdCWlTmG8HkzmevFm
	8Tgla90w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU4MC-008idn-O6; Tue, 15 Mar 2022 10:24:48 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU4M9-008idF-13
 for linux-nvme@lists.infradead.org; Tue, 15 Mar 2022 10:24:46 +0000
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20220315102441epoutp04be65c85fe529cf9f8cd76eaee6bed1d4~chuT8bDlI0133701337epoutp04r
 for <linux-nvme@lists.infradead.org>; Tue, 15 Mar 2022 10:24:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20220315102441epoutp04be65c85fe529cf9f8cd76eaee6bed1d4~chuT8bDlI0133701337epoutp04r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1647339881;
 bh=FsfyjBB7q0DvWz2A7F3Mgvw46I0WUKQTNbFMUprKeZk=;
 h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
 b=YHb6fcMMr+9gns/uCN/Mv1JofKy7uuGGK4TSzGp9iDG/nAdOB+7HN2XDiNQcO24lB
 2/YiC36uQ2PeumOx+QMJlB7G6XgW36+pHc/zhE8Hj5d+R6R2ZGSvTZ9n4r/Ct5+OLM
 Gg3mGmryc9MwuN4sAKRDu8N7/bjeahwzKIaqOik8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTP id
 20220315102441epcas2p430a23fe2dfd556a81ea6cb5d396c9ee6~chuTxNEQs1275912759epcas2p4c;
 Tue, 15 Mar 2022 10:24:41 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.100]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4KHqK24xDvz4x9Pt; Tue, 15 Mar
 2022 10:24:38 +0000 (GMT)
X-AuditID: b6c32a45-513ff700000228cc-43-62306966ea6c
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
 epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 64.A1.10444.66960326; Tue, 15 Mar 2022 19:24:38 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) [PATCH v2] driver/nvme/host: Support duplicated nsid for the
 private ns
From: Sungup Moon <sungup.moon@samsung.com>
To: "hch@lst.de" <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20220315084611.GA3961@lst.de>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220315102438epcms2p68d757d1863b5582778f8c89517b82a70@epcms2p6>
Date: Tue, 15 Mar 2022 19:24:38 +0900
X-CMS-MailID: 20220315102438epcms2p68d757d1863b5582778f8c89517b82a70
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphk+LIzCtJLcpLzFFi42LZdljTVDct0yDJYFanqsX/PcfYLFauPspk
 MenQNUaLy7vmsFnMX/aU3WLd6/csDmweE5vfsXucv7eRxWPTqk42j81L6j1232xg8/i8SS6A
 LSrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoCiWF
 ssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgXmBXnFibnFpXrpeXmqJlaGBgZEpUGFC
 dsaLywvZClYKVZy+3sPWwNgq2MXIySEhYCLxcPlCpi5GLg4hgR2MEmt37GPsYuTg4BUQlPi7
 QxikRlggUuLc0ptsILaQgKLE32d9jBBxXYk1/6cwg9hsAtoS9868ZQKxRQTsJXp/TGUFmcks
 cIFR4urjpWwQy3glZrQ/ZYGwpSW2L98KNogTqHnO9dNMEHENiR/LepkhbFGJm6vfssPY74/N
 Z4SwRSRa752FqhGUePBzN1RcUuLpyQ9Q8XyJtt+L2ECOkBDoYJQ4//AI1AJziT8vr4MN5RXw
 lei4vgSsgUVAVWJp/yRmkOclBFwkTuxLBgkzA922bOFrsDCzgKbE+l36EBXKEkdusUBU8El0
 HP7LDvPhjnlPoBapSlyc0MMG8+3KeQ2MEK0eEmteBE9gVJyFCOdZSFbNQli1gJF5FaNYakFx
 bnpqsVGBITxqk/NzNzGCk6OW6w7GyW8/6B1iZOJgPMQowcGsJMJ75oV+khBvSmJlVWpRfnxR
 aU5q8SFGU6AfJzJLiSbnA9NzXkm8oYmlgYmZmaG5kamBuZI4r1fKhkQhgfTEktTs1NSC1CKY
 PiYOTqkGJl++7R/E+R9ke9fnrN2u9b0u0DpfvCw3c4L/02PX9/G8YPq/umua4FZ2ryXBGozO
 d6VZn/y9+EUx/MWWXPHkZYlfZ5f0HGI26rq0V+Ka6J+F5mYOAl8lLfY07k3OWVkVHzl9EZ8E
 0xQ+qdVhp+P+PXxpmrDc7Fb0b0kLF3XL53uKp3Zme6SzZbRK3jR7O4eJ8cHySyFbyh94bRW6
 mHhVKf7dFt+rx39uk37B9f5bifOprE86juGrF9gETl4fFTKdTbN6hnfgjdpfes90/6/flZ4r
 2rrjqO28Fo0u++6T/dnCHAtsamrnNnS5xP39oflnZfSPVWeCpi4/sypZ5dQXe+avJnE7Jyxg
 bPC6s8TUQ4mlOCPRUIu5qDgRAPIC7x0XBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220314110545epcms2p4a227eac7c4652445050e70ee2350635d
References: <20220315084611.GA3961@lst.de>
 <20220314110545epcms2p4a227eac7c4652445050e70ee2350635d@epcms2p4>
 <20220315071230.GA2069@lst.de> <20220315071926.GA2137@lst.de>
 <a3051d85-c08e-a273-c7cc-2eb3e21df717@grimberg.me>
 <20220315084035.GA3834@lst.de>
 <6ac83f8b-01e6-5394-0570-023ac6b1a71d@grimberg.me>
 <CGME20220314110545epcms2p4a227eac7c4652445050e70ee2350635d@epcms2p6>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_032445_524250_5F5AE85A 
X-CRM114-Status: GOOD (  14.73  )
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

First of all private namespace should be created by the vendor specific com=
mand,
because namespace management, ANA and NVM Set should be disabled on the con=
troller
level. So Normal namespace managed NVMe deivce should return true using the
namespace management field (ctrl->oacs & NVME_CTRL_OACS_NS_MNGT_SUPP).

If user create using the namespace management admin command, my patch
check the namespace management field and that sub-system should be managed
like multi-path nvme device route.

So, if user create shared namespace on that nvme subsystem, should
distroy all namespace with target nsid, and create the new shared namespace
using the vendor specific admin command.

=C2=A0=0D=0A=C2=A0=0D=0A---------=20Original=20Message=20---------=0D=0ASen=
der=20:=20hch=40lst.de=C2=A0<hch=40lst.de>=0D=0ADate=20:=202022-03-15=2017:=
46=20(GMT+9)=0D=0ATitle=20:=20Re:=20=5BPATCH=20v2=5D=20driver/nvme/host:=20=
Support=20duplicated=20nsid=20for=20the=20private=20ns=0D=0A=C2=A0=0D=0AOn=
=C2=A0Tue,=C2=A0Mar=C2=A015,=C2=A02022=C2=A0at=C2=A010:42:56AM=C2=A0+0200,=
=C2=A0Sagi=C2=A0Grimberg=C2=A0wrote:=0D=0A>>>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*=C2=A0We=C2=A0also=C2=A0do=C2=A0this=C2=
=A0for=C2=A0private=C2=A0namespaces=C2=A0as=C2=A0the=C2=A0namespace=C2=A0sh=
aring=C2=A0flag=0D=0A>>>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0*=C2=A0could=C2=A0change=C2=A0after=C2=A0a=C2=A0rescan.=0D=0A>>=
>=0D=0A>>>=C2=A0What=C2=A0happens=C2=A0in=C2=A0this=C2=A0case?=C2=A0we=C2=
=A0now=C2=A0have=C2=A0non-unique=C2=A0shared=C2=A0namespaces?=0D=0A>>=0D=0A=
>>=C2=A0The=C2=A0non-uniqueue=C2=A0NSIDs=C2=A0can=C2=A0only=C2=A0happen=C2=
=A0for=C2=A0private=C2=A0namespaces.=0D=0A>=0D=0A>=C2=A0But=C2=A0what=C2=A0=
happens=C2=A0if=C2=A0this=C2=A0changes=C2=A0upon=C2=A0a=C2=A0rescan=C2=A0as=
=C2=A0you=C2=A0commented?=0D=0A=C2=A0=0D=0AWell,=C2=A0it=C2=A0can't=C2=A0ch=
ange=C2=A0to=C2=A0shared=C2=A0as=C2=A0the=C2=A0nsids=C2=A0are=C2=A0non-uniq=
ue.=C2=A0=C2=A0If=C2=A0we=0D=0Awant=C2=A0to=C2=A0be=C2=A0paranoid=C2=A0we=
=C2=A0could=C2=A0add=C2=A0a=C2=A0sanity=C2=A0check=C2=A0for=C2=A0that,=C2=
=A0but=C2=A0then=0D=0Aagain=C2=A0there=C2=A0are=C2=A0a=C2=A0bunch=C2=A0of=
=C2=A0other=C2=A0things=C2=A0where=C2=A0we=C2=A0could=C2=A0be=C2=A0more=C2=
=A0paranoid.=0D=0A=C2=A0

