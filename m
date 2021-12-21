Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B426CC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Dec 2021 13:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jVVvUvVQ+prN0jlPu8Y3XO/gLJ3J9jnlgf8nl/RXDa8=; b=ES9l5SjC3ZtDVa09zlpE+oo7oV
	3Jj9yrjKuk9xieGY+FYBXM4KZ2/lGdXg22rihw0spoeZZZTE3xZl2AxBaPTRaYzH6LF7ub5NT7Tef
	VHSd9Wsz1/7CfKgwbwZYdSO8F2VB7sHEKcjG/CgsjyyO6bREqbwOvCVrutydgJBFuhAhA8+O+IrHm
	bjK0BQqfBIIwWFwUMOOsf2rM1Bh7OzLGr0VeLRnkSDLZk3A+0uPPuab9QEmX2hb6trVyyJuc1ah6D
	6aA4IhzgFVOXzKpVEmAfacASyy6+ssOzYaZYHrSMkLkSj8ng2OgwObsX0TMkH7P29GCW8j0YGIDEg
	BlxAmSSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mzen4-006qQk-PB; Tue, 21 Dec 2021 13:02:50 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mzemz-006qQ7-0y
 for linux-nvme@lists.infradead.org; Tue, 21 Dec 2021 13:02:46 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0EE611F3A5;
 Tue, 21 Dec 2021 13:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1640091763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jVVvUvVQ+prN0jlPu8Y3XO/gLJ3J9jnlgf8nl/RXDa8=;
 b=Z3fsz6hFXO3MRAgFN6ak2O1x5Eu71IwShoeAj0SiFRjmUmfT/E4ojSfoxxzJrzVyELAM7V
 vn/Y/VZeAfBZqaomgRBGIWcP0kVDhma5FleioT4asAteiV0cqLSiu/g3StjKv5Ej39TFpX
 IbVSH97Bw/jqwwr6wJUW5He6ft3HPKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1640091763;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jVVvUvVQ+prN0jlPu8Y3XO/gLJ3J9jnlgf8nl/RXDa8=;
 b=xD8fBpFRXEgLDns8K1z+BM9IoB9pOIV36ZXOKLKefPNBnmEl1D5GHrer03CNvlAPFcwuJb
 lWr8bGsz3cq6HQBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0116313C3D;
 Tue, 21 Dec 2021 13:02:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id g/czAHPQwWHTJgAAMHmgww
 (envelope-from <dwagner@suse.de>); Tue, 21 Dec 2021 13:02:43 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org,
	James Smart <jsmart2021@gmail.com>
Cc: Daniel Wagner <dwagner@suse.de>,
	Martin Wilck <mwilck@suse.com>
Subject: Re: [PATCH] nvme-cli: nvmf-connect@.service: Remove matching from
 default syntax
Date: Tue, 21 Dec 2021 14:02:39 +0100
Message-Id: <164009175251.30030.10978793155269933125.b4-ty@suse.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217193232.29034-1-jsmart2021@gmail.com>
References: <20211217193232.29034-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211221_050245_243869_02ADD696 
X-CRM114-Status: UNSURE (   8.16  )
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

On Fri, 17 Dec 2021 11:32:32 -0800, James Smart wrote:
> commit 53aab69a0add added the "--matching" argument to the systemd
> connect script that issues connect-all to a discovery controller. When
> this argument is used, only discovery log entries whose target port
> traddr's match the traddr of the discovery controller will be connected
> to.  This eliminates the ability to do referrals by the discovery
> controller.
> 
> [...]

Applied, thanks!

[1/1] nvme-cli: nvmf-connect@.service: Remove matching from default syntax
      commit: 58c23ceb12d16756b2222a55d1d9dc5f34bb4fa4

Best regards,
-- 
Daniel Wagner <dwagner@suse.de>

