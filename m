Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61BA1CA0ED1
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Aug 2025 07:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lCx52BTFQyVkdB/6lQFOfEoZYCvJwp1Eh/Bzcrwmn/Y=; b=l5oUNW7mf86cgnbiAHOSF+i5Ns
	ORQRoWbQHTaEVI+yu24TaM/bLnn4rGtkS94Q2Iwllf6/Tph+x5B1o7v+Sj3qmaGKNTy2U5nFuWnuD
	JR5yCV23b7GF/Y0xB15Uqs4HgpE4fLZbA9wc6jhn8LcKgyR0TVsR23r2ByJcdqUzQ97U20Qx86/c8
	PWbyP6p0pOo4q8axgi727vjShG6DZbA+8WW3ShA+9FRRfSRzbpS2dFU+nJ6XOtOrJWEDAf67qOn5C
	DKGz729uu0hbd4h4PW43z+sGmPl4IxFGWxjxCN5r5IiKwcpMRDzOeDayagu15AaP/rbECwLO4ZsTe
	//ig/P+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unuei-00000006pz5-0G94;
	Mon, 18 Aug 2025 07:51:48 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unuH0-00000006mjp-2Bok
	for linux-nvme@lists.infradead.org;
	Mon, 18 Aug 2025 07:27:19 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CABB41F387;
	Mon, 18 Aug 2025 07:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755502036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lCx52BTFQyVkdB/6lQFOfEoZYCvJwp1Eh/Bzcrwmn/Y=;
	b=NsubL6MZerty1Vi8BWjg/Vj9dVWaKz1HNKf9kMuGXo9jkDSdaglF3EgZa7CCh3Hp0O/5Wf
	NQ7t3RmKnJZEJ3PuWKE0qVgrPHn/4GqObDQdz1db+m4akUeHyluxujnjaqcIrLX1tiapGG
	gWXc1X+oqny9Pvq/T6iR1cE58f2sAKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755502036;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lCx52BTFQyVkdB/6lQFOfEoZYCvJwp1Eh/Bzcrwmn/Y=;
	b=qoUriL0XwwDTDcZC38GEIsFQ3Id+0QOg+kYWniNbLHQ1AvqPDqW5Qev1wevjvmGj2v1zJD
	oJTNtWSPKUCgCrAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NsubL6MZ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qoUriL0X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755502036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lCx52BTFQyVkdB/6lQFOfEoZYCvJwp1Eh/Bzcrwmn/Y=;
	b=NsubL6MZerty1Vi8BWjg/Vj9dVWaKz1HNKf9kMuGXo9jkDSdaglF3EgZa7CCh3Hp0O/5Wf
	NQ7t3RmKnJZEJ3PuWKE0qVgrPHn/4GqObDQdz1db+m4akUeHyluxujnjaqcIrLX1tiapGG
	gWXc1X+oqny9Pvq/T6iR1cE58f2sAKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755502036;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lCx52BTFQyVkdB/6lQFOfEoZYCvJwp1Eh/Bzcrwmn/Y=;
	b=qoUriL0XwwDTDcZC38GEIsFQ3Id+0QOg+kYWniNbLHQ1AvqPDqW5Qev1wevjvmGj2v1zJD
	oJTNtWSPKUCgCrAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8604913A55;
	Mon, 18 Aug 2025 07:27:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zEbSHNTVomiTEwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 18 Aug 2025 07:27:16 +0000
Message-ID: <e99748f0-ed6e-496a-8f08-14f332f174ec@suse.de>
Date: Mon, 18 Aug 2025 09:27:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 3/4] nvme: add common APIs for printing tabular format
 output
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, kbusch@kernel.org, gjoyce@ibm.com
References: <20250812125614.164445-1-nilay@linux.ibm.com>
 <20250812125614.164445-4-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250812125614.164445-4-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: CABB41F387
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250818_002718_706949_9916EC0F 
X-CRM114-Status: GOOD (  21.85  )
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

On 8/12/25 14:56, Nilay Shroff wrote:
> Some nvme-cli commands, such as nvme list and nvme list -v, support output
> in tabular format. Currently, the table output is not well aligned because
> column widths are fixed at print time, regardless of the length of the data
> in each column. This often results in uneven and hard-to-read output.For
> any new CLI command that requires tabular output, developers must manually
> specify the column width and row value width, which is both error-prone and
> inconsistent.
> 
> This patch introduces a set of common table APIs that:
> - Automatically calculate column widths based on the content
> - Maintain proper alignment regardless of value length
> - Simplify adding tabular output support to new and existing commands
> 
> The new APIs are:
> 1. table_init() — Allocate a table instance.
> 2. table_add_columns() — Add column definitions (struct table_column),
>     including name and alignment (LEFT, RIGHT, CENTERED).
> 3. table_get_row_id() — Reserve a row index for inserting values.
> 4. table_add_row() — Add a row to the table.
> 5. table_print() — Print the table with auto-calculated widths.
> 6. table_free() — Free resources allocated for the table.
> 
> For adding values, the following setter APIs are provided, each
> supporting alignment types (LEFT, RIGHT, or CENTERED):
> - table_set_value_str()
> - table_set_value_int()
> - table_set_value_unsigned()
> - table_set_value_long()
> - table_set_value_unsigned_long()
> 
> Usage steps:
> 1. Call table_init() to create a table handle.
> 2. Define an array of struct table_column specifying column names and
>     alignment, then call table_add_columns().
> 3. Obtain a row ID using table_get_row_id() and set values using the
>     appropriate setter table APIs : table_set_value_*() function.
> 4. Add the completed row using table_add_row().
> 5. Repeat steps 3–4 for each additional row.
> 5. Call table_print() to display the table.
> 6. Call table_free() to release table resources.
> 
> With these APIs, developers no longer need to pre-calculate column or row
> widths. The output is consistently aligned and easy to read.
> 
> Suggested-by: Daniel Wagner <dwagner@suse.de>
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   util/meson.build |   3 +-
>   util/table.c     | 278 +++++++++++++++++++++++++++++++++++++++++++++++
>   util/table.h     | 117 ++++++++++++++++++++
>   3 files changed, 397 insertions(+), 1 deletion(-)
>   create mode 100644 util/table.c
>   create mode 100644 util/table.h
> 
Sheesh. Can o'worms.

Displaying a table on an ASCII terminal is black magic (check
manpage for ncurses ...), and I'm pretty certain that printing
spaces for alignment is _not_ the way to go.
If you really want to implement this then at the very least use
tabs. Ideally check with the ncurses manpage how one can display
a table with the correct escape characters.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

