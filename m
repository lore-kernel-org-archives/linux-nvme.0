Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D495FCD11DF
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Mar 2024 09:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4DYPP75j7C3GhlIHB9YssHuA5ow7hvgyLAib1zLr/FQ=; b=w61bHMGzZRrAYjoldRKyZCydaA
	khkX8NNLxoELmtmQCTl4BAdzJWp2TQvfukNseBxdoy4AdxvvKK/kOIe1xIEBNfZkg2BrIJC5e9DMq
	IBabO2/+J+GsfuZuwHRS3L4CSPQKqgfgmL556X55YGHOXyds9UDbWs1qhD5dGpS7vPBYr9C0ZcRL6
	mQ/dWgfI9LJhJedcyFGixzH5GJsA3s/udjZEqUKhI6+ICVxPUVESg7V7QxVlNGZUwZgwqjgv/FfuR
	kHzrr1fOQ5hLPOsjXpQGI9wbjxGGsLG7F8i9XrZKe9QePEQDW3Lq3GAGl95NiU8ENTo8zJzGB0OAj
	03zxRBrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp32A-00000003o3F-31Y2;
	Tue, 26 Mar 2024 09:23:54 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp324-00000003o1a-3SRr
	for linux-nvme@lists.infradead.org;
	Tue, 26 Mar 2024 09:23:52 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 26F293534C;
	Tue, 26 Mar 2024 09:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711445026; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4DYPP75j7C3GhlIHB9YssHuA5ow7hvgyLAib1zLr/FQ=;
	b=y/BF39b4shPQzjxBaQrzQHx+rKCH6AnrIcfKPrO7DrYVYw2WzPyHknHeswYbagtqKGHvLK
	9AvMx6AqwhFYSVNr7gYFdOwlvntuH3L5wLnWZsGSHHBdF/R+NCuPiHdJND20i0kmaYWggm
	JkDjfyOwRg2GYSg1awv9RkAFsj3X8h8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711445026;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4DYPP75j7C3GhlIHB9YssHuA5ow7hvgyLAib1zLr/FQ=;
	b=/goQ2ldyNdTbi8SQPwvawbsg1gnrqzxgeJj6jDNzoSzb/Qm9+ReTcFKTH16SVOyux/oYyT
	E01cE2xT+XYSKfDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711445026; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4DYPP75j7C3GhlIHB9YssHuA5ow7hvgyLAib1zLr/FQ=;
	b=y/BF39b4shPQzjxBaQrzQHx+rKCH6AnrIcfKPrO7DrYVYw2WzPyHknHeswYbagtqKGHvLK
	9AvMx6AqwhFYSVNr7gYFdOwlvntuH3L5wLnWZsGSHHBdF/R+NCuPiHdJND20i0kmaYWggm
	JkDjfyOwRg2GYSg1awv9RkAFsj3X8h8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711445026;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4DYPP75j7C3GhlIHB9YssHuA5ow7hvgyLAib1zLr/FQ=;
	b=/goQ2ldyNdTbi8SQPwvawbsg1gnrqzxgeJj6jDNzoSzb/Qm9+ReTcFKTH16SVOyux/oYyT
	E01cE2xT+XYSKfDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 15D4813587;
	Tue, 26 Mar 2024 09:23:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Ed8ABCKUAmZtBAAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 26 Mar 2024 09:23:46 +0000
Date: Tue, 26 Mar 2024 10:23:45 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v2 02/18] nvme/rc: silence fcloop cleanup
 failures
Message-ID: <y7n4krsyu2trzaiv3kjyesuvu7g7vonc2akcjv3swl7inyxpeu@ooe7ubijthib>
References: <20240322135015.14712-1-dwagner@suse.de>
 <20240322135015.14712-3-dwagner@suse.de>
 <nc33lqabldktsxsdrmnjrpdagp2vnqid3vr5u4r2xwf6cuhjmv@cgvtqfzcrxds>
 <bl3civ2dzinzrmlb5mg4lpkutwfb7d6sx5a6qtiequj2x44vvm@d72cun3ezvkq>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bl3civ2dzinzrmlb5mg4lpkutwfb7d6sx5a6qtiequj2x44vvm@d72cun3ezvkq>
X-Spamd-Result: default: False [-2.22 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.998];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.42)[91.06%]
Authentication-Results: smtp-out1.suse.de;
	none
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_022349_071587_E808F1E6 
X-CRM114-Status: GOOD (  10.10  )
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

On Tue, Mar 26, 2024 at 08:39:18AM +0000, Shinichiro Kawasaki wrote:
> On Mar 25, 2024 / 19:27, Daniel Wagner wrote:
 >   (echo "foo" > file) 2>/dev/null
> >   {echo "foo" > file} 2>/dev/null
> > 
> > I suppose we want to keep it simple and just add the brackets around the echos.
> 
> Both has pros and cons: added brackets are simpler, while file existence check
> is more readable, IMO. I think either way is fine.

I see, so let's go with the existence check, I also find it simpler to
read (understand).

