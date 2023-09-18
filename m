Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06954CD37B0
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Sep 2023 17:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AYQSn+OIzp01ryaAaejSH+/Rdtrl+ucwSOYu4Xut+PI=; b=4koaHxW1XGoIe1CgTHLjwopX8z
	mv00qUu6k5x94PV7fSHfbv0JI2FQbkyiG6nRkpgf5gHCvMAGOK0pnMva1zbbJEDaRySMa7U6EJ4gV
	0PC1ryvxc52tuuk93wzw+Gs2m9FK39imDkhjoHsJNY27X9Leh4gI+gJwW+hYwh6cfGQa6SEmi5REb
	DcqWpfMe1d1VV6m2qmGmT/ObKGfl8ZLvaDKBrnA+Dbhd7yHCpJw7xWCD39ShgirDE4fNfTejYoZBk
	i423nR0Q4T17Wd4xfYq5DRGjgex6XuOu++Bst9yDvglC87Al4Y6UmlsyEeM581yl21/0AtQxsUR/c
	auZfyofA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiHkh-00Fx0f-1w;
	Mon, 18 Sep 2023 17:09:39 +0000
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qiHkd-00Fwyd-29
	for linux-nvme@lists.infradead.org;
	Mon, 18 Sep 2023 17:09:38 +0000
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-573c62b3cd2so3458329a12.3
        for <linux-nvme@lists.infradead.org>; Mon, 18 Sep 2023 10:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jade-fyi.20230601.gappssmtp.com; s=20230601; t=1695056972; x=1695661772; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYQSn+OIzp01ryaAaejSH+/Rdtrl+ucwSOYu4Xut+PI=;
        b=SOtJka1gspl96aaMOjSt9+x2laPGucAp0GgeqjX8WmbUg8IOLj4PGww5NyHldfKVr5
         CuGAgxAKN2tc2iIGHgYiBhjrK3U6qjk++8DxikBQOTT6wP6zqr2Q6TobgrNAGV4SnGDw
         op8nQHxX5N3NHpmbNvS4gdgs4omVcMwZRmR6qUb+HMXxcMBZ7K81ldoHk8InXUmo2Odd
         nsFJoBNifjCi04mwmnFwoq2hN8owMqGjDQ/A+7C91ceJETIwVaqeh5ipR/jHBV2Io2b1
         RQYB9JkdXCNWWTOgzu/uZKXtu17c7+/hZjGbvkG2UVr+U0Go1LoOMssDWfmYlRddzvW8
         19Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695056972; x=1695661772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AYQSn+OIzp01ryaAaejSH+/Rdtrl+ucwSOYu4Xut+PI=;
        b=YND1/9BNAHZp2h/ZiyqAc4ysmOT/q+pVDBvUMS9TVRTb6d8WpyqmErgTXz0cZiFgzX
         tm7C16oUecUutv7INAewUOXKwQ/BAkanoCUEVHbJt290acjksxj08Go2mtCFYQwjDmpb
         03g8hNGOfswxwybmu7IEz4bepfsNpvDz3j6b9h0MKXEk3J4AtNGshB3bbVKZQ6DnFBrd
         23RVmZZhuF0EpdttpqbrSj1SqrkeYBvWW7BzawNngUeRzTilPYgT+SU1yn0zmjH6mGuw
         0nHFohTqTQFXTUDxUofCdToZOdooMZVBzRK8OeFAqDAG5ZIwJSePui4jmZZBhT4gS80P
         fRkA==
X-Gm-Message-State: AOJu0Ywsqifk5/76Jd+aOLJXcmQg3e1FojsPhP3gu0oK4/L6e1/QVZeV
	CCrbYFklQRo5de+ONsO4KmrL/A==
X-Google-Smtp-Source: AGHT+IGtUIR1rYu6U73lUGcuPGDdUrU80/1dpmLzoWH5zRK9YDq6P1xbXkYrEtqDzirwAafIJfYUyg==
X-Received: by 2002:a05:6a20:7288:b0:157:e4c6:766a with SMTP id o8-20020a056a20728800b00157e4c6766amr9410730pzk.41.1695056972113;
        Mon, 18 Sep 2023 10:09:32 -0700 (PDT)
Received: from localhost ([172.103.222.8])
        by smtp.gmail.com with ESMTPSA id x14-20020a056a00270e00b0068fe7c4148fsm7330361pfv.57.2023.09.18.10.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 10:09:31 -0700 (PDT)
From: Jade Lovelace <lists@jade.fyi>
To: Gene <lists@sapience.com>,
	Ricky WU <ricky_wu@realtek.com>,
	Keith Busch <kbusch@kernel.org>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	linux-kernel@vger.kernel.org
Cc: regressions@lists.linux.dev,
	Alyssa Ross <hi@alyssa.is>,
	Michal Suchanek <msuchanek@suse.de>,
	"axboe @ kernel . dk " <axboe@kernel.dk>,
	"sagi @ grimberg . me " <sagi@grimberg.me>,
	"linux-nvme @ lists . infradead . org " <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Subject: [Revert] Re: Possible nvme regression in 6.4.11
Date: Mon, 18 Sep 2023 10:07:38 -0700
Message-ID: <20230918170831.1677690-2-lists@jade.fyi>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <66bc5229-8131-4111-96fe-bd5ee90314b0@leemhuis.info>
References: <66bc5229-8131-4111-96fe-bd5ee90314b0@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230918_100935_926210_5EDFF607 
X-CRM114-Status: UNSURE (   7.86  )
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

This regression affects all copies of the Dell XPS 15 9560 and Dell Precision
5520 with any SSD including aftermarket ones.

Per the bugzilla discussion here:
https://bugzilla.kernel.org/show_bug.cgi?id=217802 this regression has
been confirmed to also affect 6.5.2 and 6.6-rc1, and affects several
distros.

Known affected branches: 6.1, 6.4, 6.5, 6.6.

It has already been reverted by OpenSUSE and is soon to be reverted in
NixOS. A patch follows, hopefully with the right metadata tags.

I have compiled a kernel 6.1 with the revert and confirmed it now boots
again.

p.s. this is my first time pointing git-send-email at this particular
list, so I'm sorry if I got anything wrong.

Jade



