Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D899FC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Mar 2022 16:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:To:MIME-Version:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jzwwovIUsP73C7zCVETKsU2PBWeO0ClIYanjeiuz1F4=; b=RhBhI0V+wzdZxHSWR2W0LCd/Zd
	FG6bkzEmEm9zLSk3GZCa6qNkAQWPOMtT6gErX8Qn+ll9WpOys5slNtOjF3TjDbFgtiaFt3ezKyZAW
	8Y9g4yuRrzAird0anf6dxBTPQvcnRkgZpqLm3BeqsFg34U+SY892i1xlp3ommXeCQp0LqnMHNtn4B
	bHGEePuDOHSQNgMut3zQbNDXegzks25blQCgO7pf0e64KT7q2qkI3TsCFuPG22xd2hKG14K3M3ecW
	poBjjUnhZTw/mvoTpJ7ntl4ZfAFJgi5znugIgBD6p3KY+AQh2UWM8EcHmXTwyW6nlfqlW/PhRblhS
	+VZSLDkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nX3jG-00EEBu-If; Wed, 23 Mar 2022 16:20:58 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nX3jD-00EEBB-SZ
 for linux-nvme@lists.infradead.org; Wed, 23 Mar 2022 16:20:57 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 01EB6210F3;
 Wed, 23 Mar 2022 16:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1648052451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jzwwovIUsP73C7zCVETKsU2PBWeO0ClIYanjeiuz1F4=;
 b=NFHTkVAka57ORvTAqAmxS0fOuauLavqEHD9Ux4cEoYYzOO8cNy2DqDpRZjTC6c7mrwCcrM
 V/GpBuCNOmUFiIC8P+UHZForH9U/xS7DW/IQupL6SqxnakeAYSTf3hXPnzTQMXRcFvx3ZH
 mPCTBLXJHlHmvcZVweO9ZIj8WJllfHc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1648052451;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jzwwovIUsP73C7zCVETKsU2PBWeO0ClIYanjeiuz1F4=;
 b=O4NUBxzwxrImnIipejEqBSpSz4Xxb3s8sWnfqW0t+L2EiqEDBoewUe0pq807OmJks3e2LL
 NnXHTjSyeDniTmDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E4BFA12FC5;
 Wed, 23 Mar 2022 16:20:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Cgk3N+JIO2JjBAAAMHmgww
 (envelope-from <hare@suse.de>); Wed, 23 Mar 2022 16:20:50 +0000
Message-ID: <521666e9-9114-9c2d-c680-a52defb45f8a@suse.de>
Date: Wed, 23 Mar 2022 17:20:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: Hannes Reinecke <hare@suse.de>
Subject: [LSF/MM/BPF TOPIC] dispersed namespaces revisited
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_092056_111292_1E3DD355 
X-CRM114-Status: GOOD (  14.58  )
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

Hi all,

there had been quite some discussion on various venues about dispersed 
namespaces on NVMe and missing linux support.
Especially since it looks as if the original specification will not be 
implemented, yet vendors do view it as a crucial use-case.
Which is already supported on other protocols like SCSI just fine, I 
might add. Even on Linux.

So I would like to have a discussion on where we stand, what the 
proposals are, and what we can do from the linux side to support the use 
case.

To add a bit of background:
Dispersed namespaces have been defined to support live migration of data 
from one subsystem to another. General idea is that the same namespace 
(as identified by the namespace identifier) might show up on different 
subsystems.
This is already working on SCSI, as dm multipathing will just look as 
the VPD page identifcation and arrange devices based on that.
For NVMe with native multipathing this currently does not work, as
a) we're identifying namespaces with the numerical NSID
and
b) namespaces are attached to the subsystem, and can only be assembled 
within that subsystem.

Sure we can always switch back to device-mapper multipathing, but I 
don't think that's a direction we want to go.
(I certainly don't.)

This discussion will be on how do we go from here; changing the spec 
and/or the implementation is on the table.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

