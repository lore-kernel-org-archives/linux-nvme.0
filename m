Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFDB6C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Feb 2022 13:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qVzYl3RlPID/1J9EWvCP0Ca8Qcit/GaDc2G90eYSD+Y=; b=YY5ylUF8QEqZGPkYAm7rpJi7+G
	B9WgFpI6/4y55pYNF+0VScbB/I6or70pmiG+viRYgWrJml4ZSHCHAzeJd9ge5TvPtyv4kENxCCEfP
	fgVTspR6zKvq4gDXciiIV+6UmSQp/fyO/NRMGGvu1bljoVlEncgSh5LcX1lxVP7glzWdeiWzJMuJ9
	ju/g184nUvJW0pvywc0UCcVG/aq9zx8afhT+OGqA0a77Dq68jEg0L+6YHwBsfDFvnych6PbLq8lul
	8Sznv/o5I0l9vz1Bys2JEAuokRGtbGgsCzEBY+T0cPPPZYJSDEnZFFImzRVwcD7GncppYcgzLlPZh
	H/e127qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nI9wk-003zQr-Kh; Thu, 10 Feb 2022 13:57:18 +0000
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nI9wh-003zOk-3s
 for linux-nvme@lists.infradead.org; Thu, 10 Feb 2022 13:57:17 +0000
Received: by mail-pf1-x431.google.com with SMTP id d187so10339468pfa.10
 for <linux-nvme@lists.infradead.org>; Thu, 10 Feb 2022 05:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qVzYl3RlPID/1J9EWvCP0Ca8Qcit/GaDc2G90eYSD+Y=;
 b=LKl4z5JRyaO+PUQiRs9JHd7OdFbbp52Lv8apqasXRv4aStNfB+l4IFQQVUlXc28apu
 uh9mhThuVQTf3LXVfbdwp3kjdP2leon4kcPp1St8klcjimLjOwz14ITEGliL/dygvA+v
 KrhDCsvRuDYMHL765CS/jHpsU/FCvpZiRQidxahdxxqdY4sWTSLUzB0RvTRcLTjkEJqD
 TGs4vUkfS8JHQwp1/wNIR0enaaLEKxTSUmqYYAUJmQrl3AU6bC6wZjdcxDYW7+r2FC6A
 66e9wgUCfNaHEYIXOyXBuV0oj8SpS3CZzh7iUyIFPaK7uA2zVr9iYVnRzqnjvkk+l1tw
 nY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qVzYl3RlPID/1J9EWvCP0Ca8Qcit/GaDc2G90eYSD+Y=;
 b=m10fJ4NFR8G1+2myLEhlvJZz5G+8fZ/B1z2AWg9BZfLerYWAHPe3gBEmEP+CvWfegq
 QCo+q85nBKcWor3Xt4agc4tNj4w0lWpObxEIC1VbWKj8MH9URzE+iFiad8QT4/t+979U
 FaulxX9xAA0xHx5ZBeAWarIIxKCKhbKwX2sZerPd6S4SyMb4xD3GCA5SJpTG9YHb3GzD
 8aw7zDuoUGlBYGoTA10Xeoh2IQemsy+JHguddOG6P71Th34Th0yOltB5aflQnE5v015z
 TMSM40kxKvNVsyjrrXMwDXoNc0YZx7M99PJBfbZezS/Fq6neloBCeBnb5/7QcsgN02UX
 /+mA==
X-Gm-Message-State: AOAM530lVWu+8wdUwcwDRa/SCkiKzGgKtawjb4jUmyRNOWwZ2y6CmXcu
 QGfaglLQgn0Ks6sGBNVXyo4FUaR4TvQGbA==
X-Google-Smtp-Source: ABdhPJw1FKxiTUNd0OpgPlNdACQm6dz2Y0aIO/DgWrV1QOf113ghOARQTDstU8K9fNFH7D7b1ObIsw==
X-Received: by 2002:a65:4c43:: with SMTP id l3mr6228379pgr.494.1644501432971; 
 Thu, 10 Feb 2022 05:57:12 -0800 (PST)
Received: from [192.168.1.116] ([198.8.77.157])
 by smtp.gmail.com with ESMTPSA id o9sm20902431pfw.86.2022.02.10.05.57.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Feb 2022 05:57:12 -0800 (PST)
Subject: Re: [GIT PULL] nvme fixes for Linux 5.17
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <YgTB0csAbKyI5WvN@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d165d411-4499-12aa-fb59-05ff1e2faaa2@kernel.dk>
Date: Thu, 10 Feb 2022 06:57:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YgTB0csAbKyI5WvN@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220210_055715_184654_D8635AAD 
X-CRM114-Status: GOOD (  10.39  )
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

On 2/10/22 12:42 AM, Christoph Hellwig wrote:
> The following changes since commit b13e0c71856817fca67159b11abac350e41289f5:
> 
>   block: bio-integrity: Advance seed correctly for larger interval sizes (2022-02-03 21:09:24 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.17-2022-02-10

Pulled, thanks.

-- 
Jens Axboe


