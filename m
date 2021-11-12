Return-Path: <SRS0=M30F=P7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2619BC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Nov 2021 15:49:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3B6560C51
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Nov 2021 15:49:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E3B6560C51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:Cc:To:MIME-Version:Date:Message-ID:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fFX73SXGKLONoio7MexYSfvQM4jBEhmxLPTXDGF0nXY=; b=YVEtSMeLjNXTbK97y+ryuG5jnM
	FMjql9D8wcGYYOVh88SuJis3yJbnMeFR5uCVD7xJ+VNFYgZKwiW6CQPF/FcljUr95splmirH5Sxxo
	lSd+t2GcbprG4kDKUneXi/fv4ElYproMx/keJm/7eJgjJMXiQXB38B7uhpMPk1JW1EEBWpF9/ruTE
	kO+6RiSuvJRW4C5cINoPVF2/edvpv3UZE/tt/gKUe7Kyp5c7gufoYNUNR0tk7JZbZbz/OMhX4YamH
	3uWft72BX/qk5nsVDs0li8dnG293vjr8weg7/wNJRsed8N4QweP4bS2KrR4NdqiAo7xvkNPo8XB9z
	5Wr0YMrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mlYoC-00BAHy-8D; Fri, 12 Nov 2021 15:49:44 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mlYo9-00BAHT-CG
 for linux-nvme@lists.infradead.org; Fri, 12 Nov 2021 15:49:42 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BB5231FD65;
 Fri, 12 Nov 2021 15:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1636732177; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fFX73SXGKLONoio7MexYSfvQM4jBEhmxLPTXDGF0nXY=;
 b=gnFNZGNY6wW7b8CaYxJQEygCjxYK84TyugGnu+r9OZSjHlK54oXfmmamSsJ+pW3YdftJ1A
 uflwjxSsR4OwFANtevziPlnJqzFKupxjrItCHn3pPE4f7sEMjy/d/6epLRcxSOsKxhrQHl
 KUI4beIyljPZvJysALNmTDSCbn4zDo8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1636732177;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fFX73SXGKLONoio7MexYSfvQM4jBEhmxLPTXDGF0nXY=;
 b=+2gY0kZthMPZv+9tc5GXg99kPSMNplUkqeYFxMlq0HMUbCL9o2e8Zwz0usULX3yj3INOAD
 8MOXiw+cEDTvUwCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E68C13BA9;
 Fri, 12 Nov 2021 15:49:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Y9FfJRGNjmF0aQAAMHmgww
 (envelope-from <dwagner@suse.de>); Fri, 12 Nov 2021 15:49:37 +0000
Message-ID: <2f583f14-bdc4-2d7c-3e3b-cbaa7809eef8@suse.de>
Date: Fri, 12 Nov 2021 16:49:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
To: keith.busch@wdc.com
Cc: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
From: Daniel Wagner <dwagner@suse.de>
Subject: nvme-cli release naming strategy
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211112_074941_623193_E5293016 
X-CRM114-Status: UNSURE (   8.13  )
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

Hi Keith,

I was thinking on how we want to handle releases with
the master and  nvme-cli-monolithic branch. I think it
would make sense  to rename  nvme-cli-monolitic to
something v1.x and  keep it maintained for a while alife.

And the master would be marked as v2.x. This would
avoid a flag day release which we force to switch
the users from monolithic version to the splited
version.

What do you think?

Daniel

