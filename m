Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA49FF885A
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Apr 2026 01:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JlHXA+6KGeVbEWmDWXbNJzgFMA1PYQvsLvjRERcW27w=; b=H7LJ0UvCc6UZjNqPvWtv4O3BzX
	wtkzFI3k7FoGCq0A8YFkIcYLPB3uBvdLN7ns1pcp6nIM1dMcl+5cDuewcWcd3LGViJXvVbeY7cfLI
	Jt2orbp2yu489cEZ9uqrexkxG7WaCnUNuBTIGzXxvh6KA6pagm0HdQ5Jlk9lmSoC6rxxAknQIQhaw
	fPxehg3mUC2BpMGfrlvmhkzvjmBpQAgqVcPuKwi7Q+50WPwJRUbiV8WxPdwXuiI4O/hKzH+ICnViz
	ko/vKeGhJrGpkB3cOC2+ztSBKpCp2P5LfeooXimHS/EJSN97s9HzkL42SmUEqJJ4SjJgZd3cfdekG
	TVJw5MmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHtNN-00000002gnb-2DIe;
	Wed, 29 Apr 2026 01:06:05 +0000
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHtNL-00000002gn8-3DaS
	for linux-nvme@lists.infradead.org;
	Wed, 29 Apr 2026 01:06:04 +0000
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-43d73352cf2so10070323f8f.1
        for <linux-nvme@lists.infradead.org>; Tue, 28 Apr 2026 18:06:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777424761; cv=none;
        d=google.com; s=arc-20240605;
        b=TrD1R1QqALeXNo3JmtmMoiPN1KAF1H5WDsDhC1T9S1CmfG+nik7z5wPdswaSMPHvuR
         7nkOvw/ZabuZMH94I/CwX5nM0yfSTeITB2tiUUqd9QwUHkoey4pRe51gmNVt+H423Bo8
         pkkHqpg57378/Fy5bUgnSUm/6MryWMeDtmTbZkcqgLyrD8jaQ1/jkLwLD5aHssgrdvOo
         VNpVIUUaNiVzWMsEbj4MjxXt2Ye5KP0Q67vubKcxgtuehSTLN/jeRUwugyC8qffB8Dtm
         SWbTF8E+rKRuS/lmKmC/SVkOMyKqIk5tQ2wYgi2Cg67vqfdeDG3tovBX+7RAp7/gp4Ur
         oBsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=JlHXA+6KGeVbEWmDWXbNJzgFMA1PYQvsLvjRERcW27w=;
        fh=enFLj7/bUdOxeE7IdjJ0ItFk7JrfXTwLi/J7Wzjgvcg=;
        b=AXWin7li6OnfoLpWl0DgRuET5lXN1ImRqlB5aQeQq73AK/d3x8pwo9eEiS+7bNb2T+
         a+1hVu+C3NeH+yC5Z/FeVU/nfxEuArZ1n87PuAec/ULTC8FrA6LbGnhex35eMtuG9rUc
         Nx0PQA1L1HPpM6VvCjDKwwjLJa3pG6OD6pZtUh5EjQdrZ8DSYCG79dakcvJLJ5YeHoBC
         R8PWBg/pMyAqAJv68B8HRk6jyL9K1pcNYO4nVM2FproC2PdE1xSYVP3XtNP7U0ezkDss
         zHfEvtUcAGoa+tG1UjBKRrLXI9Y/W5sO/OSr23emMFHS/r6jtFTB5CbKv8Xq9/wQWKFC
         LHCA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777424761; x=1778029561; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JlHXA+6KGeVbEWmDWXbNJzgFMA1PYQvsLvjRERcW27w=;
        b=ImhLGFIQPvw1laXKm+eX+CZuzhW4H2a4BZ95SH8imHAG/ZgBD5tf1/VpwHHUIM5wYF
         t/xjFYBVctAQwQxamVPmmi7OlYPwGzaGu3IbtbGoefzmu8rcUUaXh6SkdnQlKBWws3WU
         wlyjp/Cra2yhQ7uxQsh4pMiojr+Ce+f/4xdBFKQNbecff/1LeKchWk5Q91CI4apAlQ/f
         +6p486fm6IHQ3JlX8jov0EIHC1QmH9k3SqaZ9DC5WDZD9bJayWI1pWyCSV4nDGDVef9L
         6UnBsaI7/vQbetqzr6Ag02sojVLaaIfG0jALs0gGkHRRyQNVYMcZSzTHNgJyNAMfqC6W
         ldHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777424761; x=1778029561;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JlHXA+6KGeVbEWmDWXbNJzgFMA1PYQvsLvjRERcW27w=;
        b=fqfh90vIB0/awCdEeVGylhkEZVBRN8+p0H4jb57cLvGNSLX+Gw7AMUW1orByYUGz9W
         ay4LDwkgR3JFy7rH/ZGjeqs88J57Htsvy84LZgjrK7IP6yWe6fQyEIMH+pYphY+Qdhp5
         iCcbkpufkTV58uHB5cI75zwmwJGJ+bu6v9tjZteTIlCOSyApqvHZf0wYB8hinr0eFlmT
         3EMygwNMlQ/eChobRi61M6gHUYgVOb3+TgVKV5bWCkEd6U6Swg71gcUbY2PECa8pOHk+
         /EpGiBh6kwJyBDkbXymppacrT6VYQXAZpsw2kbtR5WqM6JrOJFaL+9rsMD7+BAFMkp2j
         lY0w==
