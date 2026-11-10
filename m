Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728A0606A31C
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2026 02:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rU+ViNnj;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=HEsNblkN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Y9b6bYtPntDct4khzaV4QTnLbRnllrZnSA0DDg+8PAs=; b=rU+ViNnjSt2YyJ
	6yU9iWVQSCoN5/KeUZEh0kFpH9cSZl7w+GxntA4M8lXJLva6MUOM+EWzajQpPClANreZCU9tvFAEK
	P9DGLzOIypKBy7QdgAquEOyTTOuNvz/rCjQDQW/QI7ZzfUSpWFODHdoacZsgUCpzUawAhIEztw9py
	twXhslfFvyAJd1qrwG8aVBNUR7YptAmhpKXy9DObG2o9TuU7hvLidGyzPZgsCF4OhnkZKwDhGKFV/
	kgJLtjYGtWhuucCtwsXdZcgNKPNcDWw56CljQncwcyGfzpZtAQ8PTYw5lZglZfZOyvfTHlyvcG8DU
	R7wHuTZ89ibKIoaSfpgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQbgw-00000002AqK-1fCn;
	Tue, 10 Nov 2026 02:34:34 +0000
Received: from out30-111.freemail.mail.aliyun.com ([115.124.30.111])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQbgs-00000002Aph-33PF
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 02:34:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794278067; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Y9b6bYtPntDct4khzaV4QTnLbRnllrZnSA0DDg+8PAs=;
	b=HEsNblkN3r9yQXapCtdK9IR26FiM3rDeU/8VIXakvkY6AA31zZQqL231OQds6jqEC5d7rhgZxD+TCDbe2IRg3nWaGzh6N/aunuTyRN5peP2FqfxZL/dxWxYh7JaTT6QwwgMoS/sFk081cMzICatBR6WAhvTt5m1jXA0nldQkG0I=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XETW-iP_1794278065;
Received: from 30.178.84.209(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XETW-iP_1794278065 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 10 Nov 2026 10:34:26 +0800
Message-ID: <42c90183-aea9-4f50-8d47-af68622a4189@linux.alibaba.com>
Date: Tue, 10 Nov 2026 10:34:24 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] nvme-auth: fix data race on ctrl->transaction
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Nilay Shroff <nilay@linux.ibm.com>,
 Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org
References: <20261109022646.290792-1-kanie@linux.alibaba.com>
 <20261109022646.290792-4-kanie@linux.alibaba.com>
 <avH-kbnayBj-gyR1@kbusch-mbp>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <avH-kbnayBj-gyR1@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_183431_441593_9C8350A1 
X-CRM114-Status: GOOD (  15.18  )
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



在 2026/11/10 01:10, Keith Busch 写道:
> On Mon, Nov 09, 2026 at 10:26:44AM +0800, Guixin Liu wrote:
>> The controller side only echoes the transaction id within a queue, so
>> the race has no functional impact today, but the increment is still
>> unsynchronized and KCSAN reports it. 
> So it's not a bug with any user observable behavior; it's just
> unexpected. It sounds like the "transaction" value doesn't need to be
> unique across queues. If it doesn't need to be unique at the "ctrl"
> scope, then I'm not seeing any benefit to imposing that rule on the
> driver.
>
>> -	chap->transaction = ctrl->transaction++;
>> +	chap->transaction = (u16)atomic_inc_return(&ctrl->transaction);
> Can we just change this to:
>
> 	chap->transaction++;
>
> ? And delete the value reset in nvme_auth_reset_dhchap? You can also
> delete the "transaction" field from the nvme_ctrl struct.
This make sense, changed in v3.

Best Regards,
Guixin Liu


