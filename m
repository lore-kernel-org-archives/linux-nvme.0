Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6771C7EE25
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jun 2023 12:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y5/re5ZKHhf+HsiKoBHJy9sV78dj7UGjrSWHzTtQwHY=; b=CxQHVrfcj3i76GW2f8liem28kp
	hnUlfduD6+4+eCHpg80ZWMJjBK0rXFTZvlZ/NQH7m0ioOKyDR5Bli8rqUwzNbTNVYA1m1QL0GkELv
	OC6fJzxa+PfyAjISdVIsQy9KnZUWPMZCLx5qEnF5Lubv8QWj3WjEy3yg9kj5SYiveuvZC5YHmLtdz
	txP+nyRBx3xmxyS+P8cUUSsbKbcSxDfJEF1NcDldtIzn9SeaE+qLK6c3rki8BoAOX/47+Urh9vWoG
	dd3d6zhjUVWdP18SaZvPjLiFxoONq7echqRP3W0WHxH0GeA40tIoG0zNqcIL/FX/4vxHQYYhZswNR
	ZYvVcMvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6sBN-005rWA-2z;
	Wed, 07 Jun 2023 12:22:33 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6sBK-005rU8-1Z;
	Wed, 07 Jun 2023 12:22:31 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0E1EE1FDAC;
	Wed,  7 Jun 2023 12:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1686140549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y5/re5ZKHhf+HsiKoBHJy9sV78dj7UGjrSWHzTtQwHY=;
	b=qvZ+tg3HOwDwgvlodDLQayhC5NPnqUtDyXNxfLFWZMX7Q6Zh5MwQdKIV6Vs4PUgW+Ar4aw
	NH2pny9sYDrFlo5nd7lOygNm+OvUPAkOaAeuXW6BJ30lokNS8kdN2s3N2OLQpHh7zY3Wj2
	A3G7JXYPchjGSP+aCqzbNbEc6weWD4Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1686140549;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y5/re5ZKHhf+HsiKoBHJy9sV78dj7UGjrSWHzTtQwHY=;
	b=TBqgiJLiiypHLRGDDE9OJ7AcoFCL4AQWePcbCTYugUg9aHOr0dyrV6pl6bTOOmNJb6mMnq
	9WkSdFkXCITQkMCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C8A1013776;
	Wed,  7 Jun 2023 12:22:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id BNyqMIR2gGRgQgAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 07 Jun 2023 12:22:28 +0000
Message-ID: <bcce493a-9090-8520-f8c6-c9b14754e20e@suse.de>
Date: Wed, 7 Jun 2023 14:22:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 12/31] swsusp: don't pass a stack address to
 blkdev_get_by_path
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
 <20230606073950.225178-13-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230606073950.225178-13-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_052230_672457_7CA0819E 
X-CRM114-Status: GOOD (  12.51  )
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
> holder is just an on-stack pointer that can easily be reused by other calls,
> replace it with a static variable that doesn't change.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   kernel/power/swap.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes


