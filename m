Return-Path: <SRS0=xhFb=KI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B923C433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 16:00:04 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04B1E61439
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 16:00:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04B1E61439
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7E3i4ZojTnLn3gKEgOBB+NBSpK6BsCHooZOVzsuFSMk=; b=bfRRYgtorjUU5pwADtqBkEAdA
	S1/2ssagx2Fzl0Ho3Xwicl8vFhFuOaqW6UCH44sg6fWLlVOlRzDOElle4glJX03nN5cvmn7bSVnXK
	M6LHZzn3lod5OxwhcrGrrEAToIuIgXJsArEmQ0wObN76bi9To8JqTPavAxNwlOav3QJlkW8XMTk4b
	lgvW+ABdzyCU/CT7xLUtGXWY7OVmd6c8x/XNBKjvCZnsGr32eEizf70fkvSNq/UL5501QygcP08Kd
	YmGW78TABGkI1SzdPG2vKPq2f2PrFM3VCZqmpexplnpO5M61I4q6Lvrc5k83/pXUxciN+eSxPGR+A
	6e0XPNyOg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lhDkF-005voS-Eg; Thu, 13 May 2021 15:59:27 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhDkC-005vnB-1c
 for linux-nvme@desiato.infradead.org; Thu, 13 May 2021 15:59:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=sC9rS2dsZghLNP4cQrgEl3m85yFLwm9XaohEby3pw50=; b=igqiRqW5uieQcpnueiGqZcHvkh
 /ODeF8zja3cZmWbrIoUtcRmD8ZW7b3vTiopBFOxtuEz7D1dSj9kEzzwxAqo7ICinR0PyKzyUnlRV8
 YdA5qdtaBhGpizOfc/dwwqkhHVEXnAtW+Rrc/fbLEr9g381o/A73xMF/FA8x6dlXRzup0BzbfU4ey
 off7T5MprN9XEF5kpqbEFN8pOlPlT3lir+NYeah2JTAv2JeDpwC4I3babSKwUTRIfZHviYhZvRIrK
 QdLdknfLkjLYWX6QhImw66aBxyE46BYOVINwXfdyobLinwWNqBreD/GArBraMIbc1CbKVKutB34ud
 zNrcRCZQ==;
Received: from mail-pl1-f171.google.com ([209.85.214.171])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhDk5-00BN5Y-LJ
 for linux-nvme@lists.infradead.org; Thu, 13 May 2021 15:59:22 +0000
Received: by mail-pl1-f171.google.com with SMTP id 69so10006802plc.5
 for <linux-nvme@lists.infradead.org>; Thu, 13 May 2021 08:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sC9rS2dsZghLNP4cQrgEl3m85yFLwm9XaohEby3pw50=;
 b=j3R2+pAVnEEPj70a9PfgrRksK4CESN2U5AjyerNdT/BuyjGjjBsiSLJgk23VG8PJyd
 7vUT0Ga7TS9rTXEjNHAelHXnv3ClM7rJgJbK+728cs3NSL0mM1+mpLwWGZR4HGh9lhCA
 09sKwdOsPk9TNKf3LnO3guFumsrmFAb9y9x4Pfk+rQlg6JgFGpt+NhGeSghH69/ElUY9
 UG8SpB2ShbAmMs6xfu1XFf79SgIohveYHFqz+XruVu0zQFGOHtEQeqig3aDAGoQoAmNm
 3S5YyGbQ4zBBYetqteN9lOP5lZeElJRfZyPzBNvCX1VhFHrC+WX75nQ/LNX5QpZGbHWI
 liXA==
X-Gm-Message-State: AOAM531yCIEYANZpftr7d2PunPyHzCPqw1ZJCFcGOueULeQE7M4s0VJQ
 ZRlw5a2YGqtNY2KlKKKwkhU=
