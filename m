Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89203C07545
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Oct 2023 05:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M3q/wHoucHzK03Le3y+14uam2vn5MVvx1mT8tW+PXkI=; b=VPn+WDN0vkugnlbPbFg7C02DAe
	cEYeVZYXmBZ9xKdKFhq+guWOZoIMJdkNsoVvIxZ4U7XFral1znschUMRv+fTSz54z8owncNv60Y1S
	JeMlUe0ZsHv/1gk4UqlsGzDZoo2rlsfOLVKcrwP5cj6793n80nYyn9KLD+UGGHasKA2sGd90raatf
	Tzbz+7C2KFlwZj6PJjf6pToumRxGbLT8ElcGsM8tWnFV4lD+K0IhRRaVRV+QV9JCYfJwlTrrOMd+6
	C+IA0tforwAWLmmA0vwVUui7jQTAG6zuVUemy2PmNzR91GMSWKu1vu21Rsh5NMbKLW2etf8109kUu
	XnEsCZPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qvACD-008uT8-0y;
	Tue, 24 Oct 2023 05:43:17 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qvACA-008uSI-1L
	for linux-nvme@lists.infradead.org;
	Tue, 24 Oct 2023 05:43:16 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 42DE221220;
	Tue, 24 Oct 2023 05:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1698126192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M3q/wHoucHzK03Le3y+14uam2vn5MVvx1mT8tW+PXkI=;
	b=WqbG4lyEHmOraqyPq1VSdPmW2qI8prUIdp8i7Wym5hz1ntXkQx103WTALQTgHNGDUMkNYs
	qY8YCoUtVuyBthmHxPfgthexZ9c3eGn1tbU75nVICaCmcs71ySJz70UHLvhM/GsMf0FGHs
	XSHnPuA+nAUwCHEX7KPcaO4LI2K+9LI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1698126192;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M3q/wHoucHzK03Le3y+14uam2vn5MVvx1mT8tW+PXkI=;
	b=iwN0Xd4zyR4vTT0/Hn8PFqkGOZK57z3UVgvwxBJJu0YOViuUT7QOLfcBNT3BIAhdzXy5gZ
	KtvR6SPlRxJdT5AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 104E21391F;
	Tue, 24 Oct 2023 05:43:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id P924AnBZN2VCDQAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 24 Oct 2023 05:43:12 +0000
Message-ID: <ce187671-ea90-4d97-b323-70f275c09649@suse.de>
Date: Tue, 24 Oct 2023 07:43:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: blktests: running nvme and srp tests with real RDMA hardware
Content-Language: en-US
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Cc: Daniel Wagner <dwagner@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
 Bart Van Assche <bvanassche@acm.org>
References: <vaijnbobhxyz4nkk2csv3nfhnpeupbudakcn3qgmo7o6vii4x5@rfnfdll6iloo>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <vaijnbobhxyz4nkk2csv3nfhnpeupbudakcn3qgmo7o6vii4x5@rfnfdll6iloo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-6.13 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-2.04)[95.29%];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231023_224314_603089_98E682D6 
X-CRM114-Status: GOOD (  11.27  )
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

On 10/24/23 04:59, Shinichiro Kawasaki wrote:
> Hello blktests users,
> 
> As of today, software RDMA driver "siw" or "rdma_rxe" is used to run "nvme"
> group with nvme_trtype=rdma or "srp" (scsi rdma protocol) group. Now it is
> suggested to run the test groups with real RDMA hardware to run tests in
> more realistic conditions. A GitHub pull request is under review to support
> it [1]. If you are interested in, please take a look and comment.
> 
> [1] https://github.com/osandov/blktests/pull/86

Just commented on it. What we really need is the functionality to run 
against pre-configured controllers (ie specify the controller NQN and 
NSID and do not call into nvmetcli); when running on real HW we 
typically cannot control the target, so we need to be able to specify
a preconfigured namespace.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


