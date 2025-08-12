Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB350CA0EE5
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Aug 2025 19:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=IJfpRJ8IpGH3rzwYKmvsJSemPZapijh2lAS9v7tcKGA=; b=3KTH9FJ+QITwbQxWFpjOpyaZ7/
	wnpoa8yH1M3Nu2Z/2XimMYG/GzxAN6YDjYX0ApJz21SoZnFX6CuI6GF6FpLKv+kwDeSw8ciMsHrW0
	ffJCgnQvW+TwEC1nEXtFjSkPJWoX85GUxhCin/J7Tr81hXjrAcu0XEP3G6iaJfZfcm5PNdc6gmeYS
	FJsR4So23y6FmH6SBoLux0JSuft7xayZ0tBCI1FXBU5m8rtbz+++tbGpQfPhdV8Iyvg7t7i+FUB96
	CkP6Vc+TjQL9gcfh+yjrKTU3MFohkiixsN6+1A7PgpBYt9Tv6dNUZTft/CZClKBWTZsCC1F1lekzZ
	Q00E9tvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uluao-0000000Bn5Q-3pCO;
	Tue, 12 Aug 2025 19:23:30 +0000
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulrEx-0000000BCBi-3U7c
	for linux-nvme@lists.infradead.org;
	Tue, 12 Aug 2025 15:48:44 +0000
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-e8e0aa2e3f9so5803324276.1
        for <linux-nvme@lists.infradead.org>; Tue, 12 Aug 2025 08:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755013722; x=1755618522; darn=lists.infradead.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IJfpRJ8IpGH3rzwYKmvsJSemPZapijh2lAS9v7tcKGA=;
        b=UamAqXJSzaTIiUlPRto3O2WW1cDujTK5Et3hFKWgyLMm5ugvLCEuRbhuMoF8K+IHGz
         1XP1DJy4OwsH6xSJkhyEsxm/oxQ8WT/zvGQGb+M4GYZVbsN+w+VJk5fup51bOtCA7VNx
         14tibK2OmVMR+TFVWNXfOwkFrEaWB7qjkqdy9yMrQ5OGcHFYmkPvnlBVSzzseJozOF3O
         awdkrDaxITyFV9ujz1cuInZ/EaJ2Ai9AU8JQ2r5+17cWz8NagT79MG9WJL/JtarTRB4S
         hooP+aFA/oDdbRiSOCGoNyl0oBSnyekJtSvL4Ubh4ysiYVpk3qyLC/aBdIGxqgVxcDlG
         QTGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755013722; x=1755618522;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IJfpRJ8IpGH3rzwYKmvsJSemPZapijh2lAS9v7tcKGA=;
        b=d4769fsYMEIND8rppLJUQhl/UioW8FEb62HahAjLcx/wyELAli05X54DZ5fqzgvjhl
         i2PeBy6TcPvMh+N12hsZd6RCITxdTkvf/DcriBN/bfRc9yUE+/XtFIspGkVxKydYIMt9
         AGB4ejkVHq6/TIOhTXj+nyqbr46nSMhmSuQ/s7cQdU2YRQPyRe/JGYs/WKcnEURmpDJK
         eowF97xlZ29oFKYp5Oy7llHvy3S3lhAz1nW2NVa26DYwEJobtakIPFA0v7HzqPRo7dot
         QcsB8ghcLwWGgQcBgTaYvcX1xiND5H7n3phu3z5Bjpar8N9RhepBOOD+ti3f8ElDYKv5
         /5gQ==
X-Gm-Message-State: AOJu0YwMr7FvwE8gQWxuj/fi/kf2uCJRC7NlxY1tLANLvqVB5Ni7CptQ
	2nZGGDD6wtIUzVSJmVs+aM7y8r3k3qKQTU4YRaFWUjGp3xFl6Q43GtrGNUU9F7cOcmypB830e/e
	q2DzBLAatMrGRY5Ltp00m+LErc9VvBGqwXLgn
X-Gm-Gg: ASbGncu9XuUtCF4vi1s0y5CVjSP4PUwbkAWMEnp95Ylw7CXt/QnKJAheWNWDYCmdNba
	DvuYIdr6ENMOIwhiVYVG8VTZ+ax2mpkSJuX3Q3+fSWbncMXNU3LYTGUWWetk7pNCd+C6En3Y67d
	sqBipP8R00OwZz6wPYeeksOLW4M1bdEgTBJWYPsljboy1GKjMpf9q/prS8sldF+WOSmwwaGm0mr
	vnYYQYU
X-Google-Smtp-Source: AGHT+IHKJAV0IZkg/4bhnozJnk9UCwQSpgYuB3EEsWL9KudWq47fM2e2sINa5GnsHNDXEwGFY48+Aw2bklKSIYOTy/o=
X-Received: by 2002:a05:6902:c08:b0:e90:4350:8c84 with SMTP id
 3f1490d57ef6-e917a1d9e44mr5242124276.12.1755013721606; Tue, 12 Aug 2025
 08:48:41 -0700 (PDT)
MIME-Version: 1.0
From: Anton Gavriliuk <antosha20xx@gmail.com>
Date: Tue, 12 Aug 2025 18:48:29 +0300
X-Gm-Features: Ac12FXx5FfqDfEZktOtg2O49UIkKj5QM8MR-v_bEYgR9JykoruoXx6J6o4a3ti0
Message-ID: <CAAiJnjqKqMHjrPLOvY5sCXiQR0n6pMvm2mS5pQEqy2XY1cD_6Q@mail.gmail.com>
Subject: Unable to reconnect namespace via NVMe/TCP
To: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_084843_868143_EEF6DF40 
X-CRM114-Status: UNSURE (   6.30  )
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

Hi

There are NVMe/TCP target and initiator servers, both running on
RHEL10 (6.12.0-55.25.1.el10_0.x86_64)

NVMe/TCP target exports single NVMe SSD

      "namespaces": [
        {
          "device": {
            "nguid": "01000000-0000-0000-8ce3-8ee3064aa4f2",
            "path": "/dev/nvme0n1"
          },
          "enable": 1,
          "nsid": 1
        }
      ],

If NVMe/TCP target is not available, initiator tries to reconnect
every 10 seconds

[ 2586.071048] nvme nvme9: failed to connect socket: -111
[ 2586.071403] nvme nvme9: Failed reconnect attempt 16/-1
[ 2586.071565] nvme nvme9: Reconnecting in 10 seconds...
[ 2596.310921] nvme nvme9: failed to connect socket: -111
[ 2596.311186] nvme nvme9: Failed reconnect attempt 17/-1
[ 2596.311349] nvme nvme9: Reconnecting in 10 seconds...
[ 2606.550772] nvme nvme9: failed to connect socket: -111
[ 2606.551252] nvme nvme9: Failed reconnect attempt 18/-1
[ 2606.551592] nvme nvme9: Reconnecting in 10 seconds...

when NVMe/TCP target become available, initiator failed reconnect the namespace

[ 2606.551592] nvme nvme9: Reconnecting in 10 seconds...
[ 2616.793080] nvme nvme9: creating 16 I/O queues.
[ 2616.829881] nvme nvme9: mapped 16/0/0 default/read/poll queues.
[ 2616.833685] nvme nvme9: Successfully reconnected (attempt 19/-1)
[ 2616.834446] nvme nvme9: identifiers changed for nsid 1
[ 2616.835618] block nvme9n1: no usable path - requeuing I/O
[ 2616.856602] block nvme9n1: no available path - failing I/O
[ 2616.856811] block nvme9n1: no available path - failing I/O

and there is no nvme9n1 namespace in the "nvme list" output.

Anton

