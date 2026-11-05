Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFA8606A326
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2026 20:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1k57KN7C;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=NXSIt5gv;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Z1/HKxve
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=sbl/mbe43FSMbPIb8odzkFI9VF6+z76hm9rsoOYKitY=; b=1k57KN7Cjo9XDG
	oZxYrdRAUJnBeVbV016qBEliRCeNmWQyNbn/DBkfL7+ZL30SpOuzgTeoNi7+RZZhwYiOQ0Lfr+iuG
	5pm205zDIF7HkygA6PEdg/Hdk103UazGCO6DNUQg5AgsO1hximXigBEDB6MvXAJD63aSdu8/AhKYF
	kxadv7nDGDiB1RNQdbHGoVOh3FtyGFl1sLOeY8vGWBdEuvNUZKq8pqLgyJ5XBH1F/R/8sR5Tqc+H2
	9kiTkZU279L8Sbi79F3RdVaVijSufvjqDy0PwZ0n5AXy7uAyHotzD55rSrQGXhSqg6NSKyPWpMQM+
	9Be4BKI8KkFYekNPF3ZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP4T4-0000000Adof-3gLb;
	Thu, 05 Nov 2026 20:53:54 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP4T1-0000000Admc-3Db5
	for linux-nvme@bombadil.infradead.org;
	Thu, 05 Nov 2026 20:53:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=sbl/mbe43FSMbPIb8odzkFI9VF6+z76hm9rsoOYKitY=; b=NXSIt5gvwoWvtVluAn6Ihv1ZQB
	Id08coWu9IY8T3SAUtgsAQ6QyTjKk4DyWhC9KqcmgHQvPGD1kjq3XAUa0xY1a89LVlGZiFGx9EHiK
	eCfVEF2WpmtmgPHHXpyzdoF3ErdeFNc0vCOBUYlNZPTKIIhwlgamvyX7P4iXYLse0i16Zou8hjNw0
	wtpAqf7tu+rtxL9xBRzOnMm+S7rAzJdKPeHobbn6x3UwJWgQHWiTS9/6MzgAds3R/Fl+mXymRwtwY
	dYQWGEf52sTJlZNp/NeoOSQ2nHMC5nNUvJwAQHbphJFWOeoKudSp1GUeh8r+BVEozHTRPpc60ZPB3
	eS6HRTMw==;
Received: from mail-dy1-x132e.google.com ([2607:f8b0:4864:20::132e])
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP4Sx-00000003YNe-2Gvg
	for linux-nvme@lists.infradead.org;
	Thu, 05 Nov 2026 20:53:50 +0000
Received: by mail-dy1-x132e.google.com with SMTP id 5a478bee46e88-36a1947498bso16189eec.1
        for <linux-nvme@lists.infradead.org>; Thu, 05 Nov 2026 12:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793912024; x=1794516824; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sbl/mbe43FSMbPIb8odzkFI9VF6+z76hm9rsoOYKitY=;
        b=Z1/HKxveh+eZSzMI9PrLhIfGuMtyoSvvtroMJltea9x8+sKwR0S/EVyzxazr1YrOm1
         JQiIe5qrAcFupM5Q9xzMaKaeWGmnQWaZy8YTxXb4RnP9H8gv5mGNMxr3pvTbWDr8iu1B
         4R29/NZMrca8ddUYeK0JdQCoBKMlZXt1BWn1qEx0wVnQ+HhipzXS4AxCId4LVks9kxij
         mpKNb3JE/BaMb14VIjRn6FovWdyRu9uw3pNbKPm86neHf9JGOElybHXW3Wlw/Mi0L8Cd
         vjDSXu4tK5rWjeXXHQZC9g5vj24T3CSt7fBdswyYxyXLI/axfP25Cef6+sfHGWjbMqSO
         RFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793912024; x=1794516824;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sbl/mbe43FSMbPIb8odzkFI9VF6+z76hm9rsoOYKitY=;
        b=FUfBTgb3Z1hk3YkQ/m39arzEp78IUjbYWeLb6EdetjajoC5XnN0UUkL9y+fCRTyork
         5kG/KuKF5Td5ad36GIu8E6AbIwNK5Akahg6eY0odXPA+opD8PXL5e/ISYSiJPz/ubdLs
         seKvGxIYxrvQjZ4w++Lc+wRx8gECAtQ7O56j9kBwZQD2r/5ajf/wqnAAJEhPJWpnP+jk
         tEvqpiQKu4MIZoEE2U1aLs7p/jn4r3Uzb/mL93VCjBpDB9Bv8f+B7N+gIkcjQyW8KXtu
         HCD4y/T/8bumex7C5Kwxqc4wKvfPPs9drrDguAnHQXltuCtnnXJKWbILVKVgyQF65vPb
         rEhw==
