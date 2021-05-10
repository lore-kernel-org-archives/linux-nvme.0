Return-Path: <SRS0=GcL3=KF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C50C433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 10 May 2021 18:31:18 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEB94613CD
	for <linux-nvme@archiver.kernel.org>; Mon, 10 May 2021 18:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEB94613CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=iuZqWPv4dXXSlgjoZRfxlK40Shuer87IS2LOMtNKhYM=; b=eM60R6byE1XXlM8XpbfPH//u4
	Mq7t06nTW9uy8HQovqh7LXV1FHpdZaipmgliSIqeiSo1atVl1tGkDR4EiCheyjy5nxBpd6HJvG0qa
	PDtYeQk+K+DHuWp1NZGklM4UrNEdvrlEBDK0zkUpktR8vlN9jdELqXeIVZ+MX1tE/+XMr0yUO1Cjf
	j2bhi+yPgcx8RCaN1yplRUVLuIo53OclHKrUC2o37ghPrd8nqekWg6mvTx6uvsrvyJ9bjpGSCp2gY
	1PPKDvmWF6gLNXjc1ykw7YBxrqqQo5KSvREEgB1BGhXy+yWmaMz2zPDbVkjRM+yfNjp0hVgYT3684
	48+Lp/hew==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgAg6-00FRTv-Hd; Mon, 10 May 2021 18:30:50 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgAg2-00FRTc-BK
 for linux-nvme@desiato.infradead.org; Mon, 10 May 2021 18:30:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=KbB00cjdMrGZ3/EeQJOhKDmPoV/wuvZQQWIztSc8h9c=; b=06GGXSk11n8j5FypeAurefabTU
 JyJ4dh28uR+xah45eN5fmNgudbkv59HlGC+Gf0wy2OPnJAZ1WjtKAI7Z1YE01hMd4KvFYd4OtGufc
 VuPrseYHSJT2ZL0I0DSXZjAAh7mvZG9uVy1rjRuNvB5IqpP6Nc65MHjJGWhG9jgRnvzJGMD1UtgzM
 7IMNfZY2XCNtb9cCiCBUbnrtTdrXIeDMyn5YA1mqyWZu0DDdfm1otWmFjnfEbekHXQdFOq/i3gbCS
 UzB4S2T0WLs1A7sv/+SnxZInjNmhhJgGarr467mvi7H1HyZspERaHrj5IE0zpKXJgrIA6caWC8Tp9
 tUHT1l+g==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgAfz-0092Ki-PB
 for linux-nvme@lists.infradead.org; Mon, 10 May 2021 18:30:44 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id E5A2F613CD;
 Mon, 10 May 2021 18:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620671443;
 bh=n//idOLDY3gOjvJUy3GyjpOm+cphTgA5iq5m/UGuy80=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WbXntB1a8Ax24Wcyb6THYvtGs9tkBt1FxzyTAjXpu8B0+8OZQqJPF8Pk+6V3aV4b9
 h7fb4SgQOkASo18BMKUzK3wlBWSwieULN3e+PwxYbcWYwKW7MIUvEVt4JZPXtDiTSM
 o/cvoSG0t+GopA4/gdDPW+idbufrUa76c8IGdJiSnIzuY4AG5sUyycMifuIQXZuHI9
 zyic4FedhWn6Q0uN2SYGc6d955DaWVhcsE9JSCxkoLvX4Az+ux457wY8eBd7rHoRd3
 5iOoS70ks5AGcfQhPCYeIlk/QZOkhKDG/HX0uqzWiMAkn2b4IemmgykvOX7dHZkfx2
 pKu0044lQgLqA==
Date: Mon, 10 May 2021 11:30:40 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
Subject: Re: nvme tcp receive errors
Message-ID: <20210510183040.GC1857448@dhcp-10-100-145-180.wdc.com>
References: <20210503142848.GB910137@dhcp-10-100-145-180.wdc.com>
 <8932c0f7-1d9d-90a0-dd9d-32ba43d03d76@grimberg.me>
 <bd69eafa-9f1d-4cdf-f1b5-8b71ffd78917@grimberg.me>
 <20210503194404.GA910455@dhcp-10-100-145-180.wdc.com>
 <ba05ff5a-b6bd-b6e4-a96b-fb9ee4e01f66@grimberg.me>
 <20210504143633.GC910455@dhcp-10-100-145-180.wdc.com>
 <76a715f5-6a37-8535-3fbe-1aa0f3a54dbc@grimberg.me>
 <20210504191441.GA911866@dhcp-10-100-145-180.wdc.com>
 <20210510180633.GB1857448@dhcp-10-100-145-180.wdc.com>
 <6838b8da-7e05-a08d-b67f-1fe28b0d880b@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6838b8da-7e05-a08d-b67f-1fe28b0d880b@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210510_113043_866186_8A7D3814 
X-CRM114-Status: GOOD (  17.01  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, May 10, 2021 at 11:18:24AM -0700, Sagi Grimberg wrote:
> 
> > Sagi,
> > 
> > Just wanted to give you an update on where we're at with this.
> > 
> > All tests run with your earlier patch removing the inline dispatch from
> > nvme_tcp_queue_request() are successful. At this point, I am leaning to
> > remove that optimization from mainline.
> 
> Thanks Keith,
> 
> Did you run it with the extra information debug patch I sent you? What
> I'm concerned about is that given that you have the only environment
> where this reproduces, and this is removed it will be very difficult
> to add it back in.
> 
> Also, what about the read issue? that one is still unresolved from
> my PoV.

The test team reports no issues for both read and write tests with the
inline dispatch removed. That single patch appears to resolve all
problems. Sorry, I should have clarified that initially.

We will go back to the extra debug from last week on top of a pristine
mainline kernel. There's been some confusion of which patches to apply
on top of others in the mix, but I'm getting better at coordinating
that.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