X-Google-Smtp-Source: ABdhPJyKQvVPuce3z1l4PmtlSaJD2TKIxNY5wls14OzgkkacwtnJxux5VVxX2A9kPeGYMqj6U7DU/w==
X-Received: by 2002:a17:902:7d8b:b029:ef:8306:6ae7 with SMTP id
 a11-20020a1709027d8bb02900ef83066ae7mr9036878plm.26.1620921553393; 
 Thu, 13 May 2021 08:59:13 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:6dd7:5386:8c63:ccae?
 ([2601:647:4000:d7:6dd7:5386:8c63:ccae])
 by smtp.gmail.com with ESMTPSA id t4sm2410467pfq.165.2021.05.13.08.59.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 May 2021 08:59:12 -0700 (PDT)
Subject: Re: regression: data corruption with ext4 on LUKS on nvme with
 torvalds master
To: Theodore Ts'o <tytso@mit.edu>, Changheun Lee <nanich.lee@samsung.com>
Cc: alex_y_xu@yahoo.ca, axboe@kernel.dk, bgoncalv@redhat.com,
 dm-crypt@saout.de, hch@lst.de, jaegeuk@kernel.org,
 linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 ming.lei@redhat.com, yi.zhang@redhat.com
References: <CGME20210513100034epcas1p4b23892cd77bde73c777eea6dc51c16a4@epcas1p4.samsung.com>
 <20210513094222.17635-1-nanich.lee@samsung.com> <YJ00g8oBZkduQXIe@mit.edu>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <a01ab479-69e8-9395-7d24-9de1eec28aff@acm.org>
Date: Thu, 13 May 2021 08:59:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YJ00g8oBZkduQXIe@mit.edu>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210513_085917_736384_E8F1D7C8 
X-CRM114-Status: GOOD (  25.15  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 5/13/21 7:15 AM, Theodore Ts'o wrote:
> On Thu, May 13, 2021 at 06:42:22PM +0900, Changheun Lee wrote:
>>
>> Problem might be casued by exhausting of memory. And memory exhausting
>> would be caused by setting of small bio_max_size. Actually it was not
>> reproduced in my VM environment at first. But, I reproduced same problem
>> when bio_max_size is set with 8KB forced. Too many bio allocation would
>> be occurred by setting of 8KB bio_max_size.
> 
> Hmm... I'm not sure how to align your diagnosis with the symptoms in
> the bug report.  If we were limited by memory, that should slow down
> the I/O, but we should still be making forward progress, no?  And a
> forced reboot should not result in data corruption, unless maybe there
> was a missing check for a failed memory allocation, causing data to be
> written to the wrong location, a missing error check leading to the
> block or file system layer not noticing that a write had failed
> (although again, memory exhaustion should not lead to failed writes;
> it might slow us down, sure, but if writes are being failed, something
> is Badly Going Wrong --- things like writes to the swap device or
> writes by the page cleaner must succeed, or else Things Would Go Bad
> In A Hurry).

After the LUKS data corruption issue was reported I decided to take a
look at the dm-crypt code. In that code I found the following:

static void clone_init(struct dm_crypt_io *io, struct bio *clone)
{
	struct crypt_config *cc = io->cc;

	clone->bi_private = io;
	clone->bi_end_io  = crypt_endio;
	bio_set_dev(clone, cc->dev->bdev);
	clone->bi_opf	  = io->base_bio->bi_opf;
}
[ ... ]
static struct bio *crypt_alloc_buffer(struct dm_crypt_io *io, unsigned size)
{
	[ ... ]
	clone = bio_alloc_bioset(GFP_NOIO, nr_iovecs, &cc->bs);
	[ ... ]
	clone_init(io, clone);
	[ ... ]
	for (i = 0; i < nr_iovecs; i++) {
		[ ... ]
		bio_add_page(clone, page, len, 0);

		remaining_size -= len;
	}
	[ ... ]
}

My interpretation is that crypt_alloc_buffer() allocates a bio,
associates it with the underlying device and clones a bio. The input bio
may have a size up to UINT_MAX while the new limit for the size of the
cloned bio is max_sectors * 512. That causes bio_add_page() to fail if
the input bio is larger than max_sectors * 512, hence the data
corruption. Please note that this is a guess only and that I'm not
familiar with the dm-crypt code.

Bart.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
