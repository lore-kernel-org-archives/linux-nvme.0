Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA172C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Apr 2022 22:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VsZTkYBDAVKt9NvM53yZwr1vvVFb7lg5gLMBYeVrZfI=; b=MgjP/4RzppHi3GZqcwJ6ng3pAA
	pudpemvhHwGdl6NUBOx8fh8zP8G8wc3QluO/PyCLMIhENcfDDql5Og8tPKd0dIDTzG3A+oWzim98J
	d7+U7myYCaAl+75W37yjjFK255TYniLe0Gx3RQbw7aPTZhn96zQRWWvynF013Uf4wOpPgnXFOkXTl
	KPyPoQSTCCJGJQxVjLKS3JAe5WK7VXO1YooVsK3M2eedMYsWvhO3mbJ8vB4GrS5DtBqMVIVuXmTFt
	qA/o/bX8mzhcq+MlN9onnl3Q0AIbqOm7iq/p9tb6L3Zd9Bf8/9jg5iC9+EOHc8oO8/tVEqky4IJUP
	qlyIN2cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njU8m-00GZMg-BM; Tue, 26 Apr 2022 22:58:40 +0000
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njU8j-00GZLW-7x
 for linux-nvme@lists.infradead.org; Tue, 26 Apr 2022 22:58:39 +0000
Received: by mail-pg1-x536.google.com with SMTP id t13so66899pgn.8
 for <linux-nvme@lists.infradead.org>; Tue, 26 Apr 2022 15:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:in-reply-to:references:subject:message-id:date
 :mime-version:content-transfer-encoding;
 bh=VsZTkYBDAVKt9NvM53yZwr1vvVFb7lg5gLMBYeVrZfI=;
 b=PBmJeextCz4u0h5ot8v+I+0BvmisD7c7SNhVQmq43Kgnr/cvLiPTblrftl4cRTTno0
 rxI39CeSVhtUz7jYm7H9Xy3yjg7aDCbKRiWWUolrnPgHARDrlkVu4asvAjBKzESdDGzl
 7+SQvaHl3sZ12IC6a2ZqdphdZoXuzFFyP7OyZBNUvc4DEo1vAPZiBr/QFPiCZE9rPIxr
 oDtUIOuPqhfzCNGPDfOWMEG9iGeTeKjqmSheF/TSx32JtKfZH2CBqP2HPfbxGT013M2T
 jFEexfOwvNFeS1NhUx7QgijzDUQtTFGqpXfk8KkSMGeO/l+EOWGrx/Fmx8e7ESio1kaj
 uP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
 :message-id:date:mime-version:content-transfer-encoding;
 bh=VsZTkYBDAVKt9NvM53yZwr1vvVFb7lg5gLMBYeVrZfI=;
 b=ZRb+eidlbWyZvIguK3HztXKNi1r2n07XnyG2snBCJw2F1cM7fSnYWOA+AzDcEtZHys
 NKa/BIoloTI0ElGMbo/oePUvElCC1zp983m8wIBcQKNi0MYFnjUhYe+P4VMYLcb1ZlCb
 LuM6kGDpn2+cwMjdXkp1ScIcpuZ9/sDe7ZzpYMs3HaNpnlAWpvyExFJ6Kfgume7svxqJ
 e7Nuof1DO3chynkA6mf8IEEP/f1EifXqJPwVr1IjddZ020VUPa/0DrA2DapTPVJOyeBW
 /f8gS5Xf/NK4849Bc04scWBpxs1IUOWdJeoN4jDmh+44mdtzV9vRAJZkKqoKylbvhepS
 6qwg==
X-Gm-Message-State: AOAM531VvOhSH8YsGmRFKrq6LhjYQ/SiXEvgMIr5SDSHhz3X+SodLWk0
 06weVY/Tz5FMEZsHvRyYGy6WVw==
X-Google-Smtp-Source: ABdhPJzQD9b/3DUGAcmR/GBQ2L5JCE7nnad8t/eXE8G7QGXJI91ISwRDB9gErP86URA/6sif5ECnaA==
X-Received: by 2002:a05:6a00:1506:b0:50a:754e:5d4c with SMTP id
 q6-20020a056a00150600b0050a754e5d4cmr26829801pfu.37.1651013915603; 
 Tue, 26 Apr 2022 15:58:35 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157]) by smtp.gmail.com with ESMTPSA id
 s10-20020a63e80a000000b0039e5c888996sm14032559pgh.86.2022.04.26.15.58.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Apr 2022 15:58:35 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, shr@fb.com, linux-nvme@lists.infradead.org,
 kernel-team@fb.com
Cc: joshi.k@samsung.com
In-Reply-To: <20220426182134.136504-1-shr@fb.com>
References: <20220426182134.136504-1-shr@fb.com>
Subject: Re: [PATCH v4 00/12] add large CQE support for io-uring
Message-Id: <165101391469.210637.11826028295180623775.b4-ty@kernel.dk>
Date: Tue, 26 Apr 2022 16:58:34 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220426_155837_519147_21F68C86 
X-CRM114-Status: GOOD (  10.51  )
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

On Tue, 26 Apr 2022 11:21:22 -0700, Stefan Roesch wrote:
> This adds the large CQE support for io-uring. Large CQE's are 16 bytes longer.
> To support the longer CQE's the allocation part is changed and when the CQE is
> accessed.
> 
> The allocation of the large CQE's is twice as big, so the allocation size is
> doubled. The ring size calculation needs to take this into account.
> 
> [...]

Applied, thanks!

[01/12] io_uring: support CQE32 in io_uring_cqe
        commit: 5c8bcc8e97123e3e68a6b1aa4c3eb6c5d5b9d174
[02/12] io_uring: store add. return values for CQE32
        commit: 04c3f8c8deae29e184d54b2cd815f39fd46c6b2e
[03/12] io_uring: change ring size calculation for CQE32
        commit: 9291ac41fda10ba7e80fc2147ca39a3b1d130ef9
[04/12] io_uring: add CQE32 setup processing
        commit: bc6bda624e953fcf42c6075fe35a219ce6df4bc4
[05/12] io_uring: add CQE32 completion processing
        commit: 22b76e8c5fd312701a1827b970230ee66aa24f69
[06/12] io_uring: modify io_get_cqe for CQE32
        commit: 771c7f07faf909b9993fd5e42581c8c82531fb58
[07/12] io_uring: flush completions for CQE32
        commit: b8e5029ed965c01066009bcb172c082b60ff436c
[08/12] io_uring: overflow processing for CQE32
        commit: 3ee1cd786a668ba2a6e8dfefacb8f29e1d995c12
[09/12] io_uring: add tracing for additional CQE32 fields
        commit: 225afd24978b55a771660fb4c6ad90cac75e7da8
[10/12] io_uring: support CQE32 in /proc info
        commit: 41a971975a3ae2b498b9f5ecad34c34280f0ffdc
[11/12] io_uring: enable CQE32
        commit: bb30aab40bcb6e9b80321615a2847a9491c95bf9
[12/12] io_uring: support CQE32 for nop operation
        commit: 0fde61fe729221b43d9c8374cb57e571f4fb2a16

Best regards,
-- 
Jens Axboe



