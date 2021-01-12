Return-Path: <SRS0=XnCc=GP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1965DC43331
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 00:37:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27C8222E03
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 00:36:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27C8222E03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nxkY/mfANYopWA+q66f7/Utlsq86H+9AcsLfw+g+Qyw=; b=LukFarcZaSF8g5thEqYAR+39p
	OMNx8bI0jM+rTcH/1U+cgHR/EZyhipZz8TPbKZDYGhTQNQ60PxkpQNVGxF6HhJoxMdIHOHne1ZUY4
	Q3TOGSoiHrRPx7dDrFn4qvQj17HQFFeSIbV6U3epsoHM0mvKQhGwC/pJBrGXqyxc4IrS6Fni2zpSl
	o5EiDv9nj5Ejm9bCyex7cqPSet1p31Maj93T9TQ7lsq+yEI2Z4aZwtk+FTSTQlzn1lFa2ypkXop47
	n8vSD6I5NS5LST5LVTerjNCk7hGJRi8rGNtsNPcjdSKAj5aMLuK/ffsD6W5bEX1Ebrb5LcvjHObGM
	/9ptxT2sw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kz7fr-0000c7-Hn; Tue, 12 Jan 2021 00:36:39 +0000
Received: from mail-pj1-f52.google.com ([209.85.216.52])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kz7fp-0000as-6m
 for Linux-nvme@lists.infradead.org; Tue, 12 Jan 2021 00:36:38 +0000
Received: by mail-pj1-f52.google.com with SMTP id j13so577741pjz.3
 for <Linux-nvme@lists.infradead.org>; Mon, 11 Jan 2021 16:36:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=O1uxIu/6aXkPXuT5N2fckE6aCRDBZKp3ip0rmrRK4Vs=;
 b=n4Dxoxgx3+qPceGMC29tOvZDUKKtWDLicfaamLpK8B4pUtcM8wZbpCqmcBeLzNf7rP
 V95gr+Mir8hLxFFVvD2Iz1CDY0BzdD/NFPKBGx623FfEbMVVeVqk4e5YRP4kH0o/UbDl
 c0ryv1V534VNS+YFj2/TIxWEe+rH8jGLDMFo/naNO7hSk4LccQz4f1816dFq1LZdfzkJ
 2NQy0cEC297D5NkMA0Zc+IjNyjIv7pYmMUNrcaER+3TiJlC+rnRZ9bYDRALn+CYsMjLt
 kmJ06AXD3tICN+Mz7ggvh0Y8anDuLKQhOeLoont34m6c+Icsxzb2q9SE09ZmRg7PofZs
 sXqA==
X-Gm-Message-State: AOAM532guvp3jgy0bCqUZMu/O2XUJgqWk69vVzRwJvB9gdb5QmGeJ+nz
 iwW7yjE0HvQiEdbzm2CiKtIrCbGS6gs=
X-Google-Smtp-Source: ABdhPJwalQKx1F0z9e7TUhhAgXcBNecnZjWD8HIh14Dy3Ax9m1kXiyRCbySI3cUKzWxenZJNSbYEHA==
X-Received: by 2002:a17:902:ff0e:b029:da:d4ee:eca3 with SMTP id
 f14-20020a170902ff0eb02900dad4eeeca3mr2355160plj.41.1610411795297; 
 Mon, 11 Jan 2021 16:36:35 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:8187:1b02:7bea:17a7?
 ([2601:647:4802:9070:8187:1b02:7bea:17a7])
 by smtp.gmail.com with ESMTPSA id ck20sm626555pjb.20.2021.01.11.16.36.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Jan 2021 16:36:34 -0800 (PST)
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
 <a6564a08-a3b0-5c22-51e3-712c4714bcc5@grimberg.me>
 <CAJS6Edgb+yCW5q5dA=MEkL0eYs4MXoopdiz72nhkxpkd5Fe_cA@mail.gmail.com>
 <ae5b1654-e580-88be-0498-0cd111b53fa2@grimberg.me>
 <CAJS6Edjkfvs4pfH9XvwAT0h4STuoDh1PahSxkkTWOsKwgL5pZQ@mail.gmail.com>
 <16fe1e9c-3a43-ef28-7b69-755e6a86464f@grimberg.me>
 <CAJS6Edi9Es1zR9QC+=kwVjAFAGYrEru4vibW42ffyWoMDutFhQ@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4684c86a-8cc7-c5ae-0d6b-9f0e7c59eda5@grimberg.me>
Date: Mon, 11 Jan 2021 16:36:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJS6Edi9Es1zR9QC+=kwVjAFAGYrEru4vibW42ffyWoMDutFhQ@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210111_193637_294819_767F6AAF 
X-CRM114-Status: GOOD (  17.29  )
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

Hey Hao,

> Here is the entire log (and it's a new one, i.e. above snippet not 
> included):
> https://drive.google.com/file/d/16ArIs5-Jw4P2f17A_ftKLm1A4LQUFpmg/view?usp=sharing
> 
> What I found is the data corruption does not always happen, especially 
> when I copy a small directory. So I guess a lot of log entries should 
> just look fine.

So this seems to be a breakage that existed for some time now with
multipage bvecs that you have been the first one to report. This
seems to be related to bio merges, which is seems strange to me
why this just now comes up, perhaps it is the combination with
raid0 that triggers this, I'm not sure.

IIUC, this should resolve your issue, care to give it a go?
--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 973d5d683180..6bceadc204a8 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -201,8 +201,9 @@ static inline size_t nvme_tcp_req_cur_offset(struct 
nvme_tcp_request *req)

  static inline size_t nvme_tcp_req_cur_length(struct nvme_tcp_request *req)
  {
-       return min_t(size_t, req->iter.bvec->bv_len - req->iter.iov_offset,
-                       req->pdu_len - req->pdu_sent);
+       return min_t(size_t, req->iter.count,
+                       min_t(size_t, req->iter.bvec->bv_len - 
req->iter.iov_offset,
+                               req->pdu_len - req->pdu_sent));
  }

  static inline size_t nvme_tcp_pdu_data_left(struct nvme_tcp_request *req)
@@ -223,7 +224,7 @@ static void nvme_tcp_init_iter(struct 
nvme_tcp_request *req,
         struct request *rq = blk_mq_rq_from_pdu(req);
         struct bio_vec *vec;
         unsigned int size;
-       int nsegs;
+       int nsegs = 0;
         size_t offset;

         if (rq->rq_flags & RQF_SPECIAL_PAYLOAD) {
@@ -233,11 +234,15 @@ static void nvme_tcp_init_iter(struct 
nvme_tcp_request *req,
                 offset = 0;
         } else {
                 struct bio *bio = req->curr_bio;
+               struct bvec_iter bi;
+               struct bio_vec bv;

                 vec = __bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
-               nsegs = bio_segments(bio);
+               bio_for_each_bvec(bv, bio, bi) {
+                       nsegs++;
+               }
                 size = bio->bi_iter.bi_size;
-               offset = bio->bi_iter.bi_bvec_done;
+               offset = mp_bvec_iter_offset(bio->bi_io_vec, 
bio->bi_iter) - vec->bv_offset;
         }

         iov_iter_bvec(&req->iter, dir, vec, nsegs, size);
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
