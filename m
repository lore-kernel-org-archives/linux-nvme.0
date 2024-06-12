Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C460C27C53
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jun 2024 21:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yCmrzEiID1d7fBr18T8wzcPvEeuHgKP/DqXaO8p4zIk=; b=QfD0ZsWkKAAUfLVJhv1RNUvVWS
	pHgHnsISxgGKXLk2zXISigOLKhSH/GaM35CLr3mFR7mZM2MULMoPrs7SblrhE1X3L+g2BgDxGBm1i
	yOcy1xUwF+ZCocRJmbme+AJpEF3p4bZuI5Iq7+CpOF+EXaCd0cKoHxRBsDEZfl6C19YEOLM8QhPYD
	cW0SRp9hKRgqFIlHZw3QEbbgu+mzZwp3eb4FvP6J1J5Xor9ND3uTMlTUs8i0+E30qYtdrCCbiVmMN
	d+f+jgtxdu9WjnACkb6Fpy8anYoeKtnq8zi+sZM62eFGBSYssLYKtl3P2Ao7Zr+lOP/i3g+Ytnuuk
	/d8+Tcfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHV7J-0000000E89Y-24er;
	Wed, 12 Jun 2024 21:02:49 +0000
Received: from hr2.samba.org ([2a01:4f8:192:486::2:0])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHV7H-0000000E87Q-1RUF
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jun 2024 21:02:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Cc:To:From:Date;
	bh=yCmrzEiID1d7fBr18T8wzcPvEeuHgKP/DqXaO8p4zIk=; b=coeMWT35Qu08XTWOoQwC2CiT11
	1HeWCiXRYDFbGznhbzKp65msZI05WtPgkv9vd+4NyBaTLkx47jw+GhKSTKvHQWcozbWC8Dan0X+GK
	sqn0oK5QHVgZGT/qf7YMl7N4YWnSDs/1IBTL+ANYV0yncGbaf1e/8KYPlCckYctX5wM4Zmh9yuksK
	q4U1pqDGkB9/EWWpz1DzLAYNmV4wNVRdGXPSRPlr+7nHT4osgVZQ0i0CSQFoyTMfr2MGx4kRE3IRq
	rTP+1lBSdNozBziO203EdDG2yLEmXARsuoWvHxazcddNvPJX0hkc9lJwnMbOGWBRuHg6S5oyU0SNW
	h38fH1pGm4SiCK45Tnvjw1OQ8OaSkuvDm+kClklcyHla8csgCcYdBGv3nBMDkDFZfwQb0B2ng8qT2
	9pNlhxSvJstgtV8bs2IHR086esQgOGPiYcgqYJOv4bRj2bOf4t0NT7LlEuPIi8JgsHvUIJnm4eAFX
	/f8D4F9oYOZMiI55lI8bB3Mj;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1sHV75-00GPm2-2u;
	Wed, 12 Jun 2024 21:02:36 +0000
Date: Wed, 12 Jun 2024 14:02:31 -0700
From: Jeremy Allison <jra@samba.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Tanjore Suresh <tansuresh@google.com>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Lukas Wunner <lukas@wunner.de>,
	David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v6 3/4] driver core: shut down devices asynchronously
Message-ID: <ZmoM59t82BCy8h3b@jeremy-HP-Z840-Workstation>
References: <20240516154920.221445-1-stuart.w.hayes@gmail.com>
 <20240516154920.221445-4-stuart.w.hayes@gmail.com>
 <ZmoLL8c_ujmjzSHQ@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZmoLL8c_ujmjzSHQ@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240612_140247_418410_C87A9047 
X-CRM114-Status: GOOD (  17.34  )
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
Reply-To: Jeremy Allison <jra@samba.org>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jun 12, 2024 at 02:55:11PM -0600, Keith Busch wrote:
>On Thu, May 16, 2024 at 10:49:19AM -0500, Stuart Hayes wrote:
>> Add code to shut down devices asynchronously, while ensuring that each
>> device is shut down before its parents & suppliers, and allowing devices
>> that share a driver to be shutdown one at a time if necessary.
>>
>> Add /sys/kernel/async_shutdown to allow user control of this feature:
>>
>>   safe: shut down all devices synchronously, unless driver prefers async
>> 	shutdown (driver opt-in) (default)
>>   on:	shut down all devices asynchronously, unless disabled by the driver
>> 	(driver opt-out)
>>   off:	shut down all devices synchronously
>>
>> Add async_shutdown to struct device_driver, and expose it via sysfs.
>> This will be used to view or change driver opt-in/opt-out of asynchronous
>> shutdown, if it is globally enabled.
>>
>>  async:   driver opt-in to async device shutdown (devices will be shut down
>>           asynchronously if async_shutdown is "on" or "safe")
>>  sync:    driver opt-out of async device shutdown (devices will always be
>>           shut down synchronously)
>>  default: devices will be shutdown asynchronously if async_shutdown is "on"
>>
>> This can dramatically reduce system shutdown/reboot time on systems that
>> have multiple devices that take many seconds to shut down (like certain
>> NVMe drives). On one system tested, the shutdown time went from 11 minutes
>> without this patch to 55 seconds with the patch.
>
>I've successfully tested this out on a few systems, and noticing a very
>decent shutdown time on my nvme systems. I also like the current
>solution here, as the two-pass method was harder to follow.
>
>So I think just remove the extra options that Christoph mentioned and
>always use the driver's preferred shutdown method, then this would all
>look good to me.

Yes, I have tested this patch on my systems and am greatly in
favour of this instead of the two-pass version I was trying
to make work. It is easy to understand and fixes the problem
for my NVME issue.

Jeremy.

