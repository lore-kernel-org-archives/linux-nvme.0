Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6EA3C433EF
	for <linux-nvme@archiver.kernel.org>; Sun,  6 Mar 2022 18:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3IDySe6/HojQ3jDxfjpKc6zpBwkz5pfcZNFnpj0OwBo=; b=ztXt3uO73eOK0UvLc8AxKHTBSi
	rnus0EE3TxUgEVXhyBedqtb1kLaLah//em85F5C+idh1yGi1e48Xq0Gi+ooHMOIYvLqrrd1FFfIwe
	qUn4L54cF1nF2skNqtte6W4nxCKsfuZoxMq4Ndvw+eT+nz6YDr0GD7sosy3R4hB8zIljgcUls/V+Z
	6jrSGgW8NBWKuQO7yW+ntxK6eYZqYSWy1AM3YmbjjFndbYYc94QoNUWFuPpfU9AR9t6Xc2rpJfsZD
	afrxrzdChQOdm1PrD2+CpaOzdKzLYpfk52La00O+yhVSFYij/dRY+t+0B7gvUCyS3uGgTyGTLRJwJ
	wBQ0wtjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nQvGt-00F9i7-DH; Sun, 06 Mar 2022 18:06:19 +0000
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nQvGp-00F9gb-VC
 for linux-nvme@lists.infradead.org; Sun, 06 Mar 2022 18:06:17 +0000
Received: by mail-pg1-x532.google.com with SMTP id 132so11748071pga.5
 for <linux-nvme@lists.infradead.org>; Sun, 06 Mar 2022 10:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=3IDySe6/HojQ3jDxfjpKc6zpBwkz5pfcZNFnpj0OwBo=;
 b=ECZvhaTcTYSYuxNQf0dXjupv9p+mdfcNTTw6ViBX4xP0zeXJMhvpwIQK9qTWRQKsVD
 SQtDRh+omkTij3RdK9ud99NHyowBI2gvl+kctfY8m9J7D3ThNlQNDH+yPjn/dzgq2HXm
 2JTWmnVhMWChL+QJMuKarlAx+hNcxWxldBAieo0PZnSkx1O1pSIizg87Z3lyOVDTTuug
 KnXayEwHBgey7lOMeKpKoB9emHN2YgUdy7f3A033WZdOK6lEDPzdtuAFqwcQtULwuojV
 63zGCRF1wVcH1aP3PvwIGNKv5PX7kI8fxhX2v/p71xw3jOuV10Biivx8AejciDrjQqf4
 MiGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=3IDySe6/HojQ3jDxfjpKc6zpBwkz5pfcZNFnpj0OwBo=;
 b=dDY15TUuK8lfw1H6YBEXCyQQFHFA2kaLRCKiNkNwe5F7ith/SjyWyPz6LA0Eh4f74e
 pxkeIUIu00PGib4VnIjoXunifGtvNwrIltHPlu2OmTnk9wpHs5ugYZ3J71L+YlEfquL9
 uzIaWm/tPDApUcOEPXaBhbNbJiDu8VBbcncyt6Vq1AsL6PpcXvIm+z0fo9ZGa4PrPh1p
 d5VZG8VTLhEsVTYYH5aC8PKcySqX+nu0lCGZgtJxG+SooF2nb4mj293sQsTeAP12pIOF
 c+tsSC4ozPwW8Ho1emNrdH6rav4n1h81KmBs+cQkNwGO1Y8uBdVfKb+Q3rwGERJ8jXmY
 NKww==
X-Gm-Message-State: AOAM532lkbAKjyip+Z7KZ5iIr9EcYw31fyh5p1L8al6TjrP+Wq1EUcyd
 oZygYrpVraFZRWZOzpgLIknWGg==
X-Google-Smtp-Source: ABdhPJzZKQnoFchQw6tzr1OIIZ1uDCy2Ywxdu5LxhrSM3BjvQrLV0Y79FSWzFuuduKBiryJFzTjlfw==
X-Received: by 2002:a63:d74f:0:b0:374:5bda:909d with SMTP id
 w15-20020a63d74f000000b003745bda909dmr6973383pgi.215.1646589974835; 
 Sun, 06 Mar 2022 10:06:14 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
 by smtp.gmail.com with ESMTPSA id
 b16-20020a056a00115000b004f6ff260c9esm931995pfm.207.2022.03.06.10.06.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Mar 2022 10:06:14 -0800 (PST)
Message-ID: <f08db783-a665-2df6-5d8e-597aacd1e687@kernel.dk>
Date: Sun, 6 Mar 2022 11:06:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 2/2] block: remove the per-bio/request write hint
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Dave Chinner <david@fromorbit.com>, sagi@grimberg.me, kbusch@kernel.org,
 song@kernel.org, linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
References: <20220304175556.407719-1-hch@lst.de>
 <20220304175556.407719-2-hch@lst.de>
 <20220304221255.GL3927073@dread.disaster.area>
 <20220305051929.GA24696@lst.de>
 <20220305214056.GO3927073@dread.disaster.area>
 <2241127c-c600-529a-ae41-30cbcc6b281d@kernel.dk>
 <20220306180115.GA8777@lst.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220306180115.GA8777@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220306_100616_041271_8BA9937E 
X-CRM114-Status: GOOD (  14.05  )
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

On 3/6/22 11:01 AM, Christoph Hellwig wrote:
> On Sun, Mar 06, 2022 at 10:11:46AM -0700, Jens Axboe wrote:
>> Yes, I think we should kill it. If we retain the inode hint, the f2fs
>> doesn't need a any changes. And it should be safe to make the per-file
>> fcntl hints return EINVAL, which they would on older kernels anyway.
>> Untested, but something like the below.
> 
> I've sent this off to the testing farm this morning, but EINVAL might
> be even better:
> 
> http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/more-hint-removal

I do think EINVAL is better, as it just tells the app it's not available
like we would've done before. With just doing zeroes, that might break
applications that set-and-verify. Of course there's also the risk of
that since we retain inode hints (so they work), but fail file hints.
That's a lesser risk though, and we only know of the inode hints being
used.

-- 
Jens Axboe


