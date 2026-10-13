Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B469CC6B16
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 15:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vlJ72bvKXAZMaGRlcugIP3h82wTWg8aaVMxMBFjQrAs=; b=RRWw3fwqgdMArF5nO8OSmXOsHq
	6UCv/IZ2CoHcW5X8LpZEnzVzJWld75WAL+lmmyRp5Q5y/iKXVdZsLUYkv5ar8UxuZ92jP48W5LQqR
	e9FyvdKmI7XUdBTH0OQ4LDPKYwoTQzYIHLY7zFclAFsZhdWyAoQfVyKiiQa5dcjTllilEsrxRchO8
	DVelFpGRXNYI+OrroD6LZ23j/AMaugNB1fV82yG51P8L3MDO0FIFE+Bf67oXMAQZSa/RIAiozHjKW
	WRXljw/hoMG31VyeK+R+3xA77u5/YYg7VekSiwqdtQY9Aff/Suo+7jo9fpYDG46ngWb93qlXCnzxQ
	LepSdAYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGeoO-0000000DQfe-0slr;
	Tue, 13 Oct 2026 15:53:08 +0000
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGeoL-0000000DQez-0azG
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 15:53:06 +0000
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-cc7cc8aafe6so1226248a12.3
        for <linux-nvme@lists.infradead.org>; Tue, 13 Oct 2026 08:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791906784; x=1792511584; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vlJ72bvKXAZMaGRlcugIP3h82wTWg8aaVMxMBFjQrAs=;
        b=n+FU8VQ6sQaArWSXR0jZX3coqeBHeYOVL9l4Broyab6Hl4OdrSI8kskGD0lHGvhhQ/
         ImF38mGw7XkaISp/HCYbSm9osA1I/haYZYQzqKDicA4W2VXVW8skfNeufj0NyL9tpQHO
         F9ipA0t04yUDsKivNSQ4AT7GUJi8Ab11adEX80jzM/3wwqygFqzu5tBuLSA6WD0uvQe0
         LKB8bfo2Uvpdm5RBCWOF4+GV+F3m8/3KA1kRUyc9fz8Wz0Whs029HbH3wKuz2fB/2qy0
         XoNDBVxS+q+qTpfnMMkzb34tUwEG5O4cvSy3UHOiU/CNIQtzbva7cRdusB8ph/tXT4UE
         2PMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791906784; x=1792511584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vlJ72bvKXAZMaGRlcugIP3h82wTWg8aaVMxMBFjQrAs=;
        b=dnWslONuW8WAWAXjXhHRcfl3xWVALS5lxaGT3Os/AcKiOEItUTAnpPNxcEz/a6RSk4
         VHmFjA9vSAuHrvUiG/EnReVTmMHvE7C2S14DZlfifF0WPpQGoOT6LZk6xQiVr8VpBQTM
         Iud4x4XeCCm4Y3PndW8CHu4HVao2vzHYyo38MdmUXQ8DPKap9D0gYE/sYGZS/lXsVsfv
         D9askPZmuOBIaZxk+qJ1QEj0GDwBJf+cfKrVVRz5mJ2ozhMQeCFJJHXrDqBGE0oqAXgY
         zZFDH62qfsB/ahSgPCBNVF4CdxqTZ/Qd5g0x4+ItvFIoknvlyCV6Mqp303U6FCjaAFUI
         Cf0A==
X-Forwarded-Encrypted: i=1; AKwUvBw7jSqZilWqaViLI7xxP7etnKtCh7941Mlx2bctHBoxp8oeFmlps/5uVXDeG6h5/CREMj1cPbnZ5OG0@lists.infradead.org
X-Gm-Message-State: AFq9FYIqH25TqRyjsTXY3/zmEZEBKToqcDw8mHvPCbSKHnl34nvCj5Ah
	Ur2Ea8qKA5A00NGi6BO3Hl1apb3+Tw1eBPf6JJqWQPPniIazRJ/y/G710NJIjF4kZTs=
X-Gm-Gg: AYBFou2k/bq/Oz1TIayg7cpq/VOKb8fhLNrm+W3tXu173qCefNdgL2fTlLq/Fomo+7A
	1M5HhBRmusq8i3LCVYhfG75vX1iyTQb/IEU9Mo6+GP/SJFty6kjf0eydzZJV3iK5IXj6FGBapEF
	VzFpeKYeo1sHhVFn9qiVNlg6D3d4k1rkl0OAUF1RI8KgtsD7cnMaoI+8GgaCjPiQl1B1n+aQ28s
	dFY08B56+5eukOCb81J1G/LZQeMWBjjuUIeUMtCtjGerDoIdkDDbazWcSho9d8rTirTbfdH/qLw
	oKrZEdfFUPhwuQQp6vQI/gnWOZ3WFkl8CqP5j5yaRCvtVQ5UFOGkW7pEMJE8HK1pMkRld6Z3WVc
	Wd8ELfm9wRCsqyilj1tAsBQpzyaqQIsnlhGNmQmXFOga4MpAp0G22ms/nfgndcsZaEre5apuOsc
	hY3xrZHv7BqIQacVzxEWI9+uum1VCW+sqJ+BeyKJDKeLaK+W6GlDpoM2bDGzx+oz4LT1HJ2Ynfm
	o9c38Gs58MVnmpq4V3w
X-Received: by 2002:a17:90b:2ccb:b0:3ab:17b6:9a93 with SMTP id 98e67ed59e1d1-3ab3afcdc6emr11228102a91.52.1791906784181;
        Tue, 13 Oct 2026 08:53:04 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:c51c:be8a:c517:276])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac5f27d491sm165944a91.12.2026.10.13.08.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 08:53:02 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Nitesh Shetty <nj.shetty@samsung.com>,
	Hannes Reinecke <hare@kernel.org>,
	Kanchan Joshi <joshi.k@samsung.com>,
	gliuxen@gmail.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: Re: [PATCH v4] nvme: bound FDP config log reads to the received buffer
Date: Wed, 14 Oct 2026 00:52:36 +0900
Message-ID: <20261013155236.3188723-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013142003.GA14422@lst.de>
References: <20261013102812.3020500-1-yhlee@isslab.korea.ac.kr> <20261013142003.GA14422@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_085305_183510_E1132E33 
X-CRM114-Status: UNSURE (   8.81  )
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

Thanks, all.  No objection to trimming the KASAN trace down to a few
frames in the commit log if a shorter one reads better -- please feel
free to cut it down.