X-Forwarded-Encrypted: i=1; AFNElJ/oCH7WLUKrR9OaXjZsPFfSxQUdZtxiU0hGVb8eC9+0mefNgunbAPK4UBnoyVh+KT5n4/KgmTbQN++y@lists.infradead.org
X-Gm-Message-State: AOJu0Yw8ncGf6ErozwxUdoJ/ghVQYLGjRUXU56GulvrvWChtjbLYrhm8
	Y19wNVf2ljZWQuthb1GpZi2UvPEENyD8qm/CZDnziv+2B0kHjPOI+9pcHGvQuxJqNQfQbhCdeUT
	Xe0UNZjvhfJDQ8bcvJ1fKBaGHGXHQ18c=
X-Gm-Gg: AeBDieuemI3H4Pi2WjDPnpTVJ65SohUav5k27tOMfWHAYw8j4xwOPfS3ntk+OVnlMGr
	TJsNvkiKC5HsMf+V7aXE88x4w1dSyKtQWvLUhX/l/OrAK1LTmrZk8qhXKrDAa7COg2WKL1h+lGi
	GkwJeYixvdTAt444edvTlhUccVhjUT32pLE0SjxkTiDRhrbuqXPEo4MoEfG7CQaa2/iPyO7Vq4b
	6D8HEP3onuBxKbIcyiYgziibRLhBQ46tfboY/QGq99zeXVpf6TokLkm9xuuOsA293xmWjYZmOFT
	4Ji9ga5i/VjNglcxeazIESETt7s=
X-Received: by 2002:a05:6000:2484:b0:43d:7b90:fa2a with SMTP id
 ffacd0b85a97d-4464839ca75mr8917349f8f.3.1777424760629; Tue, 28 Apr 2026
 18:06:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260409060835.GA6389@lst.de> <20260427004406.2971227-1-kumar.shivam43666@gmail.com>
 <DI4KADNWR1XG.ILIR3Q697X77@arkamax.eu>
In-Reply-To: <DI4KADNWR1XG.ILIR3Q697X77@arkamax.eu>
From: Shivam Kumar <kumar.shivam43666@gmail.com>
Date: Tue, 28 Apr 2026 21:05:48 -0400
X-Gm-Features: AVHnY4LrNYuHn-pBq3qr0lpU5puD8CQIBSM-g3cJEIUHJCA9N-eeFHHwUpcGsvo
Message-ID: <CA+ysrSLry7c2eYBSeuXV_VOeWrtskPchnP0WXai5CO00omCJqQ@mail.gmail.com>
Subject: Re: [PATCH v2] nvmet-tcp: set a default MDTS of 2 MiB for TCP transport
To: Maurizio Lombardi <mlombard@arkamax.eu>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	linux-nvme@lists.infradead.org, kbusch@kernel.org, gregkh@linuxfoundation.org, 
	security@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260428_180603_813636_CA62F3D7 
X-CRM114-Status: UNSURE (   5.80  )
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

Hi Maurizio,

I'll add enforcement to reject commands exceeding the MDTS limit and send a v3.

Thanks,
Shivam Kumar

