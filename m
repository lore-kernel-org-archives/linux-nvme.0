Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BAAEC678D5
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Mar 2023 08:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9z1R2OQWeWcIJWUjUS2QeXOmQJlxvrDO6VaNkzbYJwk=; b=Rq5JITVpkTYE3TbrVA01G5DUd5
	O3CCyNZnC5GfFlijihlcYx6N86jznkgEkQ1qWWlbtvWov3+nQoCl5XO35qdSlGqZSQDTH23zbKvlA
	Q68kzNWsRVYav/pkzxm/CZOmKthwwKPw/0kYX86io+ClebpdHsPamlUirWGpam6JpgfE4Y+huifNu
	bwdX+SLkwHap2vq2arfsnJ2kbF71YzfnXJghpEP+OyWrS1b/9GXHMfxsbk8EIVAOq7WAaY0/KXF3d
	8WHOVsTE9hcXF9TV5+oFWEbfSggKuJWcIeJNNsJzp3vdJrfR9/n1+cnjmv4r4SvD36/MP+yckz85C
	e9lL914w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZpEr-003zRA-Ne; Wed, 08 Mar 2023 08:33:33 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZpEp-003zQ4-HT
	for linux-nvme@lists.infradead.org; Wed, 08 Mar 2023 08:33:32 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 29DBA1FE3E;
	Wed,  8 Mar 2023 08:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1678264405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9z1R2OQWeWcIJWUjUS2QeXOmQJlxvrDO6VaNkzbYJwk=;
	b=FV2hysVqRum9yV1EWywxzPUX0Ivk+83zCGxi3P6e/W2hJySyOx9Za8/f5h8e+mTruMDg5T
	3OSZuo3k4LYCnQbRirpbPn0jwO3ni8dYDsyVkkAFQ/7m+YBzOkrUPd0yQVr0D4DcJ7Y0qr
	KVJ4pjUtX4n10wzALpSP/xep4cLfL+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1678264405;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9z1R2OQWeWcIJWUjUS2QeXOmQJlxvrDO6VaNkzbYJwk=;
	b=x0/S73XcdfJuHaCngQuAVPqX9/GOXLhZUqDx7s3riy5ELsRD59ctUAK9tKeWEY3OqH1KCi
	R6spAl3kvt1xnNAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1B22C1348D;
	Wed,  8 Mar 2023 08:33:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id YMiSBlVICGT2GgAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 08 Mar 2023 08:33:25 +0000
Date: Wed, 8 Mar 2023 09:33:24 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: James Smart <jsmart2021@gmail.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [RFC v1 0/3] Unifying fabrics drivers
Message-ID: <20230308083324.5sjcfh7v7clpdpuc@carbon.lan>
References: <20230301082737.10021-1-dwagner@suse.de>
 <e70f3b0c-5049-0bbe-fb13-41efc0425e0f@gmail.com>
 <20230307124143.s5ojphvt2wvdj2j7@carbon.lan>
 <030c66e0-7d9c-7bbc-7442-b6f6f6ff5832@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <030c66e0-7d9c-7bbc-7442-b6f6f6ff5832@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230308_003331_750469_8F965DB9 
X-CRM114-Status: UNSURE (   8.32  )
X-CRM114-Notice: Please train this message.
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

On Tue, Mar 07, 2023 at 11:55:52PM +0000, Chaitanya Kulkarni wrote:
> please avoid it moving and updating at the same time..
> 
> I'd first do a prep patches and move the bits/code around
> and establish the stability of code then only I'd make the
> actual changes for unification...

Sounds like a plan. Thanks!

