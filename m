Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78723C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Jul 2022 15:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jTqfA6srykFLYf4Fjk4hYRBDzM8KBinziURX/lp7iC4=; b=1IKh87eXAgV76HtjIyady3WiBY
	JdHVLwz0xn4c9b9VBuLEfps4NY7yR7RPaBf9Wn3Bk8vgXYKvYW0NIBkHVjGwkUhp0lGKFASO5iFWS
	Sci9TkNLQDKZTHEll0C4y8KwaYUE+NAoR67bInbiFRzq8hP6wS6zgmlaYAncydRo1v8FDjsgOUClw
	GcDQpngywWM7IK9O3RiW0ow8yE0LSh6f+UGKIhFczDkJELtqy0fPtEYfMS1Cy64ggESsnCuX2ezwr
	Wfli3GxQFfrvKMfBlTyfq1hdpKUBQCq7RJLJ4HcvjrhyoZi/u0anrUh7A0+NMnjtRpfJK1OvQTNgK
	x7/+13FA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEBI9-007LD5-VQ; Wed, 20 Jul 2022 15:07:13 +0000
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEBI7-007LBD-Cs
	for linux-nvme@lists.infradead.org; Wed, 20 Jul 2022 15:07:12 +0000
Received: by mail-wr1-x431.google.com with SMTP id z13so6972524wro.13
        for <linux-nvme@lists.infradead.org>; Wed, 20 Jul 2022 08:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jTqfA6srykFLYf4Fjk4hYRBDzM8KBinziURX/lp7iC4=;
        b=73L1dpOo8OCJSAwaeAEqeJ79WIrhe6F2SuOiyRR6pIV7C8PCjo6CI73E4F9kboOKr8
         eBuLuyR90Arl4co8CMy/sdbL0vqDMRWTKOlkwEK8sJDJd48wX5WT9C54DcI4GMGmNSGr
         I7/RFhu88x1cTNzbLP4DXsCYGcGZE29fqkzjM3PvGr51B6KYP9Aa665Msn2B701ONvgA
         /5LgSqIZKZ+otQ6EePf36h1jhhIvnlHDB88LmL6N0Onul01WAiEBK0k1fLpKpTTSQQIl
         F0pnrSw5HnSRwytlBtw1eNUIW/ZEf9WcvtMkOY0913fEX7A7r71GNk/UgPgZ+g+iTk/z
         rBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jTqfA6srykFLYf4Fjk4hYRBDzM8KBinziURX/lp7iC4=;
        b=rQq1N6dyqAhCTUvyS255moKFlh9iOqoYyUnTMXnGVzJNMuR3NCMW0bi3lmuX7I5bmS
         jetkP67cOVIpudrVzEvEfduK9RsQhw1YX50NBN3wG7NCsHDlRKkacnHyJDmQ5dJvsy5h
         zcYNcS40oKLP5SgHVq8TlbIyDKD1CbEoZr/gSLQ28LENURWxHV7VkJw92e9OdsacMLan
         tIOPuNnV5hMk9xuZhaPKqIVtLXLyH2M/YuMhOZeBRdIw7XzVYGEygoOJySPuOR3ni/io
         AoAtiLNxTzEV90XeCj2JqDFvQcThReVPLy60Tbfag3R8zQJRz+MVMC20JhHozj36iqdL
         Jrug==
X-Gm-Message-State: AJIora++u/mpceABOrE12y4AlYr4SKwH76sNgF7+cjEXsAbzx//e80Jb
	Nr5IIHgajLaXkNYd3iCvXv/2TWqUJOyQMxoEy6gK
X-Google-Smtp-Source: AGRyM1tTO3AXCPrAOBwfVD7lxLpRl/Qu85ZbXMxFT4AVQj9Pz/D2gv4wdnRdcBXnr44Xztt45Wa3aD3BXAzEN2DEOaA=
X-Received: by 2002:adf:fb86:0:b0:21e:3cc8:a917 with SMTP id
 a6-20020adffb86000000b0021e3cc8a917mr6548771wrr.538.1658329628941; Wed, 20
 Jul 2022 08:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220715191622.2310436-1-mcgrof@kernel.org> <a56d191e-a3a3-76b9-6ca3-782803d2600c@kernel.dk>
 <CAHC9VhRzm=1mh9bZKEdLSG0vet=amQDVpuZk+1shMuXYLV_qoQ@mail.gmail.com>
 <CAHC9VhQm3CBUkVz2OHBmuRi1VDNxvfWs-tFT2UO9LKMbO7YJMg@mail.gmail.com> <e139a585-ece7-7813-7c90-9ffc3a924a87@schaufler-ca.com>
In-Reply-To: <e139a585-ece7-7813-7c90-9ffc3a924a87@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 20 Jul 2022 11:06:57 -0400
Message-ID: <CAHC9VhQeScpuhFU=E+Q7Ewyd0Ta-VLA+45zQF9-g-Ae+CN1fgA@mail.gmail.com>
Subject: Re: [PATCH v2] lsm,io_uring: add LSM hooks for the new uring_cmd file op
To: Casey Schaufler <casey@schaufler-ca.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>
Cc: joshi.k@samsung.com, linux-security-module@vger.kernel.org, 
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-block@vger.kernel.org, a.manzanares@samsung.com, javier@javigon.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220720_080711_461358_4104B65B 
X-CRM114-Status: GOOD (  27.96  )
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

I just had a thought, would the io_uring folks be opposed if I
submitted a patch to add a file_operations:uring_cmd for the null
character device?  A simple uring_cmd noop seems to be in keeping with
the null device, and it would make testing the io_uring CMD
functionality much easier as it would not rely on a specific device.

I think something like this would be in keeping with the null driver:

  static int uring_cmd_null(struct io_uring_cmd *ioucmd, unsigned int
issue_flags)
  {
    return 0;
  }

Thoughts?

-- 
paul-moore.com

