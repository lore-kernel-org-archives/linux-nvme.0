Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5B6C43219
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Apr 2022 12:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EwRuU3lN9KI8hyzt5BRGcUdxQu2aFhndVDrcib1zzbI=; b=HDzlAQNXFLRjc5ezPM6wKmvJTF
	J3jh4a5HM5FHe8/nfuSImcfF8rr3D0043novGsmoNoI5R4Q8zvgIyBZXgkms8OE6ss6ZZxNLk1U3o
	s+JXMjOZ6WDWevuX3XYn6xYl38DLZ1d0RbiHw3mAlwubH0cXaOx2Rd2rJXUnYi0KCbBHN6dlZ+aFh
	DpGZh44SzajHRa4d5d/enU9y44clhbPsNeRIMS8WeXZt1P5J/lA4RAhjfZ10IjUUfKYDUkeuMBd3/
	NvegUqgXrh7pxo2spO+yAXsc81apyuuSZ6K6vQlUQfPXsYHNhdHOtYTVMPWL5gl5kJzsL3M0VCkDj
	HMqWglRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njh8B-001Nmx-5M; Wed, 27 Apr 2022 12:50:55 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njf2j-000xM1-D3
 for linux-nvme@lists.infradead.org; Wed, 27 Apr 2022 10:37:10 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DE5591F747;
 Wed, 27 Apr 2022 10:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1651055827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EwRuU3lN9KI8hyzt5BRGcUdxQu2aFhndVDrcib1zzbI=;
 b=feYJC2od1AKLT8mJSoDbAoyzHedIgJQwZvNS3KNVkgnc7RzT6txrdyC7qHmbKtqm0eHZ1C
 nwtyIUFNi9tG48N+Y74qTSYSX6kwlgGkYQd3TgrHBB36BxazEEJwyWSiqJG/CA/Henk0as
 Q442kgxgzolK1QTcIhmgJfFSnVSSaYE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1651055827;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EwRuU3lN9KI8hyzt5BRGcUdxQu2aFhndVDrcib1zzbI=;
 b=Z5DGjHUwr8LqYy6Y4hmCD5vvVYHZlNaZpZ9cOR3X70LSGdN3HKPIIQ+uUPD5pElrFfGesW
 b/jCF0GqeLUhBNBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 942411323E;
 Wed, 27 Apr 2022 10:37:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id VQRnI9McaWJTBQAAMHmgww
 (envelope-from <hare@suse.de>); Wed, 27 Apr 2022 10:37:07 +0000
Message-ID: <a885def5-7373-28d9-6ed6-bc836864c67c@suse.de>
Date: Wed, 27 Apr 2022 12:37:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: chaitanyak@nvidia.com, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, dm-devel@redhat.com,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 axboe@kernel.dk, msnitzer@redhat.com, bvanassche@acm.org,
 martin.petersen@oracle.com, kbusch@kernel.org, hch@lst.de,
 Frederick.Knight@netapp.com, osandov@fb.com,
 lsf-pc@lists.linux-foundation.org, djwong@kernel.org, josef@toxicpanda.com,
 clm@fb.com, dsterba@suse.com, tytso@mit.edu, jack@suse.com,
 nitheshshetty@gmail.com, gost.dev@samsung.com,
 =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
 Arnav Dawn <arnav.dawn@samsung.com>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 James Smart <james.smart@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
References: <20220426101241.30100-1-nj.shetty@samsung.com>
 <CGME20220426101938epcas5p291690dd1f0e931cd9f8139daaf3f9296@epcas5p2.samsung.com>
 <20220426101241.30100-4-nj.shetty@samsung.com>
From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v4 03/10] block: Introduce a new ioctl for copy
In-Reply-To: <20220426101241.30100-4-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220427_033709_646729_A26F18A4 
X-CRM114-Status: GOOD (  16.50  )
X-Mailman-Approved-At: Wed, 27 Apr 2022 05:48:55 -0700
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

On 4/26/22 12:12, Nitesh Shetty wrote:
> Add new BLKCOPY ioctl that offloads copying of one or more sources ranges
> to one or more destination in a device. COPY ioctl accepts a 'copy_range'
> structure that contains no of range, a reserved field , followed by an
> array of ranges. Each source range is represented by 'range_entry' that
> contains source start offset, destination start offset and length of
> source ranges (in bytes)
> 
> MAX_COPY_NR_RANGE, limits the number of entries for the IOCTL and
> MAX_COPY_TOTAL_LENGTH limits the total copy length, IOCTL can handle.
> 
> Example code, to issue BLKCOPY:
> /* Sample example to copy three entries with [dest,src,len],
> * [32768, 0, 4096] [36864, 4096, 4096] [40960,8192,4096] on same device */
> 
> int main(void)
> {
> 	int i, ret, fd;
> 	unsigned long src = 0, dst = 32768, len = 4096;
> 	struct copy_range *cr;
> 	cr = (struct copy_range *)malloc(sizeof(*cr)+
> 					(sizeof(struct range_entry)*3));
> 	cr->nr_range = 3;
> 	cr->reserved = 0;
> 	for (i = 0; i< cr->nr_range; i++, src += len, dst += len) {
> 		cr->range_list[i].dst = dst;
> 		cr->range_list[i].src = src;
> 		cr->range_list[i].len = len;
> 		cr->range_list[i].comp_len = 0;
> 	}
> 	fd = open("/dev/nvme0n1", O_RDWR);
> 	if (fd < 0) return 1;
> 	ret = ioctl(fd, BLKCOPY, cr);
> 	if (ret != 0)
> 	       printf("copy failed, ret= %d\n", ret);
> 	for (i=0; i< cr->nr_range; i++)
> 		if (cr->range_list[i].len != cr->range_list[i].comp_len)
> 			printf("Partial copy for entry %d: requested %llu, completed %llu\n",
> 								i, cr->range_list[i].len,
> 								cr->range_list[i].comp_len);
> 	close(fd);
> 	free(cr);
> 	return ret;
> }
> 
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> Signed-off-by: Javier González <javier.gonz@samsung.com>
> Signed-off-by: Arnav Dawn <arnav.dawn@samsung.com>
> ---
>   block/ioctl.c           | 32 ++++++++++++++++++++++++++++++++
>   include/uapi/linux/fs.h |  9 +++++++++
>   2 files changed, 41 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

