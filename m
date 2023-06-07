Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02234C77B7A
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jun 2023 13:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wEe7ym7DG6+ReBAqtJb3Db8VZpiGpFPixKb9/k6VjEM=; b=WCYFyLQLniph4tlqbIBDvGa2XI
	YVuS4edIw3Z5X7Sm30cFCOks5vGaGWE8czUHPBCKSyYNktyKBt+91SzyZXVcrrG+F4LzfNxoW7acP
	fkW0Id8EIUMy1swfa/OrAAnYYuB2f2vVWwJXmZ8epAThPMJ8o0qS9XVkJZ55RUkmKI0WB/Ys/SNVe
	RxeSwRAzuleaJH7FdCnytaCKgqlOwtzCLJKPYwenr32B/EP1ADSGAGdwiN+0Fd2yGUfRXBHtFVSlr
	uwJ3EJzo14KcnNsdzg9Gtlj/CK/yNNjNbhx9WyR2qbA5ufToNR7tsnXGq0B80578Oa6fslngSNtbz
	XpynX6DA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6t0q-00647I-0U;
	Wed, 07 Jun 2023 13:15:44 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6t0m-006457-1g;
	Wed, 07 Jun 2023 13:15:42 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C5CB41FDAB;
	Wed,  7 Jun 2023 13:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1686143736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wEe7ym7DG6+ReBAqtJb3Db8VZpiGpFPixKb9/k6VjEM=;
	b=N0dwib7zQJVE0ULFBPC0sfkg/Jge+HIDAw84X+zwwrRYM1SykrGWO8FjFFKpN4AmJjRbx4
	/4iCJ59NZj9pixMFJN353suhvUtbV0nQwz3/3vjLJBmBOXWzcQM9fpiiVasmuBLvAOL+mE
	qCIwNxgxfEM9lUrK7xUKYDh6P8ZS15g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1686143736;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wEe7ym7DG6+ReBAqtJb3Db8VZpiGpFPixKb9/k6VjEM=;
	b=6IBoqKo78nF4JFonmwwaXhneF6sFwiKgyR6/7kqsbB1BpRbIFiX4U3XRFI3zNWu5vhIuxP
	RRp2kVdb3eXiQmDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 74F201346D;
	Wed,  7 Jun 2023 13:15:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id ZokEHPiCgGSCYQAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 07 Jun 2023 13:15:36 +0000
Message-ID: <36637ff7-1893-fe1a-bce7-5b1ef45f4839@suse.de>
Date: Wed, 7 Jun 2023 15:15:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 31/31] fs: remove the now unused FMODE_* flags
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
 <20230606073950.225178-32-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230606073950.225178-32-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_061540_708369_F2906CAC 
X-CRM114-Status: GOOD (  11.79  )
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
> FMODE_NDELAY, FMODE_EXCL and FMODE_WRITE_IOCTL were only used for
> block internal purposed and are now entirely unused, so remove them.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   include/linux/fs.h | 7 -------
>   1 file changed, 7 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes


