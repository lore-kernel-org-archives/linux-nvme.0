Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC888C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Feb 2022 15:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zbdy6hJHDF/2mJsn5QvJwk5ZRTiby8DvmOJZl2ko1y8=; b=AzVKWHdQCsWoDdvfgZIuFHlMch
	Z36lkLSajTXQB78W8hPuKwNj90Pmpp/j+2iMOiI8hSxRDMgDMtJoA9bi04kSdDgmP0lS7kpy2Lu8r
	z6CuGYYXmEBymO/OhFWOQ8xHCnjf/FJedApsW1lgKEMkh6TOGWJ9TUIPZEUVWMoono5AXLgjSRyIy
	QwYMHgfLoWW752onx/X6loLMKMSWia/BbM31OqBuIEV/B7+2qvlZ96a2Aah2QNn2N+rKjLrxIRo9q
	zZsq2BwGHhfJ51Wq8pEIdm0OexBt3Vj7uaFilJyjZjjX+xjoy/ViCdZHl1//EzgR/F9y88zXYjflV
	IOpCZfZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKMHl-007VYl-92; Wed, 16 Feb 2022 15:32:05 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKMHe-007VXc-IQ
 for linux-nvme@lists.infradead.org; Wed, 16 Feb 2022 15:32:04 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2E8F221114;
 Wed, 16 Feb 2022 15:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1645025517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zbdy6hJHDF/2mJsn5QvJwk5ZRTiby8DvmOJZl2ko1y8=;
 b=lBZhU7lzds60u7O5YW7JsmfffYx1leYULjLRVd4jPFosK8T9tYrdcV/9TI9qSfnWwVL86W
 0o/DdwRve/nudORd4aMUn+FMdxd5/5F6GfGslvzQjUpPQ850IdOo8BiWxKP6Xu8+jpr5Vx
 vKNy3PC5B+8gGu+zboyBVEVcZD33f9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1645025517;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zbdy6hJHDF/2mJsn5QvJwk5ZRTiby8DvmOJZl2ko1y8=;
 b=+TE5Bzno6bmi0gB8v7sswCZgm8pWItk4MSo5FWnVH658Cm5ds1/Nc5jN5tOYik3fTYqLBX
 NOGOrExHP5VyCPBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1AE1413B15;
 Wed, 16 Feb 2022 15:31:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0YLsBe0YDWJ8MwAAMHmgww
 (envelope-from <hare@suse.de>); Wed, 16 Feb 2022 15:31:57 +0000
Message-ID: <6328baac-fe6f-f3ef-ca4b-d8c91b4a83ee@suse.de>
Date: Wed, 16 Feb 2022 16:31:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/2] block: skip the fsync_bdev call in del_gendisk for
 surprise removals
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, kbusch@kernel.org, markus.bloechl@ipetronik.com,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20220216150901.4166235-1-hch@lst.de>
 <20220216150901.4166235-2-hch@lst.de>
 <4f29d9a3-021c-f2f0-b452-e682fa1db459@suse.de>
 <20220216152019.GA19002@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220216152019.GA19002@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220216_073158_775350_6FED610E 
X-CRM114-Status: GOOD (  13.01  )
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

On 2/16/22 16:20, Christoph Hellwig wrote:
> On Wed, Feb 16, 2022 at 04:18:43PM +0100, Hannes Reinecke wrote:
>> My turn to be picky:
>> In the previous patch you use 'set_bit()' for GD_DEAD, which to my
>> knowledge doesn't imply a memory barrier.
>> Yet here you rely on that for the 'test_bit()' to return the correct/most
>> recent value.
>> Don't we need a memory barrier here somewhere?
> 
> Well, we only do the test to skip useless work.  A race is not a
> problem here.

Ok.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

