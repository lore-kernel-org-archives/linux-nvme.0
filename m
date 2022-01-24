Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC8AC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jan 2022 19:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GLaZfB9I2LW9NeKFD2WW2Oku6S9Lctym5AUPyw4r0EY=; b=EbjeKalmWRjqygWsnOby0Zrfsb
	wUT9XaL+f8fM7ddN5PieW9OnaES03gvceyK05M2fXpaa6rNo63hVzeyxNH9hxln5Sha0mXWL8Qwh7
	8DF08Q2nuhwS65bkxwAGf017OirYOOrvsB6NQ5yyxE6wmaSouf0O4ZJSthMsuKu1IAD5R42Ulm63p
	WBokZaCActApLxXgU0AFoX/Jyg97SJuJo3OkL9GVatF5L5fAUuAZMtNL4yMUxjSQ2MN0FJHK4Mwtf
	89Z49MGIDet7seYzM1M3NxqJv7vdkGSc5JItiGIBlUib4Ub/7ZRXdaWejrY/kTRKp8v4OtMIZFAlN
	JrI2x5hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nC4lR-004nXz-CF; Mon, 24 Jan 2022 19:12:29 +0000
Received: from mail-pf1-f175.google.com ([209.85.210.175])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nC48f-004X3B-0A
 for linux-nvme@lists.infradead.org; Mon, 24 Jan 2022 18:32:26 +0000
Received: by mail-pf1-f175.google.com with SMTP id y27so12690615pfa.0
 for <linux-nvme@lists.infradead.org>; Mon, 24 Jan 2022 10:32:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=GLaZfB9I2LW9NeKFD2WW2Oku6S9Lctym5AUPyw4r0EY=;
 b=43iydJ9N+EvO+wW8Q1KiKdLSpo2wv+uWhXfnTO8ZNfAhwq+ft51UnrmyfpbaZps1ws
 QAzQTvyz9QTNU5Z/sCVn8ET0KohKmxhO44flsVAuizQf3qe+Z2G/6DThRuvDaECTgeid
 0rGX8c2Sdg8XNuVK6yGWAC67+78kI2ocX76upf0HCZG3xzlRFj9cSMHGm0xKXNx1ivrp
 T6YdGwUExqvhe0wnqnnmAwFb0Mnh8r37W4sDNpQxI6sfsoWn9xEMt/X4XaLtlQM3hwkX
 R94e+Il2nsZiz7TlR5vIH2UgaujXutvomjJjVpZQ3Ih1+/7mRxaD7MxRQgCk9NOrsnuO
 HdFg==
X-Gm-Message-State: AOAM533c3eNFwzQSbJ0FUZLIgI5Wa9jw77JkTNL1kJosqgp56+3gM2uZ
 dZORsco8LQesBCK+dbANoD0=
X-Google-Smtp-Source: ABdhPJzA51riiYOrypw+qulVvPjMNxUCWtPJGWOxpGCXrMtb9yuuv88+rFUnia/iPBRRB6INTPErIQ==
X-Received: by 2002:a63:205:: with SMTP id 5mr12627815pgc.379.1643049142834;
 Mon, 24 Jan 2022 10:32:22 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd?
 ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
 by smtp.gmail.com with ESMTPSA id l21sm16939528pfu.120.2022.01.24.10.32.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jan 2022 10:32:21 -0800 (PST)
Message-ID: <db0d9760-9cff-e85b-ca2a-003c297322d1@acm.org>
Date: Mon, 24 Jan 2022 10:32:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V2 02/13] block: move initialization of q->blkg_list into
 blkcg_init_queue
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org
References: <20220122111054.1126146-1-ming.lei@redhat.com>
 <20220122111054.1126146-3-ming.lei@redhat.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220122111054.1126146-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220124_103225_100549_7371BF76 
X-CRM114-Status: UNSURE (   8.50  )
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

On 1/22/22 03:10, Ming Lei wrote:
> q->blkg_list is only used by blkcg code, so move it into
> blkcg_init_queue.

Should Tejun be Cc-ed for this patch?

Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

