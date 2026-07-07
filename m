Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70CDFC43458
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jul 2026 13:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IuEPD0jWts4svd2xAWZK0uyVgL/6lCoJlkeVPxbPmsM=; b=EFQ4e1Frw2V+rYZk8zWmQNnTxY
	UenrM1tQ/uX5cCYpbujD+INX65ZUMHHFegnQp1QMjAYJ3Ev/mTyTWcZlU6GL9TWLgQnQi8jNiS/hr
	0N2BrfWwutWVuOV0NZm/aPI1cRzDHLK2Mx2HZcxFXNkzZWmh0ofU+jb8WhDdTFTBa/DbGusqWprub
	KmSBvu/nLQQXRkTkRHkzJzenx5ka+1BauedHIPgNwVOry62O7W0gJ79dLh6CZYA2HydRVLpebxqvR
	LQvn74att6J67wLv7Q1ZA0+jVbE3BX1pzmLpC3Q/m3kAhptya+luVmJVpiQJWrwI4HkprFjYRvb/5
	f7UDIgjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wh5zC-0000000F4P0-1Blp;
	Tue, 07 Jul 2026 13:37:18 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wh5z9-0000000F4Na-3ipH
	for linux-nvme@lists.infradead.org;
	Tue, 07 Jul 2026 13:37:17 +0000
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D64CB75BCA;
	Tue,  7 Jul 2026 13:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783431432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IuEPD0jWts4svd2xAWZK0uyVgL/6lCoJlkeVPxbPmsM=;
	b=RVjUoEBpG7OVPQndTscLgxLkZoD3QX5lSOTequ1ugX8PgbONdnan4AqbOvN6TMfVqvffb5
	syuCYRYMl/KZTXW1gwqASpY/4MrWZW8Qq+iGBfk3DqjV10l/xmum0HmnWvQDtegRC6tV92
	h/Cutg/ZwEm6Dw0020awi848Tj4ElvA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783431432;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IuEPD0jWts4svd2xAWZK0uyVgL/6lCoJlkeVPxbPmsM=;
	b=vajsEHkGgfJK7Y97WXZ1i3FzjxyrS0cmx4ijr6y3CNKFsQJhnW8nT/y6sDyZ7o+v5qSWxO
	MXiGvIGrQUv6uRCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VwMgytJ9;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6nBXDHkH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783431431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IuEPD0jWts4svd2xAWZK0uyVgL/6lCoJlkeVPxbPmsM=;
	b=VwMgytJ9XGoOx6sH7R9euEw3eOj35eLmeso2lG0a+P73jkIHz3AOL9tG3teh9fvaZDuRbO
	IbQzzLoBmXDKTdTROiQP8oQg6Ci/01Q/LjOewMb+oGe6gBJyIbMYcPW2//m6xL0gLXzSNb
	9T3J2MRozQbkp0oaKHYvsC159wLmHSU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783431431;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IuEPD0jWts4svd2xAWZK0uyVgL/6lCoJlkeVPxbPmsM=;
	b=6nBXDHkH01w89jImPceMJi7NAbWtd/CTwnE9tCo5AWl76riqOWm6rLWjr4m9rsZzZJQB1K
	QPU//LwbgQhrq4CA==
Date: Tue, 7 Jul 2026 15:37:09 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Daniel Wagner <wagi@kernel.org>
Subject: Re: [PATCH] When kmodpy is not available call kmod binary directly
Message-ID: <ak0BBYBYdrLBh63I@kunlun.suse.cz>
References: <20250321105915.8971-1-msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321105915.8971-1-msuchanek@suse.de>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.51 / 50.00];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	BAYES_HAM(-1.99)[94.97%];
	ONCE_RECEIVED(1.20)[];
	HFILTER_HELO_IP_A(1.00)[kunlun.suse.cz];
	NEURAL_HAM_LONG(-1.00)[-0.997];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[kunlun.suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spamd-Bar: +++
X-Rspamd-Queue-Id: D64CB75BCA
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260707_063716_090485_97A7C7C5 
X-CRM114-Status: GOOD (  17.57  )
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

On Fri, Mar 21, 2025 at 11:59:10AM +0100, Michal Suchanek wrote:
> kmodpy is an unmaintained project. Python is not really good at
> backwards compatibility. With the upstream project not keeping up with
> python churn using the library is a maintenance burden.
> 
> nvmet does not use the python library in any substantial way, it only
> loads a module once. This can be easily accomplished without any library
> using the modprobe tool directly.

Forgot

Signed-off-by: Michal Suchanek <msuchanek@suse.de>

> ---
>  nvmet/nvme.py | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/nvmet/nvme.py b/nvmet/nvme.py
> index 59efdb5b7c1b..397f103abcdb 100644
> --- a/nvmet/nvme.py
> +++ b/nvmet/nvme.py
> @@ -256,9 +256,20 @@ class Root(CFSNode):
>              # Try the ctypes library included with the libkmod itself.
>              try:
>                  import kmod
> -                kmod.Kmod().modprobe(modname)
> -            except Exception as e:
> -                pass
> +
> +                try:
> +                    kmod.Kmod().modprobe(modname)
> +                except Exception as e:
> +                    pass
> +            except ImportError:
> +                # Try the binary specified in /proc
> +                try:
> +                    kmod = None
> +                    with open('/proc/sys/kernel/modprobe', 'r') as f:
> +                        kmod = f.read().rstrip()
> +                    os.system(kmod + ' ' + modname)
> +                except Exception as e:
> +                    pass
>  
>      def _list_subsystems(self):
>          self._check_self()
> -- 
> 2.47.1
> 

