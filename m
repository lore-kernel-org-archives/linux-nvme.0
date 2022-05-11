Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1311C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 11 May 2022 12:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6WhEVSHsDA565Egp5d9HDhwu+cGxlIM6t99NlYBqV5g=; b=EH0IHo7MIV379VB2h7hjy1CUtw
	irFRGbiF/gXIuNARlZTl2aWMxetAtIVhDnZARG/gguZPVoJbxThNjFe6FmWi2n5TfhSmTR/9ZqTuO
	VKE3A7p8OCBwlDPvbwGLYaJhIgbGs6bU5X07sLjykyMGJaMVY49S650hgMAfGC/w52Mgrz8f2VDm5
	ajM8/B7IOuTtnQrkR23XuFjGn6wHPOW2tZWrXVw/0J8bonNUpgol1wdUOX5AStTmuGYfeKkk8aWOy
	HhiS4BP50vNUY2VqnoR0oBMl1bRpKhWLtXsBrvJLZbQzRTF+CxenMfxYf94mgo5xQzAf42FzR8g59
	CXx4DT0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nolbr-006nyb-BZ; Wed, 11 May 2022 12:38:31 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nolbm-006nw3-Tn
 for linux-nvme@lists.infradead.org; Wed, 11 May 2022 12:38:28 +0000
Received: by mail-pl1-x62c.google.com with SMTP id n8so1783243plh.1
 for <linux-nvme@lists.infradead.org>; Wed, 11 May 2022 05:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=6WhEVSHsDA565Egp5d9HDhwu+cGxlIM6t99NlYBqV5g=;
 b=2Ex8SVi61fEvxrpYhj2SKTejb3qy3nZoCoxtciNK9s84k3RjlV2Wt/zRFzjqd1lxmE
 AEWcmlVvBCFSRgsPROdEMSp+qFpMmVa0qId2GcfYE2vWjow8YLmBFxs0xRTlTYgauZfZ
 078fGH4fMsG3siC4XqaV1zLxCYpeuCthjeczPsTmDmTjZWKZnZLjsge4PuElOaYxarBp
 uuVWRyCRFoKZAmJarzlVdUqVuTZKqOoD1g+XeXnpICtFFLn3y+8c1bLq0BGSOaCq/zCI
 l3Dhesp8Y6M4pa3guS9Z5kpnFdtESpMrKtfF3luAkqVsOz+FKQtu850981SZZNrt9BwG
 lufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=6WhEVSHsDA565Egp5d9HDhwu+cGxlIM6t99NlYBqV5g=;
 b=KNty5oW7lyYB7tfBb06/oqlGWH3vHeLhznpNaajG5YMKof6N2lpDajYKcDmmvFFqd+
 JkAZkw57MAnCR4ec37SyMrKGkRAx9k5Ny8J9tNxNEiPs1dOIS/AyXpmXFoU9kOw3QVOW
 XB2p9XVr9/qGyRHVUKN2IE1/EdyzRt6m8xDdP+9xUbDVcFdowlJDC0W4yR9QET1weyFm
 Y/Iu0j+a1PtCk6NoSbqT1vrf3/bQvqj6WwZxe3ke9/eN815E8oiGu2h2TaXFZYgzK1ZI
 7mLTHf4UAKjPG369Tq+H41XSdNeOL8PA+yxVQ4IXzNB3k0vNu1GNQQP9bNbefCOcY9XN
 hMOg==
X-Gm-Message-State: AOAM5323ZtuEqvsNC6iURk9B+htOYSSW/oKhG29dDzJruRe2vb0YhXoM
 FdUUZ6HwT/n9QFsqZIG8IeiGiQ==
X-Google-Smtp-Source: ABdhPJzalOfoorcqazZGfnpCc+GXImojvyl5Tcat5bI0ddUIGLbUenIOINr15lBFpxnHXfalEAnhPA==
X-Received: by 2002:a17:90b:2243:b0:1dc:3f08:8316 with SMTP id
 hk3-20020a17090b224300b001dc3f088316mr5307653pjb.194.1652272704449; 
 Wed, 11 May 2022 05:38:24 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
 by smtp.gmail.com with ESMTPSA id
 c14-20020a62f84e000000b0050dc76281e8sm1637365pfm.194.2022.05.11.05.38.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 May 2022 05:38:23 -0700 (PDT)
Message-ID: <9e888eb3-3fd3-6c21-ddf5-4489fd54054e@kernel.dk>
Date: Wed, 11 May 2022 06:38:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5 6/6] io_uring: finish IOPOLL/ioprio prep handler removal
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 asml.silence@gmail.com, ming.lei@redhat.com, mcgrof@kernel.org, shr@fb.com,
 joshiiitr@gmail.com, anuj20.g@samsung.com, gost.dev@samsung.com
References: <20220511054750.20432-1-joshi.k@samsung.com>
 <CGME20220511055320epcas5p2457aaf8e7405387282f60831f5a4eca9@epcas5p2.samsung.com>
 <20220511054750.20432-7-joshi.k@samsung.com> <20220511065423.GA814@lst.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220511065423.GA814@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220511_053827_197512_4A736307 
X-CRM114-Status: GOOD (  10.53  )
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

On 5/11/22 12:54 AM, Christoph Hellwig wrote:
> I think this should go first, and the uring_cmd bits need to do the
> right thing from the beginning.

It just needs folding in, I'll do that.

-- 
Jens Axboe


