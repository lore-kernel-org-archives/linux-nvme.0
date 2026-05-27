Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15186CD5BD2
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 02:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mmI7ayL1NAcfSlbe9mbEsF3exTTkv6X1ZDYlRiBzLU0=; b=aRRj8de+a+b7bitVPHwPTa3vny
	QWgbycLOzi+R5zisq57kaXGSUy5y9eIsfRW/sLrg6MUpON2ENbJ1Qb8xEtzYvk4sJlg5ylU23kgQM
	Zyz2XXxVDsK4x2dcx/w7VeV3ioSg6g2sJEJNbuJSuQpTQst6v39B+Tj3VDuNr8zy3uoub+Zie/x+D
	WBOir04Ku0tuEZOTO4YGbCn6N2o538coQTLKurfrJxjmryE34xL/wESCa6kjDm4r+YwQ4OaJpqqVx
	QSc2+KpBr2d5Bp2B6ZCsqLpBDu3yq1Ykvc3urXvShG6JG08H2s/Rbg+prOxrPG0QoIXvLZlVX7oK5
	xRaibv3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS41l-00000003A2G-0lDe;
	Wed, 27 May 2026 02:29:49 +0000
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS41i-00000003A1g-35M6
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 02:29:47 +0000
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-c8532ba6c95so1083422a12.0
        for <linux-nvme@lists.infradead.org>; Tue, 26 May 2026 19:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779848986; x=1780453786; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mmI7ayL1NAcfSlbe9mbEsF3exTTkv6X1ZDYlRiBzLU0=;
        b=JlnK9LLPgmcN6T9UGEG+iVQ80jHYxkABn2DFt2cuv28wv3ZcWGFv4eqO2x5h+Us903
         Y4/+gdLXoAVubADnsMYsXY3nlg9wD0C4yGosH+96Nm6gzUGasRQhzxzgTTOwkWAG8eyD
         D5Wqdoj+WWb1yHsJmc456nR/+suxYhCCgqY78TmKACi2hWuGNQOsKn+rLvORab6DvTi0
         AyU1fg3Hwps1pIr1JuciuWg5ChVjYKNzKW+7bWjIqX+37Gmwjy3r72zuECdLikSQpQ9+
         YIP4WQ01lkQg6VJQpVX80jxIPkgEIbAj1ce92l2sT1TcXgku1c3MSoFOVFnRavbi7rqX
         GiDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779848986; x=1780453786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mmI7ayL1NAcfSlbe9mbEsF3exTTkv6X1ZDYlRiBzLU0=;
        b=GccXYlgD0PDUJJfZXwaouTj1qxUfTInjATqZcYw5+boKGs2jwfYv+ZA/UeX7K+96cz
         GZp7WI4X0lbFKNW0oN3jRnXdgS8vLV+Bgo1dly7hh6A9k4Ylk9Ukqh6TV7AUFD9roPkA
         BPTgX9cWE2Wn1p9iBgiPvfdbHEiIV6ks26UNMAHFJ34AGKoZxprVIDdF9qcwOnvKoP2l
         Eay7TQH1rokeVZsVjEccWSoeziHtHBmfg+GEQBkiiU/l4btnNyO6lyL+QOnYtGx6zIzI
         Ww4XQ1JplCa24y8XW2eEZ0YAr64kGw1jbJdGnt1Wzqelg0CD7M91/LYE+SBVbgfHGnr/
         HLtA==
X-Gm-Message-State: AOJu0YxHcDZ3gX1xwc5KH2XCzkJ12j+Esip3o9a/ufXTMrnH1AdACZsY
	+XpaRzqW5MB6l8D0IWRkSSmh7q34FjW/da6M0ten1KDeH+UY8hfMXIZF3K3d23Z4q9xagg==
X-Gm-Gg: Acq92OH4aEK3DRtraTkLqu0aQYEjfgnTXeF/TUfjWOJGceN7Y64qTidNjgj/cJUD4QF
	FzhEtw9MJmr7NFoRBWVYLEVDPG0lIXcBtF30jq/bePvyRhzv74hxrl2kyVUTixeOT8g1VuhDzvD
	CMvrYfodKuga3/sZcL2yqUHCpY9S+YpaRMDlUwI8YNJMBCuJQqZyZxGwOkXBuOQAH+HV3n05nk6
	ewPwGmMXsenKyXH25hX3jMPZL5P/ikc/N3xSRRs/MbDLHj/Oo6ZNdYTmZvtJwlwqjJ5gJgelqCV
	vJjt4Wt3pob/18sQlHssz2NOAZJk86j/GjV2aa/9ds3yLTkF+YnJMjfoQt07SnbhwL4JCbSMsA1
	7C/6/k9IrMGBheER3cpkVOn4MHDcYgO8yMflTv/F/QsHlnpwDPGJ+GrOD7gJX+VrJODp92DB4gy
	G0oAIsnTGwFyvKr3RmKw==
X-Received: by 2002:a05:6a21:3183:b0:3b2:a958:a725 with SMTP id adf61e73a8af0-3b328fb1b21mr21607519637.41.1779848985535;
        Tue, 26 May 2026 19:29:45 -0700 (PDT)
Received: from [127.0.1.1] ([221.238.56.51])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d72eac34sm634308b3a.49.2026.05.26.19.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 19:29:45 -0700 (PDT)
From: liuxixin <gliuxen@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] nvme: fix FDP configuration log parsing
Date: Wed, 27 May 2026 10:22:53 +0800
Message-ID: <cover.1779848573.git.gliuxen@gmail.com>
In-Reply-To: <ahWw_09BJkQi9zQe@kbusch-mbp>
References: <ahWw_09BJkQi9zQe@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: send-local.py
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260526_192946_781903_C0D1DA56 
X-CRM114-Status: UNSURE (   8.65  )
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

Hi Keith,

Thanks for the review. v2 uses the minimal bounds fix you suggested:
keep n = NUMFDPC + 1 and compare with >= instead of >.

The descriptor walk validation (dsze == 0 / past end of log) is unchanged
from v1.

## Test plan
- Build: make M=drivers/nvme -j12 (linux-next, verified)

- Repro/validation (lab):
  Tested on linux-next 7.1.0-rc4-next-20260521 with QEMU 8.2 nvme-subsys,fdp=on.
  With a single FDP configuration (NUMFDPC field 0), forcing fdpcidx=1 triggers
  FDP invalid config descriptor list on the unfixed driver, while the fix
  rejects it early with FDP index:1 out of range:1 and skips stream
  registration.

Thanks,
liuxixin


