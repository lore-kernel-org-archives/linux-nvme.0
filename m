Return-Path: <SRS0=1rws=HL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BC5C433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 18:02:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8154564DBA
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 18:02:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8154564DBA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9agmt6F+mhv23a19BAX1BSHfIJvO/BYoWDNaRfmJY98=; b=zrQ/3OxuCzoJSS/oJ8rBwj5fn
	ko9TSpf2b7aVV4g2cnyrZ7jw6h32sFOtgJ8Gio2sibXtSl1/eCVulq5GQZZ/pZoHED72rAUF2e/L3
	2jrPvCXM3mJdi5RZFySqzEgyf9NOxRT+qHESdzfF7ss6WDh4rQIprfqvmz/cXFZKLZb2DfU1GMF6M
	WBzqD5Zsy7LdsoLK38y3oOjth9bjz2P6GEJz4rZd6LlCyKLl41LYqy3eHdDxC32OlInT+oFfjWpvH
	OiFBMLFETcEbW8tzkENtLTiacaa9ycbRYAWfGPjK17GRQgrd5iPS7LK7IeUNVRAmHx67PHNEZEZh4
	XBNXlvK5Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9XKp-0003cS-4U; Tue, 09 Feb 2021 18:01:59 +0000
Received: from mail-oi1-f178.google.com ([209.85.167.178])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9XKl-0003aY-Hx
 for linux-nvme@lists.infradead.org; Tue, 09 Feb 2021 18:01:56 +0000
Received: by mail-oi1-f178.google.com with SMTP id y199so18345441oia.4
 for <linux-nvme@lists.infradead.org>; Tue, 09 Feb 2021 10:01:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Iq8/ZgeqgaKeHpzc+K70RawUm9UDMRthE6hF9QeYZYQ=;
 b=KsXj0oK81wABUyoDnqIk1WfpO9T1NZJsfNiLLWbetD2JY54zgrXxeIC2Z+E6lZYvNE
 WjNP13/OhhDGwuc3ROWc5davKsQRiv2lAJp/LCM9INxapNs3J+nSm1MWM3Dy1qsHmJDd
 Fi/Mfqk+ayOWpyzX/9ENfRCdjOXetr2pkKlSrbuVWU2cwRTJ9xtGDiu+/7qKoDe6Uh4A
 dm8xU92N8OTZjTMqVknyubsonuTjS2uIoogEqyEKSrvwvCd7J0REyxzpZEo4QO9WT0aM
 E6hUqQHXENqJWcoxi3OO44D0lDqV53iajDG18rZVB/tUtPp5i7KFWoNgdzD4G+TvgkdC
 PzeA==
X-Gm-Message-State: AOAM533p9DAxJKQ3FUcTjggcwA8iaOvUZXdO28ZfyuUH1clLYeLoMLnh
 f79jqyO4UyXxyxokHnqGBjE=
X-Google-Smtp-Source: ABdhPJzfDNYVoZUsFJ4psb2NCXI3S4JznsGzCUt+B4N306WmYvCG4yZEEN3V7pKAqEU/tW9kLYwLJQ==
X-Received: by 2002:aca:48c:: with SMTP id 134mr3267246oie.16.1612893714659;
 Tue, 09 Feb 2021 10:01:54 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:fba0:f308:bf9a:df5c?
 ([2600:1700:65a0:78e0:fba0:f308:bf9a:df5c])
 by smtp.gmail.com with ESMTPSA id q3sm4386185oih.35.2021.02.09.10.01.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Feb 2021 10:01:54 -0800 (PST)
Subject: Re: kernel null pointer at nvme_tcp_init_iter+0x7d/0xd0 [nvme_tcp]
To: Yi Zhang <yi.zhang@redhat.com>, linux-nvme@lists.infradead.org,
 linux-block <linux-block@vger.kernel.org>
References: <cki.F3E139361A.EN5MUSJKK9@redhat.com>
 <630237787.11660686.1612580898410.JavaMail.zimbra@redhat.com>
 <e1d08160-ca49-91e2-dafc-3ee80516842d@grimberg.me>
 <5848858e-239d-acb2-fa24-c371a3360557@redhat.com>
 <a88fd4c8-8d5c-6934-39bc-5c864e3ed84f@grimberg.me>
 <aec13f12-640c-77d5-bbdd-b4a3e18f1bf2@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6ae16841-5f51-617a-aab7-666b7eed299c@grimberg.me>
Date: Tue, 9 Feb 2021 10:01:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <aec13f12-640c-77d5-bbdd-b4a3e18f1bf2@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210209_130155_646480_0D340705 
X-CRM114-Status: GOOD (  17.57  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: axboe@kernel.dk, Rachel Sibley <rasibley@redhat.com>,
 Chaitanya.Kulkarni@wdc.com, CKI Project <cki-project@redhat.com>,
 Ming Lei <ming.lei@redhat.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>>> Thanks for reporting Ming, I've tried to reproduce this on my VM
>>>> but did not succeed. Given that you have it 100% reproducible,
>>>> can you try to revert commit:
>>>>
>>>> 0dc9edaf80ea nvme-tcp: pass multipage bvec to request iov_iter
>>>>
>>>
>>> Revert this commit fixed the issue and I've attached the config. :)
>>
>> Hey Ming,
>>
>> Instead of revert, does this patch makes the issue go away?
> Hi Sagi
> 
> Below patch fixed the issue, let me know if you need more testing. :)

Thanks Yi,

I'll submit a proper patch, but can you run this change
to see what command has a bio but without any data?
--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 619b0d8f6e38..311f1b78a9d4 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2271,8 +2271,13 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct 
nvme_ns *ns,
         req->data_len = blk_rq_nr_phys_segments(rq) ?
                                 blk_rq_payload_bytes(rq) : 0;
         req->curr_bio = rq->bio;
-       if (req->curr_bio)
+       if (req->curr_bio) {
+               if (!req->data_len) {
+                       pr_err("rq %d opcode %d\n", rq->tag, 
pdu->cmd.common.opcode);
+                       return BLK_STS_IOERR;
+               }
                 nvme_tcp_init_iter(req, rq_data_dir(rq));
+       }

         if (rq_data_dir(rq) == WRITE &&
             req->data_len <= nvme_tcp_inline_data_size(queue))
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
