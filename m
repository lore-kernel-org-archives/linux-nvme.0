Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B69F7C6FD18
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Apr 2023 14:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bnQHzRr0LZD/gqua06NrEUO3XOVObpoFGxZ813nFw+8=; b=bDGLiSm4RXSxbQu0g2SBEmRZva
	euJ+V2GrHKprTAhzUDjZIgzTJoUjMm5z3m+Z3Lus4RZ2BkHre7RTUlotxLgdq8cA+qPeY66eLzVvu
	ulpMt6zml3PY9F1XNhpvxlvzbPBwoncXXWngBrdHPMSRW66CY+dXvkcTWIjsppA0uExkH+pR/rAAn
	kDn/eZu1r0Q29zVDET+ITloHOS1QP6OXpqNZ34k09efRVovFPCqqdMJi9pqxxFF5q6f/e0cd7zo7h
	T67yPvdWHZgC7l3Gi/x+S3S1US3DTVQib9uWhfz7KMdMTiYcbx1aGkDXptkxzxK3niHWcV2EUWTV+
	OLWdqmyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pomHw-002Qmu-39;
	Tue, 18 Apr 2023 14:26:32 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pomHu-002Qlm-20
	for linux-nvme@lists.infradead.org;
	Tue, 18 Apr 2023 14:26:31 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6550C21A97;
	Tue, 18 Apr 2023 14:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681827987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bnQHzRr0LZD/gqua06NrEUO3XOVObpoFGxZ813nFw+8=;
	b=U48JVbzbUzPtUcReF2MIZHKVGHSSHDpQscfCDfNI5InpsGA7r48mpHWiQFudHm40r2Smrt
	Gi9AiRAIZNnz8mzPrjRKMFk+m68EkeKcZ9WDNpcALmgVrs3R+jKOu5hzIm76eHbSbdZWyU
	DCCzUmM6sAyFVZerVLZ8dunMxb/GgIU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681827987;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bnQHzRr0LZD/gqua06NrEUO3XOVObpoFGxZ813nFw+8=;
	b=hg4mAQJuxINaFtIAUcsYNVqGdl2aYVpMtTjEvkH6rGyXCBgBwQYSykzxiuQnwn0nF0X82k
	kMINp1OZTs6lwIBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 561AF13581;
	Tue, 18 Apr 2023 14:26:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id XzcBFZOoPmRRWwAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 18 Apr 2023 14:26:27 +0000
Date: Tue, 18 Apr 2023 16:26:26 +0200
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Martin Belanger <Martin.Belanger@dell.com>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH v3 0/4] nvmet-fcloop: unblock module removal
Message-ID: <lum3oejitdb36ox2ec736kc73hzlmmnyr7jtg23wfa4t5slkvs@hm4u6xfnatcp>
References: <20230418130159.11075-1-dwagner@suse.de>
 <nlogr5rdxqvilsz4iolktfpdvflvvithwaoa3vrx2fsjqlho4q@4upw7jq3aem2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nlogr5rdxqvilsz4iolktfpdvflvvithwaoa3vrx2fsjqlho4q@4upw7jq3aem2>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230418_072630_801788_966EDC55 
X-CRM114-Status: GOOD (  10.54  )
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

On Tue, Apr 18, 2023 at 03:43:22PM +0200, Daniel Wagner wrote:
> On Tue, Apr 18, 2023 at 03:01:55PM +0200, Daniel Wagner wrote:
> > nvme/041 (Create authenticated connections)                  [failed]
> > nvme/042 (Test dhchap key types for authenticated connections) [failed]
> > nvme/043 (Test hash and DH group variations for authenticated connections) [passed]
> > nvme/044 (Test bi-directional authentication)                [failed]
> > nvme/045 (Test re-authentication)                            [passed]
> 
> I suppose these should be disabled for fc as all this is tcp specific.

After a fresh reboot the deleter tport, lport and rport trouble is back...

nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  10.265s  ...  10.365s
tests/nvme/rc: line 198: /sys/class/fcloop/ctl/del_target_port: No such file or directory
tests/nvme/rc: line 190: /sys/class/fcloop/ctl/del_local_port: No such file or directory
tests/nvme/rc: line 182: /sys/class/fcloop/ctl/del_remote_port: No such file or directory

