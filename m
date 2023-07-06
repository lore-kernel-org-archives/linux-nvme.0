Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53066EB64D9
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Jul 2023 18:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:To:MIME-Version:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=paR5GMN/yfc7jhKaqg3zvahLExZAZSTJKlzzx3ooyJw=; b=fsDJFAEhNcimV2SHjRL3Qei+Ds
	xPLWn0WI0hlgaKucsW7yKtsLZOg0qXywLZIZ2cggRhDEKl/Q8qNaAMplBKShGGee6U2gf46KYOnoE
	MtddyzykBN84FUxVL15TwsxfT/kcgmysaWMdSmaS1QukcdZbsZ75fjHQEoXBiXRYGasb3HNOqTkWy
	I0Pu4VyGOt+d0TGsdLe//aK87XNtRVW6ZUteWP3ZE8nhnZFCUTHKGKbkvDw3kAynCyai4pHYrc3yL
	DQFtvatc0IJp49LjHVG9HLapAAe5ChrCrWqtEUPYTPzwdkAROzZq2UoxCrekJE/R5+W1Et6eowxqh
	jSw/1Bpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qHTvy-002QV7-0z;
	Thu, 06 Jul 2023 18:42:30 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qHTvv-002QUD-18
	for linux-nvme@lists.infradead.org;
	Thu, 06 Jul 2023 18:42:28 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 548741F893;
	Thu,  6 Jul 2023 18:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1688668937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=paR5GMN/yfc7jhKaqg3zvahLExZAZSTJKlzzx3ooyJw=;
	b=XWHHUPu1tlB2GpjfVZjeZ4WAB8vL5lZ3ODgXpk6n7IHwuYgCsA4NPHJ/9PHLu6LNrD1jV5
	eiOWNLaPNWMpSlCGk2/49cA2anrZXBAqjlRgsqCqOtoS7sAe1DlqBUuIYYod/Aqv/TlSRI
	h2jbS/sTocX+/AQ731OJMD5KKqSmE1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1688668937;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=paR5GMN/yfc7jhKaqg3zvahLExZAZSTJKlzzx3ooyJw=;
	b=mVilUmX/x+yoWPClt0dCF4ozqy6fqKxKgkA0ewFppWGcqPop3GPGE+z+SVA1Aa6YHK8NIl
	rtbjphSwiFWJcmDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3F6DE138EE;
	Thu,  6 Jul 2023 18:42:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 3tXQDQkLp2QobwAAMHmgww
	(envelope-from <hare@suse.de>); Thu, 06 Jul 2023 18:42:17 +0000
Message-ID: <f10a9e4a-b545-429d-803e-c1d63a084afe@suse.de>
Date: Thu, 6 Jul 2023 20:42:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: Hannes Reinecke <hare@suse.de>
Subject: nvme-tls and TCP window full
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230706_114227_604475_B90910EA 
X-CRM114-Status: GOOD (  10.44  )
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

Hi Sagi,

I'm currently debugging my nvme-tls patches; with the rebase to latest 
linus' head things started to behave erratically as occasionally a CQE 
was never received, triggering a reset.

Originally I thought it's my read_sock() implementation which is to 
blame, but then I fixed wireshark to do a proper frame dissecting 
(wireshark merge req #11359), and found that it's rather an issue with 
TCP window becoming full.
While this is arguably an issue with the sender (which is trying to send 
32k worth of data in one packet), the connection never recovers from the 
window full state; the command is dropped, never to reappear again.

I would have thought/hoped that we (from the NVMe side) would
be able to handle it better; in particular I'm surprised that we can 
send large chunks of data at all. And that the packet is dropped due to 
a protocol error without us notifying.
So question really is: do we check for the TCP window size somewhere?
If so, where? Or is it something the lower layers have to do for us?

Full packet dissection available on request.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

