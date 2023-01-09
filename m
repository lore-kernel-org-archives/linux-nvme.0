Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A64CC5479D
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Jan 2023 10:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ocpGmy6QJxltUeGKuetyr80CclrHu2CXv/z5CqFSi/k=; b=VQh6kYhEPOSbrlJ000kotlrlok
	oMRQSZwZtv7wLmDydb4dSX96ih6/M64aWl3Xjw3zvU+mRhuu/kwwOWb4iv8aKtHqAjoS6V+qbJbDr
	3eUb3iqVN1LGc61KXiWAMLxpJqGi4raLLB0MAoQb2Br4IeV8qfNyhMGDt/nnWLlc3pIczx+xkAUb/
	x2hVHpvve4rmuI95ZgZEpi3d7M7BCAwSC3nb2FH3s+1VsJlAw1oUjJx0ywXdpjCICwBj+1LnLXdNo
	pz12ES/yrgz3G9JqD6ywqudVVqjaLFpNYEXyQVcLTiErcB4WyX4nnvjLRvhQL2EFv6m7eG3+9M6KU
	1Vgw4SJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEp8T-000j03-4R; Mon, 09 Jan 2023 10:12:09 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEp8N-000ixQ-ME
	for linux-nvme@lists.infradead.org; Mon, 09 Jan 2023 10:12:06 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ABD3338D08;
	Mon,  9 Jan 2023 10:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1673259117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ocpGmy6QJxltUeGKuetyr80CclrHu2CXv/z5CqFSi/k=;
	b=im2zsg12wUbgsNnADenyU30mCGXjduHuxzZG5EuvLOUPTtY+QYs8hc3F4Ma5jLSpiZr7jI
	+Nfgls+DkMI8B3eOqZHZYqIA1i5MZ0j1vFN3uJKRirLuHpGS8ktlS0impZDjG3YPM/YnOk
	99hZZz+N6BcrQ/o7V+8CmJQFmAlxow8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1673259117;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ocpGmy6QJxltUeGKuetyr80CclrHu2CXv/z5CqFSi/k=;
	b=hu2ZQA2csG+pByGKLKAzQgQ4JH5Q9ECkU8GM5u236g1Be3K/5t69kxnzvtdDZIM40YRr0A
	I2+rdH2PflOAWvCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9C4DC13583;
	Mon,  9 Jan 2023 10:11:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id NM32JW3ou2MvEwAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 09 Jan 2023 10:11:57 +0000
Date: Mon, 9 Jan 2023 11:11:57 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Nick Neumann <nick@pcpartpicker.com>, linux-nvme@lists.infradead.org
Subject: Re: trying to gain understanding on BLKRRPART and "failed to re-read
 partition table" error
Message-ID: <20230109101157.q5j6vbiozphd24b7@carbon.lan>
References: <CADqNVTonXBsyG7SRzVua1rtfsySobjFyEW=zUAREZNm+Qv+h_Q@mail.gmail.com>
 <Y7h6okidN679ZtPh@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7h6okidN679ZtPh@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230109_021203_942613_2754375C 
X-CRM114-Status: UNSURE (   9.98  )
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

On Fri, Jan 06, 2023 at 12:46:42PM -0700, Keith Busch wrote:
> There really is no need for user space to do the BLKRRPART ioctl
> anymore. The kernel takes care of the rescan automatically, so unless
> you've a really old kernel, we might be better off just removing the
> ioctl.

As far I can tell, the current version of nvme-cli doesn't issue
any BLKRRPART ioctl anymore (although the documentation says so).

