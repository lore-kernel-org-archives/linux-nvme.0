Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E3CFC46CD2
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jan 2024 18:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vyi7Jk8s1GGdbDgKQkhkdShn9I6oBrF0UuofmZnT4Gw=; b=ztHTFvdWtSi+uQBYn+jQpQ7j0L
	ncf5SJkrJC9hTbUUNkP1eL1vaFySXBKibedzh7xI3fBGfKsFPNiYOomEGC6OI7mml1gSC1KV6i2ex
	DfQGlUQeHbi+2dU3Z8jIikMiKmJokTPNyPaXpOmml/aFSyoc3ob9Y5GDjP2UnfdIu1NWsUKL1VKBV
	Xgb1gpv/bqojDSQ+bxcHPSaL4KK0oGCPXakbaHtGroKj1UiyAtovSxM/4ToGTji1Xr/eZoQFy2e+j
	6q31PTbdkBwyyZs3LiAP7Q42TORr7HEALc0y6MBhsEaqKQZcU9QvazN+gfbNq4XB2x2ZN2DgbweE+
	j1wvnzUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKj7E-008fCS-2e;
	Tue, 02 Jan 2024 18:03:48 +0000
Received: from hr2.samba.org ([2a01:4f8:192:486::2:0])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKj7A-008fBY-2b
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jan 2024 18:03:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Cc:To:From:Date;
	bh=Vyi7Jk8s1GGdbDgKQkhkdShn9I6oBrF0UuofmZnT4Gw=; b=PkzxzVjTh5VIL7oV4T2pzzLan+
	KXG/N2BUDDqEyj1j5pp9zqWIwIFR2sDoCI9+xsR6T3VaGa6DynKw7DvZu0d+k44cvbGXtw++lNbJ0
	LJWXh+E0t8KSJ/7HJiICwvPiYumZODa/UlI/DfXa6S6j+jzAfJ6CWNRfgGMFIyNnpQ5qp2lJtUvZD
	A7l/tM8LPDREeYtEMA6WUwRuYqiFp74rEQnVgjUIIo6p+1Ifu/Hm1MgMW9KrN3MVLnCoRe5azg/+o
	pudRX8kYXss5T3QucYTH2nee0BDh9rADDQK+5VDIajkCsnnVb0LQKyIneXGOqy06sQnS0GI5TrGL0
	5Az19rLbuPWos2MTRBTl7vEVsaHPDhelGHJWd/YVImFJjNT2RTSXZJspmnwrg4TppvEmt4ZCaJRMA
	jNTcyw43ZyuB5ngbHjEPQ6/HIX323T1Y+rF72zPYik+TpchTzyolkCvY6PlayUlhpXcG3a9JDfvcW
	CvxsKuFb1HkYgDJ72Iw1/fSj;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1rKj6x-0067De-1v;
	Tue, 02 Jan 2024 18:03:32 +0000
Date: Tue, 2 Jan 2024 10:03:27 -0800
From: Jeremy Allison <jra@samba.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Jeremy Allison <jallison@ciq.com>, tansuresh@google.com, hch@lst.de,
	gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	linux-nvme@lists.infradead.org, jra@samba.org
Subject: Re: [PATCH 4/4] nvme: Add two-pass shutdown support
Message-ID: <ZZRP730tbkXNndZl@jeremy-HP-Z840-Workstation>
References: <20231221172257.2234320-1-jallison@ciq.com>
 <20231221172257.2234320-5-jallison@ciq.com>
 <694ac9af-ac3b-41a0-a50d-abb89503d453@grimberg.me>
 <ZYt1o/n8qymZC65g@jeremy-HP-Z840-Workstation>
 <e2001f25-ee04-4f34-823c-7647ab58da13@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e2001f25-ee04-4f34-823c-7647ab58da13@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240102_100344_915062_5A9E1B79 
X-CRM114-Status: GOOD (  10.71  )
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

On Mon, Jan 01, 2024 at 11:21:14AM +0200, Sagi Grimberg wrote:
>
>
>On 12/27/23 02:53, Jeremy Allison wrote:
>>On Mon, Dec 25, 2023 at 11:58:04AM +0200, Sagi Grimberg wrote:
>>>On 12/21/23 19:22, Jeremy Allison wrote:
>>>> EXPORT_SYMBOL_GPL(nvme_disable_ctrl);
>>>>+int nvme_wait_for_shutdown_cmpl(struct nvme_ctrl *ctrl)
>>>>+{
>>>>+    ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
>>>>+    ctrl->ctrl_config |= NVME_CC_SHN_NORMAL;
>>>
>>>Why is ctrl_config being set again?
>>
>>Good catch. There's no need for that. I'll fix
>>in the next iteration, thanks !
>>
>>>>+EXPORT_SYMBOL_GPL(nvme_wait_for_shutdown_cmpl);
>>>
>>>Why export the symbol?
>>
>>nvme_wait_for_shutdown_cmpl() calls nvme_wait_ready(),
>>which is a static function defined in drivers/nvme/host/core.c.
>>
>>The only way to inline the functionality of nvme_wait_for_shutdown_cmpl()
>>into nvme_shutdown_wait() is to export nvme_wait_ready() instead.
>>
>>If you're OK with that I can remove the intermediate
>>function nvme_wait_for_shutdown_cmpl() (and indeed as
>>you've pointed out there's no need to set ctrl->ctrl_config
>>again).
>
>I think it is small enough to make it static inline in nvme.h

Sorry, just looking for some clarification here. Are
you talking about inlining nvme_wait_ready() ? There
are indeed larger functions already inlined in nvme.h.

