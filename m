Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD8E5C41535
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Dec 2023 12:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UMm1DoyaPpwpo+PnKPhoSryClnHczDpt/CiQSSO2zzQ=; b=M/DQlxXyhfj73ZUyoLPggQ3J/A
	uCKKA8qak6QvvvF8am4CBN+s485kK/Dkz1loLQ2kPvJjXpTkbu6rmOrbOwl/2mZt1Q9rqcmLm93cs
	HU/0sIWIl6ykZM3YMXc7gTsgOgQ8aT52sNAUDxBZggbxK8/URAaG7ZzmF+memaQ3JD9NPUEiEDVu1
	oxMoGRFO5Gn5sMj95MSi3p50Itc5cSzGUb3XAxHzOEgTwCcAa5B9cRFO6NY2nNnUfXTTR+F0W9LfU
	MDziiruMdsrZTiwh0BYQCfSEoX8vZfQ3p0CSzQ0lWwNEZwGE8DBEJLmFxJ1tIuBkdA2H7ejU28LGo
	YAGn+IYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGeef-005w5E-2c;
	Fri, 22 Dec 2023 12:29:29 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGeea-005w1u-2j
	for linux-nvme@lists.infradead.org;
	Fri, 22 Dec 2023 12:29:27 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8421A21DF2;
	Fri, 22 Dec 2023 12:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703248160; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UMm1DoyaPpwpo+PnKPhoSryClnHczDpt/CiQSSO2zzQ=;
	b=G+KESr+4QqDv3X7UPtdbcA1OrFFGLBIQpl2tKJJ+6nyJeF1yxxuMef3XMfis5LJTXGU4Kr
	g7NPzz5wzzLf54iPqO0rN+Ga+WrYI4TGgXUKJRfldnM7OcJrSRwBwx0J1weiHDSWSY4ROm
	4CpBfYbyLFiIVz6nm0mYIxRKs6upmgw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703248160;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UMm1DoyaPpwpo+PnKPhoSryClnHczDpt/CiQSSO2zzQ=;
	b=80k/polCmLLhXHxesfwmjw4jzS06xdUoyHTmLJxbOAfsvBYmiSsxga0FDMw0n9Sf9IZXJv
	bCCpGzOZBB3Y/yCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703248160; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UMm1DoyaPpwpo+PnKPhoSryClnHczDpt/CiQSSO2zzQ=;
	b=G+KESr+4QqDv3X7UPtdbcA1OrFFGLBIQpl2tKJJ+6nyJeF1yxxuMef3XMfis5LJTXGU4Kr
	g7NPzz5wzzLf54iPqO0rN+Ga+WrYI4TGgXUKJRfldnM7OcJrSRwBwx0J1weiHDSWSY4ROm
	4CpBfYbyLFiIVz6nm0mYIxRKs6upmgw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703248160;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UMm1DoyaPpwpo+PnKPhoSryClnHczDpt/CiQSSO2zzQ=;
	b=80k/polCmLLhXHxesfwmjw4jzS06xdUoyHTmLJxbOAfsvBYmiSsxga0FDMw0n9Sf9IZXJv
	bCCpGzOZBB3Y/yCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 22B5C13997;
	Fri, 22 Dec 2023 12:29:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rlTOBiCBhWU2EQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 22 Dec 2023 12:29:20 +0000
Message-ID: <4f03e599-2772-4eb3-afb2-efa788eb08c4@suse.de>
Date: Fri, 22 Dec 2023 13:29:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Large block for I/O
Content-Language: en-US
To: Viacheslav Dubeyko <slava@dubeyko.com>,
 Bart Van Assche <bvanassche@acm.org>, Matthew Wilcox <willy@infradead.org>
Cc: lsf-pc@lists.linuxfoundation.org, linux-mm@kvack.org,
 linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <7970ad75-ca6a-34b9-43ea-c6f67fe6eae6@iogearbox.net>
 <4343d07b-b1b2-d43b-c201-a48e89145e5c@iogearbox.net>
 <03ebbc5f-2ff5-4f3c-8c5b-544413c55257@suse.de>
 <5c356222-fe9e-41b0-b7fe-218fbcde4573@acm.org>
 <BB694C7D-0000-4E2F-B26C-F0E719119B0C@dubeyko.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <BB694C7D-0000-4E2F-B26C-F0E719119B0C@dubeyko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.30 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=G+KESr+4;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="80k/polC"
X-Rspamd-Queue-Id: 8421A21DF2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231222_042925_064707_3082B3CF 
X-CRM114-Status: GOOD (  26.74  )
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

On 12/22/23 09:23, Viacheslav Dubeyko wrote:
> 
> 
>> On Dec 21, 2023, at 11:33 PM, Bart Van Assche <bvanassche@acm.org> wrote:
>>
> 
> <skipped>
> 
>>> .
>>
>> Hi Hannes,
>>
>> I'm interested in this topic. But I'm wondering whether the disadvantages of
>> large blocks will be covered? Some NAND storage vendors are less than
>> enthusiast about increasing the logical block size beyond 4 KiB because it
>> increases the size of many writes to the device and hence increases write
>> amplification.
>>
> 
> I  am also interested in this discussion. Every SSD manufacturer carefully hides
> the details of architecture and FTL’s behavior. I believe that switching on bigger
> logical size (like 8KB, 16KB, etc) could be even better for SSD's internal mapping
> scheme and erase blocks management. I assume that it could require significant
> reworking the firmware and, potentially, ASIC logic. This could be the main pain
> for SSD manufactures. Frankly speaking, I don’t see the direct relation between
> increasing logical block size and increasing write amplification. If you have 16KB
> logical block size on SSD side and file system will continue to use 4KB logical
> block size, then, yes, I can see the problem. But if file system manages the space
> in 16KB logical blocks and carefully issue the I/O requests of proper size, then
> everything should be good. Again, FTL is simply trying to write logical blocks into
> erase block. And we have, for example, 8MB erase block, then mapping and writing
> 16KB logical blocks looks like more beneficial operation compared with 4KB logical
> block.
> 
> So, I see more troubles on file systems side to support bigger logical size. For example,
> we discussed the 8KB folio size support recently. Matthew already shared the patch
> for supporting 8KB folio size, but everything should be carefully tested. Also, I experienced
> the issue with read ahead logic. For example, if I format my file system volume with 32KB
> logical block, then read ahead logic returns to me 16KB folios that was slightly surprising
> to me. So, I assume we can find a lot of potential issues on file systems side for bigger
> logical size from the point of view of efficiency of metadata and user data operations.
> Also, high-loaded systems could have fragmented memory that could make the memory
> allocation more tricky operation. I mean here that it could be not easy to allocate one big
> folio. Log-structured file systems can easily aligned write I/O requests for bigger logical
> size. But in-place update file systems can increase write amplification for bigger logical
> size because of necessity to flush bigger portion of data for small modification. However,
> FTL can use delta-encoding and smart logic of compaction several logical blocks into
> one NAND flash page. And, by the way, NAND flash page usually is bigger than 4KB.
> 
And that is actually a very valid point; memory fragmentation will 
become an issue with larger block sizes.

Theoretically it should be quite easily solved; just switch the memory 
subsystem to use the largest block size in the system, and run every 
smaller memory allocation via SLUB (or whatever the allocator-of-the-day
currently is :-). Then trivially the system will never be fragmented,
and I/O can always use large folios.

However, that means to do away with alloc_page(), which is still in 
widespread use throughout the kernel. I would actually in favour of it,
but it might be that mm people have a different view.

Matthew, worth a new topic?
Handling memory fragmentation on large block I/O systems?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


