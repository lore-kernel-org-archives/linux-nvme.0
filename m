Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2271E9A04A
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Feb 2026 16:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/x9hZC8EplBXWTWBtGo8KWBQFeqJeKq9WTJDuTB04dM=; b=Gkli6lQPSW+oBwEWpE/jO/aPrj
	4X9/nrtEFZvgyt0dv6dgy6ID5eVpEow/NYVbvtPjpu1QRUUPngJ5hWsDcKhG6vjabc0JV1bclh+qr
	HA7Y7elcGIfjCmNw7r8CR4Ge0LVa+m1gjPACvQzIaDDVu06iu0oEuMMeUqCYyJOw/ksKluKXQT4rh
	/zbEorcwjvQLeC8FP6xiQUD+fRicJZpPU45wcgvxa6+yAuNHauTECKSLBUj3z3JqObVXLOm1UAdY4
	TaV35n8balRF4QIOn7KKHdtwJ2AzJ8ylSWK9kq6krIOwL3jcDRCIuoX3brfMVfKBjbgG+v3XTBD4c
	H2V6Iifg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vt6XU-0000000Bc6G-44oY;
	Thu, 19 Feb 2026 16:06:04 +0000
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vt6XR-0000000Bc5m-2D8Q
	for linux-nvme@lists.infradead.org;
	Thu, 19 Feb 2026 16:06:03 +0000
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-65a3ea5133fso119719a12.1
        for <linux-nvme@lists.infradead.org>; Thu, 19 Feb 2026 08:06:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771517159; cv=none;
        d=google.com; s=arc-20240605;
        b=TiqXKDk6nLPnk/j8biAhZNmuwb5PVlzvDhJyC1EIOgjPlzQUqbYa1fco3w0XCNe2ck
         j8hlqN5HlG9wdNxxwWIzWXh3IyKPVUHwSdulrO+HxjaqOSduuAYH0pJCTsg9NLpOTr74
         9rP5Zn+XTa34Xjhbl/NGrMYfLyS1yBZuvHgBcZTL5zkeEDsgQhzHAtH+GDrvOat4XeQo
         m2oNfe7YjIHANY7Gsr+5NyqiVdYjqNXYhe1KKjqap2Pur1MXTUZ163shfa9b78xpFd+r
         jtXn2E3wSlPupK6UrvoVxAqV6rxOKfPA0j3Reg0xeVPD9UVZnuzfTWkrV7TkDNAeEQPl
         g4pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/x9hZC8EplBXWTWBtGo8KWBQFeqJeKq9WTJDuTB04dM=;
        fh=1U1PA6USzd9TAxxl8Mz8dyExuSQyW16eFMjdXRD5Nws=;
        b=j0k4UjvBY5DpwLVD8n3tjsVI3JDhAe91OG6y8G031T1CkCPyrLlokGiC7uxOOHkOCk
         GnP2VOpKzzT46b3TpTQkn/ifd5KdgFKbBD7hDwGSVPKmTIxQzNOvRTZmrPxE5QXP1aSX
         9tThd+igNoJ9y8mP8vtiw9Etyz/FVQZTdUSgEp7IfG7dDVU0xONE3y90AFrmC4NJfBK9
         hKVo060aaEexB99DrF34riqbJqbHqXxxq0KUG8IsVvah1JICLkArA7qk6w+jfifvlQ1I
         MqJ1pyqfi12a+SLCqG8qKVqgKog9KUWbdZJyUeVE8ysEJdFxXpSKuvIWYtmKzt4zo1Xn
         4WJQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771517159; x=1772121959; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/x9hZC8EplBXWTWBtGo8KWBQFeqJeKq9WTJDuTB04dM=;
        b=Dl/BG3Js5X5lyNDK7kts+KV+OD5ZOiovFwfd54Pp5RzhLu3Ct1WaqfR+YhF0bKbgFn
         0R3hAPwm5N+yAV0MFLt0PVJLMRAvf9B1dsttq3zXz4pUEzISN0LtUGD8IWlX1S0vxp6t
         c8bSr8MToEs7NkZpW5qTFBX7lFMJleDOZ6GAJ7/Lsnr94AKpBDwguTSxzODQij1kceth
         aRvrPBZ5k/f90yicys0pC5K/WO232b2d8jwxYuflEUOULmxu0goGkmHbv8SNMXZGWQtA
         CP16ty8INxeUUPdL20gGw5zZSUVOAgZ9Rc1T5QDdngBAoqgJYItRlLmMbnDF4/3V4GBR
         cN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771517159; x=1772121959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/x9hZC8EplBXWTWBtGo8KWBQFeqJeKq9WTJDuTB04dM=;
        b=E+GlH8ChqPTIyLrLt1D1L89P7Rh/sC2jTAFQaKLn8YdKtdUK/lbptIEFlmnpb6kjVN
         DIPUqKxi02RnuEcpzBUZ0C4NfSeqApvTd0965z/U32WIew8mGI5NyCJns8bS9PjNk58T
         IBCoxZvKchdGYnw9tTBi0WH+3V+G+VWhuKlN400pUb3CsLqXp4S32Ix7jL5bknXacmIW
         3uiZxogEn1po4sqYRl5Rcazj4x/EFlvjthkYFtBAbeRBgDgq77XzffqBsMN3XFNEhrPs
         icrXu2u2t3/4QKAIJli2g0klX5JUlfF5roGqKJA/gGZVyL0wwgAhMJMn/5xTteqSd5q0
         7OaA==
