Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B332C25B7C
	for <linux-nvme@archiver.kernel.org>; Thu, 23 May 2024 13:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mjRKHkCHJaZREpZFTXzAPPKwBxIeivQ6IBLkno7Bz2Y=; b=Hvmg3MfR5qw0lCaJLc9OwOkJFL
	ryZO1KsffViNYyBNdSTtUuP/H//K80dqOJF+fn0r24TTCCwH9845spVZdBXE5VHxYMovRbfvqLF3g
	qKleCdvGg32H7UJZ0Y6zjGJq4+SlIh7AiVsKkvfZCR0g+kdeMMvLjbxZy91K5ZHI7obZJY2s7iSMr
	65zIbXrYAGd+QPIcJgwnpSDSto5hHy9ogbihPgmYy2URng/a3ypJfHls+EO2TEf9dR2SvzUkxcqmG
	TTGKDiy2AoG4xliGD+ZxGhUYA64krWfpXvW47XAmwJcowJBpAgpw93noxsiMW8/3ANuMAYe5RjLM2
	2E21MxiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA8ZG-00000006NNJ-1cjR;
	Thu, 23 May 2024 13:33:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA8ZD-00000006NMa-3NBu
	for linux-nvme@lists.infradead.org;
	Thu, 23 May 2024 13:33:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716471189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mjRKHkCHJaZREpZFTXzAPPKwBxIeivQ6IBLkno7Bz2Y=;
	b=doU+mAmEodn3QYLrfZkONj4A4uC0aCWCkE9PhYL7X2AbcULEOWWGkBQKtGJWsaICpXQdff
	bOK4Bd3/ECNXyVJrwIFuWEzEhJ1HpQraaZz3pTmBE3MN2q/OiVi1/3CFUjVrYyfnUSRVO3
	bHS09t2+2ayej+Xd9PThEmUqYs4KH3E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-IV9B1EUWOG2LUuftIbx_Pw-1; Thu, 23 May 2024 09:33:07 -0400
X-MC-Unique: IV9B1EUWOG2LUuftIbx_Pw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AE6A3812296;
	Thu, 23 May 2024 13:33:06 +0000 (UTC)
Received: from [10.18.25.182] (unknown [10.18.25.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 43FC27412;
	Thu, 23 May 2024 13:33:06 +0000 (UTC)
Message-ID: <17692dc1-0817-4216-8e9b-3c9207802ae3@redhat.com>
Date: Thu, 23 May 2024 09:33:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] nvme: multipath: Implemented new iopolicy
 "queue-depth"
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, sagi@grimberg.me, emilne@redhat.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jrani@purestorage.com, randyj@purestorage.com, hare@kernel.org
References: <20240522165406.702362-1-jmeneghi@redhat.com>
 <Zk4sEpypKqeU67dg@kbusch-mbp.dhcp.thefacebook.com>
 <20240523064525.GA28524@lst.de>
 <fe13bd05-76c5-4bf8-bfda-f9ecf08b2272@redhat.com>
 <20240523131617.GA23604@lst.de>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20240523131617.GA23604@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240523_063312_018443_087D2038 
X-CRM114-Status: GOOD (  10.33  )
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


On 5/23/24 09:16, Christoph Hellwig wrote:
> On Thu, May 23, 2024 at 09:12:21AM -0400, John Meneghini wrote:
>> On 5/23/24 02:45, Christoph Hellwig wrote:> On Wed, May 22, 2024 at 11:32:02AM -0600, Keith Busch wrote:
>>>> Christoph, Sagi, 6.10 merge window is still open and this has been
>>>> iterating long before that. Any objection?
>>>
>>> No, it's not.  The window for development closes with the release for
>>> 6.9.  New features must be in before that.
>>
>> So what's the next window for new features?  6.11?
> 
> What else?

Then merge it there.  Duh.


