Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54DEDC04A95
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 17:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rep4pojwfTyRGxKKuu/b3sredKMuYFzcTxvnOVzRjpk=; b=Adu2B2cg5iAWNzoUMs/T0TLiSy
	mdZQH9DI70jOnP1Uo5qe7asgz/PJZJRuy92Bz5QjOp9tjSXvqINVRNs/HpVBRHxQluK6MA72g9kMd
	9wFZhrrSsQMwGlJxLClEVyvps9eH7nHmuYGmPiIu8lajp8gYskGt2R/gdcfNV2rIsuukL1flparys
	vn2mJGHrVMlfPjkJbXA13Sa2cehMmz32nKHIp47z9RTNBVd/DmiCBKoMMj/yzUS7pfyiaJqsWvgYD
	YqGpN5JJru1hoe38lp9KfWiyjnhdb5kHqHPC4qPmMCcu0DM/iZT4WuVaXGY8waxCoj72TVHUqHvU7
	ew7C6nXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onNZ4-006Q8Z-0P; Tue, 25 Oct 2022 17:18:10 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onNZ0-006Q72-TT
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 17:18:08 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E68CC1FA17;
	Tue, 25 Oct 2022 17:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666718282; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rep4pojwfTyRGxKKuu/b3sredKMuYFzcTxvnOVzRjpk=;
	b=BGDiAG7yzgaw+BqzqvmsQppQesVFxJwLWfXQvAxzwSTTxhhvGCPJoEj+e/ZrD7+k2HPa4J
	kFB6nxzklrOkC2t1Ztygt9J4VxsG9CSXoEMYVoUFMcVr4g0u9J8MBbLD0hLsqJ+TNWPv+5
	ydqFd8397RYkD8RDZUVzhGKppixnxUE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666718282;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rep4pojwfTyRGxKKuu/b3sredKMuYFzcTxvnOVzRjpk=;
	b=uBInM+AmE+RalXQQSrwhjDilOqRLF3r/EkrNlLZwKeD8o5HtGoEjxHdvAoiIYexwMr8yA0
	2SnP0U8sSWCwJ2Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C7CBF13A64;
	Tue, 25 Oct 2022 17:18:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Iv7CL0oaWGODNAAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 25 Oct 2022 17:18:02 +0000
Message-ID: <97c225cf-ad4e-b2bb-d06a-f1874d013743@suse.de>
Date: Tue, 25 Oct 2022 19:18:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/6] nvme-auth: rename __nvme_auth_[reset|free] to
 nvme_auth[reset|free]_dhchap
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20221025134330.1028352-1-sagi@grimberg.me>
 <20221025134330.1028352-2-sagi@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20221025134330.1028352-2-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_101807_120213_4349ECEC 
X-CRM114-Status: GOOD (  11.91  )
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

On 10/25/22 15:43, Sagi Grimberg wrote:
> nvme_auth_[reset|free] operate on the controller while
> __nvme_auth_[reset|free] operate on a chap struct (which maps to a queue
> context). Rename it for clarity.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/auth.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes


