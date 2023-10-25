Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91756C25B47
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Oct 2023 06:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LKf527QDKA1/5ZquYgTSoBOfyqoeO5hVypS2OexNT8U=; b=JtVFHxUvE904QgpboUttPGsDxx
	FFJvvtX8qBCWi8ZCNGuVxjeQZY7fHqO67ta4jKUKoqSvm3ZmSLqvpaQ4fMS21oSyBAxS1IyXFHMGo
	XVmXrtG9znwsRh+7NZ/t3uFxk6tZi0o7UUe7HqQ0BoCIX10KRr64zcvKwpuaPVFEPkDDs+vwvRxCd
	cwkGmB1F4C3sFvsvge/UHy53b79CWABnmZ1Sl7yUxI3oHA8Hr5zYYUBbHLVOBRfVPUHzvZLVyHZCI
	ucFZpSMPdx71o4pad4+cEI1KCjlLWekpuztc41+TprO6UIH+/oyy3QsW7NABVPKdtYRJUguxcLa2u
	rQzunaow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qvXSA-00BUdj-15;
	Wed, 25 Oct 2023 06:33:18 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qvXS8-00BUcw-0h
	for linux-nvme@lists.infradead.org;
	Wed, 25 Oct 2023 06:33:17 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E10FB1FF19;
	Wed, 25 Oct 2023 06:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1698215588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LKf527QDKA1/5ZquYgTSoBOfyqoeO5hVypS2OexNT8U=;
	b=NeK8/4oz3iPBAXaLdN1ODbn0/ZNjY1A7UVmyFtwHcxqRoTVxLSgyoabKpcsshwQRvnlIIe
	WdH4npgjuY+/GW+CAPL5phRvUwFKAVkGoGpyZDUY3AXfe6HkmvgtxoZEfWX+iGwZrKwlQG
	07JiAE8ZtKGACCS5/lIF7lEHhceGlnQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1698215588;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LKf527QDKA1/5ZquYgTSoBOfyqoeO5hVypS2OexNT8U=;
	b=mOoz4eUQajxJbKgl6M1puu+MBU4V6hdtMejovqaEm5Br/CVyuF9Dq58inAztEaTxPWC6Zw
	ltEV6quIiWXu7VBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 66D0B13524;
	Wed, 25 Oct 2023 06:33:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id iOxhEKS2OGV+RQAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 25 Oct 2023 06:33:08 +0000
Message-ID: <7d2e149e-f965-4e06-ac9d-faedeac74046@suse.de>
Date: Wed, 25 Oct 2023 08:33:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] nvme-tcp: always set valid seq_num in dhchap reply
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, Mark O'Donovan <shiftee@posteo.net>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 sagi@grimberg.me, hch@lst.de, axboe@kernel.dk
References: <20231023140003.58019-1-shiftee@posteo.net>
 <ZTfzetR5o_RUfJGK@kbusch-mbp>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZTfzetR5o_RUfJGK@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231024_233316_403045_ECB52B15 
X-CRM114-Status: GOOD (  13.69  )
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

On 10/24/23 18:40, Keith Busch wrote:
> On Mon, Oct 23, 2023 at 02:00:00PM +0000, Mark O'Donovan wrote:
>> The first patch is a small unrelated fix which makes it clear that the
>> response data section of the Success1 message is not optional.
>>
>> The second patch removes use of the host sequence number (S2) as an
>> indicator of bi-directional authentication.
>>
>> The third patch causes us to always set the host sequence number (S2)
>> to a non-zero value instead of the 0 value reserved for the secure
>> channel feature.
> 
> Should these go in now for 6.6? We're pretty close to the end. If for
> 6.7, there is a merge conflict that I think would be easiest resolved if
> I wait until the block tree resyncs after the 6.7 merge window opens.
> 
I'd suggest to wait, as we'll need to fixup nvmet, too.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


