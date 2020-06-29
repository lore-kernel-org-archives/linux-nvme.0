Return-Path: <SRS0=U6YU=AK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E2AC433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 11:40:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E984723B2F
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 11:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IjW2YQw0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y7mhmgKw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E984723B2F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FHXTNHSdHBMXgdMiiOw/nHZMMANgylzG1J8f4mAmI88=; b=IjW2YQw0oGkIhA7Xc3RGpADxn
	9IX3FwNvmYg+YQrrKYGoi80gT9Yjf2hDkDsQoyK0QVgbKBFtybdqWbdcaZ+Z2u6VOoGe36AZx1cdv
	9khevMvC0O0Kyhc5OAbRlsNl0KhiEO7Rk3tKC/zgcPUDV1JNq6a3/82M/QWAisGDj1xeckv31ms7A
	RLx7QJgPWHFN5kT3WiKvpH3cFx3iPbD30whPRvIrtQpXBXub1hjO9amJKCiGa8pHEm88j7XF4SXPA
	B3yg4HFN4exkCA2HOh7z88zeym0QnHBTwlumXtBhboSmRewSyvSmHdNhmlzGHPe+9Uv/AymE4cEz/
	ZN/av8ZCw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jps90-0003QG-Fe; Mon, 29 Jun 2020 11:40:14 +0000
Received: from us-smtp-1.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jps8w-0003PO-Nq
 for linux-nvme@lists.infradead.org; Mon, 29 Jun 2020 11:40:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593430809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CkBsRTU3NLnLOCtZABIJSi326dv/G4KE311OeelG590=;
 b=Y7mhmgKwVgLj+y3VS5q9O9jcSFUCSVZan1JltEiPRbo7RkyJi01T5t6GbmWp3oUQTA46F9
 l5OMAKIA2jcT2Df3iJgPmEu0dBLJiXi+1mTMGIH9kNEQENbATI26WTlE7LYxtQ7GVDzQJ7
 31ursplcsxJNFJb/8c59qDKTP0e/o6E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-PxlUawicPrKyo7-miOyCiw-1; Mon, 29 Jun 2020 07:40:07 -0400
X-MC-Unique: PxlUawicPrKyo7-miOyCiw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20A62102;
 Mon, 29 Jun 2020 11:40:06 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-123.pek2.redhat.com
 [10.72.12.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2CB215DC1E;
 Mon, 29 Jun 2020 11:40:03 +0000 (UTC)
Subject: Re: regression: blktests nvme/004 failed on linux-stable 5.7.y
To: Greg KH <gregkh@linuxfoundation.org>
References: <1528690896.32343478.1593229315244.JavaMail.zimbra@redhat.com>
 <1015661434.32401219.1593424943236.JavaMail.zimbra@redhat.com>
 <20200629105939.GA3362395@kroah.com>
From: Yi Zhang <yi.zhang@redhat.com>
Message-ID: <ec706623-76ac-bb87-8591-869b3844f237@redhat.com>
Date: Mon, 29 Jun 2020 19:40:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200629105939.GA3362395@kroah.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
Cc: stable@vger.kernel.org, chaitanya.kulkarni@wdc.com,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 6/29/20 6:59 PM, Greg KH wrote:
> On Mon, Jun 29, 2020 at 06:02:23AM -0400, Yi Zhang wrote:
>> Hello
>>
>> commit[1] introduced regression that will lead blktest nvme/004 failed on v5.7.5, and commits [2] fixed this issue on latest linux tree.
>> But commit[2] cannot be directly applied to stable tree due to dependceny[3], could you help backport the fix and dependency to stable tree, thanks.
>>
>>
>> [1]
>> 64f5e9cdd711 nvmet: fix memory leak when removing namespaces and controllers concurrently
>>
>> [2]
>> 819f7b88b48f nvmet: fail outstanding host posted AEN req
>>
>> [3]
>> 1cdf9f7670a7 nvmet: cleanups the loop in nvmet_async_events_process

Without it, the other patch cannot be applied directly on stable.
yes, we can backport them without bellow patch, I also found they 
already queued up, sorry for the noise.

>> 696ece751366 nvmet: add async event tracing support
> Why is this last commit needed?
>
> The other ones are already queued up in the current queue, thanks.
>
> greg k-h
>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
