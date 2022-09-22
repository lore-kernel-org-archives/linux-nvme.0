Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1C0C6FA8B
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 08:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kYaoXyL+LaxNVrMzONAvFhzEYM3kzS7CwYSLX9nJFRE=; b=eau2wl8ZvQ17vfl1XiWax1uank
	rpP/Uaow8lfy9LrTJWR6D/0bQP7fJgGAbM83isIY4+f0d4l5Qdh+igVj16rq15NavaKUkquAY2zUA
	e64qH9rf3gjkws3NU6Ws7QJIpIqNKpuFy+YZMmjxk3LrOFyNkQ7mb+5IweYRcwxihNFKIqD+kLQ/Y
	TXUxIzRyNui+Tb3YFTptGMvS0IhDDfKOo8Ch7oE3hKawpDooM9dGnhPKZ20v01CjQ/FA4RvXXPdug
	tDBjLH/OQwYA1Mk8LFBthhe0p4eE5PbrgyBSwpuv3Axg3/NjY6saByn0pjEt2lPXbY6DpheRqT6KE
	5FD+6F3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obHiW-00ECpq-KF; Thu, 22 Sep 2022 08:37:56 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obHiC-00EChn-3q
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 08:37:37 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A882B1F37F;
	Thu, 22 Sep 2022 08:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1663835854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kYaoXyL+LaxNVrMzONAvFhzEYM3kzS7CwYSLX9nJFRE=;
	b=yYSaz+C9u4bVDvsuS5u6SpGAdAEkb/8ZJ852VaHOXsnYhFO8rl/nLFGuwot+IRsvE+fHOb
	Oc6dmbgdlxpAcqksTiVqFWh0BH2loNlRtygjwvhsYlVshAoQfxsQTgbYybh1hDyS3KfrJt
	7HivddykX8D7oz0/2nr5Ss/p13Q3Ojo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1663835854;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kYaoXyL+LaxNVrMzONAvFhzEYM3kzS7CwYSLX9nJFRE=;
	b=7BH4HkDqIh7cy470gHae20X4/b0pORvJxTpbCBZzCo59WviSIQ2bBOsLzpK7lxcf1rvJJ/
	kIvCd3nsCOSPf0DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9B81313AA5;
	Thu, 22 Sep 2022 08:37:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id o7NlJc4eLGPwZgAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 22 Sep 2022 08:37:34 +0000
Date: Thu, 22 Sep 2022 10:37:34 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH v2 3/2 nvme-cli] fabrics: re-read the discovery log page
 when a discovery controller reconnected
Message-ID: <20220922083734.sdt35cmmaxnv74ok@carbon.lan>
References: <20220922081538.13364-1-sagi@grimberg.me>
 <20220922081538.13364-4-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922081538.13364-4-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_013736_364429_34D90AA1 
X-CRM114-Status: GOOD (  12.71  )
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

On Thu, Sep 22, 2022 at 11:15:38AM +0300, Sagi Grimberg wrote:
> When using persistent discovery controllers, if the discovery controller
> loses connectivity and manage to reconnect after a while, we need to
> retrieve again the discovery log page in order to learn about possible
> changes that may have occurred during this time as discovery log change
> events were lost.
> 
> Upon reception of a udev EVENT=rediscover we can kickstart discovery on
> the existing discovery controller device node that generated the event.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

