Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE8AC61DA3
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Feb 2023 18:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mCAjmH+y9RfcSzdsqktWB2qihaToifWXvEEckSYFn1U=; b=YDWOvQIa+RMB/VSdOdMp+1IBeH
	4y6SZM1ld6VuhNjgj7EzgJASx/6gAplMyQJpC3SVHAq8HE3VeH3VAdRPXWSmJLGkm6eZSzh94Fmzg
	nu3/q+kINyabRZPJ4olSC6uoE5eZflistBZkt+FIhjwvuuDX/R5omjNOxKUUJGwbRjNq4g/tFHCnk
	PPXDQHZ9tcVZ96WSncRE2yBYPBpvMBQnMLepyha+EASNKN6+REKt1N4Qr1FzlAs0B+gmAY0ZKfgZ1
	Xz+cliWOi02fVvVfLBcBjBnjjd0m6TD5YT9ztLpkZhgcxiUAQnZNbrAZ4Bm6ecUIZ2TU5d/wIEn3r
	PwEiQlMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pUX0e-009HFo-Cm; Tue, 21 Feb 2023 18:05:00 +0000
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pUX0b-009HEp-T7
	for linux-nvme@lists.infradead.org; Tue, 21 Feb 2023 18:04:59 +0000
Received: by mail-pj1-x1034.google.com with SMTP id pt11so6589688pjb.1
        for <linux-nvme@lists.infradead.org>; Tue, 21 Feb 2023 10:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCAjmH+y9RfcSzdsqktWB2qihaToifWXvEEckSYFn1U=;
        b=cU+qS1cAwy/+6/YsKudl6aFY83WeYfdNkUxRNjXboI53GB2RXfA7NKjWuZmgDz/d1C
         buCc5HCXS4h4PTgFk2RuCicEaCcw7TpdEUAJlIJGR28Xn3xb8YwZys+ge8j3sGGtCWia
         WXtYVfAP31VrjczgWUpI4/RmcX3GdDwJEurlXz1GycoBMnbNEw/RIUtq8NWI9/wXA0FF
         blZexmwat0G0MfAdAljh5/hHVMAP9vSb3/kEIxAmbX9/QC6WBkKDGj76yMaAzkQgQjDc
         HnG0mYMtVCLi9h2zAZiJki93BNA8/17mG2xQ9STIsAPVMzwfTHJyai1ySZ1spHa2Vjhj
         uFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mCAjmH+y9RfcSzdsqktWB2qihaToifWXvEEckSYFn1U=;
        b=QxMKI4RIvA3VtbViE2YjANE4gi1eyIdX6trkhCOXsiwUY1GXVqq05byxZGBzf/RdOi
         RWqnE5dDMy2IfzDKiYGAIFpySs+CQVA2rxNGxqggqAHRS/tSyl3YkC2sD3pHlC3PFd8c
         9m9hAiuAp6nHcw6KY9DMMgNugeBH7XSq5Uyv6+bbKVeooVU8UtfQ+Zyi5KjsSM7HZlFj
         28Opq+iimItdBQo0xMN5HKhSZzX8cJeZOfeMFteZoGpGHc5hNXXCw5V4trUz+5BHAQPT
         fau4qFWnjoDkzvkGFRHivNyZhOwUgqz8Um1hg0ktzO3QeC4j6UfrHYJ9SFI9j+MWZhI9
         zTMQ==
X-Gm-Message-State: AO0yUKW+1JB24LHT+/2m5MpsxIPcrrd5XU07BmGhIigMoFNzXCVjJCWp
	Txw+V1bW4XuPCD7DgrXX7vGUbEieqaycHtvRRH8=
X-Google-Smtp-Source: AK7set+DPvt4gc1+MMSfea4jAKfm3GuiLqy6YIIuhZXw3q9nS6EVev/33IgWsrSeIZ4R0sI9pU5NSkPSQXtwRvPcVUs=
X-Received: by 2002:a17:902:f783:b0:198:f13d:571b with SMTP id
 q3-20020a170902f78300b00198f13d571bmr730679pln.1.1677002697193; Tue, 21 Feb
 2023 10:04:57 -0800 (PST)
MIME-Version: 1.0
References: <52f9afe2-f621-77d8-9d10-449d539e901d@leemhuis.info>
 <Y+5JdR02tlzD/TFS@kbusch-mbp> <151a00d9-0ea2-eadb-72b4-fa8a2dd41bfc@kernel.dk>
 <CACosJgyjgh+cz6nTrKWVQ9P8Z9_wJGWGQBOjae2MoJrZQ3RmTQ@mail.gmail.com> <Y/T5L1ZIssWY5wQZ@kbusch-mbp>
In-Reply-To: <Y/T5L1ZIssWY5wQZ@kbusch-mbp>
From: Michal Berger <michallinuxstuff@gmail.com>
Date: Tue, 21 Feb 2023 19:04:46 +0100
Message-ID: <CACosJgxLbU95SuPo+oPCT-0EyG4p_CpgLAh+WafQxCN0Yn0Lhw@mail.gmail.com>
Subject: Re: [regression] Bug 217037 - cmb attributes missing from the nvme
 class under sysfs
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, Jens Axboe <axboe@fb.com>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230221_100457_958551_4821F03B 
X-CRM114-Status: GOOD (  15.60  )
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

Oh, that's quite alright -  I asked just to make sure I didn't miss
anything. :) With that said, I just spun up the build (based on
89f5349e) with your commit inside and I can confirm the issue is fixed
on my end (all the attributes are back where they should be).
Appreciate the help!

Regards,
Michal


wt., 21 lut 2023 o 18:02 Keith Busch <kbusch@kernel.org> napisa=C5=82(a):
>
> On Sun, Feb 19, 2023 at 11:54:37PM +0100, Michal Berger wrote:
> > Have there been any patches submitted for testing? I don't see any as
> > part of this thread nor at the bugzilla where the issue was initially
> > reported. :)
>
> I'm sorry, I didn't see your email in the bugzilla. With time running out=
, I
> just posted the patch for upstream with a link to your original report, b=
ut I
> apologize for not getting you CC'ed on it. The fix is included in the 6.2
> release.

