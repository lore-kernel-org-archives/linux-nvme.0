Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87BFCC32793
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Aug 2022 07:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4bqzVKoYvbSPVobgOmPJjxXtVGb3htPzvF/SRogMrYQ=; b=nRvBegMLnhrrw2ykU+AWKxdVb0
	qYSCPRJH1EAonmFCxjH3ufdCNyN1YTFa1Eypk6vVvRkxoVbE9uQwtIJJRfO4ZHf/pzmFQ/nZIhDxe
	7mxxwOWmEWdfqJQKX0aUVERgniOhwnowt3hIP5uwmSwXPxX5vwSNCqQ5x1/WZg2mVa/sKau5lShXh
	s4Fj7RVeKZjVJDlb7BSrWe3tIRTdrxYlVg9U29MeEKpQt81qA3FWia9TTbtWgnAlZMQ14WCp9gbY/
	tSVw/J01QHLBj5ai/0MLNjO0RUsSgrNCrTM7k7HNQTx7pF1e67/iMyaD04tpJDvuARKPzvBuBN/gG
	ECtvEMIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQOdY-003b4h-J9; Tue, 23 Aug 2022 07:47:48 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQOdQ-003ayf-GS
	for linux-nvme@lists.infradead.org; Tue, 23 Aug 2022 07:47:45 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0BAEE5CE3C;
	Tue, 23 Aug 2022 07:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1661240859; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4bqzVKoYvbSPVobgOmPJjxXtVGb3htPzvF/SRogMrYQ=;
	b=DdiRPDWlgVCOcEjjj0rvdFAiOjx9CLkijT7CH59Wey/cQNZKjjQ8KVrED/WMuli02yMLJ/
	s9lfY2xcN6WAu9EI+j/QHjY2LvT6gh1aaqA+/XmFrKf4Kweutts4+2vwfO3LnkaL7MJ+e6
	52EtfBkI4dXINt0luhnVqx8H4Oyt3Q0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1661240859;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4bqzVKoYvbSPVobgOmPJjxXtVGb3htPzvF/SRogMrYQ=;
	b=8yBeEfxxO7XEFNtnS/vU71SVXU+YWitgJvxAENAM3wJk7VuLpNdV6RvISQ4B8rE9gQgjAt
	NYOMRn6u2VnHmhDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EF20013AB7;
	Tue, 23 Aug 2022 07:47:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id SrFgOhqGBGMvRAAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 23 Aug 2022 07:47:38 +0000
Date: Tue, 23 Aug 2022 09:47:38 +0200
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Sagi Grimberg <sagi@grimberg.me>, Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH v3] nvme: consider also host_iface when checking ip
 options
Message-ID: <20220823074738.dzyy56mst4gp5fiv@carbon.lan>
References: <20220729142630.13504-1-dwagner@suse.de>
 <7f3a0257-791c-0522-cd20-6963f54c42a2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f3a0257-791c-0522-cd20-6963f54c42a2@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220823_004740_742560_52062BFE 
X-CRM114-Status: UNSURE (   7.14  )
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

On Sat, Jul 30, 2022 at 08:41:51AM +0800, Chao Leng wrote:
> Looks good to me.
> 
> Reviewed-by: Chao Leng <lengchao@huawei.com>

ping

