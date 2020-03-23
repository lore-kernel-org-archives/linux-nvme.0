Return-Path: <SRS0=QV8n=5I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7385DC4332E
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2020 19:42:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4E0020714
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2020 19:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FWKBOb2J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4E0020714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=yNGHUfhthfm6w/U8UvcNVk1xaB0qq1UJb2nmZJsJzFQ=; b=FWKBOb2J50IaCPvkKj0cJlN7b
	/dE7H47hiYtGXy07LqKO9vrqVrE+B+qXDE1ZJoN0qMeh/6QdBMkQ/RbNZa0duv/I5YMzWUUWZUnNk
	p45kFDgGk8Cb+JfE/z235uzEezJi4e5ZpGMrX9t/SOQ/fo1wUBX2ytl/YFFGkZ1XH22QMX//KSEOW
	wB1vJ+YTmQYjs/1EsdNHPMk86NXWQvr6fBFqFmKF3mDGM89VrbLSHMDBYtj14tOQT0USqVXAZUGpo
	EoeNES+Rq6uNog5K9F4jXfyglJsud3t7jjRmGeXNV3/Sm7q/zM28fZ6900ei1Uaqq8YpARS1stlH0
	V4TZeztDQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jGSxN-0004xp-3p; Mon, 23 Mar 2020 19:41:53 +0000
Received: from mail-wm1-f68.google.com ([209.85.128.68])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jGSx1-0004fy-CV
 for linux-nvme@lists.infradead.org; Mon, 23 Mar 2020 19:41:32 +0000
Received: by mail-wm1-f68.google.com with SMTP id c81so728465wmd.4
 for <linux-nvme@lists.infradead.org>; Mon, 23 Mar 2020 12:41:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8nhnqBGw171rjDqEfgxVxpVguf2doIph7BKjij/CRKc=;
 b=J6k7mb5IpleSgUhyO6oaFd11ICJEjxyUgYr9f6HcfSm048p3UCTNlDo1XIZMvGn4nL
 HumG2S+UMhauWno111oixQggDpQbo0OfNIF6oDs9Ap4hwpmofSHwEr29z8IAF0CIn0Am
 DOj1LuEJ4oUfofu37tiybez2KnS7EUhY1ZmRpZCoSleoFPFGGZ7Id8Sl1FHj94dJyq3Q
 kdrXOl/N8NYV4FvTq6aDnXNRc85oHQ0OJHsUWQ5gf29vM1GK0310wjxbJtOceuMnkATB
 +IKGCEDLpvk/8cVqazVzJ/utYvQLSEomeLkXNccogxCLqRFmqhxnEXPzYtB3u35xZ8Ls
 b+ew==
X-Gm-Message-State: ANhLgQ2Y7W+DGPECcjEOTGlhbr6nYQCnaPKy7MT9lNlTXHpggNSk86P8
 5pPfPz9uoxLg32eNMe8fOUzB1Rhh
X-Google-Smtp-Source: ADFU+vvsWZK7tVjGDbjegmRB6XGNf4GATPs3LMHMS+4qxNcLHgDpbgPMPXMvCfEr5Dgj9TZ9jhPdSQ==
X-Received: by 2002:a1c:8097:: with SMTP id b145mr1065719wmd.159.1584992489465; 
 Mon, 23 Mar 2020 12:41:29 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4c50:a06:3358:69f8?
 ([2601:647:4802:9070:4c50:a06:3358:69f8])
 by smtp.gmail.com with ESMTPSA id q4sm1420481wmj.1.2020.03.23.12.41.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 23 Mar 2020 12:41:28 -0700 (PDT)
Subject: Re: nvmet: Kernel oops when doing mkfs on nvme-tcp device
To: tasleson@redhat.com, linux-nvme@lists.infradead.org
References: <17c25d8d-0dc2-9dc8-2b65-954034c23646@redhat.com>
 <507887d2-96dd-b0ee-bb05-519039d98359@grimberg.me>
 <e16baf6a-c9e0-2249-6d7a-4e8d58f8e9b6@redhat.com>
 <f390f5a1-a80f-44d7-5d69-642119eef9b8@grimberg.me>
 <c8fce5f3-a01b-da38-820f-cf6caaa377ab@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d5e056ca-05b5-c91b-6ed7-668d28b1fe62@grimberg.me>
Date: Mon, 23 Mar 2020 12:41:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <c8fce5f3-a01b-da38-820f-cf6caaa377ab@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200323_124131_421738_8499886F 
X-CRM114-Status: GOOD (  14.45  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>>> Can you share which line *(nvme_tcp_io_work+0x303) map to?
>>>
>>> I'm not running a debug kernel so I don't think I have that available?
>>> Please advise if otherwise.
>>
>> Maybe you will still have frame pointers though?
>>
>> If you run:
>> gdb <path_to_mod>
>> ...
>>> l *(nvme_tcp_io_work+0x303)
>>
>> Do you get anything useful?
> 
> Nope, sorry.

Maybe install also kernel-debuginfo?

I tried looking at the sources myself, addr2line got me to:
--
gdb nvme-tcp.ko.debug
GNU gdb (Ubuntu 8.2.91.20190405-0ubuntu3) 8.2.91.20190405-git
Copyright (C) 2019 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later 
<http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Type "show copying" and "show warranty" for details.
This GDB was configured as "x86_64-linux-gnu".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
     <http://www.gnu.org/software/gdb/documentation/>.

For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from nvme-tcp.ko.debug...
(gdb) l *(nvme_tcp_io_work+0x303)
0x1c33 is in nvme_tcp_io_work (drivers/nvme/host/tcp.c:181).
--

Which is:
--
static inline struct page *nvme_tcp_req_cur_page(struct nvme_tcp_request 
*req)
{
         return req->iter.bvec->bv_page; // <== this
}
--

This means that we are trying to send data from a bio that doesn't
reference any data. So something here is strange.

Anyways, is it possible to add some information the the source?
--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 11e10fe1760f..95c9e40037b4 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -888,6 +888,8 @@ static int nvme_tcp_try_send_data(struct 
nvme_tcp_request *req)
                 else
                         flags |= MSG_MORE;

+               pr_info("sending req %d len %lu page %p\n", 
blk_mq_rq_from_pdu(req)->tag, len, page);
+
                 /* can't zcopy slab pages */
                 if (unlikely(PageSlab(page))) {
                         ret = sock_no_sendpage(queue->sock, page, 
offset, len,
--

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
