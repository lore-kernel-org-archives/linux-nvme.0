Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E8F6C32771
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 13:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M84FFzTMi9h6oICE7y6YgmOmaedFbJztaEjMgsP60GA=; b=dh/Cto67bJzb+liFX0gDOZ8Tz2
	M4gGyjnYNXe9OIS2TF+ejsaIgwUUnr0uG0BpfN6QLqLa2KkcBhxWEY3yH5CNi3/iDORtINf8W74MC
	Slh5ffZn+gz12aZe8FOSNF4xzwHGJ4WrI5sf15YFoQTwT7rGI/bkf0tqEd+LrwZBenomvWwiMXFTS
	4tAigfXQ0F8eHecu6d2lWOP7DzE/ZupPJ5kVpL79EGkXWNmS7X+oKcUdwz34LAHUMixd9X2ISuggI
	q/QdxeqInE5smydRs85Jiy9+JEP6+fIxhPjRlmP9RHuQcdaaXpIsZrlKm1KTdaf8o8zSEJrHcnVvf
	qmrhdu+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odX2l-00GTBH-9i; Wed, 28 Sep 2022 13:24:07 +0000
Received: from mail-vs1-xe2d.google.com ([2607:f8b0:4864:20::e2d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odX2j-00GT9i-1F
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 13:24:06 +0000
Received: by mail-vs1-xe2d.google.com with SMTP id 63so12685384vse.2
        for <linux-nvme@lists.infradead.org>; Wed, 28 Sep 2022 06:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=M84FFzTMi9h6oICE7y6YgmOmaedFbJztaEjMgsP60GA=;
        b=UQq3nN3gztbrniSqexDrn4v7PkItW7CpPH/KcfuYAUD26dpvM6A+Z1ppytRi9QJU0h
         SibNAUP3E5PUR0VD6A8+2jFi4423oDZEAOFCtrSDMAef7fvfR/dQUGQqgwK97vv69/+S
         03CeucNoQ6I2JlzDRTVoX5DD2n3plcFbnIY9YYBTOSVfsXS3eqI0t+ZZffTWaMrrBOwE
         rIlnK2bsPqtsj+/cBEJtft7eEaYssu86yFAeBDzcSKKK04SPYynDvy68ynAhFS8TjSxW
         XXmEx8dRxbnSyxtAdqp3PSrlsQtT3pQDiln4s3FZY8k5Wfx0CLF8Qo5A6kezx6P6Wba1
         NmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=M84FFzTMi9h6oICE7y6YgmOmaedFbJztaEjMgsP60GA=;
        b=reFgikREXWjvX5mqdAYDV/yimoBn/zFjif61k/hGFGouSee9mKzW8Xqxqz4WPjJhgC
         otS2q9CovsI8+5DC3Xxp/IrpFuEKHho6sBPyt46QWOt6B2je51bxWgv25B5EuvPh8wgk
         v/w40s55qBMPCMaJndtaoBkkAIojU6vN7RCbxf+6UrkDedhbypDTwW2AW5w2U7TZ9QHT
         CvKlYgDDdUIeDUThWQO/fndc2uTdc+gPPs9+Q5prBGf44/sGVjqr4E22AONSs6lzqZPk
         xlW/wGAuz7o/QIFQaBTGGecVxdlsPWmAn5VXCQHNR2j4SMkqn8DMT1xbC43zCcsc8DIx
         Qwow==
X-Gm-Message-State: ACrzQf2ZTwZoRXzpx6J+RKlthPikGfo930dhFhNefsdk56hlQXi1M7AA
	+qH1SlgVbjVv+qwhTIj32KfUXU+6m3sUREOhDRLb8kU1zA==
X-Google-Smtp-Source: AMsMyM6/5w8wyMAkWnRZyW1kzS8Or+a2Mjp2kGlSOJEyaCX+PfkjFmwnO3J6PHWhJ61G1pDVoEEBVAv1tBoX1pc+Ov4=
X-Received: by 2002:a05:6102:21db:b0:398:28b9:5c0c with SMTP id
 r27-20020a05610221db00b0039828b95c0cmr13561532vsg.56.1664371442093; Wed, 28
 Sep 2022 06:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220927014420.71141-1-axboe@kernel.dk>
In-Reply-To: <20220927014420.71141-1-axboe@kernel.dk>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Wed, 28 Sep 2022 18:53:25 +0530
Message-ID: <CACzX3AumYMDVPwvRYpMi6vvcPTzR0W0bUT1-545HvArpH+7Uwg@mail.gmail.com>
Subject: Re: [PATCHSET v2 0/5] Enable alloc caching and batched freeing for passthrough
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_062405_122897_6AD7A668 
X-CRM114-Status: GOOD (  15.88  )
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

On Tue, Sep 27, 2022 at 7:14 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> Hi,
>
> The passthrough IO path currently doesn't do any request allocation
> batching like we do for normal IO. Wire this up through the usual
> blk_mq_alloc_request() allocation helper.
>
> Similarly, we don't currently supported batched completions for
> passthrough IO. Allow the request->end_io() handler to return back
> whether or not it retains ownership of the request. By default all
> handlers are converted to returning RQ_END_IO_NONE, which retains
> the existing behavior. But with that in place, we can tweak the
> nvme uring_cmd end_io handler to pass back ownership, and hence enable
> completion batching for passthrough requests as well.
>
> This is good for a 10% improvement for passthrough performance. For
> a non-drive limited test case, passthrough IO is now more efficient
> than the regular bdev O_DIRECT path.
>
> Changes since v1:
> - Remove spurious semicolon
> - Cleanup struct nvme_uring_cmd_pdu handling
>
> --
> Jens Axboe
>
>
I see an improvement of ~12% (2.34 to 2.63 MIOPS) with polling enabled and
an improvement of ~4% (1.84 to 1.92 MIOPS) with polling disabled using the
t/io_uring utility (in fio) in my setup with this patch series!

--
Anuj Gupta

