Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D38BCCD5BB0
	for <linux-nvme@archiver.kernel.org>; Fri, 22 May 2026 15:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V6CiLFdYiV3Q7ZtuI9KNP1Ontp/HhSPO+ET7rm7tfZU=; b=kA4TpA7TyN88G5P8D0TB8+LDTn
	/2InK/MUJ1Lm9CEvNruGzKec3eABgslTn/6hEcUR9AR9W/kvdwb5cXaaUXXEVSBGBUgUwnfyQ+l1G
	KIJxOtF1FurTuagDUMeq+wKJF9KNMihd1wlKNoXsdYGx///s3zrd1hxdji3lPOYCYw/LV6/hOTSB6
	hTfUp9LSv/Rz5ixI+R75IDrVPczNR1dvjgm5nbisRbquVInJ6DuSAisoB1PfuPVlMAB9T+fkilMC+
	Bz0rGGeAFRZWjy6OheKToBqfh2IQMAmEjjeqXkNObUpdmnb0IVY97kTfyFeqcgCDhQ6/QMdVveXRD
	ijxNsYIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQRrf-0000000BGKd-1X0Q;
	Fri, 22 May 2026 15:32:43 +0000
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQRrd-0000000BGK8-05HF
	for linux-nvme@lists.infradead.org;
	Fri, 22 May 2026 15:32:42 +0000
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-bce57c132b2so1493375066b.0
        for <linux-nvme@lists.infradead.org>; Fri, 22 May 2026 08:32:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779463959; cv=none;
        d=google.com; s=arc-20240605;
        b=Oe8iP+3SW95VsIDlQw1DS4BBg4qtguNVQPwOiews2UWeKLsCut4NMOjNYK53yGCOu+
         dmL1+Y1Jt/wamV0OEthAYAyUehsEsE8hAE7ZFwJOoZnNMIfetgsoFk0D+FboBaFT85hJ
         PVB8E53V2vNdU72f0Yxc7MVev6V15BptpdmlokOJ/mV5PPBCc279cmAF5fNG9tkIdnq8
         /0didhGmlvG+ZLsl/1fpsOrox3qjkohAqFm6TB0BIUWCZEBBPVyuuqbKcvHBfQyQut14
         iFFWnR4+2ZTLg19NEuH3MC3BrVc6czcs+O/9ZCyNX4dB5xDyXDprMKt3kvMt9uYSrOz+
         KYXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V6CiLFdYiV3Q7ZtuI9KNP1Ontp/HhSPO+ET7rm7tfZU=;
        fh=6Dmq+rStMlewNi4jHgwQSdoHPNHTZE+2XTmFNzuF33U=;
        b=AZ9ZUC6VsVDmhNyTcYSqUWWVTeR3wBUe1qN5lmV0WpE/c2Vhb3pm9C7eDDy6CqRhzo
         5mW7Z76GbZpiS1PQPDw2ONvXu6Kuk1Taizr2QGjZGSb+OiQQpNcGb4Npk2ohnnM0ULK9
         M+aM9hbsM9ZSBu0Kmfr0JmODuzQtb6ldilrtoKfZVa7642ecn91/fGzFz1gNiIaqBxY7
         GVPNPiTECu+MZkK3XT/8XGJQtqvf4b6RyBtBD9vaJfEMSYPhcUuOxr80rYHauEcZgIWf
         aOgt3uPtoAUcGDJfSdESQy5INRgXGBD5h0JyrDDLA5Eg9Fkfk2B2ggdG/V4uTZERWOJ3
         h60w==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779463959; x=1780068759; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6CiLFdYiV3Q7ZtuI9KNP1Ontp/HhSPO+ET7rm7tfZU=;
        b=k4pgZku+nUz5uynrQ6GfBMXQG0U4mAkHQzcOiMjW9Pm8Xx698bmq8wGhsDZCYigsMS
         kXN+ePuwirjolhFV1MeX/3tkJulVl/MgnC7O4xlgZpxA4faOCFQxd10Yw0ZTmvbNHbXo
         UqPMPK2w8oPlPY0NYTrZB8BvmC3UJDuItYIzwErxrnPR1Oyak36DGYMnqWeulawKwyd4
         XmTsrcfAA7pTpXmY9zGiUSCO4cVL9/9oh9dBWnf7X2+/+PALINdDFFHfRwO1boz90vaQ
         oLDpIgn/ipAHhLtooA8C5XhMVANXJarnDrP/K1clzW+kNopdVmaEqDBB7k6NT6eRfSzY
         l5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779463959; x=1780068759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V6CiLFdYiV3Q7ZtuI9KNP1Ontp/HhSPO+ET7rm7tfZU=;
        b=OxXhoe+qlvwMqfJ9LQppL9YbednyH6Z7f9X5bYrZ4lDVdLbeyE95TKbJl/HwDb9Fws
         c0iJNBueZPVZiboyFv8JUaIoI+4uHmjxZLU8VjKmMfy/R6M/+HGCXLjjgQcRv4HNRYCy
         sE3xDMtywYzK4J8AJR9R8c8SlftIGbe/qKN8EAq+QPwHsFjkr/F2gVgm25PC0PJFx3Xv
         D/hLcv86nGXAjHQUMMktHg2ZS91oCVbRhmu9apd2WxyNTmukbUqdSydamt8imb1Ds8ZO
         gVAGy4dV347fP3jLHRPUY1TPYfF/H/NmiuDB3bsKdIw6nZSIkC/gy4WYUdBIH8NQI5yg
         gYqA==
