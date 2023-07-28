Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F01AC001DE
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Jul 2023 08:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uAWKzqRAwM9WVlQh+HXjiVoc+9cES0KQ8DeLucaBVgg=; b=nvJyxmqtCvS0u/jbuFAZigGFsp
	JgqMzjGI/tctvsw6Ci9H9/ChnO7D37zei1aEx6yLTTHCNkQjBddZWH/lIB3Pra2yLDblADoxJRHVl
	g+wWyCtjOKw0MGyFIvmgXzZG0QoanCwoZmshBeOQI1dihmvHY8WNMhdWUtU4nXa6YcwHAIxXpSDLu
	PT6/HrR3jLKqBEnwsUA9NQfuGWFBmqa18qv6F8U1/vUrJTKt5Qp742MhWdM5R94ZLjCr9NPshnXzO
	ehyXzyhlrBbolp6aO83z6DoGfcOzhp0chloDXmL+FtNglxSn5pN4MLMlFtZzCNW5fvtU3homsk43n
	eGaUJqEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qPJG4-002UOL-0R;
	Fri, 28 Jul 2023 08:55:36 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qPJG1-002UMY-0T
	for linux-nvme@lists.infradead.org;
	Fri, 28 Jul 2023 08:55:34 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 801261F854;
	Fri, 28 Jul 2023 08:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1690534528; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uAWKzqRAwM9WVlQh+HXjiVoc+9cES0KQ8DeLucaBVgg=;
	b=fnJ3zXeJfj3bLH3le16xDYUsOQ79o2TzjmECfwDbGR2i2gJ4lN7aph8XqyEcpjSdlwl6wA
	ZgTlxrRLGTOC8EYB7PAyL+QVHQqITh1pY0x+qOoonIVXl6AM56K0ia3s1BVk2oaEQPbrpv
	1lliJKDjRh1ysVQ97gwSoLU90kdjILk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1690534528;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uAWKzqRAwM9WVlQh+HXjiVoc+9cES0KQ8DeLucaBVgg=;
	b=D6SUtbiY3lYQSIKNFOL90txpnKb4VrD41xFd1UFe3P8ZGgA6s0uJYHFicmtlOX54XL0sNz
	pgPJd5qjEBkevsBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6F4DD133F7;
	Fri, 28 Jul 2023 08:55:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id fw0hG4CCw2RidwAAMHmgww
	(envelope-from <dwagner@suse.de>); Fri, 28 Jul 2023 08:55:28 +0000
Date: Fri, 28 Jul 2023 10:55:27 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, 
	Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>, 
	James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH blktests v1 11/11] nvme: Add explicitly host to
 allow_host list
Message-ID: <tgchxlramrmairlqojfw5tim2hqgvwu3iug532lyu2lzrjk4pw@geegddpo3zqw>
References: <20230726124644.12619-1-dwagner@suse.de>
 <20230726124644.12619-12-dwagner@suse.de>
 <4eztk7hhup2le6nqd4u4udvdrek3sngrljfr22b7rnhaqcr4of@aoe2j52jfwzb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4eztk7hhup2le6nqd4u4udvdrek3sngrljfr22b7rnhaqcr4of@aoe2j52jfwzb>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230728_015533_331363_8A27A85B 
X-CRM114-Status: GOOD (  17.67  )
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

On Fri, Jul 28, 2023 at 08:15:45AM +0000, Shinichiro Kawasaki wrote:
> On Jul 26, 2023 / 14:46, Daniel Wagner wrote:
> > Only allow to connect to our setup target with the correct hostnqn.
> > 
> > Thus we have to explicitly add the test hostnqn to the test subsysnqn
> > allow_host list.
> 
> [...]
> 
> > --- a/tests/nvme/030
> > +++ b/tests/nvme/030
> > @@ -28,6 +28,7 @@ test() {
> >  
> >  	_create_nvmet_subsystem "${subsys}1" "$(losetup -f)"
> >  	_add_nvmet_subsys_to_port "${port}" "${subsys}1"
> > +	_create_nvmet_host "${subsys}1" "${def_hostnqn}"
> >  
> >  	genctr=$(_discovery_genctr)
> >  
> > @@ -36,13 +37,13 @@ test() {
> >  
> >  	genctr=$(_check_genctr "${genctr}" "adding a subsystem to a port")
> >  
> > -	echo 0 > "${NVMET_CFS}/subsystems/${subsys}2/attr_allow_any_host"
> > +	_add_nvmet_allow_hosts "${subsys}2" "${def_hostnqn}"
> >  
> > -	genctr=$(_check_genctr "${genctr}" "clearing attr_allow_any_host")
> > +	genctr=$(_check_genctr "${genctr}" "adding host to allow_hosts")
> >  
> > -	echo 1 > "${NVMET_CFS}/subsystems/${subsys}2/attr_allow_any_host"
> > +	_remove_nvmet_allow_hosts "${subsys}2" "${def_hostnqn}"
> >  
> > -	genctr=$(_check_genctr "${genctr}" "setting attr_allow_any_host")
> > +	genctr=$(_check_genctr "${genctr}" "removing host from allow_hosts")
> >  
> >  	_remove_nvmet_subsystem_from_port "${port}" "${subsys}2"
> >  	_remove_nvmet_subsystem "${subsys}2"
> 
> The hunk above looks different from other changes. Is it changing test
> content slightly to meet request by Max? If so, it would be good to note
> in the commit message.

I should have explained this change in the commit message. When we use
allowed_hosts, the attr_allow_any_host feature is disabled and thus has no side
effects like updating the genctr. This makes the test fail. I opted to use
_[add|remove]_nvmet_allow_hosts to trigger the same side effect. While at it, I
also updated the logging info.

