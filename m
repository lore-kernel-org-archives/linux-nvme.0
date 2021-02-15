Return-Path: <SRS0=Cnjr=HR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD20C433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Feb 2021 21:42:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D3AA64DEB
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Feb 2021 21:42:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D3AA64DEB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=l1aLbLKcZZROBe/PLJ3CAPgBn7YNBiijh8N2zg7breY=; b=VsrcmorITJJXHhVXdaZbc+dbY
	yw3ocgRpgHiEFkMwHMLmFjJxK9Vz1L/OkhPxkyaJSldrqGdWvBiCrFpX0crf2g4aWYEJs4+0Za00K
	5LxSyDHFkBg4i2nDp9zUjroRbIsll2Nwfiq+ZXnljr2oX0Z3yYsCwcCkv+l0y0PpMGsQ2hIYgY2/h
	bpQ8ASooY1mL1XTBNyf3tweFPnZo0CV8gDSxuXfpC3jjx6lpSZyH4pPGHr+L1FWj2mUhn0zY3EPAs
	Y5HrT/N73aLQHFBc3PCNoCmD+/sS7YpZV+HFbr+SqpQa1yh51ZFMgr4NUILlwY30PxH8yXLZg4gAt
	vyNHkMpgw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lBldd-00047C-Sb; Mon, 15 Feb 2021 21:42:37 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lBlda-00046X-NK
 for linux-nvme@lists.infradead.org; Mon, 15 Feb 2021 21:42:35 +0000
Received: by mail-wr1-f48.google.com with SMTP id v14so10769960wro.7
 for <linux-nvme@lists.infradead.org>; Mon, 15 Feb 2021 13:42:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=baba1EYbLYIBXg3ORjndRJNVh9sQDmT87KzXuITG1HA=;
 b=IPnGemD3VEP6ZOF5imNye/SKlRPfccdOCUXAmkcIa0T8QBttOrb/TRr1Ql+oOZFrQO
 gKDNZyhwsVmG7qTbxVgHAdJegq3ZgNrX2O3fZC/nCRpjR8Uv6qpVrpiAA1MafNAadyUj
 MTC06dU0Qe+bSQ4Jn5xMQlCCacRgl1gXZ4TJawWO/Mo3y9XIrJnZuwdxfeiOT7ywWLTR
 BY3EoFcLqHUzAINxNQOvsOm4sVlkGnfrOjPIf5qh4+OHbnmMjI1gRhZdKWOlzUXmdrJb
 CQHMRTZdwN7lKa9d8pAV1g2d8J8SgjJccjrdi/ezhCQ9NxkV2lYYBa2eEKI6rZSl0JlP
 AFHg==
X-Gm-Message-State: AOAM532DW8bV44sMC3yfB7XJibWAsnO/dDh3t+8tBgks6qy3/mjuRaeW
 ufpnfs/rpssPeFL+ve8UFN34uUtbb6c=
X-Google-Smtp-Source: ABdhPJwXvsRNj+oGFRoYnATFLM1CSWwK3gmfG40s2idLOp29yhtcy493CrYv8N2u3nEieFISK3ZZhQ==
X-Received: by 2002:adf:fb51:: with SMTP id c17mr5504882wrs.145.1613425352946; 
 Mon, 15 Feb 2021 13:42:32 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:e348:9c6c:4cb7:8321?
 ([2601:647:4802:9070:e348:9c6c:4cb7:8321])
 by smtp.gmail.com with ESMTPSA id q21sm981681wmj.18.2021.02.15.13.42.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Feb 2021 13:42:32 -0800 (PST)
