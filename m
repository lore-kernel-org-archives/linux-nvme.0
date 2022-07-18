Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 396C7C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jul 2022 21:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h9woUmKziOSYMEOzduzyD/qFH0+bR5EPCY6q/eggFXo=; b=zjnecVVCA7nzkSq7F4AxLBY9Z3
	iUB/+AZeqcryI1IAXBmhD7tLwXWXxIbpagQm3mDn54pQtEQ3DAS0rAHW3Or0aQHO2qf+A5+NtySs9
	k7oJhm9lCGPNfmPsR5vMR57stMHe4lhbaZu0uOhKM/QkTKcNS17Rz1YMrbJFs0KyfkTZ1L4L40uE6
	sS6VddfEy926Lbw5r1+IANy15nZdQ31LRTYyGq6BVnM02QMu23PKqbEpTDWD2yoASY912/y3p4tuF
	j9lDA0KWpFvmoz8yoNNQpgpZx9K1/zNOlPvYA3t7Yx7tq0/EnF9AzCYAqILElq4iD/k9IYmkFTSS3
	aqNbU1NQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDYf7-001jSY-6P; Mon, 18 Jul 2022 21:52:21 +0000
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDYf3-001jOC-SU
	for linux-nvme@lists.infradead.org; Mon, 18 Jul 2022 21:52:20 +0000
Received: by mail-wr1-x42c.google.com with SMTP id bu1so18938312wrb.9
        for <linux-nvme@lists.infradead.org>; Mon, 18 Jul 2022 14:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h9woUmKziOSYMEOzduzyD/qFH0+bR5EPCY6q/eggFXo=;
        b=EypuYtIoFxGWldjnCkEvixi/5nqZRcKxgu9gksofTF/7OzAHPa7nULrCiL7jAbKYAr
         Xgdrjgcisf4pc+AY4AnLrxTS2Ks5w0h3XMZSfZzqnjGLdZ5u2ewA/8Ksj1WmrTomqh47
         xp1XmGJqxGVxdfZNGx+vxw1Z6S95GVwzbMFA6UH8WNWYgmej1SP13Uce7EpORBhHYPxU
         2TwP0+gH5O3aQVh2vPRuSTrr8Lrr35X3YKdQ8RG7USZr0p6fHDzQAZVvqbT04hJZessh
         eNFHnt8M/P8EabU18CILE0P8s5dVT/bN3OzyhgwNhOa+BCS9G79k9OLCF0/rmzqnOSCT
         UC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h9woUmKziOSYMEOzduzyD/qFH0+bR5EPCY6q/eggFXo=;
        b=WTuHtH1N6f7DgDXPVoOCjVA6cYuC6BHmHKUElpbD/ND4m812HRbeV2b3ddoZNCfPBm
         fcIEWDEU9Vf2//+fMXOGmOcbY2x7x5bf2zMzCjMZUEE9C7q5pM3yahsOY4f54iXDORy1
         z2lbHcQQ0skU04xR4/1z6dFEZujkZVxUTBTcVbYel09vU/xedwX4H2ash06lFGqNVxUw
         3pMxWMDFm8ULfuzX3C8zHw04CUy0uvastbeSfG9zBrUPplumyc+uZf6HdKJQFFDPh3sC
         HUQy8cc628AyAe4WH48HzN3jh31LmBzRdhpHYG8FbqPW8mmuQrobygY6Rqo25BDMOca9
         1CKA==
X-Gm-Message-State: AJIora+gBr1JqHa1bFqF3kWcToJ8MF577Ifkrf2kvYZHLeHysSekjnWs
	6witjzuNocbFQRCTxigIWsF7ctKiOBmCmVLnikpY
