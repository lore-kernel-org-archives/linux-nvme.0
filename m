Return-Path: <SRS0=5LEM=CT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F681C433E2
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Sep 2020 18:36:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93697214F1
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Sep 2020 18:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pRbDwBnK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BA1OPZN1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93697214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=C75mQqdYGvM0wPhrUf9uCkxo8iDn0Vmks32lc/iMa7s=; b=pRbDwBnKFRyS1zCSezcjZqOIY
	kBBaZEXuUWe64T7B/Qc/kYFdFvfnig2zmkXgQXZScYm/zZ6+gVHyrXj69d0Xy+rNqbCkJ51lEsz4i
	X9hncqisKvea14m/pbzEnd4lyaIXFThQkvK7oXzBa6ZTsEvrUwiRoSPd7sz8nv5vmUcuBomjKQmY6
	syZWHns2KZ4VobUfR9Iz0S+iA5wx8pxGwzwAAAPkTtcKMEueLVNa0MSbw6fP7gZmjG7RNMF1hpT6g
	1UZO+LEqMtwlShvyq85tCcBVu5ewxBiEM7lYBwT3Whrh/3fp1LSljmmC68EUlxH6DcznMEH1E7go+
	ffhmrWOsw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kGRQv-00058Y-OE; Thu, 10 Sep 2020 18:36:33 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kGRQt-000582-76
 for linux-nvme@lists.infradead.org; Thu, 10 Sep 2020 18:36:31 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5AEF6214F1;
 Thu, 10 Sep 2020 18:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599762989;
 bh=Ise/zhJfXTx5M42JFBz3YJI4X4k9TZV6Gvdncwu/KHI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BA1OPZN1k6DVunZzioqPQLJxOvjSyvlo34b6GEt56hGXAuzgxWCUMj5RY6GxTAlHY
 6aQGTgUJbIlGb2eC9VRZLGnEZJ/E8KhenbzhTm1RDldNGSWTWRZWD80xktPX0DC6Dr
 F85JTIhRtjusX3kJ7AZPLpFY3u927fgC8mkvyyPY=
Date: Thu, 10 Sep 2020 11:36:27 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2 nvme-cli] nvme-status: Don't reduce all negative
 statuses to ECOMM
Message-ID: <20200910183627.GC3446191@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200909215833.317258-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200909215833.317258-1-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200910_143631_344974_C472D5C6 
X-CRM114-Status: UNSURE (   9.03  )
X-CRM114-Notice: Please train this message.
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Applied, thank you

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
