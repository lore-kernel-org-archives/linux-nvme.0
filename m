Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C623C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Feb 2022 13:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ulFfKXoRq8QJukyKpX0WjkN9+vmh3h2i2KxS5J3haRQ=; b=jWKe2zy5s0NI7uJ3miG7UvISC2
	K70niN3KFxELG+ZbmdPBcRw8xv2tELsotxlBmOhF6xK6xhn+VRbQrB9yTsSZL/Huqr2Et3kWEm/F2
	ImUW/m0vSSMkSihQhemuTmZAZ8JgEQMmpzFrO4TKHY1BE3EED3k+BiXpujEnelle8S7KPzqqLPBfW
	z+XlFQLN6LOu81iAU8i6TykpHtCXudulE5YGgPpGoCSrEkVTmYYmyCtBD0WkCGnzZdHKofR67EKcS
	ktEj2YiugzJEIOGmQaRtUF1l3euIiHFEkjyWXxIrqkBBbQGPYmbfDA67BqpZLKfON3V5oBiHJbXg5
	KS9XgFrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFFXm-00FKgF-QH; Wed, 02 Feb 2022 13:19:30 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFFXj-00FKeo-Fv
 for linux-nvme@lists.infradead.org; Wed, 02 Feb 2022 13:19:28 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 34DEB212B5;
 Wed,  2 Feb 2022 13:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643807966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ulFfKXoRq8QJukyKpX0WjkN9+vmh3h2i2KxS5J3haRQ=;
 b=DGEwghLPcWpzoCyyuOkZszuDl1Q8nqded/8dPqG8Q4YU7UWvuMuws+oda0lX7DvFwZ+65W
 XLmqjEpMg3A4TrGv93zlxgQ+Qy09zlx1ClX33wXVIJnWV+LhMQb61MKYsIUi4IlLy2c44/
 lsHCp3gnEtoVC69tYvIoR77t/2E1jZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643807966;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ulFfKXoRq8QJukyKpX0WjkN9+vmh3h2i2KxS5J3haRQ=;
 b=MK6+KnaE5ttkGnMgjHwh7+EWvFddHB6ebwBy9l80HtxfBniDhBKSGdFapKAUgiUVemN/AT
 0MJWjC+AmEHj1gCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 23CC913E48;
 Wed,  2 Feb 2022 13:19:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id GJBXCN6E+mFeQwAAMHmgww
 (envelope-from <hare@suse.de>); Wed, 02 Feb 2022 13:19:26 +0000
Message-ID: <7a8e472b-8534-957e-6c32-49d3b919f382@suse.de>
Date: Wed, 2 Feb 2022 14:19:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCHv2 6/7] block: add pi for nvme enhanced integrity
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com, colyli@suse.de
References: <20220201190128.3075065-1-kbusch@kernel.org>
 <20220201190128.3075065-7-kbusch@kernel.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220201190128.3075065-7-kbusch@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220202_051927_704389_F02142E0 
X-CRM114-Status: GOOD (  11.09  )
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

On 2/1/22 20:01, Keith Busch wrote:
> The NVMe specification defines larger data integrity formats beyond the
> t10 tuple. Add support for the specification defined CRC64 formats,
> assuming the reference tag does not need to be split with the "storage
> tag".
> 
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   block/Kconfig          |   1 +
>   block/t10-pi.c         | 194 +++++++++++++++++++++++++++++++++++++++++
>   include/linux/t10-pi.h |  20 +++++
>   3 files changed, 215 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

