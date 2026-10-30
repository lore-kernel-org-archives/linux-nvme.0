Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF3C606A31C
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Oct 2026 13:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=sS7VoPhN;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=robsoncassiano.software header.i=@robsoncassiano.software header.a=rsa-sha256 header.s=cf-bounce header.b=YKilNunR;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=cloudflare-smtp.net header.i=@cloudflare-smtp.net header.a=rsa-sha256 header.s=cf2024-1 header.b=JFH9qcWC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Date:Subject:To:From:Message-ID:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=cEobcl7c88x9QhVf5/nXmvYezeYLt4FG1azzLPhj5Ig=; b=sS7VoPhNAX/8Tx
	qJrwngEEMrFIBeWoHiABDvMveO7hbNDFm+FstyL6+d2+Q1PUMGy8ICT75tM/WuT+b8+wRVujI/sKu
	tUNSapDcj/14WXEoGEsl7UiOGz4+oJtt1jzKzrrmN48pgjWa9vVflFskG1hkfft9BloyG/MO4pwnK
	/miiOVmExze93OPtXvjWRUgi7K/jygu6UG4/pJXaeVmMiHEpEePoAx29M3jeBrtBdeiU6rFj4w2Tb
	2udMDBdNQMo8iYuHzPVkB3P5wqCS9/grJKRl8pCKXCe1Jo/NfpMiSbySbBzlY+/z9pW4FUduJ9mj+
	pupHxR/Tm28+2AU+MvXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMmnW-0000000Bljm-2xvn;
	Fri, 30 Oct 2026 13:37:34 +0000
Received: from bg-jh.cloudflare-smtp.net ([104.30.16.97])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMmnT-0000000BliO-2kjn
	for linux-nvme@lists.infradead.org;
	Fri, 30 Oct 2026 13:37:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; s=cf-bounce; d=robsoncassiano.software; c=relaxed/relaxed;
	h=References:In-Reply-To:Date:Subject:To:From:Feedback-ID:from:reply-to:cc
	:resent-date:resent-from:resent-to:resent-cc:list-id:list-help
	:list-unsubscribe:list-unsubscribe-post:list-subscribe:list-post
	:list-owner:list-archive; t=1793367451; x=1793972251; bh=cEobcl7c88x9QhVf5/
	nXmvYezeYLt4FG1azzLPhj5Ig=; b=YKilNunRs8rOCbDTUi0c4IysJhDbqlxGdYh4ddccE6hV5
	R41D37XcWec//2keAO1fV0WYMjZumUSmLZ/Hdc/zRU2IRjrOIASoo8R0bZWkzapL5tAJwn0CeF9
	+whtU6h/TjZj3/OoVC7DvWaT5vI4CSvm7gM0Sk0+xLPL4wzRx8U4eD6MCyrkLgJgnbO+767pmUy
	ysEmPNSTT2sxiwOxzcaGWmD2ud5ZWuGiiN38VFHcOJu4qaNnuZCxcpO5NZwouk5aVaoKXuFy7Oq
	ZaAY5K5ukba0G9XvRDzwLQU818FPmhXtHgyNdXyBImc5hJLuC5QvytVNxJQ8ItS2jh/OGBXg==;
DKIM-Signature: v=1; a=rsa-sha256; s=cf2024-1; d=cloudflare-smtp.net; c=relaxed/relaxed;
	h=References:In-Reply-To:Date:Subject:To:From:Feedback-ID:from:reply-to:cc
	:resent-date:resent-from:resent-to:resent-cc:list-id:list-help
	:list-unsubscribe:list-unsubscribe-post:list-subscribe:list-post
	:list-owner:list-archive; t=1793367451; x=1793972251; bh=cEobcl7c88x9QhVf5/
	nXmvYezeYLt4FG1azzLPhj5Ig=; b=JFH9qcWCJXSOGaBKoXtttj3uV9O6tZ7PC5Gt7YTWvfe7g
	U/D2Owns2aBT/HNH2OjBwPf022UsRYUwggzbUBawnwN7rFwdOKw7FoqO6catX+Wc/xTxxn+fPau
	rdQANa0Qb0lfxYUuwYa1iVxRK3gh+BJ7tdnPgPBXmyXwwBwmZa0BVa46PLDcprZZXMOFJ1Oo7lJ
	8TUzg2P1fJ1W9+xE/NjMrOM+E6v9EhVPkChbJw4j/llMMKK3WUb1zU8Rh4P1R12DpPAmVPud1zw
	7+1LsajsuK9lx4c8DaO8QqBFC2dqbj88MqYbntFxiDclPtaxxMHECwO7KvVkZMfsJj/gMN0w==;
Feedback-ID: robsoncassiano.software:5:5:Cloudflare
Received: from authenticated-submission.invalid
        by mx.cloudflare.net (Cloudflare Email Submission) with ESMTPSA id t1TwmakcG2W5; Fri, 30 Oct 2026 13:37:12 +0000
Message-ID: <RdUyoz1qGHmvMC3KpJkRLAr0jeP45R7Ojj1d@robsoncassiano.software>
From: Robson Cassiano <linux@robsoncassiano.software>
To: linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-pci: add NVME_QUIRK_NO_SECONDARY_TEMP_THRESH for WD SN740
Date: Fri, 30 Oct 2026 10:37:12 -0300
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030030513.209623-1-linux@robsoncassiano.software>
References: <20261030030513.209623-1-linux@robsoncassiano.software>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261030_063732_716094_18EE870D 
X-CRM114-Status: UNSURE (   5.52  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.0 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Retracting this patch.

The drive accepts and stores threshold writes on both secondary sensors,
so 0 and 0xffff Kelvin are the spec-mandated power-on defaults and not a
controller defect. Hiding temp2_min/max and temp3_min/max would remove
working functionality.

Tested on 15b7:5017 (SN740, firmware 73100004), kernel 7.2.8, where the
quirk is not applied. The hwmon interface takes millicelsius, so 350 K is
written as 76850:

  # Sensor 1, over temperature threshold
  echo 76850 > /sys/class/hwmon/hwmon4/temp2_max
  cat  /sys/class/hwmon/hwmon4/temp2_max
  76850

  # Sensor 2, over temperature threshold
  echo 76850 > /sys/class/hwmon/hwmon4/temp3_max
  cat  /sys/class/hwmon/hwmon4/temp3_max
  76850

  # Sensor 1, under temperature threshold
  echo 76850 > /sys/class/hwmon/hwmon4/temp2_min
  cat  /sys/class/hwmon/hwmon4/temp2_min
  76850

Every readback is a fresh Get Features, and all three return the written
value, so NVME_FEAT_TEMP_THRESH succeeds on the secondary sensors and the
values persist. The composite sensor (temp1_max) behaves the same way.

The attributes were restored to the power-on defaults afterwards
(tempN_max 0xffff, tempN_min 0x0000) and the live sensor inputs were
unaffected throughout.

The review was correct.

--
Robson Cassiano



