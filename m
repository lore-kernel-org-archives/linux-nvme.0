Return-Path: <SRS0=S77o=F5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9DFC433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Dec 2020 09:06:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B66422795
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Dec 2020 09:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B66422795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5Fb/pQi+8WC3EkNUkRxQuPURDNGnbFSgomejhNOD32A=; b=zAPWr3bAGzcGp9BbMtisj7md5
	qOkbMXyEw9DOo2IJMEa3ktQnO7Ck/PmSXOsB5JYsS8BqKuiMjYyxvgeVv4wYkmR2eakWWXBDZxTif
	xvCz+Tgg7YNsQB57JLZ1LQgm4VEYcIn/T5j5fhCo0Z1yMslOPaCKJjL1BxXFlJiDvaFS6mlMVyyre
	bDvbaRbtxamnYOpiP48KizpTBZc34TdPbJ03udL0im7QyhqEwE/2tFQza9yi/bbUqwLrLqhOlwnHq
	4s1cqtk/3eMcaQsVPTn8mqO7upghkTQUts3dWfdpxGNlzQ2S9GE89lSxUmzuyADNS/Z2Rxymz6eOR
	ktgF0cwsQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ksj2w-0001hP-4r; Fri, 25 Dec 2020 09:06:02 +0000
Received: from mail-pj1-f49.google.com ([209.85.216.49])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ksj2t-0001gl-EL
 for Linux-nvme@lists.infradead.org; Fri, 25 Dec 2020 09:06:00 +0000
Received: by mail-pj1-f49.google.com with SMTP id j13so2324447pjz.3
 for <Linux-nvme@lists.infradead.org>; Fri, 25 Dec 2020 01:05:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kHKlkwKRI6xpf/0LqvqgKwoMwqMxnIXnno92pqlURf0=;
 b=h5az/9uWG5EKhMf2nsilC2KAftGLk6szibrBCMjhICkb3LMikiMNWwiJUcdCtaqNQ8
 Hkr81vmbuDjb9nL10vMkKanGlJBDuRynsKMVANEHRty9Qt8EbjNJmPFlhPcktq2lAR8s
 Gryj9/zyfnQbvvWPXRDht0kUoxNGVxmg0rh9lGCBbqGhP9Bd1t1WYpg/RJjv0Zp1K1xr
 omm7lSkFhtbd9LHnXdxEFP6p5xdUIkuCKcKUeKfTaZyq0VB1oBqc/fuIzw8vO/1jz2RT
 U1sfoYMLCy3uGN6Djj9/Bko0RI3q5tYq6CMIz4zz5Ohhe5qaLQY9e/ZRHiW4nZLBGZMH
 n1Ug==
X-Gm-Message-State: AOAM533ZTyAmUkjCSz8lAC2QB8NOMpPy0wrYr7hk5u7VUo9dhdeUZ7Xk
 Uy3e10gcgkvnrOwEN0DimxtwLnuM8hs=
X-Google-Smtp-Source: ABdhPJxR97CxAGPn6hOjnB+aRFD8npLplrnx2muVaiq9AiAeimpFqogwhnf2WjCgmHSVn7GlCxyLfw==
X-Received: by 2002:a17:90a:1b0d:: with SMTP id
 q13mr7886090pjq.21.1608887156795; 
 Fri, 25 Dec 2020 01:05:56 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:a837:43c7:da34:a96d?
 ([2601:647:4802:9070:a837:43c7:da34:a96d])
 by smtp.gmail.com with ESMTPSA id ay21sm4946248pjb.1.2020.12.25.01.05.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Dec 2020 01:05:55 -0800 (PST)
Subject: Re: Data corruption when using multiple devices with NVMEoF TCP
To: Hao Wang <pkuwangh@gmail.com>
References: <CAJS6EdjsTVgs3JK3q2DePjEz1A0s9RJTOwqo=Ka7kinNMECtJw@mail.gmail.com>
 <2c0ff5ec-4ae2-ad29-67fb-4744514dab47@grimberg.me>
 <CAJS6Edh8aVAHhKRGqU+7v5C3KY7YxczVg_7Q8QrPGtyvVw7K3w@mail.gmail.com>
 <fd4541e4-78c5-ec3b-b272-467fd11f7472@grimberg.me>
 <20201223084332.GA30502@infradead.org>
 <CAJS6EdijX6ws_wHxygdpcYGtB6JFwLDbDE3A0t0QUYS-LbRakg@mail.gmail.com>
 <16d876c1-524a-38d3-3cff-99ec694464b2@grimberg.me>
 <CAJS6EdivEF0c=3FmKj4wGZoVRKbUvjH_qJLXmO7Tvwsp+km0rw@mail.gmail.com>
 <f631893c-5ce9-95fd-c32c-35a7e70d093c@grimberg.me>
 <CAJS6EdjUAb77-rWd=XmFhsM2_3Hds6VV6jQUVPJoJQHhk12J_Q@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a6564a08-a3b0-5c22-51e3-712c4714bcc5@grimberg.me>
Date: Fri, 25 Dec 2020 01:05:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJS6EdjUAb77-rWd=XmFhsM2_3Hds6VV6jQUVPJoJQHhk12J_Q@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201225_040559_525581_530466B8 
X-CRM114-Status: GOOD (  14.20  )
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
Cc: Christoph Hellwig <hch@infradead.org>, Linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> In my current setup, on the initiator side, nvme3n1 & nvme4n1 are 2
> nvme-tcp devices, schedulers for 3 is:
>   - cat /sys/block/nvme3n1/queue/scheduler: "none"
>   - cat /sys/block/nvme3c3n1/queue/scheduler: "[none] mq-deadline kyber"
> Not sure what is nvme3c3n1 here?
> 
> And disabling merges on nvme-tcp devices solves the data corruption issue!

Well, it actually confirms that we have an issue when we get a multi-bio
request that was merged. I'm assuming you also do not see the prints
I added in this case...

Would you mind adding these prints (they will overload probably, but
may be useful to shed some light on this):
--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 979ee31b8dd1..5a611ddb22ea 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -243,6 +243,16 @@ static void nvme_tcp_init_iter(struct 
nvme_tcp_request *req,
                 nsegs = bio_segments(bio);
                 size = bio->bi_iter.bi_size;
                 offset = bio->bi_iter.bi_bvec_done;
+               if (rq->bio != rq->biotail) {
+                       int bio_num = 1;
+                       struct bio *ptr = rq->bio;
+                       while (ptr != bio) {
+                               ptr = ptr->bi_next;
+                               bio_num++;
+                       };
+                       pr_info("rq %d (%s) data_len %d bio[%d/%d] 
sector %llx bvec: nsegs %d size %d offset %ld\n",
+                               rq->tag, dir == WRITE ? "WRITE" : 
"READ", req->data_len, bio_num, blk_rq_count_bios(rq), 
bio->bi_iter.bi_sector, nsegs, size, offset);
+               }
         }

         iov_iter_bvec(&req->iter, dir, vec, nsegs, size);
--

Thank you for helping isolating this issue.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
