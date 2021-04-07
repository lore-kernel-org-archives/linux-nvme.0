Return-Path: <SRS0=pbEM=JE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFF4C433B4
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 01:04:50 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C27906124B
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 01:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C27906124B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Cb9kB0XPg/Mp2louEPOlPDYxAdqtx+Iq4tLD8MP4Tgs=; b=iaa8qZjhu23jrrAE3spPFRiTi
	ubmdnTaKvHdi7gvV+bX6Mwo7FeBeeS2X6LDR44xHcBJD8L8mS/A0Ua1M1yaACHu6Z0TfEG4t0qJiW
	KE+qlnu+aIzwaDZMBuCQRpK+OVl/dRa+6nF+RTHATW7vB0AxmCS0Qj/03ERR+tPwBa1ERo1sUvrqI
	j4DOqUyL82y9I0L4Sel1ipR6Eq0xBS7/LoyKZhq0CTUIwrX1HyPxd27+vj0sYaiw33Rw6YyvwxgQ7
	qNPCpbJ/UzLqKk6dkXGf2hDsALF7q185eT6WLFHpuICZ3Z+/V7ZSQkr/fxYmltt7WJmk/TB7z24iO
	eM70AB/PQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lTwcJ-003j4X-09; Wed, 07 Apr 2021 01:04:23 +0000
Received: from mail-pf1-f174.google.com ([209.85.210.174])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lTwc9-003j46-Tz
 for linux-nvme@lists.infradead.org; Wed, 07 Apr 2021 01:04:18 +0000
Received: by mail-pf1-f174.google.com with SMTP id 11so10004086pfn.9
 for <linux-nvme@lists.infradead.org>; Tue, 06 Apr 2021 18:04:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Nrx7vAYL/v9rvNMTti5K1Qo11AwKaoS5LOcemj/8W2U=;
 b=GfgGsvP/JaxyGsIJ/+Z0xcsWnBn6HNtSt3pCWtVhjdy3uK7mZ2w9KeWDUt7fGyRnA2
 cF0BXCfmD0vhGI0MhO2uiVXspCrqPff1UxhuQ89hQbyniQXFGeE6OdYb4Utzq14Wheye
 Zd8sbRdehRZBI4b9ixzZ2gqFk7JgA0rIansyfmWA6o0nTJeU2gRkBmncNgAzK2zNHUfc
 93HwQZKrBaQTSxvQUxU8tqCpRExkjfc+PK+ayfWJm1RvYDetSugAhWEkYN86mMWxyjPX
 4fNqxvrVEfCTm6c9hl5NdCSpXRdUrs3Sn8HdZdAZn2R+pzgCkbkSMixIvJTnJUsXTuQG
 zIdA==
X-Gm-Message-State: AOAM531V7fs8qe4IiW4MhazeDC1lMlkov0WN6ZEm3akyvUiZtKO3KSWL
 swUT0fj67QkU8kdQUFOyAxPDKvW12bY=
X-Google-Smtp-Source: ABdhPJwwVWKwRWSy9PYi5/d1lPFYyUnpeCqjbdXMS72m+AKyxxRx0TRIxHVn8+G/LtwFjkvMd+dFjg==
X-Received: by 2002:a62:1a08:0:b029:220:da90:9173 with SMTP id
 a8-20020a621a080000b0290220da909173mr783294pfa.65.1617757451729; 
 Tue, 06 Apr 2021 18:04:11 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:3103:b16c:6e5:14e0?
 ([2601:647:4802:9070:3103:b16c:6e5:14e0])
 by smtp.gmail.com with ESMTPSA id e9sm19464280pgk.69.2021.04.06.18.04.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Apr 2021 18:04:11 -0700 (PDT)
Subject: Re: [PATCH stable/5.4..5.8] nvme-mpath: replace direct_make_request
 with generic_make_request
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20210402200841.347696-1-sagi@grimberg.me>
 <YGgG2TAA9TNqM9S6@kroah.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <00e36c71-9f2c-5b38-96fd-3d471382f6ac@grimberg.me>
Date: Tue, 6 Apr 2021 18:04:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YGgG2TAA9TNqM9S6@kroah.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210407_020414_460879_14A5A5AC 
X-CRM114-Status: GOOD (  12.55  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> Hence, we need to fix all the kernels that were before submit_bio_noacct was
>> introduced.
> 
> Why can we not just add submit_bio_noacct to the 5.4 kernel to correct
> this?  What commit id is that?

Hey Greg,

submit_bio_noacct was applied as part of a rework by Christoph that I
didn't feel was suitable as a stable candidate. The commit-id is:
ed00aabd5eb9fb44d6aff1173234a2e911b9fead

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
