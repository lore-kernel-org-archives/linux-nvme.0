Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB3CACC6B1A
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2026 11:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FHiNAL91Xid+WHCxhOo2pAad/m3iCzr2YePKwS0EFY8=; b=u8KwEBf03YGUwqwR7mJePD6LVo
	5vN4AlmKuHrFWmetlekZbcYTr18Sia6HqyLxqY3mjmmGSKyd+sE2qYOKBVUeC/9mF30T/uu/Sul0Q
	u7vkIMcauh+X1mPNmptd9UISnoCFPTApG/9IgOgJBsFJhE3U56ORz/dM4ou07Vm8nlItXNQXKPU/x
	xMrj4yHcZSeOymjOFCT8JyITjnbSTnIAI7bRbiR2189sTVleXOHsMEnb4OMts3MyWymB+U0B6c3wE
	xKnHJi7VSzHof/O21MrS7OwaVwAqvgwxfashuPV+k4WYsxirKP3q2Qg1ctujlaM4dZK+jkGILaTEp
	KcozYJOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGwkF-0000000FGsL-2Aw2;
	Wed, 14 Oct 2026 11:02:03 +0000
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGwk4-0000000FGqC-2eM5
	for linux-nvme@lists.infradead.org;
	Wed, 14 Oct 2026 11:01:55 +0000
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4a172eb31f0so33186315e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 14 Oct 2026 04:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791975711; x=1792580511; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FHiNAL91Xid+WHCxhOo2pAad/m3iCzr2YePKwS0EFY8=;
        b=irEPBjwr5C55G4ABQsnT1EPVaT6LqWmrULngBCsVPS3eOCa7I355u4YeB8KKBf1NuV
         Pjl3CAmwTljACHYd5XvCVT/MVT84CXHFu5PjAMWjhAd1K5FIsr78DDMEr08vdjtzAVIp
         JAT45HgaSdQTuzy7id1jgmpI1mrPpjzC0reVod0f+z72NRJ5+0jk+HSAupMcbTst92zH
         OdmTVBvpFZ7mCdomwGSfwgjbj1TVwhc/m9KJ82II6TPIt176LdjKbZ5uqcXXPvHRY2RS
         VvYHuAlW0IUwtH1w6xpoWFOLZ5C3Rp5woyLKqR5VoIW/J3j1kLO5y8Zp0Z4Q+HP9HmRy
         2Esg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791975711; x=1792580511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FHiNAL91Xid+WHCxhOo2pAad/m3iCzr2YePKwS0EFY8=;
        b=2RdZ8y3zOHA5QOzmGeGaEdB6MxJQP/CnpKITa1o++a+r4liZRUkuyi/2i4n8T2COyy
         vUkwYVqRoL1GxKb/AJ45vsdk50z80Wy6Vbk16LyFVD9tg649lhrAm9BtjmCxduDZIVSs
         ZBaPgvQnoXt1jOer0+t9YGG/lkCum5kdCLOvmg1JMfAMTdI4UvSGC1gXXZDCGjFHhj9c
         AUDuwJZ5t9qBG5D7Rxq0Zz9ynu8xXErH4pVur8LUIuny7oIxvZYYoUKcMRoaCD99gjtE
         DfiOW/iApdM8UXiqTbuvQKtvTevZTa8wSsm3+2ngSPG/cIwqcVd2Y3WM0FH6y+A6UAfu
         WNpQ==
X-Forwarded-Encrypted: i=1; AKwUvBx9Q1Y5sbO7QrhCH/EPqk44KohjpImBQb8tJZMOd0jHBxBpabi7RcUCEXiB2hAXIT23WY4Ov9XZHM/X@lists.infradead.org
X-Gm-Message-State: AFq9FYI/1lFDTpIaZOaOuTpCM3AaVJJ0sOLjIi2VJwM3W2s+TEKP8BTm
	wLGXSiMljYCUMjvovo+fxrBLSb78iAULgEPWtJyU4WxxveDZfCrz50CV
X-Gm-Gg: AYBFou27LvfH0etSZjVo8+GknjP/LXXBoq9d42KPmvjFTCnSNQxKjlXyoWymnC5MbWW
	8sOtcRLces8xbngO9q3Gbb/IeyzoMphb5vV24mk4Z2IWQcjhpoIXyO+LNZTtCCWSn5HYjIrD4l6
	EXuGNAdHqYsyinb3GeIi7lE/X4homa6X7ufBDzoSVofZExZJXO4mmIoU+eOkM5H+Wi34SXaiG75
	94y9lgInsRBH+jL6B7XBJnEuYaD62GDybLlEp72JiGlBaNifzIXoZ2QyxuuRLNPcKTkh0sHjrWe
	rxWckLExCjLbLZR1zr/s7Z8GNCVIJ7yksfkwZxMTmIbUsDt7BJZvYpSQCd7Csli6BQqpL+7cgkL
	Y9Jlg9MRrSIvhQCtfgfD2i5SHptal/cYsLv9v/9ykJ16djsL7a2zZ5N0MnR9R3HjWYORd5Wn/d4
	+9hmKp5hXEVpqmfMaPpMJatuPQ1BAwuQq3ZaQkMb8F97ea46Ma0DV10LDUj5+aEabhtT8g93/NQ
	9ZPMhH662DwAVRhk/hkHrLlIIMxXzhsdrF92+9x4krUZA==
X-Received: by 2002:a05:600c:3e0a:b0:4a0:1c10:1419 with SMTP id 5b1f17b1804b1-4a18e4cd667mr303811435e9.26.1791975710181;
        Wed, 14 Oct 2026 04:01:50 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.109.133])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de2e2ef2fsm9396807f8f.59.2026.10.14.04.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 04:01:49 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 4/5] nvmet: pci-epf: report transport errors in command completions
Date: Wed, 14 Oct 2026 13:01:45 +0200
Message-ID: <20261014110146.95291-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <1b4ee842-844e-4b6a-9ce8-0c4e7229825f@kernel.org>
References: <20261012141239.156408-1-parri.andrea@gmail.com> <20261012141239.156408-5-parri.andrea@gmail.com> <20261013142736.GE14759@lst.de> <1b4ee842-844e-4b6a-9ce8-0c4e7229825f@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261014_040154_301571_0116E7D5 
X-CRM114-Status: GOOD (  11.55  )
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

On Tue, Oct 13, 2026 at 05:12:16PM +0200, Damien Le Moal wrote:
> On 2026/10/13 16:27, Christoph Hellwig wrote:
> > I think this looks good.  Damien/Niklas, can you test this on hardware?
> 
> I do not have the hardware available right now. Niklas ? Can you test this?

Thanks, Damien.  I don't have PCI endpoint hardware either, so this and
the SGL patch are build-tested only.  I'll keep Niklas on Cc: for v2.

Thanks,
Andrea

