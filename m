Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54EF5EB64D8
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jun 2023 11:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HHkbLk/cLJhPHRHX27FHhhWp3DrX/nCJGGt+VLR1SzI=; b=whZGJNK0JGApiIH7JSqiMbcZvB
	AE6aax9qcd6l/2lRB2pYweOy9yJ3F/m7NvWmqi5N/F2jYpsw5KgigwVRPRI5DMmQJYFVL5/3BMiT+
	pHnleaH1wYSBlz//BG7gxN99amiF6NHgvhHGkfGndGq014eLa6aYnn7ZKDtWjYcCBByhMH0grLor8
	WQV/VVMp4O4V74i35nxFifN+wWRsmCkJQ1F+jLdoVYMKWEJTh50olWwYGnNjUetVqLzBojIvdY4vz
	TzFjTFECeLhFtzTpYg8UIU+xhyzcRg0zLtu32VjDHnuixAkftj332eYQFa7WSMl8elFczlXVszmyh
	0JRYMIDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBvs8-00EMnP-0s;
	Wed, 21 Jun 2023 11:19:36 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBvs5-00EMlo-1o
	for linux-nvme@lists.infradead.org;
	Wed, 21 Jun 2023 11:19:34 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EDBF31FDD5;
	Wed, 21 Jun 2023 11:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1687346371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HHkbLk/cLJhPHRHX27FHhhWp3DrX/nCJGGt+VLR1SzI=;
	b=gGyxtk4CRVWFBztpC1rGErZc/Yx9a1BC/H90dzZ7W77getnyDY45MVlreaQOjjctagP6q+
	u63OAFg3WhKhJdsBe0yueYNraFUBO74si03Y2gRIuobb2g+rXj3sg+745UIb/IGq3SlfDF
	eSRWB5UJqo1OlzXzTD/JquDJguSgW0g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1687346371;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HHkbLk/cLJhPHRHX27FHhhWp3DrX/nCJGGt+VLR1SzI=;
	b=QYsModYHdx6Ew+QFqgUL2c5xStel7OjLiIEsT8JEjjqZiMC2Vpv+HL6H+peDN8c2+QpLwN
	4tLO/CKpYV5251AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DCD4F134B1;
	Wed, 21 Jun 2023 11:19:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id QwPcNcPckmQeJwAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 21 Jun 2023 11:19:31 +0000
Date: Wed, 21 Jun 2023 13:19:31 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>, 
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>, Hannes Reinecke <hare@suse.de>, 
	James Smart <jsmart2021@gmail.com>, Martin Belanger <Martin.Belanger@dell.com>
Subject: Re: [PATCH blktests v1 1/3] nvme/048: Check for queue count check
 directly
Message-ID: <h7m22wkkpxo524a73rhl6y55lh5jkjcdteasc7voc6m6e7vfvx@hbr7hfhfkf2k>
References: <20230620132703.20648-1-dwagner@suse.de>
 <20230620132703.20648-2-dwagner@suse.de>
 <380cde65-8794-cfbc-237f-30a8d7e9330c@grimberg.me>
 <f6rvvhgim4nk34onfgbwyfctgvgdbdigwbsugjvizgtli46p57@s7c4gkqrpjqy>
 <083e29ff-4ad0-d05f-0521-56ace13629e6@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <083e29ff-4ad0-d05f-0521-56ace13629e6@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230621_041933_751868_B1FF1D53 
X-CRM114-Status: GOOD (  11.00  )
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

On Wed, Jun 21, 2023 at 12:50:29PM +0300, Sagi Grimberg wrote:
> > > Why not simply wait for live? The connecting is obviously racy...
> > 
> > That is what the new version is doing. It's waiting for the live state and then
> > checks the queue count.
> 
> Maybe don't fold waiting for live into waiting for queue_count.

Alright, will do!

