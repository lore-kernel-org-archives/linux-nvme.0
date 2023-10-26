Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 450ECC25B67
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Oct 2023 13:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7rK2Gdfki2buF/+1fFTKgr/9v5OKh28TcBAEfhAtzbY=; b=SdXCMMrYgXSFBAtPHu9paRPP8n
	5HXoK8MYxA5h5KOwysrMk5kJtDWjUKUX4j4f9tj2qmfzE5Vdr+na87DW0jGx3ITV/9/ogqz85arb4
	+KZzHKG8AWM+C6rw5ilSfG7cCJ12WX45m/JAdmwK2YHIRbpaTioIA+UU6nkYQHy6ufvpDtpTz8DCp
	UcsjLQQUhTCQxxlEWNzhmkWQmuuRcBQEn65eVB/b/dTfmqjTEbOLKNcjIVkoyF9MflfvUK+eux9Xj
	AJqDzNuACDDc1jnyoOTqlipaFQ9jF+QSSGJR2B12ZV5s13LezD8bK8ZMV5107Ti7RP1fiP9cRkIcf
	TDkQWg1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qw0f6-00EZxm-0q;
	Thu, 26 Oct 2023 13:44:36 +0000
Received: from vps0.lunn.ch ([156.67.10.101])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qw0f3-00EZwl-2x
	for linux-nvme@lists.infradead.org;
	Thu, 26 Oct 2023 13:44:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7rK2Gdfki2buF/+1fFTKgr/9v5OKh28TcBAEfhAtzbY=; b=SyaND0yGQAPqt81flZS4dBYhle
	vn6XPG4EuXJXpl4O+824HTxahalYMm2NMP2TsavRDixuzk8hf2KKHAgwF039d2HibyhcgC1eXPSIy
	p+/NRTqy+HfHFMYqDP/dmyvFY52Eh1j+7OKo8bMDtXJ9+R8zMZWsve/9cUrFZHmgo2Fc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qw0es-000Fs7-Og; Thu, 26 Oct 2023 15:44:22 +0200
Date: Thu, 26 Oct 2023 15:44:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christoph Hellwig <hch@lst.de>
Cc: Kees Cook <keescook@chromium.org>,
	Justin Stitt <justinstitt@google.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	ksummit@lists.linux.dev
Subject: Re: the nul-terminated string helper desk chair rearrangement
Message-ID: <c7445b16-27c9-4182-8b0a-4272ddd2d341@lunn.ch>
References: <20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com>
 <20231019054642.GF14346@lst.de>
 <202310182248.9E197FFD5@keescook>
 <20231020044645.GC11984@lst.de>
 <CAFhGd8o8FaD-3rkBAhEXhc8XqpUk_cLqNwyfpndVuSxDOei_gA@mail.gmail.com>
 <202310201127.DA7EDAFE4D@keescook>
 <20231026100148.GA26941@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026100148.GA26941@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231026_064433_958256_F6FCDEEE 
X-CRM114-Status: UNSURE (   6.64  )
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

> > > [1]: https://elixir.bootlin.com/linux/v6.6-rc6/source/include/linux/fortify-string.h#L292

I found that https://elixir.bootlin.com/linux is the best way to find
Documentation for functions and structures. I would suggest try it
first, and only when what fails to start using grep.

       Andrew