X-Forwarded-Encrypted: i=1; AKwUvByJxCbCCa09wsG7qJKyzvpjrrgKFpF0ZgCzQxR7k6oPdbmIrzVnjLl8PuEdI4dQB4PNYxIaTRybxDGE@lists.infradead.org
X-Gm-Message-State: APuU4Z8fQ0IfnzEVO3xY3CL4cMxKKILDORP1JDNBy1Me7/gJCx8lXDuJ
	lFqw1D2Pbqo8kq8B58IRpvpI65TQiA3C5JWNrr07jyC0XroohK5kl1PqtuPt+Ooe7osasHE8Yrn
	4whszrIk=
X-Gm-Gg: AYBFou0BSAwJ/S9Syscj+4FMUUBYCRVJLan4WC0rcl9aYIGIecg9l92+nB41H1uoNd/
	9RdDpXPB4uhbTvzHP2LB7Zy9GQzTWsREE33ny4OwaeDxRHJ6sL7THfuoXKJhuBlK4Euk/5Y6wu1
	kmhoq7uiwl0m4/zU7vGA9mu0C4z6NqdIxD65rX6dRcWA6QOkBmrOpAWZyfD/a9ZxA98IMa+vlPw
	Rs9+40WElfelgLZrG2YqeEAUqHrfYHLsoEr1pVpAlUOEyvXaPP3laQBUZTtMwydp7mfKaKPRAno
	gyGgEBPzkc9+aznqdNIyTwJR3PY+dMZKxlDHPkaN352iNDTPKSGYBPhNOjS/C5YQ0DhIM3cxRTd
	fvHLKL50GJazE47TMelb6mgH13T4fqurTPk20jRUYVJp67+t0HfZG0ZJYAI/fYVLKUbY8mI86o1
	jMig2CgsuO5RiNC8rsGqMfCK5VWqOyx3cYwkKCZMhzQ2LgJhBT2eOaL4GayxaokOuE/LbcveKSJ
	q4kzbtTpiuRqfyCFRr9vUTXCROsE32xTnzi0MfTtT12pKdc7XP3RvRzlll14FrTgvPRCh5V/66s
	w5JdYXy089lOHkcktl8bOdpdwckrJytyxwKuLUSoSdkYnIEjkZB7XUXn9bTBMdyY+CUNouWCr9m
	bWQMq8UAlGQc=
X-Received: by 2002:a05:7300:c8c8:b0:366:c497:610c with SMTP id 5a478bee46e88-36f770080f3mr433079eec.33.1793912023912;
        Thu, 05 Nov 2026 12:53:43 -0800 (PST)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36f7369c69fsm714577eec.6.2026.11.05.12.53.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 12:53:43 -0800 (PST)
Message-ID: <84c3612f-a157-49b2-9bbf-62c6850cf061@kernel.dk>
Date: Thu, 5 Nov 2026 13:53:42 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 7.4
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, paulmck@kernel.org
References: <auzqoK4jrx-NSHRv@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <auzqoK4jrx-NSHRv@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_205348_265179_2BDE09A3 
X-CRM114-Status: GOOD (  16.95  )
X-Spam-Score: 0.0 (/)
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
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/5/26 1:44 PM, Keith Busch wrote:
> This pull includes a patch for the srcu subsystem. The patch adds a new
> helper, list_splice_init_srcu(), needed to fix namespace removal racing
> with srcu readers. Paul McKenney reviewed and acked this going through
> our nvme tree:
> 
>   https://lore.kernel.org/linux-nvme/493a0897-c117-4517-a3a4-6d84da9d30ae@paulmck-laptop/
> 
> The following changes since commit c8c53d669d4e45b3a804013251a34387d7e11bfb:
> 
>   blk-crypto: fix NULL deref and UAF in __blk_crypto_evict_key() (2026-10-29 11:10:05 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-7.4-2026-11-05
> 
> for you to fetch changes up to f33c8bc785401669b29229bcf3d0086ba9f5b87c:
> 
>   nvmet: cache passthru reference in __nvmet_req_complete() (2026-11-05 08:53:01 -0800)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 7.4
> 
>  - Fix a passthru reference leak that hangs disabling a target passthru
>    controller (7.4-rc1 regression)
>  - Fix namespace removal race with SRCU readers of the namespace list
>  - Fix use-after-free in nvme-tcp controller teardown after a failed
>    connect
>  - Fix NULL dereference in nvme-rdma when a reconnect adds queues
>  - nvmet-rdma device removal and disconnect fixes
>  - nvmet-tcp TLS record type handling and bounded connection accept work
>  - Don't leak stale memory in the nvmet ANA log page
>  - Harden nvmet against invalid input: keep-alive timeout overflow,
>    incomplete DHCHAP messages, configfs address bounds, arbitration
>    burst mask, and locking for traffic based keep alive updates
>  - Keep the old nvmet auth keys if setting new ones fails
>  - Delete nvme-loop controller on failed reset
>  - Fix extra cdev reference put and unregister on a zero pr_register key
>  - Fix a TLS key reference leak in the nvme keyring
>  - Quirks for ADATA XPG GAMMIX S70 BLADE and KIOXIA XG10d
>  - Speed up nvmet namespace disable
>  - Misc cleanups

Pulled, thanks.

-- 
Jens Axboe


