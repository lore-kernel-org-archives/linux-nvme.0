Return-Path: <SRS0=CVLn=P6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1F8C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Nov 2021 12:22:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECAA76103D
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Nov 2021 12:22:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ECAA76103D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZgI9wE+bqDaUqKlwUokBfOBJxvSo16W3jSJyMmN430g=; b=SV2ka1Ogvh6JweTwqrCREDfFDB
	gP9K8rtzN+Y/yxAwoC6Y8O3SYFqg5GdLIs0uoRDtD4jYEvkfOlrX6FdLu2vGBsLSGhhfHLrvE/V1u
	nZkSTiD5tXwRL54fe0K9flVnbTILO7Nd6UZ2kgCUUd7ygVxEp3akA+0CX89vk5wbXsjjI0tHiztmT
	nHTsaE/UWyDlPgoQSoLQmu+0rnYTiSmwM7Ip5E+NPCq0NU7rPQ5WY2X3Lsf55ShSX/A/rlmmmW2VQ
	lLGzImrrvbVZsyX63+3YLeGshWklWPwjoQ+qDY5gs3LAitb8CLc5yXZGJJ3SyUywQvzflihUzCn4u
	VM5tweOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ml962-007rzf-2o; Thu, 11 Nov 2021 12:22:26 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ml95x-007rxz-FK
 for linux-nvme@lists.infradead.org; Thu, 11 Nov 2021 12:22:24 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A44651FD4A;
 Thu, 11 Nov 2021 12:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1636633339; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZgI9wE+bqDaUqKlwUokBfOBJxvSo16W3jSJyMmN430g=;
 b=oqLEfiRKlQAc1sl56eeptwnvrIxAvcoZFJAsLzvrfd4oejzLJhCUSpzPK9Kv4pJM8YWs4G
 SHVNpDOiVvwPzLoCp0WP5BakByaYwEiPG7Y4XyCQc7HWA0BPROy0W8nBbJnvnYtCUr0nM4
 n1ExfYNrfDg/vcJb7d0FGoVdogud4ws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1636633339;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZgI9wE+bqDaUqKlwUokBfOBJxvSo16W3jSJyMmN430g=;
 b=pBQMuMueBtLFnXQ55/dVHpkk4AA2HYHbBzBmlDhggY2twBArNLrLLCrJvuiTh71NZu1lWO
 hd0Sh9tJfUU/cHBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 76BE213D89;
 Thu, 11 Nov 2021 12:22:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 96FNGPsKjWEicQAAMHmgww
 (envelope-from <hare@suse.de>); Thu, 11 Nov 2021 12:22:19 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: Hannes Reinecke <hare@suse.de>
Subject: Please rebase nvme-5.16
Message-ID: <0614137b-7ae3-48b1-d60b-57d1fcdae6ff@suse.de>
Date: Thu, 11 Nov 2021 13:22:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211111_042221_680297_047B9C9B 
X-CRM114-Status: UNSURE (   7.96  )
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

Hi Christoph,

your 'nvme-5.16' branch is causing a boot stall with various symptoms
(stalling in bfq_put_queue() or blk_mq_put_request(), depending);
using Jens 'block-5.16' branch doesn't exihibit this issue.

Any chance of rebasing on top of block-5.16 to make it usable again?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

