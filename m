Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C27C0C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Mar 2022 01:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aeKnD278gsrWyP8wQB2hD8XvRI7hUSlZIoaZT77WpCI=; b=NoHdkJlXI6nNmjAXvI7gSOGME4
	/7tcc1f1+xpEGFF6ErnosBwKE1oYpwsyJDHdEq2hQhK7LtIAoUWiZGOlDUx5CMAGeXf27J3K2vwCN
	6Z1T+w2YiDDkhedi2hFMfW+57tjjU9wIK2SkKcSpYau5JDxnxgO1JXTNUTrpgMYHRVUOGwc95mybP
	g8+ppDdYpExk5IhF1lbqBfQHBN2ZPXZZSdOey4S35dJj2CAeUUtKTZX58zGxXf7tyCOKETrLbg1Jf
	kXS80dIRBpTCPPsUdhFTt5fnHnEWWsm7rfCGXZ7n011CEeI8X7KrmovDWpn7ipmmh1Z+nzsXK7A3q
	8d/nCAJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nXC72-00FIWQ-Vi; Thu, 24 Mar 2022 01:18:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nXC6z-00FIVi-Rm
 for linux-nvme@lists.infradead.org; Thu, 24 Mar 2022 01:18:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648084680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aeKnD278gsrWyP8wQB2hD8XvRI7hUSlZIoaZT77WpCI=;
 b=Hdjaz4aPadeE38sgu9W2uArmB95KJF9HN+1SNyBV8kIXerPTYL4aYjPwL+R2SqmJcV1Crf
 GF5xLFqC3zzxsAcdxrNLlDE9punY7/tg4vf/vUXPW3I9c90RMaIJ3FLKpqNulXZM22cKq8
 p9t3qZRbL45wBzfyzURuRpy3aedNa1o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-628-vvQJKOV7ORuyhBfwSovUgQ-1; Wed, 23 Mar 2022 21:17:58 -0400
X-MC-Unique: vvQJKOV7ORuyhBfwSovUgQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7CFB4185A79C;
 Thu, 24 Mar 2022 01:17:58 +0000 (UTC)
Received: from [10.22.19.101] (unknown [10.22.19.101])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 54C3340D282D;
 Thu, 24 Mar 2022 01:17:58 +0000 (UTC)
Message-ID: <4e1aaadb-0044-6367-e4a6-e3f159fa007c@redhat.com>
Date: Wed, 23 Mar 2022 21:17:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [LSF/MM/BPF TOPIC] dispersed namespaces revisited
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@infradead.org>
Cc: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <521666e9-9114-9c2d-c680-a52defb45f8a@suse.de>
 <YjtKYETOnoI6/x4E@infradead.org>
 <da128051-4d15-1566-2876-5167a0c1d033@suse.de>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <da128051-4d15-1566-2876-5167a0c1d033@suse.de>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jmeneghi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_181801_997703_98C59791 
X-CRM114-Status: GOOD (  21.67  )
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

I agree with Christoph that the current conception of dispersed namespaces fundamentally breaks the NVMe storage object model.

However, there have been several ideas proffered at FMDS to fix this and I think people are willing to make changes to TP-4034 
to redress this problem.

I think this is a topic that needs to be discussed at LSF/MM or ALPSS.

/John

On 3/23/22 13:16, Hannes Reinecke wrote:
> On 3/23/22 17:27, Christoph Hellwig wrote:
>> Hi Hannes,
>>
>> the answer is pretty simple:  dispersed namespaces are a bad idea and
>> will not be implemented in Linux, and this has been the stance since
>> this was first proposed.
>>
>> If these vendors want Linux support they can already trivially
>> implement virtual subsystems and are highly encouraged to do so.
>> (the concept of domains actually makes it even simpler than in
>> the beginning).
> 
> Guess what, that's what I have been proposing.
> And they have (somewhat) agreed.
> 
> I just wanted to use LSF to get everyone on board, and then be able to come with a proposal to NVMexpress which I know will be 
> acceptable from the Linux community.
> 
> I have a patchset ready implementing virtual subsystems based on the NS UUID (and thereby putting each namespace into a separate 
> subsystem).
> At this time it's just a PoC to demonstrate the concept; specification is not even proposed, and so it's hard to code against.
> 
> I can send a pointer to my kernel.org branch if you like.
> 
> Cheers,
> 
> Hannes


