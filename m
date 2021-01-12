Return-Path: <SRS0=XnCc=GP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5F4C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 01:29:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C44D22E01
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 01:29:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C44D22E01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=G4xnfiGUqmV92E7iQiS2DO1sUaqHbNpCKAZIF5oudTE=; b=a7esrDopXQUTN2zMdD8QwzNZ9
	rYi+f2Vy6dTG1Qr/gZv8WjRuCMuwkUEj3O25Hv6oaP+IVtd7b7Deaj0xdaNvB1jqRoTXVvjNV59R/
	+oA0LlJx5fjMGOpaDOoYuRMvqbqpYqBVK0TCMZl/0UxfIb6nQvEt/yr1EWiAiRj+QZLJMdtBwUl4j
	ahqlPFiwG2vDUPyXr1IdjjbhedQfWSxgXEILyRxi/9yRg/GC40cu6OUYL3jY9ZetCu4lDnAludhCd
	h3KDWZMDeCVJpN1zIkgzfHZpQNcd9Y/+aCsPE4KQbBoH+r4IlYyLDtUzDF1fi5lR7r0S07gSsEEbu
	tgwODDfXg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kz8VF-0006el-0m; Tue, 12 Jan 2021 01:29:45 +0000
Received: from mail-pl1-f182.google.com ([209.85.214.182])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kz8VA-0006d8-VR
 for Linux-nvme@lists.infradead.org; Tue, 12 Jan 2021 01:29:43 +0000
Received: by mail-pl1-f182.google.com with SMTP id x12so486985plr.10
 for <Linux-nvme@lists.infradead.org>; Mon, 11 Jan 2021 17:29:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Dj+RXwLDVT/a6nxTyH38rM4ybZrWXLnkl+t0CxdurXU=;
 b=cunCExuvlZFAk0r5S9Eqq0O5nrubCNKtCfrJmPo3BeN/UbeBaCieLibsR8iQ4Mgk2/
 qrSf9Q+iYlszFwEXgSitKDaOdglfJb4+GTG0iucDN/GCxzJLE3+AqZ2ylOXhqwfVadut
 00bXKHSS6pTbWS95w3EuH2Fjd8tYbJhKyq0i0KNtsM/dRurtw5jbfe1tDO7FapZl8sbL
 BZXMoLiPuY0WmMJEsRsR4D8jowpzS5Xxxj+t6/Ta/QT5xNvaifLX+YndH+HrCcZLq4bl
 YaixaxeL29vxKOV1pK62rPZa4sDuaD2oCD2+1nweYBH4rR/ZbgYsg4KqjfrOjpTdgUPf
 YFhA==
X-Gm-Message-State: AOAM533RLlQvCGSrTSR2mEvm7RRdOgHGdWHd8daA0iXOJ4d9O8HQvqTs
 cZkGcckwMSZhrCRp3a6X9ZaAhdW8ePE=
X-Google-Smtp-Source: ABdhPJwICnmcZz3aigKU43p9J7hvhFuy4Z6ONCuKomU97U8pCJ8xsYUZjJu6a04mtqFOnMobOwQ7pA==
X-Received: by 2002:a17:902:16b:b029:dc:4ca1:f5fc with SMTP id
 98-20020a170902016bb02900dc4ca1f5fcmr2597778plb.26.1610414979569; 
 Mon, 11 Jan 2021 17:29:39 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:8187:1b02:7bea:17a7?
 ([2601:647:4802:9070:8187:1b02:7bea:17a7])
 by smtp.gmail.com with ESMTPSA id q15sm1053302pgk.11.2021.01.11.17.29.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Jan 2021 17:29:38 -0800 (PST)
Subject: Re: Data corruption when using multiple devices with NVMEoF TCP
From: Sagi Grimberg <sagi@grimberg.me>
To: Hao Wang <pkuwangh@gmail.com>
References: <CAJS6EdjsTVgs3JK3q2DePjEz1A0s9RJTOwqo=Ka7kinNMECtJw@mail.gmail.com>
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
 <4684c86a-8cc7-c5ae-0d6b-9f0e7c59eda5@grimberg.me>
Message-ID: <fcb56817-1f34-e307-e888-45ebb661c31d@grimberg.me>
Date: Mon, 11 Jan 2021 17:29:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4684c86a-8cc7-c5ae-0d6b-9f0e7c59eda5@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210111_202941_085555_77BCF4E7 
X-CRM114-Status: GOOD (  18.41  )
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


> Hey Hao,
> 
>> Here is the entire log (and it's a new one, i.e. above snippet not 
>> included):
>> https://drive.google.com/file/d/16ArIs5-Jw4P2f17A_ftKLm1A4LQUFpmg/view?usp=sharing 
>>
>>
>> What I found is the data corruption does not always happen, especially 
>> when I copy a small directory. So I guess a lot of log entries should 
>> just look fine.
> 
> So this seems to be a breakage that existed for some time now with
> multipage bvecs that you have been the first one to report. This
> seems to be related to bio merges, which is seems strange to me
> why this just now comes up, perhaps it is the combination with
> raid0 that triggers this, I'm not sure.

OK, I think I understand what is going on. With multipage bvecs
bios can split in the middle of a bvec entry, and then merge
back with another bio.

The issue is that we are not capping the last bvec entry send length
calculation in that.

I think that just this can also resolve the issue:
--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 973d5d683180..c6b0a189a494 100644
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
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
