Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF31C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Mar 2022 12:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DAtfKJxhTlUfLfh7FDdHLWXEZv3s/cYhD3RWZTonYVc=; b=NVw3izF6n/wWitrfRfgznAxCmh
	ddT7GEoFfr3cCcUhJZTC3jlwwyg5cNF2hnxkac5Y/3Smd4yhMB7uwKDoSznpnPsuvnnO5Q/pOBZxx
	h34L+PfTlwL/z2IM55gscOEUtYfQ46bGDj/eNh2jh6LC0ITWSwEQk5cOh+2iwyB4RP0I5+3G4Qqgw
	azFOdEoKDXdP09K7VOzitxvJ+4Ccml7SCXxbWXVfaYfnddFyrxFQc7w9kwAPuHZkVXW0DkxpT1Sbq
	QO0mi2TtgTb3xvBS6wRp7/fM2M7DONrMG2L/0WDOmsqOxZADdjC/TK+bXzpT+qUvEuNFbUOE832wo
	ZezzPe0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSI5t-00CooQ-R4; Thu, 10 Mar 2022 12:40:37 +0000
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSI5r-00Con2-3Y
 for linux-nvme@lists.infradead.org; Thu, 10 Mar 2022 12:40:36 +0000
Received: by mail-lj1-x22a.google.com with SMTP id v28so7485656ljv.9
 for <linux-nvme@lists.infradead.org>; Thu, 10 Mar 2022 04:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DAtfKJxhTlUfLfh7FDdHLWXEZv3s/cYhD3RWZTonYVc=;
 b=CNx5wp3+3lfwtIyoCM9pRl1cXVqdYbE6/d4Op9YI4mLz2vYcAduj4xLyqq95HxWX8Y
 /UqkC3O3uouwq15gtsKUA6ISPm+F1W/NRnQEkLSibFQOOlM9Ou0pWViE0PSFvdm+i6hE
 cVbSFHOo87qTdoL+ls2yBlZrEyEryORUwE8MY9mVRruJmSXBKW5MO0pjMPclHlgbe35v
 vv73luUALWmVAxQhjuYyrg1o3+DZ5JaBwo7pgQE7XuCtVhXNxaEdVMhp+gJpOh3jpDla
 hYADDMd0nJAtdtyPxuB/9RzMmIl5x5EZmsyiZDBHc7/PTZkR5jNUByZbxz54s09DOrJC
 evqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DAtfKJxhTlUfLfh7FDdHLWXEZv3s/cYhD3RWZTonYVc=;
 b=gs0TH2aierbtJDT7qr0StUOr/xWKSu9R5fJlwkD8MmsQpj3/8OO/0HhU9FIlYE6TIV
 mFVtXQzigNvupNC4J1IOw/WHz6i7e60Uc5uiD5IS/V+3lwu4EPWICfzMIJ3lny22XH7w
 eqiKMS394fXZ+qVnf+LgkMP91u621AOa9R1FfvYNgbSjcyqn7CFPA7S6Lqy8oPfwDcI9
 3p910UxJS4midKBugBiFWqgM7cRS/aKvVHtAxJSMpPyGVTldTM8l/sE+iBeH24MZxdJl
 F1ZdSEfHD+tgGaBqUvFFx5itXd4gqK8+RM0UhjfNkE2E+pm6kiC1UPjdfLmB/vxem/Ps
 HSpA==
X-Gm-Message-State: AOAM532CflO9WyW67runJ0YMqPpHWGrV+D8Bbi8eGNrZO3oKFeglrRh3
 5YICDZpvYkCDSFsXqWN+zKScxNlGQSLqmg0JDQc=
X-Google-Smtp-Source: ABdhPJyOXMDOJXEweNjgQ/Heimakq+LFmrhTTQqxKwAXvx1dEWUO11jTrEOo7xbbSHGosGfV5AfpN6e8NUahPBFVAbw=
X-Received: by 2002:a2e:3004:0:b0:223:c126:5d1a with SMTP id
 w4-20020a2e3004000000b00223c1265d1amr2931647ljw.408.1646916033166; Thu, 10
 Mar 2022 04:40:33 -0800 (PST)
MIME-Version: 1.0
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152714epcas5p4c5a0d16512fd7054c9a713ee28ede492@epcas5p4.samsung.com>
 <20220308152105.309618-11-joshi.k@samsung.com> <20220310083400.GD26614@lst.de>
In-Reply-To: <20220310083400.GD26614@lst.de>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Thu, 10 Mar 2022 18:10:08 +0530
Message-ID: <CA+1E3rJMSc33tkpXUdnftSuxE5yZ8kXpAi+czSNhM74gQgk_Ag@mail.gmail.com>
Subject: Re: [PATCH 10/17] block: wire-up support for plugging
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>, 
 Keith Busch <kbusch@kernel.org>, Pavel Begunkov <asml.silence@gmail.com>,
 io-uring@vger.kernel.org, 
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
 sbates@raithlin.com, logang@deltatee.com, Pankaj Raghav <pankydev8@gmail.com>, 
 =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>, 
 Luis Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>, 
 Anuj Gupta <anuj20.g@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220310_044035_174085_D884AE03 
X-CRM114-Status: GOOD (  11.47  )
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

On Thu, Mar 10, 2022 at 2:04 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Mar 08, 2022 at 08:50:58PM +0530, Kanchan Joshi wrote:
> > From: Jens Axboe <axboe@kernel.dk>
> >
> > Add support to use plugging if it is enabled, else use default path.
>
> The subject and this comment don't really explain what is done, and
> also don't mention at all why it is done.

Missed out, will fix up. But plugging gave a very good hike to IOPS.
Especially while comparing this with io-uring's block-io path that
keeps .plug enabled. Patch 9 (that enables .plug for uring-cmd) and
this goes hand in hand.

