Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C365C10F16
	for <linux-nvme@archiver.kernel.org>; Mon,  6 May 2024 14:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XA9W9f1SBSqLQu94gvj/Mh29w+9LvY09mBD6fBmg2As=; b=xG3Sq7mt3+ktWlz6iRQDIKcVdC
	IeJtOXY4OuGC+zaNie7bfeMfKCuvQxyQpfGvOE4MynQ6j54CEaaWx5IR4QCgdVQZDhAlCHRRxRNuT
	7P3UE2aFHpKSs5fRoPwahhDx0dcUMt4w3HxuWUxUwBer0NuP7KOUEAQAfARHkPXtVOIE1Wg0HxXov
	TwyU9yNQ5qLtLkIRraT6jer4jytvWV/5s5eTCiLnVJZPVN8P/6/lQO1b8W0H98sx1l25Sl7T80VHl
	Ob1hAfX+u1+zO3gzbW9gYLDOT5EMS3kRtMQzFwOXUpoN2mzS9KOg7brAplYBaKq7L1awhKVDyIl6w
	UNxAnUWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3zeB-00000007kBU-2jHi;
	Mon, 06 May 2024 14:48:55 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3ze6-00000007k9p-3s60
	for linux-nvme@lists.infradead.org;
	Mon, 06 May 2024 14:48:54 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D9DC8384DE;
	Mon,  6 May 2024 14:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715006927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XA9W9f1SBSqLQu94gvj/Mh29w+9LvY09mBD6fBmg2As=;
	b=Qk1dslLFITd+O02g8p12Ft1KcwiQPGH8+YYOO49rSAg227qRPiF6anVCOvRYy1+dz1TIcZ
	sEj223RLDlv3bQdrtxU6vxQT8a2Fp5kGFpHGGo17zCYe5NJpaBCaSmwZVSmHTManX7K7Jm
	bM40iZhQ3sEM3QUXRwHWAbWIDtcrJ0Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715006927;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XA9W9f1SBSqLQu94gvj/Mh29w+9LvY09mBD6fBmg2As=;
	b=PT7rsUoPrw7ypD+0y6Z1qG7em8CT954qHyl3QlvsGuB3YcKS6kpfixH8szkXVvEPR7rs3+
	4E2kL0V0ptu5XMBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715006926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XA9W9f1SBSqLQu94gvj/Mh29w+9LvY09mBD6fBmg2As=;
	b=pgaEYfvCgh2n39ZoIR6fGHVG+/pIMC037k1is5U0mPyG1LZyPE7t6fpTedBfxK4TeBC7az
	tujoYS6HYpsY1AcnINIPiLz9va/hzScDefgrg1BvvAzzI/EDUauu9mDWQAALVRsKjSpCUp
	odYqpzO0AbuW3KMWucJA8yLXdWJMX2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715006926;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XA9W9f1SBSqLQu94gvj/Mh29w+9LvY09mBD6fBmg2As=;
	b=l0FHoN+jiIz0ljnZaWe+2/DOfHcMQjvThOGIGSDu6XkufAluRu3jCVLP7qcuh1FYX5rY12
	uj5mt1uXu/6WiNBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C68DC13A32;
	Mon,  6 May 2024 14:48:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id c+cDL87tOGbQdgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 06 May 2024 14:48:46 +0000
Date: Mon, 6 May 2024 16:48:46 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	Chaitanya Kulkarni <kch@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH blktests v4 05/17] common/rc: introduce
 _set_combined_conditions
Message-ID: <rouixsltnzjkefrkx7jtg5ynuhrywsjjb2kafzrhtnqcdybffb@4pksg7ykjn3j>
References: <20240504081448.1107562-1-shinichiro.kawasaki@wdc.com>
 <20240504081448.1107562-6-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240504081448.1107562-6-shinichiro.kawasaki@wdc.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240506_074851_145681_400E11AA 
X-CRM114-Status: GOOD (  13.01  )
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

On Sat, May 04, 2024 at 05:14:36PM GMT, Shin'ichiro Kawasaki wrote:
> When the test case has the "set_conditions" hook, blktests repeats the
> test case multiple times. This allows repeating the test changing one
> condition parameter. However, it is often desired to run the test for
> multiple condition parameters. For example, some test cases in the nvme
> test group are required to run for different "transport types" as well
> as different "backend block device types". In this case, it is required
> to iterate over all combinations of the two condition parameters
> "transport types" and "backend block device types".
> 
> To cover such iteration for the multiple condition parameters, introduce
> the helper function _set_combined_conditions. It takes multiple
> _set_conditions hooks as its arguments, combines them and works as the
> set_conditions() hook. When the hook x iterates x1 and x2, and the other
> hook y iterates y1 and y2, the function iterates (x1, y1), (x2, y1),
> (x1, y2) and (x2, y2). In other words, it iterates over the Cartesian
> product of the given condition sets.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

I learned a bit on bash variable expansion today :)

Looks good.

Reviewed-by: Daniel Wagner <dwagner@suse.de>

