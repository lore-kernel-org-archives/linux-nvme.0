Return-Path: <SRS0=7aSL=EM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39DEC5517A
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 12:34:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E9002071A
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 12:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vBHqDf5S";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="ygaOOI0K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E9002071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=G2IktrduGxwZqGq4k0MgqkXbuUIr6K4Lu4wjFnKmkqU=; b=vBHqDf5SEGIiMiKK/mhVbauFO6
	Nvayj93ffECPeQjLLWE3TUuQy5YKM02Ma931fs8ueCiETBpYqigKOyYXPE6lmPwyLQJc2IgTMrzZ7
	PdYtEklWReZa6LWDVG0nv0PWe+Pa4poEBAUIfDTSU9z4SM98vgV1iPtq0gCN76BvGpnxMVnfjMUNd
	vPpHb09rZQ3AcJHABGjvmT3E8B6FZBDYvIcHhFCfWLcBxs1VspYUEHvDZ8ASX3AM7bGY/MijFVtrM
	npCSKQw0x41+DgLIXiRi6o+ULvoLF0ohxAVB4xumgaSlqJdc73GTWs1LtxahOtaHOPA/DJC0E1qHk
	ToiR5oTg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kb0x4-0003JL-Ih; Fri, 06 Nov 2020 12:34:46 +0000
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kb0x2-0003IH-0r
 for linux-nvme@lists.infradead.org; Fri, 06 Nov 2020 12:34:44 +0000
Received: by mail-ed1-x532.google.com with SMTP id o20so1099363eds.3
 for <linux-nvme@lists.infradead.org>; Fri, 06 Nov 2020 04:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
 bh=40gpl2JklJx+/sP7r0Ll+gdyPKCJhIzg3bso1L6wPXw=;
 b=ygaOOI0KKmsH8FBSW3YD5D4TDcmJqP+bM79QnyBl6V4o0feNNa8ohKeFGis024Z1ir
 s3p5OTG+5Cdt744qOMxOfkhgVPFdX5oNkPPEGYMZmDAOt9AC5zTx6Xh2Z8MJJuJ8am6n
 hrnSnpMnp5frkQtSnCm8puVI5+HUvqdnOYDINrbpwY00+of7peAuYgrDaO08zuGSf9U2
 qWX/UoumaXK1QrUGluxaEpSMKvXdH1XpEoMXnBBP5uhG4CwTjgKI0gHWCzYECw0Sxmoe
 ZZEa40vWQZ3Pk5vR+B7IG+ecByErt3+X8xNH52EFRP7lLuvbeQu+NDD1sNiTS40JnaFV
 Ouzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=40gpl2JklJx+/sP7r0Ll+gdyPKCJhIzg3bso1L6wPXw=;
 b=FDyRCPSQKtUB/7bZgqJzJesJCcCVXFsIa6rtzXDEz0Ew/vhrXKQsB9OR+IP7OpD5xC
 LzjD7oEaUXjlY8b9xvVAe9JcyscS1kORGwQ2KpWc+IeB7g6hojGyWCSqIPjmDW5CT8hP
 SdIfcEquQbNm9jaQz3weHWx9Et2tJCGFo9B6sVDLFoRuIYaP7kL48DGY4nk0HYU9MBsJ
 wXjhFLXyOeyM7ulx04H5hIR1GtfAEf/iN1YBYFWbQJFSSUZqDSdsqwmIhE/KcttT548D
 oB3XfZlrX7cMSd4N+qFdFaXSbeTmv0Aqd3cbBC7WMMuadYmI+B9IdXwhLxNHgkBf1Sl2
 Fihg==
X-Gm-Message-State: AOAM533Im+j6gsYQXmiZQhZU9p0q7WmlCEQVGsaQRrousO3DSmLkVcyr
 AISF2uPHbzOtJw6LUJDKG0D54Q==
X-Google-Smtp-Source: ABdhPJz9Vhx0+VGN7p6qFIXk/sTMp5K3I8D7JpKxkCXoOemb2+5ZPrpfEXGrttIC/iQr2pTqeOKF4A==
X-Received: by 2002:a50:e686:: with SMTP id z6mr1748812edm.188.1604666082735; 
 Fri, 06 Nov 2020 04:34:42 -0800 (PST)
Received: from localhost (5.186.126.247.cgn.fibianet.dk. [5.186.126.247])
 by smtp.gmail.com with ESMTPSA id rl1sm837113ejb.36.2020.11.06.04.34.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 04:34:42 -0800 (PST)
Date: Fri, 6 Nov 2020 13:34:41 +0100
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>,
 "\"linux-nvme@lists.infradead.org\"" <linux-nvme@lists.infradead.org>
Subject: nvme: problem with chunk_sectors and blkzone
Message-ID: <20201106123441.wjci7i3gij7jgpue@MacBook-Pro.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201106_073444_100489_72A8AA3A 
X-CRM114-Status: GOOD (  11.86  )
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
Cc: Klaus Jensen <its@irrelevant.dk>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Keith,

I have noticed that one of the patches merged some time ago, where we
are avoiding to set chunk_sectors due to the lack of noiob indirectly
breaks blkzone

    e83d776f9f98b nvme: only use power of two io boundaries

if id->noiob is not set, then chunk_sectors is set to 0, which turns out
in blkzone failing in ZNS SSDs not setting the IO boundary

     blkzone: /dev/nvme0n1: unable to determine zone size

This is easy reproduceable with QEMU

Am I missing something here?

I am happy to send a patch to utils-linux fixing this (have one with me
as I looked into the problem), but I think it is worth reporting this as
it is effectively breaking user-space.

Thoughts?

Javier

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
