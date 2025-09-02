Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7387ECA1005
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Sep 2025 12:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Oy0+ZjgcUTHxI8IO6SmQY8/8YB65RaZy/XYvD1uhubU=; b=copHs2Si64NY42WXmHZTgD9YAE
	8LAz1na/lSB8N69e4Hj3ub8SZ+wXLW5bOhSPRKuQchjmGnYt1nRyq1DRJJZXWqdOf2tM5XhhBDs+H
	ySGzXhqLjYla3vy06tgyz0CikYUYThgw9mTwLZ1cz28KJrdu+DqtSDvDTy35K+n68IGFHED9ocVcU
	89Ji6vlwizAN2X7izaFmW6KuI+zc3RSHf5RA7dR8bYdZMqksIgSCtXpBBUUYDR25uczscHXyBT0/o
	wbW3nyY2yaztMxTDKqSNlgIFjj1MBhTXKQvbpzHzDwY6czCkammnRQ+mvposBI96iV+PDU7s4pkFU
	53ExgHmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utQBv-0000000HKMl-3M5b;
	Tue, 02 Sep 2025 12:32:51 +0000
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utOMG-0000000Ghv8-3M7w
	for linux-nvme@lists.infradead.org;
	Tue, 02 Sep 2025 10:35:25 +0000
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-77264a94031so807246b3a.2
        for <linux-nvme@lists.infradead.org>; Tue, 02 Sep 2025 03:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756809324; x=1757414124; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Oy0+ZjgcUTHxI8IO6SmQY8/8YB65RaZy/XYvD1uhubU=;
        b=Y5zZHruFOR/eYmSJBXwuAODLOSox7sy/0BcCBt2QHhY5BSEdUYBufviktgQA37KTT1
         CiCJI71dWT7M5hvkYZGCkXx5eBb+sMkORNNG+ArkCe/YsqjMqaT5JsB4JqntHgTOSNl8
         +rBd/KgbEVlY78dyb7YS+EpzNsjguzTzoWkU2KafzSRfdrgntaG9xniscjRJvtWS/Ek8
         KmGR3/E9j7zVysmvIi3WRy0wyrAmzUs6YD0WtLT6ZdUDhiiv8FDEKkKfWd92Y1RowQ5Y
         TRqB3+K5KmhAqsETiGQmC/mI8GusXf5+eKnSC7mker/ZUIEI/g0GVhJrG7QrN35nfq3N
         Zo7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756809324; x=1757414124;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oy0+ZjgcUTHxI8IO6SmQY8/8YB65RaZy/XYvD1uhubU=;
        b=aloWehiMyj56S6DemQRwvOFQ+UzaQGLhJHC4+YR3FBZPqy4yZZQ9pFwEA2WbhZIIpJ
         S4ur8s8gPUL48jj//8oiK8T3EN60KFu497TEZMk7bHf10b3Pv91p6mfvg7nzFVAuFWrA
         JMFA6zIFI5SSTBooXHX42vkf7Ct5D7AQmUbLpMU1Cx2qsM4YRQTZmlydC0fYE+wAwyQi
         X8U/+iEHthAl80VLkIqAbFj5vUSUmOfwfm80iM+XM+6LUEk/Rs3oDTHHmWE7D0jyJQ2t
         aIe9PB59bELPuX6I/ybmazvv6Hl3BfnLHrAT2wjNS9PEKc5Kv9JCEHRTsWQxWN0aL3GS
         wM5g==
X-Forwarded-Encrypted: i=1; AJvYcCX8Rj8a0O4h7BDTPDfp0oIFHCjf98XuxD17sehvcDdhYwbVGpm4FB3QINr74N0IVpnaBb14dYLfwNw4@lists.infradead.org
X-Gm-Message-State: AOJu0YxDX6mhva8Rnl+aIIKCnkLZVI1tQeW8w6aNPzZzmVmsbV1DK70c
	CyaLl/TdA1PjB+2VJSpk2gI39LX2EUngA0hiiJ7ulv8WX9H3m2rR3QEn
X-Gm-Gg: ASbGncuiolJzJJJMuRjKo4NWw7DQSZ1tF+NWCSwfCArDvBkP7Ytm8UOtFW5BlmM9gTv
	DzaHweeQHPGIvgaIbJ8CGBlD5JeUjPBZolxzqDdtbv75ewzyrKZhwr+1aB0A34Zb3WsA8ZNp/pP
	jjiWpKzzKIfeKfozc8J7GQwF0jTrJBmXONAP+aSdPLEuf5dPm19g/kNdv36O12iqCrpDYF7Wyzk
	jVgy28pVhbKJbUKjAQY93Fp1xMpq1pnp32ccxxSjVy0OowLUYoD7ds9T+IAad/oRhIBk+gmD3mg
	OgQ2WkLZywpFCdzX7Qc80cwJYLE7OtvIvpivsX3PuKDVn50+XMvo500chLAcdoRGwiyIvXAjN+l
	5k3SJ4htE2qBaGT1aQLoTzzE9cCi+sKR+O9JQVOWbBJ0e/AECAYeOmEcj
X-Google-Smtp-Source: AGHT+IHBEIcoAXiQBDvntsTjV/I1iMaCm8Wm6ePBm+ak/qeK1Wqgqu0CzitAXYtbtdQW05BUkEvq7g==
X-Received: by 2002:a05:6a00:240c:b0:772:3aa4:226e with SMTP id d2e1a72fcca58-7723e33851amr11538796b3a.19.1756809324019;
        Tue, 02 Sep 2025 03:35:24 -0700 (PDT)
Received: from [10.0.2.15] (portal-nbc.netapp.com. [202.3.121.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a26a4e5sm13363163b3a.19.2025.09.02.03.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 03:35:23 -0700 (PDT)
Message-ID: <2841bd1b7910bd0e1b263b393152f2cb13dd3ae3.camel@gmail.com>
Subject: Re: [PATCH] nvme: Use non zero KATO for persistent discovery
 connections
From: Martin George <martinus.gpy@gmail.com>
To: alistair23@gmail.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, 
	sagi@grimberg.me, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Alistair Francis <alistair.francis@wdc.com>
Date: Tue, 02 Sep 2025 16:05:19 +0530
In-Reply-To: <20250902035211.2953174-1-alistair.francis@wdc.com>
References: <20250902035211.2953174-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250902_033524_840782_E34453EB 
X-CRM114-Status: GOOD (  12.84  )
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

On Tue, 2025-09-02 at 13:52 +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
>=20
> The NVMe Base Specification 2.1 states that:
>=20
> """
> A host requests an explicit persistent connection ... by specifying a
> non-zero Keep Alive Timer value in the Connect command.
> """
>=20
> As such if we are starting a persistent connection to a discovery
> controller and the KATO is currently 0 we need to update KATO to a
> non
> zero value to avoid continuous timeouts on the target.
>=20
>=20

When would this ever happen? Won't nvme-cli & nvme/host/fabrics.c in
the kernel ensure a PDC (persistent discovery controller) would always
have the KATO either default set to NVMF_DEF_DISC_TMO (i.e. 30s) or any
positive int value & not zero?

Do you have a test log for the above scenario where the KATO ends up
being zero for a PDC?

-Martin

