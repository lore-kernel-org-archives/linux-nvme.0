Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C0EEC47258
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Feb 2024 09:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oFwim8ThHrk8QQk358LWWpZbU9sDMBXoce8M4m6I6ls=; b=3ldWlCMOMD9J3JMIzBY1Hczv5G
	dhEsNeRm2eZeRPfBwIN10zyJn0sHZ1BNraVDceKsDmSmJyvWauLYl0UojWtpyUuirP2+/L2/Gjc+M
	8jNYXYV08qK7SGQ0enddNRB/BSc06y/Gw0jtccc7x5LJ9pooxesCODC0adYXMSdxqeV+IPf/U+et6
	YCyZqwWRLTAnskrhC/RcXZQ8YYJNl0gP1nKzBm0DRsnurGiGWcPtgshQrXufkSp2u6DC5m5xrAzyW
	qCThjHjlfi9+9iru4+lpN8Tj3t7yf1QBRuPEh90Dk0AbspH+ZLF/OI2M8S+Gc7jhu9k+SXd50JOf5
	DwjkzSsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVpSZ-0000000As7T-3wsI;
	Fri, 02 Feb 2024 09:03:43 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVpST-0000000As3Y-3BgK
	for linux-nvme@lists.infradead.org;
	Fri, 02 Feb 2024 09:03:42 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 90D321F6E6;
	Fri,  2 Feb 2024 09:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706864613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oFwim8ThHrk8QQk358LWWpZbU9sDMBXoce8M4m6I6ls=;
	b=WfYJPtQx17vISHkDDHhzbtc6gvAB1jix0EFACySWmTJ9iqwbJ4ex1wT5C0Gi9cBvBetOBI
	kncTUVwo7daei/yCJtzMGtt3qiVXvDNxjIOTBLpv7So3/fCFy/79auLxj2owaaQfLDT5rU
	MSG3+PU4ZfgKy3pnOJY6/171gRUjjB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706864613;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oFwim8ThHrk8QQk358LWWpZbU9sDMBXoce8M4m6I6ls=;
	b=o3+WmFIXALVT6l11YvJA8V7ohdpKvoOI1tIUW36B73mcAwJPo+LOTqOrNyXVllAsVZqiMJ
	09NlT0VDlA7PxdAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706864613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oFwim8ThHrk8QQk358LWWpZbU9sDMBXoce8M4m6I6ls=;
	b=WfYJPtQx17vISHkDDHhzbtc6gvAB1jix0EFACySWmTJ9iqwbJ4ex1wT5C0Gi9cBvBetOBI
	kncTUVwo7daei/yCJtzMGtt3qiVXvDNxjIOTBLpv7So3/fCFy/79auLxj2owaaQfLDT5rU
	MSG3+PU4ZfgKy3pnOJY6/171gRUjjB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706864613;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oFwim8ThHrk8QQk358LWWpZbU9sDMBXoce8M4m6I6ls=;
	b=o3+WmFIXALVT6l11YvJA8V7ohdpKvoOI1tIUW36B73mcAwJPo+LOTqOrNyXVllAsVZqiMJ
	09NlT0VDlA7PxdAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E141139AB;
	Fri,  2 Feb 2024 09:03:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lK1MHeWvvGWGRwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 02 Feb 2024 09:03:33 +0000
Date: Fri, 2 Feb 2024 10:03:32 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, 
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Dennis Maisenbacher <dennis.maisenbacher@wdc.com>
Subject: Re: Re: [PATCH blktests] nvme/046: change nvme io-passthru command
 option from -o to --opcode
Message-ID: <xfypo2wloir5l3wrw4aodzjekertc4dlnb7dvk2i5egiqwo3ao@rokmuhzvvcfe>
References: <20240126061037.2169224-1-shinichiro.kawasaki@wdc.com>
 <rbpa7bx5rfhnlhnrzucz5hi5szflkvihdtdmuksuccekwy53qf@nbotapgudm6r>
 <Zbu2qJGoz9UQfPw7@kbusch-mbp.dhcp.thefacebook.com>
 <232e910f-ea57-4532-a24f-9c461507146b@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <232e910f-ea57-4532-a24f-9c461507146b@nvidia.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.80 / 50.00];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240202_010337_975720_7B8231D6 
X-CRM114-Status: GOOD (  25.89  )
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

On Thu, Feb 01, 2024 at 06:17:01PM +0000, Chaitanya Kulkarni wrote:
> On 2/1/24 07:20, Keith Busch wrote:
> > On Wed, Jan 31, 2024 at 03:34:14PM +0100, Daniel Wagner wrote:
> >> On Fri, Jan 26, 2024 at 03:10:37PM +0900, Shin'ichiro Kawasaki wrote:
> >>> A recent commit in nvme-cli v2.6 changed the single letter of the
> >>> --opcode option from -o to -O. This caused the failure of nvme/046. To
> >>> make the test case work regardless of the nvme-cli version, replace -o
> >>> with --opcode.
> >>>
> >>> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> >> Sorry about this. We introduced a couple of global flags, -v (verbose)
> >> and -o (output) and this changed a bunch commands. This was done in the
> >> quest to add JSON output format support add to all commands.
> >>
> >> I will refrain from doing more like this for the 2.x cycle.
> > Changing intput/output is always going to trip someone up. Maintaining
> > backward compatibility vs. improving the design is a challenge.
> >
> > IMO, though, scripts should always use the long options. The short
> > options are convenient for hacking away at a terminal, but they're not
> > readily readable. The long options are more descriptive for when you
> > have to maintain the script in the future.

Good point. I'll keep that in mind.

> I'll keep in mind while reviewing patches, let's make the policy to use
> the long options for blktests at least.

Yes, makes sense.

> Daniel, is it possible to update nvme mailing list when you release new 
> version
> of nvme-cli/libnvme so someone can run the blktests and make sure things
> are stable ?

Sure, will do.

I hope to get blktests hooked up into the CI build, so that we can catch
those problems earlier. Dennis made good progress recentely on this
project. Let's see how it goes.

FWIW, you can also get notification from github whenever there is a new
release. As far I can tell all distributions rely on this feature
nowadays. E.g. when I do a release a few minutes later Arch usually
ships the new version :)

