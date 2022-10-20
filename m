Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1229C433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Oct 2022 14:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GgH4UzB8Ciqxv90CcUbAxA345ZbhfMdZyd+zc9xDufY=; b=S9XMFg303loOlSj/7uFovwNs7b
	Xi/0iP8TP6wTL6pa50AsvhxenM2KzCRs1wfuEqB7DW375M3ONkZ4UyX7FOKE3c49p9Y1AaJhxETI+
	J/No+zJdctD9gWdZ3Zach84MBGfwH6383JEwaK/7Sjhi5ihc/ehYU1PDTAvfdUBqs20pIe/62x6qE
	ywvtWpHJxH2Nj6J72qDPQbciE84KqASomITr+GBaEBL0fLatAvy3bd5k4otyLfC+ldTxM3H8Y1NE9
	syhTUWE3DpHvTVfZiUJN4dIwrlU7jp1/LwNVATuizcAM/2eqM+sHOBUunovOgHxnbbc/gCjLI1FOn
	SNOZmdQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olWZq-00GC6B-49; Thu, 20 Oct 2022 14:31:18 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olWM2-00FzNM-68
	for linux-nvme@lists.infradead.org; Thu, 20 Oct 2022 14:17:03 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E64391FB63;
	Thu, 20 Oct 2022 14:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666275418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GgH4UzB8Ciqxv90CcUbAxA345ZbhfMdZyd+zc9xDufY=;
	b=Sgm2NeWiabLl2osCT6tHyYbF7VflTZYMprs16N/TZSW9A1rcaXGmA/jIHw+3m94cK5U1/h
	4ddPcSe1Sq9LyncTdVrGEfR6B6mVv/qbWn5DaZrkir/oXfZoVKfQak3FwMRUzI74yeM31O
	jrG+hEJ3E5dKMmjh/+7gFxLgvBcleUM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666275418;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GgH4UzB8Ciqxv90CcUbAxA345ZbhfMdZyd+zc9xDufY=;
	b=Vrx/B5847JBRkndX8y+Ecsc6F/AbbOH26HK/dZLFG+oL10Y2i196NuUXUHO9NGkAahXc6Q
	DgD4960VAdcb2dBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D667813494;
	Thu, 20 Oct 2022 14:16:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 9nc0NFpYUWNxXwAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 20 Oct 2022 14:16:58 +0000
Date: Thu, 20 Oct 2022 16:16:58 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Subject: Re: lockdep warning: fs_reclaim_acquire vs tcp_sendpage
Message-ID: <20221020141658.x63rk7ymtduw2q7o@carbon.lan>
References: <20221019075138.ff2sfahovionh72v@carbon.lan>
 <c30b24b9-e80f-9e8a-5754-caa7dc7bfe8b@grimberg.me>
 <20221019093712.2d2g36wcwwcl7zat@carbon.lan>
 <20221019113517.wv27jqp7lyskfbqb@carbon.lan>
 <96978c5e-369b-a010-f9b5-6b4675836e47@grimberg.me>
 <20221019160147.ij3nc44n5ppmzifp@carbon.suse.asia>
 <8c564393-f5e6-57e7-c2a2-8ddd58187a0b@grimberg.me>
 <20221020081002.z2qvzlq3du7qef4b@carbon.lan>
 <930775bf-4e8f-5580-8216-d2f28e369cb3@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <930775bf-4e8f-5580-8216-d2f28e369cb3@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_071702_452374_1828CA25 
X-CRM114-Status: UNSURE (   8.58  )
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

On Thu, Oct 20, 2022 at 12:57:11PM +0300, Sagi Grimberg wrote:
> Just for the experiment, can you try with this change:

Good call, this seems to do the trick. The splat is gone with it.

