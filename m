Return-Path: <SRS0=K5Lp=F4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DA4C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Dec 2020 02:57:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50ED6224B1
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Dec 2020 02:57:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50ED6224B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=52ianQgLVweSGv9Ew7Vkbh7ePmcaHfczuSJBD8Ygi/A=; b=ujchqpyNqc2MS3ltuGNUdVhy/
	73GI2R2zE5JS1RtAG/lYIUlE3xEnI+4yAc276yWPt96qEkhfJ+6rWu/j2xaTngOPdEv7xcpo/01Xc
	zwlJpptWz4CJizuooMlEOs4BHBZ56SsX/UlrL24aFSrGCstpxxAkytEGm10X48LL/erhtrmcrjy5X
	t30RHgGxLWWjNZ3qXaeWr0l/dBhLT5XDkuwezUJ03ZLXlm2TsofgDZFtanT9P5ER2ymLqAcG16YdY
	t+Psqjouz+8PuqyAgBKDUJY/bBd9YwGlp2PKKElkOoLWEHHMM88sIf/RMUZsp9YeTalNGrO3BjA1E
	wFAwfGt3A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ksGok-0004vc-5T; Thu, 24 Dec 2020 02:57:30 +0000
Received: from mail-pg1-f173.google.com ([209.85.215.173])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ksGog-0004uu-44
 for Linux-nvme@lists.infradead.org; Thu, 24 Dec 2020 02:57:28 +0000
Received: by mail-pg1-f173.google.com with SMTP id n25so780852pgb.0
 for <Linux-nvme@lists.infradead.org>; Wed, 23 Dec 2020 18:57:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kCoesy/QRwsiON2IhYdMDoMw3tiouLTAsPPX3McP9dI=;
 b=ix6B4hON06woaMwSvOcm6XZ1dj+pT/i1iwgpfagQM1FxNgT7XYOs5MAcf47TinXbl5
 1J/0z+mwDd+iw90TmvXRJ3gv7UTBMjkPSkMzsqonw+POxwfi284+6lhYh6+EToDX34Fy
 Yjx/AN+m9SA1p50c3mWVe/9ZKWaCnskek2yfB7jVJklHG33Ch4v/lMjy8gEC3ZqHPR72
 IWEtpoqoxlnvW0gAZ35pRBpszxuf7VPNJaKRxzLf1X/v0GItxnzIGDoJLJtpU77En6iq
 j2q1ArKw3Ot/sPAGVr4oJSTamSfTfUFWbfnl2vumpBYWpcVssFeOCBizEV6x61T7UO0Z
 n+6g==
X-Gm-Message-State: AOAM531NMgR5O06gpDznFuEs1mm1PWN+9dxf1PwZfhS8+EC8ns9Pg/ft
 DBbk+NEXj7wOlJLeSqIbunOcukR7Yws=
X-Google-Smtp-Source: ABdhPJz+kb3aIhvVB8+tuKX1waPhmEK3LB9L/QLkqt1pncouvdiOayNFu/mL9W62q5/pX7uIM9UErg==
X-Received: by 2002:aa7:8483:0:b029:1a5:b071:fb8e with SMTP id
 u3-20020aa784830000b02901a5b071fb8emr25950220pfn.48.1608778644535; 
 Wed, 23 Dec 2020 18:57:24 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:8c81:7d09:c1ab:94c8?
 ([2601:647:4802:9070:8c81:7d09:c1ab:94c8])
 by smtp.gmail.com with ESMTPSA id s29sm26462052pgn.65.2020.12.23.18.57.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Dec 2020 18:57:23 -0800 (PST)
Subject: Re: Data corruption when using multiple devices with NVMEoF TCP
To: Hao Wang <pkuwangh@gmail.com>, Christoph Hellwig <hch@infradead.org>
References: <CAJS6EdjsTVgs3JK3q2DePjEz1A0s9RJTOwqo=Ka7kinNMECtJw@mail.gmail.com>
 <2c0ff5ec-4ae2-ad29-67fb-4744514dab47@grimberg.me>
 <CAJS6Edh8aVAHhKRGqU+7v5C3KY7YxczVg_7Q8QrPGtyvVw7K3w@mail.gmail.com>
 <fd4541e4-78c5-ec3b-b272-467fd11f7472@grimberg.me>
 <20201223084332.GA30502@infradead.org>
 <CAJS6EdijX6ws_wHxygdpcYGtB6JFwLDbDE3A0t0QUYS-LbRakg@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <16d876c1-524a-38d3-3cff-99ec694464b2@grimberg.me>
Date: Wed, 23 Dec 2020 18:57:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJS6EdijX6ws_wHxygdpcYGtB6JFwLDbDE3A0t0QUYS-LbRakg@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201223_215726_206336_FDE480DB 
X-CRM114-Status: GOOD (  16.40  )
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
Cc: Linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Okay, tried both v5.10 and latest 58cf05f597b0.
> 
> And same behavior
>   - data corruption on the initiator side when creating a raid-0 volume
> using 2 nvme-tcp devices;
>   - no data corruption either on local target side, or on initiator
> side but only using 1 nvme-tcp devoce.
> 
> A difference I can see on the max_sectors_kb is that, now on the
> target side, /sys/block/nvme*n1/queue/max_sectors_kb also becomes
> 1280.
> 

Thanks Hao,

I'm thinking we maybe have an issue with bio splitting/merge/cloning.

Question, if you build the raid0 in the target and expose that over
nvmet-tcp (with a single namespace), does the issue happen?

Also, would be interesting to add this patch and see if the following
print pops up, and if it correlates when you see the issue:

--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 979ee31b8dd1..d0a68cdb374f 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -243,6 +243,9 @@ static void nvme_tcp_init_iter(struct 
nvme_tcp_request *req,
                 nsegs = bio_segments(bio);
                 size = bio->bi_iter.bi_size;
                 offset = bio->bi_iter.bi_bvec_done;
+               if (rq->bio != rq->biotail)
+                       pr_info("rq %d (%s) contains multiple bios bvec: 
nsegs %d size %d offset %ld\n",
+                               rq->tag, dir == WRITE ? "WRITE" : 
"READ", nsegs, size, offset);
         }

         iov_iter_bvec(&req->iter, dir, vec, nsegs, size);
--

I'll try to look further to understand if we have an issue there.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
