Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9472C77B78
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Apr 2023 09:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7j4qJXIawGY6mpyNjNiUk4lxy3e36PGk3TvZkti17I0=; b=lPGHUBoHhHPpvmcdTJGTBBV/d6
	WeHo53kHshKXJXjMXWrl4MXeGztMMDWjoNjxCiNWtTaAJMZC7DU6NZ/mEnMheeZ/JhhUfuInYWa/g
	qz0dJs+er45as4lFmCeH2ff8V9ir30/SmUaV2bflng+SsHlAcG64YJuSCi6dfIBQV6O78uXTYYwO2
	xBv9b4KDWOFmmVVAqcTj5wBW1dEhzHGdBnFwm86JOPJ2vhSgsAKLnV8/Tsi+WVMfkanJcu7XZGZeG
	9a5OzLXL6W8WWsWEP2AX7VZ8b/XaQciC3nc/ijuXsLfRRFwe5Z7OnA3H4iFUdcBfZQCrxhoUCaK0O
	CIGfHpVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pp3j2-004gpt-2r;
	Wed, 19 Apr 2023 09:03:40 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pp3iy-004gp5-22
	for linux-nvme@lists.infradead.org;
	Wed, 19 Apr 2023 09:03:38 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1F69C218FA;
	Wed, 19 Apr 2023 09:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681895014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7j4qJXIawGY6mpyNjNiUk4lxy3e36PGk3TvZkti17I0=;
	b=Tj94UxfK6K7wLBKigrc77QBvPBsPY3QM40KxLpP4L0LQPc2W038uyhv3sIcCc9PE4Pl8BT
	He/xvrLP+yyOb7sNDD7lF7p08k55WDUc/AYRVXHGAXqN/4+sOFQxAfziCSTujQRivroeLw
	o43QR8IJGzXvf8OIqFION0pMXX+mx4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681895014;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7j4qJXIawGY6mpyNjNiUk4lxy3e36PGk3TvZkti17I0=;
	b=53tm+o8syWXozVEDsTToCP6FxOj/tYgzwaWPw46EzsVUdElogZnK1JYTQ6i1RZDTcbFW5q
	J0w4T4jrXjagHGAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 119F513580;
	Wed, 19 Apr 2023 09:03:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id XglHBGauP2Q1fgAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 19 Apr 2023 09:03:34 +0000
Date: Wed, 19 Apr 2023 11:03:33 +0200
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Martin Belanger <Martin.Belanger@dell.com>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH v3 0/4] nvmet-fcloop: unblock module removal
Message-ID: <srd2pdxk5vqchlrdimlbqxqdc6v6x2n4x7y4muyaajiy6fim6z@bnejs2qf5zhe>
References: <20230418130159.11075-1-dwagner@suse.de>
 <nlogr5rdxqvilsz4iolktfpdvflvvithwaoa3vrx2fsjqlho4q@4upw7jq3aem2>
 <lum3oejitdb36ox2ec736kc73hzlmmnyr7jtg23wfa4t5slkvs@hm4u6xfnatcp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lum3oejitdb36ox2ec736kc73hzlmmnyr7jtg23wfa4t5slkvs@hm4u6xfnatcp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230419_020336_821063_288DCDAA 
X-CRM114-Status: GOOD (  15.86  )
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

On Tue, Apr 18, 2023 at 04:26:27PM +0200, Daniel Wagner wrote:
> On Tue, Apr 18, 2023 at 03:43:22PM +0200, Daniel Wagner wrote:
> > On Tue, Apr 18, 2023 at 03:01:55PM +0200, Daniel Wagner wrote:
> > > nvme/041 (Create authenticated connections)                  [failed]
> > > nvme/042 (Test dhchap key types for authenticated connections) [failed]
> > > nvme/043 (Test hash and DH group variations for authenticated connections) [passed]
> > > nvme/044 (Test bi-directional authentication)                [failed]
> > > nvme/045 (Test re-authentication)                            [passed]
> > 
> > I suppose these should be disabled for fc as all this is tcp specific.
> 
> After a fresh reboot the deleter tport, lport and rport trouble is back...
> 
> nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
>     runtime  10.265s  ...  10.365s
> tests/nvme/rc: line 198: /sys/class/fcloop/ctl/del_target_port: No such file or directory
> tests/nvme/rc: line 190: /sys/class/fcloop/ctl/del_local_port: No such file or directory
> tests/nvme/rc: line 182: /sys/class/fcloop/ctl/del_remote_port: No such file or directory

Eventually, I figured the out the root problem. The modules got unloaded before
the resource were freed. This explains a lot of the nasty problems I saw.
Anyway, I posted an updated blktests fixes but I think we should still consider
these patches here.

  https://lore.kernel.org/linux-nvme/20230419084757.24846-1-dwagner@suse.de/

BTW, the authentication tests fail for fc, but not for the rest. And after
reading up on it, it supposed to work on fc as well. So here we go first real
bugs found.

