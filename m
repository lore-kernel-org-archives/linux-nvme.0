Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01AFBC4167B
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Dec 2023 19:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KModFUjISk9lPDaAIevH39bme1IjL/Al+Yhj9dt8OqE=; b=Au49+yxDx1PcGhU25Gs85J201J
	UI7H/mk+XOegw9BaJv4ydXWxWbbkzu1bWx38UX5XV9reL7F+QDwtdN+lyslFGOKajs2+O84Z4M4hf
	NXLCt4lob7Amre56Qs7+qbX5ktLVMNWHuTr3YD78DXe57TmNjulcYv8jZRgPOMai2jsIYh5VGgyaK
	G3qHPUuwVmUYiyaQCHKUV3E5Io23hmFZ469jrY4uedzcq+F8XJ+b+isOzTbT+GgeNwpZSHF9gpaoe
	6TjPBC7aX/2faM0GDp2I+bVekY81lO3hn4cZXfKI8vUXli1TXpVbPCpqYzZXnQVgqrGtYLxDbQRxu
	JEKbrKkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAECQ-005Ow0-0d;
	Mon, 04 Dec 2023 19:01:46 +0000
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAECL-005OvH-2U
	for linux-nvme@lists.infradead.org;
	Mon, 04 Dec 2023 19:01:44 +0000
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-35d7e22ccfeso267815ab.0
        for <linux-nvme@lists.infradead.org>; Mon, 04 Dec 2023 11:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701716501; x=1702321301; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KModFUjISk9lPDaAIevH39bme1IjL/Al+Yhj9dt8OqE=;
        b=bGiKh7yWogarmQVwBcuSBMTItwVJMA+/hM6L1wskuBzAleHTwluq93c88mzJ6maH3f
         bPq8osjT9vSmIvic/JsljLfrsAWPWfVxdjzus0AoZ+VLNpTzcbx06BDCuSpFe+g7v3+q
         r7bCGh2BbqCO14WlLKMVSWklAb8DeWNfM1gVC7j6p/tFmtN4jHUug43FJr8OmSz7Ykrb
         mnGb9tT5kKRlT7BZhoDHWIayFEmxY3b2puDYpujiH0cdYvX8TLJ9OJD7dxZoD70mnFG1
         5hxk+txMqv1OL7PLcjw4kGLTwgTSdT0eJYin9z2uTx0itK3pcFTezTJq7YkzzEQSB03B
         ftvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701716501; x=1702321301;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KModFUjISk9lPDaAIevH39bme1IjL/Al+Yhj9dt8OqE=;
        b=K1Ue/ndBmFlfqIaXHYy6hHjE4oOo1HHy2yEZ4tnrkGGt/isKM1g9S63vGNODU9DXhv
         9kCrMCXNhXdVorh5klRamZsWW4EccbyamyOU4g7k3ccLjdwINy9de6MkWfRtOKDwrZ5h
         Kg9fqAag5gyDKEDwQaOLc/nOtVikhttOKMl8HRXVqpb/mKVXrhGlyiYb/0g7q2Nt9mbb
         x0A8cuL3+0AIfK195LbFAo+48A4g05IgEcP+mp2vANTsZ6ZYUzP2P4xBN073f7VVjwf1
         2KA4x+lO5L6Y44awkXYT562ftzmHPV3/97Q/H2pb9MVRGxeqGsELfXfIk/sIsauk7rMu
         KuTw==
X-Gm-Message-State: AOJu0Yzxc6s/Ga7R8VBn3Bx5Va1Xbhj8dkutaA9Rh0ZLURzdxpG0Yvgv
	6tRu2446v37ZRFH0qRB+eMRCeg==
X-Google-Smtp-Source: AGHT+IEt2MMR+yxdjujJW2KLoxn/yZExW+eo2d1nv1y7A48SjFpuY0W3NiElWjAJPk/nnbhIfFVFZg==
X-Received: by 2002:a92:cdae:0:b0:35d:607a:d943 with SMTP id g14-20020a92cdae000000b0035d607ad943mr6603235ild.2.1701716500958;
        Mon, 04 Dec 2023 11:01:40 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id h4-20020a056e02052400b0035cb655bafesm70728ils.45.2023.12.04.11.01.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 11:01:40 -0800 (PST)
Message-ID: <9c1ee0ee-ccae-4013-83f4-92a2af7bdf42@kernel.dk>
Date: Mon, 4 Dec 2023 12:01:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iouring: one capable call per iouring instance
Content-Language: en-US
To: Jeff Moyer <jmoyer@redhat.com>, Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, io-uring@vger.kernel.org, hch@lst.de,
 sagi@grimberg.me, asml.silence@gmail.com, Keith Busch <kbusch@kernel.org>,
 linux-security-module@vger.kernel.org
References: <20231204175342.3418422-1-kbusch@meta.com>
 <x49zfypstdx.fsf@segfault.usersys.redhat.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <x49zfypstdx.fsf@segfault.usersys.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_110142_163185_6BF4083E 
X-CRM114-Status: UNSURE (   9.58  )
X-CRM114-Notice: Please train this message.
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

On 12/4/23 11:40 AM, Jeff Moyer wrote:
> Finally, as Jens mentioned, I would expect dropping priviliges to, you
> know, drop privileges.  I don't think a commit message is going to be
> enough documentation for a change like this.

Only thing I can think of here is to cache the state in
task->io_uring->something, and then ensure those are invalidated
whenever caps change. It's one of those cases where that's probably only
done once, but we do need to be able to catch it. Not convinced that
caching it at ring creation is sane enough, even if it is kind of like
opening devices before privs are dropped where you could not otherwise
re-open them later on.

-- 
Jens Axboe


