Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B67BCC433FE
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Mar 2022 19:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iYzvICBpRK+Z1lkcKMGBj85WSLhaFfQKUQR/1tbsVi0=; b=THkp3lFriuAvZ2BhVrzV9Kw2xC
	ZXXkoldPm4pgkKbSqqX1jyHE7/zWsYB6Eh3v9W43t/lhxT36sJFuWBno1vIY6c3Q9/PbZvu4MCaJt
	nh0yEQjaFjiPNAcmDjldOvKXh6ONg8WbIEaiAAwzY31C3ZIa8d5vVzm+cV5u86DsE5wdpZxIgXPWK
	9exRyFPEwrr9wzBXKBqMnQ/CAh8hwCyPX1Fhy6kNWl1JfMxWhzQ1Jka4csvP/Srn11ro8UzpNSLGI
	8zFRxJ397VZ2YdhzUpPXlV1wL/KvrEcOHU6rZqm9XLzV/BZ7cyVTRjFfS3zL2kJoBxSq6R9N16xsP
	T7fpumxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRJMu-001PJB-91; Mon, 07 Mar 2022 19:50:08 +0000
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRJMq-001PHI-Gm
 for linux-nvme@lists.infradead.org; Mon, 07 Mar 2022 19:50:06 +0000
Received: by mail-io1-xd2a.google.com with SMTP id b16so4045346ioz.3
 for <linux-nvme@lists.infradead.org>; Mon, 07 Mar 2022 11:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:in-reply-to:references:subject:message-id:date
 :mime-version:content-transfer-encoding;
 bh=iYzvICBpRK+Z1lkcKMGBj85WSLhaFfQKUQR/1tbsVi0=;
 b=D9EOkrsYV7Xsyxf/6CdXzNXALautOeZBiGjeX/I4hjBM8EynsqoHdUlfNoDp+n97Cx
 ak3LSSmjyVYTrUo3k8wUJ/vzRpIHWWk2A1GZUSlCpFOfDx8AVtsHh7/RvdGmbKIXfOBC
 YVz8ptxroGcIhO1e7z2glBGmsSfeQ1TB8MJIyJfzlEnsrLK68ilH9PTwj96YEXzZAGUU
 tXTF1Wvp5ogod/B+rQzAQLizXotw0U4w14DYF56LdpsZt8PsTNM1yIYfEEx+43rDvjJU
 HF9j6lUn/42Oauqt03YtKhF3B1Gfi30Qoe60vsMifkKbkyB5LAaFvaavy4m5SElM4DZf
 RjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
 :message-id:date:mime-version:content-transfer-encoding;
 bh=iYzvICBpRK+Z1lkcKMGBj85WSLhaFfQKUQR/1tbsVi0=;
 b=59diCEQEqz1k9L4KHKrWQ2oxYJzlgTF8imybHbsivGFiJR0FPmX8YOJIO+qzA5x2Lj
 q1rbZpPat7s2HC60FXZWOPwdG4+iOQXUmbjETSW0OK4neJFaPFqihq84DRaJKgMGkNBA
 dcTVvy+GfmHQtFv++cq7apieJA5IcvwWZeV2YZ2Oep4xWIihcz9AplmjLW53lQ/4xe4n
 wScGxJN0rMBnBgckXisLB3ZQZnvjISwnwHv4al1VspBpbV2EUYlAz16/UV3vt+f55/BO
 yjy6ktAHbh8xEcJTVQAlB4Eg+a5H4NecEMjUsuOkMcM3l12s3KYk2e0gn09mRLP12xWl
 8NXQ==
X-Gm-Message-State: AOAM5319wfTLbqpePgueZuZabrD0VqtZK5zBMnU6PO8qvO7hYTnBCd7b
 yX2r7L7R9NDQmBGwoSc669J5vQ==
X-Google-Smtp-Source: ABdhPJybq+mzRA9wXefyDpbSCzRp9JiXKbIPz1Fc1EWfxA+XSQ7k68avZwGrMkTiAo8s8+pRBO+9cg==
X-Received: by 2002:a02:5bc2:0:b0:317:b050:cba with SMTP id
 g185-20020a025bc2000000b00317b0500cbamr8910432jab.301.1646682602578; 
 Mon, 07 Mar 2022 11:50:02 -0800 (PST)
Received: from [127.0.1.1] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id
 s13-20020a056e0218cd00b002c5f74a97d6sm11807418ilu.39.2022.03.07.11.50.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Mar 2022 11:50:02 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, linux-crypto@vger.kernel.org,
 linux-block@vger.kernel.org
Cc: martin.petersen@oracle.com, hch@lst.de
In-Reply-To: <20220303201312.3255347-1-kbusch@kernel.org>
References: <20220303201312.3255347-1-kbusch@kernel.org>
Subject: Re: [PATCHv4 0/8] 64-bit data integrity field support
Message-Id: <164668260179.56567.6298714072189307417.b4-ty@kernel.dk>
Date: Mon, 07 Mar 2022 12:50:01 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220307_115004_632505_2773291E 
X-CRM114-Status: UNSURE (   8.46  )
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

On Thu, 3 Mar 2022 12:13:04 -0800, Keith Busch wrote:
> The NVM Express protocol added enhancements to the data integrity field
> formats beyond the T10 defined protection information. A detailed
> description of the new formats can be found in the NVMe's NVM Command
> Set Specification, section 5.2, available at:
> 
>   https://nvmexpress.org/wp-content/uploads/NVM-Command-Set-Specification-1.0b-2021.12.18-Ratified.pdf
> 
> [...]

Applied, thanks!

[1/8] block: support pi with extended metadata
      commit: c340b990d58c856c1636e0c10abb9e4351ad852a
[2/8] nvme: allow integrity on extended metadata formats
      commit: 84b735429f5fe6f57fc0b3fff3932dce1471e668
[3/8] asm-generic: introduce be48 unaligned accessors
      commit: c2ea5fcf53d5f21e6aff0de11d55bc202822df6a
[4/8] linux/kernel: introduce lower_48_bits function
      commit: 7ee8809df990d1de379002973baee1681e8d7dd3
[5/8] lib: add rocksoft model crc64
      commit: cbc0a40e17da361a2ada8d669413ccfbd2028f2d
[6/8] crypto: add rocksoft 64b crc guard tag framework
      commit: f3813f4b287e480b1fcd62ca798d8556644b8278
[7/8] block: add pi for extended integrity
      commit: a7d4383f17e10f338ea757a849f02298790d24fb
[8/8] nvme: add support for enhanced metadata
      commit: 4020aad85c6785ddac8d51f345ff9e3328ce773a

Best regards,
-- 
Jens Axboe



