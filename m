Return-Path: <SRS0=QV8n=5I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833A7C43331
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2020 23:37:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D6F9206F9
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2020 23:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="con18XiO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="adjsB8T7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D6F9206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date
	:Message-ID:References:To:Subject:From:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0oKaNyO9K9McbyQG6MdDq9xJPfmIxvh/nbUwoeDPU/4=; b=con18XiO3xKG3i
	tFciTxeaC48fJgdh9f18vyz7L79aJJ6Mrxv0fGVMdbKr7I7M8TKGl6k0BTR3CGKlYHDRJyCFRmfWB
	3bbQRhslP1xePLW0cQrx9mNWkvKbEiBU9ud1pVhA7MVYt9XMrtvKKVWZD5TlSMnr80gzq2r1pB2L6
	EjnTqM65HhsfQFdSUZdn+mSX3+tjiTDTr+zrI13hIDbzAN/xxhrvnIslYXrrGKHsjckZbdadNpse/
	IZBVyV89KW1MRY7kD04YSIatRroARSjaCx0LJZcgZ2d4iiJ6YU2JJ9ADVY+ebRsy1sV5wyG9HD2HP
	KKj3I8UL9T02ba6sDZGQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jGWde-0007n6-3h; Mon, 23 Mar 2020 23:37:46 +0000
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jGWdb-0007lz-B2
 for linux-nvme@lists.infradead.org; Mon, 23 Mar 2020 23:37:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585006661;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xRnbTWyFnGiWtf15NBPhJw/g3/P9aGZUAUBxj8l5fuc=;
 b=adjsB8T7W+y+6iKQd5us8LTFGicEBX1ttbqjLr8UM7UWyR0TZ6AheTTAZwIqjp7oRpZyas
 o8xcY6ZWUvX92ak0x4eCuaxwsMZR7X/FrPHgxLrfj/6vCN8cZdHREbaatKJ4I2rak2VXTP
 EeTxcc5E0k72rqMBpqYWp240RJRRwlQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-KRfsjWovMbW8_CTMCllaBg-1; Mon, 23 Mar 2020 19:37:39 -0400
X-MC-Unique: KRfsjWovMbW8_CTMCllaBg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7DCA3477
 for <linux-nvme@lists.infradead.org>; Mon, 23 Mar 2020 23:37:38 +0000 (UTC)
Received: from [10.3.128.7] (unknown [10.3.128.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 04DDB19C4F
 for <linux-nvme@lists.infradead.org>; Mon, 23 Mar 2020 23:37:37 +0000 (UTC)
From: Tony Asleson <tasleson@redhat.com>
Subject: Re: nvmet: Kernel oops when doing mkfs on nvme-tcp device
To: linux-nvme@lists.infradead.org
References: <17c25d8d-0dc2-9dc8-2b65-954034c23646@redhat.com>
 <507887d2-96dd-b0ee-bb05-519039d98359@grimberg.me>
 <e16baf6a-c9e0-2249-6d7a-4e8d58f8e9b6@redhat.com>
 <f390f5a1-a80f-44d7-5d69-642119eef9b8@grimberg.me>
 <c8fce5f3-a01b-da38-820f-cf6caaa377ab@redhat.com>
 <d5e056ca-05b5-c91b-6ed7-668d28b1fe62@grimberg.me>
 <BYAPR04MB496517B2AF9555819C4A684086F00@BYAPR04MB4965.namprd04.prod.outlook.com>
 <1d6fd91f-8442-515f-fe20-5a7a6157ab2e@grimberg.me>
 <ad18c611-33bd-3dd8-989a-0e4b950db20c@grimberg.me>
Organization: Red Hat
Message-ID: <66a7c3e3-66a1-8a97-92ed-31ad00d6eb89@redhat.com>
Date: Mon, 23 Mar 2020 18:37:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <ad18c611-33bd-3dd8-989a-0e4b950db20c@grimberg.me>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200323_163743_457601_56B03E7E 
X-CRM114-Status: UNSURE (   9.77  )
X-CRM114-Notice: Please train this message.
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
Reply-To: tasleson@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 3/23/20 5:02 PM, Sagi Grimberg wrote:
> Tony, does this patch work for you? It makes the issue disappear
> on my end.

I built a generic 5.5 kernel and modules with debug.  I recreated the
issue and using gdb I get:

...
Reading symbols from
/lib/modules/5.5.0/kernel/drivers/nvme/host/nvme-tcp.ko...
(gdb) l nvme_tcp_io_work+0x303
Function "nvme_tcp_io_work+0x303" not defined.
(gdb) l *(nvme_tcp_io_work+0x303)
0x1c03 is in nvme_tcp_io_work (drivers/nvme/host/tcp.c:181).

179  static inline struct page *nvme_tcp_req_cur_page(struct
nvme_tcp_request *req)
 180 {
 181         return req->iter.bvec->bv_page;
 182 }

which matches what Chaitanya found.

After applying your patch I'm no longer hitting this issue!

Thanks everyone!

-Tony


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
