Return-Path: <SRS0=SWCy=JM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1D2C433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 19:51:15 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1BD760FF0
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 19:51:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1BD760FF0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7Yy8TfikMDNFq0QF68KuBrPe3MFnwsgURswvfphMoB4=; b=HlWeIlf5oqrpcFDB0f4+k9V9x
	NG4ioCzWve++8GT1tdgNgPTuHQTYbXJHGyYys9Sy/rPHXu4ZnrKhZbRNtW1TxjZWV/OU0jMM+WFT5
	OiLAiIXzhYEjND1YL5xmltOBGrwfsy3RPqAxF7PdoNgHmzVEL6SyLfcJtg/qDkuh6t3f6JMNu+sOK
	tlj3KbvfGv/D0HJiZ3bq4Dilhdu/QplL9wPdQVBTfatAd/UOMvEIxXWJ9PaWpITK84H0CAQCwOulX
	L09GW3DYOqw+9m30Egky/MlSuo0ADfeCLDbQApOKQjnSsXssTJG+eYf3mmo0ix2RawysAPslVzGWn
	DV/ymnArQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lX80r-00HBP9-8o; Thu, 15 Apr 2021 19:50:53 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lX80n-00HBOj-8v
 for linux-nvme@desiato.infradead.org; Thu, 15 Apr 2021 19:50:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=jzSTR4S/XfBfmHFocbuUnh6F7IZZt8GfGeTP4lw6/K4=; b=AKboUUPsDiEAQYZJC0TKP/dLai
 ETQZpKfYGCm3YaDDXKU1cKsoJw9KZzRO4eOW2Yq7A9ZJiAJWCmVhr5eRP1ETfhqmmQkgDKGO6Pm5D
 thzxxwQcrUmOR2hryjNoYiApn656uY4D01UADjQmUJo+1YKSd3hi2heX1PvgBwBoE7tmIMJ4QXXwj
 YVzJY/MSvV4BzrKMSdWTW+QZWqPiaQ6ZAVxSa//rDboWD/5Fo7BsO8hdpJp71/tOLP9OcuYV7hWWT
 pdrgJJGIsHvT/m2PtW4nh7oveQMAVRmAwr2DJbX/Vc8wdCkTJjSgR8drlPxHSVruNG3dnJpU1lyFw
 5NP+icjA==;
Received: from mail-pj1-f54.google.com ([209.85.216.54])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lX80k-008rA6-SC
 for linux-nvme@lists.infradead.org; Thu, 15 Apr 2021 19:50:48 +0000
Received: by mail-pj1-f54.google.com with SMTP id
 e8-20020a17090a7288b029014e51f5a6baso8005254pjg.2
 for <linux-nvme@lists.infradead.org>; Thu, 15 Apr 2021 12:50:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jzSTR4S/XfBfmHFocbuUnh6F7IZZt8GfGeTP4lw6/K4=;
 b=VUjLpmVd3kF0SuHfZ9Bt3uXmYTQJRELOmgVFMx7TqnD46cUTGpKDDJeSJjBN5cS0CW
 12I0j3MGAu/Vqni9e9oAbC3arzqseZI4M+2QHV952Bj2iwvCoAjK7g+AcXqg4n7Gy1wX
 3RiEqqyA+p1WDLsh3SLoHMKAWfk+baOr8wBtbH3Tprm+lKggC3Kg0BgenADqDuHO7nRK
 +MSNffHhSrNgyxhpJRF0enzPsw+9JtXPZLPBLTim3Bsd+C6AfGOXEUHUdJM6UmARnoc+
 qSkDwkTmiiHO1c2ICV1EFPc0WZscvyUxt9Z1npKV7EqMrYuu/tL2KI2ByilP7t1g1yVQ
 t2fg==
X-Gm-Message-State: AOAM532q5DBU/FvbwCMSv7Uh/hfOy0rMt+ZqAv7w4buWrUILAumpE67+
 D4GLBap+kxQhyBaB/IeQrb0=
X-Google-Smtp-Source: ABdhPJxePiKeGIZglO2VnENKO4CmWRNHyXXkuqGu0pEa2yWYv+nCrnpvMLLjycBthAhK0BSdfce1dg==
X-Received: by 2002:a17:902:7689:b029:eb:3d5f:ae58 with SMTP id
 m9-20020a1709027689b02900eb3d5fae58mr5532107pll.39.1618516245716; 
 Thu, 15 Apr 2021 12:50:45 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:f031:1d3a:7e95:2876?
 ([2601:647:4000:d7:f031:1d3a:7e95:2876])
 by smtp.gmail.com with ESMTPSA id e9sm2997293pgk.69.2021.04.15.12.50.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Apr 2021 12:50:44 -0700 (PDT)
Subject: Re: [RFC PATCH 1/2] percpu_ref: add percpu_ref_tryget_many_live
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
 linux-raid@vger.kernel.org, Song Liu <song@kernel.org>,
 linux-nvme@lists.infradead.org, Tejun Heo <tj@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20210415103310.1513841-1-ming.lei@redhat.com>
 <20210415103310.1513841-2-ming.lei@redhat.com>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <dcdc3233-b4a6-24b2-85dd-78ed9e70fef1@acm.org>
Date: Thu, 15 Apr 2021 12:50:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210415103310.1513841-2-ming.lei@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210415_125046_937164_04F33193 
X-CRM114-Status: GOOD (  11.76  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 4/15/21 3:33 AM, Ming Lei wrote:
>  /**
> - * percpu_ref_tryget_live - try to increment a live percpu refcount
> + * percpu_ref_tryget_many_live - try to increment a live percpu refcount
>   * @ref: percpu_ref to try-get
> + * @nr: number of references to get

You may want to change "increment" into "increase" to make it more clear
that this function may increase the percpu refcount by more than one.

Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
