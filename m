Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA1D7C7EE22
	for <linux-nvme@archiver.kernel.org>; Wed, 17 May 2023 22:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ueC5VTlD9srXw3nIH9njJ76Dcn6bg+Ch492X/b41lbA=; b=pt/yyOY5xjsRSe3odhji58BXah
	dwBzEzwvYH5sPijMXC0mt0hJL2gfjjHgt7z34fogF8pdOUZ8wVgo7b0l8DPFR8g5vEdEKBkEri2hP
	IVJN+6y2kWxsIZOe0FMKnv2TCTCtTTRZz7Dgty6bLp0Pk3TwcG8HXjxtK88qnIAyBDRW2yLiPvPoi
	dkwF7f1IO9TlNRFoAbRidmV/9YT/UkBaOLgWqKbth5O0PjMeIP6buCqUOnrrQ7FI/EQIXyrb1Ryy6
	aT2Bvi4o9az59aKSRfhsQRNhlzH9yd/9hEw+tl7y6omtH90GWIHRMY7WcXv/jwkPesjyI79Za1QL1
	z+M79wkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzPJZ-00BBTt-12;
	Wed, 17 May 2023 22:08:09 +0000
Received: from mail-qk1-x764.google.com ([2607:f8b0:4864:20::764])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzPJW-00BBSZ-2l
	for linux-nvme@lists.infradead.org;
	Wed, 17 May 2023 22:08:08 +0000
Received: by mail-qk1-x764.google.com with SMTP id af79cd13be357-759219bed84so81222285a.0
        for <linux-nvme@lists.infradead.org>; Wed, 17 May 2023 15:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1684361282; x=1686953282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ueC5VTlD9srXw3nIH9njJ76Dcn6bg+Ch492X/b41lbA=;
        b=UDRFMAdWpynTrDbJC1BriLTjkNpRTpnhvSqGm+mKUDFhfa5ssxsfhLrjjmI5NvuWp+
         sN4rwlIpkXwhEShZS/4R8KZwJwv85QT2FsVtDIQL++TOOeP+ZNdqquWxzJuJQfa64GpP
         kK5EAwL5mGQaH/Z7tTo2iQnrSKlDrIxoHSZoRfnSedQSgj/G+Nh/4IGqV4/62qO/nJd3
         ZQGhfk177adp+yKyTLoWDZEhU7HuCJlCKkdvJXax8nA7MMqzfamjfMf/jch1fWEZW+Xx
         TbP8ro3PzpprS7UV85W1EboiloTp4/mkvLYeUUeR8o5uTzPFejI8e8qtqw6tq7zaq1ww
         86OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684361282; x=1686953282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ueC5VTlD9srXw3nIH9njJ76Dcn6bg+Ch492X/b41lbA=;
        b=fwcstiJKKZu0ImiEQS2w5fwUxdF7CNGGVpqoHBXmOX0RRB87OMhudziV2Fhwvycr0d
         3o4abIrXg20Q3n2Td4y+6adcZ3RhElFAoGzA3tQEDgA9N3JfMtgc+glxKYZxAMrHKMgS
         vyMCkUj986Ftc2PlJj5x8cKB2tHAJIp1A6/H5rnp4JKeKb0Y2TVGAZ5aHmn/PSQghvGE
         x4wcBa1GxhuEpIUQ5ekt1S52+lAIjodTUg8jEJ/4TTG5eLFXHuBH0hrk3dzmEcKWpmcg
         kQzQFJhfMujLwbJSLD41efbr5PObBOKo945x+BHDQZHBTuojHmg9lGAUoknoXbVptUjq
         vXUA==
X-Gm-Message-State: AC+VfDyj5MdYcfHPZEix5gzdd5ZHFzSK2gU6/oq4oHansr6NMaPFuFOZ
	REh2oeM3pksofC+JIhH+lAOV5OH0bmyT3kyQigaV/kKu4bS75g==
X-Google-Smtp-Source: ACHHUZ56bta6++K2Drtf3iR6Y1vi5d7ExA+Azh0eGHkiWskYrkwNGnqFSSiiS3hvOcaE7vy/aJTl3HLY0P3U
X-Received: by 2002:a05:6214:27c7:b0:5b3:e172:b63e with SMTP id ge7-20020a05621427c700b005b3e172b63emr1963211qvb.22.1684361282510;
        Wed, 17 May 2023 15:08:02 -0700 (PDT)
Received: from c7-smtp.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id j1-20020a056214032100b0061a2cff3bafsm14581qvu.21.2023.05.17.15.08.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 May 2023 15:08:02 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp.dev.purestorage.com (Postfix) with ESMTP id B570F20D28;
	Wed, 17 May 2023 16:08:01 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id AF7CDE40456; Wed, 17 May 2023 16:08:01 -0600 (MDT)
Date: Wed, 17 May 2023 16:08:01 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Costa Sapuntzakis <costa@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@fb.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 0/3] keepalive bugfixes
Message-ID: <20230517220801.GA2840889@dev-ushankar.dev.purestorage.com>
References: <20230424232225.1975793-1-ushankar@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424232225.1975793-1-ushankar@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230517_150807_087322_49424626 
X-CRM114-Status: UNSURE (   7.51  )
X-CRM114-Notice: Please train this message.
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

Ping?

