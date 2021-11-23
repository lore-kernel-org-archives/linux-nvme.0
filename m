Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6253AC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Nov 2021 16:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uOrxbQlFM+bzmMhNXnSyo79bBRJLFpr/FR8h/jW2fXo=; b=W5QOgph3rJ/TsrFGYfih8nt3tt
	rDnkta/HBNg37/HBxYwcbYWXSpeLiCWeErHTBIBJLNqTB8rkbZZRCXuUq7ZE2ToAcIaAj+D+yfBbV
	PSmdeiXSy/aauBnJAUuarvndLDHASp4pe0CbtmkBl7+afXItF3hpKHZa5N2CfnY9pq2UzaYXsIwOP
	6n0jWmY6TJzdTFXIOj4P8AWFEhD4fEkiD3B5mmr46P7XbkEX8dseVa8G86Hb65AOU07mpXnGYiQ5l
	I1TTzZVJqtNuu0GYNb1wQ6ybgZPxIm/zEeHkvfzeaPqrTUsMrbOnZ3oBFSIaOpOqy7trm1f3U8hTT
	HOEW+1BQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mpYoM-002vog-Bg; Tue, 23 Nov 2021 16:38:26 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mpYoK-002vm6-Cu
 for linux-nvme@lists.infradead.org; Tue, 23 Nov 2021 16:38:25 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A59A521954;
 Tue, 23 Nov 2021 16:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637685502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uOrxbQlFM+bzmMhNXnSyo79bBRJLFpr/FR8h/jW2fXo=;
 b=qnB9nESzOnX7c5l/bqOHrDxDqytG2Dnv7ErJiIVpLv5otCMTCs72YMmX/RCq+nU7Ck5HlL
 KpyZD6/BPOjEk4+xAW0N7zkN1HaU304b8QfPDhnCrqDJio0jTF0/dpAAXrrkUqTvqAi0DK
 Kdbkt/J+Lvrz08v3lbYsv+Rj5ST1zp4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637685502;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uOrxbQlFM+bzmMhNXnSyo79bBRJLFpr/FR8h/jW2fXo=;
 b=mPfOeOzONe53MkdQQUnxw6JkuISmejyqPcQ3xvUAsTuCAyh4ytXYQkksfgD19p44Q7K5tU
 i2ji/mkdkKS1rNCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 884C313E38;
 Tue, 23 Nov 2021 16:38:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id W3JGIP4YnWHJaAAAMHmgww
 (envelope-from <hare@suse.de>); Tue, 23 Nov 2021 16:38:22 +0000
Subject: Re: [PATCH] nvme: print out valid arguments when reading from
 /dev/nvme-fabrics
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20211119083912.38260-1-hare@suse.de>
 <20211123162204.GB23957@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <36c5cc0c-f12b-b63a-89ca-d1d3971e7e61@suse.de>
Date: Tue, 23 Nov 2021 17:38:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211123162204.GB23957@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211123_083824_634792_C57AFD41 
X-CRM114-Status: GOOD (  18.00  )
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

On 11/23/21 5:22 PM, Christoph Hellwig wrote:
> The subject should use a nvme-fabrics prefix.
> 
>> +		const struct match_token *tok;
>> +		int idx;
>> +
>> +		for (idx = 0; idx < ARRAY_SIZE(opt_tokens); idx++) {
>> +			tok = &opt_tokens[idx];
>> +			if (tok->token == NVMF_OPT_ERR)
>> +				continue;
>> +			if (idx)
>> +				seq_puts(seq_file, ",");
>> +			seq_puts(seq_file, tok->pattern);
>> +		}
>> +		seq_puts(seq_file, "\n");
> 
> A helper for this logic would be nice.  Also shouldn't be there
> some kind of token to distinguish from the case where a controller
> has already been created?
> 
Helper: sure.
But we don't need to distinguish the case where the controller has 
already been created as this is handled by the if condition further up.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

