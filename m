Return-Path: <SRS0=yJEp=HU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F195C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Feb 2021 16:37:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2CAD64E33
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Feb 2021 16:37:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2CAD64E33
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xtH2YmnEyfn4m653bJ0WhYjzstGrf8hD/Lf90fEZQmM=; b=vJX+hgnhD5Iehhy7kvdwcJKHt
	ve/c5C5Ddi1vCtSj0lOXqKZzYX8hyWmoiiumJ1ZgCszfDlZEEV6II7gPj1rmtVdpdxgHxoReYmtqb
	UbHDGaGTPsFokiexW6qEedm92pfrwkwnDV3hI8PcQULZvg7k9CxLL6tPm44mf9qpZV/vNFNqJ/MfD
	HLPLgRTVzMU+Rxjfqo7Wx7H2g5EHDQRj5La5/6dkTTiQoxxk2xKHpK9/k39eFQSh5+fp/hNfYvs8X
	1hO5AAhfkXqrrBgFcS5vj4sn3TMxXss1cWspKzkYEQ1NBVb5XTE79SuS46cOYZ9MWvPIERsFJlUZj
	U9+HDwIBg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lCmII-00029F-6e; Thu, 18 Feb 2021 16:36:46 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lCmIE-00028A-Ji
 for linux-nvme@lists.infradead.org; Thu, 18 Feb 2021 16:36:43 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A16D64E33;
 Thu, 18 Feb 2021 16:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1613666201;
 bh=eYUKdXDICnFa+i1wPpTdlsZ+SDO2K8Nk+deIkwCTNTY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HA1Ogt2wvWEDe1wqrlOV98LF8Pyy1YC24G/eOsSBccam5D8yNDgca4rzFptzi0/7m
 fky6uzL56PKZHa/momevLyUXxOYaS5mf2ONZKCrBXK9UfgehXgTkF23/6tFbmoB6La
 hf5D+/mo9oYhBPwrE+oHYm8k5BHpVrvny0KC9kn9TjCmUqEfdPQ0L7Sfni/qoRM+os
 zSQQ5rxWwfgaMjvqOrtFyOU8UUnBeSfdS5Az6zyAVoJYdJL/Im95d6uHqBb1Nolx5g
 fn1Qzw/OBYoSfQAH7eZl9nMI4cCY8o7/fy54Lb6BrLRJA//DXvuo2jtvdWOOt9jqdR
 JPtf+ovc2hh/w==
Date: Fri, 19 Feb 2021 01:36:35 +0900
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] fabrics: permit kato int argument for discovery
 controllers
Message-ID: <20210218163635.GA30146@redsun51.ssa.fujisawa.hgst.com>
References: <20210218094642.5616-1-marting@netapp.com>
 <9a37a05a-4af0-59d2-5b6b-874b71940de7@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9a37a05a-4af0-59d2-5b6b-874b71940de7@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210218_113642_816147_4B8F14FE 
X-CRM114-Status: GOOD (  15.46  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Martin George <marting@netapp.com>, Martin George <martinus.gpy@gmail.com>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Feb 18, 2021 at 05:29:27PM +0100, Hannes Reinecke wrote:
> On 2/18/21 10:46 AM, Martin George wrote:
> > Given discovery controllers can now accept integer arguments
> > for kato, permit the same in build_options().
> > 
> > Signed-off-by: Martin George <marting@netapp.com>
> > ---
> >   fabrics.c | 5 ++---
> >   1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fabrics.c b/fabrics.c
> > index 1880a5d..9cfe26a 100644
> > --- a/fabrics.c
> > +++ b/fabrics.c
> > @@ -896,9 +896,8 @@ static int build_options(char *argstr, int max_len, bool discover)
> >   	    (!discover &&
> >   	      add_int_argument(&argstr, &max_len, "queue_size",
> >   				cfg.queue_size, false)) ||
> > -	    (!discover &&
> > -	      add_int_argument(&argstr, &max_len, "keep_alive_tmo",
> > -				cfg.keep_alive_tmo, false)) ||
> > +	    add_int_argument(&argstr, &max_len, "keep_alive_tmo",
> > +				cfg.keep_alive_tmo, false) ||
> >   	    add_int_argument(&argstr, &max_len, "reconnect_delay",
> >   				cfg.reconnect_delay, false) ||
> >   	    add_int_argument(&argstr, &max_len, "ctrl_loss_tmo",
> > 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> 
> Martin, you probably have to resend it via a pull request to the github
> repository.

Not necessary, I am totally okay with applying these direct from the
mailing list.

Thanks for the review, patch is already applied!

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