X-Forwarded-Encrypted: i=1; AJvYcCWvgreFcskaQgnCNdFh7LqA6qw1qoEAT35dpn8ijGrVFS+Pz1VTHrIY4ePvZvBc4qUJXeT3HKlYZqm1@lists.infradead.org
X-Gm-Message-State: AOJu0YwM25H2727mlnO/3LW+RHGwa4Sxnne3yLgHIcBSEqMJXrNBCmdX
	E0puzlM0zre19dADmQvpehwOqPZ7OJwskyGN71M71YXUVt4HIxEW/Uy7BKLc9DR6PVVlZ/xKpGO
	lUyM6v1lsFQqCCxq9PfUqukOonIWXlXzShGv00U82K2dCex5aapzJ
X-Gm-Gg: AZuq6aJVbNkoe7g+GVPm+mTGb5JbZnrKUb9D1aTF8WYM4auPSj6zfT7mlR9FAhZf85o
	bejX1Rk8suyK4AqLV5/i2x6ClAi33lqrItYGPJQ7q3rac8nH07R3wfKO3vkKW7ne/KiO/Pz10eu
	CyFXQI02s1k5b5UNLYnOVJHNzSmsJu57zruhjG3CizAxb6Gw+Tt3gJFop3DUYtlXlrjlW20Txx5
	UQqbYTnkInKeqrA/BAPCBIKFo0z2CKvoLitre9jQhT9sl6uT5RaobpwJ9qCzTlo/17irJ/zEuy7
	7kzCctWk
X-Received: by 2002:a05:6402:2808:b0:65a:3c0b:85e7 with SMTP id
 4fb4d7f45d1cf-65bad14f893mr6872126a12.6.1771517158805; Thu, 19 Feb 2026
 08:05:58 -0800 (PST)
MIME-Version: 1.0
References: <20260219014335.9061-1-csander@purestorage.com>
 <20260219014335.9061-2-csander@purestorage.com> <CACzX3AvpBv_vM5DNFmxBcMoCogC4HK1e0c58PA0kiBQ1wMacow@mail.gmail.com>
In-Reply-To: <CACzX3AvpBv_vM5DNFmxBcMoCogC4HK1e0c58PA0kiBQ1wMacow@mail.gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 19 Feb 2026 08:05:47 -0800
X-Gm-Features: AaiRm52e4AXuAZfVzFRiojhXAflRftulDVyOfdFRPY4BmS-UR6hLrd3nWi17ZCE
Message-ID: <CADUfDZrk1Ro+VmaTDcbsUwQiL8EHhqbFbzHTrc5s0AJxbwdqTQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] io_uring: add REQ_F_IOPOLL
To: Anuj gupta <anuj1072538@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>, io-uring@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260219_080601_627254_F06776C7 
X-CRM114-Status: GOOD (  10.38  )
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

On Thu, Feb 19, 2026 at 4:39=E2=80=AFAM Anuj gupta <anuj1072538@gmail.com> =
wrote:
>
> >         REQ_F_HAS_METADATA_BIT,
> >         REQ_F_IMPORT_BUFFER_BIT,
> >         REQ_F_SQE_COPIED_BIT,
> > +       REW_F_IOPOLL_BIT,
> >
> nit: should this be REQ_F_IOPOLL_BIT for naming consistency with the
> other REQ_F_*_BIT entries? Otherwise this looks good.

Absolutely, sorry for the typo.

Thanks,
Caleb

