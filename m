Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81066EE0214
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2024 08:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=oq44AviJtmOMZFlkH3w+IQ0DOuq60Snkx4IkmtTHaoU=; b=TojX/2aRJsdgL/lz+X+vyDiCxM
	Moy2j943McAGfXg8GRuq/2uJlSflR9lAxAWnrbAI9eVwV6VXsAqzLZ0p/jV+HxQwv3pKTdPTnP0eB
	5Tew/bRyGQt9rKV4HouK1X36dOGlBkPR8kpoAvcwS4jVyZIPRt18FbqBPx2BXZz1Hzyg2EoLJXBRF
	35YjPjDsX3yemks15xHThl5EWrNjFEMOBxkbiA6uNEZ9dfin4MpkYyOwGQK5bOWoDL8438OuEJ+jy
	i/V7dyJXFOOmvccs2g1JME7U5Y9IumvPUnU1Nt5mRBLsrAmyS7kKKBFF8tNEGq8xvd/l8rjL8Jz0X
	t6RODeRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soIHL-00000008Y63-0Din;
	Wed, 11 Sep 2024 08:00:43 +0000
Received: from mail.bizluminar.com ([51.254.102.79])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soIHI-00000008Y3v-0KPt
	for linux-nvme@lists.infradead.org;
	Wed, 11 Sep 2024 08:00:42 +0000
Received: by mail.bizluminar.com (Postfix, from userid 1002)
	id 24A6F48198; Wed, 11 Sep 2024 10:00:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bizluminar.com;
	s=mail; t=1726041635;
	bh=oq44AviJtmOMZFlkH3w+IQ0DOuq60Snkx4IkmtTHaoU=;
	h=Date:From:To:Subject:From;
	b=ebORpIcmaRBrzVHeFfVr1fWATVz5Jmon4ET4c8JoO7eyjJFA0ikLVLk9ByhD6ehW0
	 kxhW9IRnQ6FuF6M+1nwF1YfSL/3e1gS9p7vbdIEL9YPJSnFrhe47i8pl+3sqZCa6m8
	 Et56c0Dj1gX8rvNrt2EGh8Y/XlhjtHluH9cYxbvAjGXwRcl6p6fcym4L7cFZLoSQUW
	 5mnJUH2AubUOwm4j4uIBjuXn2v7wRcgWLQCdPhxwIOZ7u63C6SX6oeOQiKqaThVRPq
	 vtNEIymfTQhY/qTfbfJ8+7tqEgsrCGK8roSdcVv7sXBdlcqK44DyfSl9JEIof64WV2
	 0lk9ZVypGdNzQ==
Received: by mail.bizluminar.com for <linux-nvme@lists.infradead.org>; Wed, 11 Sep 2024 08:00:30 GMT
Message-ID: <20240911084500-0.1.am.qo8y.0.ne6k2g0lpx@bizluminar.com>
Date: Wed, 11 Sep 2024 08:00:30 GMT
From: "Petr Kadlec" <petr.kadlec@bizluminar.com>
To: <linux-nvme@lists.infradead.org>
Subject: Steel Structures
X-Mailer: mail.bizluminar.com
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240911_010040_807729_9FDA257F 
X-CRM114-Status: UNSURE (   0.83  )
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

Good day,

I represent a leading manufacturer of advanced steel structures with vary=
ing degrees of complexity and technical requirements.

We undertake orders for containerized (module) technology stations, scree=
ners, separators, centrifuges, cyclones, tanks, silos, high-power transfo=
rmers, and many other solutions. We also offer comprehensive execution of=
 industrial installation hardware.

By working with us, you gain access to comprehensive and personalized sup=
port, from design and material procurement to access to spare parts, thro=
ugh stages such as the application of protective layers, thermal and mech=
anical processing, as well as galvanizing.

Would you like to learn more about the possibilities of producing customi=
zed structures tailored to your needs?


Best regards
Petr Kadlec