X-Forwarded-Encrypted: i=1; AFNElJ8aM3A2selA7uteoPwlvjNp8AC5EimgzgjnJFDRo/+lDmem0+eljgBGjbR4bdNW8zoJVBgxTpAqqdsI@lists.infradead.org
X-Gm-Message-State: AOJu0YxmhdPnaZYv++OXtq5NKnzWKpMVY2BNtvssM3S9lVDe68qJR0Qk
	M5yKdzusBQMF6N5YNVzpSUJv2IjfEr8iCOrSaxWDpLvc31IEJvsNjpjuaAGY5ZhpwrstRcK+TJC
	4NwT5eERp7scCe9Urk36/NT4CLi5Peow=
X-Gm-Gg: Acq92OHwa/GjpInwHTJnGH0OTxY3rn+J8kB1d7ldxcGaWXEcy6t/MeeBr+kMUEMdqNJ
	1sJxk82sanBUhvbX53EmNEyJWPOTn3toe/6BSMo0x98k4MORu3tcl1eNkckIPTCsgoIxifR3Q7X
	M3FyJVkNyd7dHQekrT+IfbXBtJOvNJi+207tAe9/w8FlGH1TGEDueYet18Bee/e2SaeaAGvJkdu
	40q5pxZUjAJFj8vJ40Wwt+bFqytezlfAUDUlvFivfHtceitvpeeAYTz+t9RmCqv7kG1u4IvRQid
	CC2xakc=
X-Received: by 2002:a17:907:d508:b0:bd0:6293:bd0d with SMTP id
 a640c23a62f3a-bdd483e64a6mr216229566b.7.1779463958687; Fri, 22 May 2026
 08:32:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260515071248.2689513-1-coshi036@gmail.com> <ag4Y5R1X0gkZbU-g@kbusch-mbp>
 <20260521082549.GA11208@lst.de> <ag8Y5c3sjYFZzan5@kbusch-mbp> <20260522121401.GC21338@lst.de>
In-Reply-To: <20260522121401.GC21338@lst.de>
From: Chao S <coshi036@gmail.com>
Date: Fri, 22 May 2026 11:32:26 -0400
X-Gm-Features: AVHnY4I5AoVhJHWOUtnN65TGeixTFl5Pm-T_d908dR5UuWMu5EKvQ1md19rEGOY
Message-ID: <CACd_6n38HebkE79dSgdnQ1=v0uK1YkCNCR3Sy99TDvwABfjVxw@mail.gmail.com>
Subject: Re: [PATCH v2] nvme: reserve a keep-alive admin tag for all transports
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, 
	Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>, 
	Tatsuya Sasaki <tatsuya6.sasaki@kioxia.com>, Maurizio Lombardi <mlombard@arkamax.eu>, 
	linux-kernel@vger.kernel.org, Sungwoo Kim <iam@sung-woo.kim>, 
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260522_083241_076701_7BF2B0D2 
X-CRM114-Status: GOOD (  16.45  )
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

On Thu, May 21, 2026, Christoph Hellwig wrote:
> True.  So maybe start filtering out all these things will go wrong
> commands.  Chao, can you start on that for keep alive?  We can then
> extend it as needed.

Sure, thank you so much for your help and comments!
Done.  v3 adds the filter (nvme_passthru_cmd_allowed) in the
passthrough path, rejecting KATO Set Features on non-fabrics with
-EOPNOTSUPP, and is structured to extend to other features later.
The reserve-a-tag change from v1/v2 is dropped.

For the blktests testcase you asked about earlier: I will send that
separately against the blktests tree.

Sent as a new series:
  https://lore.kernel.org/linux-nvme/20260522152807.2061501-1-coshi036@gmai=
l.com/

Chao

On Fri, May 22, 2026 at 8:14=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Thu, May 21, 2026 at 08:38:29AM -0600, Keith Busch wrote:
> > This command is already special since we filter for it on the completio=
n
> > side. We may want to selectively filter other Set Feature commands too.
> > For example, we don't want user space turning on Host Dispersed
> > Namespace Support, because this driver is not going to correctly react
> > to that one either.
>
> True.  So maybe start filtering out all these things will go wrong
> commands.  Chao, can you start on that for keep alive?  We can then
> extend it as needed.

