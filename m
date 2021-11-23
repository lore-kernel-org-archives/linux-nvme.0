Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E23C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Nov 2021 17:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RIYYmA24Gl1gE9yeKkwxGRiYoJICqZeRGBY5Uld6p9Q=; b=aWLial6RETpZM6X+OhkeyyARkq
	io0GHiXsPJT6+fWkLEnLrqv8E0R96SYwK4zpW/aAe4gaueqaSGZNtq8j7tQg6MMfPaYlPbJY7rBbb
	u436NciWdsOilzGf9ihRMQjt98hz9NjwJN5x6zUrGSN3D3H+mZuEcNwciJv43VJ/u2gFku63pZHpk
	ivAmKNPtthrgv56bTUlBm9mhX3NVRj9MS6v7Tg9PPYLY8vfnUQZ6/dujdzxsPfa2CK2bl+kxTZ7rk
	k+T2M7/NX7iu6BeDOvXOHMwaS8DDEFwVyUm2NSvMQr/dpv4xb2j5HzdQw/a4XzM1E1jbCZAsmRkql
	ZP+98OIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mpZDa-00311T-EE; Tue, 23 Nov 2021 17:04:30 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mpZDU-0030wp-MY
 for linux-nvme@lists.infradead.org; Tue, 23 Nov 2021 17:04:29 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5C3D11FD5A;
 Tue, 23 Nov 2021 17:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637687036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RIYYmA24Gl1gE9yeKkwxGRiYoJICqZeRGBY5Uld6p9Q=;
 b=AU/AJzifKHWoCOYDI6ByCKseYSiJN0QZHpiCyDtGl2CPFaJLgXr6L2BFhVDhYGx6xEv4zD
 29RI+6gGZTyIk9AnUdiaKjZLRyQHBG2wR84wEVeB6o4v1TNYEJ2tz+tC5n7M2HcIlOOlJZ
 ocdFhBRgEnQaoWx4xr9S+UNj0JjpQxU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637687036;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RIYYmA24Gl1gE9yeKkwxGRiYoJICqZeRGBY5Uld6p9Q=;
 b=QNvHlYUD4+4tlwmOnB44vp6dLFVw5svnCGf7E5owbJcoqUXjLYilBMaPawZnEXwjkdGqCy
 GZGSlSuup4TZKACA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3B6B013E2B;
 Tue, 23 Nov 2021 17:03:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id JSshDfwenWFucwAAMHmgww
 (envelope-from <hare@suse.de>); Tue, 23 Nov 2021 17:03:56 +0000
Subject: Re: [PATCH] nvme: print out valid arguments when reading from
 /dev/nvme-fabrics
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20211119083912.38260-1-hare@suse.de>
 <20211123162204.GB23957@lst.de>
 <36c5cc0c-f12b-b63a-89ca-d1d3971e7e61@suse.de>
 <20211123164222.GA24422@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <4d3c61a5-27db-7611-49ab-a25f00f40119@suse.de>
Date: Tue, 23 Nov 2021 18:03:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211123164222.GA24422@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211123_090424_907529_617D0392 
X-CRM114-Status: GOOD (  15.39  )
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

On 11/23/21 5:42 PM, Christoph Hellwig wrote:
> On Tue, Nov 23, 2021 at 05:38:22PM +0100, Hannes Reinecke wrote:
>> Helper: sure.
>> But we don't need to distinguish the case where the controller has already
>> been created as this is handled by the if condition further up.
> 
> Well, a token that the reader clearly sees that there is no controller
> yet
> 
Ah. That. Sure, can do.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

