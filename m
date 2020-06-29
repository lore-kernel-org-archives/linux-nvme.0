Return-Path: <SRS0=U6YU=AK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816DEC433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 10:00:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FE9D23750
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 10:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FBtaEDFA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VM8Qxvoy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FE9D23750
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lMZDvI5rkkh8L/1tSwxxCSSWO9RtLv1wDM8zjSRvF0Y=; b=FBtaEDFAi/K0TgDPk8Db5ASf9
	OZLHdT4G3OoyjI0Qr0EFIcNFAElcHPhXnDr0127D9N4OsON2kiN/liyidfI1lTAeedCG/8L2LPZKv
	Dn0YU1g0BrbgQCNPL3HAlxJUIanqWnGJ2a/b/cxwy5P1dBLpNfp9Zx3bcjxv6hUwNdhNCstH+uTKC
	y85qdqHvq1PkPqYaq0jnoos8ARHub6ILXl19DOi4w18nW8xgcsUXioQIs/xPy17TSdpXPDeICYmD6
	uzc0rSNZIDFMBPR9OE3iqEd26+uH7eZFd14rnAq2+020g0W5y69hc1/v3KZiaGx4j9KLnVGdTlrph
	CUlWMmQAA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jpqaG-0003GT-47; Mon, 29 Jun 2020 10:00:16 +0000
Received: from us-smtp-2.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jpqaD-0003Ft-86
 for linux-nvme@lists.infradead.org; Mon, 29 Jun 2020 10:00:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593424812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mGr8qTtPXpxdp/5ZRpAT+8RS+gHomXGsYG9BIMlD7DQ=;
 b=VM8QxvoyMs4CnFqxVERV+KvwPS4LzI5ZgZqfGDwLRpkaAITZb0US+tuc8Z+uukj3R9m3FF
 VMtKqK6PZXOpCpnGkZG3dvfMk1m/OokcAsO9azj1YwaNBwjzSepdUCbBs1D2pAjEgfomJv
 lI0sTEeuE9hFXZe3BsWc3QdrAy3qMX8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-1VEmKfAjPDWRVoDO8o1MdQ-1; Mon, 29 Jun 2020 06:00:07 -0400
X-MC-Unique: 1VEmKfAjPDWRVoDO8o1MdQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD68F1005512;
 Mon, 29 Jun 2020 10:00:06 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-123.pek2.redhat.com
 [10.72.12.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9321510013DB;
 Mon, 29 Jun 2020 10:00:05 +0000 (UTC)
Subject: Re: blktests nvme/004 failed on linux-stable 5.7.y
To: Christoph Hellwig <hch@infradead.org>
References: <1517012281.32343351.1593228195746.JavaMail.zimbra@redhat.com>
 <1528690896.32343478.1593229315244.JavaMail.zimbra@redhat.com>
 <20200627065215.GB20157@infradead.org>
From: Yi Zhang <yi.zhang@redhat.com>
Message-ID: <eb521be2-6007-dc69-cb73-62106040fe05@redhat.com>
Date: Mon, 29 Jun 2020 18:00:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200627065215.GB20157@infradead.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

There are other dependency patch for it, will cc stable maintainer to 
figure out the backport, thanks Christoph.

On 6/27/20 2:52 PM, Christoph Hellwig wrote:
> On Fri, Jun 26, 2020 at 11:41:55PM -0400, Yi Zhang wrote:
>> Hello
>>
>> commit [1] introduced regression that will lead blktest nvme/004 failed, and commits [2] fixed this issue on latest linux tree.
>> linux-stable 5.7.y has [1] but still not pick up[2], does anyone know how to start the process to include [2] to linux-stable tree, thanks.
>>
>>
>> [1]
>> 64f5e9cdd711 nvmet: fix memory leak when removing namespaces and controllers concurrently
>>
>> [2]
>> 819f7b88b48f nvmet: fail outstanding host posted AEN req
>> 1cdf9f7670a7 nvmet: cleanups the loop in nvmet_async_events_process
> You can always send backpors to the stable maintainer..
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