X-Google-Smtp-Source: AGRyM1sK8QBEOZVKtlfTmdajnsX69FmXFPbExPnoOWj0fyUUVKvHCszqdWqig5PeaOgS5K5CwqzofilUO6EDkOahZ0g=
X-Received: by 2002:a5d:64a3:0:b0:21d:adaa:ce4c with SMTP id
 m3-20020a5d64a3000000b0021dadaace4cmr24233512wrp.161.1658181133286; Mon, 18
 Jul 2022 14:52:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220715191622.2310436-1-mcgrof@kernel.org> <a56d191e-a3a3-76b9-6ca3-782803d2600c@kernel.dk>
 <CAHC9VhRzm=1mh9bZKEdLSG0vet=amQDVpuZk+1shMuXYLV_qoQ@mail.gmail.com>
 <CAHC9VhQm3CBUkVz2OHBmuRi1VDNxvfWs-tFT2UO9LKMbO7YJMg@mail.gmail.com> <e139a585-ece7-7813-7c90-9ffc3a924a87@schaufler-ca.com>
In-Reply-To: <e139a585-ece7-7813-7c90-9ffc3a924a87@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 18 Jul 2022 17:52:01 -0400
Message-ID: <CAHC9VhRzjLFg9B4wL7GvW3WY-qM4BoqqcpyS0gW8MUbQ9BD2mg@mail.gmail.com>
Subject: Re: [PATCH v2] lsm,io_uring: add LSM hooks for the new uring_cmd file op
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Jens Axboe <axboe@kernel.dk>, Luis Chamberlain <mcgrof@kernel.org>, joshi.k@samsung.com, 
	linux-security-module@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
	a.manzanares@samsung.com, javier@javigon.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220718_145218_141083_7B672ADB 
X-CRM114-Status: GOOD (  26.32  )
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

On Mon, Jul 18, 2022 at 1:12 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 7/15/2022 8:33 PM, Paul Moore wrote:
> > On Fri, Jul 15, 2022 at 3:52 PM Paul Moore <paul@paul-moore.com> wrote:
> >> On Fri, Jul 15, 2022 at 3:28 PM Jens Axboe <axboe@kernel.dk> wrote:
> >>> On 7/15/22 1:16 PM, Luis Chamberlain wrote:
> >>>> io-uring cmd support was added through ee692a21e9bf ("fs,io_uring:
> >>>> add infrastructure for uring-cmd"), this extended the struct
> >>>> file_operations to allow a new command which each subsystem can use
> >>>> to enable command passthrough. Add an LSM specific for the command
> >>>> passthrough which enables LSMs to inspect the command details.
> >>>>
> >>>> This was discussed long ago without no clear pointer for something
> >>>> conclusive, so this enables LSMs to at least reject this new file
> >>>> operation.
> >>> From an io_uring perspective, this looks fine to me. It may be easier if
> >>> I take this through my tree due to the moving of the files, or the
> >>> security side can do it but it'd have to then wait for merge window (and
> >>> post io_uring branch merge) to do so. Just let me know. If done outside
> >>> of my tree, feel free to add:
> > I forgot to add this earlier ... let's see how the timing goes, I
> > don't expect the LSM/Smack/SELinux bits to be ready and tested before
> > the merge window opens so I'm guessing this will not be an issue in
> > practice, but thanks for the heads-up.
>
> I have a patch that may or may not be appropriate. I ran the
> liburing tests without (additional) failures, but it looks like
> there isn't anything there testing uring_cmd. Do you have a
> test tucked away somewhere I can use?

All I have at the moment is the audit-testsuite io_uring test (link
below) which is lacking a test for the io_uring CMD command.  I plan
on adding that, but I haven't finished the SELinux patch yet.

* https://github.com/linux-audit/audit-testsuite/tree/main/tests/io_uring

(Side note: there will be a SELinux io_uring test similar to the
audit-testsuite test, but that effort was delayed due to lack of
io_uring support in the Fedora policy for a while; it's working now,
but the SELinux/SCTP issues have been stealing my time lately.)

-- 
paul-moore.com