Subject: Re: nvme-tcp bricks my computer
From: Sagi Grimberg <sagi@grimberg.me>
To: "Belanger, Martin" <Martin.Belanger@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <SJ0PR19MB45443358535A404035588EC5F2B69@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <42f94a06-cc66-87dd-3a92-de793a228d22@grimberg.me>
 <SJ0PR19MB4544B86790800C6371E7F96AF2B49@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <ccb20293-efdf-ee96-d97f-405ced9b67a5@grimberg.me>
 <69e0073c-35cd-552d-eccd-2092ab49c38d@grimberg.me>
 <SJ0PR19MB4544A3DF2B1B2A1EEB8D1B41F2B39@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <43ca75a5-e751-6b9b-2a0d-336dbbc207a1@grimberg.me>
 <2251aa94-0d6c-1405-b1d8-185bcd714d8c@grimberg.me>
 <SJ0PR19MB45442A0B8E171B55A8AACACEF2B29@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <8937148e-f667-9a05-3828-58114dca6da3@grimberg.me>
 <SJ0PR19MB4544A653D3A84A19A28D3984F28E9@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <1a430561-498c-70dd-f14b-8fab10673f65@grimberg.me>
 <SJ0PR19MB4544CAB0A539F84E54EC5208F2889@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <7f5ff08a-36f0-3b67-9753-20eedd4b6f4d@grimberg.me>
Message-ID: <8bcaaef7-76b3-0c57-d343-1581807a6d02@grimberg.me>
Date: Mon, 15 Feb 2021 13:42:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <7f5ff08a-36f0-3b67-9753-20eedd4b6f4d@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210215_164234_775898_9D61F69F 
X-CRM114-Status: GOOD (  22.69  )
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

>> Hi Sagi,
> =

> Hey,
> =

>> Just to give you an update...
>>
>> We're still investigating the root cause of the crash.
>>
>> We found a bug in our Discovery Controller related to SGL format =

>> (format 0x5A vs. 0x01). When the host sends a "Set Feature" to =

>> configure AER/AEN with a SGL format of 0x5A,
> =

> This is coming from:
> -- =

> static void nvme_tcp_set_sg_null(struct nvme_command *c)
> {
>  =A0=A0=A0=A0=A0=A0=A0 struct nvme_sgl_desc *sg =3D &c->common.dptr.sgl;
> =

>  =A0=A0=A0=A0=A0=A0=A0 sg->addr =3D 0;
>  =A0=A0=A0=A0=A0=A0=A0 sg->length =3D 0;
>  =A0=A0=A0=A0=A0=A0=A0 sg->type =3D (NVME_TRANSPORT_SGL_DATA_DESC << 4) |
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 NV=
ME_SGL_FMT_TRANSPORT_A;
> }
> -- =

> =

>  =A0the DC responds with an R2T, which is
>> obviously a bug. This does not happen when the SGL format is 0x01. We =

>> believe that this R2T, because it is unexpected by the nvme-tcp =

>> module, causes the module to crash.
> =

> I'm assuming because the R2T has data length of 0? because set_features
> does not pass any data (feature offset/value is in the sqe)...
> =

>> One of our engineers that is more familiar with kernel modules is =

>> currently trying to understand how the R2T would cause nvme-tcp to crash.
>>
>> I will let you know if/when I get more info.
> =

> Cool, thanks.

Does this make the crash go away at least?
--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 69f59d2c5799..5274cc5800f9 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -568,6 +568,13 @@ static int nvme_tcp_setup_h2c_data_pdu(struct =

nvme_tcp_request *req,
         req->pdu_len =3D le32_to_cpu(pdu->r2t_length);
         req->pdu_sent =3D 0;

+       if (unlikely(!req->pdu_len)) {
+               dev_err(queue->ctrl->ctrl.device,
+                       "req %d r2t len is %u, probably a bug...\n",
+                       rq->tag, req->pdu_len);
+               return -EPROTO;
+       }
+
         if (unlikely(req->data_sent + req->pdu_len > req->data_len)) {
                 dev_err(queue->ctrl->ctrl.device,
                         "req %d r2t len %u exceeded data len %u (%zu =

sent)\n",
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index ac2d9ed23cea..d82df6cca801 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
