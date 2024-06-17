Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3519C27C77
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Jun 2024 08:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=u+y/L6S5UL+8vZAxwL74vV1B6m8M84m9zI1fQPT/Bfs=; b=Lz08snKHQONA4fPQGKnJSlooZk
	z9neU+ndiGAcw8tkdx4Zvwd0nsLSQsOnj9q2v0TLVawNBrAGsPl7vjsaMUWPFDTNALBlniGLJd8FY
	FsXX1EVmk85yN3sAd3XpOcRWnx64a043Yb7Tbl99/lmIMhkwjyxIMIseVPOVXyenWfDZ20Qauaroc
	zYpvhBDqDMDpL6Gt3lBmvml0cRMg2hP/wLiOLcyxvP1pc5/UEPLTsiLzsCNZDNqa9GIJAXpowKleo
	elsZBgmal1KPqPHJ7jTes68YWHzbqzCwDBRmxsGz9/OQsR+CHLA1A+YbF+CQ/A8um8/6ZE8Vlyc4c
	VMA7xEaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJ7S2-00000009nqP-2JpC;
	Mon, 17 Jun 2024 08:10:54 +0000
Received: from mail.salesoptimize.pl ([162.19.245.89])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJ7Rz-00000009noj-2kuD
	for linux-nvme@lists.infradead.org;
	Mon, 17 Jun 2024 08:10:53 +0000
Received: by mail.salesoptimize.pl (Postfix, from userid 1002)
	id 392624658E; Mon, 17 Jun 2024 10:10:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=salesoptimize.pl;
	s=mail; t=1718611850;
	bh=u+y/L6S5UL+8vZAxwL74vV1B6m8M84m9zI1fQPT/Bfs=;
	h=Date:From:To:Subject:From;
	b=OYbF7lFZBlGPTBSb3+Rti/oGRD5l3lOU2VLIJ7NkNTzoGVp+1wlzf2h04xbh/RyzI
	 V/CZZMbo78LMd21SNT91awBJIBAc2BG10JHd/pRLT3l6ULyRXh0naOa7PG45SEU9SX
	 ZeIUWUVlysavVm73Vi7ogRchy7zpfs+ITfEpm0olWXOs/3iXfbbMYvfleYyaWCRqfX
	 VeLGUx5+uF00lQwaW/Q1jmmvuiQ4UTrKLIJLOPv9qdZ1EivC1xZaa4rjJ0BJzUaodY
	 lCw75Z2rp8Vzr9vyTWwRZyc7PblbGA5K5WFtI//CgHRyHqEh0JsE2SPBnjouJMgdK1
	 I7K0VX0JxMDNw==
Received: by mail.salesoptimize.pl for <linux-nvme@lists.infradead.org>; Mon, 17 Jun 2024 08:10:47 GMT
Message-ID: <20240617084500-0.1.31.oepi.0.z0krv9rihj@salesoptimize.pl>
Date: Mon, 17 Jun 2024 08:10:47 GMT
From: "Tomasz Wawrzyniak" <tomasz.wawrzyniak@salesoptimize.pl>
To: <linux-nvme@lists.infradead.org>
Subject: =?UTF-8?Q?Odroczenie_zap=C5=82aty?=
X-Mailer: mail.salesoptimize.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240617_011051_962725_548CB7B7 
X-CRM114-Status: UNSURE (   1.15  )
X-CRM114-Notice: Please train this message.
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

Szanowni Pa=C5=84stwo,

chcia=C5=82bym zaproponowa=C4=87 mo=C5=BCliwo=C5=9B=C4=87 wyd=C5=82u=C5=BC=
enia okresu sp=C5=82aty za zakupione produkty.

Mogliby=C5=9Bcie z=C5=82o=C5=BCy=C4=87 zam=C3=B3wienie u swojego dostawcy=
, a my dokonamy p=C5=82atno=C5=9Bci w wyznaczonym przez niego terminie. P=
o otrzymaniu p=C5=82atno=C5=9Bci wystawimy Pa=C5=84stwu faktur=C4=99 sprz=
eda=C5=BCy z odroczonym terminem p=C5=82atno=C5=9Bci (30-90 dni).

S=C4=85 Pa=C5=84stwo zainteresowani takim rozwi=C4=85zaniem?


Pozdrawiam
Tomasz Wawrzyniak

