Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF6B2EED61E
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 16:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y688il3GFHiFWg+vI0HLvQDIl7O+Ltp/r+4vpEGWbrk=; b=k6SZiXawOkxJ/InlTuGbjN4E6o
	cVPNYTpoPdMJteAVrsKCtrQhX4SLnnNDFaq3NR+4UiWcEaPbQfkM/zHFiPGkMI6BnXagVvW/QqoaK
	oEmSjEjLOiolPWvbxLCzWgWVd3QO1gYd05iSIfLXymqUtewanUmxaxHOBR/UlTpRiOtQpnIHBE0d0
	z+DnxgEZfRlgsb0b7b1i1VgK+4JfAjo3Cox6sgu4L9HPCEliSZF4SE7M8AFnN6GFGzOgkAkIT+20A
	K+noA/wPgpjKrXSVbfT113fdWclSQCKlVeCyHRf981RBx8lt1Lt3N7RiypIPb3Xiv1iui46E8uDP7
	EE3FWPfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1somip-0000000DhtB-3LYa;
	Thu, 12 Sep 2024 16:31:07 +0000
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1somim-0000000Dhsr-0M1o
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 16:31:06 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1726158661; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gFsxA2yzHRkwkYcpyrsOi2/KYEuoU3U9Hq7Jq1f/lgJIqxItpKKmAsOFRw8r9XEhRmpzWIMktBVNeMxJvZHyym/cwuLkcxt8w/z045Gos2wqMTqn6yTeHsEmbEd0qPXG/mUW0sYj3HJuzcpZV9i+YRfv/8b3jZVL6nirbs1ht1k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726158661; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Y688il3GFHiFWg+vI0HLvQDIl7O+Ltp/r+4vpEGWbrk=; 
	b=VyNJzffHbZOmp6A2n7pRjKI9LVnHZnt59tHM664WI1YEVvSDr9KlY0ko/G+5kYvzIQTn/Ph6uWrr8LST/Vw5Cra2yn7U/NqzjBjDS0L5idrPfxvA/fJ4RWqW6VjARkLZ8aP3dqRZJBcCv29I0Ew0J71/AVuFZMbicHQOqxH1rCw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=bob.beckett@collabora.com;
	dmarc=pass header.from=<bob.beckett@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726158661;
	s=zohomail; d=collabora.com; i=bob.beckett@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Y688il3GFHiFWg+vI0HLvQDIl7O+Ltp/r+4vpEGWbrk=;
	b=E5zGdh5Jn8/dOnsLmZt1tOliDtoQWfeegey6C/RcaD8wn5XhzEd9arvkxJTPRJ08
	Zjxy5Ru91NccZoeTi/X83vUtd8k0trL9WT/q4b/OfZm7F09Ljy+O2Zx8rxc4GUZNiGg
	HryWQSzUVZ+9CmsNAqQ8ehBp0CR2IkK4TorxG+Qs=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1726158629063318.4094749629203; Thu, 12 Sep 2024 09:30:29 -0700 (PDT)
Date: Thu, 12 Sep 2024 17:30:28 +0100
From: Robert Beckett <bob.beckett@collabora.com>
To: "Christoph Hellwig" <hch@lst.de>
Cc: "Keith Busch" <kbusch@meta.com>,
	"linux-nvme" <linux-nvme@lists.infradead.org>,
	"sagi" <sagi@grimberg.me>, "Keith Busch" <kbusch@kernel.org>
Message-ID: <191e7126880.114951a532011899.3321332904343010318@collabora.com>
In-Reply-To: <20240912065716.GA7431@lst.de>
References: <20240911174631.3484553-1-kbusch@meta.com> <20240912065716.GA7431@lst.de>
Subject: Re: [PATCH] nvme-pci: qdepth 1 quirk
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_093104_192897_98DC05F7 
X-CRM114-Status: UNSURE (   8.82  )
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

 ---- On Thu, 12 Sep 2024 07:57:16 +0100  Christoph Hellwig  wrote ---=20
 > > +=C2=A0=C2=A0=C2=A0=C2=A0{ PCI_DEVICE(0x1217, 0x8760),
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.driver_data =3D NVME=
_QUIRK_QDEPTH_ONE },
 >=20
 > Do we have some kind of name for this device?  That always feels useful
 > when googling for it or finding patterns.

The device is the 64GB Steam Deck from Valve.

 >=20
 > Otherwise looks good:
 >=20
 > Reviewed-by: Christoph Hellwig hch@lst.de>
 >=20
 >=20

