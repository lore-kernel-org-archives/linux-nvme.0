Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C310D16271
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Oct 2024 13:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=70N2jAJqrjvH5ZkrUTGtIw0CKdFTcuxxCwedWZ5xnGw=; b=EeOoEY5qatOTUVAPCPkeYKH7zX
	2Cvs65vzSJO/vnP6NVzDA75f2e6un7mX3zFvNLXFyN070Hn7ODVdZUvS2RO/032SCTdLP4HKlpvz8
	m67PvN4auSbZe+w1gQmOI1CemJaSdtnvcrAOgNb6CN/FI9IkG+5+n2MrMAue3w1n1DowOGS7cXJqq
	wqtzbvyEg80KkpfRUPOiuGtDTqPDET2OkOP8B74u4fiQaHJyevWTFEsYzIgG0AvEsob349IaDtaj9
	chfWlY3v2GZefGJ/gFBbsza4BCtbSRUM6gLCkgaIg3qDQfIQ1VUvM0AgCoIzDxXyy7wgmIMHgGWwX
	JKZjfsEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0Lc3-00000005Ol3-2QwY;
	Mon, 14 Oct 2024 13:59:55 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0Ky1-00000005ETc-04XJ
	for linux-nvme@bombadil.infradead.org;
	Mon, 14 Oct 2024 13:18:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=70N2jAJqrjvH5ZkrUTGtIw0CKdFTcuxxCwedWZ5xnGw=; b=TnDnA9Im59a0O2q17hgOznLzlp
	Dxy3DRd2CSi9teqtq1f6ikSLJ1qZd+UVMRVIhss14WVnwvzgcSVrh9NnAObNKPFLDBXsohOhAMbFF
	p0b2ivVOCfJ8s67jZf5Uwvz6Xx0BmY3b8VSLQN2J3TN2OYYan/TP3F94lxSvwliSVeW4Yp7au4EHb
	daLwGIQ1rS9AXxFJs1EKlPcND5sUPWGmxp+07EMj8lifUASDQLklVX6B2iVpZuje3P06/9DLIAePl
	8WTOJTmFEwAhAJM2Gt4B6E8yBhw14+mVtfKssb49LEK5wk2ay44IFBvhU6mbd60b31Tb7qGb4uvJc
	QJ+V8r+Q==;
Received: from smtp-out2.suse.de ([195.135.223.131])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0Kxy-00000006LjO-0DNT
	for linux-nvme@lists.infradead.org;
	Mon, 14 Oct 2024 13:18:31 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 58FE61FE53;
	Mon, 14 Oct 2024 13:18:27 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 489B613A42;
	Mon, 14 Oct 2024 13:18:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iHJLESMaDWesUgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 14 Oct 2024 13:18:27 +0000
Message-ID: <eb2298da-1d64-4424-a462-9056f722b5d7@suse.de>
Date: Mon, 14 Oct 2024 15:18:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nvme-tcp uaf when tls setup fails
To: Daniel Wagner <dwagner@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
 Christoph Hellwig <hch@lst.de>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <8bb28305-01b3-4d68-bc74-bdbd9352b1c1@flourine.local>
 <5b68b804-337f-4cec-9d90-6f727baaabbd@flourine.local>
 <77f84f3b-86ff-4d26-ab25-a0355bcb0e40@flourine.local>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <77f84f3b-86ff-4d26-ab25-a0355bcb0e40@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Rspamd-Queue-Id: 58FE61FE53
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_141830_349387_45D6202B 
X-CRM114-Status: UNSURE (   9.62  )
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

On 10/14/24 15:14, Daniel Wagner wrote:
>> The logs say that the connect to queue 3 fails, but it seems this
>> command never got send out (ftrace):
>>
>>      kworker/4:0H-759     [004] .....  8771.165686: nvme_setup_cmd: nvme1: qid=0, cmdid=0, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_fabrics_type_connect recfmt=0, qid=1, sqsize=127, cattr=0, kato=0)
>>            <idle>-0       [004] ..s1.  8771.172062: nvme_complete_rq: nvme1: qid=0, cmdid=0, res=0x1, retries=0, flags=0x0, status=0x0
>>      kworker/5:0H-796     [005] .....  8771.172422: nvme_setup_cmd: nvme1: qid=0, cmdid=0, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_fabrics_type_connect recfmt=0, qid=2, sqsize=127, cattr=0, kato=0)
>>            <idle>-0       [005] ..s1.  8771.178292: nvme_complete_rq: nvme1: qid=0, cmdid=0, res=0x1, retries=0, flags=0x0, status=0x0
>>
>> And it is very reliable to reproduce it.
> 
> It is also reproducible without TLS.

Does this help?

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 04f0ac57855e..12f8a97150af 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2163,8 +2163,8 @@ static int nvme_tcp_configure_admin_queue(struct 
nvme_ctrl *ctrl, bool new)
         blk_sync_queue(ctrl->admin_q);
  out_stop_queue:
         nvme_tcp_stop_queue(ctrl, 0);
-       nvme_cancel_admin_tagset(ctrl);
  out_cleanup_tagset:
+       nvme_cancel_admin_tagset(ctrl);
         if (new)
                 nvme_remove_admin_tag_set(ctrl);
  out_free_queue:

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

