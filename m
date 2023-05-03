Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDEEBC77B78
	for <linux-nvme@archiver.kernel.org>; Wed,  3 May 2023 08:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZKOYF8DaplIKH+Sile2V6/F1QE14apRzKlMxxSUuStg=; b=OBAMMJDPLi//7rcNbRML8+/Gxr
	TsupPC+x2n3WcHLws0qRzK9t+By49VugkBcbP8XWWFofS1hkHvFgyeN4TM7YSHWsjvinVJ8Uth45j
	HsRmWHUkMe16KddexjXp6l1Xzxz7fpJpKiNnHYbWIakgZgQpQ/ZFhvEnBodurD8J6/giPckSPNcCP
	TUAnBX8RaPsqT68Cy18CsLpGzUDnJ5AonZdL6Z0p8O1KW4oR+wOA2BLuqioQKf4wQ54VNeMInj2WT
	8nDIfgQg64NLFMm8GcEcX4PROS2C8ClIi7wmoWePELd4Q+o89nPDsEG0/tsidxwYcBjZxfExBUiEX
	9+rGZCdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pu7bC-003nam-36;
	Wed, 03 May 2023 08:12:30 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pu7b9-003nYp-2v
	for linux-nvme@lists.infradead.org;
	Wed, 03 May 2023 08:12:29 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 449DC200BE;
	Wed,  3 May 2023 08:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1683101546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZKOYF8DaplIKH+Sile2V6/F1QE14apRzKlMxxSUuStg=;
	b=gaouWjGNWRqDvWg25oqoPMDNtskfrHp8iYpILM8xPKeegLZPHAu0Pg87HpJc4LDVQMJFgp
	f4M2erMXrDKP38DHqFptc9lHB55t2bp6XDn43TkCwKejaFqxzkCMPpxlqFUJEoDg3tbz5A
	t63F0xrnPFYP0VWucP64BEIfjEA4b5Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1683101546;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZKOYF8DaplIKH+Sile2V6/F1QE14apRzKlMxxSUuStg=;
	b=p0GnPf1FK0N/lBj6yU5ED0jN0UvZ+R2CgRD+llkGoncTHBHcxeL42DNULmE+JbiHm+GUif
	DSUIJhbLtti9xDDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3605313584;
	Wed,  3 May 2023 08:12:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id S40nDWoXUmQSZwAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 03 May 2023 08:12:26 +0000
Date: Wed, 3 May 2023 10:12:25 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH blktests v2 1/2] nvme-rc: Cleanup fc ports in reverse
 order
Message-ID: <cavn776zwjjiefckoeg4igobtzlmxrp6et253hmakruvcyqxec@jvxrkwlw4ewe>
References: <20230419084757.24846-1-dwagner@suse.de>
 <20230419084757.24846-2-dwagner@suse.de>
 <a58b526d-2e29-6c4a-e277-b684f98636eb@grimberg.me>
 <2zcb7p4hgdeuj4wud3ztizodqt3lu44ktewusaxot5jn3ifrlx@x6hha62vjrqu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2zcb7p4hgdeuj4wud3ztizodqt3lu44ktewusaxot5jn3ifrlx@x6hha62vjrqu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230503_011228_086944_24567E66 
X-CRM114-Status: GOOD (  26.69  )
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

On Sun, Apr 30, 2023 at 10:07:06AM +0000, Shinichiro Kawasaki wrote:
> On Apr 19, 2023 / 12:41, Sagi Grimberg wrote:
> > 
> > 
> > On 4/19/23 11:47, Daniel Wagner wrote:
> > > We need to free the resources in the opposite order as we allocate them.
> > > 
> > > Signed-off-by: Daniel Wagner <dwagner@suse.de>
> > > ---
> > >   tests/nvme/rc | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/tests/nvme/rc b/tests/nvme/rc
> > > index b44239446dcf..ec0cc2d8d8cc 100644
> > > --- a/tests/nvme/rc
> > > +++ b/tests/nvme/rc
> > > @@ -204,10 +204,10 @@ _cleanup_fcloop() {
> > >   	local remote_wwnn="${3:-$def_remote_wwnn}"
> > >   	local remote_wwpn="${4:-$def_remote_wwpn}"
> > > -	_nvme_fcloop_del_rport "${local_wwnn}" "${local_wwpn}" \
> > > -			       "${remote_wwnn}" "${remote_wwpn}"
> > >   	_nvme_fcloop_del_tport "${remote_wwnn}" "${remote_wwpn}"
> > >   	_nvme_fcloop_del_lport "${local_wwnn}" "${local_wwpn}"
> > > +	_nvme_fcloop_del_rport "${local_wwnn}" "${local_wwpn}" \
> > > +			       "${remote_wwnn}" "${remote_wwpn}"
> > >   }
> > >   _cleanup_nvmet() {
> > 
> > Does this fix a bug? if it does, than it should probably be documented
> > that there is a driver bug because userspace teardown ordering should
> > not trigger a driver bug.
> 
> I think this fixes a bug, and it can be a left work to add another new test
> case. Daniel, what do you think?

Initially I thought this fixes a bug when unloading the fc module. But this
change was just really fixing. So stringly speaking I don't think it really
workarounds a bug in the fc module unloading. I left the change in the series as
I though it makes sense to do the operation in reverse order.

So in short it's really just a cosmetic fix for blktests.

