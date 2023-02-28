Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD754C64EC7
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Feb 2023 16:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D/FPL9KWoan+aGF0+Fj8Ts+VkGVEiVbizSsqsZXIaWA=; b=Nb/SNUnMOKhy1Oyd3U+cSz3ixc
	8z42eqIMZGBIFQWVUltAXWWlJ0eun/n9A9MadP80sMoMKPHQGHry08Rojb4hx9BePReU9DCBD5l4S
	Rchg8qkvO/rtJqSjUdkEZyqJPD9ylcoWYdLGTSej7ScztH3pagcUYNVuEG8ZsvOpbSuCZQjuuGKMP
	KfpREpXy8T/UwwXU/ldCiUEwHRnTqw0SZFzhiAjBZ7YUfPBNO5hh3qMYcwseqNH4ledCR1u/K3gLo
	ruI6rO8zPA/zdxSRTyvm3q8qwSDZ/N0bk3HLer2pwQQ98pHrz8J0cINXiW6KngOQuMkVu8WrX2s8P
	NTcyAoXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pX2Tf-00DjDt-3L; Tue, 28 Feb 2023 16:05:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pX2Tb-00DjD5-9w
	for linux-nvme@lists.infradead.org; Tue, 28 Feb 2023 16:05:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1677600313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D/FPL9KWoan+aGF0+Fj8Ts+VkGVEiVbizSsqsZXIaWA=;
	b=LHEpBsaQnNKCzP7IgDo1Sh2Ow442lpuc0YRFZpEullpnyWemXb1FUqE7ongHmDh4KqSq00
	7StH55aN9Ty966kSUn8M6JgqtiwZeN4x6Djkaw9weCtH9LJKwHji48t89OE2KIIlNxH4CB
	KiTQELh4855CaUyK4V3mgQUJ0aO3xMY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-pqYcYWV1O6iGT5cUqPJIAw-1; Tue, 28 Feb 2023 11:05:09 -0500
X-MC-Unique: pqYcYWV1O6iGT5cUqPJIAw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 527A22817220;
	Tue, 28 Feb 2023 16:05:08 +0000 (UTC)
Received: from [10.22.8.29] (unknown [10.22.8.29])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 84188492B0F;
	Tue, 28 Feb 2023 16:05:07 +0000 (UTC)
Message-ID: <d72e3ef4-f607-9a63-9f6d-b03084a8edf6@redhat.com>
Date: Tue, 28 Feb 2023 11:05:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF Topic] Non-block IO
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>, lsf-pc@lists.linux-foundation.org
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 io-uring@vger.kernel.org, axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
 ming.lei@redhat.com
References: <CGME20230210180226epcas5p1bd2e1150de067f8af61de2bbf571594d@epcas5p1.samsung.com>
 <20230210180033.321377-1-joshi.k@samsung.com>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20230210180033.321377-1-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230228_080515_465298_2E4B7997 
X-CRM114-Status: GOOD (  12.37  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/10/23 13:00, Kanchan Joshi wrote:
> 1. Command cancellation: while NVMe mandatorily supports the abort
> command, we do not have a way to trigger that from user-space. There
> are ways to go about it (with or without the uring-cancel interface) but
> not without certain tradeoffs. It will be good to discuss the choices in
> person.

As one of the principle authors of TP4097a and the author of the one NVMe controller implementation that supports the NVMe 
Cancel command I would like to attend LSF/MM this year and talk about this.

See my SDC presentation where I describe all of the problems with the NVMe Abort command and demonstrates a Linux host sending 
NVMe Abort and Cancel command to an IO controller:

https://www.youtube.com/watch?v=vRrAD1U0IRw


/John


