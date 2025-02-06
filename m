Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86DBC02194
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Feb 2025 09:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=s9FvBgec2vOLzZMd+I0JTxSJ2jvdHkBRar46owoDscI=; b=tiNIIGQUHJ4iZwjNcWQl5eiMFA
	m3Sdpyv/wTujYb3AZQnsF4GNFWhyk/oizJIKfx0aQIR632fhXBTzDUnyX94VXHcbBA7vbrCh5FUUT
	LXAjnhGeV6D3A/Kaud935IyQ3oOP4vyK6nmIwS3JemD0HCymhy5TmcDHXh8XFT9FE/HnA689Gy1Ii
	QhErmB4T3t6aP06tT3o4cPeKDmqO2m8u3uUIgn5SHxJpj2JJPV1WQxzdK93CdicGOr0t6ADJFpaUg
	mHNviw8lZq+Uw3dYqkEz6mW2qc2ZNx+BQ7lE+gyPH1HBdBZ1xBU2EN4kFA1K8kBWmqVrAawOmmL8L
	lFRqxiYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tfxky-00000005m3C-1gpw;
	Thu, 06 Feb 2025 09:01:08 +0000
Received: from mail.commetrax.com ([141.95.18.165])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tfxkr-00000005m1B-1VCW
	for linux-nvme@lists.infradead.org;
	Thu, 06 Feb 2025 09:01:07 +0000
Received: by mail.commetrax.com (Postfix, from userid 1002)
	id 48165244CA; Thu,  6 Feb 2025 10:00:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=commetrax.com;
	s=mail; t=1738832455;
	bh=s9FvBgec2vOLzZMd+I0JTxSJ2jvdHkBRar46owoDscI=;
	h=Date:From:To:Subject:From;
	b=J57oY4EuiVNrIxCm8hbypQfXACd5M/qr8n44xVzZmsy9upgh8qf/ZWDkiqVbfD7FY
	 wAdepeKmZ/z3bbhL8+P88covQ7V1PCo/bpnrwJwqfMUI3jg8nKEHYaXrSSl0SID66k
	 LZRrCpS5NNaBcXKsqXYu+Y1kdUjhkYDWKmkn941x062m55Yr2nFrIgD3f8r3gY+mnZ
	 axpA0rMLonq3WLxyGV9o9hdw5thZSbPAxbFmcJX3nXMdAv9iw7YCwtFGigO/0yFRpV
	 AKs1ZTiusppJTIXo3WyPDSkZgonpTsp/bvFuXL0893fFBmTg9Iwj1CVd8Ta5UGiv0A
	 93vn35K2lII1w==
Received: by mail.commetrax.com for <linux-nvme@lists.infradead.org>; Thu,  6 Feb 2025 09:00:31 GMT
Message-ID: <20250206084500-0.1.7p.id85.0.pr0im9bcvf@commetrax.com>
Date: Thu,  6 Feb 2025 09:00:31 GMT
From: "Vincenc Turek" <vincenc.turek@commetrax.com>
To: <linux-nvme@lists.infradead.org>
Subject: Wide range of packaging
X-Mailer: mail.commetrax.com
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250206_010102_113628_142951BB 
X-CRM114-Status: UNSURE (   1.86  )
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

Hi,

Are you looking for packaging that not only protects your product but als=
o enhances its value in the eyes of your customers?

We manufacture a wide range of bottles, caps, and buckets made of HDPE an=
d PP, designed to meet the demands of industries such as cosmetics, chemi=
cals, and food.

Our packaging stands out for its durability, aesthetic appearance, and th=
e ability to customize colors and closures =E2=80=93 helping to build bra=
nd recognition and trust.

Are you interested in solutions that perfectly align with your company's =
needs?


Best regards
Vincenc Turek

