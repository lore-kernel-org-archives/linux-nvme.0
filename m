Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67DCDC27C44
	for <linux-nvme@archiver.kernel.org>; Fri, 31 May 2024 08:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:To:In-Reply-To:Cc:References
	:Message-Id:Date:Subject:Mime-Version:From:Content-Transfer-Encoding:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MG6LYpllHmnJXtgJOt/alUy0Z1+D5pDhglGk5gH5q64=; b=iCPBDSKbT3bs0TG2GCRMleCE8d
	d8F08wpd4nyvd1U836wNxdmWIKaKY4Z7xsLhZLupgvtMxyYK9Bdk1poVmOS07OmWTAiNm1H42E5js
	L/1S6rPMtFXv14Vy1YxzBYS8P2j1C194GSyXRU3LcVS3qtFbzz0sHNgIXlFOK2NVD+FwgzOb2rfmw
	tyWWpioBjwf/y90ZlQigN2w8ovBSxwTeHRDSVYsdTR4t08CEgRpiCxuNv+uVlrX1EG3FiRWi8kjXA
	6PfrvlYV144eaQZCdmQb4CIDM/sLIpEmMAyqEpCZowEEbSl+jjZUOGDQEFtZ9IO9W0mZh1pspibxn
	Utmsnmyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCxmv-00000009eKu-3WqW;
	Fri, 31 May 2024 08:39:01 +0000
Received: from fout3-smtp.messagingengine.com ([103.168.172.146])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCxmg-00000009eEZ-46GS;
	Fri, 31 May 2024 08:38:49 +0000
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7E22B1380150;
	Fri, 31 May 2024 04:38:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 31 May 2024 04:38:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1717144722; x=1717231122; bh=MG6LYpllHmnJXtgJOt/alUy0Z1+D5pDh
	glGk5gH5q64=; b=DWDORLjdbmk4tl1FU59msoRJmHQGiFrXHMPkuNI15jaUogpy
	bKkJBA9BaP9GGdlVujXHJQcMCdyxmo/3UuQmv0vNw8NCNzQZ1kELKLtACAeNVMv/
	6ZKnJzsjhzehmzS68T8Yx/av0urEkSfqhLX1DTx1YtPZgbSUvcLvOKwWleCgwsoq
	sfnjwOMdXN7yqUpMURKiEFnLXQBCSqdCV8Icziq42lx0OGaJvBrnVdwAipfHUJpP
	aBR3FWbBt4G3jpxovuvFBLYlDkAolQp4wj13yRjOAdv5NrfpR3bdBsV8qS54XV8I
	uD1TJ4ZPIdKhdej1iY2sevFuU2731FLxvbEiUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717144722; x=
	1717231122; bh=MG6LYpllHmnJXtgJOt/alUy0Z1+D5pDhglGk5gH5q64=; b=c
	hlzhL2A062qJIl6SaoPmO/xGl9XwZ2fygnJudOYlfUzA4cefi/nz9+VbU8wYJfdG
	/cL8dIOxd0ka7BmCQJOYE/ZeyIhcdxvAHfDw27C6maXN2BV/LRyXFo3DDAqecKAt
	wDdjCejignjSk/UErTjdVvAdITAUyEee1S9Nw5sejinDQPU6xyG0AGMEEsoeZmGP
	I/5B7CLAXa9wBcsJdj+lOLNjh496FUXUktWtpe0cagCrvxH6p2QeX2Z0nnRkUAYU
	gc9u1lwMeWb5zM/vVpcwOWwF4x9iYRdaSnZ7XqWex3nwkDnc3uBOUwGxuCokGZ2Q
	csiof3Y5zSe6U6oMj6Ghg==
X-ME-Sender: <xms:kYxZZjQZybnWdagLKRyq5wu3Vlj694bJ1DlN5vM_Y6qlrQSBixNjxA>
    <xme:kYxZZkyPKmM_tapOuPeo5fWRiaaqA7_1MLFlw9MogW-Ke7m_lu44MCqByDYKIC6DT
    i9AiVJyV_aa4z8Lyig>
X-ME-Received: <xmr:kYxZZo2jTW9cGswgRt1VHIklVETmwA7Ok7TM5DGQ-LcI_eQ_Sgj12Oyu4YSQFvU6mKrYFsS1D_MAB-vUKHLfifgtCrhyUmuco6H4sXwBzrkVPOCvbFIFywOs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekiedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptgfghfggufffkfhfvegjvffosehtqhhmtdhhtdejnecuhfhrohhmpefuvhgv
    nhcurfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrth
    htvghrnhepvdfhtdduuddvueejueffgfdukedvfeevgfeuieeivdeltdehgeeivefftdet
    kedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    hvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:kYxZZjC93nUGwlXDKszUwMtwIgbwTDrHKXp0RKodNQN4YuNUcrEIQQ>
    <xmx:kYxZZshxU5LiQn-YdhIcw93ZdLxWx4RAENapjv1MT5JMvT5Hfx3BUg>
    <xmx:kYxZZnq-Bxsn3m7hCHTqlitekPxDxXhSjXBH4Oq04dn2sb6GidzAzw>
    <xmx:kYxZZnhHg06x4apEEznsdQcOWD_3n3AipBxUAMBJtB8GUPYrJus7Cw>
    <xmx:koxZZtYV8P44-h6v_o0yn23f6Hc8gbJtmPAeMTcdZjeZ1453k_veuEvZ>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 May 2024 04:38:41 -0400 (EDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Sven Peter <sven@svenpeter.dev>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] nvme-apple: add missing MODULE_DESCRIPTION()
Date: Fri, 31 May 2024 10:38:25 +0200
Message-Id: <F36A6A33-240D-4F88-B0D9-5C08E35DBC8C@svenpeter.dev>
References: <20240530-md-nvme-apple-v1-1-b8b7ca569660@quicinc.com>
Cc: Hector Martin <marcan@marcan.st>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20240530-md-nvme-apple-v1-1-b8b7ca569660@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: iPhone Mail (21F90)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240531_013847_242995_8630047E 
X-CRM114-Status: UNSURE (   5.96  )
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


> On 31. May 2024, at 07:16, Jeff Johnson <quic_jjohnson@quicinc.com> wrote:=

>=20
> =EF=BB=BFmake allmodconfig && make W=3D1 C=3D1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/host/nvme-a=
pple.o
>=20
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
>=20
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Reviewed-by: Sven Peter <sven@svenpeter.dev>



