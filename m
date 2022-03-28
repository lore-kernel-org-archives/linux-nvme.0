Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF68C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Mar 2022 15:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iCw0b3XToxwiaR/bdGuRr076f7JMY5fsXf/SeZL0nm0=; b=mHvhJA1478i3qXy7BwlILHBJ9k
	xhoB3kC5xIbKLEe6c5mXkLbtTd+Nw9Uxo7GAd8Rtr5cwXLuoaf7yrRNZRLYr6wadZQojW/YurvnAt
	Br/ySk2z9kRUAKqDUJLrhy108Bkk9638sYvl/EBgIAnhDFiHLEsA+UtrUJglQezNq/yisMjmpXyON
	nixaZMnyVYh5hrpk4Nya1smddaQLNaBLcI3xiMzWVepQAElOi86AbcRMY4XAA6/Skw1ElGci0LrTI
	MULIpQJJ+P3I2jkqja3qTs+37/hYDX0/2NqYYA/McWksqxZmzJH8wP2mhwwFjVKyNXvbjV0+aU9QQ
	1Gz/2e4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nYrG9-009LPQ-Dz; Mon, 28 Mar 2022 15:26:21 +0000
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nYr3K-009EZT-AV
 for linux-nvme@lists.infradead.org; Mon, 28 Mar 2022 15:13:07 +0000
Received: by mail-lf1-x129.google.com with SMTP id m3so25280463lfj.11
 for <linux-nvme@lists.infradead.org>; Mon, 28 Mar 2022 08:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iCw0b3XToxwiaR/bdGuRr076f7JMY5fsXf/SeZL0nm0=;
 b=FNXA89+8fRs/cQ1rMfYcVgR6o3Z9XmDAs5sMd8H3hBVXBcKkiQk/2FVh0sDMrfXnRe
 0hAc19rXOSwu+TI5pvuzDzGEO4OhYQF7SOaUcsJAyODWM/beP2uoy1XyZ+U0ewVhkS2A
 e3S2kOOdhGa5IQYh7VMU5A65+8crgObh9tpPcP1TfTu/zlg9tyUFMojSJm+AVq+RZrrp
 ZC4PzNC7cvqrwHxfQm6imGAifQCpXevdsOjHQ3CFNvPow7RqwlGGapR7kzpsKlH/dvL/
 huWi+OYFoHmLXTnnnGvAqMT5ixjuhaVaNEUc6i3a/t4PVVc8jBvAAyl9ZZRAo6DRmGRB
 JCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iCw0b3XToxwiaR/bdGuRr076f7JMY5fsXf/SeZL0nm0=;
 b=N/qc4gkloOmQfdkGsvVjZmi+3Zu3HwC9tfbubGs7YU2xpvvu5jyiKCS3aBpehXyOkg
 TLJAVorj+RLlu3ztiYO2fIzQWqLL1l2fO7r589ujdLeclx1JGyKVhNg+D021G3ImawCy
 XnwD4WobCJGFHmflsR/kFGmFOC+aeCTwYppfHT0Tzdnw8CvLXXES+QnRuGLAWwz62g1j
 sxkjlTryw5FqBWqQ36KpCmj6fbQJxbb6ohe8OBlwlrSiB30mcerhCPrx1C3op87lvMn9
 dtRhfi4gMCEZjN8HrrX7tCE0CG/UK+HThhM5XDlEQ6HlRK9ebYcXiTOx9Qvr47rzRA2a
 4/NA==
X-Gm-Message-State: AOAM530/Bimrutpa9r9NNcyUDLrdmCHVN47ixurwck73uM4AOjswZ7Hn
 PUTMpWIARW1k9hG3XwVouXjTQ3Ii8mMAU1gv83o=
X-Google-Smtp-Source: ABdhPJyfgxxmWjPM51s46Lqx3TmQQoB1b7BftLFmSdR0rugNVGjSzV/nDP5PMYi2OLkLsAjoHdbb4x+8kmvbTuDWL4k=
X-Received: by 2002:a05:6512:c29:b0:44a:865e:19c4 with SMTP id
 z41-20020a0565120c2900b0044a865e19c4mr10112582lfu.306.1648480381090; Mon, 28
 Mar 2022 08:13:01 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20220325111952epcas5p4800055294fe473b923713d4b9c006026@epcas5p4.samsung.com>
 <20220325111444.5675-1-joshi.k@samsung.com> <20220325162058.GA16275@lst.de>
In-Reply-To: <20220325162058.GA16275@lst.de>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Mon, 28 Mar 2022 20:42:34 +0530
Message-ID: <CA+1E3r+pZiBb3fF4nA1ru6+SBtLNjp2dysZtMOjC=DQNHEV+zw@mail.gmail.com>
Subject: Re: [PATCH] nvme: enable generic interface (/dev/ngX) for unknown
 command sets
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, k.jensen@samsung.com, 
 =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>, j.granados@samsung.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220328_081306_428260_7CA41020 
X-CRM114-Status: UNSURE (   7.26  )
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

On Fri, Mar 25, 2022 at 9:55 PM Christoph Hellwig <hch@lst.de> wrote:
Thanks for the feedback; will change accordingly.

