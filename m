Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BBCDC76196
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Apr 2023 06:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HEuH/YkOBOinF1cO2uWYOkFM8PNnCrP0rdn4xwT5/74=; b=mE4q06GTPqlQXdkeJzli+v/Mh2
	yEUfWjudNQgd5kWZ2fSL5bixDUSlsJFoqJdkb/cYdtrN3Dfp04Kjp61RUZm+GVVDYh3ZcaBrGZmUG
	ToN+TCj1aJE8pdK4tLCdlymKTGjRVZeU2t4sDUAPhpu/j1GQcppwVevPrZ5S82oPi1tA0DWda1jSf
	jfYZtp/Haalb9DwxLhXWlwPzhketlOJX0pgmBQlpfCTWUvn+u9O64HjI2pVoGFZvWJ2bPze8jxbBI
	4paRaD5XQoZZsxxNuQZt+GtePIwEHkLMlLxBpX9/qnQ1fQOHxyaO1h62eKbQ1eoCpSJFtWav9HtP8
	mVvs8qAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pkIr8-006R63-1S;
	Thu, 06 Apr 2023 06:12:22 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pkIr6-006R5Q-0c
	for linux-nvme@lists.infradead.org;
	Thu, 06 Apr 2023 06:12:21 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7F7EC22591;
	Thu,  6 Apr 2023 06:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1680761535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HEuH/YkOBOinF1cO2uWYOkFM8PNnCrP0rdn4xwT5/74=;
	b=CkW+mlZZ57yZ9Qn4hRM+IE6aTUShGtpL1Der3Bv5pM0cdh1+nuj9OHJbeMGQgBkzMLFEhd
	RemidBnMjk9xrepeLsoaNUa0Ko4I26DH3SsjUpqYbY5OWv9OziQEFEdIwd0YOf9+45EPD0
	6z/UitWKp7FbVUPeQBQ3PsWCy0EKmWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1680761535;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HEuH/YkOBOinF1cO2uWYOkFM8PNnCrP0rdn4xwT5/74=;
	b=WUenku246MDvCLBqqQ0P5JzbF1T+196qFpqZhf2VW6OuCU9Zzc8ARLJRZe1sCDrxhWRvWM
	b7Mg0Buus+gN+ABQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7053F133E5;
	Thu,  6 Apr 2023 06:12:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id P3BkG79iLmS+IAAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 06 Apr 2023 06:12:15 +0000
Date: Thu, 6 Apr 2023 08:12:14 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, 
	James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH blktests v5 1/4] nvme/rc: Add setter for attr_qid_max
Message-ID: <2w3ki4ntl5m2farwokvepbgtcvd5piywv3cmdyzp4s6su6fngc@55wsvekrge3c>
References: <20230405154630.16298-1-dwagner@suse.de>
 <20230405154630.16298-2-dwagner@suse.de>
 <9bde6907-20b8-1e19-8b5c-e26f62f2f9e4@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bde6907-20b8-1e19-8b5c-e26f62f2f9e4@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230405_231220_401905_40E643ED 
X-CRM114-Status: GOOD (  14.26  )
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

On Wed, Apr 05, 2023 at 06:39:43PM +0000, Chaitanya Kulkarni wrote:
> this is only used in the testcase patch #4, until we get a second
> user move it to patch #4 ?
> 
> in case this was already discussed and decision made to keep it
> in rc, please ignore this comment.

There wasn't any decision on this topic. I was not sure if I should put it in rc
but I saw there are already _set_nvmet_*() functions. Thus I came to the
conclusion it makes maintaining these helper function simpler in future because
they are all in one file. If someone touches all _set_nvmet_*() function this
one is not forgotten.

The same goes for the other rc helpers (patch 1-3).

That said, I really do not insit in putiting in rc.

