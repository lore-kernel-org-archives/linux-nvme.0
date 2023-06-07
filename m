Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D510C7EE25
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jun 2023 12:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6awWd81MfbQpPECmTEMQsvwsJnzU0bGaP6n4z8ueT+o=; b=G3PqhnNFe02YWWx8s5NAm4PyGH
	puxwbhJUCx3tfFQz2k8IcIYAOSks5Sx3qtj7Zb6OJHiowN4bBgbsrJUD+HCYWZJNO6/zHVGdfNOCE
	31HxVaCvZmEO9N81GpRoJwtQVmf9xnVjQeGEJSTUlDVOaSv5wRi+AKR3Vr9qm1TXoH8mrULcT515l
	tWRktyJKk4l0iha9ZhwnHXW8ugi+nQVCxP6AE/7jbG1WKb5N0ME+pZGvGXrCiiuzhQZlEMEvystF0
	bgxq7C32TBfV0ax7fr8A4pfj867TxcpoT5UX2iPvdEJWoCLTNHbypWi6RfFXg7J75IN1j04jIV8Jn
	1mB/oNnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6sIk-005uOG-2y;
	Wed, 07 Jun 2023 12:30:10 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6sIf-005uLQ-2b;
	Wed, 07 Jun 2023 12:30:09 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E25A01FDAC;
	Wed,  7 Jun 2023 12:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1686141003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6awWd81MfbQpPECmTEMQsvwsJnzU0bGaP6n4z8ueT+o=;
	b=o6WC3BuTLL9OO8DdyBhJYmvOn/cp9vADoKFzPsAr0RP/r8bQecDsCmXoqw9heD81sUEORn
	gKgDvsR/JHpiUeyd8QwMbjKMcycA8o1Zlgo58T8tPF5Mo4UB1SwKujcqqI8pPELo8Gwrn9
	cSpSgIe8zihh7U4pq74OJvGBxyVPI7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1686141003;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6awWd81MfbQpPECmTEMQsvwsJnzU0bGaP6n4z8ueT+o=;
	b=TXDqVthNZi6seMbjS6wxpowzv9W/n8Z0FerCL6qlCgHqla7KkeoDrJ8qOT7OA2E2CE8TeL
	BytBOFX89JhkztCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9F79413776;
	Wed,  7 Jun 2023 12:30:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id cnA9Jkt4gGSORgAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 07 Jun 2023 12:30:03 +0000
Message-ID: <6c9d0bb0-ec67-0d40-9017-0cd9267f23c4@suse.de>
Date: Wed, 7 Jun 2023 14:30:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 17/31] block: add a sb_open_mode helper
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Richard Weinberger <richard@nod.at>, Josef Bacik <josef@toxicpanda.com>,
 "Md. Haris Iqbal" <haris.iqbal@ionos.com>, Jack Wang <jinpu.wang@ionos.com>,
 Phillip Potter <phil@philpotter.co.uk>, Coly Li <colyli@suse.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
 linux-block@vger.kernel.org, linux-um@lists.infradead.org,
 linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
 linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-18-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230606073950.225178-18-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_053005_991121_5FAA727D 
X-CRM114-Status: GOOD (  12.74  )
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

On 6/6/23 09:39, Christoph Hellwig wrote:
> Add a helper to return the open flags for blkdev_get_by* for passed in
> super block flags instead of open coding the logic in many places.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/super.c       |  5 +----
>   fs/nilfs2/super.c      |  7 ++-----
>   fs/super.c             | 15 ++++-----------
>   include/linux/blkdev.h |  7 +++++++
>   4 files changed, 14 insertions(+), 20 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes


