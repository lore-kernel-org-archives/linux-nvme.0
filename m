Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35CE7C54798
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Mar 2024 11:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RCpNkeO38Vc6PYS+hznBwEQHFD/PUdYW47ZidYaWvc8=; b=N9vRrJEsK9C5TixjlzPeGruQXH
	ZhXIR12rdswymHXFymf6t+RqsG5Mg3JYwTC949QubQUGfLO7omcMDZTyfOvr/lMhz8sZfBrupPPDb
	kiR/D/TpNQx2C7ba8WHBqUJ7VvyXHbU8Qs6uUH4tEc24NxGPUaKljQF5IJUa3avNJT4PSlg2SKcvL
	dZpHwqCdDhR6tI/k0S5BYVC3S/1BH5nXiKYesB/uxDrRbSeG27Nep2ekOn/tPP0aXUDawp615LlIH
	1E1JA8XnoEso2Tj9ekpBwI0gqejN3jPBe5pmAvGAEXms1HmTyh1bq8vLARGcPOVitAwO9vK/zb9cA
	A/Nvav0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhSon-0000000DIPQ-24E4;
	Tue, 05 Mar 2024 11:18:45 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhSoh-0000000DINq-3Fyw
	for linux-nvme@lists.infradead.org;
	Tue, 05 Mar 2024 11:18:43 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 96C9176AF8;
	Tue,  5 Mar 2024 11:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709637517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RCpNkeO38Vc6PYS+hznBwEQHFD/PUdYW47ZidYaWvc8=;
	b=NpxF39sYIKrZNG2og1c7PQ2WbV9zLfnPlghYJIJ6VlSuCuw7N2xdc2q1P/AYYRwTvKn6aM
	uJ1N1BxWSpzwKbzXRBHh0K+STPBM9fcnsg+dB2XJNseUUltnlzXnb2/fZ8xSQxuDLGkv+w
	W6LZmBa08BgYCdjGPjiqXKtC7EY2BM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709637517;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RCpNkeO38Vc6PYS+hznBwEQHFD/PUdYW47ZidYaWvc8=;
	b=TVacvBjiJXGSDpQPyd0O1D3nzt7WdYopgMgRP1Y8Xefm0KcI9lRHvUKj3YJdQ119GPEUN5
	eTpwd7eCLe+hfgDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709637517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RCpNkeO38Vc6PYS+hznBwEQHFD/PUdYW47ZidYaWvc8=;
	b=NpxF39sYIKrZNG2og1c7PQ2WbV9zLfnPlghYJIJ6VlSuCuw7N2xdc2q1P/AYYRwTvKn6aM
	uJ1N1BxWSpzwKbzXRBHh0K+STPBM9fcnsg+dB2XJNseUUltnlzXnb2/fZ8xSQxuDLGkv+w
	W6LZmBa08BgYCdjGPjiqXKtC7EY2BM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709637517;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RCpNkeO38Vc6PYS+hznBwEQHFD/PUdYW47ZidYaWvc8=;
	b=TVacvBjiJXGSDpQPyd0O1D3nzt7WdYopgMgRP1Y8Xefm0KcI9lRHvUKj3YJdQ119GPEUN5
	eTpwd7eCLe+hfgDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8049213466;
	Tue,  5 Mar 2024 11:18:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id MU0AH43/5mVxEQAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 05 Mar 2024 11:18:37 +0000
Date: Tue, 5 Mar 2024 12:18:36 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
	Keith Busch <kbusch@kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests v1 0/2] extend nvme/045 to reconnect with
 invalid key
Message-ID: <p5xkwz6i2lfy2a65pbpq3en6wh57y75qcoz3y3eio3ze5b7cm3@zgfn5so4yuig>
References: <20240304161303.19681-1-dwagner@suse.de>
 <2ya2o6s6lyiezbjoqbr33oiae2l65e2nrc75g3c47maisbifyv@4kpdmolhkiwx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ya2o6s6lyiezbjoqbr33oiae2l65e2nrc75g3c47maisbifyv@4kpdmolhkiwx>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NpxF39sY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=TVacvBji
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.01 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCPT_COUNT_FIVE(0.00)[5];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: 96C9176AF8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240305_031840_055859_17968CAF 
X-CRM114-Status: GOOD (  25.27  )
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

On Tue, Mar 05, 2024 at 09:44:45AM +0000, Shinichiro Kawasaki wrote:
> On Mar 04, 2024 / 17:13, Daniel Wagner wrote:
> > The is the test case for
> > 
> > https://lore.kernel.org/linux-nvme/20240304161006.19328-1-dwagner@suse.de/
> >
> > 
> > Daniel Wagner (2):
> >   nvme/rc: add reconnect-delay argument only for fabrics transports
> >   nvme/048: add reconnect after ctrl key change
> 
> I apply the kernel patches in the link above to v6.8-rc7, then ran nvme/045
> with the blktests patches in the series. And I observed failure of the test
> case with various transports [1]. Is this failure expected?

If you have these patches applied, the test should pass. But we might
have still some more stuff to unify between the transports. The nvme/045
test passes in my setup. Though I have seen runs which were hang for
some reason. Haven't figured out yet what's happening there. But I
haven't seen failures, IIRC.

I am not really surprised we seeing some fallouts though. We start to
test the error code paths with this test extension.

> Also, I observed KASAN double-free [2]. Do you observe it in your environment?
> I created a quick fix [3], and it looks resolving the double-free.

No, I haven't seen this.

> sudo ./check nvme/045
> nvme/045 (Test re-authentication)                            [failed]
>     runtime  8.069s  ...  7.639s
>     --- tests/nvme/045.out      2024-03-05 18:09:07.267668493 +0900
>     +++ /home/shin/Blktests/blktests/results/nodev/nvme/045.out.bad     2024-03-05 18:10:07.735494384 +0900
>     @@ -9,5 +9,6 @@
>      Change hash to hmac(sha512)
>      Re-authenticate with changed hash
>      Renew host key on the controller and force reconnect
>     -disconnected 0 controller(s)
>     +controller "nvme1" not deleted within 5 seconds
>     +disconnected 1 controller(s)
>      Test complete

That means the host either successfully reconnected or never
disconnected. We have another test case just for the disconnect test
(number of queue changes), so if this test passes, it must be the
former... Shouldn't really happen, this would mean the auth code has bug.

> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index f2832f70e7e0..4e161d3cd840 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -221,14 +221,10 @@ static int ns_update_nuse(struct nvme_ns *ns)
>  
>  	ret = nvme_identify_ns(ns->ctrl, ns->head->ns_id, &id);
>  	if (ret)
> -		goto out_free_id;
> +		return ret;

Yes, this is correct.
>  
>  	ns->head->nuse = le64_to_cpu(id->nuse);
> -
> -out_free_id:
> -	kfree(id);
> -
> -	return ret;
> +	return 0;
>  }
>

I think you still need to free the 'id' on the normal exit path though

If you have these patches applied, the test should pass. But we might
have still some more stuff to unify between the transports. The nvme/045
test passes in my setup. Though I have seen runs which were hang for
some reason. Haven't figured out yet what's happening there. But I
haven't seen failures.

