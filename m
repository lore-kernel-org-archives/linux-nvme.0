Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01247C77B7E
	for <linux-nvme@archiver.kernel.org>; Mon, 29 May 2023 16:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XGlmlfpGRhYW8HjfyI5EG9tKXwTbZGzHl2Gw/X6ax14=; b=cvJUe7TzdYoHuNxce4M81+/SRY
	fWadN9DJGUqtMLunkY8GUWTEXC2V1h08I5kj+ERHzFgouF0r7Z43pOqUWWcxt9xd3CvIiLYSruUBO
	5s4Zq3PTIr9Jhk23gGq7irpExQmBSGBc1OiALgsRi5+s+IVEHJQvKPHkvkLMI3RgXtV4wN7wo36mh
	DXvw6csCkeeVjR+u1uiHXJfcq6WpXpdniwYgMk9KzfL1rTBXRijo8cudBirgEzwAgLTtN3g2+1T3e
	dwkHSwduftc12q58M3+aZFQDNQqB8+AMKzSgqQqmPKSRvIloszalQpkv5MAuByTdzfZ5g/G+Ji47y
	Aae+LPOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q3frB-00B8ZD-1C;
	Mon, 29 May 2023 16:36:29 +0000
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q3fr8-00B8Y9-0f
	for linux-nvme@lists.infradead.org;
	Mon, 29 May 2023 16:36:27 +0000
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-565eb83efe4so24202557b3.0
        for <linux-nvme@lists.infradead.org>; Mon, 29 May 2023 09:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685378184; x=1687970184;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XGlmlfpGRhYW8HjfyI5EG9tKXwTbZGzHl2Gw/X6ax14=;
        b=gD4kPaLLf9pJV0lpw2cIWttEo9EVBn7x8f+92LW12OXCCFANe21Fg01PjDXO0UtxY2
         Ub5I5H1SdDWAoWmUFNeFLAYHmxDq8YTSmOaqguooZLFZobRrzvTxGbtaD72knDH23eOR
         MY6ARUPzlKzmyW1m+BBJysdYOhoJdDqFYBuSUXe+0EMClHkTcg4RjJwjoiWhoOTKM3Dt
         9K997gDZQsyxazGzIDcLguDZimyccw5IT7vyORCRBHtiqJDhUH/qSIl0d7GezyQg513/
         VW7HwcNry8jcfbS5LOs9BUzeIfyV4CP5ISfkACbfC7ABZjMV3VQHFd1Zf4JXCiU+XtDx
         EW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685378184; x=1687970184;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XGlmlfpGRhYW8HjfyI5EG9tKXwTbZGzHl2Gw/X6ax14=;
        b=I1WKYo0WjlQg31BoXoTFJGTjenJ2LO/xlvn4Ws9RxXYzx2Lrj6G7ix0mO3l5x5gzKj
         unvSdypgaoMrtWnW0EnZhso0cEGpcHcWuWl1RD5+1CrxOxY7MJKDvjVdCN/Jsot/Z9+F
         mdTNuCGGIlOxInfExmjMl7yqs4j6+4ckawGjg7rKzQdmA7UfWKoUx5fZIUUFORrci9yi
         upxTaDKWBXI7ptLAPsEX4tRF/VhLwP09LcS7ABNIz6clGNx+mroyp2vlhQ3dx69eME4W
         SNvOqgEMxnFfGoOgu+nSSAJk8PW51p5GOH96agQy4FRICshXqKXVOiJxvsUggiN1FKQJ
         ixpw==
X-Gm-Message-State: AC+VfDwmZx26vjnMFVYCZ3YhUn5KP4CjJ59klV6Gtily3JqYZCxbxngz
	Muumy2biIChFAase5iU6FhejeaaKb1Ak4FE9KjM=
X-Google-Smtp-Source: ACHHUZ7InCRLGF330bSJ+LMuRh4g/NfzTfd2m8OEywQty5+b+eU+JLZRKLHh0ktsR3qbMPwu4QSHwqAz7Ha/ifAXWSw=
X-Received: by 2002:a0d:d88b:0:b0:565:bb04:53fa with SMTP id
 a133-20020a0dd88b000000b00565bb0453famr11663162ywe.10.1685378184319; Mon, 29
 May 2023 09:36:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230522104146.2856-1-nj.shetty@samsung.com> <CGME20230522104536epcas5p23dd8108dd267ec588e5c36e8f9eb9fe8@epcas5p2.samsung.com>
 <20230522104146.2856-3-nj.shetty@samsung.com> <20230524154049.GD11607@frogsfrogsfrogs>
In-Reply-To: <20230524154049.GD11607@frogsfrogsfrogs>
From: Nitesh Shetty <nitheshshetty@gmail.com>
Date: Mon, 29 May 2023 22:06:13 +0530
Message-ID: <CAOSviJ2-=U+Y2vFOq6=8n=uHqXgoud3=7gaH7H7sw2jiPXtNPA@mail.gmail.com>
Subject: Re: [dm-devel] [PATCH v11 2/9] block: Add copy offload support infrastructure
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Nitesh Shetty <nj.shetty@samsung.com>, Jens Axboe <axboe@kernel.dk>, 
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	James Smart <james.smart@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-block@vger.kernel.org, martin.petersen@oracle.com, 
	linux-scsi@vger.kernel.org, linux-mm@kvack.org, gost.dev@samsung.com, 
	anuj20.g@samsung.com, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, ming.lei@redhat.com, 
	James.Bottomley@hansenpartnership.com, linux-fsdevel@vger.kernel.org, 
	dlemoal@kernel.org, joshi.k@samsung.com, bvanassche@acm.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230529_093626_249157_0FD04BFC 
X-CRM114-Status: GOOD (  17.26  )
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

> > +/*
> > + * @bdev_in: source block device
> > + * @pos_in:  source offset
> > + * @bdev_out:        destination block device
> > + * @pos_out: destination offset
> > + * @len:     length in bytes to be copied
> > + * @endio:   endio function to be called on completion of copy operation,
> > + *           for synchronous operation this should be NULL
> > + * @private: endio function will be called with this private data, should be
> > + *           NULL, if operation is synchronous in nature
> > + * @gfp_mask:   memory allocation flags (for bio_alloc)
> > + *
> > + * Returns the length of bytes copied or error if encountered
> > + *
> > + * Description:
> > + *   Copy source offset from source block device to destination block
> > + *   device. Max total length of copy is limited to MAX_COPY_TOTAL_LENGTH
> > + */
> > +int blkdev_issue_copy(struct block_device *bdev_in, loff_t pos_in,
>
> I'd have thought you'd return ssize_t here.  If the two block devices
> are loopmounted xfs files, we can certainly reflink "copy" more than 2GB
> at a time.
>
> --D
>

Sure we will add this to make API future proof, but at present we do have
a limit for copy. COPY_MAX_BYTES(=128MB) at present. This limit is based
on our internal testing, we have plans to increase/remove with this
limit in future phases.

Thank you,
Nitesh Shetty

