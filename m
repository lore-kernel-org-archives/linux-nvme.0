Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2ACFC3ABC6
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 09:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ve0eAauMpTlI0sIjvMlpoNdCq9hG/CRz4Qjl9FkzLhw=; b=EdZls5+vUi8Nhg+tNaFkEUcrcG
	FB889fmKQVmGuEXXJPCKlAdaztugf3bOXzau10yFumcISKWgMJFqn6EPA0PrvQLHHQMXPfzlX+Nl/
	dR6ujK62aUG8nXRUyEfHv7jGSqE5m9KyJxvCg6LKf1cICZMdhsJXoEpnOF1gjwNbCVgQGtZY3rPaN
	TAyDZPHRFlAzi3YbiBU26b2KUF0ce6Tvhfn3z5RU3sNJWXezOGbiRjVr88fN/9jppB0l2uD44ouBA
	WQXp/BlS1hI2xEbzaLLNLRSOkyRb912EPH8g8KoVKN2B2sAKGy+CwZlN+NcjD0ttXVENhwFL6bXRo
	gtdqLXvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCbUE-0000000F1gH-0YiQ;
	Wed, 07 May 2025 09:54:46 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCbDG-0000000EzPE-0Eyh
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 09:37:15 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 54FD42115A;
	Wed,  7 May 2025 09:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746610632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ve0eAauMpTlI0sIjvMlpoNdCq9hG/CRz4Qjl9FkzLhw=;
	b=P8zipbW6yfXDEW/xO1ZNQSujeq3A1Vh5TbIdOo7ijFfusIYzKh8B2bxM7Xhi3kEVoT5AlZ
	eftRMUNKVIn8wB0Y+f/grj2TijCaOTuIlvKW7RlIZt73zdWXysh2u0QEf2yAKVKbVO21/S
	vgS3NyEaE499e8GmQhxRg5HkETT4d2A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746610632;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ve0eAauMpTlI0sIjvMlpoNdCq9hG/CRz4Qjl9FkzLhw=;
	b=vm9pZDVefw4jE+wBPFSUAOL0RpvenHeSAmcV9AtFDmudPIIcWO/vAdZ3dGKCh/MjTDz86j
	n5xFG0jbXGLVOnAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746610632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ve0eAauMpTlI0sIjvMlpoNdCq9hG/CRz4Qjl9FkzLhw=;
	b=P8zipbW6yfXDEW/xO1ZNQSujeq3A1Vh5TbIdOo7ijFfusIYzKh8B2bxM7Xhi3kEVoT5AlZ
	eftRMUNKVIn8wB0Y+f/grj2TijCaOTuIlvKW7RlIZt73zdWXysh2u0QEf2yAKVKbVO21/S
	vgS3NyEaE499e8GmQhxRg5HkETT4d2A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746610632;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ve0eAauMpTlI0sIjvMlpoNdCq9hG/CRz4Qjl9FkzLhw=;
	b=vm9pZDVefw4jE+wBPFSUAOL0RpvenHeSAmcV9AtFDmudPIIcWO/vAdZ3dGKCh/MjTDz86j
	n5xFG0jbXGLVOnAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3698413882;
	Wed,  7 May 2025 09:37:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sAloDMgpG2hDfgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 07 May 2025 09:37:12 +0000
Message-ID: <de2b26ca-ea7c-40a1-8ebd-47b1f43aab5a@suse.de>
Date: Wed, 7 May 2025 11:37:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kernel TLS configuration, was: Re: [ANNOUNCE] ktls-utils 1.0.0
To: Christoph Hellwig <hch@infradead.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
 kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 linux-nvme@lists.infradead.org
References: <oracle/ktls-utils/push/refs/tags/ktls-utils-1.0.0/000000-c787cd@github.com>
 <32e4bd99-a85f-4f53-94bd-b8c3ecf2c66f@oracle.com>
 <aBoCELZ_x-C4talt@infradead.org>
 <cc795966-8c09-48ed-80e4-c70ff4143202@suse.de>
 <aBog09quIh39IL3W@infradead.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <aBog09quIh39IL3W@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_023714_242908_A1171853 
X-CRM114-Status: UNSURE (   9.46  )
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

On 5/6/25 16:46, Christoph Hellwig wrote:
> On Tue, May 06, 2025 at 03:03:10PM +0200, Hannes Reinecke wrote:
>> Hmm. We do that already:
>>
>>          dev_dbg(nctrl->device, "queue %d: start TLS with key %x\n",
>>                  qid, pskid);
>>          memset(&args, 0, sizeof(args));
>>          args.ta_sock = queue->sock;
>>          args.ta_done = nvme_tcp_tls_done;
>>          args.ta_data = queue;
>>          args.ta_my_peerids[0] = pskid;
>>          args.ta_num_peerids = 1;
>>          if (nctrl->opts->keyring)
>>                  keyring = key_serial(nctrl->opts->keyring);
>>          args.ta_keyring = keyring;
>>          args.ta_timeout_ms = tls_handshake_timeout * 1000;
>>          queue->tls_err = -EOPNOTSUPP;
>>          init_completion(&queue->tls_complete);
>>          ret = tls_client_hello_psk(&args, GFP_KERNEL);
>>
>> ... but we never evaluate the 'keyring' parameter from tlshd.
>> Should be easy enough to fix.
> 
> That is only used to link the keyrind in tls_handshake_private_keyring
> and never passed over netlink.
> 
> 
ktls-utils pull request #94.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

