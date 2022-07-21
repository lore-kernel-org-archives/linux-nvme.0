Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D880C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jul 2022 03:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:References:In-Reply-To:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PXcLbgz/2hZNyRCKVpHDt9L+ugWOOu7ycGEMz9duFt8=; b=feVYpQ9hWlRwg8YAQaIaH8UJ3O
	eqbiAiXTQs043vdlLL9XqPdQcoCjdgSLzyIxNpNgctGZJMAlyMNMW4V66g3Q3BAT0bwQYUE9EkFbT
	+yXQ5to+TG7eMxigKIrSs9a04kML5T4d8MhXvuqSAVbPOb6zukZK2osRNkvVW9xfc9LXaS0eRdxOz
	fwaYFMt6m1ZsDqH4ZWYeRzQ29xzzGct2wytq549bD2Ic1Ga7YvzsGGh8RuGW+/iJTzZJ6cijovd6Z
	42/nZ9k0f9gzxHPRevYy/nL/FCAyr8Db36Gw+7+NFW4KfAahxAKZOoazeb2A66QCBVHANnVNYfbQk
	XSE3fWYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oENIs-00G200-NH; Thu, 21 Jul 2022 03:56:46 +0000
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oENIp-00G1tM-Sy
	for linux-nvme@lists.infradead.org; Thu, 21 Jul 2022 03:56:45 +0000
Received: by mail-pf1-x42a.google.com with SMTP id d10so610546pfd.9
        for <linux-nvme@lists.infradead.org>; Wed, 20 Jul 2022 20:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20210112.gappssmtp.com; s=20210112;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PXcLbgz/2hZNyRCKVpHDt9L+ugWOOu7ycGEMz9duFt8=;
        b=AJSGr9MeESvQ1BHuYg1u20EvRDhzIGuqU/qnzvueLooOm1yNr/hPAB5/H9UranvqHZ
         HICW03++IDk+ajH9p05A+tyzubpVbPftxEsMB2MU7u0YJPfcL/0eaZh24Ps/e/sFPFLG
         nzN0ESbxRKM+vq+6WBt8SrdXQuVBA7J1hEUq+I28qguMQ7R2tow+tOQGoALabymobz3B
         k32UK50Wh3FaTUniZmirR2TylU+VeApcWFbANPgHr1+yCjUktIGoXj32PSCMlXOsh1hl
         lZvJxQKhAde9eOM4wL8MnCO/YHya95Xrqfksxcxm+zJvBeMoX9aTlbw6PAt8LXEoNEgh
         0EeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PXcLbgz/2hZNyRCKVpHDt9L+ugWOOu7ycGEMz9duFt8=;
        b=7qqOiUtEcSxj1FSFa2RiP3Fi+nBz2AK0AKuA39R1pPFNrQoZpXzXys8FaCPSneSmLK
         kqxUq7KAyXXRGJ25IC3P+nFJR9j3MONGX0IZDUvYtVCDPBzWRJ4/86fA2NXFzP+lOxpV
         Lw3OEk7zgSRJwtelMyYD4ZpYYPNT3d2k4sGzq9H9KjzscxS8kEz8JHBXaXuxI9nAsKFl
         3MKi/waQni0nYMCYGaui9jwAyr4hZLZDdjgPXKIpuN3TJAqDThMmUXvAnKg9ZVw5Mw4+
         Z1qnaCTyj7Eic0JnIPWVySAAhtK+u6+IhLasiI0O4F4aSu+bK3kYd29KTlIuKOr1xjk9
         QPww==
X-Gm-Message-State: AJIora+uZ01q8YLrf87UMR55OABNzpxX7bEYYdjD7fjadR5iH3kb10V/
	JFz/3xUWeAwfsHOX2NGwXMADdRFhGDLQ20A3jyF9xz/wPO5bIA==
X-Google-Smtp-Source: AGRyM1scp+RxkXYyOzwQDID4GtfVxc+vRqVJDCM7uEyTprEdPloEgysXH9XVJicMOkA8UnVjHPANGWoIaIUR8oMviog=
X-Received: by 2002:a65:6e93:0:b0:419:acad:f06b with SMTP id
 bm19-20020a656e93000000b00419acadf06bmr32290788pgb.68.1658375800209; Wed, 20
 Jul 2022 20:56:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac4:d06f:0:b0:535:c52f:e1cf with HTTP; Wed, 20 Jul 2022
 20:56:39 -0700 (PDT)
X-Originating-IP: [24.53.241.20]
In-Reply-To: <9122f83f-902b-3738-3b0e-f806df999c3f@linux.alibaba.com>
References: <20220720015538.15838-1-nbowler@draconx.ca> <9122f83f-902b-3738-3b0e-f806df999c3f@linux.alibaba.com>
From: Nick Bowler <nbowler@draconx.ca>
Date: Wed, 20 Jul 2022 23:56:39 -0400
Message-ID: <CADyTPExY4TOuy1pboWLiTRpjmKiLZkkGUqcnL1dGdSwviMapZA@mail.gmail.com>
Subject: Re: [PATCH] nvme: Define compat_ioctl again to unbreak 32-bit userspace.
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220720_205644_192839_FD667715 
X-CRM114-Status: GOOD (  10.92  )
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

On 2022-07-19, Guixin Liu <kanie@linux.alibaba.com> wrote:
> =E5=9C=A8 2022/7/20 09:55, Nick Bowler =E5=86=99=E9=81=93:
[...]
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index a2862a56fadc..30e105dbc178 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -2093,6 +2093,7 @@ static int nvme_report_zones(struct gendisk *disk,
>> sector_t sector,
>>   static const struct block_device_operations nvme_bdev_ops =3D {
>>   	.owner		=3D THIS_MODULE,
>>   	.ioctl		=3D nvme_ioctl,
>> +	.compat_ioctl	=3D nvme_ioctl,
>>   	.open		=3D nvme_open,
>>   	.release	=3D nvme_release,
>>   	.getgeo		=3D nvme_getgeo,
[...]
> Should this in the brace of "#ifdef CONFIG_COMPAT" and "#endif"?

I think it doesn't make any significant difference either way -- the
.compat_ioctl member is always present in the block_device_operations
structure.  Unconditional assignment thus seems more sensible to me.

v2 uses blkdev_compat_ptr_ioctl which expands to NULL for !CONFIG_COMPAT.

Thanks,
  Nick

