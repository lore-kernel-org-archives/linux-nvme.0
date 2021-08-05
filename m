Return-Path: <SRS0=eYGd=M4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53622C4338F
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Aug 2021 06:20:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D87C60F70
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Aug 2021 06:20:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0D87C60F70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dmfrt4tfihqtFgBu/peBq87PI8rEcA7voLZpYYVvbQI=; b=tSIEfbPAIgi87JBprW8ndQt/la
	Y1DW3jLXHdF5HGpuC26YirEztKSFy3t9O9QHDg6mntKjxjNnenV+WBaLLbzfLMsl/eGmwl/bEyhWU
	Z2MLOSUjUHQRu5mqG+Cn69cOCJft+5hKImzAHjlIbyn5lEZem5mFCBbMEtoKrnm8PYuheGsyyA2rq
	bnWr3+qtzMX+kCfw7t6BIFACpest/OdL8alP7YPV1KcTYAddd8MC/m56Ba6eJlSs3i3YJN4QiWOqp
	xpDQYmZll5NWK6cf4gZNQrimRL2FthcqQBZZM+dd+hQCDQrWjDKL7/+5sLdVDCAxlVlrgXfSHqo+a
	9hVv+N4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mBWjN-008Dtl-5H; Thu, 05 Aug 2021 06:19:49 +0000
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mBWjK-008DsG-AO; Thu, 05 Aug 2021 06:19:47 +0000
Received: by mail-pj1-x102e.google.com with SMTP id l19so6591404pjz.0;
 Wed, 04 Aug 2021 23:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Us8M4Gz10TOU+v1I5NsNfx0zgCQlwHS7fXqY8nkODX4=;
 b=NmphZcKHDr5rzeeiJu0gciOePeopU2TUfYviW4P0HGDE7eQ7rlOkWulSippslpN7hI
 KbiuY7BMkNLpA3KqdMnGptqECAiI0U+Ak9aV80XIgQ6d7TzHsqM4uDuFBN/RjTWP4dFi
 v2wWmB7dicFmiRtF/+fN1KXwh1JHYKc7Cccp5WBNRYX1xc9WfWeQ98S5ZK3t/bQ/YWsA
 1tn0ksVptVHOuY5mogE+aT/nGQLlOduKg9Neq8j/WElHzV63gKu4Ou+WpOPovZW8GC3S
 lTU8D0eXfSbhbH4EHGHVR3wXlcn80rxe2kU9gIf02PVZUsle8ZWaAo8SBvhe2OpOLwMx
 u/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Us8M4Gz10TOU+v1I5NsNfx0zgCQlwHS7fXqY8nkODX4=;
 b=lSeurgsxdOyKMT7/eIQIgbqA3KsDe7lWTfydG9X2kUlTZTGmIeA3FGl5HlQ51JF791
 NRr1ijBl9Z6rBHPPg49+eeUNrf2uAy6wBfTnHRx7J1uVU2FHV6bB/9GymmcSvr/k8h95
 1H0ujD/h/RIwWoALKjinVQ8qt1idbIt7Cld9Y2KZARVTkR72hpSVMNP/hMZVfUItT0pQ
 +gGXNJO+5yAFWjSWMd8gC0sBlODu4aT9pTlEDwsS+WinWAhcCVsBu+HJoLKAXF9hc/tI
 ASn0c0g/PSdaLjVFs3AFA5JqfxK+6H1Nnyg0LsKuf0vDO7g3yNUjN61ddz/2fSTSe7Yc
 fIMw==
X-Gm-Message-State: AOAM532FmaNgumOOGiYFa8PFMKYqCiKBh9aP9H/xkajB8WWw/XmKaa0F
 raCx4l9m/vs4MTmRVGtICB0=
X-Google-Smtp-Source: ABdhPJylCwEmCslg5aa1nc2EitMfnv0khm5CC20SSkcpOfTgA4if26raJjt9hmbh77ooLfOKEQ2BOg==
X-Received: by 2002:a17:90a:fef:: with SMTP id
 102mr13385008pjz.148.1628144385681; 
 Wed, 04 Aug 2021 23:19:45 -0700 (PDT)
Received: from [192.168.50.71] (ip70-175-137-120.oc.oc.cox.net.
 [70.175.137.120])
 by smtp.gmail.com with ESMTPSA id l11sm5198375pfd.187.2021.08.04.23.19.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Aug 2021 23:19:45 -0700 (PDT)
Subject: Re: [PATCH 02/15] block: use bvec_virt in bio_integrity_{process,free}
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Geoff Levand <geoff@infradead.org>, Ilya Dryomov <idryomov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Song Liu <song@kernel.org>, Mike Snitzer <snitzer@redhat.com>,
 Coly Li <colyli@suse.de>, Stefan Haberland <sth@linux.ibm.com>,
 Jan Hoeppner <hoeppner@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Phillip Lougher <phillip@squashfs.org.uk>, linux-block@vger.kernel.org,
 dm-devel@redhat.com, linux-um@lists.infradead.org,
 ceph-devel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org
References: <20210804095634.460779-1-hch@lst.de>
 <20210804095634.460779-3-hch@lst.de>
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Message-ID: <b1d05349-86d2-0334-436f-811600ee1578@gmail.com>
Date: Wed, 4 Aug 2021 23:19:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210804095634.460779-3-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210804_231946_414018_7DED70F0 
X-CRM114-Status: UNSURE (   9.34  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 8/4/2021 2:56 AM, Christoph Hellwig wrote:
> Use the bvec_virt helper to clean up the bio integrity processing a
> little bit.
> 
> Signed-off-by: Christoph Hellwig<hch@lst.de>

Looks good.

Reviewed-by: Chaitanya Kulkarni <kch@kernel.org>

-- 
-ck

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
