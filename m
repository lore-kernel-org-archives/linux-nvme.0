Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 251B7C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Feb 2022 14:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:Cc:From:To:MIME-Version:Date:Message-ID:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+RcZpPqtnfLAwgIFAjYhXtgjx/0Wde9g5JtAXXXQ3Hk=; b=QJRRJ+dGrnQIucWktLG2j64v0o
	S42MWOtZU3PYXAWakq9DJsPRX+NyLr0OfCLPhyn6itJcIHWXMCLOr58grX7J0kdApyTUFZsLWye2Y
	MsFIUxbxrNR4EM3c31hm9kE7pr8ycbwDqhx/Vyhi9p1FgOI/9UyDKIza3FLgKQQBn4R5p0pkSX32S
	I7Cg6HUq0QmcduMRCnXA1Ps7puk14g3BQYTnZ7A1mtavsHHp2uj2bR3yQ4KqtFbDq7R63HhOSbB5s
	fN6Pwdml5kvEgKstITJuLd9FfUd3SEARat5EBKHwzIcVfY7f+DpNKlWHaaNJJcYKKdzahGsBjX2G0
	ZBPywS+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFGXo-00Fen0-So; Wed, 02 Feb 2022 14:23:37 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFGMf-00FZzZ-Lu
 for linux-nvme@lists.infradead.org; Wed, 02 Feb 2022 14:12:07 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 392351F397;
 Wed,  2 Feb 2022 14:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643811124; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+RcZpPqtnfLAwgIFAjYhXtgjx/0Wde9g5JtAXXXQ3Hk=;
 b=IoEmeC7b6SCa2pEE4x4Dcr5x3ja8fY7Iqi+JIo1sSpTPS9vz1jOYEZfrgpFXp6/Q2PP9bG
 EPo2LhvuC2c+jfaRIFc10W1Xuk2tVMkfXQEqszO9RIQ8vdszRnsmWfVKgfthMuG51OAxdv
 kXNtBvBnJ8Ky7zs95rRLzHyvl7UZ+w4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643811124;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+RcZpPqtnfLAwgIFAjYhXtgjx/0Wde9g5JtAXXXQ3Hk=;
 b=Ji9+WRMhtXbsUd8Nw/4DI0m71QiyLu0cugknNcqTwZpD2vPhslTP08V1vm03RHgLG0L6Ni
 TX9Morl3HlHdH3Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2C5F613BBC;
 Wed,  2 Feb 2022 14:12:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +glHCjSR+mGGYgAAMHmgww
 (envelope-from <hare@suse.de>); Wed, 02 Feb 2022 14:12:04 +0000
Message-ID: <3a066f81-a53d-4d39-5efb-bd957443e7e2@suse.de>
Date: Wed, 2 Feb 2022 15:12:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
From: Hannes Reinecke <hare@suse.de>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Chuck Lever III <chuck.lever@oracle.com>
Subject: [LSF/MM/BPF TOPIC][LSF/MM/BPF ATTEND] TLS handshake for in-kernel
 consumers
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220202_061205_910437_92BB0E52 
X-CRM114-Status: GOOD (  12.31  )
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

nvme-over-tcp has the option to utilize TLS for encrypted traffic, but 
due to the internal design of the nvme-over-fabrics stack we cannot 
initiate the TLS connection from userspace (as the current in-kernel TLS 
implementation is designed).

This leaves us with two options:
1) Put TLS handshake into the kernel (which will be quite some
   discussion as it's arguably a userspace configuration)
2) Pass an in-kernel socket to userspace and have a userspace
   application to run the TLS handshake.

None of these options are quiet clear cut, as we will be have to put
quite some complexity into the kernel to do full TLS handshake (if we
were to go with option 1) or will have to design a mechanism to pass
an in-kernel socket to userspace as we don't do that currently (if we 
were going with option 2).

We have been discussing some ideas on how to implement option 2 
(together with Chuck Lever and the NFS crowd), but so far haven't been 
able to come up with a decent design.

So I would like to discuss with interested parties on how TLS handshake 
could be facilitated, and what would be the best design options here.

The proposed configd would be an option, but then we don't have that, 
either :-)

Required attendees:

Chuck Lever
James Bottomley
Sagi Grimberg
Keith Busch
Christoph Hellwig
David Howells

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

