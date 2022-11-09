Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3CCFC433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 00:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BgwnROHdjL1x0uwJ8RwYRg+FuQv4vUf55wNMEXJyT4s=; b=VrSkY83k3ORT5hP3r4dg1V+z6v
	WX5Km1hLUu+pSpG+ADMLvsUTeX6hmgr8kawFkVfLFHmqWs/p97HyLZSdYoN3zScs3kpggzbScNwbo
	KLidws0gEFbM7edd/Cq0RbJ7/MCLvXEmYb5gwKb24w1W7j0g5PWXxN/vPyfQUokj+gPfHFz7xwqwa
	7ajG43jZK9yBK/nf+XYqk5wMJi88AKVP49rHe0blRpgQ/tguKB4n5/F0FD8ryRiHA4sA1nlOz3Ok3
	E26eoU5xZCPUFJIaZJ/oRslWntRWMvDEto2f3NRDHbzKEEr6y+ZFpBBv/HU6NYw8bNyUwsX1qb/X2
	PgA7C40g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osZNw-009T1Z-Vt; Wed, 09 Nov 2022 00:56:08 +0000
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osZNp-009T0s-8I
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 00:56:02 +0000
Received: by mail-pg1-x535.google.com with SMTP id 136so10995260pga.1
        for <linux-nvme@lists.infradead.org>; Tue, 08 Nov 2022 16:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BgwnROHdjL1x0uwJ8RwYRg+FuQv4vUf55wNMEXJyT4s=;
        b=l23r9UhWgKjUXu0vgbuhSfu8hx5xOaMUJyp3BqkVu56Z5l/ilbYIhMyOoApO051c9N
         vrsvuM02dCuM27FlgYVOOKS3jnNHpUss4xv0EebEy2j/zQ9O0pK0f4ZyvEstFdB7tttI
         RA4AbBUmM1SLJClLHte6B1Ge+9P4vSbdvaDl2v1VL0an54a503b0A58hjngLM9GuRFJi
         jL0TOSWcoAxRmrP2yXKUPxcgrFK9Ka7vWt8R0WfJDOD4/qD6OyZzMKHGj+flNc1NdXAZ
         9LpFkWRl4IvDDqMQTgs+a4I8pFvRc/Cs1oGWYexij2TA35oRf5ZM4Dt0lpaAinZsLeh3
         v3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BgwnROHdjL1x0uwJ8RwYRg+FuQv4vUf55wNMEXJyT4s=;
        b=YVmDaYEsclmcmWE5W43nA4sSpGTN+N05wZG706NQ2XpyDaMyFcWJKDLL+fWiDQzmfk
         oRQIre6SuUYn175CgydypIgr/FZp2QTtfzaQKHGJfUiR9Vgl5jPiNF436xXDPc/u5I1M
         oKuxVDPy82lv7JqrAHxpoPOCqvXtpDmoJlLyr91e+UK3agBXVyFiRjlo123rk1fiGGSy
         qOmsnaXorwQqz0GeXx+VEnjtxkz8PaukjWHj4QJP7WxlhziZ03noWQ2EzZvtltPu+TOr
         oCxAziyW7lgCXRbgSqsOoHOAYIXlOcHkIGClFWhRes70M4Czav39hDhx5FqVHcfFQlGC
         pDqg==
X-Gm-Message-State: ACrzQf1dKNDj3u56qjSdagOwvqUg9YayYgqd+tyZjmGSqFXYiUaL62+2
	IMoqxxzTVAFekch1SOxpbZOuDibUa8yAsqtj4ehSf48j6fM=
X-Google-Smtp-Source: AMsMyM7EBpnPriLS9oJwgXOnMvT9J+mzLsJW218dK37YGVkfzZmdNTECUOXptQ5yg7f7xTNXaejxgu+K1Go20y1QD1Q=
X-Received: by 2002:aa7:9e1c:0:b0:56c:78fa:2a2 with SMTP id
 y28-20020aa79e1c000000b0056c78fa02a2mr59321238pfq.65.1667955359317; Tue, 08
 Nov 2022 16:55:59 -0800 (PST)
MIME-Version: 1.0
From: Tiago Dias Ferreira <tiagodfer@gmail.com>
Date: Tue, 8 Nov 2022 21:55:48 -0300
Message-ID: <CAJuHpLb+TVvxfcdBTMGk__vmevUa-4ZmdqO00shNvwJkuzPovw@mail.gmail.com>
Subject: nvme-pci: netac nv7000 has bogus namespace ids
To: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_165601_330071_97E73C8D 
X-CRM114-Status: UNSURE (   5.06  )
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

Hello,
I'm sending this commit to fix the issue where just the first nvme is
detected due to bogus namespace ids poorly implemented by Netac:
https://github.com/torvalds/linux/commit/3943eaeb9ac167ff6f8d099459ab158eb1fc8bdb

Regards,
Tiago Dias Ferreira

