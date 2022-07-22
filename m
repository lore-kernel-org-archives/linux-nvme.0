Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E16C43334
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jul 2022 09:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V1T9tYXo2IZ5gcCiAwEp1v5jb7O6bldvEJZeoeE2dZU=; b=yJvvUkoAtlQsuQ1sz18IinxBQO
	2SLeGQcWQZ2yvzjWW+qNezXWzGwCr+D4Zyi/BU4QmT4hb2jF41Q7paGtcopTfM2gUoTEu4X92s8t3
	aRS6oLg4Zhbx9I9G5WIh97vCNiQLWq7udumqhbzVl6C1ZmUWGxGqsC5MSmuHAvr7U8Np80kVecAqd
	6fbskJENfBQ0APCQDLUXMMTwSPOmePpmtTyuuz5kmdC9ML+P7Y6wg7hDNsuSneRPPCbvZoiF+D3RA
	/E8wzM1QYAyL5Tokg87+2MEa8hn0PK4dj5FZz064TGiau1NFC67Hpo9zM8P+C+kmp4pPmV4aA7pC9
	Cq/AHzWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEpFF-001xl0-VI; Fri, 22 Jul 2022 09:46:54 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEpFD-001xhc-BG
	for linux-nvme@lists.infradead.org; Fri, 22 Jul 2022 09:46:52 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3D9A93779C;
	Fri, 22 Jul 2022 09:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1658483209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V1T9tYXo2IZ5gcCiAwEp1v5jb7O6bldvEJZeoeE2dZU=;
	b=HHjMBnv5cp1+uoyt7MFQpEZLVaFamRM+uR30hjQohrr0CvS/81RvmI6RiNZOXdNLg0Jzns
	I31WUt45hTDti5O0YbAb/X6ZJ8n1oxXWugmYf53xZ6ylEZDgQchmOrOm8DVzCJkLcjupbX
	uBFzi/SbxAU9W7W4I8j4pLuucjmrJG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1658483209;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V1T9tYXo2IZ5gcCiAwEp1v5jb7O6bldvEJZeoeE2dZU=;
	b=ys7yj5wZ8WgCQTx2oqDlO/6/VgKA7S+ShmYFCZ6r4rMzjVQ3AFjiljc2knWgB9+gDZOpFC
	6jEvhKCaktVx71BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2B321134A9;
	Fri, 22 Jul 2022 09:46:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id wRVyCQly2mL7bQAAMHmgww
	(envelope-from <dwagner@suse.de>); Fri, 22 Jul 2022 09:46:49 +0000
Date: Fri, 22 Jul 2022 11:46:48 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Chao Leng <lengchao@huawei.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme: consider also host_iface when checking ip
 options
Message-ID: <20220722094648.i6w3dymag3mfjpuo@carbon>
References: <20220722092456.24517-1-dwagner@suse.de>
 <3f0528a5-73d2-3dc5-32fb-0eb73797bf71@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f0528a5-73d2-3dc5-32fb-0eb73797bf71@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220722_024651_549348_A1B1D053 
X-CRM114-Status: UNSURE (   9.44  )
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

On Fri, Jul 22, 2022 at 05:37:42PM +0800, Chao Leng wrote:

> Maybe we should not check the host_iface, because it is not used in the controller
> management code. If some users uses these parameters incorrectly, it may result in
> unexpected behavior.

Currently we only allow 1:1 setups. Checking if we use different network
interfaces allows n:1 setups.

Obviously, if the user has a invalid IP configuration etc things will
break apart but this is true for almost anything.

