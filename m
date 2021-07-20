Return-Path: <SRS0=Lfpf=MM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC46C07E95
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jul 2021 20:28:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BEE4600EF
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jul 2021 20:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BEE4600EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vlnb.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=8EL2dhA6SiN+DGcGdUIrLrH4NvghKuNxr8AA2YPEXSo=; b=xS04SHX9AgIFk68YtKzjDAxhZZ
	Rm55shhascKywCgoDHrEOgBSnzOG9CexrqhCUK+jbhhFxNjOgBRHNDjxwMEX9NOFhkLErHcWQ4zSG
	51ZOoM4TCbAhNMByHKhgdjnGq4xda9yWGKbkDCP/n9IOdakkY16WX0hmo15slpo/2iAdMvMO/RMdy
	dZoIuxCltJgruxinwtqb4OP+elqJKOFr2HS+9koB8qHefA514DYbqOF9sCAW/69tOPUaOgfouMzDb
	nhEzG7Isa04Yljr8uLIU1GZ1rIYwcEyTnBaQbKNrTHWhFZ9ztmsSaOcb8het33GwT0HfZ0zLQehLM
	+zWRQirA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m5wLm-00DrYC-46; Tue, 20 Jul 2021 20:28:22 +0000
Received: from mout.kundenserver.de ([212.227.126.134])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m5wLh-00DrXg-M2
 for linux-nvme@lists.infradead.org; Tue, 20 Jul 2021 20:28:19 +0000
Received: from [192.168.0.113] ([178.252.67.224]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.163]) with ESMTPSA (Nemesis) id
 1MderZ-1lWbRq3WwD-00ZgwV; Tue, 20 Jul 2021 22:27:15 +0200
Subject: Re: [PATCH 05/11] nvme: add definitions for NVMe In-Band
 authentication
To: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org
References: <20210716110428.9727-1-hare@suse.de>
 <20210716110428.9727-6-hare@suse.de>
 <affd7d4a-6eb5-20b4-fcb3-7e8a0767d7a2@grimberg.me>
 <2eebe51b-7ca0-c2cf-0949-18fb88a0395b@suse.de>
From: Vladislav Bolkhovitin <vst@vlnb.net>
Message-ID: <2bc945e4-c1a7-f537-aa74-a4fdc81f9d12@vlnb.net>
Date: Tue, 20 Jul 2021 23:26:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <2eebe51b-7ca0-c2cf-0949-18fb88a0395b@suse.de>
Content-Language: en-US
X-Provags-ID: V03:K1:iWPJ2DwRbNoWBzOqSvRw156UUCsO5gFEUpS7ar/9SVweYVuST7p
 Am2uZD6MyxopWUHQNral4DOMBbCSZSvKuub6fifMSq7F43g44IvOTv2HMYCuAt612PZ890T
 1S8ydKiuB2J2KVfhDRfmRTKRZmxr3SMCANYcUnOQuALB++dh6dqxbgDUH4D/eMaKc77uxac
 1CqEnTbsvTMsH0MnGKPnw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:O2VJ8bYgfpw=:UHN7I/4vSf4bZQjLCP3E3H
 6qDLCbTVCXUbxueU9MyrBcATZJNJ9OYAsd8qp+Ui4tG2wWlY0/vc38M3jSYAjI7Mk0OPd0s8G
 qPCaPTKzzzU45QFGSH8HWrWQPJOk+Q5AlaeMFw2hnCrz8Rpa4164yYWnXK7h02cId7oK31H/N
 cy++ac+4506ssAYzmyo4M6Pzztpb6rA8vPrVb9N+SF9oLEqBm/nhKs6On5lo+DFFiOmxufJxv
 Fscof6WBPu//MlHuTUTgJqB9SXOfUHPG4sGWIjcdNdyU+1YITD04dXj71q6HgYUZLelMlrwdR
 OCZciTJSFVdQG6K/4/nYbseTM/gX9kZBKewSxRvO5jwO9fxefJ9GeNWO1zVqJ7Bx9bPr9VbIl
 1EgCrkNu9UZMMjUbmV9DeJ1uT20v2pEdDRHEBXAxt0OBCbfh3Yr+NCT3OcfKi2tsOxRpCfujK
 bKiryFWXH9hCv3wVk8sHZZlIgmh2KQBayDjLy5Ns9H4QEANjr/9qziaDY/zSfFhN6KJMVMiew
 bJzf6fJaQf+Mzrzo7Q+vjcEffyOXflpPuYUyZToxX4L8XuNDaS0T6E/bbdWDdc5r3MI5w+raM
 WY5UQEb561M8WazvW2gz9Bg1o645RUgJd+JpmMXOU1ArHTxUAtL8Jea0shHQuGGEF3ji83r/O
 P9BTY1ACrpaKISgYKk865c7ZCo0Pjz0u7ENd9C49YhBqeNYhML7QI/w3a1pRyiWkLZ55e97Xt
 k2Ewf3cBkRGP7mgdRIJDJMEuwKeifd7F9ymOzAuoznXIegjqo23hf61OmybLJ35RdARJyFP2w
 9mt+0dTUbbeg90psEgnLcSdlPFT4CpP/dhnGqEU2iqZ4ddf7g2P5xMQm+JCXiXDIhaWWOUE
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210720_132818_058393_0F5183AC 
X-CRM114-Status: GOOD (  10.58  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ck9uIDcvMTcvMjEgNTowNCBQTSwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOgo+IE9uIDcvMTcvMjEg
ODozMCBBTSwgU2FnaSBHcmltYmVyZyB3cm90ZToKClsuLi5dCgo+Pj4gKwo+Pj4gK2VudW0gewo+
Pj4gK8KgwqDCoCBOVk1FX0FVVEhfREhDSEFQX0hBU0hfU0hBMjU2wqDCoMKgID0gMHgwMSwKPj4K
Pj4gTWF5YmUgcy9IQVNIL0hGLyAoc3RhbmRzIGZvciBoYXNoIGZ1bmN0aW9uLCB3aGljaCBpcwo+
PiBhIGJldHRlciBkZXNjcmlwdGlvbikuCj4gCj4gT3IgSE1BQywgYXMgdGhpcyBpcyB3aGF0IGl0
J3MgdXNlZCBmb3IuLi4KCkkgd291bGQgYmV0dGVyIGRvIGp1c3QgTlZNRV9BVVRIX0RIQ0hBUF9T
SEEyNTYuICJIQVNIIiBpcyByZWR1bmRhbnQKaGVyZS4gQmV0dGVyIHRvIGtlZXAgaXQgc2hvcnRl
ci4KClZsYWQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
