Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0748CC369AB
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 16:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Ji/0WU0Hkm/Wd/Ac+aaMEEcuwdORU+nluLgv81PFOFU=; b=31TjqW62TxQn+v72EeCe6vwyCP
	vv3FrVtQHKHFOAjL5PaQK7Xn7D2H/8ZS71mLMKV1xqQs3zxRmFLRAB3V+iLAty5jDjxLXGSIzLd45
	tKlGuwx0Ma30TGe2xdloOdtbQ++2r4pCyHDwF2be70mG0b9k56V6qbqq/MphS1GPftTfs3QZnNlIl
	QCArsClW5qNWs6aR+IjGXiPlVHaW6FBkAjwZaePIyT1z9J9Qb+kCMSC6O5lLA5E1PPR5h+xXf+gjq
	Mn046pNjo6H3XOrGspIIruDQk0WKPgK9+t0qTrS4u75faDo4LmmV6j91G06bU2xEfLjxd+37nT02K
	k6DnESdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7zWN-0000000ElMZ-0yTq;
	Thu, 24 Apr 2025 16:33:55 +0000
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7zDn-0000000Ehqb-0fHw
	for linux-nvme@lists.infradead.org;
	Thu, 24 Apr 2025 16:14:44 +0000
Received: by mail-il1-x143.google.com with SMTP id e9e14a558f8ab-3d91b55bd39so7018275ab.0
        for <linux-nvme@lists.infradead.org>; Thu, 24 Apr 2025 09:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745511282; x=1746116082; darn=lists.infradead.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ji/0WU0Hkm/Wd/Ac+aaMEEcuwdORU+nluLgv81PFOFU=;
        b=J1KY4sz7bQMioYGO0eCTQSE6oGqM9l1zwNX1WrQqJBZqIk12PJHO2zfmvrfu32YwHa
         y4bQ21kUQNLYoHWG4CjtJujoEZvxCf0DJn52qQrl/VMpnaGYjvBcgJR61oYF/l7CYPpB
         JcYmRqyjFui4trBSIAm1PmQw1CcW6DAKOWszPcIEadRPNej8PFuRTpwNIiP0RdkSZKeu
         E5VPLjsiNNDzMna6GUxZ5JlBUkQRY2BAL/aM6afPVpmYKdmqV9eLi9ClDAfFk0K+1k+2
         PS5ie+OxM/ONbwOP9eFPdDTDpK3WonYeOlFcWGpFdm/7hqp+iNJm0d5j4XDsYCWM6r3x
         nhNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745511282; x=1746116082;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ji/0WU0Hkm/Wd/Ac+aaMEEcuwdORU+nluLgv81PFOFU=;
        b=pUG8sC8FWFdYfz9E5gXgD+OBjePpYwQQZrhcQjxt+qQgZjc65dn20+F0ei14ienr/Z
         fxgsvN+BBmnXyVJqD2TcKNewvKP2q/wuTsymZ5ew/nVxS0uw3pPvivTL1/EIUlsx50qK
         G/LMhL/XbJ1+yiXVR2HWOo3FGKHAGKXTOWoaZk9kV08kfgZQVnvGpy0nW1i3WE9pNEzR
         iCh/i6q1hAuIpYgctaab8Oete7XaD88fb7vpgJP2x3SmoraOA8gL0BIlqZuHZHVt/dtO
         tBoONUYAEXQgs/zi7Zb0g7xF76+XLXn9i3XQY5MKUqXn1B2zhd3t7yNrGo/N7Lk1UWM5
         GF3g==
X-Forwarded-Encrypted: i=1; AJvYcCX9NYenBvcBCvDCQUdiOjULiukUZDz/8Md8Ataq6p1pqka/L8mw3om+H/g1IxPPp+iXvSlP5N1jzKe3@lists.infradead.org
X-Gm-Message-State: AOJu0YxUCO/Xzt+FtI+/7mWNj2tYSbdtW6mi7DKl4R1ZHqEVsZA7HBnb
	vMAsEQwPCYiD+XzP0E0FXvuxkOIrqudiz5z9um+tO97A4nK9clbuh+E3z9lEMr4=
X-Gm-Gg: ASbGncvwdgUgG3WEVZNh1NXG3HIK6i89vVBiFwtlmhS1wHb27Mcnr2y2lyMcBzctlMs
	PHXPBqeKw8u7+5Q3aaDXfTSQwmWLZbLOcdLTcZBDDAhoLfHGQzpuzlcpmZEbNA/AN9sdWu6N7pH
	OaOQgeW+keNetAXYKqD3hAVdLy/H06NBnBzgGBhtUM5+JqO/sXr5r+ldo1oXc3w8OtIL6VAy5NB
	q9G5Baijv0TH/l20nMaA3qDY8aRT+wt//O6m1DE6vJis9wUFBf8KDspIVHdmN4U8PoHR+6DcLyL
	B4eyZA/Y7pAQljpAXx/iFexh5u9nBoMOGt0Z2wIgGLOPaoqt
X-Google-Smtp-Source: AGHT+IHFPgnElAxZcqW1tgQiIZ2Unus+4rkzCDBPFWFzjHn1qt49SXmEjV32GZC2wJh6qjNVKHSPSw==
X-Received: by 2002:a05:6602:3f0a:b0:864:4a3a:2567 with SMTP id ca18e2360f4ac-864598fb52fmr28809239f.11.1745511281657;
        Thu, 24 Apr 2025 09:14:41 -0700 (PDT)
Received: from purestorage.com ([208.88.159.129])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f824ba0eb9sm333003173.110.2025.04.24.09.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 09:14:41 -0700 (PDT)
Date: Thu, 24 Apr 2025 10:14:38 -0600
From: Michael Liang <mliang@purestorage.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Michael Liang <mliang@purestorage.com>,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/1] nvme-tcp: wait socket wmem to drain in queue stop
Message-ID: <20250424161438.g2fyo4ozvburf2rh@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_091443_198609_D07F1BFD 
X-CRM114-Status: UNSURE (   8.58  )
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

Changes in v3:
 - Use nowait to stop all queues first then wait;
 - Check queue allocation flag in wait to avoid accessing after free;
 - Link to v2: https://lore.kernel.org/linux-nvme/20250417071036.a7nhovuokg7w2n5r@purestorage.com/

Michael Liang (1):
  nvme-tcp: wait socket wmem to drain in queue stop

 drivers/nvme/host/tcp.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

-- 
2.34.1


