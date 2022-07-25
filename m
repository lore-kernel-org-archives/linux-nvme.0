Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E95D2C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Jul 2022 09:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yQAU4BUSG7a0m73dSIVkaHBoDq1GY9AhV2ynEKSpWM4=; b=zAXUAZ6hx8AesJuYUwpOpj7wgT
	5EVMJFglcbGWb1a0G0MyWfPi7BTwTYn26D8Zoq3hwfTWLkzXrn4zu4TkG/b1lS8diVdKkO8YpijWm
	mrJO3EslTN/ToOgas29a63nU5Csb19b+1gJmRZmBsn3KwT9k6D3VntP+rkGXd3H5tH4uaSGywi/uI
	Sq/9SRV/9aKk9sG0KGK2O+EnB0n73teSnvjQh16n6gJd2Nq2Db/uYg0V4ZPH0yCMHGDkLlgQ/T0/A
	ai07otbHTN4xpZFQBWmW+xvd2QwNovVBJgVzum+gtSW4Leeeqh2l6nB5wXbCS+UGX4JlZkN4hnRBa
	YRpJ6jag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oFuLC-007WpI-PN; Mon, 25 Jul 2022 09:25:30 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oFuL8-007WjT-15
	for linux-nvme@lists.infradead.org; Mon, 25 Jul 2022 09:25:27 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A286733979;
	Mon, 25 Jul 2022 09:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1658741122; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yQAU4BUSG7a0m73dSIVkaHBoDq1GY9AhV2ynEKSpWM4=;
	b=r10p+9OAispNPvSzVhOl6nbkpT16PWTAbhe5LIp9IJWnWR81STrcpFZdsohiP+ZAE1293k
	AJqZpaiYnzQYy51BgFt0IUnRYpihejTuoZWxpY9no42Gp/am7KDMyLo3jhgyd5jkAWaDby
	J1jwBvKpMEkdzcqk/GdyhctLtGrpZsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1658741122;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yQAU4BUSG7a0m73dSIVkaHBoDq1GY9AhV2ynEKSpWM4=;
	b=fvI372iIx0mDpB9ECDFITvjdb1G4foSbcoHxRYNBjlz8ufWYMBwo07M1ViGpQm5xXUZYcB
	pAGbhDobcg2QrHAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9576113A8D;
	Mon, 25 Jul 2022 09:25:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id scdsJIJh3mL1DwAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 25 Jul 2022 09:25:22 +0000
Date: Mon, 25 Jul 2022 11:25:22 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Chao Leng <lengchao@huawei.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme: consider also host_iface when checking ip
 options
Message-ID: <20220725092522.i7lch2p4tn7uj6ii@carbon.lan>
References: <20220722092456.24517-1-dwagner@suse.de>
 <3f0528a5-73d2-3dc5-32fb-0eb73797bf71@huawei.com>
 <20220722094648.i6w3dymag3mfjpuo@carbon>
 <ce2ba75a-3dd6-8530-c868-298bbeb93d67@huawei.com>
 <20220722100932.tyjljbccwv47tg4z@carbon>
 <a37fc589-b47b-61c6-0c36-c3b13e7ce56d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a37fc589-b47b-61c6-0c36-c3b13e7ce56d@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220725_022526_259920_0E84B601 
X-CRM114-Status: UNSURE (   9.23  )
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

On Mon, Jul 25, 2022 at 08:52:27AM +0800, Chao Leng wrote:
> > What's wrong with it?
> nvme over tcp has implemented host_iface-related processing.
> But nvme over rdma(roce) do not.
> You can test with nvme over rdma(roce).

Ah, now I get your point. Indeed this will only work for the TCP
transport. But the RDMA transport doesn't set the NVMF_OPT_HOST_IFACE to
the allowed_opts so we should filter out this with the additional
NVMF_OPT_HOST_IFACE checks for the RDMA transport.

