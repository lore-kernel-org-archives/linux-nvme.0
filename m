Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA7BFC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Mar 2022 05:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qyTj9cXHtlUfFSUGvVAvJWbJTr/7IJg9th2YsxmQzz4=; b=e0kSSh+Te+2Ip6uhl8Jfwk1Wd6
	YG1kBFu52QtdEbgE1qVhYKKmwuGzAWILmkePY+sUgWrtxkZqrEXjNmjDOYMsDM0wtrIRBj7XamqU7
	vHpfKcY5OEIwcBlrBdvz7K98DsPQzCFi1a8ksGmBH4pBTVk8QwBPcxB/TFcuciX53WgDJJMGmzJk1
	ajBRjO4SQppDvKHNQYjDehgqCUxEmAO+SYX7wH7KBMiksFsuMS55lLih7TeD/V1GL7FIOC6KDdjcC
	eNpp2yCCpl2A9maxPmtOEtPjM5Mm4J+xCnEmd/3fBI2n/GyH1fv/lJ31BMROYAUSkgMhamG8H9GK0
	NEJIa9qA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSB49-00BTb2-Kh; Thu, 10 Mar 2022 05:10:21 +0000
Received: from mail-pj1-f48.google.com ([209.85.216.48])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSB46-00BTZW-3a
 for linux-nvme@lists.infradead.org; Thu, 10 Mar 2022 05:10:19 +0000
Received: by mail-pj1-f48.google.com with SMTP id
 15-20020a17090a098f00b001bef0376d5cso4205465pjo.5
 for <linux-nvme@lists.infradead.org>; Wed, 09 Mar 2022 21:10:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=qyTj9cXHtlUfFSUGvVAvJWbJTr/7IJg9th2YsxmQzz4=;
 b=cPxjGsQZShV7j8uDC4nk4MzwpK0EOzjfIy5rHx0eSfDrgM9zh1ECG1rGixatsLkKM5
 w1ik8wExPnTV1OunZo3uqXcu10FHQWpyI5zj7OQcHUOL7as1c6gegkTW9mHdm7UxEfjn
 WPWSaZ7vzLgGaIjQ9JqBnz1A4O5SCBEmAPzsb+fB+uLtUjw1NnDvQQUdBf5ARdIPval3
 M+puYZ4XafawRFqz93CToCzwLvn/Fwpf6qrlhQaxkcVWJlmgiQqyi/Hcm+55xmIAxWx7
 8XmuzjBpew2Vwf07NqJU9Ni35LcIpeeTgBqfgqubajH0y2AS640oj4azmkkPa8QL1SHl
 49Dw==
X-Gm-Message-State: AOAM531PfcaRs/xR7mkJy37Zo3n2UTGhbicXiwYtYKn/qVe9pGmF+X9J
 USkRi3+yXnmOodxwiO7fSyY/jBBhi4o=
X-Google-Smtp-Source: ABdhPJzXAKsNp1FIuVW50wMHnHE5ShDs5AClcVYkR31D2mmFy9Zxc1BAeGGMQkH1gHgc9gZ6UnV3JQ==
X-Received: by 2002:a17:902:e88e:b0:151:ffdf:5692 with SMTP id
 w14-20020a170902e88e00b00151ffdf5692mr3087609plg.17.1646889014299; 
 Wed, 09 Mar 2022 21:10:14 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd?
 ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
 by smtp.gmail.com with ESMTPSA id
 cv15-20020a17090afd0f00b001bedcbca1a9sm8340362pjb.57.2022.03.09.21.10.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Mar 2022 21:10:13 -0800 (PST)
Message-ID: <22878ead-454e-b680-8946-fcae188f7576@acm.org>
Date: Wed, 9 Mar 2022 21:10:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] nvmet: add missing locks around nvmet_ns_revalidate
Content-Language: en-US
To: Niels Dossche <dossche.niels@gmail.com>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <20220309203449.63125-1-dossche.niels@gmail.com>
 <dd679ebd-dba9-219b-20c4-21f0270138da@acm.org>
 <09c807d0-1aaa-b5c0-65cb-05700059e5d0@gmail.com>
 <283f07fe-cfc8-cecc-311f-ca7603e5118e@acm.org>
 <946ca1a5-4dbc-7b49-d234-1136815fe699@gmail.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <946ca1a5-4dbc-7b49-d234-1136815fe699@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220309_211018_185293_E88EFEBC 
X-CRM114-Status: GOOD (  17.41  )
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

On 3/9/22 16:24, Niels Dossche wrote:
> The main focus of the analyzer is not on lockdep assertions actually.
> It works roughly in the following way:
> 1) The analyzer searches for *_lock and *_unlock calls in order to know which fields are locks.
> 2) It searches wrappers for those lock and unlock calls (e.g. task_lock locks task_struct->alloc_lock)
> 3) It determines which field accesses of the same struct type occur guarded by a lock (e.g. A->field guarded by A->lock). This is used to (try to) determine which fields need to be locked by which lock.
> 4) It searches for violations by counting for each field access how many paths are guarded by the lock and how many are not. If the count of unguarded is way smaller than the count of guarded, then it is reported as a possible violation.
> 
> The analysis works interprocedurally. It also uses Multi-Layer Type Analysis of K. Lu et al. in order to improve the global call graph with respect to indirect calls.

That sounds interesting but does that algorithm also cover 
initialization and cleanup code for which it is guaranteed that only a 
single thread accesses the data?

> The lockdep part of the analyzer is not more powerful than the clang assertions. To be honest, I'm not sure that it can be easily integrated into Clang itself. The analyzer currently uses LLVM bitcode files as an input.

This is not a big deal. I was asking about clang integration because it 
is more convenient to run a single tool (compiler) than two tools 
(compiler + static analyzer). As you may know the Linux kernel supports 
the __acquires(), __releases() and __must_hold() annotations that are 
recognized by the sparse static analyzer 
(https://sparse.docs.kernel.org/en/latest/). The clang annotations 
however are more powerful than the sparse annotations. Additionally, it 
seems to me that the popularity of 'sparse' is declining a bit.

Bart.


