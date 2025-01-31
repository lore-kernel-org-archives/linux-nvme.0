Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A1DC0218D
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jan 2025 09:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:To:Cc:Subject:From:MIME-Version:Date:Message-ID:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZRUnapFC7WAaDdpcqgXRbqKjqQXqOMV/HtgdV4S6oo8=; b=DlyrIq6pkOYTM+0JmhRd2uFeSr
	k65mJhe/l0DVBSvR+EM0eFCvKI8QG1CD6zSXHv+3wKCT14LYwK/Ss2Zr21MMhWFHxg6eC4rQMNWT4
	0OcZ88iRv1YqxfVvO5QKbbqzmnMd0r+B9hwXxVNP5DPA86uwrvL06jVbnkLDJmRo1xncrXdbCJTEd
	tOmesJQ5qhQlVUIGWuCbPCURcDgLiQ/W50Ex4+E8MZUnkKCIzWc0XgnCROQGVNAZwSRtLn6fUtp0s
	lhmPVQmi4R/cTm8ACYQI2en0Oa+rcGVdMdIIRFcqSSii1f+/Qivh9bNzKC4niRqpSDi6wSg+QOh0R
	2cRtUeIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdnGS-0000000AIlb-1jzm;
	Fri, 31 Jan 2025 09:24:40 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdnGQ-0000000AIkc-1JDS
	for linux-nvme@lists.infradead.org;
	Fri, 31 Jan 2025 09:24:39 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5F9341F38D;
	Fri, 31 Jan 2025 09:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738315476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZRUnapFC7WAaDdpcqgXRbqKjqQXqOMV/HtgdV4S6oo8=;
	b=gDNBC0NFxD+w/uxZvEYlskaqZ0hFtS8KUZCZ8biAHhz4c8bwUNcZ7/tIAxk0wWnNzH22tf
	YuPPkiedsJD5MzBPhCYjNAlIIoIl2NM/XCQRzjOBvCwnoO9F/AX5N+8KJOzxxgerjzqm7U
	led+8BnKcqEjyIHzkjDGef8g7kRbtrg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738315476;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZRUnapFC7WAaDdpcqgXRbqKjqQXqOMV/HtgdV4S6oo8=;
	b=Z3Sql7dulgRJN0ku2UAp+oncBkxKRAaJNNmgGr5QFIOANA6k2wcJNfluSuAwWDJKGC1HYi
	MrCyfSrzLANRX3Bw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gDNBC0NF;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Z3Sql7du
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738315476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZRUnapFC7WAaDdpcqgXRbqKjqQXqOMV/HtgdV4S6oo8=;
	b=gDNBC0NFxD+w/uxZvEYlskaqZ0hFtS8KUZCZ8biAHhz4c8bwUNcZ7/tIAxk0wWnNzH22tf
	YuPPkiedsJD5MzBPhCYjNAlIIoIl2NM/XCQRzjOBvCwnoO9F/AX5N+8KJOzxxgerjzqm7U
	led+8BnKcqEjyIHzkjDGef8g7kRbtrg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738315476;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZRUnapFC7WAaDdpcqgXRbqKjqQXqOMV/HtgdV4S6oo8=;
	b=Z3Sql7dulgRJN0ku2UAp+oncBkxKRAaJNNmgGr5QFIOANA6k2wcJNfluSuAwWDJKGC1HYi
	MrCyfSrzLANRX3Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27B201364B;
	Fri, 31 Jan 2025 09:24:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8AyGCNSWnGf5GwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 31 Jan 2025 09:24:36 +0000
Message-ID: <63af907d-9cdd-4956-9978-4e77389b1716@suse.de>
Date: Fri, 31 Jan 2025 10:24:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Daniel Wagner <dwagner@suse.de>
Subject: [LSF/MM/BPF TOPIC] TP4129 KATO correctoins and clarification
Cc: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Christoph Hellwig <hch@infradead.org>, Sagi Grimberg <sagi@grimberg.me>,
 John Meneghini <jmeneghi@redhat.com>, Hannes Reinecke <hare@suse.de>,
 Randy Jennings <randyj@purestorage.com>, Keith Busch <kbusch@kernel.org>,
 lsf-pc@lists.linux-foundation.org
To: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5F9341F38D
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250131_012438_487117_DD953F65 
X-CRM114-Status: GOOD (  12.45  )
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

Hi,

The KATO handling in the spec got updated via the TP4129. In short it 
mandatas that failing requests should be delayed by some value before 
retried on a different path.

We had some discussion in the past about how to handle failing requests 
due to timeout or connectivity loss and couldn't really agree on how to 
handle them. Hopefully, the spec has clarified this topic and I'd like 
to discusson it and figure out how to implement it. I know Christoph is 
not particular happy with the TP but maybe there is still something we 
could do?

Mohamed is working on a patchset and I am also trying to come up with 
something useful (*). I think we both should be able to post some 
patches for discussion before the event. Anyway, I think it would be a 
great opertunity to discuss this topic.

Thanks,
Daniel


(*) Initially I wanted to have something ready for this topic proposal 
but it's not there yet.


