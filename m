Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9253FCA0EC3
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Sep 2023 11:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eNx29bnJ99NS09aFxiAeMZMQZbsfMZR+hkX0zVZ1siw=; b=b0x2DyLpLm15KjeK1ze25yhNyH
	8W/eIxCe+FinwmxokmooiR1xxAYEeCucrBlgU7yeLdMN6tpqDCEqfv3ZWKwMddFc7FTH2idSlHxDD
	p7pg73ZVYtGkD6Zikd7eB7x6vU9Cng9t3pmgX/onzRWs3sNLJ+pw7Jn17LrsMscUk828MgTh6zwtg
	+Mqx706M0aI6H3IvYOpO5llC7X3oq89IV/IMXT9Jp5WctdmpfcN0khKjiX2hKgsyC3C6trmlb9Pw1
	xMsUpF9i+s3NAqmjLSK5L8+wbphGPYMFpZM04M/tUDuriMq+5LPZa2UCQ5LkiIb6rNVaf/JwPDGCo
	vaZBMOUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qg1t7-003Fh9-3D;
	Tue, 12 Sep 2023 11:49:02 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qg1t3-003FOz-11
	for linux-nvme@lists.infradead.org;
	Tue, 12 Sep 2023 11:49:01 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2B8381FD77;
	Tue, 12 Sep 2023 11:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1694519198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eNx29bnJ99NS09aFxiAeMZMQZbsfMZR+hkX0zVZ1siw=;
	b=Tk87M2n+BYaPsG3xv2afWFOtpMwJ+cLBD6B026z0l7ZBFD+fp/3KeO+usGpjhaG5QChYRN
	svrGkP8nSmBJjWxcpl0Ngm3fxTKwZqWtjvJzT03MBZ4fzr8CH+V5yAAkT9OfORc6tqgz4/
	Oy2jPt8DWA5fxxfb0BMBnxBHvGJlGEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1694519198;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eNx29bnJ99NS09aFxiAeMZMQZbsfMZR+hkX0zVZ1siw=;
	b=IMsLIb8j8m8o12Z7Yu8RG4KZHkfNUOdNrfXDnvp1okE5HSdwM+f4bljGccLxguXL1bMIQc
	iWXNW+HCrEVOUMDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 16B29139DB;
	Tue, 12 Sep 2023 11:46:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 60wtBZ5PAGX/fgAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 12 Sep 2023 11:46:38 +0000
Message-ID: <750247cc-11a6-4383-980c-de72638fbe79@suse.de>
Date: Tue, 12 Sep 2023 13:46:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv11 00/18] nvme: In-kernel TLS support for TCP
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230824143925.9098-1-hare@suse.de>
 <683554de-5f4f-4adb-4e97-c532f514b352@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <683554de-5f4f-4adb-4e97-c532f514b352@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230912_044900_518026_CEFF719E 
X-CRM114-Status: GOOD (  12.05  )
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

On 9/12/23 13:34, Sagi Grimberg wrote:
> 
>> Hi all,
> 
> Hannes, I think that this is in decent shape. Assuming that
> the recent reports on the tls tests are resolved, I think this
> is ready for inclusion.
> 
Thanks for that.

> I also want to give it some time on the nvme tree.
> 
I guess that will be a good idea.
I had a look at the report for I/O timeouts with TLS, and currently
it seems not to be TLS specific but rather generic issues with the NVMe 
stack, just being visible now due to delayed timing.

Cheers,

Hannes


